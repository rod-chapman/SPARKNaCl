with SPARKNaCl;        use SPARKNaCl;
with SPARKNaCl.Debug;  use SPARKNaCl.Debug;
with SPARKNaCl.Scalar; use SPARKNaCl.Scalar;
procedure Scalarmult6
is
   BobSK : constant Bytes_32 :=
     (16#5d#, 16#ab#, 16#08#, 16#7e#, 16#62#, 16#4a#, 16#8a#, 16#4b#,
      16#79#, 16#e1#, 16#7f#, 16#8b#, 16#83#, 16#80#, 16#0e#, 16#e6#,
      16#6f#, 16#3b#, 16#b1#, 16#29#, 16#26#, 16#18#, 16#b6#, 16#fd#,
      16#1c#, 16#2f#, 16#8b#, 16#27#, 16#ff#, 16#88#, 16#e0#, 16#eb#);


   AlicePK : constant Bytes_32 :=
     (16#85#, 16#20#, 16#f0#, 16#09#, 16#89#, 16#30#, 16#a7#, 16#54#,
      16#74#, 16#8b#, 16#7d#, 16#dc#, 16#b4#, 16#3e#, 16#f7#, 16#5a#,
      16#0d#, 16#bf#, 16#3a#, 16#0d#, 16#26#, 16#38#, 16#1a#, 16#f4#,
      16#eb#, 16#a4#, 16#a9#, 16#8e#, 16#aa#, 16#9b#, 16#4e#, 16#6a#);

   K : Bytes_32;
begin
   K := Mult (BobSK, AlicePK);
   DH ("K is", K);
end Scalarmult6;
