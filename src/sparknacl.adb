with SPARKNaCl.Car;
package body SPARKNaCl
  with SPARK_Mode => On
is
   pragma Warnings (GNATProve, Off, "pragma * ignored (not yet supported)");

   function M1 (Left, Right : in Normal_GF) return Normal_GF;

   function M2 (Left, Right : in Normal_GF) return Normal_GF;

   --===============================
   --  Exported subprogram bodies
   --===============================

   function "+" (Left, Right : in Normal_GF) return Normal_GF
   is
      subtype ILT is I32 range 0 .. (LMM1 * 2) + 1;
      T     : ILT;
      Carry : I32_Bit;
      R     : GF32 with Relaxed_Initialization;
   begin
      Carry := 0;

      --  In this implementation, we compute and add Carry
      --  as we go along
      for I in Index_16 loop
         pragma Loop_Optimize (No_Unroll);
         T := I32 (Left (I)) + I32 (Right (I)) + Carry;
         R (I) := T mod LM;
         Carry := T / LM;
         pragma Loop_Invariant
           (for all J in Index_16 range 0 .. I => R (J)'Initialized);
         pragma Loop_Invariant
           (for all J in Index_16 range 0 .. I => R (J) in GF32_Normal_Limb);
      end loop;

      pragma Assert (R'Initialized and then R in Normal_GF32);

      --  The "Carry" from limb 15 can only be 0 or 1, so we
      --  multiply that by R2256 and add to limb 0. R is then a
      --  "Nearlynormal_GF", so only a _single_ call to
      --  Car.Nearlynormal_To_Normal is required
      R (0) := R (0) + (R2256 * Carry);

      pragma Assert (R'Initialized and then R in Nearlynormal_GF);

      return Car.Nearlynormal_To_Normal (R);
   end "+";

   function "-" (Left, Right : in Normal_GF) return Normal_GF
   is
      subtype ILT is I32 range -LM .. LMM1;
      T     : ILT;
      Carry : I32 range -1 .. 0;
      R     : GF32 with Relaxed_Initialization;
   begin
      Carry := 0;

      --  In this implementation, we compute and add Carry
      --  as we go along
      for I in Index_16 loop
         pragma Loop_Optimize (No_Unroll);
         T := I32 (Left (I)) - I32 (Right (I)) + Carry;
         R (I) := T mod LM;
         Carry := ASR32_16 (T);
         pragma Loop_Invariant
           (for all J in Index_16 range 0 .. I => R (J)'Initialized);
         pragma Loop_Invariant
           (for all J in Index_16 range 0 .. I => R (J) in GF32_Normal_Limb);
      end loop;

      pragma Assert (R'Initialized and then R in Normal_GF32);

      --  The "Carry" from limb 15 can only be 0 or -1, so we
      --  multiply that by R2256 and add to limb 0. R is then a
      --  "Nearlynormal_GF", so only a _single_ call to
      --  Car.Nearlynormal_To_Normal is required
      R (0) := R (0) + (R2256 * Carry);

      pragma Assert (R'Initialized and then R in Nearlynormal_GF);

      return Car.Nearlynormal_To_Normal (R);
   end "-";

   function M1 (Left, Right : in Normal_GF) return Normal_GF
   is
      subtype U32_Normal_Limb is U32 range 0 .. LMM1;

      T  : GF64_PA;
      TF : GF64 with Relaxed_Initialization;
      LT : U32_Normal_Limb;
   begin
      LT := U32_Normal_Limb (Left (0));

      --  Initialization of T and unrolling of the first loop
      --  iteration can both be done in a single assignment here.
      T := GF64_PA'(0  => I64 (LT * U32_Normal_Limb (Right (0))),
                    1  => I64 (LT * U32_Normal_Limb (Right (1))),
                    2  => I64 (LT * U32_Normal_Limb (Right (2))),
                    3  => I64 (LT * U32_Normal_Limb (Right (3))),
                    4  => I64 (LT * U32_Normal_Limb (Right (4))),
                    5  => I64 (LT * U32_Normal_Limb (Right (5))),
                    6  => I64 (LT * U32_Normal_Limb (Right (6))),
                    7  => I64 (LT * U32_Normal_Limb (Right (7))),
                    8  => I64 (LT * U32_Normal_Limb (Right (8))),
                    9  => I64 (LT * U32_Normal_Limb (Right (9))),
                    10 => I64 (LT * U32_Normal_Limb (Right (10))),
                    11 => I64 (LT * U32_Normal_Limb (Right (11))),
                    12 => I64 (LT * U32_Normal_Limb (Right (12))),
                    13 => I64 (LT * U32_Normal_Limb (Right (13))),
                    14 => I64 (LT * U32_Normal_Limb (Right (14))),
                    15 => I64 (LT * U32_Normal_Limb (Right (15))),
                    others => 0);

      --  Based on the loop invariant below, but substituting I for 0,
      --  we can assert...
      pragma Assert
        ((for all K in Index_31 range 0 .. 15 =>
            T (K) >= 0 and T (K) <= MGFLP) and
         (for all K in Index_31 range 16 .. 30 =>
            T (K) = 0));

      --  "Textbook" ladder multiplication
      for I in Index_16 range 1 .. 15 loop

         pragma Loop_Optimize (No_Unroll);
         --  Manual unroll and PRE of the inner loop here gives a significant
         --  performance gain at all optimization levels, preserves proof,
         --  and avoids the need for a complex inner loop invariant.
         --
         --  for J in Index_16 loop
         --     T (I + J) := T (I + J) + (Left (I) * Right (J));
         --  end loop;

         LT := U32_Normal_Limb (Left (I));

         --  Note that the "*" here is done in 32-bit Unsigned arithmetic
         --  before the result is converted to 64-bit and accumulated into T.
         --  This is much faster on 32-bit platforms that don't do 64-bit
         --  multiplication in a single instruction.
         T (I)      := T (I)      + I64 (LT * U32_Normal_Limb (Right (0)));
         T (I + 1)  := T (I + 1)  + I64 (LT * U32_Normal_Limb (Right (1)));
         T (I + 2)  := T (I + 2)  + I64 (LT * U32_Normal_Limb (Right (2)));
         T (I + 3)  := T (I + 3)  + I64 (LT * U32_Normal_Limb (Right (3)));
         T (I + 4)  := T (I + 4)  + I64 (LT * U32_Normal_Limb (Right (4)));
         T (I + 5)  := T (I + 5)  + I64 (LT * U32_Normal_Limb (Right (5)));
         T (I + 6)  := T (I + 6)  + I64 (LT * U32_Normal_Limb (Right (6)));
         T (I + 7)  := T (I + 7)  + I64 (LT * U32_Normal_Limb (Right (7)));
         T (I + 8)  := T (I + 8)  + I64 (LT * U32_Normal_Limb (Right (8)));
         T (I + 9)  := T (I + 9)  + I64 (LT * U32_Normal_Limb (Right (9)));
         T (I + 10) := T (I + 10) + I64 (LT * U32_Normal_Limb (Right (10)));
         T (I + 11) := T (I + 11) + I64 (LT * U32_Normal_Limb (Right (11)));
         T (I + 12) := T (I + 12) + I64 (LT * U32_Normal_Limb (Right (12)));
         T (I + 13) := T (I + 13) + I64 (LT * U32_Normal_Limb (Right (13)));
         T (I + 14) := T (I + 14) + I64 (LT * U32_Normal_Limb (Right (14)));
         T (I + 15) := T (I + 15) + I64 (LT * U32_Normal_Limb (Right (15)));

         pragma Loop_Invariant
            (for all K in Index_31 => T (K) >= 0);
         pragma Loop_Invariant
            (for all K in Index_31 range 0 .. (I - 1)   =>
               T (K) <= (I64 (K + 1) * MGFLP));
         pragma Loop_Invariant
            (for all K in Index_31 range I .. 15        =>
               T (K) <= (I64 (I + 1) * MGFLP));
         pragma Loop_Invariant
            (for all K in Index_31 range 16 .. (I + 15) =>
               T (K) <= (I64 (16 + I) - I64 (K)) * MGFLP);
         pragma Loop_Invariant
            (for all K in Index_31 range I + 16 .. 30   =>
               T (K) = 0);
      end loop;

      --  Substituting I = 15 into the outer loop invariant above,
      --  and eliminating quantifiers with null ranges yields
      --  the following assertion.
      --
      --  The coefficients of MGFLP in the upper bound for limbs 0 .. 30
      --  form a "pyramid" which peaks at 16 for T (15), like this:
      --
      --- 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 15 14 13 12 11 10 ... 1
      pragma Assert
        (
         --  Lower bound
         (for all K in Index_31 => T (K) >= 0) and
         --  Upper bounds
         (for all K in Index_31 range  0 .. 14 =>
            T (K) <= (I64 (K) + 1) * MGFLP) and
         T (15) <= 16 * MGFLP and
         (for all K in Index_31 range 16 .. 30 =>
            T (K) <= (31 - I64 (K)) * MGFLP)
        );

      --  To "carry" the value in limbs 16 .. 30 and above down into
      --  limbs 0 .. 14, we need to multiply each upper limb by 2**256.
      --
      --  Unfortutely, our limbs don't have enough bits for that to work,
      --  but we're working in mod (2**255 - 19) arithmetic, and we know that
      --  2**256 mod (2**255 - 19) = R2256, so we can multiply by that instead.
      --
      --  Given the upper bounds established above, we _can_ prove that
      --  T (I) + R2256 * T (I + 16) WILL fit in 64 bits.
      for I in Index_15 loop
         pragma Loop_Optimize (No_Unroll);
         TF (I) := T (I) + R2256 * T (I + 16);

         pragma Loop_Invariant
           (for all J in Index_15 range 0 .. I => TF (J)'Initialized);

         pragma Loop_Invariant
           (
            (for all J in Index_15 range 0 .. I =>
               TF (J) = T (J) + R2256 * T (J + 16))
           );
      end loop;

      pragma Assert
        (for all J in Index_15 => TF (J)'Initialized);

      TF (15) := T (15);

      pragma Assert (TF'Initialized);
      pragma Assert (TF in Product_GF);


      --  Sanitize T, as per WireGuard sources
      pragma Warnings (GNATProve, Off, "statement has no effect");
      Sanitize_GF64_PA (T);
      pragma Unreferenced (T);

      --  In SPARKNaCl, we normalize after "*".
      --
      --  Interestingly, in the TweetNaCl sources, only TWO
      --  applications of the "car_25519" function are used here.
      --
      --  In SPARKNaCl we have proved that THREE
      --  applications of car_25519 are required to definitely
      --  return any possible Product_GF to a fully normalized
      --  Normal_GF.
      return Car.Nearlynormal_To_Normal
               (Car.Seminormal_To_Nearlynormal
                 (Car.Product_To_Seminormal (TF)));
   end M1;

   function M2 (Left, Right : in Normal_GF) return Normal_GF
   is
      L : Normal_GF renames Left;
      R : Normal_GF renames Right;

      subtype U32NL is U32 range 0 .. LMM1;
      subtype U64NL is U64 range 0 .. LMM1;

      L0  : constant U32NL := U32NL (L (0));
      L1  : constant U32NL := U32NL (L (1));
      L2  : constant U32NL := U32NL (L (2));
      L3  : constant U32NL := U32NL (L (3));
      L4  : constant U32NL := U32NL (L (4));
      L5  : constant U32NL := U32NL (L (5));
      L6  : constant U32NL := U32NL (L (6));
      L7  : constant U32NL := U32NL (L (7));
      L8  : constant U32NL := U32NL (L (8));
      L9  : constant U32NL := U32NL (L (9));
      L10 : constant U32NL := U32NL (L (10));
      L11 : constant U32NL := U32NL (L (11));
      L12 : constant U32NL := U32NL (L (12));
      L13 : constant U32NL := U32NL (L (13));
      L14 : constant U32NL := U32NL (L (14));
      L15 : constant U32NL := U32NL (L (15));
      R0  : constant U32NL := U32NL (R (0));
      R1  : constant U32NL := U32NL (R (1));
      R2  : constant U32NL := U32NL (R (2));
      R3  : constant U32NL := U32NL (R (3));
      R4  : constant U32NL := U32NL (R (4));
      R5  : constant U32NL := U32NL (R (5));
      R6  : constant U32NL := U32NL (R (6));
      R7  : constant U32NL := U32NL (R (7));
      R8  : constant U32NL := U32NL (R (8));
      R9  : constant U32NL := U32NL (R (9));
      R10 : constant U32NL := U32NL (R (10));
      R11 : constant U32NL := U32NL (R (11));
      R12 : constant U32NL := U32NL (R (12));
      R13 : constant U32NL := U32NL (R (13));
      R14 : constant U32NL := U32NL (R (14));
      R15 : constant U32NL := U32NL (R (15));

      subtype GF64_Natural_Limb is U64 range 0 .. (MGFLC * MGFLP);

      --  Limb Product (LP) - a subtype for representing the product
      --  of two normalized GF64 Limbs
      subtype LP   is GF64_Natural_Limb range 0 .. MGFLP;
      --  Sum of 2 Limb Products...
      subtype LP2  is GF64_Natural_Limb range 0 .. 2 * MGFLP;
      --  ... and so on...
      subtype LP3  is GF64_Natural_Limb range 0 .. 3 * MGFLP;
      subtype LP4  is GF64_Natural_Limb range 0 .. 4 * MGFLP;
      subtype LP5  is GF64_Natural_Limb range 0 .. 5 * MGFLP;
      subtype LP6  is GF64_Natural_Limb range 0 .. 6 * MGFLP;
      subtype LP7  is GF64_Natural_Limb range 0 .. 7 * MGFLP;
      subtype LP8  is GF64_Natural_Limb range 0 .. 8 * MGFLP;
      subtype LP9  is GF64_Natural_Limb range 0 .. 9 * MGFLP;
      subtype LP10 is GF64_Natural_Limb range 0 .. 10 * MGFLP;
      subtype LP11 is GF64_Natural_Limb range 0 .. 11 * MGFLP;
      subtype LP12 is GF64_Natural_Limb range 0 .. 12 * MGFLP;
      subtype LP13 is GF64_Natural_Limb range 0 .. 13 * MGFLP;
      subtype LP14 is GF64_Natural_Limb range 0 .. 14 * MGFLP;
      subtype LP15 is GF64_Natural_Limb range 0 .. 15 * MGFLP;
      subtype LP16 is GF64_Natural_Limb range 0 .. 16 * MGFLP;


      T0,  T30 : LP;
      T1,  T29 : LP2;
      T2,  T28 : LP3;
      T3,  T27 : LP4;
      T4,  T26 : LP5;
      T5,  T25 : LP6;
      T6,  T24 : LP7;
      T7,  T23 : LP8;
      T8,  T22 : LP9;
      T9,  T21 : LP10;
      T10, T20 : LP11;
      T11, T19 : LP12;
      T12, T18 : LP13;
      T13, T17 : LP14;
      T14, T16 : LP15;
      T15 : LP16;

      C : GF64_Natural_Limb;

      --  Upper Bounds on Digits and Carry values during phase 1
      --  ripple carry and reduction.
      D0 : GF64_Natural_Limb;
      C0UB : constant := GF64_Natural_Limb'Last / LM;

      subtype D1S is GF64_Natural_Limb range 0 .. 534 * MGFLP + C0UB;
      D1 : D1S;
      C1UB : constant := D1S'Last / LM;

      subtype D2S is GF64_Natural_Limb range 0 .. 497 * MGFLP + C1UB;
      D2 : D2S;
      C2UB : constant := D2S'Last / LM;

      subtype D3S is GF64_Natural_Limb range 0 .. 460 * MGFLP + C2UB;
      D3 : D3S;
      C3UB : constant := D3S'Last / LM;

      subtype D4S is GF64_Natural_Limb range 0 .. 423 * MGFLP + C3UB;
      D4 : D4S;
      C4UB : constant := D4S'Last / LM;

      subtype D5S is GF64_Natural_Limb range 0 .. 386 * MGFLP + C4UB;
      D5 : D5S;
      C5UB : constant := D5S'Last / LM;

      subtype D6S is GF64_Natural_Limb range 0 .. 349 * MGFLP + C5UB;
      D6 : D6S;
      C6UB : constant := D6S'Last / LM;

      subtype D7S is GF64_Natural_Limb range 0 .. 312 * MGFLP + C6UB;
      D7 : D7S;
      C7UB : constant := D7S'Last / LM;

      subtype D8S is GF64_Natural_Limb range 0 .. 275 * MGFLP + C7UB;
      D8 : D8S;
      C8UB : constant := D8S'Last / LM;

      subtype D9S is GF64_Natural_Limb range 0 .. 238 * MGFLP + C8UB;
      D9 : D9S;
      C9UB : constant := D9S'Last / LM;

      subtype D10S is GF64_Natural_Limb range 0 .. 201 * MGFLP + C9UB;
      D10 : D10S;
      C10UB : constant := D10S'Last / LM;

      subtype D11S is GF64_Natural_Limb range 0 .. 164 * MGFLP + C10UB;
      D11 : D11S;
      C11UB : constant := D11S'Last / LM;

      subtype D12S is GF64_Natural_Limb range 0 .. 127 * MGFLP + C11UB;
      D12 : D12S;
      C12UB : constant := D12S'Last / LM;

      subtype D13S is GF64_Natural_Limb range 0 .. 90 * MGFLP + C12UB;
      D13 : D13S;
      C13UB : constant := D13S'Last / LM;

      subtype D14S is GF64_Natural_Limb range 0 .. 53 * MGFLP + C13UB;
      D14 : D14S;
      C14UB : constant := D14S'Last / LM;

      subtype D15S is GF64_Natural_Limb range 0 .. 16 * MGFLP + C14UB;
      D15 : D15S;
      C15UB : constant := D15S'Last / LM;
   begin
      T0 := LP (L0 * R0);
      T16 := LP (L15 * R1)  + LP (L14 * R2)  + LP (L13 * R3) +
             LP (L12 * R4)  + LP (L11 * R5)  + LP (L10 * R6) +
             LP (L9  * R7)  + LP (L8  * R8)  + LP (L7  * R9) +
             LP (L6  * R10) + LP (L5  * R11) + LP (L4  * R12) +
             LP (L3  * R13) + LP (L2  * R14) + LP (L1  * R15);
      D0  := T0  + R2256 * T16;
      C := D0 / LM;
      pragma Assert (C <= C0UB);
      D0 := D0 mod LM;
      pragma Assert_And_Cut (D0 in U64NL and
                             C <= C0UB);

      T1 := LP (L1 * R0) + LP (L0 * R1);
      T17 := LP (L15 * R2)  + LP (L14 * R3)  + LP (L13 * R4) +
             LP (L12 * R5)  + LP (L11 * R6)  + LP (L10 * R7) +
             LP (L9  * R8)  + LP (L8  * R9)  + LP (L7  * R10) +
             LP (L6  * R11) + LP (L5  * R12) + LP (L4  * R13) +
             LP (L3  * R14) + LP (L2  * R15);
      D1  := T1  + R2256 * T17 + C;
      C := D1 / LM;
      D1 := D1 mod LM;
      pragma Assert_And_Cut (D0 in U64NL and
                             D1 in U64NL and
                             C <= C1UB);

      T2 := LP (L2 * R0) + LP (L1 * R1) + LP (L0 * R2);
      T18 := LP (L15 * R3)  + LP (L14 * R4)  + LP (L13 * R5) +
             LP (L12 * R6)  + LP (L11 * R7)  + LP (L10 * R8) +
             LP (L9  * R9)  + LP (L8  * R10) + LP (L7  * R11) +
             LP (L6  * R12) + LP (L5  * R13) + LP (L4  * R14) +
             LP (L3  * R15);
      D2  := T2  + R2256 * T18 + C;
      C := D2 / LM;
      D2 := D2 mod LM;
      pragma Assert_And_Cut (D0 in U64NL and
                             D1 in U64NL and
                             D2 in U64NL and
                             C <= C2UB);

      T3 := LP (L3 * R0) + LP (L2 * R1) + LP (L1 * R2) +
            LP (L0 * R3);
      T19 := LP (L15 * R4)  + LP (L14 * R5)  + LP (L13 * R6) +
             LP (L12 * R7)  + LP (L11 * R8)  + LP (L10 * R9) +
             LP (L9  * R10) + LP (L8  * R11) + LP (L7  * R12) +
             LP (L6  * R13) + LP (L5  * R14) + LP (L4  * R15);
      D3  := T3  + R2256 * T19 + C;
      C := D3 / LM;
      D3 := D3 mod LM;
      pragma Assert_And_Cut (D0 in U64NL and
                             D1 in U64NL and
                             D2 in U64NL and
                             D3 in U64NL and
                             C <= C3UB);

      T4 := LP (L4 * R0) + LP (L3 * R1) + LP (L2 * R2) +
            LP (L1 * R3) + LP (L0 * R4);
      T20 := LP (L15 * R5)  + LP (L14 * R6)  + LP (L13 * R7) +
             LP (L12 * R8)  + LP (L11 * R9)  + LP (L10 * R10) +
             LP (L9  * R11) + LP (L8  * R12) + LP (L7  * R13) +
             LP (L6  * R14) + LP (L5  * R15);
      D4  := T4  + R2256 * T20 + C;
      C := D4 / LM;
      D4 := D4 mod LM;
      pragma Assert_And_Cut (D0 in U64NL and
                             D1 in U64NL and
                             D2 in U64NL and
                             D3 in U64NL and
                             D4 in U64NL and
                             C <= C4UB);

      T5 := LP (L5 * R0) + LP (L4 * R1) + LP (L3 * R2) +
            LP (L2 * R3) + LP (L1 * R4) + LP (L0 * R5);
      T21 := LP (L15 * R6)  + LP (L14 * R7)  + LP (L13 * R8) +
             LP (L12 * R9)  + LP (L11 * R10) + LP (L10 * R11) +
             LP (L9  * R12) + LP (L8  * R13) + LP (L7  * R14) +
             LP (L6  * R15);
      D5  := T5  + R2256 * T21 + C;
      C := D5 / LM;
      D5 := D5 mod LM;
      pragma Assert_And_Cut (D0 in U64NL and
                             D1 in U64NL and
                             D2 in U64NL and
                             D3 in U64NL and
                             D4 in U64NL and
                             D5 in U64NL and
                             C <= C5UB);

      T6 := LP (L6 * R0) + LP (L5 * R1) + LP (L4 * R2) +
            LP (L3 * R3) + LP (L2 * R4) + LP (L1 * R5) +
            LP (L0 * R6);
      T22 := LP (L15 * R7)  + LP (L14 * R8)  + LP (L13 * R9) +
             LP (L12 * R10) + LP (L11 * R11) + LP (L10 * R12) +
             LP (L9  * R13) + LP (L8  * R14) + LP (L7  * R15);
      D6  := T6  + R2256 * T22 + C;
      C := D6 / LM;
      D6 := D6 mod LM;

      pragma Assert_And_Cut (D0 in U64NL and
                             D1 in U64NL and
                             D2 in U64NL and
                             D3 in U64NL and
                             D4 in U64NL and
                             D5 in U64NL and
                             D6 in U64NL and
                             C <= C6UB);

      T7 := LP (L7 * R0) + LP (L6 * R1) + LP (L5 * R2) +
            LP (L4 * R3) + LP (L3 * R4) + LP (L2 * R5) +
            LP (L1 * R6) + LP (L0 * R7);
      T23 := LP (L15 * R8)  + LP (L14 * R9)  + LP (L13 * R10) +
             LP (L12 * R11) + LP (L11 * R12) + LP (L10 * R13) +
             LP (L9  * R14) + LP (L8  * R15);
      D7  := T7  + R2256 * T23 + C;
      C := D7 / LM;
      D7 := D7 mod LM;

      pragma Assert_And_Cut (D0 in U64NL and
                             D1 in U64NL and
                             D2 in U64NL and
                             D3 in U64NL and
                             D4 in U64NL and
                             D5 in U64NL and
                             D6 in U64NL and
                             D7 in U64NL and
                             C <= C7UB);


      T8 := LP (L8 * R0) + LP (L7 * R1) + LP (L6 * R2) +
            LP (L5 * R3) + LP (L4 * R4) + LP (L3 * R5) +
            LP (L2 * R6) + LP (L1 * R7) + LP (L0 * R8);
      T24 := LP (L15 * R9)  + LP (L14 * R10) + LP (L13 * R11) +
             LP (L12 * R12) + LP (L11 * R13) + LP (L10 * R14) +
             LP (L9  * R15);
      D8  := T8  + R2256 * T24 + C;
      C := D8 / LM;
      D8 := D8 mod LM;

      pragma Assert_And_Cut (D0 in U64NL and
                             D1 in U64NL and
                             D2 in U64NL and
                             D3 in U64NL and
                             D4 in U64NL and
                             D5 in U64NL and
                             D6 in U64NL and
                             D7 in U64NL and
                             D8 in U64NL and
                             C <= C8UB);


      T9 := LP (L9 * R0) + LP (L8 * R1) + LP (L7 * R2) +
        LP (L6 * R3) + LP (L5 * R4) + LP (L4 * R5) +
        LP (L3 * R6) + LP (L2 * R7) + LP (L1 * R8) +
        LP (L0 * R9);
      T25 := LP (L15 * R10) + LP (L14 * R11) + LP (L13 * R12) +
        LP (L12 * R13) + LP (L11 * R14) + LP (L10 * R15);
      D9  := T9  + R2256 * T25 + C;
      C := D9 / LM;
      D9 := D9 mod LM;

      pragma Assert_And_Cut (D0 in U64NL and
                             D1 in U64NL and
                             D2 in U64NL and
                             D3 in U64NL and
                             D4 in U64NL and
                             D5 in U64NL and
                             D6 in U64NL and
                             D7 in U64NL and
                             D8 in U64NL and
                             D9 in U64NL and
                             C <= C9UB);

      T10 := LP (L10 * R0) + LP (L9 * R1) + LP (L8 * R2) +
        LP (L7  * R3) + LP (L6 * R4) + LP (L5 * R5) +
        LP (L4  * R6) + LP (L3 * R7) + LP (L2 * R8) +
        LP (L1  * R9) + LP (L0 * R10);
      T26 := LP (L15 * R11) + LP (L14 * R12) + LP (L13 * R13) +
        LP (L12 * R14) + LP (L11 * R15);
      D10 := T10 + R2256 * T26 + C;
      C := D10 / LM;
      D10 := D10 mod LM;

      pragma Assert_And_Cut (D0 in U64NL and
                             D1 in U64NL and
                             D2 in U64NL and
                             D3 in U64NL and
                             D4 in U64NL and
                             D5 in U64NL and
                             D6 in U64NL and
                             D7 in U64NL and
                             D8 in U64NL and
                             D9 in U64NL and
                             D10 in U64NL and
                             C <= C10UB);

      T11 := LP (L11 * R0) + LP (L10 * R1)  + LP (L9 * R2) +
        LP (L8  * R3) + LP (L7  * R4)  + LP (L6 * R5) +
        LP (L5  * R6) + LP (L4  * R7)  + LP (L3 * R8) +
        LP (L2  * R9) + LP (L1  * R10) + LP (L0 * R11);
      T27 := LP (L15 * R12) + LP (L14 * R13) + LP (L13 * R14) +
        LP (L12 * R15);
      D11 := T11 + R2256 * T27 + C;
      C := D11 / LM;
      D11 := D11 mod LM;

      pragma Assert_And_Cut (D0 in U64NL and
                             D1 in U64NL and
                             D2 in U64NL and
                             D3 in U64NL and
                             D4 in U64NL and
                             D5 in U64NL and
                             D6 in U64NL and
                             D7 in U64NL and
                             D8 in U64NL and
                             D9 in U64NL and
                             D10 in U64NL and
                             D11 in U64NL and
                             C <= C11UB);


      T12 := LP (L12 * R0) + LP (L11 * R1)  + LP (L10 * R2) +
        LP (L9  * R3) + LP (L8  * R4)  + LP (L7  * R5) +
        LP (L6  * R6) + LP (L5  * R7)  + LP (L4  * R8) +
        LP (L3  * R9) + LP (L2  * R10) + LP (L1  * R11) +
        LP (L0  * R12);
      T28 := LP (L15 * R13) + LP (L14 * R14) + LP (L13 * R15);
      D12 := T12 + R2256 * T28 + C;
      C := D12 / LM;
      D12 := D12 mod LM;

      pragma Assert_And_Cut (D0 in U64NL and
                             D1 in U64NL and
                             D2 in U64NL and
                             D3 in U64NL and
                             D4 in U64NL and
                             D5 in U64NL and
                             D6 in U64NL and
                             D7 in U64NL and
                             D8 in U64NL and
                             D9 in U64NL and
                             D10 in U64NL and
                             D11 in U64NL and
                             D12 in U64NL and
                             C <= C12UB);


      T13 := LP (L13 * R0)  + LP (L12 * R1)  + LP (L11 * R2) +
        LP (L10 * R3)  + LP (L9  * R4)  + LP (L8  * R5) +
        LP (L7  * R6)  + LP (L6  * R7)  + LP (L5  * R8) +
        LP (L4  * R9)  + LP (L3  * R10) + LP (L2  * R11) +
        LP (L1  * R12) + LP (L0  * R13);
      T29 := LP (L15 * R14) + LP (L14 * R15);
      D13 := T13 + R2256 * T29 + C;
      C := D13 / LM;
      D13 := D13 mod LM;

      pragma Assert_And_Cut (D0 in U64NL and
                             D1 in U64NL and
                             D2 in U64NL and
                             D3 in U64NL and
                             D4 in U64NL and
                             D5 in U64NL and
                             D6 in U64NL and
                             D7 in U64NL and
                             D8 in U64NL and
                             D9 in U64NL and
                             D10 in U64NL and
                             D11 in U64NL and
                             D12 in U64NL and
                             D13 in U64NL and
                             C <= C13UB);

      T14 := LP (L14 * R0)  + LP (L13 * R1)  + LP (L12 * R2) +
        LP (L11 * R3)  + LP (L10 * R4)  + LP (L9  * R5) +
        LP (L8  * R6)  + LP (L7  * R7)  + LP (L6  * R8) +
        LP (L5  * R9)  + LP (L4  * R10) + LP (L3  * R11) +
        LP (L2  * R12) + LP (L1  * R13) + LP (L0  * R14);
      T30 := LP (L15 * R15);
      D14 := T14 + R2256 * T30 + C;
      C := D14 / LM;
      D14 := D14 mod LM;

      pragma Assert_And_Cut (D0 in U64NL and
                             D1 in U64NL and
                             D2 in U64NL and
                             D3 in U64NL and
                             D4 in U64NL and
                             D5 in U64NL and
                             D6 in U64NL and
                             D7 in U64NL and
                             D8 in U64NL and
                             D9 in U64NL and
                             D10 in U64NL and
                             D11 in U64NL and
                             D12 in U64NL and
                             D13 in U64NL and
                             D14 in U64NL and
                             C <= C14UB);

      T15 := LP (L15 * R0)  + LP (L14 * R1)  + LP (L13 * R2) +
             LP (L12 * R3)  + LP (L11 * R4)  + LP (L10 * R5) +
             LP (L9  * R6)  + LP (L8  * R7)  + LP (L7  * R8) +
             LP (L6  * R9)  + LP (L5  * R10) + LP (L4  * R11) +
             LP (L3  * R12) + LP (L2  * R13) + LP (L1  * R14) +
             LP (L0  * R15);
      D15 := T15 + C;
      C := D15 / LM;
      D15 := D15 mod LM;

      pragma Assert_And_Cut (D0 in U64NL and
                             D1 in U64NL and
                             D2 in U64NL and
                             D3 in U64NL and
                             D4 in U64NL and
                             D5 in U64NL and
                             D6 in U64NL and
                             D7 in U64NL and
                             D8 in U64NL and
                             D9 in U64NL and
                             D10 in U64NL and
                             D11 in U64NL and
                             D12 in U64NL and
                             D13 in U64NL and
                             D14 in U64NL and
                             D15 in U64NL and
                             C <= C15UB);

      --  The carry from D15 is now multiplied by R2256 and added
      --  to D0
      pragma Assert (C15UB = 1048596);
      D0 := D0 + R2256 * C;
      pragma Assert (D0 <= LMM1 + R2256 * C15UB);

      declare
         R  : GF32 with Relaxed_Initialization;
         C2 : GF32_Normal_Limb;
         T  : GF32_Any_Limb;
      begin
         R (0) := I32 (D0) mod LM;
         C2 := I32 (D0) / LM;
         pragma Assert (R (0)'Initialized and C2 <= 609);

         T := I32 (D1) + C2;
         R (1) := T mod LM;
         C2 := T / LM;
         pragma Assert (R (0 .. 1)'Initialized and C2 <= 1);

         T := I32 (D2) + C2;
         R (2) := T mod LM;
         C2 := T / LM;
         pragma Assert (R (0 .. 2)'Initialized and C2 <= 1);

         T := I32 (D3) + C2;
         R (3) := T mod LM;
         C2 := T / LM;
         pragma Assert (R (0 .. 3)'Initialized and C2 <= 1);

         T := I32 (D4) + C2;
         R (4) := T mod LM;
         C2 := T / LM;
         pragma Assert (R (0 .. 4)'Initialized and C2 <= 1);

         T := I32 (D5) + C2;
         R (5) := T mod LM;
         C2 := T / LM;
         pragma Assert (R (0 .. 5)'Initialized and C2 <= 1);

         T := I32 (D6) + C2;
         R (6) := T mod LM;
         C2 := T / LM;
         pragma Assert (R (0 .. 6)'Initialized and C2 <= 1);

         T := I32 (D7) + C2;
         R (7) := T mod LM;
         C2 := T / LM;
         pragma Assert (R (0 .. 7)'Initialized and C2 <= 1);

         T := I32 (D8) + C2;
         R (8) := T mod LM;
         C2 := T / LM;
         pragma Assert (R (0 .. 8)'Initialized and C2 <= 1);

         T := I32 (D9) + C2;
         R (9) := T mod LM;
         C2 := T / LM;
         pragma Assert (R (0 .. 9)'Initialized and C2 <= 1);

         T := I32 (D10) + C2;
         R (10) := T mod LM;
         C2 := T / LM;
         pragma Assert (R (0 .. 10)'Initialized and C2 <= 1);

         T := I32 (D11) + C2;
         R (11) := T mod LM;
         C2 := T / LM;
         pragma Assert (R (0 .. 11)'Initialized and C2 <= 1);

         T := I32 (D12) + C2;
         R (12) := T mod LM;
         C2 := T / LM;
         pragma Assert (R (0 .. 12)'Initialized and C2 <= 1);

         T := I32 (D13) + C2;
         R (13) := T mod LM;
         C2 := T / LM;
         pragma Assert (R (0 .. 13)'Initialized and C2 <= 1);

         T := I32 (D14) + C2;
         R (14) := T mod LM;
         C2 := T / LM;
         pragma Assert (R (0 .. 14)'Initialized and C2 <= 1);

         T := I32 (D15) + C2;
         R (15) := T mod LM;
         C2 := T / LM;
         pragma Assert (R (0 .. 15)'Initialized and C2 <= 1);

         pragma Assert (R'Initialized and C2 <= 1);

         R (0) := R (0) + R2256 * C2;

         return Car.Nearlynormal_To_Normal (Nearlynormal_GF (R));
      end;
   end M2;

   function "*" (Left, Right : in Normal_GF) return Normal_GF renames M2;

   pragma Unreferenced (M1);

   --------------------------------------------------------
   --  Constant time equality test
   --------------------------------------------------------

   function Equal (X, Y : in Byte_Seq) return Boolean
   is
      D : Boolean := True;
   begin
      for I in N32 range X'Range loop
         pragma Loop_Optimize (No_Unroll);
         D := D and (X (I) = Y (I));
         pragma Loop_Invariant
           (D = (for all J in N32 range X'First .. I => X (J) = Y (J)));
      end loop;

      return D;
   end Equal;

   --------------------------------------------------------
   --  Utility functions
   --------------------------------------------------------

   function To_Byte_Seq (S : String) return Byte_Seq
   is
      Ret : Byte_Seq (0 .. S'Length - 1);
   begin
      for I in Ret'Range loop
         Ret (I) := Character'Pos (S (S'First + Natural (I)));
      end loop;
      return Ret;
   end To_Byte_Seq;

   --------------------------------------------------------
   --  Data sanitization
   --------------------------------------------------------

   procedure Sanitize (R : out Byte_Seq) is separate;

   procedure Sanitize_U16 (R : out U16) is separate;

   procedure Sanitize_U32 (R : out U32) is separate;

   procedure Sanitize_U64 (R : out U64) is separate;

   procedure Sanitize_GF16 (R : out Normal_GF) is separate;

   procedure Sanitize_GF32 (R : out GF32) is separate;

   procedure Sanitize_GF64_PA (R : out GF64_PA) is separate;

   procedure Sanitize_I64_Seq (R : out I64_Seq) is separate;

   procedure Sanitize_U32_Seq (R : out U32_Seq) is separate;

   procedure Sanitize_Boolean (R : out Boolean) is separate;

end SPARKNaCl;
