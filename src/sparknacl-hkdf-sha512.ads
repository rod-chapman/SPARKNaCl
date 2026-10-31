with SPARKNaCl.Hashing.SHA512;
with SPARKNaCl.MAC;
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
                    (if Salt'Length > 0 then Salt'First = 0),
          Post   => MAC.Same (PRK, MAC.HMAC_SHA_512 (IKM, Salt));

   --  Index N of an output block T (N) of HKDF-Expand
   subtype Block_Index is N32 range 1 .. 255;

   --  The output blocks of HKDF-Expand, RFC 5869 section 2.3:
   --    T (1) = HMAC-Hash (PRK, Info | 0x01)
   --    T (N) = HMAC-Hash (PRK, T (N - 1) | Info | N)
   function T (PRK  : in Hashing.SHA512.Digest;
               Info : in Byte_Seq;
               N    : in Block_Index) return Hashing.SHA512.Digest
   is (if N = 1 then
          MAC.HMAC_SHA_512 (Info & Byte (N), PRK)
       else
          MAC.HMAC_SHA_512 (T (PRK, Info, N - 1) & Info & Byte (N), PRK))
     with Ghost,
          Pre                => (if Info'Length > 0 then Info'First = 0) and
                                Info'Length < U32 (N32'Last) - 193,
          Subprogram_Variant => (Decreases => N);

   --  The functional postconditions of Expand and KDF are proved by
   --  GNATprove but not executed: evaluating T for every byte of OKM
   --  would cost millions of HMAC computations in a build with
   --  assertions enabled (16320 bytes times up to 255 blocks for the
   --  largest permitted output).
   pragma Assertion_Policy (Post => Ignore);

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
          --  OKM = first OKM'Length bytes of T (1) | T (2) | ...
          Post   => OKM'Initialized and then
                    (for all I in OKM'Range =>
                       OKM (I) = T (PRK, Info, I / Hash_Len + 1)
                                   (I mod Hash_Len));

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
                    Info'Length < U32 (N32'Last - 193),
          --  Expand of the PRK from Extract
          Post   => (for all I in OKM'Range =>
                       OKM (I) = T (MAC.HMAC_SHA_512 (IKM, Salt),
                                    Info,
                                    I / Hash_Len + 1)
                                   (I mod Hash_Len));

end SPARKNaCl.HKDF.SHA512;
