with SPARKNaCl.Hashing.SHA2_Common; use SPARKNaCl.Hashing.SHA2_Common;

package body SPARKNaCl.Hashing.SHA512
  with SPARK_Mode => On
is
   pragma Warnings (GNATProve, Off, "pragma * ignored (not yet supported)");

   IV_512 : constant Bytes_64 :=
     (16#6a#, 16#09#, 16#e6#, 16#67#, 16#f3#, 16#bc#, 16#c9#, 16#08#,
      16#bb#, 16#67#, 16#ae#, 16#85#, 16#84#, 16#ca#, 16#a7#, 16#3b#,
      16#3c#, 16#6e#, 16#f3#, 16#72#, 16#fe#, 16#94#, 16#f8#, 16#2b#,
      16#a5#, 16#4f#, 16#f5#, 16#3a#, 16#5f#, 16#1d#, 16#36#, 16#f1#,
      16#51#, 16#0e#, 16#52#, 16#7f#, 16#ad#, 16#e6#, 16#82#, 16#d1#,
      16#9b#, 16#05#, 16#68#, 16#8c#, 16#2b#, 16#3e#, 16#6c#, 16#1f#,
      16#1f#, 16#83#, 16#d9#, 16#ab#, 16#fb#, 16#41#, 16#bd#, 16#6b#,
      16#5b#, 16#e0#, 16#cd#, 16#19#, 16#13#, 16#7e#, 16#21#, 16#79#);

   --------------------------------------------------------
   --  Local subprogram declarations
   --------------------------------------------------------

   procedure Hash_512 (Output :    out Digest;
                       M      : in     Byte_Seq)
     with Global => null;

   --------------------------------------------------------
   --  Local subprogram bodies
   --------------------------------------------------------

   procedure Hash_512 (Output :    out Digest;
                       M      : in     Byte_Seq)
   is
      H : Bytes_64;
   begin
      Hash_512_Core (H, IV_512, M);
      Output := H;
   end Hash_512;

   procedure Hash (Output :    out Digest;
                   M      : in     Byte_Seq)
   is
   begin
      Hash_512 (Output, M);
   end Hash;

   function Hash (M : in Byte_Seq) return Digest
   is
      R : Digest;
   begin
      Hash_512 (R, M);
      return R;
   end Hash;

end SPARKNaCl.Hashing.SHA512;
