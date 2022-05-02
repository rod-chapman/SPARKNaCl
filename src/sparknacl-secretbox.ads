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

   --------------------------------------------------------
   --  TLS 1.3 AEAD using ChaCha20 and Poly1305 (RFC 8439)
   --------------------------------------------------------

   procedure Create (C       :    out Byte_Seq;
                     Tag     :    out Bytes_16;
                     M       : in     Byte_Seq;
                     N       : in     Core.ChaCha20_IETF_Nonce;
                     K       : in     Core.ChaCha20_Key;
                     AAD     : in     Byte_Seq;
                     Counter : in     U32)
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

   procedure Open (M        :    out Byte_Seq;
                   Status   :    out Boolean;
                   Tag      : in     Bytes_16;
                   C        : in     Byte_Seq;
                   N        : in     Core.ChaCha20_IETF_Nonce;
                   K        : in     Core.ChaCha20_Key;
                   AAD      : in     Byte_Seq;
                   Counter  : in     U32)
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
