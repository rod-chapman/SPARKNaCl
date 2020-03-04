with SPARKNaCl.Utils;
package body SPARKNaCl.Scalar
  with SPARK_Mode => On
is

   Nine : constant Bytes_32 := (9, others => 0);
   GF_121665 : constant Normal_GF := (16#DB41#, 1, others => 0);

   --------------------------------------------------------
   --  Scalar multiplication
   --------------------------------------------------------

   function Mult (N : in Bytes_32;
                  P : in Bytes_32) return Bytes_32
   is
      X  : Normal_GF := Utils.Unpack_25519 (P);
      Z2 : Bytes_32 :=
         (N (0) and 248) & N (1 .. 30) & ((N (31) and 127) or 64);

      Swap  : Boolean;
      CB    : Byte;
      Shift : Natural;

      A2, A3, B, B2, C, C2, D, E, F, T1, T2 : Normal_GF;
   begin
      B  := X;
      C  := GF_0;
      A2 := GF_1;
      D  := GF_1;

      for I in reverse U32 range 0 .. 254 loop
         CB := Z2 (I32 (Shift_Right (I, 3)));
         Shift := Natural (I and 7);
         Swap  := Boolean'Val (Shift_Right (CB, Shift) mod 2);

         pragma Loop_Invariant (A2 in Normal_GF);
         pragma Loop_Invariant (B  in Normal_GF);
         pragma Loop_Invariant (C  in Normal_GF);
         pragma Loop_Invariant (D  in Normal_GF);

         Utils.CSwap (A2, B, Swap);
         Utils.CSwap (C, D, Swap);

         E  := A2 + C;
         A3 := A2 - C;

         C  := B + D;
         B2 := B - D;

         D  := Square (E);
         F  := Square (A3);

         A2 := C * A3;
         C  := B2 * E;
         E  := A2 + C;

         A3 := A2 - C;
         B  := Square (A3);
         C  := D - F;

         A2 := C * GF_121665;
         A3 := A2 + D;

         C2 := C;
         C  := C2 * A3;

         A2 := D * F;
         D  := B * X;
         B  := Square (E);

         Utils.CSwap (A2, B, Swap);
         Utils.CSwap (C, D, Swap);
      end loop;

      T1 := Utils.Inv_25519 (C);
      T2 := A2 * T1;

      --  Sanitize as per WireGuard sources
      pragma Warnings (GNATProve, Off, "statement has no effect");
      Sanitize_Boolean (Swap);
      Sanitize (Z2);
      Sanitize_GF (X);
      Sanitize_GF (A2);
      Sanitize_GF (A3);
      Sanitize_GF (B);
      Sanitize_GF (B2);
      Sanitize_GF (C);
      Sanitize_GF (C2);
      Sanitize_GF (D);
      Sanitize_GF (E);
      Sanitize_GF (F);
      Sanitize_GF (T1);
      pragma Unreferenced (Swap, Z2, X, A2, A3, B, B2, C, C2, D, E, F, T1);

      return Utils.Pack_25519 (T2);
   end Mult;

   function Mult_Base (N : in Bytes_32) return Bytes_32
   is
   begin
      return Mult (N, Nine);
   end Mult_Base;

end SPARKNaCl.Scalar;
