package body SPARKNaCl.MAC
  with SPARK_Mode => On
is
   pragma Warnings (GNATProve, Off, "pragma * ignored (not yet supported)");

   subtype Index_17 is I32 range 0 .. 16;
   subtype Poly_1305_F is U32_Seq (Index_17);

   MinusP : constant Poly_1305_F :=
     (5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 252);

   function Construct (K : in Bytes_32) return Poly_1305_Key
   is
   begin
      return Poly_1305_Key'(F => K);
   end Construct;

   procedure Construct (K :    out Poly_1305_Key;
                        X : in     Bytes_32)
   is
   begin
      K.F := X;
   end Construct;

   function Serialize (K : in Poly_1305_Key) return Bytes_32
   is
   begin
      return K.F;
   end Serialize;

   procedure Sanitize (K : out Poly_1305_Key)
   is
   begin
      Sanitize (K.F);
   end Sanitize;

   procedure Onetimeauth (Output :    out Bytes_16;
                          M      : in     Byte_Seq;
                          K      : in     Poly_1305_Key)
   is
      S, U           : U32;
      J              : Index_17;
      N              : I64; --  Because M'Length can be > I32'Last
      M_Offset       : N32;
      X, R, H, C, G  : Poly_1305_F;

      procedure Add_1305 (H : in out Poly_1305_F;
                          C : in     Poly_1305_F)
        with Global => null;

      procedure Add_1305 (H : in out Poly_1305_F;
                          C : in     Poly_1305_F)
      is
         U : U32 := 0;
      begin
         for J in Index_17 loop
            pragma Loop_Optimize (No_Unroll);
            U := U + H (J) + C (J);
            H (J) := U and 255;
            U := Shift_Right (U, 8);
         end loop;
      end Add_1305;

   begin
      H := (others => 0);
      X := (others => 0);

      R := (0  => U32 (K.F (0)),
            1  => U32 (K.F (1)),
            2  => U32 (K.F (2)),
            3  => U32 (K.F (3)) and 15,
            4  => U32 (K.F (4)) and 252,
            5  => U32 (K.F (5)),
            6  => U32 (K.F (6)),
            7  => U32 (K.F (7)) and 15,
            8  => U32 (K.F (8)) and 252,
            9  => U32 (K.F (9)),
            10 => U32 (K.F (10)),
            11 => U32 (K.F (11)) and 15,
            12 => U32 (K.F (12)) and 252,
            13 => U32 (K.F (13)),
            14 => U32 (K.F (14)),
            15 => U32 (K.F (15)) and 15,
            16 => 0);

      N := M'Length;
      M_Offset := 0;

      while (N > 0) loop
         pragma Loop_Optimize (No_Unroll);

         C := (others => 0);

         J := 0;

         pragma Loop_Invariant
           (N + I64 (M_Offset) = M'Length);

         while  ((J < 16) and (I64 (J) < N)) loop
            pragma Loop_Optimize (No_Unroll);
            pragma Loop_Invariant
              (N + I64 (M_Offset) = M'Length and
                 M_Offset + J in M'Range);

            C (J) := U32 (M (M_Offset + J));
            J := J + 1;
         end loop;

         C (J) := 1;


         N := N - I64 (J);
         --  If N > 0 now, then there at least one more block to process.
         --  If N = 0, then this is the final loop iteration, so no need to
         --  increment M_Offset. This also protects against overflow
         --  when M'Last is at or near N32'Last
         if N > 0 then
            M_Offset := M_Offset + J; -- POV
         end if;

         Add_1305 (H, C);

         for I in Index_17 loop
            pragma Loop_Optimize (No_Unroll);

            X (I) := 0;
            for P in Index_17 loop
               pragma Loop_Optimize (No_Unroll);
               X (I) := X (I) + H (P) *
                        (if P <= I then R (I - P) else 320 * R (I + 17 - P));
            end loop;
         end loop;

         H := X;
         U := 0;

         for P in Index_16 loop
            pragma Loop_Optimize (No_Unroll);
            U := U + H (P);
            H (P) := U and 255;
            U := Shift_Right (U, 8);
         end loop;

         U := U + H (16);
         H (16) := U and 3;
         U := 5 * Shift_Right (U, 2);

         for P in Index_16 loop
            pragma Loop_Optimize (No_Unroll);
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
         pragma Loop_Optimize (No_Unroll);
         H (P) := H (P) xor (S and (G (P) xor H (P)));
      end loop;

      C := (U32 (K.F (16)), U32 (K.F (17)), U32 (K.F (18)), U32 (K.F (19)),
            U32 (K.F (20)), U32 (K.F (21)), U32 (K.F (22)), U32 (K.F (23)),
            U32 (K.F (24)), U32 (K.F (25)), U32 (K.F (26)), U32 (K.F (27)),
            U32 (K.F (28)), U32 (K.F (29)), U32 (K.F (30)), U32 (K.F (31)),
            0);

      Add_1305 (H, C);

      for P in Index_16 loop
         pragma Loop_Optimize (No_Unroll);
         Output (P) := Byte (H (P) mod 256);
      end loop;
   end Onetimeauth;

   function Onetimeauth_Verify (H : in Bytes_16;
                                M : in Byte_Seq;
                                K : in Poly_1305_Key) return Boolean
   is
      X : Bytes_16;
   begin
      Onetimeauth (X, M, K);
      return Equal (H, X);
   end Onetimeauth_Verify;

end SPARKNaCl.MAC;
