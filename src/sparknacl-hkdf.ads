package SPARKNaCl.HKDF
  with Pure,
       SPARK_Mode => On
is
   --------------------------------------------------------
   --  Hash-based Key Derivation using SHA-256
   --------------------------------------------------------

   procedure Extract (PRK  :    out Byte_Seq;
                      Salt : in     Byte_Seq;
                      IKM  : in     Byte_Seq)
     with Global => null,
          Pre    => PRK'First = 0 and
                    PRK'Length = 32 and
                    IKM'First = 0 and
                    IKM'Length > 0 and
                    Salt'First = 0 and
                    Salt'Length <= U32 (N32'Last - 64);

   procedure Expand (OKM  :    out Byte_Seq;
                     PRK  : in     Byte_Seq;
                     Info : in     Byte_Seq)
     with Global => null,
          Pre    => OKM'First = 0 and
                    PRK'First = 0 and
                    OKM'Length > 0 and
                    OKM'Length < N32'Last and
                    PRK'Length > 0;

   procedure KDF (OKM  :    out Byte_Seq;
                  IKM  : in     Byte_Seq;
                  Salt : in     Byte_Seq;
                  Info : in     Byte_Seq)
     with Global => null,
          Pre    => OKM'First   = 0 and
                    IKM'First   = 0 and
                    Salt'First  = 0 and
                    OKM'Length  > 0 and
                    IKM'Length  > 0 and
                    OKM'Length < N32'Last and
                    Salt'Length > 0;

end SPARKNaCl.HKDF;
