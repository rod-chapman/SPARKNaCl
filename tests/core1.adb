with SPARKNaCl;       use SPARKNaCl;
with SPARKNaCl.Core;  use SPARKNaCl.Core;
with SPARKNaCl.Debug; use SPARKNaCl.Debug;
with Random;

with Ada.Text_IO; use Ada.Text_IO;
procedure Core1
is
   Shared : constant Salsa20_Key :=
     Construct ((16#4a#, 16#5d#, 16#9d#, 16#5b#,
                 16#a4#, 16#ce#, 16#2d#, 16#e1#,
                 16#72#, 16#8e#, 16#3b#, 16#f4#,
                 16#80#, 16#35#, 16#0f#, 16#25#,
                 16#e0#, 16#7e#, 16#21#, 16#c9#,
                 16#47#, 16#d1#, 16#9e#, 16#33#,
                 16#76#, 16#f0#, 16#9b#, 16#3c#,
                 16#1e#, 16#16#, 16#17#, 16#42#));

   Zero : constant Bytes_16 := (others => 0);

   C : constant Bytes_16 :=
     (16#65#, 16#78#, 16#70#, 16#61#, 16#6e#, 16#64#, 16#20#, 16#33#,
      16#32#, 16#2d#, 16#62#, 16#79#, 16#74#, 16#65#, 16#20#, 16#6b#);

   FirstKey : Bytes_32;

   RawKey1 : Bytes_32;
   RawKey2 : Bytes_32;
begin
   HSalsa20 (FirstKey, Zero, Shared, C);
   DH ("FirstKey is", FirstKey);

   Random.Random_Bytes (RawKey1);
   Random.Random_Bytes (RawKey2);
   declare
      K1 : Salsa20_Key := Construct (RawKey1);
      K2 : Salsa20_Key := Construct (RawKey2);
   begin
      if Equal (Serialize (K1), Serialize (K2)) then
         Put_Line ("K1 equals K2 - Test Failed.");
      else
         Put_Line ("K1 /= K2 - OK.");
      end if;
      Sanitize (K1);
      Sanitize (K2);
      pragma Unreferenced (K1);
      pragma Unreferenced (K2);
   end;
end Core1;
