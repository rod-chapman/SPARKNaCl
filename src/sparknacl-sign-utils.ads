package SPARKNaCl.Sign.Utils
  with Pure,
       SPARK_Mode => On
is
   procedure Construct (X : in     Bytes_64;
                        Y :    out Signing_SK);

end SPARKNaCl.Sign.Utils;
