package body SPARKNaCl.Core
  with SPARK_Mode => On
is

   --===============================
   --  Local subprogram declarations
   --  and renamings
   --===============================

   function RL32 (X : in U32;
                  C : in Natural) return U32
     renames Rotate_Left;

   procedure ST32 (X :    out Bytes_4;
                   U : in     U32)
     with Global => null;

   function LD32 (X : in Bytes_4) return U32
     with Global => null;

   --===============================
   --  Local subprogram bodies
   --===============================

   --  POK
   procedure ST32 (X :    out Bytes_4;
                   U : in     U32)
   is
      T : U32 := U;
   begin
      for I in X'Range loop
         X (I) := Byte (T mod 256);
         T := Shift_Right (T, 8);
      end loop;
   end ST32;

   --  POK
   function LD32 (X : in Bytes_4) return U32
   is
      U : U32;
   begin
      U := U32 (X (3));
      U := Shift_Left (U, 8) or U32 (X (2));
      U := Shift_Left (U, 8) or U32 (X (1));
      return Shift_Left (U, 8) or U32 (X (0));
   end LD32;

   --------------------------------------------------------
   --  Salsa20 Core functions
   --------------------------------------------------------

   --  POK
   procedure Salsa20 (Output :    out Bytes_64;
                      Input  : in     Bytes_16;
                      K      : in     Bytes_32;
                      C      : in     Bytes_16)
   is
      W, X, Y : U32_Seq_16;
      T       : U32_Seq_4;
   begin
      W := (others => 0);
      --  In C this is a loop, but we unroll and make single
      --  aggregate assignment to initialize the whole of X.
      X := (0  => LD32 (C (0 .. 3)),
            1  => LD32 (K (0 .. 3)),
            6  => LD32 (Input (0 .. 3)),
            11 => LD32 (K (16 .. 19)),

            5  => LD32 (C (4 .. 7)),
            2  => LD32 (K (4 .. 7)),
            7  => LD32 (Input (4 .. 7)),
            12 => LD32 (K (20 .. 23)),

            10 => LD32 (C (8 .. 11)),
            3  => LD32 (K (8 .. 11)),
            8  => LD32 (Input (8 .. 11)),
            13 => LD32 (K (24 .. 27)),

            15 => LD32 (C (12 .. 15)),
            4  => LD32 (K (12 .. 15)),
            9  => LD32 (Input (12 .. 15)),
            14 => LD32 (K (28 .. 31)));

      Y := X;

      for I in Index_20 loop
         for J in Index_4 loop
            T := (0 => X ((5 * J) mod 16),
                  1 => X ((5 * J + 4) mod 16),
                  2 => X ((5 * J + 8) mod 16),
                  3 => X ((5 * J + 12) mod 16));

            T (1) := T (1) xor RL32 (T (0) + T (3), 7);
            T (2) := T (2) xor RL32 (T (1) + T (0), 9);
            T (3) := T (3) xor RL32 (T (2) + T (1), 13);
            T (0) := T (0) xor RL32 (T (3) + T (2), 18);

            W (4 * J + ((J + 0) mod 4)) := T (0);
            W (4 * J + ((J + 1) mod 4)) := T (1);
            W (4 * J + ((J + 2) mod 4)) := T (2);
            W (4 * J + ((J + 3) mod 4)) := T (3);
         end loop;
         X := W;
      end loop;

      --  Salsa20 Output stage
      --  derives Output from X, Y
      Output := (others => 0);
      for I in Index_16 loop
         ST32 (Output (4 * I .. 4 * I + 3), X (I) + Y (I));
      end loop;
   end Salsa20;

   --  POK
   procedure HSalsa20 (Output :    out Bytes_32;
                       Input  : in     Bytes_16;
                       K      : in     Bytes_32;
                       C      : in     Bytes_16)
   is
      W, X, Y : U32_Seq_16;
      T       : U32_Seq_4;
   begin
      W := (others => 0);
      --  In C this is a loop, but we unroll and make single
      --  aggregate assignment to initialize the whole of X.
      X := (0  => LD32 (C (0 .. 3)),
            1  => LD32 (K (0 .. 3)),
            6  => LD32 (Input (0 .. 3)),
            11 => LD32 (K (16 .. 19)),

            5  => LD32 (C (4 .. 7)),
            2  => LD32 (K (4 .. 7)),
            7  => LD32 (Input (4 .. 7)),
            12 => LD32 (K (20 .. 23)),

            10 => LD32 (C (8 .. 11)),
            3  => LD32 (K (8 .. 11)),
            8  => LD32 (Input (8 .. 11)),
            13 => LD32 (K (24 .. 27)),

            15 => LD32 (C (12 .. 15)),
            4  => LD32 (K (12 .. 15)),
            9  => LD32 (Input (12 .. 15)),
            14 => LD32 (K (28 .. 31)));

      Y := X;

      for I in Index_20 loop
         for J in Index_4 loop
            T := (0 => X ((5 * J) mod 16),
                  1 => X ((5 * J + 4) mod 16),
                  2 => X ((5 * J + 8) mod 16),
                  3 => X ((5 * J + 12) mod 16));

            T (1) := T (1) xor RL32 (T (0) + T (3), 7);
            T (2) := T (2) xor RL32 (T (1) + T (0), 9);
            T (3) := T (3) xor RL32 (T (2) + T (1), 13);
            T (0) := T (0) xor RL32 (T (3) + T (2), 18);

            W (4 * J + ((J + 0) mod 4)) := T (0);
            W (4 * J + ((J + 1) mod 4)) := T (1);
            W (4 * J + ((J + 2) mod 4)) := T (2);
            W (4 * J + ((J + 3) mod 4)) := T (3);
         end loop;
         X := W;
      end loop;

      --  HSalsa20 output stage
      --  derives Output from X, Y, C, Input
      for I in Index_16 loop
         X (I) := X (I) + Y (I);
      end loop;

      for I in Index_4 loop
         X (5 * I) := X (5 * I) - LD32 (C (4 * I .. 4 * I + 3));
         X (6 + I) := X (6 + I) - LD32 (Input (4 * I .. 4 * I + 3));
      end loop;

      Output := (others => 0);
      for I in Index_4 loop
         ST32 (Output (4 * I .. 4 * I + 3), X (5 * I));
         ST32 (Output (4 * I + 16 .. 4 * I + 19), X (6 + I));
      end loop;

   end HSalsa20;


end SPARKNaCl.Core;
