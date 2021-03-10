package SPARKNaCl.Hashing
  with Pure,
       SPARK_Mode => On
is
   subtype Digest is Bytes_64; -- 512 bits

   --  Use IV to initialize a Digest before first call
   --  to Hashblocks
   IV : constant Digest;

   procedure Hashblocks
     (X : in out Digest;
      M : in     Byte_Seq)
     with Global => null;

   --  Procedural interface. Faster assuming Output is passed by reference
   procedure Hash (Output :    out Digest;
                   M      : in     Byte_Seq)
     with Global => null;

   --  Functional interface
   function Hash (M : in Byte_Seq) return Digest
     with Global => null;

private
   IV : constant Digest :=
     (16#6a#, 16#09#, 16#e6#, 16#67#, 16#f3#, 16#bc#, 16#c9#, 16#08#,
      16#bb#, 16#67#, 16#ae#, 16#85#, 16#84#, 16#ca#, 16#a7#, 16#3b#,
      16#3c#, 16#6e#, 16#f3#, 16#72#, 16#fe#, 16#94#, 16#f8#, 16#2b#,
      16#a5#, 16#4f#, 16#f5#, 16#3a#, 16#5f#, 16#1d#, 16#36#, 16#f1#,
      16#51#, 16#0e#, 16#52#, 16#7f#, 16#ad#, 16#e6#, 16#82#, 16#d1#,
      16#9b#, 16#05#, 16#68#, 16#8c#, 16#2b#, 16#3e#, 16#6c#, 16#1f#,
      16#1f#, 16#83#, 16#d9#, 16#ab#, 16#fb#, 16#41#, 16#bd#, 16#6b#,
      16#5b#, 16#e0#, 16#cd#, 16#19#, 16#13#, 16#7e#, 16#21#, 16#79#);
end SPARKNaCl.Hashing;
