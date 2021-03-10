with SPARKNaCl.Scalar;
with SPARKNaCl.Secretbox;

package body SPARKNaCl.Cryptobox
  with SPARK_Mode => On
is
   procedure Keypair (Raw_SK : in     Bytes_32;
                      PK     :    out Public_Key;
                      SK     :    out Secret_Key)
   is
   begin
      SK.F := Raw_SK;
      PK.F := Scalar.Mult_Base (Raw_SK);
   end Keypair;

   function Construct (K : in Bytes_32) return Secret_Key
   is
   begin
      return Secret_Key'(F => K);
   end Construct;

   function Construct (K : in Bytes_32) return Public_Key
   is
   begin
      return Public_Key'(F => K);
   end Construct;

   function Serialize (K : in Secret_Key) return Bytes_32
   is
   begin
      return K.F;
   end Serialize;

   function Serialize (K : in Public_Key) return Bytes_32
   is
   begin
      return K.F;
   end Serialize;

   procedure Sanitize (K : out Secret_Key)
   is
   begin
      Sanitize (K.F);
   end Sanitize;

   procedure Sanitize (K : out Public_Key)
   is
   begin
      Sanitize (K.F);
   end Sanitize;

   procedure BeforeNM (K  :    out Core.Salsa20_Key;
                       PK : in     Public_Key;
                       SK : in     Secret_Key)
   is
      S  : Bytes_32;
      LK : Bytes_32;
   begin
      S := Scalar.Mult (SK.F, PK.F);
      Core.HSalsa20 (Output => LK,
                     Input  => Zero_Bytes_16,
                     K      => Core.Construct (S),
                     C      => Sigma);
      Core.Construct (K, LK);

      pragma Warnings (GNATProve, Off, "statement has no effect");
      Sanitize (S);
      Sanitize (LK);
      pragma Unreferenced (S, LK);
   end BeforeNM;

   procedure AfterNM (C      :    out Byte_Seq;
                      Status :    out Boolean;
                      M      : in     Byte_Seq;
                      N      : in     Stream.HSalsa20_Nonce;
                      K      : in     Core.Salsa20_Key)
   is
   begin
      Secretbox.Create (C, Status, M, N, K);
   end AfterNM;

   procedure Open_AfterNM
     (M      :    out Byte_Seq; --  Output plaintext
      Status :    out Boolean;
      C      : in     Byte_Seq; --  Input ciphertext
      N      : in     Stream.HSalsa20_Nonce;
      K      : in     Core.Salsa20_Key)
   is
   begin
      Secretbox.Open (M, Status, C, N, K);
   end Open_AfterNM;

   procedure Create (C            :    out Byte_Seq;
                     Status       :    out Boolean;
                     M            : in     Byte_Seq;
                     N            : in     Stream.HSalsa20_Nonce;
                     Recipient_PK : in     Public_Key;
                     Sender_SK    : in     Secret_Key)
   is
      K : Core.Salsa20_Key;
   begin
      BeforeNM (K, Recipient_PK, Sender_SK);
      AfterNM (C, Status, M, N, K);
      pragma Warnings (GNATProve, Off, "statement has no effect");
      Core.Sanitize (K);
      pragma Unreferenced (K);
   end Create;

   procedure Open (M            :    out Byte_Seq;
                   Status       :    out Boolean;
                   C            : in     Byte_Seq;
                   N            : in     Stream.HSalsa20_Nonce;
                   Sender_PK    : in     Public_Key;
                   Recipient_SK : in     Secret_Key)
   is
      K : Core.Salsa20_Key;
   begin
      BeforeNM (K, Sender_PK, Recipient_SK);
      Open_AfterNM (M, Status, C, N, K);
      pragma Warnings (GNATProve, Off, "statement has no effect");
      Core.Sanitize (K);
      pragma Unreferenced (K);
   end Open;

end SPARKNaCl.Cryptobox;
