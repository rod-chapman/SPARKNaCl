package SPARKNaCl.Sign
  with Pure,
       SPARK_Mode => On
is
   --  Limited, so no assignment or comparison, and always
   --  pass-by-reference.
   type Signing_PK is limited private;
   type Signing_SK is limited private;

   --------------------------------------------------------
   --  Public key signatures
   --------------------------------------------------------

   procedure Keypair (SK_Raw : in     Bytes_32; -- random please!
                      PK     :    out Signing_PK;
                      SK     :    out Signing_SK)
     with Global => null;

   procedure PK_From_Bytes (PK_Raw : in     Bytes_32;
                            PK     :    out Signing_PK)
     with Global => null;

   function Serialize (K : in Signing_SK) return Bytes_64
     with Global => null;

   function Serialize (K : in Signing_PK) return Bytes_32
     with Global => null;

   procedure Sanitize (K : out Signing_PK)
     with Global => null;

   procedure Sanitize (K : out Signing_SK)
     with Global => null;


   --  The length of a signature block that is prepended to a message
   --  when signed.
   Sign_Bytes : constant := 64;

   procedure Sign (SM :    out Byte_Seq;
                   M  : in     Byte_Seq;
                   SK : in     Signing_SK)
     with Global => null,
          Relaxed_Initialization => SM,
          Pre => (M'First   = 0 and
                  SM'First  = 0 and
                  M'Last   <= N32'Last - Sign_Bytes) and then
                 (SM'Length = M'Length + Sign_Bytes and
                  SM'Last   = M'Last + Sign_Bytes),
          Post => SM'Initialized;

   procedure Open (M      :    out Byte_Seq;
                   Status :    out Boolean;
                   MLen   :    out I32;
                   SM     : in     Byte_Seq;
                   PK     : in     Signing_PK)
     with Global => null,
          Pre => M'First   = 0 and
                 SM'First  = 0 and
                 SM'Length = M'Length and
                 SM'Last   = M'Last and
                 SM'Length >= Sign_Bytes;

private
   --  Note - also limited types here in the full view to ensure
   --  no assignment and pass-by-reference in the body.
   type Signing_PK is limited record
      F : Bytes_32;
   end record;

   type Signing_SK is limited record
      F : Bytes_64;
   end record;

end SPARKNaCl.Sign;
