package SPARKNaCl.Hashing
  with Pure,
       SPARK_Mode => On
is

private
   function Big_Endian_Unpack (Input : in U64) return Bytes_8
     with Global => null,
          Post   => (for all I in Index_8 => Big_Endian_Unpack'Result (I) =
            Big_Endian_Get_Byte (Input, I));

   function Big_Endian_Get_Byte (Input : in U64;
                                 Index : in Index_8) return Byte
     with Ghost,
          Global => null,
          Post   => Big_Endian_Get_Byte'Result = Byte (
            Shift_Right (Input, Integer (Index_8'Last - Index) * 8) mod 256);

end SPARKNaCl.Hashing;
