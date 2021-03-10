with SPARKNaCl.Utils;
package body SPARKNaCl.Scalar
  with SPARK_Mode => On
is
   pragma Warnings (GNATProve, Off, "pragma * ignored (not yet supported)");

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

      A, B, C, D, E, F : Normal_GF;

      --  Additional temporaries needed to avoid aliasing of
      --  function results and their arguments. This enables RSO
      --  in all function/operator calls below.
      T1, T2 : Normal_GF;

      Result : Bytes_32;
   begin
      B := X;
      C := GF_0;
      A := GF_1;
      D := GF_1;

      for I in reverse U32 range 0 .. 254 loop
         pragma Loop_Optimize (No_Unroll);

         CB := Z (I32 (Shift_Right (I, 3)));
         Shift := Natural (I and 7);
         Swap  := Boolean'Val (Shift_Right (CB, Shift) mod 2);

         pragma Loop_Invariant (A in Normal_GF and B in Normal_GF and
                                C in Normal_GF and D in Normal_GF);

         Utils.CSwap16 (A, B, Swap);
         Utils.CSwap16 (C, D, Swap);

         --  Single binary operator or unary function call per statement to
         --  avoid introduction of a compiler-generated temporary that we
         --  won't be able to sanitize.
         E  := A + C;
         T1 := A - C;

         C  := B + D;
         T2 := B - D;

         D := Square (E);
         F := Square (T1);

         A := C * T1;
         C := T2 * E;
         E := A + C;

         T2 := A - C;
         B  := Square (T2);
         T1 := D - F;

         A  := T1 * GF_121665;
         T2 := A + D;

         C := T1 * T2;

         A := D * F;
         D := B * X;
         B := Square (E);

         Utils.CSwap16 (A, B, Swap);
         Utils.CSwap16 (C, D, Swap);
      end loop;

      --  Compute Result in 3 steps here to avoid introducing a
      --  compiler-generated temporary which we won't be able
      --  to sanitize.
      T1 := Utils.Inv_25519 (C);
      T2 := A * T1;
      Result := Utils.Pack_25519 (T2);

      --  Sanitize as per WireGuard sources
      pragma Warnings (GNATProve, Off, "statement has no effect");
      Sanitize_Boolean (Swap);
      Sanitize (Z);
      Sanitize_GF16 (X);
      Sanitize_GF16 (A);
      Sanitize_GF16 (B);
      Sanitize_GF16 (C);
      Sanitize_GF16 (D);
      Sanitize_GF16 (E);
      Sanitize_GF16 (F);
      Sanitize_GF16 (T1);
      Sanitize_GF16 (T2);
      pragma Unreferenced (Swap, Z, X, A, B, C, D, E, F, T1, T2);

      return Result;
   end Mult;

   function Mult_Base (N : in Bytes_32) return Bytes_32
   is
   begin
      return Mult (N, Nine);
   end Mult_Base;

end SPARKNaCl.Scalar;
