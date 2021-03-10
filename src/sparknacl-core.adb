package body SPARKNaCl.Core
  with SPARK_Mode => On
is
   pragma Warnings (GNATProve, Off, "pragma * ignored (not yet supported)");

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

   --  Derives intermediate values X and Y from Input, K and C.
   --  Common to both Salsa20 and HSalsa20
   procedure Core_Common
     (Input  : in     Bytes_16;
      K      : in     Salsa20_Key;
      C      : in     Bytes_16;
      X      :    out U32_Seq_16;
      Y      :    out U32_Seq_16)
     with Global => null;

   --===============================
   --  Local subprogram bodies
   --===============================

   procedure ST32 (X :    out Bytes_4;
                   U : in     U32)
   is
      T : U32 := U;
   begin
      for I in X'Range loop
         pragma Loop_Optimize (No_Unroll);
         X (I) := Byte (T mod 256);
         T := Shift_Right (T, 8);
      end loop;
   end ST32;

   function LD32 (X : in Bytes_4) return U32
   is
      U : U32;
   begin
      U := U32 (X (3));
      U := Shift_Left (U, 8) or U32 (X (2));
      U := Shift_Left (U, 8) or U32 (X (1));
      return Shift_Left (U, 8) or U32 (X (0));
   end LD32;

   procedure Core_Common
     (Input  : in     Bytes_16;
      K      : in     Salsa20_Key;
      C      : in     Bytes_16;
      X      :    out U32_Seq_16;
      Y      :    out U32_Seq_16)
   is
      W : U32_Seq_16;
      T : U32_Seq_4;

      --  Common to all iterations of the inner loop,
      --  so factored out here.
      procedure Adjust_T
        with Global => (In_Out => T);

      procedure Adjust_T
      is
      begin
         T (1) := T (1) xor RL32 (T (0) + T (3), 7);
         T (2) := T (2) xor RL32 (T (1) + T (0), 9);
         T (3) := T (3) xor RL32 (T (2) + T (1), 13);
         T (0) := T (0) xor RL32 (T (3) + T (2), 18);
      end Adjust_T;
   begin
      W := (others => 0);
      --  In C this is a loop, but we unroll and make single
      --  aggregate assignment to initialize the whole of X.
      X := (0  => LD32 (C (0 .. 3)),
            1  => LD32 (Bytes_4 (K.F (0 .. 3))),
            6  => LD32 (Input (0 .. 3)),
            11 => LD32 (Bytes_4 (K.F (16 .. 19))),

            5  => LD32 (C (4 .. 7)),
            2  => LD32 (Bytes_4 (K.F (4 .. 7))),
            7  => LD32 (Input (4 .. 7)),
            12 => LD32 (Bytes_4 (K.F (20 .. 23))),

            10 => LD32 (C (8 .. 11)),
            3  => LD32 (Bytes_4 (K.F (8 .. 11))),
            8  => LD32 (Input (8 .. 11)),
            13 => LD32 (Bytes_4 (K.F (24 .. 27))),

            15 => LD32 (C (12 .. 15)),
            4  => LD32 (Bytes_4 (K.F (12 .. 15))),
            9  => LD32 (Input (12 .. 15)),
            14 => LD32 (Bytes_4 (K.F (28 .. 31))));

      Y := X;

      for I in Index_20 loop
         pragma Loop_Optimize (No_Unroll);
         --  This inner loop has been unrolled manually and
         --  simplified in SPARKNaCl.
         --
         --  ORIGINAL CODE:
         --  for J in Index_4 loop
         --     T := (0 => X ((5 * J) mod 16),
         --           1 => X ((5 * J + 4) mod 16),
         --           2 => X ((5 * J + 8) mod 16),
         --           3 => X ((5 * J + 12) mod 16));

         --     T (1) := T (1) xor RL32 (T (0) + T (3), 7);
         --     T (2) := T (2) xor RL32 (T (1) + T (0), 9);
         --     T (3) := T (3) xor RL32 (T (2) + T (1), 13);
         --     T (0) := T (0) xor RL32 (T (3) + T (2), 18);

         --     W (4 * J + ((J + 0) mod 4)) := T (0);
         --     W (4 * J + ((J + 1) mod 4)) := T (1);
         --     W (4 * J + ((J + 2) mod 4)) := T (2);
         --     W (4 * J + ((J + 3) mod 4)) := T (3);
         --  end loop;

         --  Begin loop unrolling --
         --  Iteration with J = 0 --
         T := (0 => X (0),
               1 => X (4),
               2 => X (8),
               3 => X (12));

         Adjust_T;

         W (0) := T (0);
         W (1) := T (1);
         W (2) := T (2);
         W (3) := T (3);

         --  Iteration with J = 1 --
         T := (0 => X (5),
               1 => X (9),
               2 => X (13),
               3 => X (1));

         Adjust_T;

         W (5) := T (0);
         W (6) := T (1);
         W (7) := T (2);
         W (4) := T (3);

         --  Iteration with J = 2 --
         T := (0 => X (10),
               1 => X (14),
               2 => X (2),
               3 => X (6));

         Adjust_T;

         W (10) := T (0);
         W (11) := T (1);
         W (8)  := T (2);
         W (9)  := T (3);

         --  Iteration with J = 3 --
         T := (0 => X (15),
               1 => X (3),
               2 => X (7),
               3 => X (11));

         Adjust_T;

         W (15) := T (0);
         W (12) := T (1);
         W (13) := T (2);
         W (14) := T (3);
         --  End loop unrolling  --

         X := W;
      end loop;
   end Core_Common;

   --------------------------------------------------------
   --  Exported suprogram bodies
   --------------------------------------------------------

   function Construct (K : in Bytes_32) return Salsa20_Key
   is
   begin
      return Salsa20_Key'(F => K);
   end Construct;

   procedure Construct (K :    out Salsa20_Key;
                        X : in     Bytes_32)
   is
   begin
      K.F := X;
   end Construct;

   function Serialize (K : in Salsa20_Key) return Bytes_32
   is
   begin
      return K.F;
   end Serialize;

   procedure Sanitize (K : out Salsa20_Key)
   is
   begin
      Sanitize (K.F);
   end Sanitize;

   --------------------------------------------------------
   --  Salsa20 Core subprograms
   --------------------------------------------------------

   procedure Salsa20 (Output :    out Bytes_64;
                      Input  : in     Bytes_16;
                      K      : in     Salsa20_Key;
                      C      : in     Bytes_16)
   is
      X, Y : U32_Seq_16;
   begin
      Core_Common (Input, K, C, X, Y);

      --  Salsa20 Output stage
      --  derives Output from X, Y
      Output := (others => 0);
      for I in Index_16 loop
         pragma Loop_Optimize (No_Unroll);
         ST32 (Output (4 * I .. 4 * I + 3), X (I) + Y (I));
      end loop;
   end Salsa20;

   procedure HSalsa20 (Output :    out Bytes_32;
                       Input  : in     Bytes_16;
                       K      : in     Salsa20_Key;
                       C      : in     Bytes_16)
   is
      X, Y : U32_Seq_16;
   begin
      Core_Common (Input, K, C, X, Y);

      --  HSalsa20 output stage
      --  derives Output from X, Y, C, Input
      for I in Index_16 loop
         pragma Loop_Optimize (No_Unroll);
         X (I) := X (I) + Y (I);
      end loop;

      for I in Index_4 loop
         pragma Loop_Optimize (No_Unroll);
         X (5 * I) := X (5 * I) - LD32 (C (4 * I .. 4 * I + 3));
         X (6 + I) := X (6 + I) - LD32 (Input (4 * I .. 4 * I + 3));
      end loop;

      Output := (others => 0);
      for I in Index_4 loop
         pragma Loop_Optimize (No_Unroll);
         ST32 (Output (4 * I .. 4 * I + 3), X (5 * I));
         ST32 (Output (4 * I + 16 .. 4 * I + 19), X (6 + I));
      end loop;
   end HSalsa20;


end SPARKNaCl.Core;
