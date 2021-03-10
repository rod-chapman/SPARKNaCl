with SPARKNaCl;           use SPARKNaCl;
with SPARKNaCl.Cryptobox; use SPARKNaCl.Cryptobox;
with SPARKNaCl.Stream;
with Ada.Text_IO;         use Ada.Text_IO;
with Interfaces;          use Interfaces;
with Random;
procedure Box7
is
   Raw_SK : Bytes_32;
   AliceSK, BobSK : Secret_Key;
   AlicePK, BobPK : Public_Key;
   N : Stream.HSalsa20_Nonce;
   S, S2 : Boolean;
begin
--   for MLen in N32 range 0 .. 999 loop
   for MLen in N32 range 0 .. 99 loop
      Random.Random_Bytes (Raw_SK);
      Keypair (Raw_SK, AlicePK, AliceSK);
      Random.Random_Bytes (Raw_SK);
      Keypair (Raw_SK, BobPK, BobSK);
      Random.Random_Bytes (Bytes_24 (N));
      Put ("Box7 - iteration" & MLen'Img);
      declare
         subtype Text is
           Byte_Seq (0 .. Plaintext_Zero_Bytes + MLen - 1);
         M, C, M2 : Text := (others => 0);
      begin
         Random.Random_Bytes (M (Plaintext_Zero_Bytes .. M'Last));
         Create (C, S, M, N, BobPK, AliceSK);
         if S then
            Open (M2, S2, C, N, AlicePK, BobSK);
            if S2 then
               if not Equal (M, M2) then
                  Put_Line ("bad decryption");
                  exit;
               else
                  Put_Line (" OK");
               end if;
            else
               Put_Line ("ciphertext fails verification");
            end if;
         else
            Put_Line ("bad encryption");
         end if;
      end;
   end loop;


end Box7;
