with Interfaces; use Interfaces;
package Car32
  with SPARK_Mode => On
is
   subtype U32 is Unsigned_32;
   subtype I32 is Integer_32;
   subtype Index_16 is I32 range 0 .. 15;
   type GF is array (Index_16) of I32;

   function C (X : in GF) return GF
     with Global => null,
          Pure_Function;

end Car32;
