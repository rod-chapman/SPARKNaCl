with SPARKNaCl.Stream;
with SPARKNaCl.Core;
package SPARKNaCl.Secretbox
  with Pure,
       SPARK_Mode => On
is
   --------------------------------------------------------
   --  Secret Key Authenticated Encryption - "SecretBox" --
   --------------------------------------------------------

   Secretbox_Zero_Bytes  : constant := 32;

   procedure Create (C      :    out Byte_Seq;
                     Status :    out Boolean;
                     M      : in     Byte_Seq;
                     N      : in     Stream.HSalsa20_Nonce;
                     K      : in     Core.Salsa20_Key)
     with Global => null,
          Pre    => (M'First = 0 and
                     C'First = 0 and
                     C'Last  = M'Last and
                     M'Length >= 32) and then
                    Equal (M (0 .. 31), Zero_Bytes_32),
          Post   => Equal (C (0 .. 15), Zero_Bytes_16);


   procedure Open
     (M      :    out Byte_Seq; --  Output plaintext
      Status :    out Boolean;
      C      : in     Byte_Seq; --  Input ciphertext
      N      : in     Stream.HSalsa20_Nonce;
      K      : in     Core.Salsa20_Key)
     with Global => null,
          Pre    => (M'First = 0 and
                     C'First = 0 and
                     M'Last  = C'Last and
                     C'Length >= 32) and then
                    Equal (C (0 .. 15), Zero_Bytes_16),
          Post   => Equal (M (0 .. 31), Zero_Bytes_32);

   -----------------------------------------------------------
   --  AEAD = "Authenticated Encryption with Additional Data"
   --  TLS 1.3 AEAD using ChaCha20 and Poly1305
   --
   --  See RFC 8439 section 2.8
   -----------------------------------------------------------

   procedure Create
     (C       :    out Byte_Seq;           --  Output ciphertext
      Tag     :    out Bytes_16;
      M       : in     Byte_Seq;           --  Message
      N       : in     Core.ChaCha20_IETF_Nonce; --  Nonce
      K       : in     Core.ChaCha20_Key;  --  Key
      AAD     : in     Byte_Seq)           --  Additional Authenticated Data
     with Global => null,
          Pre    => M'First    = 0 and
                    C'First    = 0 and
                    M'Last     = C'Last and
                    C'Length   <= U32 (N32'Last) and
                    M'Length   <= U32 (N32'Last) and
                    C'Length   = M'Length and
                    AAD'First  = 0 and
                    AAD'Length <= U32 (N32'Last) and
                    C'Length + AAD'Length <= U32 (N32'Last - 192);

   procedure Open
     (M        :    out Byte_Seq;            --  Output message
      Status   :    out Boolean;             --  True iff decryption and
                                             --  authentication tag check OK
      Tag      : in     Bytes_16;
      C        : in     Byte_Seq;            --  Input ciphertext
      N        : in     Core.ChaCha20_IETF_Nonce; --  Nonce
      K        : in     Core.ChaCha20_Key;   --  Key
      AAD      : in     Byte_Seq)            --  Additional Authenticated Data
     with Global => null,
          Pre    => M'First    = 0 and
                    C'First    = 0 and
                    M'Last     = C'Last and
                    C'Length   <= U32 (N32'Last) and
                    M'Length   <= U32 (N32'Last) and
                    C'Length   = M'Length and
                    AAD'First  = 0 and
                    AAD'Length <= U32 (N32'Last) and
                    C'Length + AAD'Length <= U32 (N32'Last - 192);
end SPARKNaCl.Secretbox;
