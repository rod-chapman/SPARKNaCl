--  with SPARKNaCl.PDebug;
--  with SPARKNaCl.Debug;
package body SPARKNaCl.Car2
  with SPARK_Mode => On
is
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
         R (I) := R (I) mod LM;
      end loop;

      --  Unroll final iteration to avoid the need for a condition
      --  expression inside the loop
      R (0)  := R (0) + R2256 * ASR_16 (R (15));
      R (15) := R (15) mod LM;
   end Carry;


   function Product_To_Seminormal
     (X : in Product_GF)
       return Seminormal_GF
   is
      subtype Temp_GF is GF
        with Dynamic_Predicate =>
          (for all I in Index_16 =>
             Temp_GF (I) >= 0 and Temp_GF (I) <= MGFLC * MGFLP);

      subtype Carry_T is I64 range 0 .. I64'Last;
      Carry : Carry_T;
      R     : Temp_GF;
   begin
      R := X;

      for I in Index_16 range 0 .. 14 loop
         Carry := R (I) / LM;
         R (I + 1) := R (I + 1) + Carry;
         R (I) := R (I) mod LM;

         pragma Loop_Invariant
           (for all K in Index_16 range 0 .. I => (R (K) in GF_Normal_Limb));
         pragma Loop_Invariant (R (I + 1) >= 0);
         pragma Loop_Invariant (Carry     <= Carry_UB (I));
         pragma Loop_Invariant (R (I + 1) <= LnC_UB (I + 1));
         pragma Loop_Invariant
           (for all K in Index_16 range I + 2 .. 15 => R (K) = X (K));
      end loop;

      --  Substitute I = 14 into the above loop invariant
      --  and simplify to yield:
      pragma Assert
        (for all K in Index_16 range 0 .. 14 => (R (K) in GF_Normal_Limb));
      pragma Assert (R (15) <= LnC_UB (15));

      Carry := R (15) / LM;
      R (0) := R (0) + R2256 * Carry;
      R (15) := R (15) mod LM;

      --  The upper-bound on R (15) is sufficient to get a tight upper-bound
      --  on R (0) now, so...
      return New_Seminormal_GF (R);
   end Product_To_Seminormal;

end SPARKNaCl.Car2;
