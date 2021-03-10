package SPARKNaCl.Core
  with Pure,
       SPARK_Mode => On
is
   --  Limited, so no assignment or comparison, and always
   --  pass-by-reference.
   type Salsa20_Key is limited private;

   function Construct (K : in Bytes_32) return Salsa20_Key
     with Global => null;

   procedure Construct (K :    out Salsa20_Key;
                        X : in     Bytes_32)
     with Global => null;

   function Serialize (K : in Salsa20_Key) return Bytes_32
     with Global => null;

   procedure Sanitize (K : out Salsa20_Key)
     with Global => null;

   --------------------------------------------------------
   --  Salsa20 Core functions
   --------------------------------------------------------

   procedure Salsa20 (Output :    out Bytes_64;
                      Input  : in     Bytes_16;
                      K      : in     Salsa20_Key;
                      C      : in     Bytes_16) --  Counter
     with Global => null;

   procedure HSalsa20 (Output :    out Bytes_32;
                       Input  : in     Bytes_16;
                       K      : in     Salsa20_Key;
                       C      : in     Bytes_16) --  Counter
     with Global => null;

private
   --  Note - also limited here in the full view to ensure
   --  no assignment and pass-by-reference in the body.
   type Salsa20_Key is limited record
      F : Bytes_32;
   end record;

end SPARKNaCl.Core;
