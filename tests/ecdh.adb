with SPARKNaCl;        use SPARKNaCl;
with SPARKNaCl.Debug;  use SPARKNaCl.Debug;
with SPARKNaCl.Scalar; use SPARKNaCl.Scalar;

with Ada.Text_IO; use Ada.Text_IO;

with Interfaces;
use type Interfaces.Unsigned_8;

procedure ECDH
is
   AliceSK : Bytes_32 :=
     (16#77#, 16#07#, 16#6d#, 16#0a#, 16#73#, 16#18#, 16#a5#, 16#7d#,
      16#3c#, 16#16#, 16#c1#, 16#72#, 16#51#, 16#b2#, 16#66#, 16#45#,
      16#df#, 16#4c#, 16#2f#, 16#87#, 16#eb#, 16#c0#, 16#99#, 16#2a#,
      16#b1#, 16#77#, 16#fb#, 16#a5#, 16#1d#, 16#b9#, 16#2c#, 16#2a#);
   AlicePK : Bytes_32;

   BobSK : Bytes_32 :=
     (16#b1#, 16#77#, 16#fb#, 16#a5#, 16#1d#, 16#b9#, 16#2c#, 16#2a#,
      16#df#, 16#4c#, 16#2f#, 16#87#, 16#eb#, 16#c0#, 16#99#, 16#2a#,
      16#3c#, 16#16#, 16#c1#, 16#72#, 16#51#, 16#b2#, 16#66#, 16#45#,
      16#77#, 16#07#, 16#6d#, 16#0a#, 16#73#, 16#18#, 16#a5#, 16#7d#);
   BobPK : Bytes_32;

   S1, S2 : Bytes_32;

begin
   AlicePK := Mult_Base (AliceSK);
   BobPK   := Mult_Base (BobSK);

   DH ("AlicePK is", AlicePK);
   DH ("BobPK   is", BobPK);

   S1 := Mult (AliceSK, BobPK);
   DH ("S1 is", S1);

   S2 := Mult (BobSK, AlicePK);
   DH ("S2 is", S2);

   if S1 = S2 then
      Put_Line ("Pass");
   else
      Put_Line ("Fail");
   end if;
end ECDH;
