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
      --  X and Z are variables not constants, so can be sanitized
      X : Normal_GF := Utils.Unpack_25519 (P);
      Z : Bytes_32 :=
         (N (0) and 248) & N (1 .. 30) & ((N (31) and 127) or 64);

      Swap  : Boolean;
      CB    : Byte;
      Shift : Natural;

      A, B, C, D, E, F, T : Normal_GF;
      Result : Bytes_32;
   begin
      B := X;
      C := GF_0;
      A := GF_1;
      D := GF_1;

      for I in reverse U32 range 0 .. 254 loop
         CB := Z (I32 (Shift_Right (I, 3)));
         Shift := Natural (I and 7);
         Swap  := Boolean'Val (Shift_Right (CB, Shift) mod 2);

         pragma Loop_Invariant (A in Normal_GF and B in Normal_GF and
                                C in Normal_GF and D in Normal_GF);

         Utils.CSwap (A, B, Swap);
         Utils.CSwap (C, D, Swap);

         --  Single binary operator or unary function call per statement to
         --  avoid introduction of a compiler-generated temporary that we
         --  won't be able to sanitize.
         E := A + C;
         A := A - C;

         C := B + D;
         B := B - D;

         D := Square (E);
         F := Square (A);

         A := C * A;
         C := B * E;
         E := A + C;

         A := A - C;
         B := Square (A);
         C := D - F;

         A := C * GF_121665;
         A := A + D;

         C := C * A;

         A := D * F;
         D := B * X;
         B := Square (E);

         Utils.CSwap (A, B, Swap);
         Utils.CSwap (C, D, Swap);
      end loop;

      --  Compute Result in 3 steps here to avoid introducing a
      --  compiler-generated temporary which we won't be able
      --  to sanitize.
      T := Utils.Inv_25519 (C);
      T := A * T;
      Result := Utils.Pack_25519 (T);

      --  Sanitize as per WireGuard sources
      pragma Warnings (GNATProve, Off, "statement has no effect");
      Sanitize_Boolean (Swap);
      Sanitize (Z);
      Sanitize_GF (X);
      Sanitize_GF (A);
      Sanitize_GF (B);
      Sanitize_GF (C);
      Sanitize_GF (D);
      Sanitize_GF (E);
      Sanitize_GF (F);
      Sanitize_GF (T);
      pragma Unreferenced (Swap, Z, X, A, B, C, D, E, F, T);

      return Result;
   end Mult;

   function Mult_Base (N : in Bytes_32) return Bytes_32
   is
   begin
      return Mult (N, Nine);
   end Mult_Base;

end SPARKNaCl.Scalar;
