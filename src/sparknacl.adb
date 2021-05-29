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

   function "*" (Left, Right : in Normal_GF) return Normal_GF
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
   end "*";

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

   procedure Sanitize_Boolean (R : out Boolean) is separate;

end SPARKNaCl;
