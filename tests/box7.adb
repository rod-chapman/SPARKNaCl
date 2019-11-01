with SPARKNaCl;        use SPARKNaCl;
with SPARKNaCl.Random; use SPARKNaCl.Random;
with Ada.Text_IO;      use Ada.Text_IO;
with Interfaces;       use Interfaces;
procedure Box7
is
   AliceSK, AlicePK, BobSK, BobPK : Bytes_32;
   N : Bytes_24;
   S, S2 : Verify_Result;
begin
--   for MLen in N32 range 0 .. 999 loop
   for MLen in N32 range 0 .. 99 loop
      Crypto_Box_Keypair (AlicePK, AliceSK);
      Crypto_Box_Keypair (BobPK, BobSK);
      Random_Bytes (N);
      Put ("Box7 - iteration" & MLen'Img);
      declare
         subtype Text is
           Byte_Seq (0 .. Crypto_Box_Plaintext_Zero_Bytes + MLen - 1);
         M, C, M2 : Text := (others => 0);
      begin
         Random_Bytes (M (Crypto_Box_Plaintext_Zero_Bytes .. M'Last));
         Crypto_Box (C, S, M, N, BobPK, AliceSK);
         if S = 0 then
            Crypto_Box_Open (M2, S2, C, N, AlicePK, BobSK);
            if S2 = 0 then
               if M /= M2 then
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
