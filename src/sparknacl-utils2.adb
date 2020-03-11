package body SPARKNaCl.Utils2
  with SPARK_Mode => On
is
   procedure Subtract_P (T         : in     Temp_GF;
                         Result    :    out Temp_GF;
                         Underflow :    out Boolean)
   is
      Carry : I64_Bit;
      R     : GF;
   begin
      R := GF_0;

      --  Limb 0 - subtract LSL of P, which is 16#FFED#
      R (0) := T (0) - 16#FFED#;

      --  Limbs 1 .. 14 - subtract FFFF with carry
      for I in Index_16 range 1 .. 14 loop
         Carry     := ASR_16 (R (I - 1)) mod 2;
         R (I)     := T (I) - 16#FFFF# - Carry;
         R (I - 1) := R (I - 1) mod LM;

         pragma Loop_Invariant
           (for all J in Index_16 range 0 .. I - 1 =>
              R (J) in GF_Normal_Limb);
         pragma Loop_Invariant (T in Temp_GF);
      end loop;

      --  Limb 15 - Subtract MSL (Most Significant Limb)
      --  of P (16#7FFF#) with carry.
      --  Note that Limb 15 might become negative on underflow
      Carry  := ASR_16 (R (14)) mod 2;

      --  Only alt-ergo proves the range-check on this line... in 48 seconds
      --  and >350000 steps!  Why? It's a really simple range-check.
      --  We know (T (15) in Temp_GF_MSL) and (Carry in 0 .. 1) so
      --  this should be easy. Why do CVC4 and Z3 both fail to prove this??
      R (15) := (T (15) - 16#7FFF#) - Carry;

      R (14) := R (14) mod LM;

      Underflow := R (15) < 0;

      -- This should be fine. Proved by CVC4, Z3 and elt-ergo OK.
      pragma Assert (T (15) in Temp_GF_MSL);

      --  This looks wrong!
      --   CVC4 proves this
      --   Z3 proves this
      --   alt-ergo proves this
      pragma Assert (R (15) in Temp_GF_MSL);

      --  This looks wrong too...
      --   CVC4 proves this
      --   Z3 proves this
      --   alt-ergo says No, which is odd, given that it proves the assertion above.
      pragma Assert (R in Temp_GF);

      --  Predicate check here
      --   CVC4 proves this
      --   Z3 proves this
      --   alt-ergo proves this
      Result := R;
   end Subtract_P;

end SPARKNaCl.Utils2;
