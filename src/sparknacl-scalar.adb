package body SPARKNaCl.Scalar
  with SPARK_Mode => On
is

   Nine : constant Bytes_32 := (9, others => 0);
   GF_121665 : constant GF := (16#DB41#, 1, others => 0);


   --------------------------------------------------------
   --  Scalar multiplication
   --------------------------------------------------------

   --  POK
   procedure Mult (Q :    out Bytes_32;
                   N : in     Bytes_32;
                   P : in     Bytes_32)
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

      Unpack_25519 (X, P);

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

         Sel_25519 (A2, B, Swap);
         Sel_25519 (C, D, Swap);

         A (E, A2, C);

         Z (A3, A2, C);

         A (C, B, D);

         Z (B2, B, D);

         S (D, E);
         S (F, A3);

         M (A2, C, A3);
         M (C, B2, E);
         A (E, A2, C);

         Z (A3, A2, C);
         S (B, A3);
         Z (C, D, F);

         M (A2, C, GF_121665);
         A (A3, A2, D);

         C2 := C;
         M (C, C2, A3);

         M (A2, D, F);
         M (D, B, X);
         S (B, E);

         Sel_25519 (A2, B, Swap);
         Sel_25519 (C, D, Swap);
      end loop;

      T1 := Inv_25519 (C);
      M (T2, A2, T1);
      Q := Pack_25519 (T2);

   end Mult;

   --  POK
   procedure Mult_Base (Q :    out Bytes_32;
                        N : in     Bytes_32)
   is
   begin
      Mult (Q, N, Nine);
   end Mult_Base;


end SPARKNaCl.Scalar;
