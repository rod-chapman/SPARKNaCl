with SPARKNaCl;           use SPARKNaCl;
with SPARKNaCl.Core;
with SPARKNaCl.Secretbox; use SPARKNaCl.Secretbox;
with SPARKNaCl.Stream;
with Random;
with Ada.Text_IO;         use Ada.Text_IO;
with Interfaces;          use Interfaces;
procedure Secretbox7
is
   RK    : Bytes_32;
   K     : Core.Salsa20_Key;
   N     : Stream.HSalsa20_Nonce;
   S, S2 : Boolean;
begin
   for MLen in N32 range 0 .. 999 loop
      Random.Random_Bytes (RK);
      Core.Construct (K, RK);
      Random.Random_Bytes (Bytes_24 (N));
      Put ("Secretbox7 - iteration" & MLen'Img);

      declare
         subtype Text is
           Byte_Seq (0 .. Secretbox_Zero_Bytes + MLen - 1);
         M, C, M2 : Text := (others => 0);
      begin
         Random.Random_Bytes (M (Secretbox_Zero_Bytes .. M'Last));
         Create (C, S, M, N, K);
         if S then
            Open (M2, S2, C, N, K);
            if S2 then
               if not Equal (M, M2) then
                  Put_Line ("bad decryption");
                  exit;
               else
                  Put_Line (" OK");
               end if;
            else
               Put_Line ("ciphertext fails verification");
               exit;
            end if;
         else
            Put_Line ("bad encryption");
            exit;
         end if;
      end;
   end loop;
end Secretbox7;
