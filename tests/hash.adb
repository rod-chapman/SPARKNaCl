with SPARKNaCl;         use SPARKNaCl;
with SPARKNaCl.Debug;   use SPARKNaCl.Debug;
with SPARKNaCl.Hashing; use SPARKNaCl.Hashing;
with Interfaces;        use Interfaces;
procedure Hash
is
   R1 : Bytes_64;

   --  Case 1: same as NaCl standard test suite
   M3 : constant String (1 .. 8) := "testing" & ASCII.LF;
   M4 : Byte_Seq (0 .. 7);

   --  Case 2: two blocks, with final block >= 112 bytes to cover
   --  final block padding
   M5 : constant Byte_Seq (0 .. 240) := (16#AA#, others => 0);
begin
   for I in M4'Range loop
      M4 (I) := Character'Pos (M3 (Integer (I + 1)));
   end loop;

   Hash (R1, M4);
   DH ("Hash is", R1);

   --  Functional style interface
   R1 := Hash (M5);
   DH ("Hash is", R1);
end Hash;
