private package SPARKNaCl.Utils2
  with SPARK_Mode => On
is
   --  Subtracting P twice from a Normal_GF might result
   --  in a GF where limb 15 can be negative with lower bound -65536
   subtype Temp_GF_MSL is I64 range -LM .. LMM1;
   subtype Temp_GF is GF
     with Dynamic_Predicate =>
       (Temp_GF (15) in Temp_GF_MSL and
         (for all K in Index_16 range 0 .. 14 =>
            Temp_GF (K) in GF_Normal_Limb));

   --  Result := T - P;
   --  if     Underflow, then Result is not a Normal_GF
   --  if not Underflow, then Result is     a Normal_GF
   procedure Subtract_P (T         : in     Temp_GF;
                         Result    :    out Temp_GF;
                         Underflow :    out Boolean)
     with Global => null,
          Pre    => T (15) >= -16#8000#,
          Post   => Underflow /= (Result in Normal_GF);

end SPARKNaCl.Utils2;
