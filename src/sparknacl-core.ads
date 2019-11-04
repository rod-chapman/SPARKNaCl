package SPARKNaCl.Core
  with SPARK_Mode => On
is

   --------------------------------------------------------
   --  Salsa20 Core functions
   --------------------------------------------------------

   procedure Salsa20 (Output :    out Bytes_64;
                      Input  : in     Bytes_16;
                      K      : in     Bytes_32;
                      C      : in     Bytes_16)
     with Global => null;

   procedure HSalsa20 (Output :    out Bytes_32;
                       Input  : in     Bytes_16;
                       K      : in     Bytes_32;
                       C      : in     Bytes_16)
     with Global => null;

end SPARKNaCl.Core;