with SPARKNaCl;        use SPARKNaCl;
with SPARKNaCl.Core;   use SPARKNaCl.Core;
with SPARKNaCl.Debug;  use SPARKNaCl.Debug;
with SPARKNaCl.Stream; use SPARKNaCl.Stream;
procedure Stream3
is
   Firstkey : constant Salsa20_Key :=
     Construct ((16#1b#, 16#27#, 16#55#, 16#64#,
                 16#73#, 16#e9#, 16#85#, 16#d4#,
                 16#62#, 16#cd#, 16#51#, 16#19#,
                 16#7a#, 16#9a#, 16#46#, 16#c7#,
                 16#60#, 16#09#, 16#54#, 16#9e#,
                 16#ac#, 16#64#, 16#74#, 16#f2#,
                 16#06#, 16#c4#, 16#ee#, 16#08#,
                 16#44#, 16#f6#, 16#83#, 16#89#));

   Nonce : constant HSalsa20_Nonce :=
     (16#69#, 16#69#, 16#6e#, 16#e9#, 16#55#, 16#b6#, 16#2b#, 16#73#,
      16#cd#, 16#62#, 16#bd#, 16#a8#, 16#75#, 16#fc#, 16#73#, 16#d6#,
      16#82#, 16#19#, 16#e0#, 16#03#, 16#6b#, 16#7a#, 16#0b#, 16#37#);

   RS : Bytes_32;
begin
   HSalsa20 (RS, Nonce, Firstkey);
   DH ("RS is", RS);
end Stream3;
