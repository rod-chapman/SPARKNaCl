with HAL;       use HAL;
with RISCV.CSR; use RISCV.CSR;

separate (SPARKNaCl.Sign)
procedure Sign2 (SM                   :    out Byte_Seq;
                 M                    : in     Byte_Seq;
                 SK                   : in     Signing_SK;
                 Hash_SK_Time         :    out Unsigned_64;
                 Hash_Reduce_SM1_Time :    out Unsigned_64;
                 Scalarbase_R_Time    :    out Unsigned_64;
                 Pack_P_Time          :    out Unsigned_64;
                 Hash_Reduce_SM2_Time :    out Unsigned_64;
                 Initialize_X_Time    :    out Unsigned_64;
                 Assign_X_Time        :    out Unsigned_64;
                 ModL_X_Time          :    out Unsigned_64)
  with SPARK_Mode => Off
is
   subtype Byte_Product is I64 range 0 .. MBP;

   D    : Bytes_64;
   H, R : Bytes_32;
   X    : I64_Seq_64;
   T    : Byte_Product;
   P    : GF_Vector_4;

   T1, T2, T3, T4, T5, T6, T7, T8, T9 : UInt64;

   procedure Initialize_SM (X : out Byte_Seq)
     with Global  => (Input  => (M, D)),
     Depends => (X => (X, M, D)),
     Pre => (M'First   = 0 and
               X'First  = 0 and
               M'Last   <= N32'Last - Sign_Bytes) and then
     (X'Length = M'Length + Sign_Bytes and
        X'Last   = M'Last + Sign_Bytes),
     Post => (X = Zero_Bytes_32 & D (32 .. 63) & M) and
     X'Initialized,
     Relaxed_Initialization => X,
     Inline;

   procedure Initialize_SM (X : out Byte_Seq)
   is
   begin
      --  Precondition ensures SM is exactly 64 bytes longer than M.
      --  Don't use "&" here to avoid allocation of a dynamic-sized
      --  object on the stack.
      X (0  .. 31)     := Zero_Bytes_32;
      X (32 .. 63)     := D (32 .. 63);
      X (64 .. X'Last) := M;
   end Initialize_SM;


begin
   T1 := Mcycle.Read;

   Hashing.Hash (D, Serialize (SK) (0 .. 31));
   D (0)  := D (0) and 248;
   D (31) := (D (31) and 127) or 64;

   T2 := Mcycle.Read;

   Initialize_SM (SM);
   R := Hash_Reduce (SM (32 .. SM'Last));

   T3 := Mcycle.Read;

   P := Scalarbase (R);

   T4 := Mcycle.Read;

   SM (0 .. 31) := Pack (P);
   SM (32 .. 63) := Serialize (SK) (32 .. 63);

   T5 := Mcycle.Read;

   H := Hash_Reduce (SM);

   T6 := Mcycle.Read;

   X := (others => 0);
   for I in Index_32 loop
      X (I) := I64 (R (I));
      pragma Loop_Invariant
        ((for all K in N32 range     0 .. I  => X (K) in I64_Byte) and
           (for all K in N32 range I + 1 .. 63 => X (K) = 0));
   end loop;

   T7 := Mcycle.Read;

   pragma Assert
     ((for all K in N32 range  0 .. 31 => X (K) in I64_Byte) and
        (for all K in N32 range 32 .. 63 => X (K) = 0) and
        (for all K in Index_64 => X (K) in I64_Byte)
     );

   pragma Warnings (Off, "explicit membership test may be optimized");

   for I in Index_32 loop
      for J in Index_32 loop
         T := Byte_Product (H (I)) * Byte_Product (D (J));
         X (I + J) := X (I + J) + T;

         --  This loop invariant follows the same pattern
         --  as that in SPARKNaCl."*"
         pragma Loop_Invariant
           (
            T in Byte_Product and

              --  Lower bound
              (for all K in Index_64 => X (K) >= 0) and

              --  rising from 1 to I
              (for all K in Index_64 range 0 .. (I - 1)   =>
                 X (K) <= (I64 (K + 1) * MBP + 255)) and

              --  flat at I + 1, just written
              (for all K in Index_64 range I .. I32'Min (31, I + J) =>
                 X (K) <= (I64 (I + 1) * MBP + 255)) and

              --  flat at I, not written yet
              (for all K in Index_64 range I + J + 1 .. 31 =>
                 X (K) <= (I64 (I) * MBP + 255)) and

              --  falling from I to 1, just written
              (for all K in Index_64 range 32 .. (I + J) =>
                 X (K) <= (I64 (32 + I) - I64 (K)) * MBP + 255) and

              --  falling, from I to 1, but not written yet
              (for all K in Index_64 range
                 I32'Max (32, I + J + 1) .. (I + 31) =>
                 X (K) <= (I64 (31 + I) - I64 (K)) * MBP + 255) and

              --  Zeroes - never written
              (for all K in Index_64 range I + 32 .. 63   =>
                 X (K) = 0)
           );
      end loop;

      --  Substitute J = 31 into the above yields
      pragma Loop_Invariant
        (
         T in Byte_Product and

           --  Lower bound
           (for all K in Index_64 => X (K) >= 0) and

           --  rising from 1 to I
           (for all K in Index_64 range 0 .. (I - 1)   =>
              X (K) <= (I64 (K + 1) * MBP + 255)) and

           --  flat at I + 1, just written
           (for all K in Index_64 range I .. 31 =>
              X (K) <= (I64 (I + 1) * MBP + 255)) and

           --  falling from I to 1, just written
           (for all K in Index_64 range 32 .. (I + 31) =>
              X (K) <= (I64 (32 + I) - I64 (K)) * MBP + 255) and

           --  Zeroes - never written
           (for all K in Index_64 range I + 32 .. 63   =>
              X (K) = 0)
        );
   end loop;

   T8 := Mcycle.Read;

   --  Substitute I = 31
   pragma Assert
     (
      --  Lower bound
      (for all K in Index_64 => X (K) >= 0) and

        --  Upper bounds
        (for all K in Index_64 range 0 .. 30   =>
           X (K) <= (I64 (K + 1) * MBP + 255)) and
        X (31) <= (32 * MBP + 255) and
        (for all K in Index_64 range 32 .. 62 =>
           X (K) <= (63 - I64 (K)) * MBP + 255) and
        X (63) = 0
     );

   --  Simplify - this assert is equivalent to the precondition of ModL
   pragma Assert
     (for all K in Index_64 => X (K) in 0 .. (32 * MBP + 255));

   SM (32 .. 63) := ModL (X);

   T9 := Mcycle.Read;

   Sanitize (D);
   Sanitize (H);
   Sanitize (R);
   Sanitize_I64_Seq (X);

   Hash_SK_Time         := Unsigned_64 (T2 - T1);
   Hash_Reduce_SM1_Time := Unsigned_64 (T3 - T2);
   Scalarbase_R_Time    := Unsigned_64 (T4 - T3);
   Pack_P_Time          := Unsigned_64 (T5 - T4);
   Hash_Reduce_SM2_Time := Unsigned_64 (T6 - T5);
   Initialize_X_Time    := Unsigned_64 (T7 - T6);
   Assign_X_Time        := Unsigned_64 (T8 - T7);
   ModL_X_Time          := Unsigned_64 (T9 - T8);

   pragma Unreferenced (D, H, R, X);
end Sign2;
