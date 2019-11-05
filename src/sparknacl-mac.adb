package body SPARKNaCl.MAC
  with SPARK_Mode => On
is

   subtype Index_17 is I32 range 0 .. 16;
   subtype Poly_1305_F is U32_Seq (Index_17);

   MinusP : constant Poly_1305_F :=
     (5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 252);


   procedure Onetimeauth (Output :    out Bytes_16;
                          M      : in     Byte_Seq;
                          K      : in     Bytes_32)
   is
      S, U           : U32;
      J, N, M_Offset : I32;
      X, R, H, C, G  : Poly_1305_F;

      --  RCC Replace formals with globals?
      procedure Add_1305 (H : in out Poly_1305_F;
                          C : in     Poly_1305_F)
        with Global => null;

      --  POK
      procedure Add_1305 (H : in out Poly_1305_F;
                          C : in     Poly_1305_F)
      is
         U : U32 := 0;
      begin
         for J in Index_17 loop
            U := U + H (J) + C (J);
            H (J) := U and 255;
            U := Shift_Right (U, 8);
         end loop;
      end Add_1305;

   begin
      H := (others => 0);
      X := (others => 0);

      R := (0  => U32 (K (0)),
            1  => U32 (K (1)),
            2  => U32 (K (2)),
            3  => U32 (K (3)) and 15,
            4  => U32 (K (4)) and 252,
            5  => U32 (K (5)),
            6  => U32 (K (6)),
            7  => U32 (K (7)) and 15,
            8  => U32 (K (8)) and 252,
            9  => U32 (K (9)),
            10 => U32 (K (10)),
            11 => U32 (K (11)) and 15,
            12 => U32 (K (12)) and 252,
            13 => U32 (K (13)),
            14 => U32 (K (14)),
            15 => U32 (K (15)) and 15,
            16 => 0);

      N := M'Length; --  PRange?
      M_Offset := 0;

      while (N > 0) loop

         C := (others => 0);

         J := 0;
         while  ((J < 16) and (J < N)) loop
            C (J) := U32 (M (M_Offset + J)); --  PIndex * 2, POV on +
            J := J + 1;
         end loop;

         C (J) := 1;
         M_Offset := M_Offset + J;
         N := N - J;
         Add_1305 (H, C);

         for I in Index_17 loop
            X (I) := 0;
            for P in Index_17 loop
               X (I) := X (I) + H (P) *
                        (if P <= I then R (I - P) else 320 * R (I + 17 - P));
            end loop;
         end loop;

         H := X;
         U := 0;

         for P in Index_16 loop
            U := U + H (P);
            H (P) := U and 255;
            U := Shift_Right (U, 8);
         end loop;

         U := U + H (16);
         H (16) := U and 3;
         U := 5 * Shift_Right (U, 2);

         for P in Index_16 loop
            U := U + H (P);
            H (P) := U and 255;
            U := Shift_Right (U, 8);
         end loop;

         U := U + H (16);
         H (16) := U;
      end loop;

      G := H;

      Add_1305 (H, MinusP);

      S := -Shift_Right (H (16), 7);

      for P in Index_17 loop
         H (P) := H (P) xor (S and (G (P) xor H (P)));
      end loop;

      C := (U32 (K (16)), U32 (K (17)), U32 (K (18)), U32 (K (19)),
            U32 (K (20)), U32 (K (21)), U32 (K (22)), U32 (K (23)),
            U32 (K (24)), U32 (K (25)), U32 (K (26)), U32 (K (27)),
            U32 (K (28)), U32 (K (29)), U32 (K (30)), U32 (K (31)), 0);

      Add_1305 (H, C);

      for P in Index_16 loop
         Output (P) := Byte (H (P) mod 256);
      end loop;
   end Onetimeauth;


   function Onetimeauth_Verify (H : in Bytes_16;
                                M : in Byte_Seq;
                                K : in Bytes_32) return Boolean
   is
      X : Bytes_16;
   begin
      Onetimeauth (X, M, K);
      return Equal (H, X);
   end Onetimeauth_Verify;

end SPARKNaCl.MAC;
