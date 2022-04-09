with SPARKNaCl;        use SPARKNaCl;
with SPARKNaCl.Core;   use SPARKNaCl.Core;
with SPARKNaCl.Debug;  use SPARKNaCl.Debug;
with SPARKNaCl.Stream; use SPARKNaCl.Stream;
procedure Stream6
is
   --  Example and Test Vector from RFC 8439 A.1 Test Vector #1

   Firstkey : constant ChaCha20_Key :=
     Construct (Bytes_32'(others => 0));

   Secondkey : constant ChaCha20_Key :=
     Construct (Bytes_32'(31 => 1, others => 0));

   Thirdkey : constant ChaCha20_Key :=
     Construct (Bytes_32'(1 => 16#FF#, others => 0));

   Nonce : constant ChaCha20_IETF_Nonce :=
     (others => 0);

   Nonce2 : constant ChaCha20_IETF_Nonce :=
     (11 => 2, others => 0);

   C : Byte_Seq (0 .. 63);
begin
   -- Test Vector #1
   ChaCha20_IETF (C, Nonce, Firstkey, 0);
   DH ("Test Vector #1 Keystream. See RFC 8539 section A.1", C);

   -- Test Vector #2
   ChaCha20_IETF (C, Nonce, Firstkey, 1);
   DH ("Test Vector #2 Keystream. See RFC 8539 section A.1", C);

   -- Test Vector #3
   ChaCha20_IETF (C, Nonce, Secondkey, 1);
   DH ("Test Vector #3 Keystream. See RFC 8539 section A.1", C);

   -- Test Vector #4
   ChaCha20_IETF (C, Nonce, Thirdkey, 2);
   DH ("Test Vector #4 Keystream. See RFC 8539 section A.1", C);

   -- Test Vector #5
   ChaCha20_IETF (C, Nonce2, Firstkey, 0);
   DH ("Test Vector #5 Keystream. See RFC 8539 section A.1", C);

end Stream6;
