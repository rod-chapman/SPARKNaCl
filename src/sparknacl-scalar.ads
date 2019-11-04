package SPARKNaCl.Scalar
  with SPARK_Mode => On
is
   --------------------------------------------------------
   --  Scalar multiplication
   --------------------------------------------------------

   procedure Mult (Q :    out Bytes_32;
                   N : in     Bytes_32;
                   P : in     Bytes_32)
     with Global => null;

   procedure Mult_Base (Q :    out Bytes_32;
                        N : in     Bytes_32)
     with Global => null;

end SPARKNaCl.Scalar;
