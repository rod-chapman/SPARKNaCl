with SPARKNaCl;          use SPARKNaCl;
with SPARKNaCl.Core;     use SPARKNaCl.Core;
with SPARKNaCl.Debug;    use SPARKNaCl.Debug;
with SPARKNaCl.Stream;   use SPARKNaCl.Stream;
with SPARKNaCl.Hashing;  use SPARKNaCl.Hashing;
procedure Stream2
is
   SecondKey : constant Salsa20_Key :=
     Construct ((16#dc#, 16#90#, 16#8d#, 16#da#,
                 16#0b#, 16#93#, 16#44#, 16#a9#,
                 16#53#, 16#62#, 16#9b#, 16#73#,
                 16#38#, 16#20#, 16#77#, 16#88#,
                 16#80#, 16#f3#, 16#ce#, 16#b4#,
                 16#21#, 16#bb#, 16#61#, 16#b9#,
                 16#1c#, 16#bd#, 16#4c#, 16#3e#,
                 16#66#, 16#25#, 16#6c#, 16#e4#));

   NonceSuffix : constant Salsa20_Nonce :=
     (16#82#, 16#19#, 16#e0#, 16#03#, 16#6b#, 16#7a#, 16#0b#, 16#37#);

   Output : Byte_Seq (0 .. 4_194_303);
   H : Bytes_64;
begin
   Salsa20 (Output, NonceSuffix, SecondKey);
   Hash (H, Output);
   DH ("H is", H);
end Stream2;
