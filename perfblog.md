## Introduction
This is the second in a series of blogs about my SPARKNaCl cryptographic library. The project's [GitHub repo](https://github.com/rod-chapman/SPARKNaCl/) provides some background information about the library, while [the first blog entry](https://blog.adacore.com/proving-constant-time-crypto-code-in-sparknacl) went into the details of transforming a tricky constant-time algorithm from C into SPARK and its proof.

If you're not familiar with SPARKNaCl, then it might be worth reviewing one or both of those before pressing on here.

This blog goes into the details of both measuring and improving the runtime performance of SPARKNaCl on a real "bare metal" embedded target, and comparing results with those for the original "TweetNaCl" C implementation.

Warning: this blog is long and rather technical, but please press on.

TL;DR version: formal is fast.

## Motivation
Having worked with SPARK for many years, I have often encountered a belief that "formal is slow". While "type safe" languages do have a reputation for not running as fast as their "type unsafe" cousins, is that really true for SPARK which offers *static* type safety?

In some applications, both correctness and performance are certainly critical, and a cryptographic library like NaCl is a fine example. Some subtle correctness properties are required, but performance is also fundamental for usability and to minimize power consumption in small battery-powered devices.

So...can we have our proverbial cake and eat it? Having established an automated proof of type-safety for SPARKNaCl, how does it actually stack up against the TweetNaCl C implementation in terms of running time?

SPARK actually has some properties in its favour. Notably:
* SPARK offers static type safety, so programs can be compiled and run with no runtime type checking at all.
* There are no aliasing and no function side-effects in SPARK.
* There are no undefined (aka "erroneous") behaviours in SPARK, and no dependence on unspecified behaviour.

These points suggest that SPARK should be highly amenable to optimization within a compiler.

On the other hand, SPARKNaCl uses some language features that might come with some performance penalty. For example, SPARKNaCl uses a functional programming style where possible, and declares operators (like "+" and "\*") for *composite* types. This aids readability of the code, but such functions are required to return their result *by copy* in Ada, so come with some performance penalty.

## Experimental setup

To measure runtime properly, a host system like MacOS or Linux is not really suitable. For these experiments, I decided to go for a small 32-bit RISC-V board - a [HiFive1 Revision B](https://www.sifive.com/boards/hifive1-rev-b). This offers a "bare metal" programming environment, so should offer reasonably predictable and reproducible results, and is also supported by the RISC-V cross version of the GNAT Community 2020 Edition and the [Ada Drivers Library](https://github.com/AdaCore/Ada_Drivers_Library).

I wrote some basic performance test programs. Rather than try to test all the functions of the library, I settled on a simpler test of the NaCl "Sign" API which forms a cryptographic signature of an arbitrary message using the signer's private key, using the "Ed25519" alrogithm. The "Sign" operation is computationally expensive, using some complex mathematical trickery involving the Curve25519 elliptic curve, and the SHA512 hash algorithm, so it seemed a good "work out" to test performance of the library.

The main test program is in [SPARKNaCl/perf/tsign.adb](https://github.com/rod-chapman/SPARKNaCl/blob/master/perf/tsign.adb) in the GitHub Repo. See the associated Makefile (tsign.mk) and project file (tsign.gpr) for how it all fits together. The test programs first runs the SPARKNaCl Sign operation on a constant 256 byte message using a fixed secret key and reports the running time in CPU Clock Cycles. It then runs exactly the same test using the TweetNaCl version of the Sign operation, which is also compiled and linked into the same binary. Both the SPARK and C versions are (obviously) compiled with the same compiler (in this case GNAT Community 2020) and at the same optimization level, so the optimization passes and "back end" are the same for each test. Each test was re-run with the compiler set to optimize at levels -O0, -O1 and -O2.

In the following sections, I'll also give the name of the Tag in the GitHub repo that corresponds to the particular snapshot of the code that was used to get each set of results so you can see how the code changes and develops.
## The  Golden Rule
In trying to improve the performance of SPARKNaCl, I set myself one golden rule: the proof of the entire library would remain 100% complete and automated. Any change to the code that "broke the proof" would be rejected.

## Performance Baseline Test (Git Tag: Baseline)
This test uses the code as it was in April 2020 when I wrote the last blog entry, but with no effort to improve performance. Similarly, the TweetNaCl C code used for comparison is essentially unmodified form the designer's original release.

The numbers reported here are in *Millions of CPU cycles* for a Sign operation, so *lower is better*.

|Level|SPARK|C|
|:-------:|-------:|---:|
|-O0|198.03|241.83|
|-O1|98.03|97.65|
|-O2|93.86|84.99|

These results actually came as something of a surprise: SPARK is very close to C at -O1, a little behind at -O2, and noticeably better at -O0, with no effort spent on analysis or optimization at all. How is SPARK winning so convincingly at -O0? A little analysis turned up the following reasons:

### Alternative Carry-and-Reduce code

One of the most time-critical functions in NaCl is the "Carry-and-Reduce" (aka "CAR") function for large (256-bit) integers. These integers are stored as an array of 16, 64-bit integers, and following an operation like "\*", they need to be reduced modulo 2\*\*255-19, and "normalized" so that all digits are in the range 0 .. 65535. With a few introductory type definitions and preprocessor macros, the CAR function in TweetNaCl look like this:




#define FOR(i,n) for (i = 0;i < n;++i)
#define sv static void
typedef long long i64;
typedef i64 gf[16];

sv car25519(gf o)
{
  int i;
  i64 c;

  FOR(i,16) {
    o[i]+=(1LL<<16);
    c=o[i]>>16;
    o[(i+1)*(i<15)]+=c-1+37*(c-1)*(i==15);
    o[i]-=c<<16;
  }
}




As we've seen before, the coding in TweetNaCl emphasizes brevity over readability, so it's pretty hard to see what's going on. At -O0, lines 12 - 15 (the loop body) generate 161 32-bit RISC-V instructions, including 10 32-bit multiplies, since 64-bit signed multiply requires several 32-bit multiply instructions on RV32IM.

Line 14 looks particularly troublesome - it has four multiplications, and is using the value of the loop counter variable i in Boolean tests which are then used as operands for multiplication. Remember that NaCl requires "constant time" programming, so we're not allowed to have a conditional statement inside the loop body. If we were, then we could isolate the "i == 15" case and replace line 14 by:


if (i == 15)
   o[0] += c-1+37*(c-1);
else
   o[i+1] += c-1;


which violates the "constant time" requirement, but is easier to read, and leads to another significant insight: if we "unroll" the final loop iteration (when i == 15), then the if statement inside the loop body can be removed entirely, and the inner loop (of the first 14 iterations) no longer requires a multiplication at all.

There is one further unfortunate feature of this code: the loop body uses the shift operators ">>" and "<<" on *signed* integers in C, which cannot be reproduced directly in SPARK. Secondly, for negative values, the result of a signed shift right is *implementation-defined* in C, while the result of a signed shift left is *undefined*.

In looking at all these issues, and how this code might be best translated and verified in SPARK, I came across the work of [Benoit Viguier](https://benoit.viguier.nl), who had verified this code (and much more besides) using the Coq theorem prover. Benoit pointed out that his effort had actually verified an alternative implementation of CAR that appears in the WireGuard sources, written by [Jason Donenfeld](https://www.zx2c4.com).

Jason's version of the algorithm removes the need for the left-shift inside the loop. The right-shift, though, is still needed. In SPARK, package Interfaces declares a Shift_Right_Arithmetic function for type Unsigned_64. Making that available for a *signed* 64-bit Integer requires two instantiations of Ada.Unchecked_Conversion and a suitable post-condition:




--  returns equivalent of X >> 16 in C, doing an arithmetic
--  shift right when X is negative, assuming 2's complement
--  representation
function ASR_16 (X : in I64) return I64
is (To_I64 (Shift_Right_Arithmetic (To_U64 (X), 16)))
  with Post => (if X >= 0 then ASR_16'Result = X / LM else
                               ASR_16'Result = ((X + 1) / LM) - 1);



Note that ASR_16 is declared as an *expression function* so its body can be available for inlining for both proof and code generation.

The initial CAR algorithm in SPARKNaCl therefore comes out as follows. In this code sample, I have omitted the subtype predicates, loop invariants, and assertions for brevity:



function Car (X : in GF) return GF
is
   Carry : I64;
   R     : GF;
begin
   R := X;
   for I in Index_16 range 0 .. 14 loop
      Carry := ASR_16 (R (I));
      R (I + 1) := R (I + 1) + Carry;
      R (I) := R (I) mod LM;
   end loop;

   Carry := ASR_16 (R (15));
   R (0) := R (0) + R2256 * Carry;
   R (15) := R (15) mod LM;

   return R;
end Car;



This code also makes it a bit clearer how this works. Essentially, the "Carry" (anything above the first 16 bits) for digit I is added to digit I+1. Digit I is then reduced modulo LM (which is 65536). Finally, the carry out from digit 15 is computed. We can't add that to digit 16 (because there isn't one!), so instead it is added to digit 0 once after being multiplied by the "magic" constant R2256. This means we end up with the right result, with the value reduced modulo 2\*\*255-19.

How and why this really works (and the proof of it) is enough material for an entire blog entry, so we won't go into it here.

From the point of view of performance, this inner loop body generates just 59 instructions with no multiplies, so a big win over the original C version.

Does this account for the big performance difference? In SPARKNaCl, I have been able to prove that *three* applications of CAR are needed to fully normalize the results of a "\*" operation on a Normal_GF. In TweetNaCl, CAR is only applied *twice* following "\*". In SPARKNaCl, we also apply CAR (twice each) after "+" and "-".

The inner loop of CAR is executed 16 times, and in SPARKNaCl, a simple experiment (and/or a bit of maths) shows that CAR is called 24564 times for a single "Sign". That means that the inner loop loop of CAR accounts for (16 \* 59 \* 24564) = 23.2 Million instructions.

In TweetNaCl, CAR is called 10240 cycles for the same test, so the inner loop accounts for (16 \* 161 \* 10240) = 26.4 Million instructions.

So... even at -O0, SPARKNaCl is saving about 3.2 Million instructions for just that one loop body.

### Function returns
I had expected that the SPARK code would be significantly slower than the C owing to the use of a functional programming style in SPARK, where we have functions like "+", "-", "\*", and CAR that return a GF (which is 128 bytes) by copy. In writing high-performance code, a generally good rule-of-thumb is to avoid copying data at all costs...

The TweetNaCl C code uses an explicit *by reference* passing style for these functions - they are declared as "void" functions with three parameters, all of which are "pointers to GF", so you'd expect this to be much faster.

So how come SPARK is still competetive? It turns out that there's more to this issue than meets the eye... we'll return to it later when we get to talk about "Return Slot Optimization"...

### Inlining and expression functions

Another performance win for SPARK comes from Ada 2012's *expression functions*. These are always eligible for inlining, even at -O0 with GNAT. Functions are never inlined at -O0 in C, so this explains more performance gains for SPARK here.

### Intrinsic bitwise functions

In TweetNaCl, there is a function declared that performs a 64-bit "Rotate" operation. This is a full-blown function in C, and is never inlined at -O0, so comes with some performance penalty.

In SPARKNaCl, we're using the "Rotate_Right" function declared in package Interfaces, which has Convention Intrinsic applied to it. This means that the GNAT code generator "just knows" how to do this function directly - a kind of "super inlining" that is built into the code generator. On RV32IM, a call to Rotate_Right for a 64-bit unsigned valued expands to just 6 instructions, so a significant performance gain for SPARK, especially in the SHA512 algorithm which uses Rotate_Right in its inner loop.

So.. that explain why SPARK is faster than C at -O0. At higher levels C catches back up through inlining and optimization of the critical function bodies, and the effect of calling CAR far fewer times.

Having established a baseline for performance for both SPARK and C, we can now move on to see how we can improve the SPARK code. At the end of this blog, we'll come back to comparing SPARKNaCl with TweetNaCl to see how they stack up.




## Getting Relaxed about Initialization (Git Tag: Relax_Init)
If you've used SPARK, you'll know it is particularly pedantic about making sure that all objects are properly (and wholly) initialized before they are referenced. In earlier releases of SPARK, the "flow analyzer" treats each variable (of any type) as a *whole object*, so things like arrays are either completely initialized, or not at all.  This approach is safe, but can lead to slightly inefficient coding where arrays end up being initialized twice to avoid a false alarm from the flow analyzer.

SPARK Community 2020 added support for *Relaxed Initialization* of variables which changes that situation. This facility moves the effort of verifying correct initialization from the flow analyzer to the proof engine. This allows us to prove (for example) that an array is properly initialized, even if it is done so element-by-element in a loop.

The language now has a new aspect and a new attribute to make this happen:

* The "Relaxed_Initialization" aspect is applied to a variable. This says "Verify initialization using the proof engine, not the flow analyzer."
* The "'Initialized" attribute returns Boolean given the name of any object or component of an object. It returns true if that object or component has been initialized.

Once again, we return the the CAR algorithm, which serves as a good example of how this works. The assignment "R := X;" is a whole-array assignment. This definitely initializes R, but these objects are 128 bytes, so comes with something of a runtime penalty. The inner loop actually initializes all the element of R *again*, so perhaps we can refactor this code using Relaxed Initialization to avoid the first array assignment. The trick is to "unroll" the *first* loop iteration this time in order to initialize R (0) and R (1) before we go into the loop.
Again, I have removed the uninteresting loop invariants, but it looks basically like this:




is
   Carry : I64;
   R     : GF with Relaxed_Initialization;
begin
   Carry := ASR_16 (X (0));
   R (0) := X (0) mod LM;
   R (1) := X (1) + Carry;

   pragma Assert
     (R (0)'Initialized and R (1)'Initialized);

   for I in Index_16 range 1 .. 14 loop
      Carry := ASR_16 (R (I));
      R (I) := R (I) mod LM;
      R (I + 1) := X (I + 1) + Carry;
      pragma Loop_Invariant
        (for all K in Index_16 range 0 .. I => R (K)'Initialized);
      pragma Loop_Invariant (R (I + 1)'Initialized);
   end loop;

   pragma Assert (R'Initialized);

   -- as before...



The loop invariants say that, after I loop iterations, elements 0 through I+1 of R are initialized. Once we exit the loop (when I = 14), we know that elements 0 through 15 are initialized, but that's the whole array, so we can Assert that R'Initialized just after the loop, and all is well.

We can use the same trick in all the "Car" functions in SPARKNaCl.Car and also in the "+", "\*" and "-" operators for GF that are in the body of the SPARKNaCl package.

Let's compare the performance of the SPARK code at the "Timing_Baseline" tag with the new "Relax_Init" tag:

|Level|Timing_Baseline|Relax_Init|
|:-------:|-------:|---:|
|-O0|198.03|191.54|
|-O1|98.03|95.26|
|-O2|93.86|88.66|

so saving a few million cycles across the board.



## Loop Reduncancy Elimination (Git Tag: PRE_Scalarmult)
We'll now turn a potential improvement in the SPARKNaCl.Sign.Scalarmult code. This functions forms the core of the Sign operation.

The specification of this function is:




function Scalarmult (Q : in GF_Vector_4;
                     S : in Bytes_32) return GF_Vector_4
  with Global => null;



where GF_Vector_4 is an array of 4 GF values. The body (again, simplifying a bit for brevity) looks like this:



function Scalarmult (Q : in GF_Vector_4;
                     S : in Bytes_32) return GF_Vector_4
is
   CB     : Byte;
   Swap   : Boolean;
   LP, LQ : GF_Vector_4;
begin
   LP := (0 => GF_0,
          1 => GF_1,
          2 => GF_1,
          3 => GF_0);
   LQ := Q;

   for I in reverse U32 range 0 .. 255 loop
      CB   := S (I32 (Shift_Right (I, 3)));
      Swap := Boolean'Val (Shift_Right (CB, Natural (I and 7)) mod 2);

      CSwap (LP, LQ, Swap);
      --  Note user-defined "+" for GF_Vector_4 called here
      LQ := LQ + LP;
      LP := LP + LP;
      CSwap (LP, LQ, Swap);
   end loop;

   return LP;
end Scalarmult;



The inner loops run 256 times, and the "+" operator for GF_Vector_4 is expensive in terms of execution time, so this looks like a good target for further efforts.

The inner loops is essentially iterating over all 256 bits of the 32-byte parameter S. The "Current Byte" of interest (CB) is picked from S by dividing the loop counter I by 8 (using a Shift). The exact bit is then extracted from CB by shifting "I and 7" places and doing a "mod 2" to get the value of that one bit. The CSwap procedure is a constant-time conditional swap of GF_Vector_4 values.

In TweetNaCl, the code is stuctured in this way to save space (so the code can fit in fewer tweets), but it's actually far easier to understand if it's written as two nested loops - an outer loop that iterates over the 32 bytes of S and an inner loop that iterates over the 8 bits of CB. It then looks like this:




--  For each byte of S, starting at the MSB
for I in reverse Index_32 loop
   --  For each bit, starting with bit 7 (the MSB)
   for J in reverse Natural range 0 .. 7 loop
      CB := S (I);
      Swap := Boolean'Val (Shift_Right (CB, J) mod 2);
      CSwap (LP, LQ, Swap);
      LQ := LQ + LP;
      LP :+ LP + LP;
      CSwap (LP, LQ, Swap);
   end loop;
end loop;




This structure is arguably easier to read, eliminates a Shift_Right operation, but also reveals an small opportunity for optimization.  The assignment to CB depends on the outer loop counter I, but *not* on the inner loop counter J, so this assignment can be "moved out" of the inner loop, thus:



--  For each byte of S, starting at the MSB
for I in reverse Index_32 loop
   CB := S (I);
   --  For each bit of CB, starting with bit 7 (the MSB)
   for J in reverse Natural range 0 .. 7 loop
      Swap := Boolean'Val (Shift_Right (CB, J) mod 2);
      CSwap (LP, LQ, Swap);
      LQ := LQ + LP;
      LP :+ LP + LP;
      CSwap (LP, LQ, Swap);
   end loop;
end loop;



Compilers already have a pass that does this kind of thing - it's called "Loop Redundancy Elimination", but that's only enabled at -O1 and above, so we can gain a little here at -O0 doing it by hand.

(RCC Question: is that right? If enabled, which pass would move that assignment? tree-pre, tree-fre, loop-invariant-motion?)

With that in place, the performance figures looks like this:

|Level|Timing_Baseline|Relax_Init|PRE_Scalarmult|
|:-------:|-------:|---:|---:|
|-O0|198.03|191.54|191.40|
|-O1|98.03|95.26|95.03|
|-O2|93.86|88.66|87.06|


so a small improvement.



## [Un]Rolling with it... (Git Tag: Unroll_Multiply)
You may wonder why I've not reported figures for the -O3 switch? Good question...

The main effect of -O3 is that it enables automatic loop unrolling. The conditions under which a loop does or doesn't get unrolled aren't entirely clear, and the results (I did try it) are also unpredictable. In particular, unrolling a loop makes the code faster (owing to fewer branches, and not having to maintain loop counter variables), but it also makes the code far bigger and therefore slower by reducing instruction cache hit rate and having to read instructions from memory (or from FLASH) more often.

But... there is one loop in SPARKNaCl that I knew might benefit from a "manual" (i.e. actually modifying the source code) loop unroll - the inner loop of the "\*" operator for the GF type. The loop body is short and it's only executed 16 times, so unrolling it shouldn't result in a large increase in code size.

The algorithm is a classic "ladder" multiplication. Remember that each GF represents a large integer, where each "digit" N represents a coeffecient multiplied by 2\*\*(16N), so the least significant digit represents "units", the next digit is multiplied by 2\*\*16, the next by 2\*\*32 and so on.

To multiply Left by Right, we loop over all the pairs of digits, multiply them together, and accumulate the coeffecients into an intermediate result T which has 31 digits. The digits of this intermediate result can be really big (way beyond 2\*\*16), so that's why TweetNaCl stores them in 64 bits.

The original code looks like this, again omitting the loop invariant:



function "*" (Left, Right : in Normal_GF) return Normal_GF
is
   T  : GF_PA; -- 31 digits
begin
   T := (others => 0);
   --  "Textbook" ladder multiplication
   for I in Index_16 loop
      for J in Index_16 loop
         T (I + J) := T (I + J) + (Left (I) * Right (J));
      end loop;
   end loop;



The inner J loop can be unrolled by hand so it would start with:



T (I)      := T (I)      + (Left (I) * Right (0));
T (I + 1)  := T (I + 1)  + (Left (I) * Right (1));
T (I + 2)  := T (I + 2)  + (Left (I) * Right (2));
--  and so on...


but we notice that the expression "Left (I)" is common to each statement, so we can do a little manual "common subexpression elimination" on there by introducing a new local variable LT:


LT         := Left (I);
T (I)      := T (I)      + (LT * Right (0));
T (I + 1)  := T (I + 1)  + (LT * Right (1));
T (I + 2)  := T (I + 2)  + (LT * Right (2));
--  and so on...


Unrolling the inner loop like this also has one side-benefit: it completely removes the need for a complex loop invariant in the inner loop. It took a while to get it right, so seeing it disappear so easily was a pyrrhic victory of sorts.

With that done, the performance figures look like this:

|Level|Timing_Baseline|Relax_Init|PRE_Scalarmult|Unroll_Multiply|
|:-------:|-------:|---:|---:|---:|
|-O0|198.03|191.54|191.40|176.50|
|-O1|98.03|95.26|95.03|69.88|
|-O2|93.86|88.66|87.06|63.61|

so a big improvement at all optimization levels.



## To Slice or not to Slice? (Git Tag: No_Slices)
The NaCl "Sign" operations uses the SHA512 hash algorithm three times to form a single signature, so I thought it would be another good place to look for performance improvement.

The inner loop of SHA512 repeatedly stores a group of 8 bytes into a Unsigned_64 value, but does so in *big-endian* format, so the first byte becomes the most-significant 8 bits of the result.  To do that, SPARKNaCl declares a simple converison function, called DL64. The original version, translated from the TweetNaCl original, looks like this:



function DL64 (X : in Bytes_8) return U64
is
   U : U64 := 0;
begin
   for I in X'Range loop
      U := Shift_Left (U, 8) or U64 (X (I));
   end loop;
   return U;
end DL64;


which looks simple enough. Note that Bytes_8 is a *constrained* array of Byte (with index values 0 .. 7) and that the Shift_Left and "or" operators here are both operating on 64-bit unsigned values.

In the main loop of SHA512, DL64 gets called many times, converting each group of 8 bytes from a 128 byte block. The "natural" way to write this in SPARK is to use array "slices" to pick out the right group of bytes, and then convert each slice to Bytes_8 to fix the bounds to those expected by DL64. This is all done in one big aggregate assignment that looks like this:


W := (0  => DL64 (Bytes_8 (M (CB + 0 .. CB + 7))),
      1  => DL64 (Bytes_8 (M (CB + 8 .. CB + 15))),
      2  => DL64 (Bytes_8 (M (CB + 16 .. CB + 23))),
      3  => DL64 (Bytes_8 (M (CB + 24 .. CB + 31))),
      -- and so on...
      15 => DL64 (Bytes_8 (M (CB + 120 .. CB + 127))));



This looks elegant, but all those slices are probably a bit slow compared to the C where it's all done with a trivial bit of pointer arithmetic.

I decided to re-write this to see if I could avoid the slices altogether.  The first step is to re-declare DL64 so it takes *two* parameters - a general unconstrained array of bytes X, and an offset value I where it should start picking bytes out of that array. It also needs a suitable precondition that states that there must be at least 8 bytes in X starting at position I, so the new specification looks like this:



function DL64 (X : in Byte_Seq;
               I : in N32) return U64
  with Global => null,
       Pre => X'Length >= 8 and then
              I >= X'First and then
              I <= X'Last - 7;



I also realized that I could re-write the body to avoid looping, and to use 32-bit Shifts and logical operators most of the time, since that will be more efficient on our RV32 CPU. It now looks like this:



function DL64 (X : in Byte_Seq;
               I : in N32) return U64
is
   LSW, MSW : U32;
begin
   --  Doing this in two 32-bit groups avoids the need
   --  for 64-bit shifts on 32-bit machines.
   MSW := Shift_Left (U32 (X (I)),     24) or
     Shift_Left (U32 (X (I + 1)), 16) or
     Shift_Left (U32 (X (I + 2)), 8) or
     U32 (X (I + 3));
   LSW := Shift_Left (U32 (X (I + 4)), 24) or
     Shift_Left (U32 (X (I + 5)), 16) or
     Shift_Left (U32 (X (I + 6)), 8) or
     U32 (X (I + 7));

   --  Just one 64-bit shift and an "or" is now required
   return Shift_Left (U64 (MSW), 32) or U64 (LSW);
end DL64;


With that in place, the calling code is much simpler and avoids the need for array slices and conversions:


W := (0  => DL64 (M, CB),
      1  => DL64 (M, CB + 8),
      2  => DL64 (M, CB + 16),
      --  and so on...
      15 => DL64 (M, CB + 120));


With that in place, the performance figures look like this:

|Level|Timing_Baseline|Relax_Init|PRE_Scalarmult|Unroll_Multiply|No_Slices|
|:-------:|-------:|---:|---:|---:|---:|
|-O0|198.03|191.54|191.40|176.50|177.40|
|-O1|98.03|95.26|95.03|69.88|69.79|
|-O2|93.86|88.66|87.06|63.61|58.31|

so a bit slower at -O0 and -O1, but noticeably faster at -O2.


## Compressed Instructions on RV32 (Git Tag: RV32IM_Not_C)
The RISC-V ISA defines several optional extensions that a particular CPU may choose to implement. The options all have a one-letter identifier, so "M" for Multiplication and Division instructions, "F" for floating-point, and "C" for Compression.

The C option defines 16-bit alternative encodings for the most commonly used 32-bit instructions. The mapping is one-to-one in both directions, so compressed instructions are decoded with a simple table look-up in the CPU, or some simple logic.

Using the compressed instructions is easy, and we've been using them so far in all these tests, since the default for the compiler is to set the target architecture to "RV32IMC". There is no change to the compiler's output, but the assembler generates the compressed opcodes as appropriate. There's also a bit of work done by the linker to make sure that jump and branch instructions all end up going to the right place.

Performance-wise, the compressed instructions can be a mixed blessing. They certainly reduce code size, so you'd expect instruction cache hit rate to improve. On the other hand, there must be some overhead is the extra instruction decoding logic, and then there's the issue of instruction alignment.

In RV32IM (no C!) all instructions are 32 bits so always appear "aligned" on a 4-byte boundary. On RV32IMC, this has to change to allow instructions to be aligned on 2-byte boundaries. The performance impact of this change is very difficult to predict, and obviously depends on the very particular details of the CPU. The E31 Core (the RISC-V core at the heart of the HiFive1_Rev_B board) manual states:

"Fetches are always word-aligned and there is a one-cycle penalty for branching to a 32-bit instruction that is not word-aligned." (section 3.1.5)

so there's a performace hit if we branch to a 32-bit instruction that *isn't* 4-byte aligned.

So... that got me thinking... what if we tell the compiler (well.. assembler) *not* to generate the compressed instructions. What effect would that have on code size and performance? This can be done by setting "-march=rv32im" for the compiler - this switch gets passed on to the assembler and linker and they take care of all the rest.

With no compressed instructions, our performance figures look like this:

|Level|Timing_Baseline|Relax_Init|PRE_Scalarmult|Unroll_Multiply|No_Slices|RV32IM_Not_C|
|:-------:|-------:|---:|---:|---:|---:|---:|
|-O0|198.03|191.54|191.40|176.50|177.40|182.15|
|-O1|98.03|95.26|95.03|69.88|69.79|69.94|
|-O2|93.86|88.66|87.06|63.61|58.31|57.77|


so a bit worse at -O0 and -O1 and a bit better at -O2. As for code size, the quick check with the "riscv32-elf-size" tool tells us that the binary at -O2 is 3648 bytes bigger without the compressed instructions, so not too bad unless, like me, you started programming on a ZX81 with 1k of RAM.




## Return Slot Optimization (Git Tag: RSO)
We now return a a vexing question: how come SPARK was so fast to begin with, especially at -O0? I had expected that the SPARK code would be far slower than TweetNaCl to begin with, owing to its functional programming style, and the use of user-defined functional operators like "+", "-" and "\*" for the types GF and GF_Vector_4. These functions return large blocks of data (128 bytes for a GF) by copy, so I had expected that this would be a big performance hit.

To find out what was going on, I reached out to Eric Botcazou at AdaCore ... it turns out it's all down to something called "Return Slot Optimization" (RSO) in GNAT. This section explains RSO, why it's so important, and how we've managed to exploit it in SPARKNaCl.

First, consider the "canonical" semantics of an assignment statement that calls a function F with 2 arguments - something like:



A := F (B, C);


Let's assume that A, B, and C are all of some type T, which is "big" - like a constrained array of data. In the worst-case scenario, two temporary variables and two assignments are required.
1. In the body of F, the return value will be constructed in a temporary variable, then copied back to the caller.
2. In the calling code, the returned value will be assigned into a compiler-generated temporary variable, before being wholly assigned onto A.

Now.. there must be opportunities to optimize that to get rid of the extra assignments - this is RSO. The trouble is that some conditions mean that RSO cannot always be safely applied. In particular, any of the following can defeat RSO:
1. Aliasing between any of the parameters (B and C) and/or the assignment target (A in this case).
2. Side-effects caused by calling F.
3. An unhanded exception raised by F.

A further complication is the fact that GCC compiles many languages, so it doesn't know if the code has come from Ada, C, C++, Fortran or whatever else, so it has to make worst-case assumptions about these issues.

But... hang on a minute... we're compiling SPARK here, where's there's no aliasing, no function side-effects, and (for SPARKNaCl) we've proven that there are no exceptions. The trouble is, the compiler doesn't know that... yet...

There are three places that RSO can be spotted and enabled:
1. In the generation of the "Gimple" intermediate code. This is always done, even at -O0, but can only spot very simple cases.
2. An optimization pass called "retslot" that is enabled at -O1 and above.
3. A later optimization pass called "nrv" tries again. Also enabled at -O1 and above.

To understand and see the effect of RSO, let's look at the function SPARKNaCl.Sign."+" which operates on the GF_Vector_4 type. The SPARK code looks like this:



function "+" (Left, Right : in GF_Vector_4) return GF_Vector_4
is
   A, B, C, D, E, F, G, H : Normal_GF;
   function Double (X : in Normal_GF) return Normal_GF
     is (X + X)
     with Global => null;
begin
   A := (Left (1) - Left (0)) * (Right (1) - Right (0));
   B := (Left (0) + Left (1)) * (Right (0) + Right (1));
   C := (Left (3) * Right (3)) * GF_D2;
   D := Double (Left (2) * Right (2));

   E := D - C;
   F := D + C;
   G := B - A;
   H := B + A;

   return GF_Vector_4'(0 => G * E,
                       1 => H * F,
                       2 => F * E,
                       3 => G * H);
end "+";



This body makes 18 calls to the operators for GF defined in the body of SPARKNaCl, so this should be ripe for RSO.

To see what's going on in the Gimple code before and after each optimization pass, we can run the compiler with the "-fdump-tree-all" flag.

Using GNAT Community 2020 Edition, in the unoptimized Gimple code for "+", only 10 of those 18 calls have RSO enabled. For example, the Gimple code for the final 4 assignments and the return statement look like this:



e = sparknacl."-" (&d, &c);
f = sparknacl."+" (&d, &c);
g = sparknacl."-" (&b, &a);
h = sparknacl."+" (&b, &a);

R.6 = sparknacl."*" (&g, &e); [return slot optimization]
<retval>[0] = R.6;

R.7 = sparknacl."*" (&h, &f); [return slot optimization]
<retval>[1] = R.7;

R.8 = sparknacl."*" (&f, &e); [return slot optimization]
<retval>[2] = R.8;

R.9 = sparknacl."*" (&g, &h); [return slot optimization]
<retval>[3] = R.9;

return <retval>;



So... the first four calls are missing out on RSO. The final four calls get RSO in the called operator, but the results is still assigned to a tempories R.6 though R.9 before being copied to "retval" and returned to the caller. Looking at the Gimple code that results from the "retslot" and "nrv" passes, there's no further change at all.

Looking even deeper at the generated code for "+" at -O2, we find it needs 1197 instructions to execute, but 1072 of those are involved in copying the results of calls to those 18 operators, which does seem like an unfortunate overhead.

These calls *could* be subject to RSO becuase of the intrinsic properties of SPARK, but the compiler doesn't know that. We need some way of giving a "hint" to the compiler that all these calls should be OK for RSO.

In order to see how this can work, I added the "Pure_Function" aspect to all the functions in the call-tree of SPARKNaCl.Sign, and Eric modified GNAT to spot this so that RSO could be enabled more widely. This has been implemented in a wavefront of GNAT Pro 22.0w. With that in place, the unoptimized Gimple for the same fragment of "+" looks like this:



e = sparknacl."-" (&d, &c); [return slot optimization]
f = sparknacl."+" (&d, &c); [return slot optimization]
g = sparknacl."-" (&b, &a); [return slot optimization]
h = sparknacl."+" (&b, &a); [return slot optimization]
<retval>[0] = sparknacl."*" (&g, &e); [return slot optimization]
<retval>[1] = sparknacl."*" (&h, &f); [return slot optimization]
<retval>[2] = sparknacl."*" (&f, &e); [return slot optimization]
<retval>[3] = sparknacl."*" (&g, &h); [return slot optimization]
return <retval>;



which is a bit more like it! We see all 8 calls here getting RSO, *and* the results of the final 4 calls are assigned directly onto "retval" and the extra temporary variables have disappeared. In fact, *all* 18 calls in "+" now have RSO enabled.

Looking at the generated code for "+" at -O2 with the new compiler is revealing - it's a single straight line sequence of just 94 instructions, with no branches, so something of an improvment from 1197 instructions before.

Another pleasant side-effect is that RSO removes the need for many compiler-generated temporary variables. With Community 2020, "+" requires 1712 bytes of space on the stack, while with the new compiler that comes down to 1056 bytes, so reducing worst-case stack usage a fair amount.

In terms of performace, the gain here is not so great for two reasons:
1. The "+" operator on GF_Vector_4 is called 512 times for a single "Sign" operation, so we'd expect something like (1197 - 94)\*512 = 564736 instructions improvement at -O2, or about 0.5 Million cycles (assuming the processor is averaging roughly 1 instruction per cycle or thereabouts...)
2. The (far more time-critical) "+", "\*", "-" and "CAR" functions on GF *are* getting RSO applied with the GNAT Community 2020 Edition, so we're not expecting to see much improvement there.

With the new compiler, the performance figures look like this:

|Level|--Baseline|--Relax_Init|--PRE_Scalarmult|--Unroll_Multiply|--No_Slices|--RV32IM_Not_C|--RSO(GNAT 22.0w)|
|:-------:|-------:|---:|---:|---:|---:|---:|---:|
|-O0|198.03|191.54|191.40|176.50|177.40|182.15|176.24|
|-O1|98.03|95.26|95.03|69.88|69.79|69.94|69.34|
|-O2|93.86|88.66|87.06|63.61|58.31|57.77|57.34|

which is in line with our expectations.




## Back to TweetNaCl and levelling the playing field (Git Tag: Faster_Tweet)
We'll now return to comparing the performance of SPARKNaCl with TweetNaCl.

It would be tempting to just compare original results with TweetNaCl to our final and best results with SPARK for our "Sign" test, returning to using the GNAT Community 2020 edition:


|Level|--TweetNaCl|--SPARKNaCl @ RSO|
|:-------:|-------:|---:|
|-O0|241.83|182.15|
|-O1|97.65|69.94|
|-O2|84.99|57.77|

Based on that, we could declare victory and ride off into the sunset, but it's not really a fair comparison any more, is it?

We've spent considerable effort in applying some transformations to SPARKNaCl which (if we're willing to give up the "fits in 100 tweets" requirement) could also be applied to the TweetNaCl sources.  In particular, the following changes could be applied to TweetNaCl:
1. Adoption of Donenfeld's alternative CAR algorithm.
2. Loop redundancy elimination in Sign.Scalarmult.
3. Unrolling the inner loop in "\*" for GF.

Our changes to eliminate array slices, relaxed initialization, and return slot optimization have no real equivalent in C, so can't be applied. We'll also continue to use the same compiler options (and the same compiler), so switching to the uncompressed ISA will be picked up in testing TweetNaCl.

With those changes in place (See the GIT Tag "Faster_Tweet" for the revised perf/tweetnacl.c sources), the results look like this:

|Level|--TweetNaCl|--SPARKNaCl|
|:-------:|-------:|---:|
|-O0|175.74|181.74|
|-O1|62.32|69.96|
|-O2|51.00|57.82|

so C is winning again at all levels. Most of this improvement in the C comes down to Donenfeld's revised CAR code - it is not only faster than the original, but is only called 10240 times for a single "Sign" operation, as opposed to 24564 times in SPARKNaCl. That alone could account for TweetNaCl executing about 13 Million fewer instructions.

The good news is that, for both languages, we've managed a dramatic improvement from the original Baseline tag.



## Hang on Harry, I've got a good idea...
In doing and writing about this work, I've already come up with a few more ideas for how I could improve the SPARK. In no particular order:
* Re-introduce the Compressed RISC-V instruction set, but use the -falign-functions and -falign-labels switches to force 4-byte alignment of all jump targets. That might get us close to the original code density with the compressed instructions, but without paying the penalty for mis-aligned branches. Thanks to Eric once again for pointing out this possibility.
* SPARK is mainly losing performance owing to all those extra calls to CAR. A long-term goal would be to fall into line with TweetNaCl, by *not* normalizing the results of "+" and "-", and only needing to apply CAR *twice* after "\*". The proof that this works will be, um, challenging...
* I realize that most-of-the-time, storing a Normal_GF with 64-bit digits is a complete waste of space, but also a huge performance penalty on RV32, where all the 64-bit arithmetic requires multiple instructions.  We could store a Normal_GF using 32-bit digits, which are fine to store the intermediate results of "+" and "-". We'd only have to "expand out" to 64-bit digits for the intermediate results of "\*". This would also save lots of memory, *and* make every assignment of a Normal_GF half the size! My initial analysis indicates that only the *first* CAR following a "\*" needs to be done in 64-bit arithmetic. Of the 24564 calls to CAR that we currently see in a Sign operation, that means 19448 of them could be replaced by a 32-bit version. I wrote a quick-and-dirty 32-bit version of CAR that comes out at 133 instructions on RV32IM at -O2, versus 321 instructions for the 64-bit variant. This would save something like 3.5 Million instructions in a Sign operation, so worth a go...

If I get round to implementing any of these, then I'll write another (and hopefully shorter) blog entry.



## Conclusions and Further Work

This has all been something of a marathon.  My excuse is that I needed something fun to do during lockdown. I should probably get out more... except I'm not allowed to...

Well done if you've got this far... in conclusion:

* There really doesn't seem to be a conflict between formal proof and getting high-performance out of time-critical code like this. At all stages of this process, the proof of type-safety and other properties for SPARKNaCl has been maintained. Indeed, the continuity of the proof is really important in giving me confidence that my performance-improving transformations *haven't* done something bad to the actual correctness of the code.
* I was largely ignorant of RSO and its importance before this, but it's really important. It means we can still adopt an elegant and functional programming style in SPARK, but without sacrificing performance owing to returning composite type from functions.

In terms of further work:

* The ideas above provide a few more areas where SPARK could gain some performance.
* This work has concentrated on the "Sign" top-level operation, but there are others that have been unused (and therefore untouched) in this work, notably the Salsa20 stream cipher, and the top-level "CryptoBox" operation. Performance analysis and tuning of those could be done next.
* Do some more experiments with -O3, but use GNAT's pragma Loop_Optimize (No_Unroll) to control loop unrolling precisely.
* Try this all over again with a 64-bit RISC-V target.
* Try it all again with GNAT-LLVM. This would be interesting just to see how much faster or slower LLVM's code runs, but there are also a host of formal verification tools for LLVM IR that we could use to check, for example, the correctness of optimization passes using tools like Galois Inc's [SAW](http:/saw.galois.com/).
* More work is needed on RSO and how we can teach the compiler to take advantage of it for verified SPARK code. Watch out for more progress on this in a future GNAT release.

### Acknowledgements
Many thanks to Eric Botcazou of AdaCore for his support in this work. In particular, Eric explained the ins-and-outs of Return Slot Optimization to me and implemented the improvements to RSO in GNAT 22.0w that are reported above. Thanks to Cyrille Comar, Yannick Moy and the rest of SPARK team at AdaCore for their support and comments on earlier drafts of this blog.
