with SPARKNaCl;         use SPARKNaCl;
with SPARKNaCl.Debug;   use SPARKNaCl.Debug;
with SPARKNaCl.Hashing; use SPARKNaCl.Hashing;
with Interfaces;        use Interfaces;
procedure Hash
is
   R1 : Digest;

   --  Case 1: same as NaCl standard test suite
   M3 : constant String (1 .. 8) := "testing" & ASCII.LF;

   --  Case 2: two blocks, with final block >= 112 bytes to cover
   --  final block padding
   M5 : constant Byte_Seq (0 .. 240) := (16#AA#, others => 0);


   --  FIPS 180-2 Appendix C. SHA-512 test cases

   --  C.1 One-block message
   C1 : constant String := "abc";

   --  C.2 Multi-block message
   C2 : constant String := "abcdefghbcdefghicdefghijdefghijkefghijklfghijklmghijklmnhijklmnoijklmnopjklmnopqklmnopqrlmnopqrsmnopqrstnopqrstu";

   --  C.3 Long message
   C3 : constant String (1 .. 1_000_000) := (others => 'a');
begin
   Hash (R1, To_Byte_Seq (M3));
   DH ("Case 1 - Hash is", R1);

   --  Functional style interface
   R1 := Hash (M5);
   DH ("Case 2 - Hash is", R1);

   -- 180-2 C.1
   Hash (R1, To_Byte_Seq (C1));
   DH ("FIPS 180-2 C.1 procedural API - Hash is", R1);

   R1 := Hash (To_Byte_Seq (C1));
   DH ("FIPS 180-2 C.1 functional API - Hash is", R1);

   -- 180-2 C.2
   R1 := Hash (To_Byte_Seq (C2));
   DH ("FIPS 180-2 C.2 functional API - Hash is", R1);

   -- 180-2 C.3
   R1 := Hash (To_Byte_Seq (C3));
   DH ("FIPS 180-2 C.3 functional API - Hash is", R1);
end Hash;
