package SPARKNaCl.Hashing
  with SPARK_Mode => On
is

   procedure Hashblocks
     (X : in out Bytes_64; -- 512 bits
      M : in     Byte_Seq)
     with Global => null;

   procedure Hash (Output :    out Bytes_64; -- 512 bits
                   M      : in     Byte_Seq)
     with Global => null;

end SPARKNaCl.Hashing;
