with SPARKNaCl.Core;
with SPARKNaCl.Scalar;
with SPARKNaCl.Secretbox;

package body SPARKNaCl.Cryptobox
  with SPARK_Mode => On
is

   --  POK
   procedure Keypair (Y, X : out Bytes_32)
   is
   begin
      X := Random_Bytes_32;
      Scalar.Mult_Base (Y, X);
   end Keypair;

   --  POK
   procedure BeforeNM (K    :    out Bytes_32;
                       Y, X : in     Bytes_32)
   is
      S : Bytes_32;
   begin
      Scalar.Mult (S, X, Y);
      Core.HSalsa20 (K, Zero_Bytes_16, S, Sigma);
   end BeforeNM;

   --  POK
   procedure AfterNM (C      :    out Byte_Seq;
                      Status :    out Boolean;
                      M      : in     Byte_Seq;
                      N      : in     Bytes_24;
                      K      : in     Bytes_32)
   is
   begin
      Secretbox.Create (C, Status, M, N, K);
   end AfterNM;

   --  POK
   procedure Open_AfterNM
     (M      :    out Byte_Seq; --  Output plaintext
      Status :    out Boolean;
      C      : in     Byte_Seq; --  Input ciphertext
      N      : in     Bytes_24; --  Nonce
      K      : in     Bytes_32) --  Key)
   is
   begin
      Secretbox.Open (M, Status, C, N, K);
   end Open_AfterNM;

   --  POK
   procedure Create (C      :    out Byte_Seq;
                     Status :    out Boolean;
                     M      : in     Byte_Seq;
                     N      : in     Bytes_24;
                     Y, X   : in     Bytes_32)
   is
      K : Bytes_32;
   begin
      BeforeNM (K, Y, X);
      AfterNM (C, Status, M, N, K);
   end Create;

   --  POK
   procedure Open (M      :    out Byte_Seq;
                   Status :    out Boolean;
                   C      : in     Byte_Seq;
                   N      : in     Bytes_24;
                   Y, X   : in     Bytes_32)
   is
      K : Bytes_32;
   begin
      BeforeNM (K, Y, X);
      Open_AfterNM (M, Status, C, N, K);
   end Open;

end SPARKNaCl.Cryptobox;
