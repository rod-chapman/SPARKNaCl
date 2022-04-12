with SPARKNaCl.MAC;

package body SPARKNaCl.HKDF
  with SPARK_Mode => On
is

   procedure Extract (PRK  :    out Bytes_32; -- output pseudo-random key
                      Salt : in     Byte_Seq; -- input salt (can be 0 bytes)
                      IKM  : in     Byte_Seq) -- input keying material
   is
   begin
      MAC.HMAC_SHA_256 (PRK, IKM, Salt);
   end Extract;

   procedure Expand (OKM  :    out Byte_Seq; -- output key material
                     PRK  : in     Bytes_32; -- pseudo-random key
                     Info : in     Byte_Seq) -- optional context
   is

      function Ceil (A, B : N32) return N32
        with Global => null,
             Pre    => B /= 0;

      function Ceil (A, B : N32) return N32 is
      begin
         return (A + (B - 1)) / B;
      end Ceil;

      --  Number of 32-byte output hashes to calculate
      N : constant N32 := Ceil (N32 (OKM'Length), 32);

      type T_Arr is array (N32 range 1 .. N) of Bytes_32;

      T : T_Arr;
   begin

      MAC.HMAC_SHA_256 (T (1), Info & 1, PRK);

      for I in 2 .. N loop
         MAC.HMAC_SHA_256 (T (I), T (I - 1) & Info & Byte (I), PRK);
      end loop;

      for J in OKM'Range loop
         OKM (J) := T ((J / 32) + 1) (J mod 32);
      end loop;

   end Expand;

   procedure KDF (OKM  :    out Byte_Seq;
                  IKM  : in     Byte_Seq;
                  Salt : in     Byte_Seq;
                  Info : in     Byte_Seq)
   is
      PRK : Bytes_32;
   begin
      Extract (PRK, Salt, IKM);
      Expand (OKM, PRK, Info);
   end KDF;

end SPARKNaCl.HKDF;