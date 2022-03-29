package body S3
  with SPARK_Mode => On
is

   function M2 (Left, Right : in Normal_GF) return Normal_GF
   is
      L : Normal_GF renames Left;
      R : Normal_GF renames Right;
      Result : Normal_GF;

      subtype U32NL is U32 range 0 .. LMM1;

      L0  : constant U32NL := U32NL (L (0));
      L1  : constant U32NL := U32NL (L (1));
      L2  : constant U32NL := U32NL (L (2));
      L3  : constant U32NL := U32NL (L (3));
      L4  : constant U32NL := U32NL (L (4));
      L5  : constant U32NL := U32NL (L (5));
      L6  : constant U32NL := U32NL (L (6));
      L7  : constant U32NL := U32NL (L (7));
      L8  : constant U32NL := U32NL (L (8));
      L9  : constant U32NL := U32NL (L (9));
      L10 : constant U32NL := U32NL (L (10));
      L11 : constant U32NL := U32NL (L (11));
      L12 : constant U32NL := U32NL (L (12));
      L13 : constant U32NL := U32NL (L (13));
      L14 : constant U32NL := U32NL (L (14));
      L15 : constant U32NL := U32NL (L (15));
      R0  : constant U32NL := U32NL (R (0));
      R1  : constant U32NL := U32NL (R (1));
      R2  : constant U32NL := U32NL (R (2));
      R3  : constant U32NL := U32NL (R (3));
      R4  : constant U32NL := U32NL (R (4));
      R5  : constant U32NL := U32NL (R (5));
      R6  : constant U32NL := U32NL (R (6));
      R7  : constant U32NL := U32NL (R (7));
      R8  : constant U32NL := U32NL (R (8));
      R9  : constant U32NL := U32NL (R (9));
      R10 : constant U32NL := U32NL (R (10));
      R11 : constant U32NL := U32NL (R (11));
      R12 : constant U32NL := U32NL (R (12));
      R13 : constant U32NL := U32NL (R (13));
      R14 : constant U32NL := U32NL (R (14));
      R15 : constant U32NL := U32NL (R (15));

      --  Limb Product - a subtype for representing the product
      --  of two normalized GF64 Limbs
      subtype LP is I64 range 0 .. MGFLP;

      subtype GF64_Natural_Limb is I64 range 0 .. (MGFLC * MGFLP);

      T0 : LP;
      subtype T16S is GF64_Natural_Limb range 0 .. 15 * MGFLP;
      T16 : T16S;

      TF0 : GF64_Natural_Limb;

      C : GF64_Natural_Limb;
   begin
      T0 := LP (L0 * R0);
      pragma Assert (T0 in LP);
      T16 := LP (L15 * R1)  + LP (L14 * R2)  + LP (L13 * R3) +
             LP (L12 * R4)  + LP (L11 * R5)  + LP (L10 * R6) +
             LP (L9  * R7)  + LP (L8  * R8)  + LP (L7  * R9) +
             LP (L6  * R10) + LP (L5  * R11) + LP (L4  * R12) +
             LP (L3  * R13) + LP (L2  * R14) + LP (L1  * R15);
      pragma Assert (T16 in T16S);
      TF0  := T0  + R2256 * T16;
      pragma Assert (TF0 in GF64_Natural_Limb);
      C := TF0 / LM;
      pragma Assert (C in 0 .. 37419914);
      TF0 := TF0 mod LM;
      pragma Assert (TF0 in 0 .. LMM1);

      Result := (others => U16 (TF0));
      return Result;
   end M2;

end S3;
