with SPARKNaCl;          use SPARKNaCl;
with SPARKNaCl.Core;     use SPARKNaCl.Core;
with SPARKNaCl.Debug;    use SPARKNaCl.Debug;
with SPARKNaCl.Hashing;  use SPARKNaCl.Hashing;
with Interfaces;         use Interfaces;
procedure Core3
is
   Second_Key : constant Salsa20_Key :=
     Construct ((16#dc#, 16#90#, 16#8d#, 16#da#,
                 16#0b#, 16#93#, 16#44#, 16#a9#,
                 16#53#, 16#62#, 16#9b#, 16#73#,
                 16#38#, 16#20#, 16#77#, 16#88#,
                 16#80#, 16#f3#, 16#ce#, 16#b4#,
                 16#21#, 16#bb#, 16#61#, 16#b9#,
                 16#1c#, 16#bd#, 16#4c#, 16#3e#,
                 16#66#, 16#25#, 16#6c#, 16#e4#));

   Nonce_Suffix : constant Bytes_8 :=
     (16#82#, 16#19#, 16#e0#, 16#03#, 16#6b#, 16#7a#, 16#0b#, 16#37#);

   C : constant Bytes_16 :=
     (16#65#, 16#78#, 16#70#, 16#61#, 16#6e#, 16#64#, 16#20#, 16#33#,
      16#32#, 16#2d#, 16#62#, 16#79#, 16#74#, 16#65#, 16#20#, 16#6b#);

   Input : Bytes_16 := (others => 0);

   Output : Byte_Seq (0 .. (2 ** 22 - 1));
   H : Bytes_64;
   Pos : I32;
begin
   Input (0 .. 7) := Nonce_Suffix;

   Pos := 0;
   loop
      loop
         Salsa20 (Output (Pos .. Pos + 63),
                  Input,
                  Second_Key,
                  C);
         Pos := Pos + 64;
         Input (8) := Input (8) + 1;
         exit when Input (8) = 0;
      end loop;
      Input (9) := Input (9) + 1;
      exit when Input (9) = 0;
   end loop;
   Hash (H, Output);
   DH ("Hash is", H);
end Core3;
