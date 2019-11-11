with SPARKNaCl.Stream;
package SPARKNaCl.Cryptobox
  with SPARK_Mode => On
is
   --------------------------------------------------------
   --  Public Key Authenticated Encryption - "Crypto Box" --
   --------------------------------------------------------

   subtype Crypto_Box_Nonce      is Bytes_24;
   subtype Crypto_Box_Secret_Key is Bytes_32;
   subtype Crypto_Box_Public_Key is Bytes_32;
   Plaintext_Zero_Bytes  : constant := 32;
   Ciphertext_Zero_Bytes : constant := 16;

   --  Key generation
   procedure Keypair (Y, X : out Bytes_32)
     with Global => Random.Entropy;

   --  Precomputation
   procedure BeforeNM (K    :    out Bytes_32;
                       Y, X : in     Bytes_32)
     with Global => null;


   procedure AfterNM (C      :    out Byte_Seq;
                      Status :    out Boolean;
                      M      : in     Byte_Seq;
                      N      : in     Stream.HSalsa20_Nonce;
                      K      : in     Bytes_32)
     with Global => null,
          Pre    => (M'First = 0 and
                     C'First = 0 and
                     C'Last  = M'Last and
                     M'Length >= 32) and then
                    Equal (M (0 .. 31), Zero_Bytes_32),
          Post   => Equal (C (0 .. 15), Zero_Bytes_16);

   procedure Open_AfterNM
     (M      :    out Byte_Seq; --  Output plaintext
      Status :    out Boolean;
      C      : in     Byte_Seq; --  Input ciphertext
      N      : in     Stream.HSalsa20_Nonce;
      K      : in     Bytes_32) --  Key)
     with Global => null,
          Pre    => (M'First = 0 and
                     C'First = 0 and
                     M'Last  = C'Last and
                     C'Length >= 32) and then
                    Equal (C (0 .. 15), Zero_Bytes_16),
          Post   => Equal (M (0 .. 31), Zero_Bytes_32);

   procedure Create (C      :    out Byte_Seq;
                     Status :    out Boolean;
                     M      : in     Byte_Seq;
                     N      : in     Stream.HSalsa20_Nonce;
                     Y, X   : in     Bytes_32)
     with Global => null,
          Pre    => (M'First = 0 and
                     C'First = 0 and
                     C'Last  = M'Last and
                     M'Length >= 32) and then
                    Equal (M (0 .. 31), Zero_Bytes_32),
          Post   => Equal (C (0 .. 15), Zero_Bytes_16);


   procedure Open (M      :    out Byte_Seq;
                   Status :    out Boolean;
                   C      : in     Byte_Seq;
                   N      : in     Stream.HSalsa20_Nonce;
                   Y, X   : in     Bytes_32)
     with Global => null,
          Pre    => (M'First = 0 and
                     C'First = 0 and
                     M'Last  = C'Last and
                     C'Length >= 32) and then
                    Equal (C (0 .. 15), Zero_Bytes_16),
          Post   => Equal (M (0 .. 31), Zero_Bytes_32);

end SPARKNaCl.Cryptobox;
