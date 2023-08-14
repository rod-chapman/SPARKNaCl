package SPARKNaCl.AES
  with Pure,
       SPARK_Mode => On
is
   --------------------------------------------------------
   --  AES Type definition(s)
   --------------------------------------------------------

   type AES256_Key        is limited private;
   type AES128_Key        is limited private;

   type AES256_Round_Keys is limited private;
   type AES128_Round_Keys is limited private;

   --------------------------------------------------------
   --  AES Key utility function(s)
   --------------------------------------------------------

   function Construct (Raw_Key : in Bytes_32) return AES256_Key
     with Global => null;

   function Construct (Raw_Key : in Bytes_16) return AES128_Key
     with Global => null;

   procedure Construct (Key     :    out AES256_Key;
                        Raw_Key : in     Bytes_32)
     with Global => null;

   procedure Construct (Key     :    out AES128_Key;
                        Raw_Key : in     Bytes_16)
     with Global => null;

   function Serialize (Key : in AES256_Key) return Bytes_32
     with Global => null;

   function Serialize (Key : in AES128_Key) return Bytes_16
     with Global => null;

   procedure Sanitize (Key : out AES256_Key)
      with Global => null;

   procedure Sanitize (Key : out AES128_Key)
      with Global => null;

   procedure Sanitize (Round_Keys : out AES256_Round_Keys)
      with Global => null;

   procedure Sanitize (Round_Keys : out AES128_Round_Keys)
      with Global => null;

   --------------------------------------------------------
   --  AES256 Core function(s)
   --------------------------------------------------------

   function Key_Expansion (Key : in AES256_Key) return AES256_Round_Keys
     with Global => null;

   function Key_Expansion (Key : in AES128_Key) return AES128_Round_Keys
     with Global => null;

   procedure Cipher (Output     :    out Bytes_16;
                     Input      : in     Bytes_16;
                     Round_Keys : in     AES256_Round_Keys)
     with Global => null;

   procedure Cipher (Output     :    out Bytes_16;
                     Input      : in     Bytes_16;
                     Round_Keys : in     AES128_Round_Keys)
     with Global => null;

   procedure Inv_Cipher (Output     :    out Bytes_16;
                         Input      : in     Bytes_16;
                         Round_Keys : in     AES256_Round_Keys)
     with Global => null;

   procedure Inv_Cipher (Output     :    out Bytes_16;
                         Input      : in     Bytes_16;
                         Round_Keys : in     AES128_Round_Keys)
     with Global => null;

private
   --------------------------------------------------------
   --  Constant definition(s)
   --------------------------------------------------------

   AES256_Number_Of_Rounds : constant I32 := 14;
   AES128_Number_Of_Rounds : constant I32 := 10;

   AES256_Words_Per_Key    : constant I32 := 8;
   AES128_Words_Per_Key    : constant I32 := 4;

   --------------------------------------------------------
   --  Type definition(s)
   --------------------------------------------------------

   subtype AES256_Key_Array is U32_Seq (Index_8);
   subtype AES128_Key_Array is U32_Seq (Index_4);

   pragma Assert (AES256_Key_Array'Length = AES256_Words_Per_Key);
   pragma Assert (AES128_Key_Array'Length = AES128_Words_Per_Key);

   type AES256_Key is limited record
      F : AES256_Key_Array;
   end record;

   type AES128_Key is limited record
      F : AES128_Key_Array;
   end record;

   subtype Round_Key is U32_Seq (Index_4);

   subtype AES256_Round_Key_Index is I32 range 0 .. AES256_Number_Of_Rounds;
   subtype AES128_Round_Key_Index is I32 range 0 .. AES128_Number_Of_Rounds;

   type AES256_Round_Key_Array is array (AES256_Round_Key_Index) of Round_Key;
   type AES128_Round_Key_Array is array (AES128_Round_Key_Index) of Round_Key;

   pragma Assert (AES256_Round_Key_Array'Length = AES256_Number_Of_Rounds + 1);
   pragma Assert (AES128_Round_Key_Array'Length = AES128_Number_Of_Rounds + 1);

   type AES256_Round_Keys is limited record
      F : AES256_Round_Key_Array;
   end record;

   type AES128_Round_Keys is limited record
      F : AES128_Round_Key_Array;
   end record;

end SPARKNaCl.AES;
