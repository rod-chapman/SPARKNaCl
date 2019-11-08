package SPARKNaCl.Core
  with SPARK_Mode => On
is

   subtype Salsa20_Key    is Bytes_32;
   --  Should be - pending bug SB07-035
--   type Salsa20_Key is new Bytes_32;
--     with Volatile; -- TBD

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
