package SPARKNaCl.Sign
  with SPARK_Mode => On
is
   --------------------------------------------------------
   --  Public key signatures
   --------------------------------------------------------

   procedure Keypair (PK : out Bytes_32;
                      SK : out Bytes_64)
     with Global => Random.Entropy;


   procedure Sign (SM :    out Byte_Seq;
                   M  : in     Byte_Seq;
                   SK : in     Bytes_64)
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
                   PK     : in     Bytes_32)
     with Global => null,
          Pre => M'First   = 0 and
                 SM'First  = 0 and
                 SM'Length = M'Length and
                 SM'Last   = M'Last and
                 SM'Length >= 64;

end SPARKNaCl.Sign;
