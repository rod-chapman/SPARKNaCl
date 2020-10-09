package body SPARKNaCl.Sign.Utils
is
   procedure Construct (X : in     Bytes_64;
                        Y :    out Signing_SK)
   is
   begin
      Y.F := X;
   end Construct;

end SPARKNaCl.Sign.Utils;
