package SPARKNaCl.Stream
  with SPARK_Mode => On
is
   --------------------------------------------------------
   --  Secret key encryption (not authenticated)
   --------------------------------------------------------

   procedure HSalsa20 (C :    out Byte_Seq; --  Output stream
                       N : in     Bytes_24; --  Nonce
                       K : in     Bytes_32) --  Key
     with Global => null,
          Pre    => C'First = 0;


   procedure HSalsa20_Xor (C :    out Byte_Seq; --  Output ciphertext
                           M : in     Byte_Seq; --  Input message
                           N : in     Bytes_24; --  Nonce
                           K : in     Bytes_32) --  Key
     with Global => null,
          Pre    => M'First = 0 and
                    C'First = M'First and
                    C'Last  = M'Last;



   procedure Salsa20 (C :    out Byte_Seq; --  Output stream
                      N : in     Bytes_8;  --  Nonce
                      K : in     Bytes_32) --  Key
     with Global => null,
          Pre    => C'First = 0;

   procedure Salsa20_Xor (C :    out Byte_Seq; --  Output stream
                                 M : in     Byte_Seq; --  Input message
                                 N : in     Bytes_8;  --  Nonce
                                 K : in     Bytes_32) --  Key
     with Global => null,
          Pre    => M'First = 0 and
                    C'First = M'First and
                    C'Last  = M'Last;


end SPARKNaCl.Stream;
