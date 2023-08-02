with SPARKNaCl;        use SPARKNaCl;
with SPARKNaCl.Debug;  use SPARKNaCl.Debug;
with SPARKNaCl.Scalar; use SPARKNaCl.Scalar;
procedure Scalarmult5
is
   AliceSK : constant Bytes_32 :=
     (16#77#, 16#07#, 16#6d#, 16#0a#, 16#73#, 16#18#, 16#a5#, 16#7d#,
      16#3c#, 16#16#, 16#c1#, 16#72#, 16#51#, 16#b2#, 16#66#, 16#45#,
      16#df#, 16#4c#, 16#2f#, 16#87#, 16#eb#, 16#c0#, 16#99#, 16#2a#,
      16#b1#, 16#77#, 16#fb#, 16#a5#, 16#1d#, 16#b9#, 16#2c#, 16#2a#);


   BobPK : constant Bytes_32 :=
     (16#de#, 16#9e#, 16#db#, 16#7d#, 16#7b#, 16#7d#, 16#c1#, 16#b4#,
      16#d3#, 16#5b#, 16#61#, 16#c2#, 16#ec#, 16#e4#, 16#35#, 16#37#,
      16#3f#, 16#83#, 16#43#, 16#c8#, 16#5b#, 16#78#, 16#67#, 16#4d#,
      16#ad#, 16#fc#, 16#7e#, 16#14#, 16#6f#, 16#88#, 16#2b#, 16#4f#);

   K : Bytes_32;

begin
   K := Mult (AliceSK, BobPK);
   DH ("K is", K);
end Scalarmult5;
