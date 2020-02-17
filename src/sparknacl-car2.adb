with SPARKNaCl.PDebug;
with SPARKNaCl.Debug;
package body SPARKNaCl.Car2
  with SPARK_Mode => On
is
   --  "UB" = "Upper Bound"

   --  Upperbound on _input_ limbs, as per the definition
   --  of Product_GF
   function Limb_UB (I : in Index_16) return I64 is
      ((MGFLC - 37 * GF_Any_Limb (I)) * MGFLP);

   --  LnC = "Limb and Carry"
   --  Note: recursive definition!
   function LnC_UB (I : in Index_16) return I64 is
      (if I = 0 then (Limb_UB (0))
                else (Limb_UB (I) + (LnC_UB (I - 1) / 65536)));

   function Carry_UB (I : in Index_16) return I64 is
      (LnC_UB (I) / 65536);


   --  Simple translation of Donenfeld's original C code from
   --  WireGuard.  Here for reference as an oracle for testing
   procedure Carry (R : in out GF)
     with SPARK_Mode => Off
   is
   begin
      --  for (i = 0; i < 16; ++i) {
      --    o[(i + 1) % 16] += (i == 15 ? 38 : 1) * (o[i] >> 16);
      --    o[i] &= 0xffff;
      --  }

      for I in I32 range 0 .. 14 loop
         R (I + 1) := R (I + 1) + ASR_16 (R (I));
         R (I) := R (I) mod 65536;
      end loop;

      --  Unroll final iteration to avoid the need for a condition
      --  expression inside the loop
      R (0)  := R (0) + 38 * ASR_16 (R (15));
      R (15) := R (15) mod 65536;
   end Carry;


   function Product_To_Seminormal
     (X : in Product_GF)
       return Seminormal_GF
   is
      subtype Temp_GF is GF
        with Dynamic_Predicate =>
          (for all I in Index_16 =>
             Temp_GF (I) >= 0 and Temp_GF (I) <= MGFLC * MGFLP);

      subtype Carry_Adjustment is I64 range 0 .. (MGFLC * MGFLP) / 65536;
      Carry : Carry_Adjustment;
      R     : Temp_GF;
   begin
      R := X;
      for I in Index_16 range 0 .. 14 loop
         Carry := ASR_16 (R (I));

         pragma Assert
           (X (I + 1) <= (MGFLC - 37 * GF_Any_Limb (I + 1)) * MGFLP);
         pragma Assert
           (X (I) <= (MGFLC - 37 * GF_Any_Limb (I)) * MGFLP);
         pragma Assert (R (I + 1) = X (I + 1));

         R (I + 1) := R (I + 1) + Carry;
         R (I) := R (I) mod 65536;

         pragma Loop_Invariant
           (for all K in Index_16 range 0 .. I => (R (K) in GF_Normal_Limb));
         pragma Loop_Invariant (R (I + 1) >= 0);

--  Previously, we had...
--         pragma Loop_Invariant
--           (R (I + 1) <= (MGFLC - 37 * GF_Any_Limb (I)) * MGFLP);

--  But now we can be much more precise using the functions above...
         pragma Loop_Invariant (Carry     <= CarryUB (I));
         pragma Loop_Invariant (R (I + 1) <= LnCUB (I + 1));

         pragma Loop_Invariant
           (for all K in Index_16 range I + 2 .. 15 => R (K) = X (K));

      end loop;

      --  Substitute I = 14 into the above loop invariant
      --  and simplify to yield:
      pragma Assert
        (for all K in Index_16 range 0 .. 14 => (R (K) in GF_Normal_Limb));
      pragma Assert (R (15) <= LnCUB (15));

--  which is much stronger than what we had before:
--  pragma Assert (R (15) in 0 .. 53 * MGFLP);
--  SO... we should be able to place a much stronger bound on R (0)

      Carry := ASR_16 (R (15));

      pragma Assert (Carry <= CarryUB (15));

      R (0) := R (0) + 38 * Carry;

      --  Declaration of Seminormal_GF_LSL needs to be adjusted...
      --  Seminormal_GF_LSL'Last could be = 65535 + 38 * CarryUB (15) now...
      pragma Assert (R (0) in Seminormal_GF_LSL);

      R (15) := R (15) mod 65536;

      return Seminormal_GF (R);
   end Product_To_Seminormal;



end SPARKNaCl.Car2;
