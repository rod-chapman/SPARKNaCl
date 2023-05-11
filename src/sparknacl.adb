with SPARKNaCl.Car;
package body SPARKNaCl
  with SPARK_Mode => On
is
   pragma Warnings (GNATProve, Off, "pragma * ignored (not yet supported)");

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
         pragma Loop_Invariant (Carry >= 0);
         pragma Loop_Invariant (Carry <= 1);
      end loop;

      --  Substitute I=15 into the loop invariant and simplify to get:
      pragma Assert_And_Cut
        ((for all J in Index_16 => R (J)'Initialized) and then
         (for all J in Index_16 => R (J) in GF32_Normal_Limb) and then
          Carry >= 0 and then
          Carry <= 1);

      --  and therefore...
      pragma Assert (R'Initialized);
      pragma Assert (R in Normal_GF32);

      --  The "Carry" from limb 15 can only be 0 or 1, so we
      --  multiply that by R2256 and add to limb 0. R is then a
      --  "Nearlynormal_GF", so only a _single_ call to
      --  Car.Nearlynormal_To_Normal is required
      R (0) := R (0) + (R2256 * Carry);

      pragma Assert (R in Nearlynormal_GF);

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

   -----------------------------------------------------
   --  Subtypes and constants supporting "*" operator
   -----------------------------------------------------

   subtype U32NL is U32 range 0 .. LMM1;
   subtype GF64_Natural_Limb is I64 range 0 .. (MGFLC * MGFLP);

   --  Limb Product (LP) - a subtype for representing the product
   --  of two normalized GF64 Limbs
   subtype LP  is GF64_Natural_Limb range 0 .. MGFLP;

   --  A fully normalized limb, signed 64-bit representation
   subtype I64NL is I64 range 0 .. LMM1;

   --  Upper Bounds on Digits and Carry values during phase 1
   --  ripple carry and reduction.

   --  Digit 0 has same upper-bound as GF64_Natural_Limb, and no carry-in
   subtype D0S is GF64_Natural_Limb;
   C0UB : constant := D0S'Last / LM;

   --  The upper-bound on D0S is GF64_Natural_Limb'Last = (MGFLC * MGFLP).
   --  Where MGFLC is described in sparknacl.ads
   --
   --  For the remaining intermediate results, the upper-bound decreases
   --  by 37*MGFLP for each digit.
   --
   --  Intermediate digit D1 is the sum of (2 + (R2256 * 14)) multiplications
   --  so is bounded to (2+38*14)*MGFLP = 534*MGFLP
   subtype D1S is GF64_Natural_Limb range 0 .. 534 * MGFLP + C0UB;
   C1UB : constant := D1S'Last / LM;

   --  D2S is bounded to (3+38*13)*MGFLP = 497*MGFLP
   subtype D2S is GF64_Natural_Limb range 0 .. 497 * MGFLP + C1UB;
   C2UB : constant := D2S'Last / LM;

   --  and so on... the upper bound decreases by 37*MGFLP each time...
   subtype D3S is GF64_Natural_Limb range 0 .. 460 * MGFLP + C2UB;
   C3UB : constant := D3S'Last / LM;

   subtype D4S is GF64_Natural_Limb range 0 .. 423 * MGFLP + C3UB;
   C4UB : constant := D4S'Last / LM;

   subtype D5S is GF64_Natural_Limb range 0 .. 386 * MGFLP + C4UB;
   C5UB : constant := D5S'Last / LM;

   subtype D6S is GF64_Natural_Limb range 0 .. 349 * MGFLP + C5UB;
   C6UB : constant := D6S'Last / LM;

   subtype D7S is GF64_Natural_Limb range 0 .. 312 * MGFLP + C6UB;
   C7UB : constant := D7S'Last / LM;

   subtype D8S is GF64_Natural_Limb range 0 .. 275 * MGFLP + C7UB;
   C8UB : constant := D8S'Last / LM;

   subtype D9S is GF64_Natural_Limb range 0 .. 238 * MGFLP + C8UB;
   C9UB : constant := D9S'Last / LM;

   subtype D10S is GF64_Natural_Limb range 0 .. 201 * MGFLP + C9UB;
   C10UB : constant := D10S'Last / LM;

   subtype D11S is GF64_Natural_Limb range 0 .. 164 * MGFLP + C10UB;
   C11UB : constant := D11S'Last / LM;

   subtype D12S is GF64_Natural_Limb range 0 .. 127 * MGFLP + C11UB;
   C12UB : constant := D12S'Last / LM;

   subtype D13S is GF64_Natural_Limb range 0 .. 90 * MGFLP + C12UB;
   C13UB : constant := D13S'Last / LM;

   subtype D14S is GF64_Natural_Limb range 0 .. 53 * MGFLP + C13UB;
   C14UB : constant := D14S'Last / LM;

   subtype D15S is GF64_Natural_Limb range 0 .. 16 * MGFLP + C14UB;
   C15UB : constant := D15S'Last / LM;

   --  Phase 2 carry and reduction
   --
   --  Knowing the value of C15UB, we can deduce the upper-bound
   --  on D0, and thus the upper-bound on the carry from D0
   P2_D0UB : constant := LMM1 + R2256 * C15UB;
   P2_C2UB : constant := P2_D0UB / LM;

   --  Input to phase 2 reduction is all digits reduced except
   --  LSB, which may be up to P2_D0UB
   type Mul_Product is array (Index_16) of GF64_Natural_Limb
     with Dynamic_Predicate => Mul_Product (0) >= 0 and
                               Mul_Product (0) <= P2_D0UB and
                               Mul_Product (1) in I64NL and
                               Mul_Product (2) in I64NL and
                               Mul_Product (3) in I64NL and
                               Mul_Product (4) in I64NL and
                               Mul_Product (5) in I64NL and
                               Mul_Product (6) in I64NL and
                               Mul_Product (7) in I64NL and
                               Mul_Product (8) in I64NL and
                               Mul_Product (9) in I64NL and
                               Mul_Product (10) in I64NL and
                               Mul_Product (11) in I64NL and
                               Mul_Product (12) in I64NL and
                               Mul_Product (13) in I64NL and
                               Mul_Product (14) in I64NL and
                               Mul_Product (15) in I64NL;


   function Mul_Phase2_Reduction (D : in Mul_Product) return Normal_GF
     with Global => null;

   function Mul_Phase2_Reduction (D : in Mul_Product) return Normal_GF
   is
      --  Local vars used in Phase 2 carry and reduction
      R  : GF32 with Relaxed_Initialization;
      C2 : GF32_Normal_Limb;
      T  : GF32_Any_Limb;
   begin
      --  Sanity checks on these constants against actual literal values
      pragma Assert (C15UB   =  1_048_596);
      pragma Assert (P2_D0UB = 39_912_183);
      pragma Assert (P2_C2UB =        609);

      --  Phase 2 carry and reduction.
      --  From here on, all arithmetic can be 32-bit.
      R (0) := I32 (D (0)) mod LM;
      C2 := I32 (D (0)) / LM;
      pragma Assert (R (0)'Initialized);
      pragma Assert (R (0) in GF32_Normal_Limb);
      pragma Assert (C2 <= P2_C2UB);

      T := I32 (D (1)) + C2;
      R (1) := T mod LM;
      C2 := T / LM;
      --  C2 is now in range 0 .. 1, and it stays that way...
      pragma Assert (R (0 .. 1)'Initialized and C2 <= 1);

      T := I32 (D (2)) + C2;
      R (2) := T mod LM;
      C2 := T / LM;
      pragma Assert (R (0 .. 2)'Initialized and C2 <= 1);

      T := I32 (D (3)) + C2;
      R (3) := T mod LM;
      C2 := T / LM;
      pragma Assert (R (0 .. 3)'Initialized and C2 <= 1);

      T := I32 (D (4)) + C2;
      R (4) := T mod LM;
      C2 := T / LM;
      pragma Assert (R (0 .. 4)'Initialized and C2 <= 1);

      T := I32 (D (5)) + C2;
      R (5) := T mod LM;
      C2 := T / LM;
      pragma Assert (R (0 .. 5)'Initialized and C2 <= 1);

      T := I32 (D (6)) + C2;
      R (6) := T mod LM;
      C2 := T / LM;
      pragma Assert (R (0 .. 6)'Initialized and C2 <= 1);

      T := I32 (D (7)) + C2;
      R (7) := T mod LM;
      C2 := T / LM;
      pragma Assert (R (0 .. 7)'Initialized and C2 <= 1);

      T := I32 (D (8)) + C2;
      R (8) := T mod LM;
      C2 := T / LM;
      pragma Assert (R (0 .. 8)'Initialized and C2 <= 1);

      T := I32 (D (9)) + C2;
      R (9) := T mod LM;
      C2 := T / LM;
      pragma Assert (R (0 .. 9)'Initialized and C2 <= 1);

      T := I32 (D (10)) + C2;
      R (10) := T mod LM;
      C2 := T / LM;
      pragma Assert (R (0 .. 10)'Initialized and C2 <= 1);

      T := I32 (D (11)) + C2;
      R (11) := T mod LM;
      C2 := T / LM;
      pragma Assert (R (0 .. 11)'Initialized and C2 <= 1);

      T := I32 (D (12)) + C2;
      R (12) := T mod LM;
      C2 := T / LM;
      pragma Assert (R (0 .. 12)'Initialized and C2 <= 1);

      T := I32 (D (13)) + C2;
      R (13) := T mod LM;
      C2 := T / LM;
      pragma Assert (R (0 .. 13)'Initialized and C2 <= 1);

      T := I32 (D (14)) + C2;
      R (14) := T mod LM;
      C2 := T / LM;
      pragma Assert (R (0 .. 14)'Initialized and C2 <= 1);

      T := I32 (D (15)) + C2;
      R (15) := T mod LM;
      C2 := T / LM;
      pragma Assert (R (0 .. 15)'Initialized and C2 <= 1);

      pragma Assert (R'Initialized and C2 <= 1);

      R (0) := R (0) + R2256 * C2;

      return Car.Nearlynormal_To_Normal (Nearlynormal_GF (R));
   end Mul_Phase2_Reduction;

   function "*" (Left, Right : in Normal_GF) return Normal_GF
   is
      L0  : constant U32NL := U32NL (Left (0));
      L1  : constant U32NL := U32NL (Left (1));
      L2  : constant U32NL := U32NL (Left (2));
      L3  : constant U32NL := U32NL (Left (3));
      L4  : constant U32NL := U32NL (Left (4));
      L5  : constant U32NL := U32NL (Left (5));
      L6  : constant U32NL := U32NL (Left (6));
      L7  : constant U32NL := U32NL (Left (7));
      L8  : constant U32NL := U32NL (Left (8));
      L9  : constant U32NL := U32NL (Left (9));
      L10 : constant U32NL := U32NL (Left (10));
      L11 : constant U32NL := U32NL (Left (11));
      L12 : constant U32NL := U32NL (Left (12));
      L13 : constant U32NL := U32NL (Left (13));
      L14 : constant U32NL := U32NL (Left (14));
      L15 : constant U32NL := U32NL (Left (15));
      R0  : constant U32NL := U32NL (Right (0));
      R1  : constant U32NL := U32NL (Right (1));
      R2  : constant U32NL := U32NL (Right (2));
      R3  : constant U32NL := U32NL (Right (3));
      R4  : constant U32NL := U32NL (Right (4));
      R5  : constant U32NL := U32NL (Right (5));
      R6  : constant U32NL := U32NL (Right (6));
      R7  : constant U32NL := U32NL (Right (7));
      R8  : constant U32NL := U32NL (Right (8));
      R9  : constant U32NL := U32NL (Right (9));
      R10 : constant U32NL := U32NL (Right (10));
      R11 : constant U32NL := U32NL (Right (11));
      R12 : constant U32NL := U32NL (Right (12));
      R13 : constant U32NL := U32NL (Right (13));
      R14 : constant U32NL := U32NL (Right (14));
      R15 : constant U32NL := U32NL (Right (15));

      C : GF64_Natural_Limb;
      D : Mul_Product;
   begin
      D := (others => 0);

      -----------------------------------------------------------------
      --  Having unrolled the loops here fully, the intermediate
      --  digits could be computed in any order, or even in parallel.
      --
      --  BUT... if we compute in order D (0) .. D (15), then we can
      --  normalize (D (0) mod LM) AND compute the carry C from D (0) to D (1)
      --  immediately, and incorporate that carry into the calculation
      --  of D (1).
      --
      --  This trick essentially fuses the first "CAR" loop into this
      --  code in-line, and allows us to assert a tight upper-bound on
      --  the value of C as we go along.
      -----------------------------------------------------------------
      declare
         L15R1  : constant LP := LP (L15 * R1);
         L14R2  : constant LP := LP (L14 * R2);
         L13R3  : constant LP := LP (L13 * R3);
         L12R4  : constant LP := LP (L12 * R4);
         L11R5  : constant LP := LP (L11 * R5);
         L10R6  : constant LP := LP (L10 * R6);
         L9R7   : constant LP := LP (L9  * R7);
         L8R8   : constant LP := LP (L8  * R8);
         L7R9   : constant LP := LP (L7  * R9);
         L6R10  : constant LP := LP (L6  * R10);
         L5R11  : constant LP := LP (L5  * R11);
         L4R12  : constant LP := LP (L4  * R12);
         L3R13  : constant LP := LP (L3  * R13);
         L2R14  : constant LP := LP (L2  * R14);
         L1R15  : constant LP := LP (L1  * R15);

         L0R0   : constant LP := LP (L0 * R0);
         D0     : D0S;
      begin
         D0 := L15R1 + L14R2 + L13R3 +
               L12R4 + L11R5 + L10R6 +
               L9R7  + L8R8  + L7R9 +
               L6R10 + L5R11 + L4R12 +
               L3R13 + L2R14 + L1R15;
         pragma Assert (D0 <= 15 * LP'Last);

         D0  := L0R0 + (R2256 * D0);
         --  Immediately compute C and normalize D (0)
         --  For proof of type safety and to prove that this converges,
         --  we only need to keep track of the fact that each digit is now
         --  normalized and assert an upper-bound on C.
         C := D0 / LM;
         D (0) := D0 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C0UB);


      declare
         L15R2  : constant LP := LP (L15 * R2);
         L14R3  : constant LP := LP (L14 * R3);
         L13R4  : constant LP := LP (L13 * R4);
         L12R5  : constant LP := LP (L12 * R5);
         L11R6  : constant LP := LP (L11 * R6);
         L10R7  : constant LP := LP (L10 * R7);
         L9R8   : constant LP := LP (L9  * R8);
         L8R9   : constant LP := LP (L8  * R9);
         L7R10  : constant LP := LP (L7  * R10);
         L6R11  : constant LP := LP (L6  * R11);
         L5R12  : constant LP := LP (L5  * R12);
         L4R13  : constant LP := LP (L4  * R13);
         L3R14  : constant LP := LP (L3  * R14);
         L2R15  : constant LP := LP (L2  * R15);

         L1R0   : constant LP := LP (L1 * R0);
         L0R1   : constant LP := LP (L0 * R1);
         D1     : D1S;
      begin
         --  And so on ... but add C from D (0) into the calculation of D (1)
         D1  := C + L1R0 + L0R1 +
                R2256 * (L15R2 + L14R3 + L13R4 +
                         L12R5 + L11R6 + L10R7 +
                         L9R8  + L8R9  + L7R10 +
                         L6R11 + L5R12 + L4R13 +
                         L3R14 + L2R15);
         C := D1 / LM;
         D (1) := D1 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C1UB);

      declare
         L15R3 : constant LP := LP (L15 * R3);
         L14R4 : constant LP := LP (L14 * R4);
         L13R5 : constant LP := LP (L13 * R5);
         L12R6 : constant LP := LP (L12 * R6);
         L11R7 : constant LP := LP (L11 * R7);
         L10R8 : constant LP := LP (L10 * R8);
         L9R9  : constant LP := LP (L9  * R9);
         L8R10 : constant LP := LP (L8  * R10);
         L7R11 : constant LP := LP (L7  * R11);
         L6R12 : constant LP := LP (L6  * R12);
         L5R13 : constant LP := LP (L5  * R13);
         L4R14 : constant LP := LP (L4  * R14);
         L3R15 : constant LP := LP (L3  * R15);

         L2R0  : constant LP := LP (L2 * R0);
         L1R1  : constant LP := LP (L1 * R1);
         L0R2  : constant LP := LP (L0 * R2);
         D2    : D2S;
      begin
         D2  := C + L2R0 + L1R1 + L0R2 +
                R2256 * (L15R3 + L14R4 + L13R5 +
                         L12R6 + L11R7 + L10R8 +
                         L9R9  + L8R10 + L7R11 +
                         L6R12 + L5R13 + L4R14 +
                         L3R15);

         C := D2 / LM;
         D (2) := D2 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C2UB);

      declare
         L15R4 : constant LP := LP (L15 * R4);
         L14R5 : constant LP := LP (L14 * R5);
         L13R6 : constant LP := LP (L13 * R6);
         L12R7 : constant LP := LP (L12 * R7);
         L11R8 : constant LP := LP (L11 * R8);
         L10R9 : constant LP := LP (L10 * R9);
         L9R10 : constant LP := LP (L9  * R10);
         L8R11 : constant LP := LP (L8  * R11);
         L7R12 : constant LP := LP (L7  * R12);
         L6R13 : constant LP := LP (L6  * R13);
         L5R14 : constant LP := LP (L5  * R14);
         L4R15 : constant LP := LP (L4  * R15);

         L3R0  : constant LP := LP (L3 * R0);
         L2R1  : constant LP := LP (L2 * R1);
         L1R2  : constant LP := LP (L1 * R2);
         L0R3  : constant LP := LP (L0 * R3);
         D3    : D3S;
      begin
         D3 := C + L3R0 + L2R1 + L1R2 + L0R3 +
               R2256 * (L15R4 + L14R5 + L13R6 +
                        L12R7 + L11R8 + L10R9 +
                        L9R10 + L8R11 + L7R12 +
                        L6R13 + L5R14 + L4R15);

         C := D3 / LM;
         D (3) := D3 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C3UB);

      declare
         L15R5  : constant LP := LP (L15 * R5);
         L14R6  : constant LP := LP (L14 * R6);
         L13R7  : constant LP := LP (L13 * R7);
         L12R8  : constant LP := LP (L12 * R8);
         L11R9  : constant LP := LP (L11 * R9);
         L10R10 : constant LP := LP (L10 * R10);
         L9R11  : constant LP := LP (L9  * R11);
         L8R12  : constant LP := LP (L8  * R12);
         L7R13  : constant LP := LP (L7  * R13);
         L6R14  : constant LP := LP (L6  * R14);
         L5R15  : constant LP := LP (L5  * R15);

         L4R0 : constant LP := LP (L4 * R0);
         L3R1 : constant LP := LP (L3 * R1);
         L2R2 : constant LP := LP (L2 * R2);
         L1R3 : constant LP := LP (L1 * R3);
         L0R4 : constant LP := LP (L0 * R4);
         D4   : D4S;
      begin
         D4 := C + L4R0 + L3R1 + L2R2 + L1R3 + L0R4 +
           R2256 * (L15R5 + L14R6 + L13R7 +
                    L12R8 + L11R9 + L10R10 +
                    L9R11 + L8R12 + L7R13 +
                    L6R14 + L5R15);

         C := D4 / LM;
         D (4) := D4 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C4UB);

      declare
         L15R6  : constant LP := LP (L15 * R6);
         L14R7  : constant LP := LP (L14 * R7);
         L13R8  : constant LP := LP (L13 * R8);
         L12R9  : constant LP := LP (L12 * R9);
         L11R10 : constant LP := LP (L11 * R10);
         L10R11 : constant LP := LP (L10 * R11);
         L9R12  : constant LP := LP (L9  * R12);
         L8R13  : constant LP := LP (L8  * R13);
         L7R14  : constant LP := LP (L7  * R14);
         L6R15  : constant LP := LP (L6  * R15);

         L5R0 : constant LP := LP (L5 * R0);
         L4R1 : constant LP := LP (L4 * R1);
         L3R2 : constant LP := LP (L3 * R2);
         L2R3 : constant LP := LP (L2 * R3);
         L1R4 : constant LP := LP (L1 * R4);
         L0R5 : constant LP := LP (L0 * R5);
         D5   : D5S;
      begin
         D5 := C + L5R0 + L4R1 + L3R2 + L2R3 + L1R4 + L0R5 +
           R2256 * (L15R6 + L14R7  + L13R8 +
                    L12R9 + L11R10 + L10R11 +
                    L9R12 + L8R13  + L7R14 +
                    L6R15);

         C := D5 / LM;
         D (5) := D5 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C5UB);

      declare
         L15R7  : constant LP := LP (L15 * R7);
         L14R8  : constant LP := LP (L14 * R8);
         L13R9  : constant LP := LP (L13 * R9);
         L12R10 : constant LP := LP (L12 * R10);
         L11R11 : constant LP := LP (L11 * R11);
         L10R12 : constant LP := LP (L10 * R12);
         L9R13  : constant LP := LP (L9  * R13);
         L8R14  : constant LP := LP (L8  * R14);
         L7R15  : constant LP := LP (L7  * R15);

         L6R0 : constant LP := LP (L6 * R0);
         L5R1 : constant LP := LP (L5 * R1);
         L4R2 : constant LP := LP (L4 * R2);
         L3R3 : constant LP := LP (L3 * R3);
         L2R4 : constant LP := LP (L2 * R4);
         L1R5 : constant LP := LP (L1 * R5);
         L0R6 : constant LP := LP (L0 * R6);
         D6   : D6S;
      begin
         D6 := C + L6R0 + L5R1 + L4R2 + L3R3 + L2R4 + L1R5 + L0R6 +
           R2256 * (L15R7  + L14R8  + L13R9 +
                    L12R10 + L11R11 + L10R12 +
                    L9R13  + L8R14  + L7R15);
         C := D6 / LM;
         D (6) := D6 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C6UB);

      declare
         L15R8  : constant LP := LP (L15 * R8);
         L14R9  : constant LP := LP (L14 * R9);
         L13R10 : constant LP := LP (L13 * R10);
         L12R11 : constant LP := LP (L12 * R11);
         L11R12 : constant LP := LP (L11 * R12);
         L10R13 : constant LP := LP (L10 * R13);
         L9R14  : constant LP := LP (L9  * R14);
         L8R15  : constant LP := LP (L8  * R15);

         L7R0 : constant LP := LP (L7 * R0);
         L6R1 : constant LP := LP (L6 * R1);
         L5R2 : constant LP := LP (L5 * R2);
         L4R3 : constant LP := LP (L4 * R3);
         L3R4 : constant LP := LP (L3 * R4);
         L2R5 : constant LP := LP (L2 * R5);
         L1R6 : constant LP := LP (L1 * R6);
         L0R7 : constant LP := LP (L0 * R7);
         D7   : D7S;
      begin
         D7 := C + L7R0 + L6R1 + L5R2 + L4R3 + L3R4 + L2R5 + L1R6 + L0R7 +
               R2256 * (L15R8  + L14R9  + L13R10 +
                        L12R11 + L11R12 + L10R13 +
                        L9R14  + L8R15);

         C := D7 / LM;
         D (7) := D7 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C7UB);

      declare
         L15R9  : constant LP := LP (L15 * R9);
         L14R10 : constant LP := LP (L14 * R10);
         L13R11 : constant LP := LP (L13 * R11);
         L12R12 : constant LP := LP (L12 * R12);
         L11R13 : constant LP := LP (L11 * R13);
         L10R14 : constant LP := LP (L10 * R14);
         L9R15  : constant LP := LP (L9  * R15);

         L8R0 : constant LP := LP (L8 * R0);
         L7R1 : constant LP := LP (L7 * R1);
         L6R2 : constant LP := LP (L6 * R2);
         L5R3 : constant LP := LP (L5 * R3);
         L4R4 : constant LP := LP (L4 * R4);
         L3R5 : constant LP := LP (L3 * R5);
         L2R6 : constant LP := LP (L2 * R6);
         L1R7 : constant LP := LP (L1 * R7);
         L0R8 : constant LP := LP (L0 * R8);
         D8   : D8S;
      begin
         D8 := C + L8R0 + L7R1 + L6R2 + L5R3 + L4R4 +
                   L3R5 + L2R6 + L1R7 + L0R8 +
               R2256 * (L15R9 + L14R10 + L13R11 +
                        L12R12 + L11R13 + L10R14 +
                        L9R15);

         C := D8 / LM;
         D (8) := D8 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C8UB);

      declare
         L15R10 : constant LP := LP (L15 * R10);
         L14R11 : constant LP := LP (L14 * R11);
         L13R12 : constant LP := LP (L13 * R12);
         L12R13 : constant LP := LP (L12 * R13);
         L11R14 : constant LP := LP (L11 * R14);
         L10R15 : constant LP := LP (L10 * R15);

         L9R0 : constant LP := LP (L9 * R0);
         L8R1 : constant LP := LP (L8 * R1);
         L7R2 : constant LP := LP (L7 * R2);
         L6R3 : constant LP := LP (L6 * R3);
         L5R4 : constant LP := LP (L5 * R4);
         L4R5 : constant LP := LP (L4 * R5);
         L3R6 : constant LP := LP (L3 * R6);
         L2R7 : constant LP := LP (L2 * R7);
         L1R8 : constant LP := LP (L1 * R8);
         L0R9 : constant LP := LP (L0 * R9);
         D9   : D9S;
      begin
         D9 := C + L9R0 + L8R1 + L7R2 + L6R3 + L5R4 +
                   L4R5 + L3R6 + L2R7 + L1R8 + L0R9 +
               R2256 * (L15R10 + L14R11 + L13R12 +
                        L12R13 + L11R14 + L10R15);

         C := D9 / LM;
         D (9) := D9 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C9UB);

      declare
         L15R11 : constant LP := LP (L15 * R11);
         L14R12 : constant LP := LP (L14 * R12);
         L13R13 : constant LP := LP (L13 * R13);
         L12R14 : constant LP := LP (L12 * R14);
         L11R15 : constant LP := LP (L11 * R15);

         L10R0 : constant LP := LP (L10 * R0);
         L9R1  : constant LP := LP (L9 * R1);
         L8R2  : constant LP := LP (L8 * R2);
         L7R3  : constant LP := LP (L7 * R3);
         L6R4  : constant LP := LP (L6 * R4);
         L5R5  : constant LP := LP (L5 * R5);
         L4R6  : constant LP := LP (L4 * R6);
         L3R7  : constant LP := LP (L3 * R7);
         L2R8  : constant LP := LP (L2 * R8);
         L1R9  : constant LP := LP (L1 * R9);
         L0R10 : constant LP := LP (L0 * R10);
         D10   : D10S;
      begin
         D10 := C + L10R0 + L9R1 + L8R2 + L7R3 + L6R4 + L5R5 +
                    L4R6  + L3R7 + L2R8 + L1R9 + L0R10 +
                R2256 * (L15R11 + L14R12 + L13R13 +
                         L12R14 + L11R15);

         C := D10 / LM;
         D (10) := D10 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C10UB);

      declare
         L15R12 : constant LP := LP (L15 * R12);
         L14R13 : constant LP := LP (L14 * R13);
         L13R14 : constant LP := LP (L13 * R14);
         L12R15 : constant LP := LP (L12 * R15);

         L11R0 : constant LP := LP (L11 * R0);
         L10R1 : constant LP := LP (L10 * R1);
         L9R2  : constant LP := LP (L9 * R2);
         L8R3  : constant LP := LP (L8 * R3);
         L7R4  : constant LP := LP (L7 * R4);
         L6R5  : constant LP := LP (L6 * R5);
         L5R6  : constant LP := LP (L5 * R6);
         L4R7  : constant LP := LP (L4 * R7);
         L3R8  : constant LP := LP (L3 * R8);
         L2R9  : constant LP := LP (L2 * R9);
         L1R10 : constant LP := LP (L1 * R10);
         L0R11 : constant LP := LP (L0 * R11);
         D11   : D11S;
      begin
         D11 := C + L11R0 + L10R1 + L9R2 + L8R3 + L7R4  + L6R5 +
                    L5R6  + L4R7  + L3R8 + L2R9 + L1R10 + L0R11 +
                R2256 * (L15R12 + L14R13 + L13R14 + L12R15);

         C := D11 / LM;
         D (11) := D11 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C11UB);

      declare
         L15R13 : constant LP := LP (L15 * R13);
         L14R14 : constant LP := LP (L14 * R14);
         L13R15 : constant LP := LP (L13 * R15);

         L12R0 : constant LP := LP (L12 * R0);
         L11R1 : constant LP := LP (L11 * R1);
         L10R2 : constant LP := LP (L10 * R2);
         L9R3  : constant LP := LP (L9 * R3);
         L8R4  : constant LP := LP (L8 * R4);
         L7R5  : constant LP := LP (L7 * R5);
         L6R6  : constant LP := LP (L6 * R6);
         L5R7  : constant LP := LP (L5 * R7);
         L4R8  : constant LP := LP (L4 * R8);
         L3R9  : constant LP := LP (L3 * R9);
         L2R10 : constant LP := LP (L2 * R10);
         L1R11 : constant LP := LP (L1 * R11);
         L0R12 : constant LP := LP (L0 * R12);
         D12   : D12S;
      begin
         D12 := C + L12R0 + L11R1 + L10R2 + L9R3 + L8R4  + L7R5 +
                    L6R6  + L5R7  + L4R8  + L3R9 + L2R10 + L1R11 +
                    L0R12 +
                R2256 * (L15R13 + L14R14 + L13R15);

         C := D12 / LM;
         D (12) := D12 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C12UB);

      declare
         L15R14 : constant LP := LP (L15 * R14);
         L14R15 : constant LP := LP (L14 * R15);

         L13R0 : constant LP := LP (L13 * R0);
         L12R1 : constant LP := LP (L12 * R1);
         L11R2 : constant LP := LP (L11 * R2);
         L10R3 : constant LP := LP (L10 * R3);
         L9R4  : constant LP := LP (L9 * R4);
         L8R5  : constant LP := LP (L8 * R5);
         L7R6  : constant LP := LP (L7 * R6);
         L6R7  : constant LP := LP (L6 * R7);
         L5R8  : constant LP := LP (L5 * R8);
         L4R9  : constant LP := LP (L4 * R9);
         L3R10 : constant LP := LP (L3 * R10);
         L2R11 : constant LP := LP (L2 * R11);
         L1R12 : constant LP := LP (L1 * R12);
         L0R13 : constant LP := LP (L0 * R13);
         D13   : D13S;
      begin
         D13 := C + L13R0 + L12R1 + L11R2 + L10R3 + L9R4  + L8R5 +
                    L7R6  + L6R7  + L5R8  + L4R9  + L3R10 + L2R11 +
                    L1R12 + L0R13 +
                R2256 * (L15R14 + L14R15);

         C := D13 / LM;
         D (13) := D13 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C13UB);

      declare
         L15R15 : constant LP := LP (L15 * R15);

         L14R0 : constant LP := LP (L14 * R0);
         L13R1 : constant LP := LP (L13 * R1);
         L12R2 : constant LP := LP (L12 * R2);
         L11R3 : constant LP := LP (L11 * R3);
         L10R4 : constant LP := LP (L10 * R4);
         L9R5  : constant LP := LP (L9 * R5);
         L8R6  : constant LP := LP (L8 * R6);
         L7R7  : constant LP := LP (L7 * R7);
         L6R8  : constant LP := LP (L6 * R8);
         L5R9  : constant LP := LP (L5 * R9);
         L4R10 : constant LP := LP (L4 * R10);
         L3R11 : constant LP := LP (L3 * R11);
         L2R12 : constant LP := LP (L2 * R12);
         L1R13 : constant LP := LP (L1 * R13);
         L0R14 : constant LP := LP (L0 * R14);
         D14   : D14S;
      begin
         D14 := C + L14R0 + L13R1 + L12R2 + L11R3 + L10R4 + L9R5 +
                    L8R6  + L7R7  + L6R8  + L5R9  + L4R10 + L3R11 +
                    L2R12 + L1R13 + L0R14 +
                R2256 * L15R15;

         C := D14 / LM;
         D (14) := D14 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C14UB);

      declare
         L15R0 : constant LP := LP (L15 * R0);
         L14R1 : constant LP := LP (L14 * R1);
         L13R2 : constant LP := LP (L13 * R2);
         L12R3 : constant LP := LP (L12 * R3);
         L11R4 : constant LP := LP (L11 * R4);
         L10R5 : constant LP := LP (L10 * R5);
         L9R6  : constant LP := LP (L9 * R6);
         L8R7  : constant LP := LP (L8 * R7);
         L7R8  : constant LP := LP (L7 * R8);
         L6R9  : constant LP := LP (L6 * R9);
         L5R10 : constant LP := LP (L5 * R10);
         L4R11 : constant LP := LP (L4 * R11);
         L3R12 : constant LP := LP (L3 * R12);
         L2R13 : constant LP := LP (L2 * R13);
         L1R14 : constant LP := LP (L1 * R14);
         L0R15 : constant LP := LP (L0 * R15);
         D15   : D15S;
      begin
         D15 := C + L15R0 + L14R1 + L13R2 + L12R3 + L11R4 + L10R5 +
                    L9R6  + L8R7  + L7R8  + L6R9  + L5R10 + L4R11 +
                    L3R12 + L2R13 + L1R14 + L0R15;

         C := D15 / LM;
         D (15) := D15 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C15UB);

      --  The carry from D (15) is now multiplied by R2256 and added
      --  to D (0)
      D (0) := D (0) + R2256 * C;
      pragma Assert (D in Mul_Product);

      return Mul_Phase2_Reduction (D);
   end "*";

   function Square (A : in Normal_GF) return Normal_GF
   is
      L0  : constant U32NL := U32NL (A (0));
      L1  : constant U32NL := U32NL (A (1));
      L2  : constant U32NL := U32NL (A (2));
      L3  : constant U32NL := U32NL (A (3));
      L4  : constant U32NL := U32NL (A (4));
      L5  : constant U32NL := U32NL (A (5));
      L6  : constant U32NL := U32NL (A (6));
      L7  : constant U32NL := U32NL (A (7));
      L8  : constant U32NL := U32NL (A (8));
      L9  : constant U32NL := U32NL (A (9));
      L10 : constant U32NL := U32NL (A (10));
      L11 : constant U32NL := U32NL (A (11));
      L12 : constant U32NL := U32NL (A (12));
      L13 : constant U32NL := U32NL (A (13));
      L14 : constant U32NL := U32NL (A (14));
      L15 : constant U32NL := U32NL (A (15));

      C : GF64_Natural_Limb;
      D : Mul_Product;
   begin
      D := (others => 0);

      -----------------------------------------------------------------
      --  This is basically the same code as "*", but we know
      --  that A = Left = Right.
      --
      --  Therefore, where we would normally calculate two terms
      --  and add such as L0*R1 + R0*L1, we can simplify because
      --  we know tht L0 = R0 and L1 = R1, so that's equal to
      --  2*L0*L1
      --
      --  That turns 2 multiplies and an addition into one multiply
      --  and a 1-bit shift left, which is faster.
      --
      --  Applying that transformation to all the terms below,
      --  collecting like terms, and simplying yields:
      -----------------------------------------------------------------
      declare
         L15L1 : constant LP := LP (L15 * L1);
         L14L2 : constant LP := LP (L14 * L2);
         L13L3 : constant LP := LP (L13 * L3);
         L12L4 : constant LP := LP (L12 * L4);
         L11L5 : constant LP := LP (L11 * L5);
         L10L6 : constant LP := LP (L10 * L6);
         L9L7  : constant LP := LP (L9  * L7);
         L8L8  : constant LP := LP (L8  * L8);

         L0L0  : constant LP := LP (L0 * L0);
         D0    : D0S;
      begin
         D0 := 2 * (L15L1 + L14L2 + L13L3 + L12L4 + L11L5 + L10L6 +
                    L9L7) + L8L8;
         pragma Assert (D0 <= 15 * LP'Last);

         D0  := L0L0 + (R2256 * D0);
         --  Immediately compute C and normalize D0
         --  For proof of type safety and to prove that this converges,
         --  we only need to keep track of the fact that each digit is now
         --  normalized and assert an upper-bound on C.
         C := D0 / LM;
         D (0) := D0 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C0UB);

      declare
         L15L2 : constant LP := LP (L15 * L2);
         L14L3 : constant LP := LP (L14 * L3);
         L13L4 : constant LP := LP (L13 * L4);
         L12L5 : constant LP := LP (L12 * L5);
         L11L6 : constant LP := LP (L11 * L6);
         L10L7 : constant LP := LP (L10 * L7);
         L9L8  : constant LP := LP (L9  * L8);

         L0L1  : constant LP := LP (L0 * L1);
         D1    : D1S;
      begin
         --  And so on ... but add C from D0 into the calculation of D1
         D1  := C +
                2 * (L0L1 +
                     R2256 * (L15L2 + L14L3 + L13L4 +
                              L12L5 + L11L6 + L10L7 + L9L8));
         C := D1 / LM;
         D (1) := D1 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C1UB);

      declare
         L15L3 : constant LP := LP (L15 * L3);
         L14L4 : constant LP := LP (L14 * L4);
         L13L5 : constant LP := LP (L13 * L5);
         L12L6 : constant LP := LP (L12 * L6);
         L11L7 : constant LP := LP (L11 * L7);
         L10L8 : constant LP := LP (L10 * L8);
         L9L9  : constant LP := LP (L9  * L9);

         L2L0  : constant LP := LP (L2 * L0);
         L1L1  : constant LP := LP (L1 * L1);
         D2    : D2S;
      begin
         D2  := C +
                2 * L2L0 + L1L1 +
                R2256 * (2 * (L15L3 + L14L4 + L13L5 + L12L6 + L11L7 + L10L8) +
                         L9L9);

         C := D2 / LM;
         D (2) := D2 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C2UB);

      declare
         L15L4 : constant LP := LP (L15 * L4);
         L14L5 : constant LP := LP (L14 * L5);
         L13L6 : constant LP := LP (L13 * L6);
         L12L7 : constant LP := LP (L12 * L7);
         L11L8 : constant LP := LP (L11 * L8);
         L10L9 : constant LP := LP (L10 * L9);

         L3L0  : constant LP := LP (L3 * L0);
         L2L1  : constant LP := LP (L2 * L1);
         D3    : D3S;
      begin
         D3 := C +
               2 * ((L3L0 + L2L1) +
                    R2256 * (L15L4 + L14L5 + L13L6 +
                             L12L7 + L11L8 + L10L9));

         C := D3 / LM;
         D (3) := D3 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C3UB);

      declare
         L15L5  : constant LP := LP (L15 * L5);
         L14L6  : constant LP := LP (L14 * L6);
         L13L7  : constant LP := LP (L13 * L7);
         L12L8  : constant LP := LP (L12 * L8);
         L11L9  : constant LP := LP (L11 * L9);
         L10L10 : constant LP := LP (L10 * L10);

         L4L0 : constant LP := LP (L4 * L0);
         L3L1 : constant LP := LP (L3 * L1);
         L2L2 : constant LP := LP (L2 * L2);
         D4   : D4S;
      begin
         D4 := C +
               2 * (L4L0 + L3L1) + L2L2 +
               R2256 * (2 * (L15L5 + L14L6 + L13L7 + L12L8 + L11L9) + L10L10);

         C := D4 / LM;
         D (4) := D4 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C4UB);

      declare
         L15L6  : constant LP := LP (L15 * L6);
         L14L7  : constant LP := LP (L14 * L7);
         L13L8  : constant LP := LP (L13 * L8);
         L12L9  : constant LP := LP (L12 * L9);
         L11L10 : constant LP := LP (L11 * L10);

         L5L0 : constant LP := LP (L5 * L0);
         L4L1 : constant LP := LP (L4 * L1);
         L3L2 : constant LP := LP (L3 * L2);
         D5   : D5S;
      begin
         D5 := C +
               2 * ((L5L0 + L4L1 + L3L2) +
                    R2256 * (L15L6 + L14L7 + L13L8 + L12L9 + L11L10));

         C := D5 / LM;
         D (5) := D5 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C5UB);

      declare
         L15L7  : constant LP := LP (L15 * L7);
         L14L8  : constant LP := LP (L14 * L8);
         L13L9  : constant LP := LP (L13 * L9);
         L12L10 : constant LP := LP (L12 * L10);
         L11L11 : constant LP := LP (L11 * L11);

         L6L0 : constant LP := LP (L6 * L0);
         L5L1 : constant LP := LP (L5 * L1);
         L4L2 : constant LP := LP (L4 * L2);
         L3L3 : constant LP := LP (L3 * L3);
         D6   : D6S;
      begin
         D6 := C +
               2 * (L6L0 + L5L1 + L4L2) + L3L3 +
               R2256 * (2 * (L15L7 + L14L8 + L13L9 + L12L10) + L11L11);
         C := D6 / LM;
         D (6) := D6 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C6UB);

      declare
         L15L8  : constant LP := LP (L15 * L8);
         L14L9  : constant LP := LP (L14 * L9);
         L13L10 : constant LP := LP (L13 * L10);
         L12L11 : constant LP := LP (L12 * L11);

         L7L0 : constant LP := LP (L7 * L0);
         L6L1 : constant LP := LP (L6 * L1);
         L5L2 : constant LP := LP (L5 * L2);
         L4L3 : constant LP := LP (L4 * L3);
         D7   : D7S;
      begin
         D7 := C +
               2 * ((L7L0 + L6L1 + L5L2 + L4L3) +
                    R2256 * (L15L8 + L14L9 + L13L10 + L12L11));

         C := D7 / LM;
         D (7) := D7 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C7UB);

      declare
         L15L9  : constant LP := LP (L15 * L9);
         L14L10 : constant LP := LP (L14 * L10);
         L13L11 : constant LP := LP (L13 * L11);
         L12L12 : constant LP := LP (L12 * L12);

         L8L0 : constant LP := LP (L8 * L0);
         L7L1 : constant LP := LP (L7 * L1);
         L6L2 : constant LP := LP (L6 * L2);
         L5L3 : constant LP := LP (L5 * L3);
         L4L4 : constant LP := LP (L4 * L4);
         D8   : D8S;
      begin
         D8 := C +
               2 * (L8L0 + L7L1 + L6L2 + L5L3) + L4L4 +
               R2256 * (2 * (L15L9 + L14L10 + L13L11) + L12L12);

         C := D8 / LM;
         D (8) := D8 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C8UB);

      declare
         L15L10 : constant LP := LP (L15 * L10);
         L14L11 : constant LP := LP (L14 * L11);
         L13L12 : constant LP := LP (L13 * L12);

         L9L0 : constant LP := LP (L9 * L0);
         L8L1 : constant LP := LP (L8 * L1);
         L7L2 : constant LP := LP (L7 * L2);
         L6L3 : constant LP := LP (L6 * L3);
         L5L4 : constant LP := LP (L5 * L4);
         D9   : D9S;
      begin
         D9 := C +
               2 * ((L9L0 + L8L1 + L7L2 + L6L3 + L5L4) +
                    (R2256 * (L15L10 + L14L11 + L13L12)));

         C := D9 / LM;
         D (9) := D9 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C9UB);

      declare
         L15L11 : constant LP := LP (L15 * L11);
         L14L12 : constant LP := LP (L14 * L12);
         L13L13 : constant LP := LP (L13 * L13);

         L10L0 : constant LP := LP (L10 * L0);
         L9L1  : constant LP := LP (L9 * L1);
         L8L2  : constant LP := LP (L8 * L2);
         L7L3  : constant LP := LP (L7 * L3);
         L6L4  : constant LP := LP (L6 * L4);
         L5L5  : constant LP := LP (L5 * L5);
         D10   : D10S;
      begin
         D10 := C +
                2 * (L10L0 + L9L1 + L8L2 + L7L3 + L6L4) + L5L5 +
                R2256 * (2 * (L15L11 + L14L12) + L13L13);

         C := D10 / LM;
         D (10) := D10 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C10UB);

      declare
         L15L12 : constant LP := LP (L15 * L12);
         L14L13 : constant LP := LP (L14 * L13);

         L11L0 : constant LP := LP (L11 * L0);
         L10L1 : constant LP := LP (L10 * L1);
         L9L2  : constant LP := LP (L9 * L2);
         L8L3  : constant LP := LP (L8 * L3);
         L7L4  : constant LP := LP (L7 * L4);
         L6L5  : constant LP := LP (L6 * L5);
         D11   : D11S;
      begin
         D11 := C +
                2 * ((L11L0 + L10L1 + L9L2 + L8L3 + L7L4  + L6L5) +
                     (R2256 * (L15L12 + L14L13)));

         C := D11 / LM;
         D (11) := D11 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C11UB);

      declare
         L15L13 : constant LP := LP (L15 * L13);
         L14L14 : constant LP := LP (L14 * L14);

         L12L0 : constant LP := LP (L12 * L0);
         L11L1 : constant LP := LP (L11 * L1);
         L10L2 : constant LP := LP (L10 * L2);
         L9L3  : constant LP := LP (L9 * L3);
         L8L4  : constant LP := LP (L8 * L4);
         L7L5  : constant LP := LP (L7 * L5);
         L6L6  : constant LP := LP (L6 * L6);
         D12   : D12S;
      begin
         D12 := C +
                2 * (L12L0 + L11L1 + L10L2 + L9L3 + L8L4  + L7L5) + L6L6 +
                R2256 * (2 * L15L13 + L14L14);

         C := D12 / LM;
         D (12) := D12 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C12UB);

      declare
         L15L14 : constant LP := LP (L15 * L14);

         L13L0 : constant LP := LP (L13 * L0);
         L12L1 : constant LP := LP (L12 * L1);
         L11L2 : constant LP := LP (L11 * L2);
         L10L3 : constant LP := LP (L10 * L3);
         L9L4  : constant LP := LP (L9 * L4);
         L8L5  : constant LP := LP (L8 * L5);
         L7L6  : constant LP := LP (L7 * L6);
         D13   : D13S;
      begin
         D13 := C +
                2 * ((L13L0 + L12L1 + L11L2 + L10L3 + L9L4 + L8L5 + L7L6) +
                     (R2256 * L15L14));

         C := D13 / LM;
         D (13) := D13 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C13UB);

      declare
         L15L15 : constant LP := LP (L15 * L15);

         L14L0 : constant LP := LP (L14 * L0);
         L13L1 : constant LP := LP (L13 * L1);
         L12L2 : constant LP := LP (L12 * L2);
         L11L3 : constant LP := LP (L11 * L3);
         L10L4 : constant LP := LP (L10 * L4);
         L9L5  : constant LP := LP (L9 * L5);
         L8L6  : constant LP := LP (L8 * L6);
         L7L7  : constant LP := LP (L7 * L7);
         D14   : D14S;
      begin
         D14 := C +
                2 * (L14L0 + L13L1 + L12L2 + L11L3 + L10L4 + L9L5 + L8L6) +
                L7L7 +
                R2256 * L15L15;

         C := D14 / LM;
         D (14) := D14 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C14UB);

      declare
         L15L0 : constant LP := LP (L15 * L0);
         L14L1 : constant LP := LP (L14 * L1);
         L13L2 : constant LP := LP (L13 * L2);
         L12L3 : constant LP := LP (L12 * L3);
         L11L4 : constant LP := LP (L11 * L4);
         L10L5 : constant LP := LP (L10 * L5);
         L9L6  : constant LP := LP (L9 * L6);
         L8L7  : constant LP := LP (L8 * L7);
         D15   : D15S;
      begin
         D15 := C +
                2 * (L15L0 + L14L1 + L13L2 + L12L3 + L11L4 + L10L5 +
                     L9L6  + L8L7);

         C := D15 / LM;
         D (15) := D15 mod LM;
      end;

      pragma Assert_And_Cut (D in Mul_Product and then
                             D (0) in I64NL and then
                             C <= C15UB);

      --  The carry from D15 is now multiplied by R2256 and added
      --  to D0
      D (0) := D (0) + R2256 * C;
      pragma Assert (D in Mul_Product);

      return Mul_Phase2_Reduction (D);
   end Square;

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
