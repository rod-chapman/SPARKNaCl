with SPARKNaCl.Hashing;
package SPARKNaCl.HKDF
  with Pure,
       SPARK_Mode => On
is
   --------------------------------------------------------
   --  Hash-based Key Derivation using SHA-256
   --------------------------------------------------------

   --  Output Key Material
   subtype OKM_Index_256 is N32 range 0 .. 32 * 255 - 1;
   type OKM_256 is array (OKM_Index_256 range <>) of Byte;

   procedure Extract (PRK  :    out Hashing.Digest_256;
                      IKM  : in     Byte_Seq;
                      Salt : in     Byte_Seq)
     with Global => null,
          Pre    => PRK'First = 0 and
                    IKM'First = 0 and
                    IKM'Length > 0 and
                    IKM'Length < U32 (N32'Last - 64) and
                    (if Salt'Length > 0 then Salt'First = 0);

   procedure Expand (OKM  :    out OKM_256;
                     PRK  : in     Hashing.Digest_256;
                     Info : in     Byte_Seq)
     with Global => null,
          Pre    => OKM'First   = 0 and
                    OKM'Length  > 0 and
                    OKM'Length  <= 255 * 32 and  -- per RFC 5869
                    PRK'First   = 0 and
                    (if Info'Length > 0 then Info'First = 0) and
                    Info'Length < U32 (N32'Last) - 97;

   procedure KDF (OKM  :    out OKM_256;
                  IKM  : in     Byte_Seq;
                  Salt : in     Byte_Seq;
                  Info : in     Byte_Seq)
     with Global => null,
          Pre    => OKM'First   = 0 and
                    OKM'Length  >= 1 and
                    OKM'Length  <= 255 * 32 and  -- per RFC 5869
                    IKM'First   = 0 and
                    IKM'Length  > 0 and
                    IKM'Length  < U32 (N32'Last - 64) and
                    Salt'First  = 0 and
                    Salt'Length > 0 and
                    Info'First  = 0 and
                    Info'Length < U32 (N32'Last - 97);

end SPARKNaCl.HKDF;
