package body P is

   function F (X, Y : in S) return S
   is
      T : S;
   begin
      T := X * Y;
      return T;
   end F;

   function F2 (X, Y : in Unsigned_16) return S3
   is
      T : S3;
   begin
      T := Integer_64 (X) * Integer_64 (Y);
      return T;
   end F2;

end P;
