package SPARKNaCl.Core
  with SPARK_Mode => On
is

   type Salsa20_Key is new Bytes_32;

   --------------------------------------------------------
   --  Salsa20 Core functions
   --------------------------------------------------------

   procedure Salsa20 (Output :    out Bytes_64;
                      Input  : in     Bytes_16; --  ??
                      K      : in     Salsa20_Key; --  Key
                      C      : in     Bytes_16) --  Counter
     with Global => null;

   procedure HSalsa20 (Output :    out Bytes_32;
                       Input  : in     Bytes_16; --  ??
                       K      : in     Salsa20_Key; --  Key
                       C      : in     Bytes_16) --  Counter
     with Global => null;

end SPARKNaCl.Core;
