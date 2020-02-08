private package SPARKNaCl.Car
  with SPARK_Mode => On
is
   function Product_To_Seminormal
     (X : in Unnormalized_GF_Product)
       return Seminormal_Product_GF
     with Global => null;


   function Seminormal_Product_To_Nearlynormal
     (X : in Seminormal_Product_GF)
       return Nearlynormal_GF
     with Global => null;

   function Summation_To_Nearlynormal
     (X : in Summation_GF)
       return Nearlynormal_GF
     with Global => null;

   function Difference_To_Nearlynormal
     (X : in Unnormalized_GF_Difference)
       return Nearlynormal_GF
     with Global => null;


   function Nearlynormal_To_Normal
     (X : in Nearlynormal_GF)
       return Normal_GF
     with Global => null;

end SPARKNaCl.Car;
