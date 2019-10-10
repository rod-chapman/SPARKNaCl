with SPARKNaCl_Types; use SPARKNaCl_Types;
with SPARKNaCl;       use SPARKNaCl;
with SPARKNaCl.Debug; use SPARKNaCl.Debug;
procedure Stream2
is
   SecondKey : constant Bytes_32 :=
     (16#dc#, 16#90#, 16#8d#, 16#da#, 16#0b#, 16#93#, 16#44#, 16#a9#,
      16#53#, 16#62#, 16#9b#, 16#73#, 16#38#, 16#20#, 16#77#, 16#88#,
      16#80#, 16#f3#, 16#ce#, 16#b4#, 16#21#, 16#bb#, 16#61#, 16#b9#,
      16#1c#, 16#bd#, 16#4c#, 16#3e#, 16#66#, 16#25#, 16#6c#, 16#e4#);

   NonceSuffix : constant Bytes_8 :=
     (16#82#, 16#19#, 16#e0#, 16#03#, 16#6b#, 16#7a#, 16#0b#, 16#37#);

   Output : Byte_Seq (0 .. 4_194_303);
   H : Bytes_64;
begin
   Crypto_Stream_Salsa20 (Output, NonceSuffix, SecondKey);
   Crypto_Hash (H, Output);
   DH ("H is", H);
end Stream2;
