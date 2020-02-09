private package SPARKNaCl.Car
  with SPARK_Mode => On
is
   function Product_To_Seminormal
    (X : in Product_GF)
       return Seminormal_GF
     with Global => null;


   function Seminormal_To_Nearlynormal
     (X : in Seminormal_GF)
       return Nearlynormal_GF
     with Global => null;

   function Sum_To_Nearlynormal
     (X : in Sum_GF)
       return Nearlynormal_GF
     with Global => null;

   function Difference_To_Nearlynormal
     (X : in Difference_GF)
       return Nearlynormal_GF
     with Global => null;


   function Nearlynormal_To_Normal
     (X : in Nearlynormal_GF)
       return Normal_GF
     with Global => null;

end SPARKNaCl.Car;
