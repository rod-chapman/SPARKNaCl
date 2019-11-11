with SPARKNaCl.Utils;
with SPARKNaCl.Scalar;
with SPARKNaCl.Secretbox;

package body SPARKNaCl.Cryptobox
  with SPARK_Mode => On
is

   --  POK
   procedure Keypair (PK : out Public_Key;
                      SK : out Secret_Key)
   is
   begin
      SK := Secret_Key (Utils.Random_Bytes_32);
      PK := Public_Key (Scalar.Mult_Base (Bytes_32 (SK)));
   end Keypair;

   --  POK
   procedure BeforeNM (K  :    out Core.Salsa20_Key;
                       PK : in     Public_Key;
                       SK : in     Secret_Key)
   is
      S  : Bytes_32;
   begin
      S := Scalar.Mult (Bytes_32 (SK), Bytes_32 (PK));
      Core.HSalsa20 (Output => Bytes_32 (K),
                     Input  => Zero_Bytes_16,
                     K      => Core.Salsa20_Key (S),
                     C      => Sigma);
   end BeforeNM;

   --  POK
   procedure AfterNM (C      :    out Byte_Seq;
                      Status :    out Boolean;
                      M      : in     Byte_Seq;
                      N      : in     Stream.HSalsa20_Nonce;
                      K      : in     Core.Salsa20_Key)
   is
   begin
      Secretbox.Create (C, Status, M, N, K);
   end AfterNM;

   --  POK
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

   --  POK
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
   end Create;

   --  POK
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
   end Open;

end SPARKNaCl.Cryptobox;
