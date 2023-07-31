package SPARKNaCl.AES256
  with Pure,
       SPARK_Mode => On
is
   --------------------------------------------------------
   --  AES256 Type definition(s)
   --------------------------------------------------------

   --  Limited, so no assignment or comparison, and always
   --  pass-by-reference.
   type AES256_Key        is limited private;
   type AES256_Round_Keys is limited private;

   --------------------------------------------------------
   --  AES256 Key utility function(s)
   --------------------------------------------------------

   function Construct (Raw_Key : in Bytes_32) return AES256_Key
     with Global => null;

   procedure Construct (Key     :    out AES256_Key;
                        Raw_Key : in     Bytes_32)
     with Global => null;

   function Serialize (Key : in AES256_Key) return Bytes_32
     with Global => null;

   procedure Sanitize (Key : out AES256_Key)
      with Global => null;

   procedure Sanitize (Round_Keys : out AES256_Round_Keys)
      with Global => null;

   --------------------------------------------------------
   --  AES256 Core function(s)
   --------------------------------------------------------

   function Key_Expansion (Key : in AES256_Key) return AES256_Round_Keys
     with Global => null;

   procedure Cipher (Output     :    out Bytes_16;
                     Input      : in     Bytes_16;
                     Round_Keys : in     AES256_Round_Keys)
     with Global => null;

   procedure Inv_Cipher (Output     :    out Bytes_16;
                         Input      : in     Bytes_16;
                         Round_Keys : in     AES256_Round_Keys)
     with Global => null;

private
   --------------------------------------------------------
   --  Constant definition(s)
   --------------------------------------------------------

   Number_Of_Rounds : constant I32 := 14;
   Words_Per_Key    : constant I32 := 8;

   --------------------------------------------------------
   --  Type definition(s)
   --------------------------------------------------------

   subtype Key_Array is U32_Seq (Index_8);
   pragma Assert (Key_Array'Length = Words_Per_Key);

   type AES256_Key is limited record
      F : Key_Array;
   end record;

   subtype Round_Key       is U32_Seq (Index_4);
   subtype Round_Key_Index is I32 range 0 .. Number_Of_Rounds;
   type Round_Key_Array    is array (Round_Key_Index) of Round_Key;
   pragma Assert (Round_Key_Array'Length = (Number_Of_Rounds + 1));

   type AES256_Round_Keys is limited record
      F : Round_Key_Array;
   end record;

end SPARKNaCl.AES256;
