package SPARKNaCl.MAC
  with SPARK_Mode => On
is
   --  Distinct from Bytes_32, but inherits Equal,
   --  Random_Bytes, and Sanitize primitive operations.
   type Poly_1305_Key is new Bytes_32;

   --------------------------------------------------------
   --  One-time authentication
   --------------------------------------------------------

   procedure Onetimeauth (Output :    out Bytes_16;
                          M      : in     Byte_Seq;
                          K      : in     Poly_1305_Key)
     with Global => null,
          Pre    => M'First = 0;

   function Onetimeauth_Verify (H : in Bytes_16;
                                M : in Byte_Seq;
                                K : in Poly_1305_Key) return Boolean
     with Global => null,
          Pre    => M'First = 0;

end SPARKNaCl.MAC;
