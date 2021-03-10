private package SPARKNaCl.Car
  with Pure,
       SPARK_Mode => On
is
   --==========================================
   --  Functions supporting normalization
   --  of GF values following "+", "-" or "*"
   --  operations.
   --
   --  See the specific subtype declarations
   --  in the private part of the specification
   --  of SPARKNaCl for precise details of the
   --  formal parameter and return value for
   --  each function.
   --==========================================

   --  Supporting "*"
   function Product_To_Seminormal
    (X : in Product_GF)
       return Seminormal_GF
     with Pure_Function,
          Global => null;

   --  Supporting "*"
   function Seminormal_To_Nearlynormal
     (X : in Seminormal_GF)
       return Nearlynormal_GF
     with Pure_Function,
          Global => null;

   --  Supporting "*", "+" and "-"
   function Nearlynormal_To_Normal
     (X : in Nearlynormal_GF)
       return Normal_GF
     with Pure_Function,
          Global => null;

end SPARKNaCl.Car;
