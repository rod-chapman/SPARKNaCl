package SPARKNaCl.Hashing.SHA384
  with Pure,
       SPARK_Mode => On
is
   subtype Digest is Bytes_48;

   --------------------------------------------------------
   --  Procedural interface. Faster assuming Output is
   --  passed by reference
   --------------------------------------------------------

   procedure Hash (Output :    out Digest;
                   M      : in     Byte_Seq)
     with Global => null;

   --------------------------------------------------------
   --  Functional interfaces
   --------------------------------------------------------

   function Hash (M : in Byte_Seq) return Digest
     with Global => null;

end SPARKNaCl.Hashing.SHA384;