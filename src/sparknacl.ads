with Interfaces;      use Interfaces;
with SPARKNaCl_Types; use SPARKNaCl_Types;
with SPARKNaCl_Random;

package SPARKNaCl
  with SPARK_Mode => On
is
   --===========================
   --  Exported subprograms
   --===========================

   procedure Random_Bytes (R : out Byte_Seq)
     with Global => SPARKNaCl_Random.Entropy;

   --------------------------------------------------------
   --  Scalar multiplication
   --------------------------------------------------------

   procedure Crypto_Scalarmult (Q :    out Bytes_32;
                                N : in     Bytes_32;
                                P : in     Bytes_32)
     with Global => null;

   procedure Crypto_Scalarmult_Base (Q :    out Bytes_32;
                                     N : in     Bytes_32)
     with Global => null;


   --------------------------------------------------------
   --  Public key signatures
   --------------------------------------------------------

   --  key generation
   procedure Crypto_Sign_Keypair (PK : out Bytes_32;
                                  SK : out Bytes_64)
     with Global => SPARKNaCl_Random.Entropy;


   procedure Crypto_Sign (SM :    out Byte_Seq;
                          M  : in     Byte_Seq;
                          SK : in     Bytes_64)
     with Global => null,
          Pre => M'First   = 0 and
                 SM'First  = 0 and
                 SM'Length = M'Length + 64 and
                 SM'Last   = M'Last + 64;

   procedure Crypto_Sign_Open (M      :    out Byte_Seq;
                               Status :    out Verify_Result;
                               MLen   :    out I32;
                               SM     : in     Byte_Seq;
                               PK     : in     Bytes_32)
     with Global => null,
          Pre => M'First   = 0 and
                 SM'First  = 0 and
                 SM'Length = M'Length and
                 SM'Last   = M'Last and
                 SM'Length >= 64;


   --------------------------------------------------------
   --  Salsa20 Core functions
   --------------------------------------------------------

   procedure Crypto_Core_Salsa20 (Output :    out Bytes_64;
                                  Input  : in     Bytes_16;
                                  K      : in     Bytes_32;
                                  C      : in     Bytes_16)
     with Global => null;

   procedure Crypto_Core_HSalsa20 (Output :    out Bytes_32;
                                   Input  : in     Bytes_16;
                                   K      : in     Bytes_32;
                                   C      : in     Bytes_16)
     with Global => null;

   --------------------------------------------------------
   --  Secret key encryption (not authenticated)
   --------------------------------------------------------

   procedure Crypto_Stream (C :    out Byte_Seq; --  Output stream
                            N : in     Bytes_24; --  Nonce
                            K : in     Bytes_32) --  Key
     with Global => null,
          Pre    => C'First = 0;


   procedure Crypto_Stream_Xor (C :    out Byte_Seq; --  Output ciphertext
                                M : in     Byte_Seq; --  Input message
                                N : in     Bytes_24; --  Nonce
                                K : in     Bytes_32) --  Key
     with Global => null,
          Pre    => M'First = 0 and
                    C'First = M'First and
                    C'Last  = M'Last;

   procedure Crypto_Stream_Salsa20_Xor (C :    out Byte_Seq; --  Output stream
                                        M : in     Byte_Seq; --  Input message
                                        N : in     Bytes_8;  --  Nonce
                                        K : in     Bytes_32) --  Key
     with Global => null,
          Pre    => M'First = 0 and
                    C'First = M'First and
                    C'Last  = M'Last;


   procedure Crypto_Stream_Salsa20 (C :    out Byte_Seq; --  Output stream
                                    N : in     Bytes_8;  --  Nonce
                                    K : in     Bytes_32) --  Key
     with Global => null,
          Pre    => C'First = 0;

   --------------------------------------------------------
   --  One-time authentication
   --------------------------------------------------------

   procedure Crypto_Onetimeauth (Output :    out Bytes_16;
                                 M      : in     Byte_Seq;
                                 K      : in     Bytes_32)
     with Global => null,
          Pre    => M'First = 0;

   function Crypto_Onetimeauth_Verify (H : in Bytes_16;
                                       M : in Byte_Seq;
                                       K : in Bytes_32) return Verify_Result
     with Global => null,
          Pre    => M'First = 0;



   --------------------------------------------------------
   --  Secret Key Authenticated Encryption - "SecretBox" --
   --------------------------------------------------------

   Crypto_Secretbox_Zero_Bytes  : constant := 32;

   procedure Crypto_Secretbox (C      :    out Byte_Seq;
                               Status :    out Verify_Result;
                               M      : in     Byte_Seq;
                               N      : in     Bytes_24;
                               K      : in     Bytes_32)
     with Global => null,
          Pre    => M'First = 0 and
                    C'First = 0 and
                    C'Last  = M'Last and
                    M'Length >= 32 and
                    M (0 .. 31) = Zero_Bytes_32,
          Post   => C (0 .. 15) = Zero_Bytes_16;


   procedure Crypto_Secretbox_Open
     (M      :    out Byte_Seq; --  Output plaintext
      Status :    out Verify_Result;
      C      : in     Byte_Seq; --  Input ciphertext
      N      : in     Bytes_24; --  Nonce
      K      : in     Bytes_32) --  Key)
     with Global => null,
          Pre    => M'First = 0 and
                    C'First = 0 and
                    M'Last  = C'Last and
                    C'Length >= 32 and
                    C (0 .. 15) = Zero_Bytes_16,
          Post   => M (0 .. 31) = Zero_Bytes_32;


   --------------------------------------------------------
   --  Public Key Authenticated Encryption - "Crypto Box" --
   --------------------------------------------------------

   subtype Crypto_Box_Nonce      is Bytes_24;
   subtype Crypto_Box_Secret_Key is Bytes_32;
   subtype Crypto_Box_Public_Key is Bytes_32;
   Crypto_Box_Plaintext_Zero_Bytes  : constant := 32;
   Crypto_Box_Ciphertext_Zero_Bytes : constant := 16;

   --  Key generation
   procedure Crypto_Box_Keypair (Y, X : out Bytes_32)
     with Global => SPARKNaCl_Random.Entropy;

   --  Precomputation
   procedure Crypto_Box_BeforeNM (K    :    out Bytes_32;
                                  Y, X : in     Bytes_32)
     with Global => null;


   procedure Crypto_Box_AfterNM (C      :    out Byte_Seq;
                                 Status :    out Verify_Result;
                                 M      : in     Byte_Seq;
                                 N      : in     Bytes_24;
                                 K      : in     Bytes_32)
     with Global => null,
          Pre    => M'First = 0 and
                    C'First = 0 and
                    C'Last  = M'Last and
                    M'Length >= 32 and
                    M (0 .. 31) = Zero_Bytes_32,
          Post   => C (0 .. 15) = Zero_Bytes_16;

   procedure Crypto_Box_Open_AfterNM
     (M      :    out Byte_Seq; --  Output plaintext
      Status :    out Verify_Result;
      C      : in     Byte_Seq; --  Input ciphertext
      N      : in     Bytes_24; --  Nonce
      K      : in     Bytes_32) --  Key)
     with Global => null,
          Pre    => M'First = 0 and
                    C'First = 0 and
                    M'Last  = C'Last and
                    C'Length >= 32 and
                    C (0 .. 15) = Zero_Bytes_16,
          Post   => M (0 .. 31) = Zero_Bytes_32;

   procedure Crypto_Box (C      :    out Byte_Seq;
                         Status :    out Verify_Result;
                         M      : in     Byte_Seq;
                         N      : in     Bytes_24;
                         Y, X   : in     Bytes_32)
     with Global => null,
          Pre    => M'First = 0 and
                    C'First = 0 and
                    C'Last  = M'Last and
                    M'Length >= 32 and
                    M (0 .. 31) = Zero_Bytes_32,
          Post   => C (0 .. 15) = Zero_Bytes_16;


   procedure Crypto_Box_Open (M      :    out Byte_Seq;
                              Status :    out Verify_Result;
                              C      : in     Byte_Seq;
                              N      : in     Bytes_24;
                              Y, X   : in     Bytes_32)
     with Global => null,
          Pre    => M'First = 0 and
                    C'First = 0 and
                    M'Last  = C'Last and
                    C'Length >= 32 and
                    C (0 .. 15) = Zero_Bytes_16,
          Post   => M (0 .. 31) = Zero_Bytes_32;


   --------------------------------------------------------
   --  Hashing
   --------------------------------------------------------

   procedure Crypto_Hashblocks
     (X : in out Bytes_64; -- 512 bits
      M : in     Byte_Seq)
     with Global => null;

   procedure Crypto_Hash (Output :    out Bytes_64; -- 512 bits
                          M      : in     Byte_Seq)
     with Global => null;

   --------------------------------------------------------
   --  Constant time equality tests
   --------------------------------------------------------

   function Crypto_Verify_16 (X, Y : in Bytes_16) return Verify_Result
     with Global => null;

   function Crypto_Verify_32 (X, Y : in Bytes_32) return Verify_Result
     with Global => null;

end SPARKNaCl;
