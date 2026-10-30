with SPARKNaCl.Hashing.SHA512;
package SPARKNaCl.HKDF.SHA512
  with Pure,
       SPARK_Mode => On
is
   --------------------------------------------------------
   --  Hash-based Key Derivation using SHA-512 (RFC 5869).
   --  Same interface as the parent package, which uses
   --  SHA-256, with a 64-byte PRK and up to 255 * 64
   --  bytes of output keying material.
   --------------------------------------------------------
   Hash_Len : constant := 64;

   --  OKM = "Output Key Material"
   subtype OKM_Index is N32 range 0 .. Hash_Len * 255 - 1;
   type OKM_Seq is array (OKM_Index range <>) of Byte;

   procedure Extract (PRK  :    out Hashing.SHA512.Digest;
                      IKM  : in     Byte_Seq;
                      Salt : in     Byte_Seq)
     with Global => null,
          Pre    => PRK'First = 0 and
                    IKM'First = 0 and
                    IKM'Length > 0 and
                    IKM'Length < U32 (N32'Last - 128) and
                    (if Salt'Length > 0 then Salt'First = 0);

   procedure Expand
     (OKM  :    out OKM_Seq;               -- Unconstrained
      PRK  : in     Hashing.SHA512.Digest; -- Pseudo-random key
      Info : in     Byte_Seq)              -- Optional context
     with Global => null,
          Relaxed_Initialization => OKM,
          Pre    => OKM'First   = 0 and
                    OKM'Length  > 0 and
                    OKM'Length  <= 255 * Hash_Len and  -- per RFC 5869
                    PRK'First   = 0 and
                    (if Info'Length > 0 then Info'First = 0) and
                    Info'Length < U32 (N32'Last) - 193,
          Post   => OKM'Initialized;

   procedure KDF (OKM  :    out OKM_Seq; -- Unconstrained
                  IKM  : in     Byte_Seq;
                  Salt : in     Byte_Seq;
                  Info : in     Byte_Seq)
     with Global => null,
          Pre    => OKM'First   = 0 and
                    OKM'Length  >= 1 and
                    OKM'Length  <= 255 * Hash_Len and  -- per RFC 5869
                    IKM'First   = 0 and
                    IKM'Length  > 0 and
                    IKM'Length  < U32 (N32'Last - 128) and
                    Salt'First  = 0 and
                    Salt'Length > 0 and
                    Info'First  = 0 and
                    Info'Length < U32 (N32'Last - 193);

end SPARKNaCl.HKDF.SHA512;
