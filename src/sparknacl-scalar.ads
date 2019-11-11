package SPARKNaCl.Scalar
  with SPARK_Mode => On
is
   --------------------------------------------------------
   --  Scalar multiplication
   --------------------------------------------------------

   function Mult (N : in Bytes_32;
                  P : in Bytes_32) return Bytes_32
     with Global => null;

   function Mult_Base (N : in Bytes_32) return Bytes_32
     with Global => null;

end SPARKNaCl.Scalar;
