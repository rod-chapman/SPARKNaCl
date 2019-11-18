with SPARKNaCl;           use SPARKNaCl;
with SPARKNaCl.Cryptobox; use SPARKNaCl.Cryptobox;
with SPARKNaCl.Stream;
with Ada.Text_IO;         use Ada.Text_IO;
procedure BadBox
is
   AliceSK, BobSK : Secret_Key;
   AlicePK, BobPK : Public_Key;
   N : Stream.HSalsa20_Nonce;
   S, S2 : Boolean;

   subtype Text is Byte_Seq (0 .. 100);
   M, C, M2 : Text := (others => 0);
begin
   Keypair (AlicePK, AliceSK);
   Keypair (BobPK, BobSK);
   Random_Bytes (Bytes_24 (N));

   Random_Bytes (M (Plaintext_Zero_Bytes .. M'Last));

   -- Final 2 params wrong way round
   Create (C, S, M, N, AliceSK, BobPK);

   -- Final 2 params wrong way round
   Open (M2, S2, C, N, BobSK, AlicePK);
end BadBox;
