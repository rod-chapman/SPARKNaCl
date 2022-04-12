with SPARKNaCl.MAC;

package body SPARKNaCl.HKDF
  with SPARK_Mode => On
is

   --------------------------------------------------------
   --  SHA-256 HKDF-Extract per RFC 5869
   --------------------------------------------------------

   procedure Extract (PRK  :    out Hashing.Digest_256; -- output key
                      IKM  : in     Byte_Seq; -- input keying material
                      Salt : in     Byte_Seq) -- input salt (can be 0 bytes)
   is
   begin
      MAC.HMAC_SHA_256 (PRK, IKM, Salt);
   end Extract;

   --------------------------------------------------------
   --  SHA-256 HKDF-Expand per RFC 5869
   --------------------------------------------------------

   procedure Expand (OKM  :    out OKM_256;   -- output key material
                     PRK  : in     Hashing.Digest_256; -- pseudo-random key
                     Info : in     Byte_Seq)   -- optional context
   is
      type T_Arr is array (N32 range 1 .. (OKM'Length + 31) / 32) of Bytes_32;

      T : T_Arr with Relaxed_Initialization;
   begin
      pragma Assert (OKM'Last <= T'Last * 32);

      MAC.HMAC_SHA_256 (T (1), Info & 1, PRK);

      for I in 2 .. T_Arr'Last loop
         pragma Loop_Invariant (T (1 .. I - 1)'Initialized);
         MAC.HMAC_SHA_256 (T (I), T (I - 1) & Info & Byte (I), PRK);
         pragma Assert (T (I)'Initialized);
      end loop;

      pragma Assert (T'Initialized);

      for J in OKM'Range loop
         OKM (J) := T ((J / 32) + 1) (J mod 32);
      end loop;

   end Expand;

   procedure KDF (OKM  :    out OKM_256;
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
