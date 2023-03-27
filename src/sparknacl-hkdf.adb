with SPARKNaCl.MAC;
package body SPARKNaCl.HKDF
  with SPARK_Mode => On
is

   --------------------------------------------------------
   --  SHA-256 HKDF-Extract per RFC 5869
   --------------------------------------------------------

   procedure Extract (PRK  :    out Hashing.SHA256.Digest; -- output key
                      IKM  : in     Byte_Seq; -- input keying material
                      Salt : in     Byte_Seq) -- input salt (can be 0 bytes)
   is
   begin
      --  In RFC 5869, the input keying material is used
      --  as the _message_ parameter to HMAC.
      MAC.HMAC_SHA_256 (PRK, IKM, Salt);
   end Extract;

   --------------------------------------------------------
   --  SHA-256 HKDF-Expand per RFC 5869
   --------------------------------------------------------

   procedure Expand
     (OKM  :    out OKM_Seq;
      PRK  : in     Hashing.SHA256.Digest;
      Info : in     Byte_Seq)
   is
      Ti : Bytes_32;
      B  : Byte := 1;   -- Output block counter
   begin
      MAC.HMAC_SHA_256 (Ti, Info & B, PRK);

      if OKM'Last <= Ti'Last then
         --  Only need first block Ti to complete OKM
         OKM := OKM_Seq (Ti (OKM'Range)); -- Slice and Slide
      else
         --  OKM larger than hash len, fill the first hash len bytes of OKM
         OKM (Ti'Range) := OKM_Seq (Ti);
         pragma Assert (OKM (Ti'Range)'Initialized);

         for I in Hash_Len .. OKM'Last loop
            if I mod Hash_Len = 0 then
               --  generate new output block
               B := B + 1;
               MAC.HMAC_SHA_256 (Ti, Ti & Info & B, PRK);
            end if;

            OKM (I) := Ti (I mod Hash_Len);
            pragma Loop_Invariant (OKM (0 .. I)'Initialized);
         end loop;
      end if;
   end Expand;

   procedure KDF (OKM  :    out OKM_Seq;
                  IKM  : in     Byte_Seq;
                  Salt : in     Byte_Seq;
                  Info : in     Byte_Seq)
   is
      PRK : Bytes_32;
   begin
      Extract (PRK, IKM, Salt);
      Expand (OKM, PRK, Info);
   end KDF;

end SPARKNaCl.HKDF;
