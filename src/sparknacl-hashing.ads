package SPARKNaCl.Hashing
  with SPARK_Mode => On
is
   subtype Digest is Bytes_64; -- 512 bits

   procedure Hashblocks
     (X : in out Digest;
      M : in     Byte_Seq)
     with Global => null;

   procedure Hash (Output :    out Digest;
                   M      : in     Byte_Seq)
     with Global => null;

end SPARKNaCl.Hashing;
