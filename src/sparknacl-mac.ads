package SPARKNaCl.MAC
  with SPARK_Mode => On
is
   --------------------------------------------------------
   --  One-time authentication
   --------------------------------------------------------

   procedure Onetimeauth (Output :    out Bytes_16;
                          M      : in     Byte_Seq;
                          K      : in     Bytes_32)
     with Global => null,
          Pre    => M'First = 0;

   function Onetimeauth_Verify (H : in Bytes_16;
                                M : in Byte_Seq;
                                K : in Bytes_32) return Boolean
     with Global => null,
          Pre    => M'First = 0;

end SPARKNaCl.MAC;
