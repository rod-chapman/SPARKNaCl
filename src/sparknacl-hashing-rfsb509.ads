with SPARKNaCl.AES; use SPARKNaCl.AES;
package SPARKNaCl.Hashing.RFSB509
  with Pure,
       SPARK_Mode => On
is
   subtype Digest is Bytes_32;

   --  This package implements the keyed variant of the RFSB509 hash function.
   --  Thus, both of the following subprograms take the "Key" parameter. In
   --  order to have the subprograms behave like the reference implementation
   --  use an all 0 key i.e (others => 0).

   --------------------------------------------------------
   --  Procedural interface. Faster assuming Output is
   --  passed by reference
   --------------------------------------------------------

   procedure Hash (Output :    out Digest;
                   Input  : in     Byte_Seq;
                   Key    : in     AES128_Key)
     with Global => null;

   --------------------------------------------------------
   --  Functional interfaces
   --------------------------------------------------------

   function Hash (Input : in Byte_Seq;
                  Key   : in AES128_Key) return Digest
     with Global => null;

end SPARKNaCl.Hashing.RFSB509;
