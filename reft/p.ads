with Interfaces; use Interfaces;
package P
is
   subtype I is Integer range 0 .. 15;
   type GF is array (I) of Interfaces.Unsigned_64
     with Dynamic_Predicate => (GF (1) = 255);

   function "*" (Left, Right : in GF) return GF;

   function Sq (X : in GF) return GF;

end P;
