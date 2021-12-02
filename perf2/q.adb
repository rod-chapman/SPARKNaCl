package body Q
is
   function Op (L, R : in GF) return GF
   is
   begin
      return N1 (N2 (N3 (L * R)));
   end Op;

   function Op2 (X : in GF) return GF
   is
      R : GF := X;
   begin
      return R;
   end Op2;

end Q;
