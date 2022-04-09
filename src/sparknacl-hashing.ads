package SPARKNaCl.Hashing
  with Pure,
       SPARK_Mode => On
is
   subtype Digest_256 is Bytes_32;
   subtype Digest_512 is Bytes_64;

   subtype Digest is Digest_512; -- Default

   --  Use IV to initialize a Digest before first call
   --  to Hashblocks
   IV_512 : constant Digest_512;
   IV_256 : constant Digest_256;

   procedure Hashblocks_256
     (X : in out Digest_256;
      M : in     Byte_Seq)
     with Global => null;

   procedure Hashblocks_512
     (X : in out Digest_512;
      M : in     Byte_Seq)
     with Global => null;

   --------------------------------------------------------
   --  Procedural interface. Faster assuming Output is passed by reference
   --------------------------------------------------------

   procedure Hash_512 (Output :    out Digest_512;
                       M      : in     Byte_Seq)
     with Global => null;

   procedure Hash_256 (Output :    out Digest_256;
                       M      : in     Byte_Seq)
     with Global => null;

   procedure Hash (Output :    out Digest_512;
                   M      : in     Byte_Seq)
     with Global => null;

   --------------------------------------------------------
   --  Functional interfaces
   --------------------------------------------------------

   function Hash_512 (M : in Byte_Seq) return Digest_512
     with Global => null;

   function Hash_256 (M : in Byte_Seq) return Digest_256
     with Global => null;

   --  Defaults to Hash_512 for compatibility w/ TweetNaCl
   function Hash (M : in Byte_Seq) return Digest_512
     with Global => null;

private
   IV_512 : constant Digest_512 :=
     (16#6a#, 16#09#, 16#e6#, 16#67#, 16#f3#, 16#bc#, 16#c9#, 16#08#,
      16#bb#, 16#67#, 16#ae#, 16#85#, 16#84#, 16#ca#, 16#a7#, 16#3b#,
      16#3c#, 16#6e#, 16#f3#, 16#72#, 16#fe#, 16#94#, 16#f8#, 16#2b#,
      16#a5#, 16#4f#, 16#f5#, 16#3a#, 16#5f#, 16#1d#, 16#36#, 16#f1#,
      16#51#, 16#0e#, 16#52#, 16#7f#, 16#ad#, 16#e6#, 16#82#, 16#d1#,
      16#9b#, 16#05#, 16#68#, 16#8c#, 16#2b#, 16#3e#, 16#6c#, 16#1f#,
      16#1f#, 16#83#, 16#d9#, 16#ab#, 16#fb#, 16#41#, 16#bd#, 16#6b#,
      16#5b#, 16#e0#, 16#cd#, 16#19#, 16#13#, 16#7e#, 16#21#, 16#79#);

   IV_256 : constant Digest_256 :=
     (16#6a#, 16#09#, 16#e6#, 16#67#,
      16#bb#, 16#67#, 16#ae#, 16#85#,
      16#3c#, 16#6e#, 16#f3#, 16#72#,
      16#a5#, 16#4f#, 16#f5#, 16#3a#,
      16#51#, 16#0e#, 16#52#, 16#7f#,
      16#9b#, 16#05#, 16#68#, 16#8c#,
      16#1f#, 16#83#, 16#d9#, 16#ab#,
      16#5b#, 16#e0#, 16#cd#, 16#19#);
end SPARKNaCl.Hashing;
