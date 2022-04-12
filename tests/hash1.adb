with SPARKNaCl;         use SPARKNaCl;
with SPARKNaCl.Debug;   use SPARKNaCl.Debug;
with SPARKNaCl.Hashing; use SPARKNaCl.Hashing;
with Interfaces;        use Interfaces;
procedure Hash1
is
   R1 : Digest_256;

   --  FIPS 180-2 SHA-256 test cases

   --  Case 1: One-block message
   M1 : constant String := "abc";

   --  Case 2: Multi-block message (448-bits)
   M2 : constant String :=
      "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq";

   --  Case 3: Long message
   M3 : constant String (1 .. 1_000_000) := (others => 'a');
begin
   Hash_256 (R1, To_Byte_Seq (M1));
   DH ("FIPS 180-2 B.1 procedural API - Hash is", R1);

   --  Functional style interface
   R1 := Hash_256 (To_Byte_Seq (M1));
   DH ("FIPS 180-2 B.1 functional API - Hash is", R1);

   Hash_256 (R1, To_Byte_Seq (M2));
   DH ("FIPS 180-2 B.2 procedural API - Hash is", R1);

   Hash_256 (R1, To_Byte_Seq (M3));
   DH ("FIPS 180-2 B.3 procedural API - Hash is", R1);
end Hash1;
