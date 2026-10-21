--  Assertion level for the ordinary (executable) postconditions of
--  subprograms that also have a ghost postcondition at level
--  SPARKlib_Logic. A Post aspect that names an assertion level can only
--  contain assertion level associations, so these postconditions need a
--  level too. No Assertion_Policy names this level, so like an ordinary
--  Post it is checked at run time with -gnata, and ignored otherwise.
pragma Assertion_Level (SPARKNaCl_Contracts);

with SPARKNaCl.Utils;
with SPARKNaCl.Hashing.SHA512; use SPARKNaCl.Hashing.SHA512;

--  Ghost-only units, used to state and prove the functional correctness
--  of ModL. Both are at assertion level SPARKlib_Logic, so are never
--  compiled into executable code.
with SPARK.Big_Integers;          use SPARK.Big_Integers;
with SPARKNaCl.Sign.ModL_Lemmas;  use SPARKNaCl.Sign.ModL_Lemmas;
package body SPARKNaCl.Sign
  with SPARK_Mode => On
is
   pragma Warnings (GNATProve, Off, "pragma * ignored (not yet supported)");

   --============================================
   --  Local constants and types
   --============================================

   GF_D  : constant Normal_GF := (16#78a3#, 16#1359#, 16#4dca#, 16#75eb#,
                                  16#d8ab#, 16#4141#, 16#0a4d#, 16#0070#,
                                  16#e898#, 16#7779#, 16#4079#, 16#8cc7#,
                                  16#fe73#, 16#2b6f#, 16#6cee#, 16#5203#);

   GF_I  : constant Normal_GF := (16#a0b0#, 16#4a0e#, 16#1b27#, 16#c4ee#,
                                  16#e478#, 16#ad2f#, 16#1806#, 16#2f43#,
                                  16#d7a7#, 16#3dfb#, 16#0099#, 16#2b4d#,
                                  16#df0b#, 16#4fc1#, 16#2480#, 16#2b83#);

   GF_X  : constant Normal_GF := (16#d51a#, 16#8f25#, 16#2d60#, 16#c956#,
                                  16#a7b2#, 16#9525#, 16#c760#, 16#692c#,
                                  16#dc5c#, 16#fdd6#, 16#e231#, 16#c0a4#,
                                  16#53fe#, 16#cd6e#, 16#36d3#, 16#2169#);

   GF_Y  : constant Normal_GF := (16#6658#, 16#6666#, 16#6666#, 16#6666#,
                                  16#6666#, 16#6666#, 16#6666#, 16#6666#,
                                  16#6666#, 16#6666#, 16#6666#, 16#6666#,
                                  16#6666#, 16#6666#, 16#6666#, 16#6666#);

   --  Original TweetNaCl code computes Q(3) by multiplying GF_X by GF_Y,
   --  but this is a constant (now called GF_XY), thus:
   GF_XY : constant Normal_GF := (16#DD90#, 16#A5B7#, 16#8AB3#, 16#6DDE#,
                                  16#52F5#, 16#7751#, 16#9F80#, 16#20F0#,
                                  16#E37D#, 16#64AB#, 16#4E8E#, 16#66EA#,
                                  16#7665#, 16#D78B#, 16#5F0F#, 16#E787#);

   GF_D2 : constant Normal_GF := (16#f159#, 16#26b2#, 16#9b94#, 16#ebd6#,
                                  16#b156#, 16#8283#, 16#149a#, 16#00e0#,
                                  16#d130#, 16#eef3#, 16#80f2#, 16#198e#,
                                  16#fce7#, 16#56df#, 16#d9dc#, 16#2406#);

   type GF_Vector_4 is array (Index_4) of Normal_GF;

   --  MBP = "Max Byte Product"
   MBP        : constant := (255 * 255);
   Max_X_Limb : constant := (32 * MBP) + 255;

   --============================================
   --  Local subprogram declarations
   --============================================

   --  Functional correctness: the result, as a 256-bit little-endian
   --  integer, is the 512-bit input X reduced modulo L. Since "mod"
   --  returns a value in 0 .. L - 1, this also says the result is
   --  fully reduced.
   function ModL (X : in I64_Seq_64) return Bytes_32
     with Pure_Function,
          Global => null,
          Pre    => (for all K in Index_64 => X (K) in 0 .. Max_X_Limb),
          Post   =>
            (SPARKlib_Logic => Value (ModL'Result) = Value (X) mod L_Big);

   procedure Sanitize_GF_Vector_4 (R : out GF_Vector_4)
     with Global => null;

   --  Replaces function "add" in the TweetNaCl sources
   function "+" (Left, Right : in GF_Vector_4) return GF_Vector_4
     with Pure_Function,
          Global => null;

   function Scalarmult (Q : in GF_Vector_4;
                        S : in Bytes_32) return GF_Vector_4
     with Pure_Function,
          Global => null;

   function Scalarbase (S : in Bytes_32) return GF_Vector_4
     with Pure_Function,
          Global => null;

   function Pack (P : in GF_Vector_4) return Bytes_32
     with Pure_Function,
          Global => null;

   subtype Bit is Byte range 0 .. 1;

   function Par_25519 (A : in Normal_GF) return Bit
     with Pure_Function,
          Global => null;

   --  SPARKNaCl introduces this function to combine Hash and Reduce into
   --  a single call. Former procedure Reduce removed.
   function Hash_Reduce (M : in Byte_Seq) return Bytes_32
     with Pure_Function,
          Global => null;

   procedure Unpackneg (R  :    out GF_Vector_4;
                        OK :    out Boolean;
                        P  : in     Bytes_32)
     with Global => null;


   --============================================
   --  Local subprogram bodies
   --============================================

   procedure Sanitize_GF_Vector_4 (R : out GF_Vector_4)
   is
   begin
      for I in R'Range loop
         pragma Loop_Optimize (No_Unroll);
         Sanitize_GF16 (R (I));
      end loop;
   end Sanitize_GF_Vector_4;

   function "+" (Left, Right : in GF_Vector_4) return GF_Vector_4
   is
      A, B, C, D, E, F, G, H : Normal_GF;

      function Double (X : in Normal_GF) return Normal_GF
        is (X + X)
        with Pure_Function,
             Global => null;
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

   function Scalarmult (Q : in GF_Vector_4;
                        S : in Bytes_32) return GF_Vector_4
   is
      CB     : Byte;
      Swap   : Boolean;
      LP, LQ : GF_Vector_4;

      procedure CSwap (P, Q : in out GF_Vector_4;
                       Swap : in     Boolean)
        with Global => null;

      procedure CSwap (P, Q : in out GF_Vector_4;
                       Swap : in     Boolean)
      is
      begin
         for I in Index_4 loop
            pragma Loop_Optimize (No_Unroll);
            Utils.CSwap16 (P (I), Q (I), Swap);
         end loop;
      end CSwap;
   begin
      LP := (0 => GF_0,
             1 => GF_1,
             2 => GF_1,
             3 => GF_0);
      LQ := Q;

      --  For each byte of S, starting at the MSB
      for I in reverse Index_32 loop
         pragma Loop_Optimize (No_Unroll);
         CB := S (I);
         --  For each bit of CB, starting with bit 7 (the MSB)
         for J in reverse Natural range 0 .. 7 loop
            pragma Loop_Optimize (No_Unroll);
            Swap := Boolean'Val (Shift_Right (CB, J) mod 2);

            CSwap (LP, LQ, Swap);
            LQ := LQ + LP;
            LP := LP + LP;
            CSwap (LP, LQ, Swap);
         end loop;
      end loop;

      return LP;
   end Scalarmult;

   function Scalarbase (S : in Bytes_32) return GF_Vector_4
   is
   begin
      return Scalarmult (GF_Vector_4'(GF_X, GF_Y, GF_1, GF_XY), S);
   end Scalarbase;

   function Par_25519 (A : in Normal_GF) return Bit
   is
      D : Bytes_32;
   begin
      D := Utils.Pack_25519 (A);
      return (D (0) mod 2);
   end Par_25519;

   function Pack (P : in GF_Vector_4) return Bytes_32
   is
      TX, TY, ZI : Normal_GF;
      R : Bytes_32;
   begin
      ZI := Utils.Inv_25519 (P (2));
      TX := P (0) * ZI;
      TY := P (1) * ZI;
      R := Utils.Pack_25519 (TY);
      R (31) := R (31) xor (Par_25519 (TX) * 128);
      return R;
   end Pack;

   --  RFC 7748 says the "order" of Curve25519 is
   --  2^252 + 0x14def9dea2f79cd65812631a5cf5d3ed
   --
   --  In little-endian radix 2**8 format, this is 256 bits, thus:
   Min_Non_Zero_L : constant := 16#12#;
   Max_L          : constant := 16#f9#;
   L31            : constant := 16#10#;
   subtype L_Limb is I64_Byte range 0 .. Max_L;

   type L_Table is array (Index_32) of L_Limb;
   L : constant L_Table := (16#ed#, 16#d3#, 16#f5#, 16#5c#,
                            16#1a#, 16#63#, 16#12#, 16#58#,
                            16#d6#, 16#9c#, 16#f7#, 16#a2#,
                            16#de#, 16#f9#, 16#de#, 16#14#,
                            16#00#, 16#00#, 16#00#, 16#00#,
                            16#00#, 16#00#, 16#00#, 16#00#,
                            16#00#, 16#00#, 16#00#, 16#00#,
                            16#00#, 16#00#, 16#00#, L31);

   --  The value of 16 * L (I) can be pre-computed in a second table,
   --  giving a small time saving in two inner loops below.
   --  Only the first 16 elements are ever accessed, so we can declare
   --  a smaller table, and specify a stronger range constraint on the
   --  elements, thus:
   subtype L16_Limb is I64 range (16 * Min_Non_Zero_L) .. (16 * Max_L);
   type L16_Table  is array (Index_16) of L16_Limb;
   L16 : constant L16_Table := (16#ed0#, 16#d30#, 16#f50#, 16#5c0#,
                                16#1a0#, 16#630#, 16#120#, 16#580#,
                                16#d60#, 16#9c0#, 16#f70#, 16#a20#,
                                16#de0#, 16#f90#, 16#de0#, 16#140#);

   --  Ghost link between the tables L and L16 above and the model L_Arr
   --  of L used in the proof of ModL
   procedure Lemma_L_Tables
     with Ghost => SPARKlib_Logic,
          Post  => (for all T in Index_32 => To_Big (L (T)) = L_Arr (T)) and
                   (for all T in Index_16 => L16 (T) = 16 * L (T));

   procedure Lemma_L_Tables
   is null;

   --===========================================================
   --  ModL - how and why it works
   --
   --  Warning: this summary was generated by Claude Opus 5.5,
   --  based on this code, the contracts, and Bernstein's
   --  TweetNaCl code and paper.
   --===========================================================
   --
   --  ModL takes a 512-bit integer X, held as 64 little-endian
   --  radix 2**8 limbs (X (K) has weight 2**(8*K)), and returns
   --  X mod L as 32 bytes, where L is the order of the Ed25519 base
   --  point:
   --
   --    L = 2**252 + D, where D = 16#14def9dea2f79cd65812631a5cf5d3ed#
   --
   --  (D is about 2**125.) In table L above, L (0 .. 15) hold D,
   --  L (16 .. 30) are zero, and L (31) = 16#10# holds the 2**252
   --  term (16 * 2**248).
   --
   --  The key identity
   --  ----------------
   --  Since 16 * L = 2**256 + 16 * D, we have
   --
   --    2**256 = -16 * D  (mod L)
   --
   --  so a limb at position I >= 32 can be replaced by lower limbs:
   --
   --    XL (I) * 2**(8*I) = -16 * D * XL (I) * 2**(8*(I-32))  (mod L)
   --
   --  Zeroing XL (I) and subtracting 16 * L (K) * XL (I) from
   --  XL (I - 32 + K), for K in 0 .. 15, subtracts exactly
   --  XL (I) * 2**(8*(I-32)) * 16 * L from the total. That is a
   --  multiple of L, so the value mod L is unchanged. Table L16
   --  holds the pre-computed values of 16 * L (K).
   --
   --  Signed ("balanced") carries
   --  ---------------------------
   --  After each subtraction, the limb is renormalized:
   --
   --    Carry := ASR_8 (XLJ + 128);
   --    XLJ   := XLJ - Carry * 256;
   --
   --  This rounds to the nearest multiple of 256 rather than flooring,
   --  so the limb ends up in -128 .. 127 (subtype FRL, "Fully Reduced
   --  Limb"). The Carry * 256 removed from limb J is added to limb
   --  J + 1, so the represented integer is preserved exactly. The
   --  contract on ASR_8 pins down that it behaves like C's arithmetic
   --  ">> 8" (floor division) for negative values. None of the carry
   --  bounds could be proved without that.
   --
   --  The adjustments are large (up to about 4000 * 2**21, or 2**33),
   --  so carries leaving the 16 non-zero D positions are large too
   --  (Carry_T is -2**25 .. 2**14). TweetNaCl therefore runs the
   --  inner loop over 20 positions, not 16, so the carry can shrink
   --  to nothing before it is dropped into a limb. The assertions in
   --  Eliminate_Limbs_62_To_32 record this convergence step by step:
   --
   --    After limb   Carry range asserted
   --    I - 16       Carry_T (-2**25 .. 2**14)
   --    I - 15       -2**17 .. 64
   --    I - 14       -512 .. 1
   --    I - 13       -2 .. 1
   --    I - 12       -1 .. 1
   --
   --  The last carry is added to XL (I - 12) without renormalization,
   --  so that limb can reach -129 or +128. Hence the weaker subtype
   --  PRL ("Partially Reduced Limb", -129 .. 128). SPARKNaCl unrolls
   --  the four positions where L (16 .. 19) = 0, which avoids
   --  multiplying by zero and gives each step its own carry bound for
   --  the provers.
   --
   --  Phase by phase, following the contracts
   --  ---------------------------------------
   --  Precondition: X (K) in 0 .. Max_X_Limb. Max_X_Limb is
   --  32 * 255**2 + 255, the largest limb that Sign can produce:
   --  Sign computes R + H * D by schoolbook multiplication of two
   --  32-byte numbers, so each column sums at most 32 byte products
   --  plus one byte of R. Hash_Reduce passes plain bytes, which is a
   --  subset of that range. Every overflow bound in ModL follows from
   --  this one number.
   --
   --  1. Initialize_XL copies X into XL, whose element subtype XL_Limb
   --     is wide enough for every intermediate value. The
   --     postcondition XL (K) = X (K) lets later contracts refer to
   --     the original input.
   --
   --  2. Eliminate_Limb_63 is the I = 63 iteration of TweetNaCl's
   --     outer loop, split out as a special case. It writes into
   --     limbs 31 .. 51, and some of those (32 .. 51) still hold raw
   --     input of about 2**21. Its postcondition describes the uneven
   --     state it leaves behind:
   --       - limbs 0 .. 30 and 52 .. 62 are unchanged (= X (K));
   --       - limbs 31 .. 50 are in FRL;
   --       - limb 51 is raw input plus one carry (XL51_T, at most
   --         Max_X_Limb + Max_L63_Carry);
   --       - limb 63 is 0.
   --     Doing this iteration separately means the general loop never
   --     has to handle a limb larger than XL51_T'Last.
   --
   --  3. Eliminate_Limbs_62_To_32 runs I from 62 down to 32.
   --     Iteration I writes only to limbs I - 32 .. I - 12, all below
   --     I. So limbs already eliminated stay zero (invariant
   --     XL (K) = 0 for K >= I), and limbs 52 .. 62 are untouched
   --     until their own turn. The postcondition:
   --       - limbs 0 .. 19 are in FRL, because they fall in the
   --         16 + 4 normalized window of the final iteration (I = 32);
   --       - limbs 20 .. 31 are in PRL, because each was either
   --         normalized or was the un-normalized "I - 12" landing limb
   --         of some iteration;
   --       - limbs 32 .. 63 are 0.
   --     The value is now about 2**256 in magnitude, may be negative,
   --     and is congruent to X mod L.
   --
   --  4. Finalize has three steps.
   --     Step 1 subtracts (XL (31) / 16) * L, via
   --       ASR_4 (XL (31)) * L (J), over all 32 limbs. Because
   --       L (31) = 16, this strips the multiples of 2**252 out of the
   --       top limb and subtracts the matching multiples of D lower
   --       down. Carries here use floor (ASR_8 and mod 256), so limbs
   --       0 .. 30 become proper bytes in 0 .. 255. XL (31) is read on
   --       every iteration before limb 31 itself is updated; the loop
   --       invariant "J + 1 .. 31 unchanged" makes that explicit.
   --     Step 2 handles the carry out of limb 31. Dropping that carry
   --       means working mod 2**256. If the Step 1 result was
   --       negative, the carry is -1, and subtracting Carry * L (J)
   --       adds L back. The final result is then the same value taken
   --       mod 2**256.
   --     Step 3 is a last floor-carry chain that writes the bytes into
   --       R. The carry out of limb 31 goes into XL (32), which is
   --       never read again. That is the mod 2**256 truncation, and it
   --       explains the suppressed "unused assignment" warning at the
   --       call to Finalize.
   --
   --  What the proof establishes
   --  --------------------------
   --  The contracts prove type safety: every intermediate value fits
   --  its subtype, nothing overflows I64, and the outputs are valid
   --  bytes. That proof leans heavily on bounds that come from
   --  understanding the algorithm, such as the carry-convergence
   --  assertions and Min_XL47_Carry = -127006.
   --
   --  The contracts also prove functional correctness. The
   --  postcondition of ModL is
   --
   --    Value (ModL'Result) = Value (X) mod L_Big
   --
   --  where Value is the integer represented by a sequence of limbs.
   --  Since "mod" returns a value in 0 .. L - 1, this says both that
   --  R = X (mod L) and that R < L. The model (Value, L_Big and
   --  lemmas) is in the private ghost child package
   --  SPARKNaCl.Sign.ModL_Lemmas, which uses SPARK.Big_Integers. Each
   --  nested procedure has a postcondition on V (XL), the integer value
   --  of XL:
   --    Initialize_XL            V (XL) = Value (X)
   --    Eliminate_Limb_63        V (XL) decreases by XL (63) * 16 * L
   --                             * 2**248
   --    Eliminate_Limbs_62_To_32 V (XL) mod L is unchanged
   --    Finalize                 Value (R) = V (XL) mod L
   --
   --  The bound in Finalize comes from the preconditions on XL: before
   --  Step 1 the value less (XL (31) / 16) * L lies in
   --  -2**248 - 9 * D .. 16 * 2**248, so the carry out of limb 31 in
   --  Step 1 is -1 or 0, and adding back L in Step 2 when it is -1
   --  gives a result in 0 .. L - 1.
   --
   --  All of this ghost code is at assertion level SPARKlib_Logic,
   --  which depends on the Static level, so it is never compiled into
   --  executable code, even with assertions enabled. The bodies of the
   --  recursive model functions and of the loop-invariant predicates
   --  are hidden from the provers except where a lemma needs them, so
   --  that the Big_Integer facts do not swamp the type-safety proofs.
   --===========================================================
   function ModL (X : in I64_Seq_64) return Bytes_32
   is

      Max_Carry : constant := 2**14;
      Min_Carry : constant := -2**25;
      subtype Carry_T is I64 range Min_Carry .. Max_Carry;

      Min_Adjustment : constant := (Min_Carry * 16 * Max_L);
      Max_Adjustment : constant := ((Max_X_Limb + Max_Carry) * 16 * Max_L);
      subtype Adjustment_T is I64
        range Min_Adjustment .. Max_Adjustment;

      subtype XL_Limb is I64
        range -((Max_X_Limb + Max_Carry + Max_Adjustment) * 16 * Max_L) ..
               ((Max_X_Limb + Max_Carry + Max_Adjustment) * 16 * Max_L);

      type XL_Table is array (Index_64) of XL_Limb;
      XL : XL_Table;

      --  "PRL" = "Partially Reduced Limb"
      subtype PRL is I64 range -129 .. 128;

      --  "FRL" = "Fully Reduced Limb"
      subtype FRL is PRL range -128 .. 127;

      --  R is written byte by byte in Finalize. Relaxed_Initialization
      --  lets the loop invariants there refer to the bytes written so
      --  far; R'Initialized in the postcondition of Finalize shows that
      --  R is fully initialized before it is returned. This aspect only
      --  affects proof, not the generated code.
      R     : Bytes_32
        with Relaxed_Initialization;

      --  The largest value of Carry is achieved when XL (63) = 0,
      --  so that
      --   Max_L63_Carry = ASR_8 (Max_X_Limb + Max_L63_Carry + 128)
      --  Knowing that all the terms are positive means we can expand
      --  ASR_8 and simplify.
      --  This is declared here it can be used to derive subtype
      --  XL51_T and used in the post-condition of Eliminate_Limb_63 below
      Max_L63_Carry : constant := (Max_X_Limb + 128) / 255;

      subtype XL51_T is I64 range 0 .. (Max_X_Limb + Max_L63_Carry);

      --------------------------------------------------------------
      --  Ghost model of XL for the functional correctness proof.
      --  V (XL) is the integer represented by XL, i.e. the sum of
      --  XL (K) * 256**K for K in 0 .. 63.
      --------------------------------------------------------------

      function XL_Big (A : in XL_Table) return Big_Arr
        with Ghost => SPARKlib_Logic,
             Post  => (for all K in Index_64 =>
                         XL_Big'Result (K) = To_Big (A (K)));

      function V (A : in XL_Table) return Big_Integer
      is (Big_Value (XL_Big (A), 64))
        with Ghost => SPARKlib_Logic;

      --  Changing one limb J of XL changes V (XL) by the difference
      --  times 256**J
      procedure Lemma_XL_Update (Old_XL, New_XL : in XL_Table;
                                 J              : in Index_64)
        with Ghost => SPARKlib_Logic,
             Pre   => (for all K in Index_64 =>
                         (if K /= J then Old_XL (K) = New_XL (K))),
             Post  => V (New_XL) =
                        V (Old_XL) +
                        (To_Big (New_XL (J)) - To_Big (Old_XL (J))) * P (J);

      --  One carry-propagation step at limb J. Limb J changes by
      --  C_Old - A - 256 * C_New, where C_Old is the carry in, A is a
      --  subtracted adjustment and C_New is the carry out. Then
      --  V (XL) plus the pending carry at limb J + 1 decreases by
      --  exactly A * 256**J.
      procedure Lemma_Carry (Old_XL, New_XL      : in XL_Table;
                             J                   : in Index_64;
                             C_Old, C_New, A     : in I64)
        with Ghost => SPARKlib_Logic,
             Pre   => (for all K in Index_64 =>
                         (if K /= J then Old_XL (K) = New_XL (K))) and
                      To_Big (New_XL (J)) =
                        To_Big (Old_XL (J)) + To_Big (C_Old) - To_Big (A) -
                        To_Big (256) * To_Big (C_New),
             Post  => V (New_XL) + To_Big (C_New) * P (J + 1) =
                        V (Old_XL) + To_Big (C_Old) * P (J) -
                        To_Big (A) * P (J);

      procedure Initialize_XL
        with Global => (Input  => X,
                        Output => XL),
             Pre  => (for all K in Index_64 => X (K) in 0 .. Max_X_Limb),
             Post =>
               (SPARKNaCl_Contracts =>
                  (for all K in Index_64 => XL (K) >= 0) and
                  (for all K in Index_64 => XL (K) <= Max_X_Limb) and
                  (for all K in Index_64 => XL (K) = XL_Limb (X (K))),
                SPARKlib_Logic =>
                  V (XL) = Value (X));

      procedure Eliminate_Limb_63
        with Global => (Proof_In => X,
                        In_Out   => XL),
             Pre  => (for all K in Index_64 =>
                        X (K) in 0 .. Max_X_Limb) and then
                     (for all K in Index_64 => XL (K) >= 0) and then
                     (for all K in Index_64 => XL (K) <= Max_X_Limb) and then
                     (for all K in Index_64 => XL (K) = XL_Limb (X (K))),
             --  Functionally, eliminating limb 63 subtracts
             --  XL (63) * 16 * L * 256**31
             Post =>
               (SPARKNaCl_Contracts =>
                  (for all K in Index_64 range 0 .. 30 =>
                     XL (K) = X (K)) and
                  (for all K in Index_64 range 31 .. 50 =>
                     XL (K) in FRL) and
                  (XL (51) in XL51_T) and
                  (for all K in Index_64 range 52 .. 62 =>
                     XL (K) = X (K)) and
                  (XL (63) = 0),
                SPARKlib_Logic =>
                  V (XL) = V (XL'Old) -
                    To_Big (XL'Old (63)) * To_Big (16) * L_Big * P (31));

      procedure Eliminate_Limbs_62_To_32
        with Global => (Proof_In => X,
                        In_Out   => XL),
             Pre  => ((for all K in Index_64 range 0 .. 30 =>
                         XL (K) = X (K) and
                         XL (K) in 0 .. Max_X_Limb) and
                      (for all K in Index_64 range 31 .. 50 =>
                         XL (K) in FRL) and
                      (XL (51) in XL51_T) and
                      (for all K in Index_64 range 52 .. 62 =>
                         XL (K) = X (K) and
                         XL (K) in 0 .. Max_X_Limb) and
                      (XL (63) = 0)),
             --  Functionally, each limb eliminated subtracts a multiple
             --  of L, so the value of XL modulo L is unchanged
             Post =>
               (SPARKNaCl_Contracts =>
                  (for all K in Index_64 range  0 .. 19 =>
                     XL (K) in FRL) and
                  (for all K in Index_64 range 20 .. 31 =>
                     XL (K) in PRL) and
                  (for all K in Index_64 range 32 .. 63 => XL (K) = 0),
                SPARKlib_Logic =>
                  V (XL) mod L_Big = V (XL'Old) mod L_Big);

      procedure Finalize
        with Global => (In_Out => XL,
                        Output => R),
             Pre  => ((for all K in Index_64 range  0 .. 19 =>
                         XL (K) in FRL) and
                      (for all K in Index_64 range 20 .. 31 =>
                         XL (K) in PRL) and
                      (for all K in Index_64 range 32 .. 63 => XL (K) = 0)),
             --  Functionally, R is XL'Old fully reduced modulo L
             Post =>
               (SPARKNaCl_Contracts =>
                  R'Initialized,
                SPARKlib_Logic =>
                  R'Initialized and then Value (R) = V (XL'Old) mod L_Big);

      function XL_Big (A : in XL_Table) return Big_Arr
      is
         Result : Big_Arr := (others => To_Big (0));
      begin
         for K in Index_64 loop
            Result (K) := To_Big (A (K));
            pragma Loop_Invariant
              (for all J in Index_64 range 0 .. K =>
                 Result (J) = To_Big (A (J)));
         end loop;
         return Result;
      end XL_Big;

      procedure Lemma_XL_Update (Old_XL, New_XL : in XL_Table;
                                 J              : in Index_64)
      is
      begin
         Lemma_Value_Update (XL_Big (Old_XL), XL_Big (New_XL), J, 64);
      end Lemma_XL_Update;

      procedure Lemma_Carry (Old_XL, New_XL      : in XL_Table;
                             J                   : in Index_64;
                             C_Old, C_New, A     : in I64)
      is
      begin
         Lemma_XL_Update (Old_XL, New_XL, J);
         Lemma_Carry_Step (V_Old => V (Old_XL),
                           V_New => V (New_XL),
                           X_Old => To_Big (Old_XL (J)),
                           X_New => To_Big (New_XL (J)),
                           C_Old => To_Big (C_Old),
                           C_New => To_Big (C_New),
                           A     => To_Big (A),
                           J     => J);
      end Lemma_Carry;

      procedure Initialize_XL
      is
      begin
         XL := (others => 0);
         for K in Index_64 loop
            pragma Loop_Optimize (No_Unroll);
            XL (K) := XL_Limb (X (K));
            pragma Loop_Invariant
              (for all A in Index_64 range 0 .. K => XL (A) = XL_Limb (X (A)));
         end loop;

         Lemma_Value_Prefix (XL_Big (XL), To_Big_Arr (X), 64);
      end Initialize_XL;

      procedure Eliminate_Limb_63
      is
         Max_L63_Adjustment : constant := 16 * Max_L * Max_X_Limb;
         subtype L63_Adjustment_T is I64 range 0 .. Max_L63_Adjustment;

         --  The most negative value of Carry is when XL (63) = Max_X_Limb and
         --  L (J - 31) = Max_L and XL (J) = 0
         --  so that
         --   Min_L63_Carry =
         --     ASR_8 (0 + Min_L63_Carry - Max_L63_Adjustment + 128)
         Min_L63_Carry : constant := ((128 - Max_L63_Adjustment) / 255) - 1;
         subtype L63_Carry_T is I64 range Min_L63_Carry .. Max_L63_Carry;

         Carry      : L63_Carry_T;
         Adjustment : L63_Adjustment_T;
         XL63       : constant XL_Limb := XL (63);

         --------------------------------------------------------------
         --  Ghost state and lemmas for the functional correctness proof
         --------------------------------------------------------------

         V0     : constant Big_Integer := V (XL)
           with Ghost => SPARKlib_Logic;

         --  XL and Carry before each step, and the carry out of each of
         --  the unrolled steps on limbs 47 .. 50
         XL_Pre                   : XL_Table
           with Ghost => SPARKlib_Logic;
         C_Pre                    : L63_Carry_T
           with Ghost => SPARKlib_Logic;
         C47, C48, C49, C50       : L63_Carry_T
           with Ghost => SPARKlib_Logic;

         --  Invariant of the main loop below, after processing limb J:
         --  V (A) plus the pending carry C at limb J + 1 equals V0 minus
         --  16 * X63 * (limbs 0 .. J - 31 of L) * 256**31.
         --
         --  The body is hidden from proof, except in the lemmas below,
         --  so that the Big_Integer arithmetic does not appear in the
         --  verification conditions for the type-safety of the code.
         function Inv (A   : in XL_Table;
                       C   : in L63_Carry_T;
                       J   : in Index_64) return Boolean
         is (V (A) + To_Big (C) * P (J + 1) =
               V0 - To_Big (16) * To_Big (XL63) * LP (31, J - 30))
           with Ghost    => SPARKlib_Logic,
                Global   => (V0, XL63),
                Pre      => J in 30 .. 46,
                Annotate => (GNATprove, Hide_Info, "Expression_Function_Body");

         procedure Lemma_Inv_Init
           with Ghost => SPARKlib_Logic,
                Global => (Proof_In => (XL, V0, XL63)),
                Pre   => V (XL) = V0,
                Post  => Inv (XL, 0, 30);

         --  One iteration of the main loop preserves Inv
         procedure Lemma_Inv_Step (Old_XL, New_XL : in XL_Table;
                                   J              : in Index_64;
                                   C_Old, C_New   : in L63_Carry_T;
                                   Adj            : in L63_Adjustment_T)
           with Ghost => SPARKlib_Logic,
                Global => (Input => (V0, XL63)),
                Pre   => J in 31 .. 46 and then
                         Inv (Old_XL, C_Old, J - 1) and then
                         (for all K in Index_64 =>
                            (if K /= J then Old_XL (K) = New_XL (K))) and then
                         Adj = L16 (J - 31) * XL63 and then
                         New_XL (J) = Old_XL (J) + C_Old - Adj - C_New * 256,
                Post  => Inv (New_XL, C_New, J);

         --  The unrolled steps on limbs 47 .. 50, the final carry into
         --  limb 51, and zeroing limb 63 complete the subtraction of
         --  XL63 * 16 * L * 256**31.
         procedure Lemma_Tail (Old_XL, New_XL     : in XL_Table;
                               C0, C1, C2, C3, C4 : in L63_Carry_T)
           with Ghost => SPARKlib_Logic,
                Global => (Proof_In => (V0, XL63)),
                Pre   =>
                  Inv (Old_XL, C0, 46) and then
                  Old_XL (63) = XL63 and then
                  (for all K in Index_64 =>
                     (if K not in 47 .. 51 and K /= 63 then
                        Old_XL (K) = New_XL (K))) and then
                  New_XL (47) = Old_XL (47) + C0 - C1 * 256 and then
                  New_XL (48) = Old_XL (48) + C1 - C2 * 256 and then
                  New_XL (49) = Old_XL (49) + C2 - C3 * 256 and then
                  New_XL (50) = Old_XL (50) + C3 - C4 * 256 and then
                  New_XL (51) = Old_XL (51) + C4 and then
                  New_XL (63) = 0,
                Post  =>
                  V (New_XL) =
                    V0 - To_Big (XL63) * To_Big (16) * L_Big * P (31);

         procedure Lemma_Inv_Init
         is
            pragma Annotate (GNATprove, Unhide_Info,
                             "Expression_Function_Body", Inv);
         begin
            Lemma_LP_Zero (31);
         end Lemma_Inv_Init;

         procedure Lemma_Inv_Step (Old_XL, New_XL : in XL_Table;
                                   J              : in Index_64;
                                   C_Old, C_New   : in L63_Carry_T;
                                   Adj            : in L63_Adjustment_T)
         is
            pragma Annotate (GNATprove, Unhide_Info,
                             "Expression_Function_Body", Inv);
         begin
            Lemma_L_Tables;
            pragma Assert
              (To_Big (L16 (J - 31)) = To_Big (16) * L_Arr (J - 31));
            pragma Assert
              (To_Big (Adj) = To_Big (L16 (J - 31)) * To_Big (XL63));
            pragma Assert
              (To_Big (Adj) = (To_Big (16) * L_Arr (J - 31)) * To_Big (XL63));
            Lemma_Carry (Old_XL, New_XL, J, C_Old, C_New, Adj);
            Lemma_Adjust (S   => V0,
                          X   => To_Big (XL63),
                          LPT => LP (31, J - 31),
                          LT  => L_Arr (J - 31),
                          PJ  => P (J));
            Lemma_LP_Succ (31, J - 31);
         end Lemma_Inv_Step;

         procedure Lemma_Tail (Old_XL, New_XL     : in XL_Table;
                               C0, C1, C2, C3, C4 : in L63_Carry_T)
         is
            pragma Annotate (GNATprove, Unhide_Info,
                             "Expression_Function_Body", Inv);
            T1, T2, T3, T4, T5 : XL_Table;
         begin
            T1 := Old_XL;
            T1 (47) := New_XL (47);
            Lemma_Carry (Old_XL, T1, 47, C0, C1, 0);
            T2 := T1;
            T2 (48) := New_XL (48);
            Lemma_Carry (T1, T2, 48, C1, C2, 0);
            T3 := T2;
            T3 (49) := New_XL (49);
            Lemma_Carry (T2, T3, 49, C2, C3, 0);
            T4 := T3;
            T4 (50) := New_XL (50);
            Lemma_Carry (T3, T4, 50, C3, C4, 0);
            T5 := T4;
            T5 (51) := New_XL (51);
            Lemma_Carry (T4, T5, 51, C4, 0, 0);
            pragma Assert
              (V (T5) = V0 - To_Big (16) * To_Big (XL63) * LP (31, 16));
            pragma Assert (for all K in Index_64 =>
                             (if K /= 63 then T5 (K) = New_XL (K)));
            Lemma_XL_Update (T5, New_XL, 63);
            pragma Assert
              (V (New_XL) =
                 V0 - To_Big (16) * To_Big (XL63) * LP (31, 16) -
                      To_Big (XL63) * P (63));
            pragma Assert
              (V (New_XL) =
                 V0 - To_Big (XL63) * (To_Big (16) * LP (31, 16) + P (63)));
            Lemma_Elim (31);
         end Lemma_Tail;
      begin
         Carry := 0;
         Lemma_Inv_Init;

         --  In the TweetNaCl sources, this loop interates 20 times
         --  covering elements of L from L (0) to L (19).
         --  In this implementation, though, we choose to loop over the
         --  first 16 elements of L first, since these are all non-zero,
         --  and manually unroll the final 4 iterations where L (16)
         --  through L (19) are all zero.
         for J in I32 range 31 .. 46 loop
            pragma Loop_Optimize (No_Unroll);
            declare
               XLJ : XL_Limb renames XL (J);
               L16_Factor : constant L16_Limb := L16 (J - 31);
            begin
               pragma Assert (L16_Factor >= 288);  -- 16#120#
               pragma Assert (L16_Factor <= 3984); -- 16#f90#
               pragma Assert (XL63 >= 0);
               pragma Assert (XL63 <= XL_Limb'Last);
               pragma Assert (L16_Factor * XL63 <= 3984 * XL_Limb'Last);
               Adjustment := L16_Factor * XL63;
               XL_Pre := XL;
               C_Pre  := Carry;
               XLJ := XLJ + Carry - Adjustment;
               Carry := ASR_8 (XLJ + 128);
               XLJ := XLJ - (Carry * 256);
               Lemma_Inv_Step (XL_Pre, XL, J, C_Pre, Carry, Adjustment);
            end;

            pragma Loop_Invariant (XL63 >= 0);
            pragma Loop_Invariant (XL63 <= XL_Limb'Last);
            pragma Loop_Invariant
              ((for all K in Index_64 range 0 .. 30 =>
                  XL (K) = XL'Loop_Entry (K)) and
               (for all K in Index_64 range 31 .. J =>
                  XL (K) in FRL) and
               (for all K in Index_64 range J + 1 .. 63 =>
                  XL (K) = XL'Loop_Entry (K)));
            pragma Loop_Invariant (SPARKlib_Logic => Inv (XL, Carry, J));
         end loop;

         pragma Assert
           ((for all K in Index_64 range 0 .. 30 =>
               XL (K) = X (K)) and
            (for all K in Index_64 range 31 .. 46 =>
               XL (K) in FRL) and
            (for all K in Index_64 range 47 .. 63 =>
               XL (K) = X (K)));

         XL_Pre := XL;
         C_Pre  := Carry;

         --  Final 4 limbs of XL (47) through XL (50)
         --  For these limbs, we know that L (16) through L (19)
         --  is zero, so the calculation of Adjustment can be eliminated.
         --
         --  As these final four limbs are processed, the upper bound
         --  on Carry stays the same at Max_L63_Carry, but the lower bound
         --  converges towards 0.
         declare
            --  Expand the definition of ASR_8 for values gives...
            Min_XL47_Carry : constant :=
              ((Min_L63_Carry + 128 + 1) / 2**8) - 1;
            pragma Assert (Min_XL47_Carry = -127006);
            Min_XL48_Carry : constant :=
              ((Min_XL47_Carry + 128 + 1) / 2**8) - 1;
            pragma Assert (Min_XL48_Carry = -496);
            Min_XL49_Carry : constant :=
              ((Min_XL48_Carry + 128 + 1) / 2**8) - 1;
            pragma Assert (Min_XL49_Carry = -2);
            Min_XL50_Carry : constant := ((Min_XL49_Carry + 128) / 2**8);
            pragma Assert (Min_XL50_Carry = 0);
         begin
            XL (47) := XL (47) + Carry;
            Carry := ASR_8 (XL (47) + 128);
            XL (47) := XL (47) - (Carry * 256);
            C47 := Carry;

            pragma Assert (Carry >= Min_XL47_Carry);

            XL (48) := XL (48) + Carry;
            Carry := ASR_8 (XL (48) + 128);
            XL (48) := XL (48) - (Carry * 256);
            C48 := Carry;

            pragma Assert (Carry >= Min_XL48_Carry);

            XL (49) := XL (49) + Carry;
            Carry := ASR_8 (XL (49) + 128);
            XL (49) := XL (49) - (Carry * 256);
            C49 := Carry;

            pragma Assert (Carry >= Min_XL49_Carry);

            XL (50) := XL (50) + Carry;
            Carry := ASR_8 (XL (50) + 128);
            XL (50) := XL (50) - (Carry * 256);
            C50 := Carry;

            --  Lower bound on Carry should have converged to 0
            pragma Assert (Min_XL50_Carry = 0);
            pragma Assert (Carry >= Min_XL50_Carry);
         end;

         pragma Assert
           ((for all K in Index_64 range  0 .. 30 => XL (K) = X (K)) and
            (for all K in Index_64 range 31 .. 50 => XL (K) in FRL) and
            (for all K in Index_64 range 51 .. 63 => XL (K) = X (K)));

         --  Note XL (51) is adjusted here but is NOT normalized
         --  to be in FRL... hence it's a special case in the post-
         --  condition above.
         XL (51) := XL (51) + Carry;
         pragma Assert (XL (51) in XL51_T);
         XL (63) := 0;

         Lemma_Tail (XL_Pre, XL, C_Pre, C47, C48, C49, C50);
      end Eliminate_Limb_63;

      procedure Eliminate_Limbs_62_To_32
      is
         Carry      : Carry_T;
         Adjustment : Adjustment_T;
         XLI        : XL_Limb;

         --------------------------------------------------------------
         --  Ghost state and lemmas for the functional correctness proof
         --------------------------------------------------------------

         V0       : constant Big_Integer := V (XL)
           with Ghost => SPARKlib_Logic;

         --  XL at the start of each iteration of the outer loop, XL and
         --  Carry before each step, and the carry out of each of the
         --  unrolled steps on limbs I - 16 .. I - 13
         XL_Start : XL_Table
           with Ghost => SPARKlib_Logic;
         XL_Pre   : XL_Table
           with Ghost => SPARKlib_Logic;
         C_Pre    : Carry_T
           with Ghost => SPARKlib_Logic;
         C16, C15, C14, C13 : Carry_T
           with Ghost => SPARKlib_Logic;

         --  Invariant of the outer loop: XL is congruent to its value on
         --  entry, modulo L. Body hidden from proof except in the lemmas.
         function OInv (A : in XL_Table) return Boolean
         is (V (A) mod L_Big = V0 mod L_Big)
           with Ghost    => SPARKlib_Logic,
                Global   => V0,
                Annotate => (GNATprove, Hide_Info, "Expression_Function_Body");

         --  Invariant of the inner loop, after processing limb J while
         --  eliminating limb I (with value XI): V (A) plus the pending
         --  carry C at limb J + 1 is V (S) minus
         --  16 * XI * (limbs 0 .. J - I + 32 of L) * 256**(I - 32),
         --  where S is XL at the start of the outer iteration.
         function Inv (A  : in XL_Table;
                       C  : in Carry_T;
                       S  : in XL_Table;
                       I  : in Index_64;
                       J  : in I32;
                       XI : in XL_Limb) return Boolean
         is (V (A) + To_Big (C) * P (J + 1) =
               V (S) - To_Big (16) * To_Big (XI) * LP (I - 32, J - I + 33))
           with Ghost    => SPARKlib_Logic,
                Pre      => I in 32 .. 62 and J in I - 33 .. I - 17,
                Annotate => (GNATprove, Hide_Info, "Expression_Function_Body");

         procedure Lemma_OInv_Init
           with Ghost => SPARKlib_Logic,
                Global => (Proof_In => (XL, V0)),
                Pre   => V (XL) = V0,
                Post  => OInv (XL);

         procedure Lemma_OInv_Final (A : in XL_Table)
           with Ghost => SPARKlib_Logic,
                Global => (Proof_In => V0),
                Pre   => OInv (A),
                Post  => V (A) mod L_Big = V0 mod L_Big;

         procedure Lemma_Inv_Init (S  : in XL_Table;
                                   I  : in Index_64;
                                   XI : in XL_Limb)
           with Ghost => SPARKlib_Logic,
                Pre   => I in 32 .. 62,
                Post  => Inv (S, 0, S, I, I - 33, XI);

         --  One iteration of the inner loop preserves Inv
         procedure Lemma_Inv_Step (Old_XL, New_XL : in XL_Table;
                                   S              : in XL_Table;
                                   I, J           : in Index_64;
                                   XI             : in XL_Limb;
                                   C_Old, C_New   : in Carry_T;
                                   Adj            : in Adjustment_T)
           with Ghost => SPARKlib_Logic,
                Pre   => I in 32 .. 62 and then
                         J in I - 32 .. I - 17 and then
                         Inv (Old_XL, C_Old, S, I, J - 1, XI) and then
                         (for all K in Index_64 =>
                            (if K /= J then Old_XL (K) = New_XL (K))) and then
                         Adj = L16 (J - (I - 32)) * XI and then
                         New_XL (J) = Old_XL (J) + C_Old - Adj - C_New * 256,
                Post  => Inv (New_XL, C_New, S, I, J, XI);

         --  The unrolled steps on limbs I - 16 .. I - 13, the final carry
         --  into limb I - 12 and zeroing limb I complete the subtraction
         --  of XI * 16 * L * 256**(I - 32), which preserves OInv.
         procedure Lemma_Tail (Old_XL, New_XL     : in XL_Table;
                               S                  : in XL_Table;
                               I                  : in Index_64;
                               XI                 : in XL_Limb;
                               C0, C1, C2, C3, C4 : in Carry_T)
           with Ghost => SPARKlib_Logic,
                Global => (Proof_In => V0),
                Pre   =>
                  I in 32 .. 62 and then
                  OInv (S) and then
                  Inv (Old_XL, C0, S, I, I - 17, XI) and then
                  Old_XL (I) = XI and then
                  (for all K in Index_64 =>
                     (if K not in I - 16 .. I - 12 and K /= I then
                        Old_XL (K) = New_XL (K))) and then
                  New_XL (I - 16) = Old_XL (I - 16) + C0 - C1 * 256 and then
                  New_XL (I - 15) = Old_XL (I - 15) + C1 - C2 * 256 and then
                  New_XL (I - 14) = Old_XL (I - 14) + C2 - C3 * 256 and then
                  New_XL (I - 13) = Old_XL (I - 13) + C3 - C4 * 256 and then
                  New_XL (I - 12) = Old_XL (I - 12) + C4 and then
                  New_XL (I) = 0,
                Post  => OInv (New_XL);

         procedure Lemma_OInv_Init
         is
            pragma Annotate (GNATprove, Unhide_Info,
                             "Expression_Function_Body", OInv);
         begin
            null;
         end Lemma_OInv_Init;

         procedure Lemma_OInv_Final (A : in XL_Table)
         is
            pragma Annotate (GNATprove, Unhide_Info,
                             "Expression_Function_Body", OInv);
         begin
            null;
         end Lemma_OInv_Final;

         procedure Lemma_Inv_Init (S  : in XL_Table;
                                   I  : in Index_64;
                                   XI : in XL_Limb)
         is
            pragma Annotate (GNATprove, Unhide_Info,
                             "Expression_Function_Body", Inv);
            pragma Unreferenced (S, XI);
         begin
            Lemma_LP_Zero (I - 32);
         end Lemma_Inv_Init;

         procedure Lemma_Inv_Step (Old_XL, New_XL : in XL_Table;
                                   S              : in XL_Table;
                                   I, J           : in Index_64;
                                   XI             : in XL_Limb;
                                   C_Old, C_New   : in Carry_T;
                                   Adj            : in Adjustment_T)
         is
            pragma Annotate (GNATprove, Unhide_Info,
                             "Expression_Function_Body", Inv);
            T : constant Index_16 := J - (I - 32);
         begin
            Lemma_L_Tables;
            pragma Assert (To_Big (L16 (T)) = To_Big (16) * L_Arr (T));
            pragma Assert (To_Big (Adj) = To_Big (L16 (T)) * To_Big (XI));
            pragma Assert
              (To_Big (Adj) = (To_Big (16) * L_Arr (T)) * To_Big (XI));
            Lemma_Carry (Old_XL, New_XL, J, C_Old, C_New, Adj);
            Lemma_Adjust (S   => V (S),
                          X   => To_Big (XI),
                          LPT => LP (I - 32, T),
                          LT  => L_Arr (T),
                          PJ  => P (J));
            Lemma_LP_Succ (I - 32, T);
         end Lemma_Inv_Step;

         procedure Lemma_Tail (Old_XL, New_XL     : in XL_Table;
                               S                  : in XL_Table;
                               I                  : in Index_64;
                               XI                 : in XL_Limb;
                               C0, C1, C2, C3, C4 : in Carry_T)
         is
            pragma Annotate (GNATprove, Unhide_Info,
                             "Expression_Function_Body", Inv);
            pragma Annotate (GNATprove, Unhide_Info,
                             "Expression_Function_Body", OInv);
            T1, T2, T3, T4, T5 : XL_Table;
         begin
            T1 := Old_XL;
            T1 (I - 16) := New_XL (I - 16);
            Lemma_Carry (Old_XL, T1, I - 16, C0, C1, 0);
            T2 := T1;
            T2 (I - 15) := New_XL (I - 15);
            Lemma_Carry (T1, T2, I - 15, C1, C2, 0);
            T3 := T2;
            T3 (I - 14) := New_XL (I - 14);
            Lemma_Carry (T2, T3, I - 14, C2, C3, 0);
            T4 := T3;
            T4 (I - 13) := New_XL (I - 13);
            Lemma_Carry (T3, T4, I - 13, C3, C4, 0);
            T5 := T4;
            T5 (I - 12) := New_XL (I - 12);
            Lemma_Carry (T4, T5, I - 12, C4, 0, 0);
            pragma Assert
              (V (T5) =
                 V (S) - To_Big (16) * To_Big (XI) * LP (I - 32, 16));
            pragma Assert (T5 (I) = XI);
            pragma Assert (for all K in Index_64 =>
                             (if K /= I then T5 (K) = New_XL (K)));
            Lemma_XL_Update (T5, New_XL, I);
            pragma Assert
              (V (New_XL) =
                 V (S) - To_Big (16) * To_Big (XI) * LP (I - 32, 16) -
                         To_Big (XI) * P (I));
            pragma Assert
              (V (New_XL) =
                 V (S) - To_Big (XI) *
                           (To_Big (16) * LP (I - 32, 16) + P (I)));
            Lemma_Elim (I - 32);
            pragma Assert
              (V (New_XL) =
                 V (S) - (To_Big (XI) * To_Big (16) * P (I - 32)) * L_Big);
            Lemma_Mod_Sub_Multiple
              (V (S), To_Big (XI) * To_Big (16) * P (I - 32));
         end Lemma_Tail;

         --  The unrolled steps on limbs I - 16 .. I - 12 and zeroing limb I
         --  leave limbs I - 11 .. Min (50, I - 1) in PRL and limbs
         --  I + 1 .. 63 zero. Stated as a lemma to keep this simple frame
         --  argument out of the large context at the end of the outer loop.
         procedure Lemma_Frame (Old_XL, New_XL : in XL_Table;
                                I              : in Index_64)
           with Ghost => SPARKlib_Logic,
                Pre   =>
                  I in 32 .. 62 and then
                  (for all K in Index_64 =>
                     (if K not in I - 16 .. I - 12 and K /= I then
                        Old_XL (K) = New_XL (K))) and then
                  (for all K in Index_64 range I - 11 .. I32'Min (50, I - 1) =>
                     Old_XL (K) in PRL) and then
                  (for all K in Index_64 range I + 1 .. 63 =>
                     Old_XL (K) = 0) and then
                  New_XL (I) = 0,
                Post  =>
                  (for all K in Index_64 range I - 11 .. I32'Min (50, I - 1) =>
                     New_XL (K) in PRL) and
                  (for all K in Index_64 range I .. 63 => New_XL (K) = 0);

         procedure Lemma_Frame (Old_XL, New_XL : in XL_Table;
                                I              : in Index_64)
         is null;

         --  The outer loop invariant that every limb is in
         --  PRL'First .. XL51_T'Last. S is XL at the start of the
         --  iteration, Mid is XL after the inner loop (which changes only
         --  limbs I - 32 .. I - 17) and New_XL is XL at the end (the
         --  unrolled steps change only limbs I - 16 .. I - 12 and I).
         --  Stated as a lemma because, inline, this check is close to the
         --  prover time limit and fails when the machine is busy.
         procedure Lemma_Range (S, Mid, New_XL : in XL_Table;
                                I              : in Index_64)
           with Ghost => SPARKlib_Logic,
                Pre   =>
                  I in 32 .. 62 and then
                  (for all K in Index_64 =>
                     S (K) in PRL'First .. XL51_T'Last) and then
                  (for all K in Index_64 =>
                     (if K not in I - 32 .. I - 17 then Mid (K) = S (K)))
                  and then
                  (for all K in Index_64 =>
                     (if K not in I - 16 .. I - 12 and K /= I then
                        New_XL (K) = Mid (K))) and then
                  (for all K in Index_64 range I - 32 .. I - 12 =>
                     New_XL (K) in PRL) and then
                  New_XL (I) = 0,
                Post  =>
                  (for all K in Index_64 =>
                     New_XL (K) in PRL'First .. XL51_T'Last);

         procedure Lemma_Range (S, Mid, New_XL : in XL_Table;
                                I              : in Index_64)
         is null;
      begin
         Lemma_OInv_Init;
         for I in reverse I32 range 32 .. 62 loop
            pragma Loop_Optimize (No_Unroll);
            XL_Start := XL;
            Carry := 0;
            --  As above, this loop iterates over limbs 0 .. 15 of L
            --  leaving the final four (zero) limbs unrolled below.
            XLI := XL (I);
            pragma Assert (XLI in PRL'First .. XL51_T'Last);
            pragma Assert (XL (I - 12) in FRL);
            Lemma_Inv_Init (XL_Start, I, XLI);
            for J in I32 range (I - 32) .. (I - 17) loop
               pragma Loop_Optimize (No_Unroll);

               declare
                  --  Rename XL (J) here so can be used as both a L- and an
                  --  R-Value below. Note also that I /= J here, so XLI and XLJ
                  --  cannot denote the same element of XL.
                  XLJ : XL_Limb renames XL (J);
               begin
                  Adjustment := (L16 (J - (I - 32))) * XLI;
                  --  XLI may be negative, but no less than PRL'First, which
                  --  bounds Adjustment from below, and so bounds the new
                  --  value of XLJ and Carry from above
                  pragma Assert (if XLI >= 0 then Adjustment >= 0);
                  pragma Assert (Adjustment >= 16 * Max_L * PRL'First);
                  XL_Pre := XL;
                  C_Pre  := Carry;
                  XLJ := XLJ + Carry - Adjustment;
                  pragma Assert
                    (XLJ <= XL51_T'Last + Max_Carry - 16 * Max_L * PRL'First);
                  Carry := ASR_8 (XLJ + 128);
                  XLJ := XLJ - (Carry * 256);
                  --  Rounding to the nearest multiple of 256 leaves the
                  --  limb fully reduced. Asserted here, where the context is
                  --  small, to keep the loop invariant below quick to prove.
                  pragma Assert (XLJ in FRL);
                  Lemma_Inv_Step (XL_Pre, XL, XL_Start, I, J, XLI,
                                  C_Pre, Carry, Adjustment);
               end;

               pragma Loop_Invariant
                 (for all K in Index_64 range 0 .. I - 33 =>
                    XL (K) = XL'Loop_Entry (K));
               pragma Loop_Invariant
                 (for all K in Index_64 range I - 32 .. J =>
                    XL (K) in FRL);
               pragma Loop_Invariant
                 (for all K in Index_64 range J + 1 .. I32'Min (50, I - 1) =>
                    XL (K) = XL'Loop_Entry (K));
               pragma Loop_Invariant
                 (for all K in Index_64 range J + 1 .. I32'Min (50, I - 1) =>
                    XL (K) in PRL);
               pragma Loop_Invariant
                 (for all K in Index_64 range I32'Max (I - 11, 52) .. I - 1 =>
                    XL (K) = XL'Loop_Entry (K));
               pragma Loop_Invariant
                 (for all K in Index_64 range I + 1 .. 63 => XL (K) = 0);
               pragma Loop_Invariant
                 (for all K in Index_64 => XL (K) in PRL'First .. XL51_T'Last);
               pragma Loop_Invariant (SPARKlib_Logic => XL (I) = XLI);
               --  Only limbs I - 32 .. J have changed since the start of
               --  this iteration of the outer loop
               pragma Loop_Invariant
                 (SPARKlib_Logic =>
                    (for all K in Index_64 =>
                       (if K not in I - 32 .. J then XL (K) = XL_Start (K))));
               pragma Loop_Invariant (XL (I - 12) in FRL);
               pragma Loop_Invariant
                 (SPARKlib_Logic => Inv (XL, Carry, XL_Start, I, J, XLI));
            end loop;

            XL_Pre := XL;
            C_Pre  := Carry;
            pragma Assert
              (SPARKlib_Logic =>
                 (for all K in Index_64 range I - 11 .. I32'Min (50, I - 1) =>
                    XL_Pre (K) in PRL) and
                 (for all K in Index_64 range I + 1 .. 63 =>
                    XL_Pre (K) = 0));

            --  16 elements of XL(I-32) .. XL(I-17) are in now FRL
            pragma Assert
              (for all K in Index_64 range I - 32 .. I - 17 =>
                 XL (K) in FRL);

            pragma Assert (XL (I - 16) in FRL);
            --  Carry is in Carry_T here
            XL (I - 16) := XL (I - 16) + Carry;
            Carry := ASR_8 (XL (I - 16) + 128);
            XL (I - 16) := XL (I - 16) - (Carry * 256);
            C16 := Carry;

            --  17 elements of XL are in FRL
            pragma Assert
              (for all K in Index_64 range I - 32 .. I - 16 =>
                 XL (K) in FRL);

            pragma Assert (XL (I - 15) in FRL);
            --  Now we can start to prove that Carry is converging.
            --  Each further reduction reduces the lower and upper bound
            --  of Carry by about 2**8, except that the addition of 128 and
            --  ASR_8 actually mean that Carry converges on the range -1 .. 1
            pragma Assert (Carry in -2**17 .. 64);
            XL (I - 15) := XL (I - 15) + Carry;
            Carry := ASR_8 (XL (I - 15) + 128);
            XL (I - 15) := XL (I - 15) - (Carry * 256);
            C15 := Carry;

            --  18 elements of XL are in FRL
            pragma Assert
              (for all K in Index_64 range I - 32 .. I - 15 =>
                 XL (K) in FRL);

            pragma Assert (XL (I - 14) in FRL);
            pragma Assert (Carry in -512 .. 1);
            XL (I - 14) := XL (I - 14) + Carry;
            Carry := ASR_8 (XL (I - 14) + 128);
            XL (I - 14) := XL (I - 14) - (Carry * 256);
            C14 := Carry;

            --  19 elements of XL are in FRL
            pragma Assert
              (for all K in Index_64 range I - 32 .. I - 14 =>
                 XL (K) in FRL);

            pragma Assert (XL (I - 13) in FRL);
            pragma Assert (Carry in -2 .. 1);
            XL (I - 13) := XL (I - 13) + Carry;
            Carry := ASR_8 (XL (I - 13) + 128);
            XL (I - 13) := XL (I - 13) - (Carry * 256);
            C13 := Carry;

            --  20 elements of XL are in FRL
            pragma Assert
              (for all K in Index_64 range I - 32 .. I - 13 =>
                 XL (K) in FRL);

            pragma Assert (XL (I - 12) in FRL);
            pragma Assert (Carry in -1 .. 1);

            --  If Carry in -1 .. 1, then the final adjustment of
            --  XL (I - 12) means that this limb can end up being
            --  -129 or +128, so in PRL but not in FRL
            XL (I - 12) := XL (I - 12) + Carry;
            pragma Assert (XL (I - 12) in PRL);

            --  XL (I) is now eliminated, so it gets zeroed out now.
            XL (I) := 0;

            Lemma_Tail (XL_Pre, XL, XL_Start, I, XLI,
                        C_Pre, C16, C15, C14, C13);
            Lemma_Frame (XL_Pre, XL, I);
            Lemma_Range (XL_Start, XL_Pre, XL, I);

            pragma Loop_Invariant
              (for all K in Index_64 range 0 .. I - 33 =>
                 XL (K) = XL'Loop_Entry (K));

            pragma Loop_Invariant
              (for all K in Index_64 range I - 32 .. I - 13 =>
                 XL (K) in FRL);
            pragma Loop_Invariant
              (XL (I - 12) in PRL);
            pragma Loop_Invariant
              (for all K in Index_64 range I - 11 .. I32'Min (50, I - 1) =>
                 XL (K) in PRL);

            --  This is XL (51) for I in 52 .. 63
            pragma Loop_Invariant
              (if I >= 52 then
              XL (51) >= XL'Loop_Entry (51) + Min_Carry);
            pragma Loop_Invariant
              (if I >= 52 then
              XL (51) <= XL'Loop_Entry (51) + Max_Carry);

            pragma Loop_Invariant
              (for all K in Index_64 range I32'Max (I - 11, 52) .. I - 1 =>
                 XL (K) = XL'Loop_Entry (K));
            pragma Loop_Invariant
              (for all K in Index_64 range I .. 63 => XL (K) = 0);
            pragma Loop_Invariant
              (for all K in Index_64 => XL (K) in PRL'First .. XL51_T'Last);
            pragma Loop_Invariant (SPARKlib_Logic => OInv (XL));
         end loop;

         Lemma_OInv_Final (XL);
      end Eliminate_Limbs_62_To_32;

      procedure Finalize
      is
         Final_Carry_Min : constant := -9;
         Final_Carry_Max : constant := 9;

         subtype Final_Carry_T is I64 range Final_Carry_Min .. Final_Carry_Max;

         subtype Step1_XL_Limb is I64 range
           (Final_Carry_Min * 256) ..
           ((Final_Carry_Max + 1) * 256) - 1;

         subtype Step2_XL_Limb is I64 range
           I64_Byte'First - (Final_Carry_Max * Max_L) ..
           I64_Byte'Last  - (Final_Carry_Min * Max_L);

         Carry : Final_Carry_T;

         --------------------------------------------------------------
         --  Ghost state and lemmas for the functional correctness proof
         --
         --  Step 1 subtracts Q * L, where Q = XL (31) / 16 on entry,
         --  leaving limbs 0 .. 31 in 0 .. 255 and a carry C1 (-1 or 0)
         --  out of limb 31. Step 2 subtracts C1 * L. Step 3 propagates
         --  carries into R. Lemma_Final_Reduce shows that the result is
         --  V (XL'Old) mod L.
         --------------------------------------------------------------

         V0     : constant Big_Integer := V (XL)
           with Ghost => SPARKlib_Logic;
         XL0    : constant XL_Table := XL
           with Ghost => SPARKlib_Logic;
         Q      : constant Final_Carry_T := ASR_4 (XL (31))
           with Ghost => SPARKlib_Logic;
         XL_Pre : XL_Table
           with Ghost => SPARKlib_Logic;
         C_Pre  : Final_Carry_T
           with Ghost => SPARKlib_Logic;
         M      : I64
           with Ghost => SPARKlib_Logic;
         --  XL after Step 1 and after Step 2
         XL_S1  : XL_Table
           with Ghost => SPARKlib_Logic;
         XL_S2  : XL_Table
           with Ghost => SPARKlib_Logic;
         --  In Step 3, T is XL with limbs 0 .. I replaced by R (0 .. I)
         T, T_Pre : XL_Table
           with Ghost => SPARKlib_Logic;

         --  Invariant of Step 1, after limb J
         function Inv1 (A : in XL_Table;
                        C : in Final_Carry_T;
                        J : in I32) return Boolean
         is (V (A) + To_Big (C) * P (J + 1) =
               V0 - To_Big (Q) * LP (0, J + 1))
           with Ghost    => SPARKlib_Logic,
                Global   => (V0, Q),
                Pre      => J in -1 .. 31,
                Annotate => (GNATprove, Hide_Info, "Expression_Function_Body");

         --  Invariant of Step 2, after limb J
         function Inv2 (A, S : in XL_Table;
                        C    : in Final_Carry_T;
                        J    : in I32) return Boolean
         is (V (A) = V (S) - To_Big (C) * LP (0, J + 1))
           with Ghost    => SPARKlib_Logic,
                Pre      => J in -1 .. 31,
                Annotate => (GNATprove, Hide_Info, "Expression_Function_Body");

         --  Invariant of Step 3
         function Inv3 (A, S : in XL_Table) return Boolean
         is (V (A) = V (S))
           with Ghost    => SPARKlib_Logic,
                Annotate => (GNATprove, Hide_Info, "Expression_Function_Body");

         procedure Lemma_Inv1_Init
           with Ghost => SPARKlib_Logic,
                Global => (Proof_In => (XL, V0, Q)),
                Pre   => V (XL) = V0,
                Post  => Inv1 (XL, 0, -1);

         procedure Lemma_S1_Step (Old_XL, New_XL : in XL_Table;
                                  J              : in Index_32;
                                  C_Old, C_New   : in Final_Carry_T;
                                  Mid            : in I64)
           with Ghost => SPARKlib_Logic,
                Global => (Input => (V0, Q)),
                Pre   => Inv1 (Old_XL, C_Old, J - 1) and then
                         (for all K in Index_64 =>
                            (if K /= J then Old_XL (K) = New_XL (K))) and then
                         Mid in Step1_XL_Limb and then
                         Mid = Old_XL (J) + (C_Old - Q * L (J)) and then
                         C_New = ASR_8 (Mid) and then
                         New_XL (J) = Mid mod 256,
                Post  => Inv1 (New_XL, C_New, J);

         procedure Lemma_Inv2_Init (S : in XL_Table;
                                    C : in Final_Carry_T)
           with Ghost => SPARKlib_Logic,
                Post  => Inv2 (S, S, C, -1);

         procedure Lemma_S2_Step (Old_XL, New_XL, S : in XL_Table;
                                  J                 : in Index_32;
                                  C                 : in Final_Carry_T)
           with Ghost => SPARKlib_Logic,
                Pre   => Inv2 (Old_XL, S, C, J - 1) and then
                         (for all K in Index_64 =>
                            (if K /= J then Old_XL (K) = New_XL (K))) and then
                         New_XL (J) = Old_XL (J) - C * L (J),
                Post  => Inv2 (New_XL, S, C, J);

         procedure Lemma_Inv3_Init (S : in XL_Table)
           with Ghost => SPARKlib_Logic,
                Post  => Inv3 (S, S);

         --  One step of Step 3: limb I goes from X to X mod 256 and the
         --  carry ASR_8 (X) is added to limb I + 1
         procedure Lemma_S3_Step (Old_T, New_T, S : in XL_Table;
                                  I               : in Index_32;
                                  X, C            : in I64)
           with Ghost => SPARKlib_Logic,
                Pre   => Inv3 (Old_T, S) and then
                         X in -2**20 .. 2**20 and then
                         C in -2**20 .. 2**20 and then
                         Old_T (I) = X and then
                         C = ASR_8 (X) and then
                         New_T (I) = X mod 256 and then
                         New_T (I + 1) = Old_T (I + 1) + C and then
                         (for all K in Index_64 =>
                            (if K /= I and K /= I + 1 then
                               Old_T (K) = New_T (K))),
                Post  => Inv3 (New_T, S);

         --  Bound on V0 - Q * L, from the precondition of Finalize
         procedure Lemma_Bound_A
           with Ghost => SPARKlib_Logic,
                Global => (Input => (XL0, Q), Proof_In => V0),
                Pre   =>
                  V0 = V (XL0) and
                  Q = ASR_4 (XL0 (31)) and
                  (for all K in Index_64 range 0 .. 19 => XL0 (K) in FRL) and
                  (for all K in Index_64 range 20 .. 31 => XL0 (K) in PRL) and
                  (for all K in Index_64 range 32 .. 63 => XL0 (K) = 0),
                Post  =>
                  V0 - To_Big (Q) * L_Big > -P (31) - 9 * Delta_Big and
                  V0 - To_Big (Q) * L_Big < 16 * P (31);

         --  After Step 1, V (S1) is in 0 .. 2**256 - 1
         procedure Lemma_Bound_W1 (S1 : in XL_Table)
           with Ghost => SPARKlib_Logic,
                Pre   =>
                  (for all K in Index_64 range 0 .. 31 =>
                     S1 (K) in I64_Byte) and
                  (for all K in Index_64 range 32 .. 63 => S1 (K) = 0),
                Post  => V (S1) >= 0 and V (S1) < P (32);

         --  After Step 3, limbs 0 .. 31 of TF are the bytes of R, limb 32
         --  is the carry out, and the rest are zero
         procedure Lemma_R_Value (TF : in XL_Table;
                                  RF : in Bytes_32)
           with Ghost => SPARKlib_Logic,
                Pre   =>
                  (for all K in Index_32 => TF (K) = I64 (RF (K))) and
                  (for all K in Index_64 range 33 .. 63 => TF (K) = 0),
                Post  =>
                  Value (RF) + To_Big (TF (32)) * P (32) = V (TF) and
                  Value (RF) >= 0 and Value (RF) < P (32);

         --  Combine the invariants of the three steps and the bounds above
         procedure Lemma_Finish (S1, S2, TF : in XL_Table;
                                 C1         : in Final_Carry_T;
                                 RV         : in Big_Integer)
           with Ghost => SPARKlib_Logic,
                Global => (Input => (V0, Q)),
                Pre   =>
                  V0 - To_Big (Q) * L_Big > -P (31) - 9 * Delta_Big and
                  V0 - To_Big (Q) * L_Big < 16 * P (31) and
                  V (S1) >= 0 and V (S1) < P (32) and
                  RV + To_Big (TF (32)) * P (32) = V (TF) and
                  RV >= 0 and RV < P (32) and
                  Inv1 (S1, C1, 31) and
                  Inv2 (S2, S1, C1, 31) and
                  Inv3 (TF, S2),
                Post  => RV = V0 mod L_Big;

         procedure Lemma_Inv1_Init
         is
            pragma Annotate (GNATprove, Unhide_Info,
                             "Expression_Function_Body", Inv1);
         begin
            Lemma_LP_Zero (0);
         end Lemma_Inv1_Init;

         procedure Lemma_S1_Step (Old_XL, New_XL : in XL_Table;
                                  J              : in Index_32;
                                  C_Old, C_New   : in Final_Carry_T;
                                  Mid            : in I64)
         is
            pragma Annotate (GNATprove, Unhide_Info,
                             "Expression_Function_Body", Inv1);
         begin
            Lemma_ASR_8_Mod (Mid);
            Lemma_L_Tables;
            pragma Assert (To_Big (Q * L (J)) = To_Big (Q) * L_Arr (J));
            pragma Assert
              (To_Big (New_XL (J)) =
                 To_Big (Old_XL (J)) + To_Big (C_Old) - To_Big (Q * L (J)) -
                 To_Big (256) * To_Big (C_New));
            Lemma_Carry (Old_XL, New_XL, J, C_Old, C_New, Q * L (J));
            pragma Assert
              (V (New_XL) + To_Big (C_New) * P (J + 1) =
                 V0 - To_Big (Q) * LP (0, J) - To_Big (Q * L (J)) * P (J));
            pragma Assert
              (V (New_XL) + To_Big (C_New) * P (J + 1) =
                 V0 - To_Big (Q) * LP (0, J) -
                      (To_Big (Q) * L_Arr (J)) * P (J));
            Lemma_Distrib (S   => V0,
                           X   => To_Big (Q),
                           LPT => LP (0, J),
                           LT  => L_Arr (J),
                           PJ  => P (J));
            Lemma_LP_Succ (0, J);
         end Lemma_S1_Step;

         procedure Lemma_Inv2_Init (S : in XL_Table;
                                    C : in Final_Carry_T)
         is
            pragma Annotate (GNATprove, Unhide_Info,
                             "Expression_Function_Body", Inv2);
            pragma Unreferenced (S, C);
         begin
            Lemma_LP_Zero (0);
         end Lemma_Inv2_Init;

         procedure Lemma_S2_Step (Old_XL, New_XL, S : in XL_Table;
                                  J                 : in Index_32;
                                  C                 : in Final_Carry_T)
         is
            pragma Annotate (GNATprove, Unhide_Info,
                             "Expression_Function_Body", Inv2);
         begin
            Lemma_XL_Update (Old_XL, New_XL, J);
            Lemma_L_Tables;
            pragma Assert
              (To_Big (New_XL (J)) - To_Big (Old_XL (J)) =
                 -(To_Big (C) * L_Arr (J)));
            Lemma_Distrib (S   => V (S),
                           X   => To_Big (C),
                           LPT => LP (0, J),
                           LT  => L_Arr (J),
                           PJ  => P (J));
            Lemma_LP_Succ (0, J);
         end Lemma_S2_Step;

         procedure Lemma_Inv3_Init (S : in XL_Table)
         is
            pragma Annotate (GNATprove, Unhide_Info,
                             "Expression_Function_Body", Inv3);
         begin
            null;
         end Lemma_Inv3_Init;

         procedure Lemma_S3_Step (Old_T, New_T, S : in XL_Table;
                                  I               : in Index_32;
                                  X, C            : in I64)
         is
            pragma Annotate (GNATprove, Unhide_Info,
                             "Expression_Function_Body", Inv3);
            pragma Unreferenced (S);
            Mid : XL_Table := Old_T;
         begin
            Lemma_ASR_8_Mod (X);
            Mid (I) := New_T (I);
            Lemma_Carry (Old_T, Mid, I, 0, C, 0);
            pragma Assert (for all K in Index_64 =>
                             (if K /= I + 1 then Mid (K) = New_T (K)));
            Lemma_XL_Update (Mid, New_T, I + 1);
         end Lemma_S3_Step;

         procedure Lemma_Bound_A
         is
            B : constant Big_Arr := XL_Big (XL0);
         begin
            pragma Assert (XL0 (31) - 16 * Q in 0 .. 15);
            pragma Assert (Q in -9 .. 8);
            pragma Assert (for all K in Index_64 =>
                             (if K < 31 then B (K) >= -129 and B (K) <= 128));
            pragma Assert (B (31) - 16 * To_Big (Q) >= 0 and
                           B (31) - 16 * To_Big (Q) <= 15);
            pragma Assert (for all K in Index_64 =>
                             (if K >= 32 then B (K) = 0));
            Lemma_Step1_Range (B, To_Big (Q));
         end Lemma_Bound_A;

         procedure Lemma_Bound_W1 (S1 : in XL_Table)
         is
            B : constant Big_Arr := XL_Big (S1);
         begin
            pragma Assert (for all K in Index_64 =>
                             (if K < 32 then B (K) >= 0 and B (K) <= 255));
            pragma Assert (for all K in Index_64 =>
                             (if K in 32 .. 63 then B (K) = 0));
            Lemma_Value_Zero_Tail (B, 32, 64);
            Lemma_Value_Bounds (B, 32, To_Big (0), To_Big (255));
         end Lemma_Bound_W1;

         procedure Lemma_Finish (S1, S2, TF : in XL_Table;
                                 C1         : in Final_Carry_T;
                                 RV         : in Big_Integer)
         is
            pragma Annotate (GNATprove, Unhide_Info,
                             "Expression_Function_Body", Inv1);
            pragma Annotate (GNATprove, Unhide_Info,
                             "Expression_Function_Body", Inv2);
            pragma Annotate (GNATprove, Unhide_Info,
                             "Expression_Function_Body", Inv3);
         begin
            Lemma_LP_L;
            Lemma_Final_Reduce (V0 => V0,
                                Q  => To_Big (Q),
                                W1 => V (S1),
                                C1 => To_Big (C1),
                                V2 => V (S2),
                                Rv => RV,
                                C  => To_Big (TF (32)));
         end Lemma_Finish;

         procedure Lemma_R_Value (TF : in XL_Table;
                                  RF : in Bytes_32)
         is
            B  : constant Big_Arr := XL_Big (TF);
            BR : constant Big_Arr := To_Big_Arr (RF);
         begin
            pragma Assert (for all K in Index_64 =>
                             (if K < 32 then B (K) = BR (K)));
            pragma Assert (for all K in Index_64 =>
                             (if K in 33 .. 63 then B (K) = 0));
            pragma Assert (for all K in Index_64 =>
                             (if K < 32 then BR (K) >= 0 and BR (K) <= 255));
            Lemma_Value_Prefix (B, BR, 32);
            Lemma_Value_Succ (B, 32);
            Lemma_Value_Zero_Tail (B, 33, 64);
            Lemma_Value_Bounds (BR, 32, To_Big (0), To_Big (255));
         end Lemma_R_Value;
      begin
         --  Step 1
         Carry := 0;
         Lemma_Inv1_Init;
         for J in Index_32 loop
            pragma Loop_Optimize (No_Unroll);
            pragma Assert (XL (31) in PRL);
            XL_Pre := XL;
            C_Pre  := Carry;
            XL (J) := XL (J) + (Carry - ASR_4 (XL (31)) * L (J));

            pragma Assert (XL (J) >= Step1_XL_Limb'First);
            pragma Assert (XL (J) <= Step1_XL_Limb'Last);
            M := XL (J);

            Carry := ASR_8 (XL (J));
            XL (J) := XL (J) mod 256;
            Lemma_S1_Step (XL_Pre, XL, J, C_Pre, Carry, M);

            --  Modified limbs 0 .. J are all in I64_Byte
            pragma Loop_Invariant
              (for all K in Index_64 range 0 .. J => XL (K) in I64_Byte);
            --  Limbs J + 1 .. 31 are unmodified and in PRL
            pragma Loop_Invariant
              (for all K in Index_64 range J + 1 .. 31 =>
                 XL (K) = XL'Loop_Entry (K));
            pragma Loop_Invariant
              (for all K in Index_64 range J + 1 .. 31 =>
                 XL (K) in PRL);
            --  Trailing 32 limbs are all 0
            pragma Loop_Invariant
              (for all K in Index_64 range 32 .. 63 => XL (K) = 0);
            pragma Loop_Invariant (SPARKlib_Logic => Inv1 (XL, Carry, J));
         end loop;

         XL_S1 := XL;
         Lemma_Inv2_Init (XL_S1, Carry);

         --  RCC Potential to split above into 0 .. 15 as above, then
         --  exploit that L (J) = 0 for J in 16 .. 30, then do L (31) as
         --  a final special case.

         --  Check first 32 limbs in I64_Byte
         pragma Assert
           (for all K in Index_64 range 0 .. 31 => XL (K) in I64_Byte);
         --  Check later 32 limbs all 0
         pragma Assert
           (for all K in Index_64 range 32 .. 63 => XL (K) = 0);

         --  Step 2

         --  RCC split this loop too, based on L properties?
         for J in Index_32 loop
            pragma Loop_Optimize (No_Unroll);
            XL_Pre := XL;
            XL (J) := XL (J) - Carry * L (J);
            Lemma_S2_Step (XL_Pre, XL, XL_S1, J, Carry);
            pragma Loop_Invariant
              (for all K in Index_32 range 0 .. J =>
                 XL (K) in Step2_XL_Limb);
            pragma Loop_Invariant
              (for all K in Index_64 range 32 .. 63 => XL (K) = 0);
            pragma Loop_Invariant
              (SPARKlib_Logic => Inv2 (XL, XL_S1, Carry, J));
         end loop;

         XL_S2 := XL;
         T     := XL;
         Lemma_Inv3_Init (XL_S2);

         pragma Assert
           (for all K in Index_64 => XL (K) in Step2_XL_Limb);
         pragma Assert
           (for all K in Index_64 range 32 .. 63 => XL (K) = 0);

         --  Step 3 - final carry chain from X (0) to X (32) and reduce
         --  each limb mod 256
         declare
            --  In Step 3, XL(I+1) is added to ASR_8(XL(I)), so we need to know
            --  the range of the ASR_8(XL(I)). A precise characterisation
            --  of the bounds on XL (I+1) would be non-linear, so we fall
            --  back on a linear over-approximation here, which suffices.

            --  Max XL Carry - max magnitude of carry from XL(I) to XL(I+1)
            MXLC : constant := 10;
            --  Step 3 Carry
            subtype S3CT is I64 range -MXLC .. MXLC;
            S3C : S3CT;
         begin
            for I in Index_32 loop
               pragma Loop_Optimize (No_Unroll);

               pragma Assert (XL (I) >=
                                Step2_XL_Limb'First - MXLC * I64 (I));
               S3C := ASR_8 (XL (I));
               XL (I + 1) := XL (I + 1) + S3C;
               R (I) := Byte (XL (I) mod 256);

               T_Pre := T;
               T (I) := I64 (R (I));
               T (I + 1) := XL (I + 1);
               Lemma_S3_Step (T_Pre, T, XL_S2, I, XL (I), S3C);

               pragma Loop_Invariant (XL (0) = XL'Loop_Entry (0));
               pragma Loop_Invariant (XL (0) in Step2_XL_Limb);
               pragma Loop_Invariant (if I <= 30 then XL (32) = 0);
               pragma Loop_Invariant
                 (for all K in Index_32 range 1 .. 31 =>
                    XL (K) >= Step2_XL_Limb'First - (MXLC * I64 (K)));
               pragma Loop_Invariant
                 (for all K in Index_32 range 1 .. 31 =>
                    XL (K) <= Step2_XL_Limb'Last + (MXLC * I64 (K)));
               pragma Loop_Invariant
                 (for all K in Index_32 range I + 2 .. 31 =>
                    XL (K) in Step2_XL_Limb);
               pragma Loop_Invariant
                 (for all K in Index_32 range 0 .. I => R (K)'Initialized);
               pragma Loop_Invariant
                 (SPARKlib_Logic =>
                    (for all K in Index_32 range 0 .. I =>
                       T (K) = I64 (R (K))));
               pragma Loop_Invariant
                 (SPARKlib_Logic =>
                    (for all K in Index_64 range I + 1 .. 63 =>
                       T (K) = XL (K)));
               pragma Loop_Invariant
                 (SPARKlib_Logic =>
                    (for all K in Index_64 range 33 .. 63 => XL (K) = 0));
               pragma Loop_Invariant (SPARKlib_Logic => Inv3 (T, XL_S2));
            end loop;
         end;

         --  Combine the three steps
         Lemma_Bound_A;
         Lemma_Bound_W1 (XL_S1);
         Lemma_R_Value (T, R);
         Lemma_Finish (XL_S1, XL_S2, T, Carry, Value (R));
      end Finalize;

   begin
      Initialize_XL;
      Eliminate_Limb_63;
      Eliminate_Limbs_62_To_32;

      --  Wording of warning changed between SPARK 2020 and 2021, so two
      --  pragmas are needed here to get a clean analysis with both
      --  toolsets.
      pragma Warnings (GNATProve, Off, "unused assignment"); --  2020
      pragma Warnings (GNATProve, Off, "XL*not used after the call"); --  2021
      --  Unused assignment to XL here expected
      Finalize;
      return R;
   end ModL;

   function Hash_Reduce (M : in Byte_Seq) return Bytes_32
   is
      R : Digest;
      X : I64_Seq_64;
   begin
      Hash (R, M);
      X := (others => 0);
      for I in Index_64 loop
         pragma Loop_Optimize (No_Unroll);
         X (I) := I64 (R (I));
         pragma Loop_Invariant
           (for all K in Index_64 range 0 .. I => X (K) in I64_Byte);
      end loop;

      pragma Assert
        (for all K in Index_64 => X (K) in I64_Byte);

      return ModL (X);
   end Hash_Reduce;

   procedure Unpackneg (R  :    out GF_Vector_4;
                        OK :    out Boolean;
                        P  : in     Bytes_32)
   is
      --  Local, time-constant equality test for GF
      --  In the original TweetNaCl sources, this is called eq25519
      function "=" (Left, Right : in Normal_GF) return Boolean
        with Pure_Function,
             Global => null;

      function Pow_2523 (I : in Normal_GF) return Normal_GF
        with Pure_Function,
             Global => null;

      function "=" (Left, Right : in Normal_GF) return Boolean
      is
      begin
         return Equal (Bytes_32'(Utils.Pack_25519 (Left)),
                       Bytes_32'(Utils.Pack_25519 (Right)));
      end "=";

      function Pow_2523 (I : in Normal_GF) return Normal_GF
      is
         C, C2 : Normal_GF;
      begin
         C := I;
         --  Note that 2**252 - 3 = 16#1111_1111 .. 1101#
         --  with (numbering from 0 at the left) only "bit 249" set to 0
         for A in 0 .. 248 loop
            pragma Loop_Optimize (No_Unroll);
            C := (C * C) * I;
         end loop;

         --  A = 249
         C2 := C * C;
         --  A = 250
         return Square (C2) * I;
      end Pow_2523;


      --  Note: refactoring here to functional/SSA form reduces the
      --  number of calls to "*" from 8 in the original TweetNaCl code
      --  to 5 from here until the initialization of R0, but only if
      --  "*" on GF is commutative.
      R1          : constant Normal_GF := Utils.Unpack_25519 (P);
      R2          :          Normal_GF renames GF_1;
      R1_Squared  : constant Normal_GF := Square (R1);
      Num         : constant Normal_GF := R1_Squared - R2;
      Den         : constant Normal_GF := R2 + (R1_Squared * GF_D);
      Den_Power_2 : constant Normal_GF := Square (Den);
      Den_Power_4 : constant Normal_GF := Square (Den_Power_2);
      Num_Den2    : constant Normal_GF := (Num * Den) * Den_Power_2;

      R0    : Normal_GF := Pow_2523 ((Den_Power_4 * Num_Den2)) * Num_Den2;
      Check : Normal_GF;
   begin
      Check := Square (R0) * Den;

      if Check /= Num then
         R0 := R0 * GF_I;
      end if;

      Check := Square (R0) * Den;

      if Check /= Num then
         R  := (others => GF_0);
         OK := False;
         return;
      end if;

      if Par_25519 (R0) = (P (31) / 128) then
         R0 := GF_0 - R0;
      end if;

      R := (0 => R0,
            1 => R1,
            2 => R2,
            3 => R0 * R1);
      OK := True;
   end Unpackneg;



   --============================================
   --  Exported subprogram bodies
   --============================================

   function Serialize (K : in Signing_SK) return Bytes_64
   is
   begin
      return K.F;
   end Serialize;

   function Serialize (K : in Signing_PK) return Bytes_32
   is
   begin
      return K.F;
   end Serialize;

   procedure Sanitize (K : out Signing_PK)
   is
   begin
      SPARKNaCl.Sanitize (K.F);
   end Sanitize;

   procedure Sanitize (K : out Signing_SK)
   is
   begin
      SPARKNaCl.Sanitize (K.F);
   end Sanitize;

   procedure Keypair (SK_Raw : in     Bytes_32; -- random please!
                      PK     :    out Signing_PK;
                      SK     :    out Signing_SK)
   is
      D   : Bytes_64;
      LPK : Bytes_32;
   begin
      Hash (D, SK_Raw);
      D (0)  := D (0) and 248;
      D (31) := (D (31) and 127) or 64;

      LPK := Pack (Scalarbase (D (0 .. 31)));

      PK.F := LPK;
      SK.F := SK_Raw & LPK;

      --  Sanitize intermediate values used in key generation
      pragma Warnings (GNATProve, Off, "statement has no effect");
      Sanitize (D);
      Sanitize (LPK);
      pragma Unreferenced (D);
      pragma Unreferenced (LPK);
   end Keypair;

   procedure PK_From_Bytes (PK_Raw : in     Bytes_32;
                            PK     :    out Signing_PK)
   is
   begin
      PK.F := PK_Raw;
   end PK_From_Bytes;

   procedure Sign (SM :    out Byte_Seq;
                   M  : in     Byte_Seq;
                   SK : in     Signing_SK)
   is
      subtype Byte_Product is I64 range 0 .. MBP;

      D    : Bytes_64;
      H, R : Bytes_32;
      X    : I64_Seq_64;
      T    : Byte_Product;
      P    : GF_Vector_4;

      procedure Initialize_SM (X : out Byte_Seq)
        with Global  => (Input  => (M, D)),
             Depends => (X => (X, M, D)),
             Pre => (M'First   = 0 and
                     X'First  = 0 and
                     M'Last   <= N32'Last - Sign_Bytes) and then
                    (X'Length = M'Length + Sign_Bytes and
                     X'Last   = M'Last + Sign_Bytes),
             Post => (X = Zero_Bytes_32 & D (32 .. 63) & M) and
                     X'Initialized,
             Relaxed_Initialization => X,
             No_Inline;

      procedure Initialize_SM (X : out Byte_Seq)
      is
      begin
         --  Precondition ensures SM is exactly 64 bytes longer than M.
         --  Don't use "&" here to avoid allocation of a dynamic-sized
         --  object on the stack.
         X (0  .. 31)     := Zero_Bytes_32;
         X (32 .. 63)     := D (32 .. 63);
         X (64 .. X'Last) := M;
      end Initialize_SM;

   begin
      --  Commentary here is based on the description of the Ed25519
      --  signing algorithm here:
      --  https://www.eiken.dev/blog/2020/11/
      --    code-spotlight-the-reference-implementation-of-ed25519-part-1/
      --  and RFC 8032

      --  RFC 8032 5.1.5 "Key Generation"
      --  Hash the private key (bytes 0 .. 31 of SK) to get
      --  64-byte Digest D
      Hash (D, Serialize (SK) (0 .. 31));
      --  Clamp the first 32 bytes of D so that they represent a useful
      --  scalar value for scalar*point multiplication.  The top-most bit
      --  is cleared, and the next-to-top-most bit is set, so the value
      --  is definitely larger than 2**254.  The botton 3 bits are cleared
      --  to ensure that the value is a multiple of 8 - the group cofactor
      D (0)  := D (0) and 248;
      D (31) := (D (31) and 127) or 64;

      --  RFC 8032 5.1.6 "Sign"
      --  Set SM to concatenation of Zero_Bytes_32 || Prefix || M
      Initialize_SM (SM);
      --  Compute ModL (Hash (Prefix || M)) which starts at offset 32 in SM now
      R := Hash_Reduce (SM (32 .. SM'Last));

      --  Now R is reduced, use it as a scalar to multiply the base point
      P := Scalarbase (R);

      --  Put 32 bytes of P into bytes 0 .. 31 of SM
      SM (0 .. 31) := Pack (P);
      --  Put public key into bytes 32 .. 63
      SM (32 .. 63) := Serialize (SK) (32 .. 63);

      --  Message M is in bytd 64 .. SM'Last, so hash the lot now,
      --  and reduce the result modulo L
      H := Hash_Reduce (SM);

      --  Copy R into the least significant 32 bytes of X
      X := (others => 0);
      for I in Index_32 loop
         pragma Loop_Optimize (No_Unroll);
         X (I) := I64 (R (I));
         pragma Loop_Invariant
           ((for all K in N32 range     0 .. I  => X (K) in I64_Byte) and
            (for all K in N32 range I + 1 .. 63 => X (K) = 0));
      end loop;

      pragma Assert
        ((for all K in N32 range  0 .. 31 => X (K) in I64_Byte) and
         (for all K in N32 range 32 .. 63 => X (K) = 0) and
         (for all K in Index_64 => X (K) in I64_Byte)
        );

      pragma Warnings (Off, "explicit membership test may be optimized");

      --  Now compute X := X + (H * D) using simple lattice multiplication
      for I in Index_32 loop
         pragma Loop_Optimize (No_Unroll);
         for J in Index_32 loop
            pragma Loop_Optimize (No_Unroll);
            T := Byte_Product (H (I)) * Byte_Product (D (J));
            X (I + J) := X (I + J) + T;

            --  This loop invariant follows the same pattern
            --  as that in SPARKNaCl."*"
            pragma Loop_Invariant
              (
               T in Byte_Product and

               --  Lower bound
               (for all K in Index_64 => X (K) >= 0) and

               --  rising from 1 to I
               (for all K in Index_64 range 0 .. (I - 1)   =>
                  X (K) <= (I64 (K + 1) * MBP + 255)) and

               --  flat at I + 1, just written
               (for all K in Index_64 range I .. I32'Min (31, I + J) =>
                  X (K) <= (I64 (I + 1) * MBP + 255)) and

               --  flat at I, not written yet
               (for all K in Index_64 range I + J + 1 .. 31 =>
                  X (K) <= (I64 (I) * MBP + 255)) and

               --  falling from I to 1, just written
               (for all K in Index_64 range 32 .. (I + J) =>
                  X (K) <= (I64 (32 + I) - I64 (K)) * MBP + 255) and

               --  falling, from I to 1, but not written yet
               (for all K in Index_64 range
                  I32'Max (32, I + J + 1) .. (I + 31) =>
                  X (K) <= (I64 (31 + I) - I64 (K)) * MBP + 255) and

               --  Zeroes - never written
               (for all K in Index_64 range I + 32 .. 63   =>
                  X (K) = 0)
              );
         end loop;

         --  Substitute J = 31 into the above yields
         pragma Loop_Invariant
           (
            T in Byte_Product and

            --  Lower bound
            (for all K in Index_64 => X (K) >= 0) and

            --  rising from 1 to I
            (for all K in Index_64 range 0 .. (I - 1)   =>
               X (K) <= (I64 (K + 1) * MBP + 255)) and

            --  flat at I + 1, just written
            (for all K in Index_64 range I .. 31 =>
               X (K) <= (I64 (I + 1) * MBP + 255)) and

            --  falling from I to 1, just written
            (for all K in Index_64 range 32 .. (I + 31) =>
               X (K) <= (I64 (32 + I) - I64 (K)) * MBP + 255) and

            --  Zeroes - never written
            (for all K in Index_64 range I + 32 .. 63   =>
               X (K) = 0)
           );
      end loop;

      --  Substitute I = 31
      pragma Assert
        (
         --  Lower bound
         (for all K in Index_64 => X (K) >= 0) and

         --  Upper bounds
         (for all K in Index_64 range 0 .. 30   =>
            X (K) <= (I64 (K + 1) * MBP + 255)) and
         X (31) <= (32 * MBP + 255) and
         (for all K in Index_64 range 32 .. 62 =>
            X (K) <= (63 - I64 (K)) * MBP + 255) and
         X (63) = 0
        );

      --  Simplify - this assert is equivalent to the precondition of ModL
      pragma Assert
        (for all K in Index_64 => X (K) in 0 .. (32 * MBP + 255));

      --   Reduce X modulo L and put the result into SM (32..63)
      SM (32 .. 63) := ModL (X);

      --  The final signature is now in SM (0 .. 63)
      Sanitize (D);
      Sanitize (H);
      Sanitize (R);
      Sanitize_I64_Seq (X);

      pragma Unreferenced (D, H, R, X);
   end Sign;

   procedure Open (M      :    out Byte_Seq;
                   Status :    out Boolean;
                   MLen   :    out I32;
                   SM     : in     Byte_Seq;
                   PK     : in     Signing_PK)
   is
      T    : Bytes_32;
      P, Q : GF_Vector_4;
      LN   : I32;
   begin
      MLen := -1;
      if SM'Length < 64 then
         M := (others => 0);
         Status := False;
         --  No sanitization required before this return
         return;
      end if;

      Unpackneg (Q, Status, Serialize (PK));
      if not Status then
         M := (others => 0);
         Sanitize_GF_Vector_4 (Q);
         return;
      end if;

      M := SM; -- precondition ensures lengths match
      M (32 .. 63) := Serialize (PK);
      P := Scalarmult (Q, Hash_Reduce (M));
      Q := Scalarbase (SM (32 .. 63));

      --  Call to user-defined "+" for GF_Vector_4
      P := P + Q;
      T := Pack (P);

      if not Equal (SM (0 .. 31), T) then
         M := (others => 0);
         Status := False;
         Sanitize (T);
         Sanitize_GF_Vector_4 (P);
         Sanitize_GF_Vector_4 (Q);
         return;
      end if;

      LN := I32 (I64 (SM'Length) - 64);

      M (0 .. LN - 1) := SM (64 .. LN + 63);
      MLen := LN;
      Status := True;

      Sanitize (T);
      Sanitize_GF_Vector_4 (P);
      Sanitize_GF_Vector_4 (Q);
      pragma Unreferenced (T, P, Q);
   end Open;

end SPARKNaCl.Sign;
