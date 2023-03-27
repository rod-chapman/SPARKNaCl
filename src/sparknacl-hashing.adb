package body SPARKNaCl.Hashing
  with SPARK_Mode => On
is

   function TS64 (U : in U64) return Bytes_8
   is
      X : Bytes_8;
      T : U64 := U;
   begin
      for I in reverse Index_8 loop
         pragma Loop_Optimize (No_Unroll);
         X (I) := Byte (T mod 256);
         T := Shift_Right (T, 8);
      end loop;
      return X;
   end TS64;

end SPARKNaCl.Hashing;
