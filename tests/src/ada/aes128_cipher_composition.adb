with SPARKNaCl;     use SPARKNaCl;
with SPARKNaCl.AES; use SPARKNaCl.AES;

with Ada.Text_IO; use Ada.Text_IO;
with Interfaces;  use Interfaces;

with Random;

procedure AES128_Cipher_Composition
is
   Iteration_Count : constant I32 := 1_000;

   Plaintext : Bytes_16;
   Raw_Key   : Bytes_16;

   Encryption_Result, Decryption_Result : Bytes_16;
begin
   Put ("Testing" & Iteration_Count'Img & " AES128 Cipher compositions: "); 

   for I in 1 .. Iteration_Count loop
      Random.Random_Bytes (Plaintext);
      Random.Random_Bytes (Raw_Key);

      declare
         Key        : constant AES128_Key := Construct (Raw_Key);
         Round_Keys : constant AES128_Round_Keys := Key_Expansion (Key);
      begin
         Cipher (Encryption_Result, Plaintext, Round_Keys);
         Inv_Cipher (Decryption_Result, Encryption_Result, Round_Keys);
      end;

      if not Equal (Decryption_Result, Plaintext) then
         Put_Line ("Compoistion Test " & I'Img & " failed");
         Put_Line ("Raw Key:");

         for I in Raw_Key'Range loop
            Put (Raw_Key (I)'Img);
            exit when I = Raw_Key'Last;
            Put (" ");
         end loop;

         Put_Line("");
         Put_Line ("Plaintext:");

         for I in Plaintext'Range loop
            Put (Plaintext (I)'Img);
            exit when I = Plaintext'Last;
            Put (" ");
         end loop;

         Put_Line ("");
         exit;
      end if;
   end loop; 

   Put_Line ("Done");
end AES128_Cipher_Composition;
