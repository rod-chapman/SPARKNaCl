package SPARKNaCl.Sign
  with SPARK_Mode => On
is
   type Signing_PK is limited private;
   type Signing_SK is limited private;

   --------------------------------------------------------
   --  Public key signatures
   --------------------------------------------------------

   procedure Keypair (PK : out Signing_PK;
                      SK : out Signing_SK)
     with Global => Random.Entropy;


   procedure Sign (SM :    out Byte_Seq;
                   M  : in     Byte_Seq;
                   SK : in     Signing_SK)
     with Global => null,
          Pre => (M'First   = 0 and
                  SM'First  = 0 and
                  M'Last   <= N32'Last - 64) and then
                 (SM'Length = M'Length + 64 and
                  SM'Last   = M'Last + 64);

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
                 SM'Length >= 64;

   procedure Sanitize (R : out Signing_PK)
     with Global => null;

   procedure Sanitize (R : out Signing_SK)
     with Global => null;

private
   type Signing_PK is new Bytes_32;
   type Signing_SK is new Bytes_64;

end SPARKNaCl.Sign;
