package body P
is
   function "*" (Left, Right : in GF) return GF
   is
      T : GF := Left;
   begin
      --  Do something simple
      T (0) := T (0) * Right (0);
      return T;
   end "*";


   function Sq (X : in GF) return GF
   is
   begin
      return X * X;
   end Sq;

end P;
