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
      N  : constant N32 := (OKM'Length + 31) / 32;
      Ti : Bytes_32;    -- T (I - 1)
      Tj : Bytes_32;    -- T (I)
      OKM_Block : N32 := 0;
      tmp : constant Byte_Seq := Info & Byte (1);
   begin
      MAC.HMAC_SHA_256 (Ti, tmp, PRK);

      for J in Index_32'Range loop
         OKM (J) := Ti (J);

         if J = OKM'Last then
            return;
         end if;
      end loop;


      for I in 2 .. N loop
         MAC.HMAC_SHA_256 (Tj, Ti & Info & Byte (I), PRK);
         OKM_Block := (I - 1) * 32;

         for J in Index_32'Range loop
            OKM (OKM_Block + J) := Tj (J);

            if OKM_Block + J = OKM'Last then
               return;
            end if;
         end loop;

         Ti := Tj;
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
