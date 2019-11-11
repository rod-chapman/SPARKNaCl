with SPARKNaCl.Utils;
with SPARKNaCl.Scalar;
with SPARKNaCl.Secretbox;

package body SPARKNaCl.Cryptobox
  with SPARK_Mode => On
is

   --  POK
   procedure Keypair (Y, X : out Bytes_32)
   is
   begin
      X := Utils.Random_Bytes_32;
      Scalar.Mult_Base (Y, X);
   end Keypair;

   --  POK
   procedure BeforeNM (K    :    out Core.Salsa20_Key;
                       Y, X : in     Bytes_32)
   is
      S  : Bytes_32;
   begin
      Scalar.Mult (S, X, Y);
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
   procedure Create (C      :    out Byte_Seq;
                     Status :    out Boolean;
                     M      : in     Byte_Seq;
                     N      : in     Stream.HSalsa20_Nonce;
                     Y, X   : in     Bytes_32)
   is
      K : Core.Salsa20_Key;
   begin
      BeforeNM (K, Y, X);
      AfterNM (C, Status, M, N, K);
   end Create;

   --  POK
   procedure Open (M      :    out Byte_Seq;
                   Status :    out Boolean;
                   C      : in     Byte_Seq;
                   N      : in     Stream.HSalsa20_Nonce;
                   Y, X   : in     Bytes_32)
   is
      K : Core.Salsa20_Key;
   begin
      BeforeNM (K, Y, X);
      Open_AfterNM (M, Status, C, N, K);
   end Open;

end SPARKNaCl.Cryptobox;
