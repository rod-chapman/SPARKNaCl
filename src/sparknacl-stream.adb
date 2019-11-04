with SPARKNaCl.Core;

package body SPARKNaCl.Stream
is
   --------------------------------------------------------
   --  Local subprogram declarations
   --------------------------------------------------------

   procedure Salsa20_Xor_Local
     (C     :    out Byte_Seq;
      M     : in     Byte_Seq;
      Xor_M : in     Boolean; --  If True then xor M against Stream
                              --  If False then return Stream unmodified
      N     : in     Bytes_8;
      K     : in     Bytes_32)
     with Global => null;

   --------------------------------------------------------
   --  Local subprogram bodies
   --------------------------------------------------------

   --  ???
   procedure Salsa20_Xor_Local
     (C     :    out Byte_Seq;
      M     : in     Byte_Seq;
      Xor_M : in     Boolean; --  If True then xor M against Stream
                              --  If False then return Stream unmodified
      N     : in     Bytes_8;
      K     : in     Bytes_32)
   is
      Z : Bytes_16;
      X : Bytes_64;
      U : U32;
      B : I32;
      C_Offset : I32;
      M_Offset : I32;
   begin
      B := C'Length; --  PRange?
      C := (others => 0);
      if B = 0 then
         return;
      end if;

      C_Offset := 0;
      M_Offset := 0;
      Z := (others => 0);
      Z (0 .. 7) := N;

      while (B >= 64) loop

         Core.Salsa20 (X, Z, K, Sigma);

         for I in Index_64 loop
            C (C_Offset + I) := --  POV and PIndex?
              (if Xor_M then
                 M (M_Offset + I) else 0) xor X (I); --  POV on + and PIndex?
         end loop;

         U := 1;
         for I in I32 range 8 .. 15 loop
            U := U + U32 (Z (I));
            Z (I) := Byte (U mod 256);
            U := Shift_Right (U, 8);
         end loop;

         B := B - 64;
         C_Offset := C_Offset + 64; --  POV?
         M_Offset := M_Offset + 64; --  POV?

      end loop;

      if B > 0 then
         Core.Salsa20 (X, Z, K, Sigma);

         for I in I32 range 0 .. (B - 1) loop
            C (C_Offset + I) := --  POV on + and PIndex?
              (if Xor_M then
                 M (M_Offset + I) else 0) xor X (I); --  POV on + and PIndex?
         end loop;
      end if;
   end Salsa20_Xor_Local;

   --------------------------------------------------------
   --  Exported subprogram bodies
   --------------------------------------------------------

   --  POK
   procedure Salsa20 (C :    out Byte_Seq; --  Output stream
                             N : in     Bytes_8;  --  Nonce
                             K : in     Bytes_32) --  Key
   is
      Null_M : Byte_Seq (0 .. 0);
   begin
      Null_M := (others => 0);
      Salsa20_Xor_Local (C, Null_M, False, N, K);
   end Salsa20;

   --  POK
   procedure Salsa20_Xor (C :    out Byte_Seq; --  Output stream
                          M : in     Byte_Seq; --  Input message
                          N : in     Bytes_8;  --  Nonce
                          K : in     Bytes_32) --  Key
   is
   begin
      Salsa20_Xor_Local (C, M, True, N, K);
   end Salsa20_Xor;



   --  POK
   procedure HSalsa20 (C :    out Byte_Seq; --  Output stream
                       N : in     Bytes_24; --  Nonce
                       K : in     Bytes_32) --  Key
   is
      S : Bytes_32;
   begin
      Core.HSalsa20 (S, N (0 .. 15), K, Sigma);
      Salsa20 (C, N (16 .. 23), S);
   end HSalsa20;

   --  POK
   procedure HSalsa20_Xor (C :    out Byte_Seq; --  Output ciphertext
                           M : in     Byte_Seq; --  Input message
                           N : in     Bytes_24; --  Nonce
                           K : in     Bytes_32) --  Key
   is
      S : Bytes_32;
   begin
      Core.HSalsa20 (S, N (0 .. 15), K, Sigma);
      Salsa20_Xor_Local (C, M, True, N (16 .. 23), S);
   end HSalsa20_Xor;

end SPARKNaCl.Stream;
