------------------------------------------------------------------------------
--  Copyright (c) 2019, Protean Code Limited
--  All rights reserved.
--
--  "Simplified" (2-Clause) BSD Licence
--
--  Redistribution and use in source and binary forms, with or without
--  modification, are permitted provided that the following conditions are
--  met:
--
--  1. Redistributions of source code must retain the above copyright notice,
--     This list of conditions and the following disclaimer.
--  2. Redistributions in binary form must reproduce the above copyright
--     notice, this list of conditions and the following disclaimer in the
--     documentation and/or other materials provided with the distribution.
--
--  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
--  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
--  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
--  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
--  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
--  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
--  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
--  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
--  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
--  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
------------------------------------------------------------------------------

with Ada.Unchecked_Conversion;

with Interfaces;      use Interfaces;

with Random;

package SPARKNaCl
  with SPARK_Mode => On
is
   --==============================
   --  Exported types and constants
   --==============================

   subtype Byte is Unsigned_8;

   subtype I32 is Integer_32;
   subtype N32 is I32 range 0 .. I32'Last;

   subtype I64 is Integer_64;
   subtype U32 is Unsigned_32;
   subtype U64 is Unsigned_64;

   type U32_Seq  is array (N32 range <>) of U32;
   type U64_Seq  is array (N32 range <>) of U64;
   type I64_Seq  is array (N32 range <>) of I64;
   type Byte_Seq is array (N32 range <>) of Byte;

   subtype Index_8  is I32 range 0 .. 7;
   subtype Index_16 is I32 range 0 .. 15;
   subtype Index_24 is I32 range 0 .. 23;
   subtype Index_32 is I32 range 0 .. 31;
   subtype Index_64 is I32 range 0 .. 63;
   subtype Index_256 is I32 range 0 .. 255;

   subtype Bytes_8  is Byte_Seq (Index_8);
   subtype Bytes_16 is Byte_Seq (Index_16);
   subtype Bytes_24 is Byte_Seq (Index_24);
   subtype Bytes_32 is Byte_Seq (Index_32);
   subtype Bytes_64 is Byte_Seq (Index_64);
   subtype Bytes_256 is Byte_Seq (Index_256);

   subtype I64_Seq_64 is I64_Seq (Index_64);

   subtype GF         is I64_Seq (Index_16);

   Zero_Bytes_16 : constant Bytes_16 := (others => 0);
   Zero_Bytes_32 : constant Bytes_32 := (others => 0);

   --   0 == "strings are equal" or "verified OK"
   --  -1 == "strings are not equal" or "verification failed"
   subtype Verify_Result is I32 range -1 .. 0;

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
     with Global => Random.Entropy;


   procedure Crypto_Sign (SM :    out Byte_Seq;
                          M  : in     Byte_Seq;
                          SK : in     Bytes_64)
     with Global => null,
          Pre => (M'First   = 0 and
                  SM'First  = 0 and
                  M'Last   <= N32'Last - 64) and then
                 (SM'Length = M'Length + 64 and
                  SM'Last   = M'Last + 64);

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
          Pre    => (M'First = 0 and
                     C'First = 0 and
                     C'Last  = M'Last and
                     M'Length >= 32) and then
                    M (0 .. 31) = Zero_Bytes_32,
          Post   => C (0 .. 15) = Zero_Bytes_16;


   procedure Crypto_Secretbox_Open
     (M      :    out Byte_Seq; --  Output plaintext
      Status :    out Verify_Result;
      C      : in     Byte_Seq; --  Input ciphertext
      N      : in     Bytes_24; --  Nonce
      K      : in     Bytes_32) --  Key)
     with Global => null,
          Pre    => (M'First = 0 and
                     C'First = 0 and
                     M'Last  = C'Last and
                     C'Length >= 32) and then
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
     with Global => Random.Entropy;

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
          Pre    => (M'First = 0 and
                     C'First = 0 and
                     C'Last  = M'Last and
                     M'Length >= 32) and then
                    M (0 .. 31) = Zero_Bytes_32,
          Post   => C (0 .. 15) = Zero_Bytes_16;

   procedure Crypto_Box_Open_AfterNM
     (M      :    out Byte_Seq; --  Output plaintext
      Status :    out Verify_Result;
      C      : in     Byte_Seq; --  Input ciphertext
      N      : in     Bytes_24; --  Nonce
      K      : in     Bytes_32) --  Key)
     with Global => null,
          Pre    => (M'First = 0 and
                     C'First = 0 and
                     M'Last  = C'Last and
                     C'Length >= 32) and then
                    C (0 .. 15) = Zero_Bytes_16,
          Post   => M (0 .. 31) = Zero_Bytes_32;

   procedure Crypto_Box (C      :    out Byte_Seq;
                         Status :    out Verify_Result;
                         M      : in     Byte_Seq;
                         N      : in     Bytes_24;
                         Y, X   : in     Bytes_32)
     with Global => null,
          Pre    => (M'First = 0 and
                     C'First = 0 and
                     C'Last  = M'Last and
                     M'Length >= 32) and then
                    M (0 .. 31) = Zero_Bytes_32,
          Post   => C (0 .. 15) = Zero_Bytes_16;


   procedure Crypto_Box_Open (M      :    out Byte_Seq;
                              Status :    out Verify_Result;
                              C      : in     Byte_Seq;
                              N      : in     Bytes_24;
                              Y, X   : in     Bytes_32)
     with Global => null,
          Pre    => (M'First = 0 and
                     C'First = 0 and
                     M'Last  = C'Last and
                     C'Length >= 32) and then
                    C (0 .. 15) = Zero_Bytes_16,
          Post   => M (0 .. 31) = Zero_Bytes_32;


   --------------------------------------------------------
   --  Constant time equality tests
   --------------------------------------------------------

   function Crypto_Verify_16 (X, Y : in Bytes_16) return Verify_Result
     with Global => null;

   function Crypto_Verify_32 (X, Y : in Bytes_32) return Verify_Result
     with Global => null;

   --------------------------------------------------------
   --  RNG
   --------------------------------------------------------

   procedure Random_Bytes (R : out Byte_Seq)
     with Global => Random.Entropy;

private
   --===============
   --  Local types
   --===============

   subtype Bit  is Byte range 0 .. 1;
   subtype Index_4  is I32 range 0 .. 3;
   subtype Index_15 is I32 range 0 .. 14;
   subtype Index_17 is I32 range 0 .. 16;
   subtype Index_20 is I32 range 0 .. 19;
   subtype Index_31 is I32 range 0 .. 30;

   subtype Bytes_4  is Byte_Seq (Index_4);

   subtype U32_Seq_4   is U32_Seq (Index_4);
   subtype U32_Seq_16  is U32_Seq (Index_16);
   subtype Poly_1305_F is U32_Seq (Index_17);

   subtype I64_Seq_32 is I64_Seq (Index_32);

   subtype U64_Seq_16 is U64_Seq (Index_16);
   subtype U64_Seq_8  is U64_Seq (Index_8);

   type GF_Vector_4 is array (Index_4) of GF;

   --  Local types for expressing a "Normalized" GF with
   --  all limbs in the range 0 .. 65535
   --
   --   subtype GF_Limb is I64 range 0 .. 65535;
   --   type GF_Normalized is new GF
   --     with Dynamic_Predicate => (for all I in Index_16 =>
   --                                  GF_Normalized (I) in GF_Limb);


   --===============================
   --  Local expression functions
   --===============================

   function To_U64 is new Ada.Unchecked_Conversion (I64, U64);
   function To_I64 is new Ada.Unchecked_Conversion (U64, I64);

   --  returns equivalent of X >> 16 in C, doing an arithmetic
   --  shift right when X is negative
   function ASR_16 (X : in I64) return I64
   is (To_I64 (Shift_Right_Arithmetic (To_U64 (X), 16)))
     with Post => ASR_16'Result >= -2**47 and
                  ASR_16'Result <= (2**47) - 1;

   --  returns equivalent of X >> 8 in C, doing an arithmetic
   --  shift right when X is negative
   function ASR_8 (X : in I64) return I64
   is (To_I64 (Shift_Right_Arithmetic (To_U64 (X), 8)))
     with Post => ASR_8'Result >= -2**55 and
                  ASR_8'Result <= (2**55) - 1;

   --  returns equivalent of X >> 4 in C, doing an arithmetic
   --  shift right when X is negative
   function ASR_4 (X : in I64) return I64
   is (To_I64 (Shift_Right_Arithmetic (To_U64 (X), 4)))
     with Post => ASR_4'Result >= -2**59 and
                  ASR_4'Result <= (2**59) - 1;

   --  Rotate Left 32
   function RL32 (X : in U32;
                  C : in Natural) return U32
   is (Rotate_Left (X, C))
     with Global => null;

   --  Rotate right 64
   function RR64 (X : in U64;
                  C : in Natural) return U64
   is (Rotate_Right (X, C))
     with Global => null;

   --===============================
   --  Local subprogram declarations
   --===============================

   procedure TS64 (X :    out Bytes_8;
                   U : in     U64)
     with Global => null;


end SPARKNaCl;
