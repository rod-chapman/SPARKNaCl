with Interfaces; use Interfaces;
package P
is
   subtype S is Integer_64;

   subtype S2 is Integer_64 range 0 .. 65535;
   subtype S3 is Integer_64 range 0 .. (65535 * 65535);

   function F (X, Y : in S) return S
     with Pure_Function, Global => null;

   function F2 (X, Y : in Unsigned_16) return S3
     with Pure_Function, Global => null;
end P;
