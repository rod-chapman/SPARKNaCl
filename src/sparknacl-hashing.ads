package SPARKNaCl.Hashing
  with Pure,
       SPARK_Mode => On
is

private
   function TS64 (U : in U64) return Bytes_8
     with Global => null;

end SPARKNaCl.Hashing;
