package body P is

   use Interfaces;

   ---------
   -- "*" --
   ---------

   function "*" (Left, Right : in GF) return GF is
      T : GF;
   begin
      T := (others => 0);
      T (0) := Left (0) * Right (0);
      return T;
   end "*";

   --------
   -- N1 --
   --------

   function N1 (X : in GF) return GF is
      T : GF := X;
   begin
      T (0) := T (0) - 1;
      return T;
   end N1;

   --------
   -- N2 --
   --------

   function N2 (X : in GF) return GF is
      T : GF := X;
   begin
      T (0) := T (0) - 2;
      return T;
   end N2;

   --------
   -- N3 --
   --------

   function N3 (X : in GF) return GF is
      T : GF := X;
   begin
      T (0) := T (0) - 3;
      return T;
   end N3;

end P;
