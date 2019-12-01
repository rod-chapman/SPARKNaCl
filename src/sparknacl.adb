with SPARKNaCl.Utils;
with SPARKNaCl.Debug;
package body SPARKNaCl
  with SPARK_Mode => On
is
   --===============================
   --  Local subprogram bodies
   --===============================

   function "+" (Left, Right : in GF) return GF
   is
      O : GF := (others => 0);
   begin
      for I in Index_16 loop
         O (I) := Left (I) + Right (I);
         pragma Loop_Invariant
           (for all J in Index_16 range 0 .. I => (O (J) >= 0 and
                                                   O (J) <= 131070));
      end loop;

      --  RCC why 2 calls here?
      Utils.Car_25519 (O);
      Utils.Car_25519 (O);

      return O;
   end "+";

   function "-" (Left, Right : in GF) return GF
   is
      O : GF := (others => 0);
   begin
      for I in Index_16 loop
         O (I) := Left (I) - Right (I);
         pragma Loop_Invariant
           (for all J in Index_16 range 0 .. I => (O (J) >= -65535 and
                                                   O (J) <= 65535));
      end loop;

      --  RCC why 2 calls here?
      Utils.Car_25519 (O);
      Utils.Car_25519 (O);

      return O;
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

         pragma Loop_Invariant
           (
            --  Lower bound
            (for all K in Index_31 => T (K) >= 0) and

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
            and
            (for all J in Index_15 range I + 1 .. 14 =>
               TF (J) = 0)
            and
              TF (15) = T (15)
           );
      end loop;

      --  Combining the effects of adding T(J) + 38 * T (J + 16)
      --  with the upper bounds from the Assert above, T (0)
      --  has the largest upper bounds of (1 + 38 * 15) * MGFLP = 571 * MGFLP
      --
      --  The upper bound on T (1), T (2) ... T (I) and so on reduce by
      --  37 * MGFLP for each increasing value of I, so...
      pragma Assert
        (for all I in Index_16 =>
           TF (I) >= 0 and
           TF (I) <= (571 - 37 * GF_Any_Limb (I)) * MGFLP);

      return Utils.Car_Seminormal_To_Normal -- Proof predicate check * 2?
        (Utils.Car_Any_To_Seminormal (TF));
   end "*";

   --  POK
   function Square (A : in GF) return GF
   is
      O : GF;
   begin
      pragma Assert ((for all I in Index_16 => A (I) >= 0),
                     "S input A - limb too negative");
      pragma Assert ((for all I in Index_16 => A (I) <= 65535),
                     "S input A - limb too big");

      O := A * A;

      pragma Assert ((for all I in Index_16 => O (I) >= 0),
                     "S output - limb too negative");
      pragma Assert ((for all I in Index_16 => O (I) <= 65535),
                     "S output - limb too large");
      return O;
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
