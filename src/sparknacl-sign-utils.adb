package body SPARKNaCl.Sign.Utils
  with SPARK_Mode => On
is
   procedure Construct (X : in     Bytes_64;
                        Y :    out Signing_SK)
   is
   begin
      Y.F := X;
   end Construct;

end SPARKNaCl.Sign.Utils;
