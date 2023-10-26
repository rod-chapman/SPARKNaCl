package body SPARKNaCl.Hashing.SHA384
  with SPARK_Mode => On
is

   --  SHA384 is SHA512 internally with a different IV and
   --  truncated output.

   pragma Warnings (GNATProve, Off, "pragma * ignored (not yet supported)");

   IV_384 : constant Bytes_64 :=
     (16#cb#, 16#bb#, 16#9d#, 16#5d#, 16#c1#, 16#05#, 16#9e#, 16#d8#,
      16#62#, 16#9a#, 16#29#, 16#2a#, 16#36#, 16#7c#, 16#d5#, 16#07#,
      16#91#, 16#59#, 16#01#, 16#5a#, 16#30#, 16#70#, 16#dd#, 16#17#,
      16#15#, 16#2f#, 16#ec#, 16#d8#, 16#f7#, 16#0e#, 16#59#, 16#39#,
      16#67#, 16#33#, 16#26#, 16#67#, 16#ff#, 16#c0#, 16#0b#, 16#31#,
      16#8e#, 16#b4#, 16#4a#, 16#87#, 16#68#, 16#58#, 16#15#, 16#11#,
      16#db#, 16#0c#, 16#2e#, 16#0d#, 16#64#, 16#f9#, 16#8f#, 16#a7#,
      16#47#, 16#b5#, 16#48#, 16#1d#, 16#be#, 16#fa#, 16#4f#, 16#a4#);

   --------------------------------------------------------
   --  Local subprogram declarations
   --------------------------------------------------------

   procedure Hash_384 (Output :    out Digest;
                       M      : in     Byte_Seq)
     with Global => null;

   --------------------------------------------------------
   --  Local subprogram bodies
   --------------------------------------------------------

   procedure Hash_384 (Output :    out Digest;
                       M      : in     Byte_Seq)
   is
      H : Bytes_64;
   begin
      Hash_512_Core (H, IV_384, M);
      Output := H (0 .. 47);
   end Hash_384;

   procedure Hash (Output :    out Digest;
                   M      : in     Byte_Seq)
   is
   begin
      Hash_384 (Output, M);
   end Hash;

   function Hash (M : in Byte_Seq) return Digest
   is
      R : Digest;
   begin
      Hash_384 (R, M);
      return R;
   end Hash;

end SPARKNaCl.Hashing.SHA384;
