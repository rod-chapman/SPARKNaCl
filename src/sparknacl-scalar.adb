with SPARKNaCl.Utils;
package body SPARKNaCl.Scalar
  with SPARK_Mode => On
is

   Nine : constant Bytes_32 := (9, others => 0);
   GF_121665 : constant GF := (16#DB41#, 1, others => 0);


   --------------------------------------------------------
   --  Scalar multiplication
   --------------------------------------------------------

   --  POK
   function Mult (N : in Bytes_32;
                  P : in Bytes_32) return Bytes_32
   is
      Z2   : Bytes_32;
      X    : GF;
      Swap : Boolean;

      A2, A3, B, B2, C, C2, D, E, F, T1, T2 : GF;
      CB    : Byte;
      Shift : Natural;
   begin
      Z2 := N;
      Z2 (31) := (N (31) and 127) or 64;
      Z2 (0) := Z2 (0) and 248;

      X := Utils.Unpack_25519 (P);

      B  := X;
      C  := GF_0;
      A2 := GF_0;
      D  := GF_0;

      A2 (0) := 1;
      D  (0) := 1;

      for I in reverse U32 range 0 .. 254 loop
         CB := Z2 (I32 (Shift_Right (I, 3)));
         Shift := Natural (I and 7);
         Swap := Boolean'Val (Shift_Right (CB, Shift) and 1);

         Utils.Sel_25519 (A2, B, Swap);
         Utils.Sel_25519 (C, D, Swap);

         E := A2 + C;

         A3 := A2 - C;

         C := B + D;

         B2 := B - D;

         D := Square (E);
         F := Square (A3);

         M (A2, C, A3);
         M (C, B2, E);
         E := A2 + C;

         A3 := A2 - C;
         B := Square (A3);
         C := D - F;

         M (A2, C, GF_121665);
         A3 := A2 + D;

         C2 := C;
         M (C, C2, A3);

         M (A2, D, F);
         M (D, B, X);
         B := Square (E);

         Utils.Sel_25519 (A2, B, Swap);
         Utils.Sel_25519 (C, D, Swap);
      end loop;

      T1 := Utils.Inv_25519 (C);
      M (T2, A2, T1);

      return Utils.Pack_25519 (T2);
   end Mult;

   --  POK
   function Mult_Base (N : in Bytes_32) return Bytes_32
   is
   begin
      return Mult (N, Nine);
   end Mult_Base;


end SPARKNaCl.Scalar;
