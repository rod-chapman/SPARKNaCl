with SPARKNaCl;        use SPARKNaCl;
with SPARKNaCl.AES256; use SPARKNaCl.AES256;

with Ada.Text_IO; use Ada.Text_IO;

procedure AES256_ECB_KAT
is
   Test_Case_Count : constant I32 := 6;

   Keys : constant array (1 .. Test_Case_Count) of Bytes_32 := (
     1 => (16#80#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, -- ECB VarKey 256 count 0 
           16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
           16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
           16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#),
     2 => (16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, -- ECB GFSbox 256 Count 0
           16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
           16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
           16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#),
     3 => (16#c4#, 16#7b#, 16#02#, 16#94#, 16#db#, 16#bb#, 16#ee#, 16#0f#, -- ECB KeySbox 256 Count 0
           16#ec#, 16#47#, 16#57#, 16#f2#, 16#2f#, 16#fe#, 16#ee#, 16#35#,
           16#87#, 16#ca#, 16#47#, 16#30#, 16#c3#, 16#d3#, 16#3b#, 16#69#,
           16#1d#, 16#f3#, 16#8b#, 16#ab#, 16#07#, 16#6b#, 16#c5#, 16#58#),
     4 => (16#c0#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, -- ECB VarKey 256 Count 1
           16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
           16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
           16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#),
     5 => (16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, -- ECB GFSbox 256 Count 1
           16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
           16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
           16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#),
     6 => (16#28#, 16#d4#, 16#6c#, 16#ff#, 16#a1#, 16#58#, 16#53#, 16#31#, -- ECB KeySbox 256 Count 1
           16#94#, 16#21#, 16#4a#, 16#91#, 16#e7#, 16#12#, 16#fc#, 16#2b#,
           16#45#, 16#b5#, 16#18#, 16#07#, 16#66#, 16#75#, 16#af#, 16#fd#,
           16#91#, 16#0e#, 16#de#, 16#ca#, 16#5f#, 16#41#, 16#ac#, 16#64#));

   Plaintexts : constant array (1 .. Test_Case_Count) of Bytes_16 := (
     1 => (16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
           16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#),
     2 => (16#0b#, 16#24#, 16#af#, 16#36#, 16#19#, 16#3c#, 16#e4#, 16#66#,
           16#5f#, 16#28#, 16#25#, 16#d7#, 16#b4#, 16#74#, 16#9c#, 16#98#),
     3 => (16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
           16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#),
     4 => (16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
           16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#),
     5 => (16#0b#, 16#24#, 16#af#, 16#36#, 16#19#, 16#3c#, 16#e4#, 16#66#,
           16#5f#, 16#28#, 16#25#, 16#d7#, 16#b4#, 16#74#, 16#9c#, 16#98#),
     6 => (16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
           16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#));

   Ciphertexts : constant array (1 .. Test_Case_Count) of Bytes_16 := (
     1 => (16#e3#, 16#5a#, 16#6d#, 16#cb#, 16#19#, 16#b2#, 16#01#, 16#a0#,
           16#1e#, 16#bc#, 16#fa#, 16#8a#, 16#a2#, 16#2b#, 16#57#, 16#59#),
     2 => (16#a9#, 16#ff#, 16#75#, 16#bd#, 16#7c#, 16#f6#, 16#61#, 16#3d#,
           16#37#, 16#31#, 16#c7#, 16#7c#, 16#3b#, 16#6d#, 16#0c#, 16#04#),
     3 => (16#46#, 16#f2#, 16#fb#, 16#34#, 16#2d#, 16#6f#, 16#0a#, 16#b4#,
           16#77#, 16#47#, 16#6f#, 16#c5#, 16#01#, 16#24#, 16#2c#, 16#5f#),
     4 => (16#b2#, 16#91#, 16#69#, 16#cd#, 16#cf#, 16#2d#, 16#83#, 16#e8#,
           16#38#, 16#12#, 16#5a#, 16#12#, 16#ee#, 16#6a#, 16#a4#, 16#00#),
     5 => (16#a9#, 16#ff#, 16#75#, 16#bd#, 16#7c#, 16#f6#, 16#61#, 16#3d#,
           16#37#, 16#31#, 16#c7#, 16#7c#, 16#3b#, 16#6d#, 16#0c#, 16#04#),
     6 => (16#4b#, 16#f3#, 16#b0#, 16#a6#, 16#9a#, 16#eb#, 16#66#, 16#57#,
           16#79#, 16#4f#, 16#29#, 16#01#, 16#b1#, 16#44#, 16#0a#, 16#d4#));

begin
   for I in Keys'Range loop
      Put ("AES256 ECB KAT - iteration" & I'Img & ": ");

      declare
         Key        : constant AES256_Key := Construct (Keys (I));
         Plaintext  : constant Bytes_16 := Plaintexts (I);
         Ciphertext : constant Bytes_16 := Ciphertexts (I);

         Result : Bytes_16;
      begin
         ECB_Encrypt (Result, Plaintext, Key);

         if Equal (Result, Ciphertext) then
            Put ("OK");
         else
            Put ("BAD");
         end if;

         Put (" Encryption | ");

         ECB_Decrypt (Result, Ciphertext, Key);

         if Equal (Result, Plaintext) then
            Put ("OK");
         else
            Put ("BAD");
         end if;

         Put_Line (" Decryption");
      end;
   end loop; 
end AES256_ECB_KAT;
