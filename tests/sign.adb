with SPARKNaCl_Types; use SPARKNaCl_Types;
with SPARKNaCl;       use SPARKNaCl;
with SPARKNaCl.Debug; use SPARKNaCl.Debug;
with Ada.Text_IO;     use Ada.Text_IO;
procedure Sign
is
   PK : Bytes_32;
   SK : Bytes_64;

   M : constant Bytes_256 := (0 => 16#55#, others => 16#aa#);

   SM : Byte_Seq (0 .. 319) := (others => 0);
   M2 : Byte_Seq (0 .. 319) := (others => 0);

   ML : I32;
   S  : Verify_Result;
begin
   Crypto_Sign_Keypair (PK, SK);
   DH ("SK is ", SK);
   DH ("PK is ", PK);
   DH ("M is ", M);

   Crypto_Sign (SM, M, SK);
   DH ("SM is ", SM);

   Crypto_Sign_Open (M2, S, ML, SM, PK);
   DH ("M2 is ", M2);
   Put_Line ("Status is " & S'Img);
   Put_Line ("ML is " & ML'Img);
end Sign;
