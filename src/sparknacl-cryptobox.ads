with SPARKNaCl.Core;
with SPARKNaCl.Stream;
package SPARKNaCl.Cryptobox
  with Pure,
       SPARK_Mode => On
is
   --------------------------------------------------------
   --  Public Key Authenticated Encryption - "Crypto Box" --
   --------------------------------------------------------

   --  Limited, so no assignment or comparison, and always
   --  pass-by-reference.
   type Secret_Key is limited private;
   type Public_Key is limited private;

   Plaintext_Zero_Bytes  : constant := 32;
   Ciphertext_Zero_Bytes : constant := 16;

   --  Key generation
   procedure Keypair (Raw_SK : in     Bytes_32;
                      PK     :    out Public_Key;
                      SK     :    out Secret_Key)
     with Global => null;

   function Construct (K : in Bytes_32) return Secret_Key
     with Global => null;

   function Construct (K : in Bytes_32) return Public_Key
     with Global => null;

   function Serialize (K : in Secret_Key) return Bytes_32
     with Global => null;

   function Serialize (K : in Public_Key) return Bytes_32
     with Global => null;

   --  Sanitization
   procedure Sanitize (K : out Secret_Key)
     with Global => null;

   procedure Sanitize (K : out Public_Key)
     with Global => null;

   --  Precomputation
   procedure BeforeNM (K  :    out Core.Salsa20_Key;
                       PK : in     Public_Key;
                       SK : in     Secret_Key)
     with Global => null;


   --  Postcomputation for Create
   procedure AfterNM (C      :    out Byte_Seq;
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

   --  Postcomputation for Open
   procedure Open_AfterNM
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

   --  Top-level all-in-one Create operation
   procedure Create (C            :    out Byte_Seq;
                     Status       :    out Boolean;
                     M            : in     Byte_Seq;
                     N            : in     Stream.HSalsa20_Nonce;
                     Recipient_PK : in     Public_Key;
                     Sender_SK    : in     Secret_Key)
     with Global => null,
          Pre    => (M'First = 0 and
                     C'First = 0 and
                     C'Last  = M'Last and
                     M'Length >= 32) and then
                    Equal (M (0 .. 31), Zero_Bytes_32),
          Post   => Equal (C (0 .. 15), Zero_Bytes_16);


   --  Top-level all-in-one Open operation
   procedure Open (M            :    out Byte_Seq;
                   Status       :    out Boolean;
                   C            : in     Byte_Seq;
                   N            : in     Stream.HSalsa20_Nonce;
                   Sender_PK    : in     Public_Key;
                   Recipient_SK : in     Secret_Key)
     with Global => null,
          Pre    => (M'First = 0 and
                     C'First = 0 and
                     M'Last  = C'Last and
                     C'Length >= 32) and then
                    Equal (C (0 .. 15), Zero_Bytes_16),
          Post   => Equal (M (0 .. 31), Zero_Bytes_32);

private
   --  Note - also limited types here in the full view to ensure
   --  no assignment and pass-by-reference in the body.
   type Secret_Key is limited record
      F : Bytes_32;
   end record;

   type Public_Key is limited record
      F : Bytes_32;
   end record;
end SPARKNaCl.Cryptobox;
