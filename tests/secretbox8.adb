with SPARKNaCl;   use SPARKNaCl;
with Random;      use Random;
with Ada.Text_IO; use Ada.Text_IO;
with Interfaces;  use Interfaces;
with Ada.Numerics.Discrete_Random;

procedure Secretbox8
is
   K : Bytes_32;
   N : Bytes_24;
   S, S2 : Boolean;
begin
   for MLen in N32 range 0 .. 999 loop
      Random_Bytes (K);
      Random_Bytes (N);
      Put ("Secretbox8 - iteration" & MLen'Img);
      declare
         subtype Index is
           N32 range 0 .. Crypto_Box_Plaintext_Zero_Bytes + MLen - 1;
         subtype CIndex is
           N32 range Crypto_Box_Ciphertext_Zero_Bytes .. Index'Last;
         subtype Text is
           Byte_Seq (Index);
         package RI is new Ada.Numerics.Discrete_Random (CIndex);
         G : RI.Generator;
         M, C, M2 : Text := (others => 0);
         Caught : Integer := 0;
      begin
         RI.Reset (G);
         Random_Bytes (M (Crypto_Box_Plaintext_Zero_Bytes .. M'Last));
         Crypto_Secretbox (C, S, M, N, K);

         if S then
            while (Caught < 10) loop
               C (RI.Random (G)) := Random_Byte;
               Crypto_Secretbox_Open (M2, S2, C, N, K);
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
