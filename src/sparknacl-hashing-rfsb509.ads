with SPARKNaCl.AES256; use SPARKNaCl.AES256;
package SPARKNaCl.Hashing.RFSB509
  with Pure,
       SPARK_Mode => On
is
   subtype Digest is Bytes_32;

   --------------------------------------------------------
   --  Procedural interface. Faster assuming Output is
   --  passed by reference
   --------------------------------------------------------

   procedure Hash (Output :    out Digest;
                   Input  : in     Byte_Seq;
                   Key    : in     AES256_Key)
     with Global => null;

   --------------------------------------------------------
   --  Functional interfaces
   --------------------------------------------------------

   function Hash (Input : in Byte_Seq;
                  Key   : in AES256_Key) return Digest
     with Global => null;

end SPARKNaCl.Hashing.RFSB509;
