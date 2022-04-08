package SPARKNaCl.Core
  with Pure,
       SPARK_Mode => On
is
   --  Limited, so no assignment or comparison, and always
   --  pass-by-reference.
   type Salsa20_Key is limited private;
   type ChaCha20_Key is limited private;
   type ChaCha20_Context is limited private;

   subtype ChaCha20_Nonce is Bytes_8;
   subtype ChaCha20_IETF_Nonce is Bytes_12;

   --------------------------------------------------------
   --  Salsa20 Key utility functions
   --------------------------------------------------------

   function Construct (K : in Bytes_32) return Salsa20_Key
     with Global => null;

   procedure Construct (K :    out Salsa20_Key;
                        X : in     Bytes_32)
     with Global => null;

   function Serialize (K : in Salsa20_Key) return Bytes_32
     with Global => null;

   procedure Sanitize (K : out Salsa20_Key)
     with Global => null;

   --------------------------------------------------------
   --  ChaCha20 Key utility functions
   --------------------------------------------------------

   function Construct (K : in Bytes_32) return ChaCha20_Key
     with Global => null;

   procedure Construct (K :    out ChaCha20_Key;
                        X : in     Bytes_32)
     with Global => null;

   function Serialize (K : in ChaCha20_Key) return Bytes_32
     with Global => null;

   procedure Sanitize (K : out ChaCha20_Key)
     with Global => null;

   procedure Sanitize (S : out ChaCha20_Context)
     with Global => null;

   --------------------------------------------------------
   --  Salsa20 Core functions
   --------------------------------------------------------

   procedure Salsa20 (Output :    out Bytes_64;
                      Input  : in     Bytes_16;
                      K      : in     Salsa20_Key;
                      C      : in     Bytes_16) --  Counter
     with Global => null;

   procedure HSalsa20 (Output :    out Bytes_32;
                       Input  : in     Bytes_16;
                       K      : in     Salsa20_Key;
                       C      : in     Bytes_16) --  Counter
     with Global => null;

   --------------------------------------------------------
   --  ChaCha20 Core functions
   --------------------------------------------------------

   procedure ChaCha20_Key_IV_Setup (Context :    out ChaCha20_Context;
                                    K       : in     ChaCha20_Key;
                                    N       : in     ChaCha20_Nonce;
                                    Counter : in     U64)
     with Global => null;

   procedure ChaCha20_Key_IV_IETF_Setup (Context :    out ChaCha20_Context;
                                         K       : in     ChaCha20_Key;
                                         N       : in     ChaCha20_IETF_Nonce;
                                         Counter : in     U32)
     with Global => null;

   procedure ChaCha20_Encrypt_Bytes (Context : in     ChaCha20_Context;
                                     C       :    out Byte_Seq;
                                     M       : in     Byte_Seq;
                                     Xor_M   : in     Boolean)
     with Global => null,
          Relaxed_Initialization => C,
          Pre    => C'First = 0 and
                    M'First = 0 and
                    (if Xor_M then M'Length = C'Length) and
                    (if not Xor_M then M'Length = 64) and
                    U32 (C'Length) <= U32 (N32'Last) and
                    C'First >= N32'First and
                    M'First >= N32'First;

private
   --  Note - also limited here in the full view to ensure
   --  no assignment and pass-by-reference in the body.
   type Salsa20_Key is limited record
      F : Bytes_32;
   end record;

   type ChaCha20_Key is limited record
      F : Bytes_32;
   end record;

   type ChaCha20_Context is limited record
      F : U32_Seq (Index_16);
   end record;
end SPARKNaCl.Core;
