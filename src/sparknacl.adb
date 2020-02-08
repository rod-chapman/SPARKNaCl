with SPARKNaCl.Utils2;
package body SPARKNaCl
  with SPARK_Mode => On
is
   --===============================
   --  Local subprogram bodies
   --===============================

   function "+" (Left, Right : in Normal_GF) return Normal_GF
   is
      O : Summation_GF := (others => 0);
   begin
      for I in Index_16 loop
         O (I) := Left (I) + Right (I);
         pragma Loop_Invariant
           (for all J in Index_16 range 0 .. I => O (J) in GF_Summation_Limb);
      end loop;

      return Utils2.Car_Nearlynormal_To_Normal
        (Utils2.Car_Summation_To_Nearlynormal (O));
   end "+";

   function "-" (Left, Right : in Normal_GF) return Normal_GF
   is
      O : GF := (others => 0);
   begin
      --  For limb 0, we compute the difference, but add 65536 to
      --  make sure the result is positive.
      O (0) := (Left (0) - Right (0)) + 65536;

      for I in Index_16 range 1 .. 15 loop
         --  Having added 65536 to the previous limb, we also add 65536 to
         --  each new limb, but subtract 1 to account for the extra 65536 from
         --  the earlier limb
         O (I) := (Left (I) - Right (I)) + 65535;
         pragma Loop_Invariant
           ((O (0) in 1 .. 131071) and
            (for all K in Index_16 range 1 .. I => O (K) in 0 .. 131070));
      end loop;

      --  We now need to carry -1 into limb O (16), but that doesn't
      --  exist, so we carry 2**256 * -1 into limb O (0). As before,
      --  we know that (2**256) mod (2**255 - 19) = 38, so we add
      --  38 * -1 to O (0)
      O (0) := O (0) - 38;

      pragma Assert (O in Unnormalized_GF_Difference);

      return Utils2.Car_Nearlynormal_To_Normal
        (Utils2.Car_Difference_To_Nearlynormal (O));
   end "-";

   function "*" (Left, Right : in Normal_GF) return Normal_GF
   is
      type TA is array (Index_31) of GF_Any_Limb;
      T  : TA;
      TF : Unnormalized_GF_Product;
   begin
      T := (others => 0);

      for I in Index_16 loop
         for J in Index_16 loop
            T (I + J) := T (I + J) + (Left (I) * Right (J));

            --  RCC explain this invariant
            pragma Loop_Invariant
              (
               --  Lower bound
               (for all K in Index_31 => T (K) >= 0) and

               --  rising from 1 to I
               (for all K in Index_31 range 0 .. (I - 1)   =>
                  T (K) <= (I64 (K + 1) * MGFLP)) and

               --  flat at I + 1, just written
               (for all K in Index_31 range I .. I32'Min (15, I + J) =>
                  T (K) <= (I64 (I + 1) * MGFLP)) and

               --  flat at I, not written yet
               (for all K in Index_31 range I + J + 1 .. 15 =>
                  T (K) <= (I64 (I) * MGFLP)) and

               --  falling from I to 1, just written
               (for all K in Index_31 range 16 .. (I + J) =>
                  T (K) <= (I64 (16 + I) - I64 (K)) * MGFLP) and

               --  falling, from I to 1, but not written yet
               (for all K in Index_31 range
                  I32'Max (16, I + J + 1) .. (I + 15) =>
                  T (K) <= (I64 (15 + I) - I64 (K)) * MGFLP) and

               --  Zeroes - never written
               (for all K in Index_31 range I + 16 .. 30   =>
                  T (K) = 0)
              );


         end loop;

         --  Substituting J = 15 into the nested invariant above,
         --  and eliminating quantifiers with null ranges yields:
         pragma Loop_Invariant
           (
            --  Lower bound
            (for all K in Index_31 => T (K) >= 0) and
            --  Upper bounds
            (for all K in Index_31 range 0 .. (I - 1)   =>
               T (K) <= (I64 (K + 1) * MGFLP)) and
            (for all K in Index_31 range I .. 15        =>
               T (K) <= (I64 (I + 1) * MGFLP)) and
            (for all K in Index_31 range 16 .. (I + 15) =>
               T (K) <= (I64 (16 + I) - I64 (K)) * MGFLP) and
            (for all K in Index_31 range I + 16 .. 30   =>
               T (K) = 0)
           );
      end loop;

      --  Substituting I = 15 into the outer loop invariant above,
      --  and eliminating quantifiers with null ranges yields:
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

      TF := (15 => T (15), others => 0);

      for I in Index_15 loop
         TF (I) := T (I) + 38 * T (I + 16);
         pragma Loop_Invariant
           (
            (for all J in Index_15 range 0 .. I =>
               TF (J) = T (J) + 38 * T (J + 16))
            and then
            (for all J in Index_15 range I + 1 .. 14 =>
               TF (J) = 0)
            and then
              TF (15) = T (15)
            and then
              --  Force the subtype predicate check here
              TF in Unnormalized_GF_Product
           );
      end loop;

      return Utils2.Car_Nearlynormal_To_Normal
               (Utils2.Car_Seminormal_Product_To_Nearlynormal
                 (Utils2.Car_Product_To_Seminormal (TF)));
   end "*";

   --  POK
   function Square (A : in Normal_GF) return Normal_GF
   is
   begin
      return A * A;
   end Square;

   --===============================
   --  Exported subprogram bodies
   --===============================

   --------------------------------------------------------
   --  Constant time equality test
   --------------------------------------------------------

   --  POK
   function Equal (X, Y : in Byte_Seq) return Boolean
   is
      D : Boolean := True;
   begin
      for I in N32 range X'Range loop
         D := D and (X (I) = Y (I));
         pragma Loop_Invariant
           (D = (for all J in N32 range X'First .. I => X (J) = Y (J)));
      end loop;

      return D;
   end Equal;

   --------------------------------------------------------
   --  RNG
   --------------------------------------------------------

   --  POK
   procedure Random_Bytes (R : out Byte_Seq)
   is
   begin
      for I in R'Range loop
         R (I) := Random.Random_Byte;
      end loop;
   end Random_Bytes;

   --------------------------------------------------------
   --  Data sanitization
   --------------------------------------------------------

   procedure Sanitize (R : out Byte_Seq) is separate;

end SPARKNaCl;
