with Interfaces;
package P
is
   subtype I is Natural range 0 .. 15;
   type GF is array (I) of Interfaces.Integer_64;

   function "*" (Left, Right : in GF) return GF;

   function N1 (X : in GF) return GF;
   function N2 (X : in GF) return GF;
   function N3 (X : in GF) return GF;
end P;
