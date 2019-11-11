with SPARKNaCl.Core; use SPARKNaCl.Core;
package SPARKNaCl.Stream
  with SPARK_Mode => On
is
   type HSalsa20_Nonce is new Bytes_24;
   type Salsa20_Nonce  is new Bytes_8;

   --------------------------------------------------------
   --  Secret key encryption (not authenticated)
   --------------------------------------------------------

   procedure HSalsa20 (C :    out Byte_Seq;       --  Output stream
                       N : in     HSalsa20_Nonce; --  Nonce
                       K : in     Salsa20_Key)    --  Key
     with Global => null,
          Pre    => C'First = 0;


   procedure HSalsa20_Xor (C :    out Byte_Seq; --  Output ciphertext
                           M : in     Byte_Seq; --  Input message
                           N : in     HSalsa20_Nonce; --  Nonce
                           K : in     Salsa20_Key)    --  Key
     with Global => null,
          Pre    => M'First = 0 and
                    C'First = M'First and
                    C'Last  = M'Last;



   procedure Salsa20 (C :    out Byte_Seq; --  Output stream
                      N : in     Salsa20_Nonce; --  Nonce
                      K : in     Salsa20_Key)    --  Key
     with Global => null,
          Pre    => C'First = 0;

   procedure Salsa20_Xor (C :    out Byte_Seq; --  Output stream
                          M : in     Byte_Seq; --  Input message
                          N : in     Salsa20_Nonce; --  Nonce
                          K : in     Salsa20_Key)    --  Key
     with Global => null,
          Pre    => M'First = 0 and
                    C'First = M'First and
                    C'Last  = M'Last;


end SPARKNaCl.Stream;
