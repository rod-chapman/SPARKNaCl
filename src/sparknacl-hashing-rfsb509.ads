with SPARKNaCl.Core; use SPARKNaCl.Core;
package SPARKNaCl.Hashing.RFSB509
  with Pure,
       SPARK_Mode => On
is
   subtype Digest is Bytes_64;

   --------------------------------------------------------
   --  Procedural interface. Faster assuming Output is
   --  passed by reference
   --------------------------------------------------------

   procedure Hash (Output :    out Digest;
                   Input  : in     Byte_Seq;
                   Key    : in     ChaCha20_Key)
     with Global => null;

   --------------------------------------------------------
   --  Functional interfaces
   --------------------------------------------------------

   function Hash (Input : in Byte_Seq;
                  Key   : in ChaCha20_Key) return Digest
     with Global => null;

end SPARKNaCl.Hashing.RFSB509;
