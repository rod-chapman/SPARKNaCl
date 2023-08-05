with SPARKNaCl;     use SPARKNaCl;
with SPARKNaCl.AES; use SPARKNaCl.AES;

with Ada.Text_IO; use Ada.Text_IO;

procedure AES128_Cipher_KAT
is
   Test_Case_Count : constant I32 := 4;

   Keys : constant array (1 .. Test_Case_Count) of Bytes_16 := (
     -- ECB VarKey 128 count 0
     1 => (16#80#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
           16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#),
     -- ECB GFSbox 128 Count 0
     2 => (16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
           16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#),
     -- ECB VarKey 128 Count 1
     3 => (16#c0#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
           16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#),
     -- ECB GFSbox 128 Count 1
     4 => (16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
           16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#));

   Plaintexts : constant array (1 .. Test_Case_Count) of Bytes_16 := (
     1 => (16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
           16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#),
     2 => (16#f3#, 16#44#, 16#81#, 16#ec#, 16#3c#, 16#c6#, 16#27#, 16#ba#,
           16#cd#, 16#5d#, 16#c3#, 16#fb#, 16#08#, 16#f2#, 16#73#, 16#e6#),
     3 => (16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
           16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#),
     4 => (16#97#, 16#98#, 16#c4#, 16#64#, 16#0b#, 16#ad#, 16#75#, 16#c7#,
           16#c3#, 16#22#, 16#7d#, 16#b9#, 16#10#, 16#17#, 16#4e#, 16#72#));

   Ciphertexts : constant array (1 .. Test_Case_Count) of Bytes_16 := (
     1 => (16#0e#, 16#dd#, 16#33#, 16#d3#, 16#c6#, 16#21#, 16#e5#, 16#46#,
           16#45#, 16#5b#, 16#d8#, 16#ba#, 16#14#, 16#18#, 16#be#, 16#c8#),
     2 => (16#03#, 16#36#, 16#76#, 16#3e#, 16#96#, 16#6d#, 16#92#, 16#59#,
           16#5a#, 16#56#, 16#7c#, 16#c9#, 16#ce#, 16#53#, 16#7f#, 16#5e#),
     3 => (16#4b#, 16#c3#, 16#f8#, 16#83#, 16#45#, 16#0c#, 16#11#, 16#3c#,
           16#64#, 16#ca#, 16#42#, 16#e1#, 16#11#, 16#2a#, 16#9e#, 16#87#),
     4 => (16#a9#, 16#a1#, 16#63#, 16#1b#, 16#f4#, 16#99#, 16#69#, 16#54#,
           16#eb#, 16#c0#, 16#93#, 16#95#, 16#7b#, 16#23#, 16#45#, 16#89#));

begin
   for I in Keys'Range loop
      Put ("AES128 Cipher KAT - iteration" & I'Img & ": ");

      declare
         Key        : constant AES128_Key := Construct (Keys (I));
         Round_Keys : constant AES128_Round_Keys := Key_Expansion (Key);

         Plaintext  : constant Bytes_16 := Plaintexts (I);
         Ciphertext : constant Bytes_16 := Ciphertexts (I);

         Result : Bytes_16;
      begin
         Cipher (Result, Plaintext, Round_Keys);

         if Equal (Result, Ciphertext) then
            Put ("OK");
         else
            Put ("BAD");
         end if;

         Put (" Encryption | ");

         Inv_Cipher (Result, Ciphertext, Round_Keys);

         if Equal (Result, Plaintext) then
            Put ("OK");
         else
            Put ("BAD");
         end if;

         Put_Line (" Decryption");
      end;
   end loop;
end AES128_Cipher_KAT;
