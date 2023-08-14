with SPARKNaCl;           use SPARKNaCl;
with SPARKNaCl.Core;
with SPARKNaCl.Secretbox; use SPARKNaCl.Secretbox;
with SPARKNaCl.Cryptobox;
with SPARKNaCl.Stream;
with Random;              use Random;
with Ada.Text_IO;         use Ada.Text_IO;
with Interfaces;          use Interfaces;
with Ada.Numerics.Discrete_Random;

procedure Secretbox8
is
   RK    : Bytes_32;
   K     : Core.Salsa20_Key;
   N     : Stream.HSalsa20_Nonce;
   S, S2 : Boolean;
begin
   for MLen in N32 range 0 .. 999 loop
      Random_Bytes (RK);
      Core.Construct (K, RK);
      Random_Bytes (Bytes_24 (N));
      Put ("Secretbox8 - iteration" & MLen'Img);
      declare
         subtype Index is
           N32 range 0 .. Cryptobox.Plaintext_Zero_Bytes + MLen - 1;
         subtype CIndex is
           N32 range Cryptobox.Ciphertext_Zero_Bytes .. Index'Last;
         subtype Text is
           Byte_Seq (Index);
         package RI is new Ada.Numerics.Discrete_Random (CIndex);
         G : RI.Generator;
         M, C, M2 : Text := (others => 0);
         Caught : Integer := 0;
      begin
         RI.Reset (G);
         Random_Bytes (M (Cryptobox.Plaintext_Zero_Bytes .. M'Last));
         Create (C, S, M, N, K);

         if S then
            while (Caught < 10) loop
               C (RI.Random (G)) := Random_Byte;
               Open (M2, S2, C, N, K);
               if S2 then
                  if not Equal (M, M2) then
                     Put (" forgery!");
                     exit;
                  end if;
               else
                  Caught := Caught + 1;
               end if;
            end loop;
            New_Line;
         else
            Put_Line ("bad encryption");
         end if;
      end;
   end loop;

end Secretbox8;
