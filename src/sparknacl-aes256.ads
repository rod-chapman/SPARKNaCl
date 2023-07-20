package SPARKNaCl.AES256
  with Pure,
       SPARK_Mode => On
is
   --  Limited, so no assignment or comparison, and always
   --  pass-by-reference.
   type AES256_Key is limited private;

   --------------------------------------------------------
   --  AES256 Key utility functions
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

   --------------------------------------------------------
   --  AES256 Core function
   --------------------------------------------------------

   procedure ECB_Encrypt (Output :    out Bytes_16;
                          Input  : in     Bytes_16;
                          Key    : in     AES256_Key)
     with Global => null;

   procedure ECB_Decrypt (Output :    out Bytes_16;
                          Input  : in     Bytes_16;
                          Key    : in     AES256_Key)
     with Global => null;

private
   subtype AES256_Key_Array is U32_Seq (Index_8);

   type AES256_Key is limited record
      F : AES256_Key_Array;
   end record;
end SPARKNaCl.AES256;
