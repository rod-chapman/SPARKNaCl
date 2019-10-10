with Interfaces; use Interfaces;
package SPARKNaCl_Types
  with SPARK_Mode => On
is
   subtype Byte is Unsigned_8;

   subtype I32 is Integer_32;
   subtype N32 is I32 range 0 .. I32'Last;

   subtype I64 is Integer_64;
   subtype U32 is Unsigned_32;
   subtype U64 is Unsigned_64;

   type U32_Seq  is array (N32 range <>) of U32;
   type U64_Seq  is array (N32 range <>) of U64;
   type I64_Seq  is array (N32 range <>) of I64;
   type Byte_Seq is array (N32 range <>) of Byte;

   subtype Index_8  is I32 range 0 .. 7;
   subtype Index_16 is I32 range 0 .. 15;
   subtype Index_24 is I32 range 0 .. 23;
   subtype Index_32 is I32 range 0 .. 31;
   subtype Index_64 is I32 range 0 .. 63;
   subtype Index_256 is I32 range 0 .. 255;

   subtype Bytes_8  is Byte_Seq (Index_8);
   subtype Bytes_16 is Byte_Seq (Index_16);
   subtype Bytes_24 is Byte_Seq (Index_24);
   subtype Bytes_32 is Byte_Seq (Index_32);
   subtype Bytes_64 is Byte_Seq (Index_64);
   subtype Bytes_256 is Byte_Seq (Index_256);

   subtype I64_Seq_64 is I64_Seq (Index_64);

   subtype GF         is I64_Seq (Index_16);

   Zero_Bytes_16 : constant Bytes_16 := (others => 0);
   Zero_Bytes_32 : constant Bytes_32 := (others => 0);

   --   0 == "strings are equal" or "verified OK"
   --  -1 == "strings are not equal" or "verification failed"
   subtype Verify_Result is I32 range -1 .. 0;

end SPARKNaCl_Types;
