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

   function Nearlynormal_To_Normal
     (X : in Nearlynormal_GF) return Normal_GF
     with Pure_Function,
          Global => null;

end SPARKNaCl.Car;
