with SPARKNaCl;        use SPARKNaCl;
with SPARKNaCl.Debug;  use SPARKNaCl.Debug;
with SPARKNaCl.Scalar; use SPARKNaCl.Scalar;
procedure Scalarmult2
is
   BobSK : constant Bytes_32 :=
     (16#5d#, 16#ab#, 16#08#, 16#7e#, 16#62#, 16#4a#, 16#8a#, 16#4b#,
      16#79#, 16#e1#, 16#7f#, 16#8b#, 16#83#, 16#80#, 16#0e#, 16#e6#,
      16#6f#, 16#3b#, 16#b1#, 16#29#, 16#26#, 16#18#, 16#b6#, 16#fd#,
      16#1c#, 16#2f#, 16#8b#, 16#27#, 16#ff#, 16#88#, 16#e0#, 16#eb#);
   BobPK : Bytes_32;
begin
   BobPK := Mult_Base (BobSK);
   DH ("BobPK is", BobPK);
end Scalarmult2;
