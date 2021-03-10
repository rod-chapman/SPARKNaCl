package SPARKNaCl.Scalar
  with Pure,
       SPARK_Mode => On
is
   --------------------------------------------------------
   --  Scalar multiplication
   --------------------------------------------------------

   function Mult (N : in Bytes_32;
                  P : in Bytes_32) return Bytes_32
     with Global => null,
          Pure_Function;

   function Mult_Base (N : in Bytes_32) return Bytes_32
     with Global => null,
          Pure_Function;

end SPARKNaCl.Scalar;
