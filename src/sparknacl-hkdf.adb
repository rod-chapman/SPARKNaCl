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

      function Num_Output_Blocks (A : N32) return N32
        with Global => null,
             Pre    => A <= 255 * 32 and
                       A >= 1,
             Post   => Num_Output_Blocks'Result >= 1 and
                       Num_Output_Blocks'Result <= 255;

      function Num_Output_Blocks (A : N32) return N32 is
      begin
         return (A + 31) / 32;
      end Num_Output_Blocks;

      --  Number of 32-byte output hashes to calculate
      N : constant N32 := Num_Output_Blocks (N32 (OKM'Length));

      type T_Arr is array (N32 range 1 .. N) of Bytes_32;

      T : T_Arr with Relaxed_Initialization;
      Counter : OKM_Index_256 := 0;
   begin
      pragma Assert (N >= 1);

      MAC.HMAC_SHA_256 (T (1), Info & 1, PRK);

      for I in 2 .. N loop
         pragma Loop_Invariant (T (1 .. I - 1)'Initialized);
         MAC.HMAC_SHA_256 (T (I), T (I - 1) & Info & Byte (I), PRK);
         pragma Assert (T (I)'Initialized);
      end loop;

      pragma Assert (T'Initialized);

      --  for J in OKM'Range loop
      --     OKM (J) := T ((J / 32) + 1) (J mod 32);
      --  end loop;
      Outer: for Block in T'Range loop
         for B in Bytes_32'Range loop
            pragma Assert (Counter in OKM'Range);
            OKM (Counter) := T (Block) (B);
            pragma Assert (OKM (OKM'First .. Counter)'Initialized);
            exit Outer when Counter = OKM'Last;
            Counter := Counter + 1;
         end loop;
      end loop Outer;

      pragma Assert (Counter = OKM'Last);
      pragma Assert (OKM'Initialized);
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
