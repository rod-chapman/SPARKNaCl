private package SPARKNaCl.Utils2
  with SPARK_Mode => On
is
   function Car_Product_To_Seminormal
     (X : in Unnormalized_GF_Product)
       return Seminormal_Product_GF
     with Global => null;


   function Car_Seminormal_Product_To_Nearlynormal
     (X : in Seminormal_Product_GF)
       return Nearlynormal_GF
     with Global => null;

   function Car_Summation_To_Nearlynormal
     (X : in Summation_GF)
       return Nearlynormal_GF
     with Global => null;

   function Car_Difference_To_Nearlynormal
     (X : in Unnormalized_GF_Difference)
       return Nearlynormal_GF_Difference
     with Global => null;


   function Car_Nearlynormal_To_Normal
     (X : in Nearlynormal_GF)
       return Normal_GF
     with Global => null;

end SPARKNaCl.Utils2;
