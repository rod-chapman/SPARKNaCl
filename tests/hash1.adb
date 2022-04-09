with SPARKNaCl;         use SPARKNaCl;
with SPARKNaCl.Debug;   use SPARKNaCl.Debug;
with SPARKNaCl.Hashing; use SPARKNaCl.Hashing;
with Interfaces;        use Interfaces;
procedure Hash1
is
   R1 : Bytes_32;

   function To_Byte_Seq (s : String) return Byte_Seq is
      ret : Byte_Seq (N32 (s'First - 1) .. N32 (s'Last - 1));
   begin
      for i in s'Range loop
         ret (N32 (i - 1)) := Character'Pos (s (i));
      end loop;
      return ret;
   end To_Byte_Seq;

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
   DH ("Hash 1 is", R1);

   --  Functional style interface
   R1 := Hash_256 (To_Byte_Seq (M1));
   DH ("Hash 2 is", R1);

   Hash_256 (R1, To_Byte_Seq (M2));
   DH ("Hash 3 is", R1);

   Hash_256 (R1, To_Byte_Seq (M3));
   DH ("Hash 4 is", R1);
end Hash1;