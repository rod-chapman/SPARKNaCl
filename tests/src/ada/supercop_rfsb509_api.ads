with SPARKNaCl;  use SPARKNaCl;
with Interfaces; use Interfaces;
with Interfaces.C;
package SUPERCOP_RFSB509_API
is
   function SUPERCOP_RFSB509_Hash 
     (Output       :    out Byte_Seq;
      Input        : in     Byte_Seq;
      Input_Length : in     Unsigned_64) return Interfaces.C.Int
     with Import,
          Convention => C,
          Link_Name  => "rfsb509_crypto_hash";

end SUPERCOP_RFSB509_API;
