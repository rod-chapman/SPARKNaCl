with S2.Car;
--  with SPARKNaCl.PDebug;
--  with SPARKNaCl.Debug;
package body S2
  with SPARK_Mode => On
is

   function "*" (Left, Right : in Normal_GF) return Normal_GF
   is
      L : Normal_GF renames Left;
      R : Normal_GF renames Right;

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

      T0, T2, T3, T4, T5,
      T6, T7, T8, T9, T10, T11,
      T12, T13, T14, T15, T16,
      T18, T19, T20, T21, T22, T23,
      T24, T25, T26, T27, T28, T29, T30 : GF64_Any_Limb;

      T1, T17 : GF64_Any_Limb;

      TF0, TF2, TF3,
      TF4, TF5, TF6, TF7,
      TF8, TF9, TF10, TF11,
      TF12, TF13, TF14, TF15 : GF64_Any_Limb;

      TF1 : GF64_Any_Limb;

      C : GF64_Any_Limb;
   begin
      T0 := I64 (L0 * R0);
      pragma Assert (T0 in 0 .. MGFLP);
      T16 := I64 (L15 * R1)  + I64 (L14 * R2)  + I64 (L13 * R3) +
        I64 (L12 * R4)  + I64 (L11 * R5)  + I64 (L10 * R6) +
        I64 (L9  * R7)  + I64 (L8  * R8)  + I64 (L7  * R9) +
        I64 (L6  * R10) + I64 (L5  * R11) + I64 (L4  * R12) +
        I64 (L3  * R13) + I64 (L2  * R14) + I64 (L1  * R15);
      pragma Assert (T16 in 0 .. 15 * MGFLP);
      TF0  := T0  + R2256 * T16;
      pragma Assert (TF0 in 0 .. 571 * MGFLP);
      C := ASR64_16 (TF0);
      pragma Assert (C in 0 .. 37419914);
      TF0 := TF0 mod LM;
      pragma Assert (TF0 in 0 .. LMM1);

      T1 := I64 (L1 * R0) + I64 (L0 * R1);
      pragma Assert (T1 in 0 .. 2 * MGFLP);
      T17 := I64 (L15 * R2)  + I64 (L14 * R3)  + I64 (L13 * R4) +
             I64 (L12 * R5)  + I64 (L11 * R6)  + I64 (L10 * R7) +
             I64 (L9  * R8)  + I64 (L8  * R9)  + I64 (L7  * R10) +
             I64 (L6  * R11) + I64 (L5  * R12) + I64 (L4  * R13) +
             I64 (L3  * R14) + I64 (L2  * R15);
      pragma Assert (T17 in 0 .. 14 * MGFLP);
      TF1  := T1  + R2256 * T17 + C;
      pragma Assert (TF1 in 0 .. 534 * MGFLP + 37419914);
      C := ASR64_16 (TF1);
      pragma Assert (C in 0 .. 34995726);
      TF1 := TF1 mod LM;


      T2 := I64 (L2 * R0) + I64 (L1 * R1) + I64 (L0 * R2);
      pragma Assert (T2 in 0 .. 3 * MGFLP);
      T18 := I64 (L15 * R3)  + I64 (L14 * R4)  + I64 (L13 * R5) +
             I64 (L12 * R6)  + I64 (L11 * R7)  + I64 (L10 * R8) +
             I64 (L9  * R9)  + I64 (L8  * R10) + I64 (L7  * R11) +
             I64 (L6  * R12) + I64 (L5  * R13) + I64 (L4  * R14) +
             I64 (L3  * R15);
      pragma Assert (T18 in 0 .. 13 * MGFLP);
      TF2  := T2  + R2256 * T18 + C;
      pragma Assert (TF2 in 0 .. 497 * MGFLP + 34995726);
      C := ASR64_16 (TF2);
      pragma Assert (C in 0 .. 32570931);
      TF2 := TF2 mod LM;


      T3 := I64 (L3 * R0) + I64 (L2 * R1) + I64 (L1 * R2) +
            I64 (L0 * R3);
      pragma Assert (T3 in 0 .. 4 * MGFLP);
      T19 := I64 (L15 * R4)  + I64 (L14 * R5)  + I64 (L13 * R6) +
             I64 (L12 * R7)  + I64 (L11 * R8)  + I64 (L10 * R9) +
             I64 (L9  * R10) + I64 (L8  * R11) + I64 (L7  * R12) +
             I64 (L6  * R13) + I64 (L5  * R14) + I64 (L4  * R15);
      pragma Assert (T19 in 0 .. 12 * MGFLP);
      TF3  := T3  + R2256 * T19 + C;
      pragma Assert (TF3 in 0 .. 460 * MGFLP + 32570931);
      C := ASR64_16 (TF3);
      pragma Assert (C in 0 .. 30146136);
      TF3 := TF3 mod LM;


      T4 := I64 (L4 * R0) + I64 (L3 * R1) + I64 (L2 * R2) +
            I64 (L1 * R3) + I64 (L0 * R4);
      pragma Assert (T4 in 0 .. 5 * MGFLP);
      T20 := I64 (L15 * R5)  + I64 (L14 * R6)  + I64 (L13 * R7) +
             I64 (L12 * R8)  + I64 (L11 * R9)  + I64 (L10 * R10) +
             I64 (L9  * R11) + I64 (L8  * R12) + I64 (L7  * R13) +
             I64 (L6  * R14) + I64 (L5  * R15);
      pragma Assert (T20 in 0 .. 11 * MGFLP);
      TF4  := T4  + R2256 * T20 + C;
      pragma Assert (TF4 in 0 .. 423 * MGFLP + 30146136);
      C := ASR64_16 (TF4);
      pragma Assert (C in 0 .. 27721341);
      TF4 := TF4 mod LM;


      T5 := I64 (L5 * R0) + I64 (L4 * R1) + I64 (L3 * R2) +
        I64 (L2 * R3) + I64 (L1 * R4) + I64 (L0 * R5);
      T21 := I64 (L15 * R6)  + I64 (L14 * R7)  + I64 (L13 * R8) +
        I64 (L12 * R9)  + I64 (L11 * R10) + I64 (L10 * R11) +
        I64 (L9  * R12) + I64 (L8  * R13) + I64 (L7  * R14) +
        I64 (L6  * R15);
      TF5  := T5  + R2256 * T21 + C;
      pragma Assert (TF5 >= 0);
      pragma Assert (TF5 <= 386 * MGFLP + 27721341);
      C := ASR64_16 (TF5);
      pragma Assert (C >= 0);
      pragma Assert (C <= 25296546);
      TF5 := TF5 mod LM;


      T6 := I64 (L6 * R0) + I64 (L5 * R1) + I64 (L4 * R2) +
        I64 (L3 * R3) + I64 (L2 * R4) + I64 (L1 * R5) +
        I64 (L0 * R6);
      T22 := I64 (L15 * R7)  + I64 (L14 * R8)  + I64 (L13 * R9) +
        I64 (L12 * R10) + I64 (L11 * R11) + I64 (L10 * R12) +
        I64 (L9  * R13) + I64 (L8  * R14) + I64 (L7  * R15);
      TF6  := T6  + R2256 * T22 + C;
      pragma Assert (TF6 >= 0);
      pragma Assert (TF6 <= 349 * MGFLP + 25296546);
      C := ASR64_16 (TF6);
      pragma Assert (C >= 0);
      pragma Assert (C <= 22871751);
      TF6 := TF6 mod LM;


      T7 := I64 (L7 * R0) + I64 (L6 * R1) + I64 (L5 * R2) +
        I64 (L4 * R3) + I64 (L3 * R4) + I64 (L2 * R5) +
        I64 (L1 * R6) + I64 (L0 * R7);
      T23 := I64 (L15 * R8)  + I64 (L14 * R9)  + I64 (L13 * R10) +
        I64 (L12 * R11) + I64 (L11 * R12) + I64 (L10 * R13) +
        I64 (L9  * R14) + I64 (L8  * R15);
      TF7  := T7  + R2256 * T23 + C;
      pragma Assert (TF7 in 0 .. 312 * MGFLP + 22871751);
      C := ASR64_16 (TF7);
      pragma Assert (C in 0 .. 20446956);
      TF7 := TF7 mod LM;


      T8 := I64 (L8 * R0) + I64 (L7 * R1) + I64 (L6 * R2) +
        I64 (L5 * R3) + I64 (L4 * R4) + I64 (L3 * R5) +
        I64 (L2 * R6) + I64 (L1 * R7) + I64 (L0 * R8);
      T24 := I64 (L15 * R9)  + I64 (L14 * R10) + I64 (L13 * R11) +
        I64 (L12 * R12) + I64 (L11 * R13) + I64 (L10 * R14) +
        I64 (L9  * R15);
      TF8  := T8  + R2256 * T24 + C;
      pragma Assert (TF8 in 0 .. 275 * MGFLP + 20446956);
      C := ASR64_16 (TF8);
      pragma Assert (C in 0 .. 18022161);
      TF8 := TF8 mod LM;

      T9 := I64 (L9 * R0) + I64 (L8 * R1) + I64 (L7 * R2) +
        I64 (L6 * R3) + I64 (L5 * R4) + I64 (L4 * R5) +
        I64 (L3 * R6) + I64 (L2 * R7) + I64 (L1 * R8) +
        I64 (L0 * R9);
      T25 := I64 (L15 * R10) + I64 (L14 * R11) + I64 (L13 * R12) +
        I64 (L12 * R13) + I64 (L11 * R14) + I64 (L10 * R15);
      TF9  := T9  + R2256 * T25 + C;
      pragma Assert (TF9 in 0 .. 238 * MGFLP + 18022161);
      C := ASR64_16 (TF9);
      pragma Assert (C in 0 .. 15597366);
      TF9 := TF9 mod LM;


      T10 := I64 (L10 * R0) + I64 (L9 * R1) + I64 (L8 * R2) +
        I64 (L7  * R3) + I64 (L6 * R4) + I64 (L5 * R5) +
        I64 (L4  * R6) + I64 (L3 * R7) + I64 (L2 * R8) +
        I64 (L1  * R9) + I64 (L0 * R10);
      T26 := I64 (L15 * R11) + I64 (L14 * R12) + I64 (L13 * R13) +
        I64 (L12 * R14) + I64 (L11 * R15);
      TF10 := T10 + R2256 * T26 + C;
      pragma Assert (TF10 in 0 .. 201 * MGFLP + 15597366);
      C := ASR64_16 (TF10);
      pragma Assert (C in 0 .. 13172571);
      TF10 := TF10 mod LM;


      T11 := I64 (L11 * R0) + I64 (L10 * R1)  + I64 (L9 * R2) +
        I64 (L8  * R3) + I64 (L7  * R4)  + I64 (L6 * R5) +
        I64 (L5  * R6) + I64 (L4  * R7)  + I64 (L3 * R8) +
        I64 (L2  * R9) + I64 (L1  * R10) + I64 (L0 * R11);
      T27 := I64 (L15 * R12) + I64 (L14 * R13) + I64 (L13 * R14) +
        I64 (L12 * R15);
      TF11 := T11 + R2256 * T27 + C;
      pragma Assert (TF11 in 0 ..  164 * MGFLP + 13172571);
      C := ASR64_16 (TF11);
      pragma Assert (C in 0 .. 10747776);
      TF11 := TF11 mod LM;


      T12 := I64 (L12 * R0) + I64 (L11 * R1)  + I64 (L10 * R2) +
        I64 (L9  * R3) + I64 (L8  * R4)  + I64 (L7  * R5) +
        I64 (L6  * R6) + I64 (L5  * R7)  + I64 (L4  * R8) +
        I64 (L3  * R9) + I64 (L2  * R10) + I64 (L1  * R11) +
        I64 (L0  * R12);
      T28 := I64 (L15 * R13) + I64 (L14 * R14) + I64 (L13 * R15);
      TF12 := T12 + R2256 * T28 + C;
      pragma Assert (TF12 in 0 ..  127 * MGFLP + 10747776);
      C := ASR64_16 (TF12);
      pragma Assert (C in 0 .. 8322981);
      TF12 := TF12 mod LM;


      T13 := I64 (L13 * R0)  + I64 (L12 * R1)  + I64 (L11 * R2) +
        I64 (L10 * R3)  + I64 (L9  * R4)  + I64 (L8  * R5) +
        I64 (L7  * R6)  + I64 (L6  * R7)  + I64 (L5  * R8) +
        I64 (L4  * R9)  + I64 (L3  * R10) + I64 (L2  * R11) +
        I64 (L1  * R12) + I64 (L0  * R13);
      T29 := I64 (L15 * R14) + I64 (L14 * R15);
      TF13 := T13 + R2256 * T29 + C;
      pragma Assert (TF13 in 0 ..  90 * MGFLP + 8322981);
      C := ASR64_16 (TF13);
      pragma Assert (C in 0 .. 5898186);
      TF13 := TF13 mod LM;


      T14 := I64 (L14 * R0)  + I64 (L13 * R1)  + I64 (L12 * R2) +
        I64 (L11 * R3)  + I64 (L10 * R4)  + I64 (L9  * R5) +
        I64 (L8  * R6)  + I64 (L7  * R7)  + I64 (L6  * R8) +
        I64 (L5  * R9)  + I64 (L4  * R10) + I64 (L3  * R11) +
        I64 (L2  * R12) + I64 (L1  * R13) + I64 (L0  * R14);
      T30 := I64 (L15 * R15);
      TF14 := T14 + R2256 * T30 + C;
      pragma Assert (TF14 in 0 ..  53 * MGFLP + 5898186);
      C := ASR64_16 (TF14);
      pragma Assert (C in 0 .. 3473391);
      TF14 := TF14 mod LM;


      T15 := I64 (L15 * R0)  + I64 (L14 * R1)  + I64 (L13 * R2) +
        I64 (L12 * R3)  + I64 (L11 * R4)  + I64 (L10 * R5) +
        I64 (L9  * R6)  + I64 (L8  * R7)  + I64 (L7  * R8) +
        I64 (L6  * R9)  + I64 (L5  * R10) + I64 (L4  * R11) +
        I64 (L3  * R12) + I64 (L2  * R13) + I64 (L1  * R14) +
        I64 (L0  * R15);
      TF15 := T15 + C;
      pragma Assert (TF15 in 0 ..  16 * MGFLP + 3473391);
      C := ASR64_16 (TF15);
      pragma Assert (C in 0 .. 1048596);
      TF15 := TF15 mod LM;

      TF0 := TF0 + R2256 * C;
      pragma Assert (TF0 in 0 .. LMM1 + R2256 * 1048596);

      pragma Assert (TF0 in 0 .. GF32_Any_Limb_Max);
      pragma Assert (TF1 in 0 .. LMM1);
      pragma Assert (TF2 in 0 .. LMM1);
      pragma Assert (TF3 in 0 .. LMM1);
      pragma Assert (TF4 in 0 .. LMM1);
      pragma Assert (TF5 in 0 .. LMM1);
      pragma Assert (TF6 in 0 .. LMM1);
      pragma Assert (TF7 in 0 .. LMM1);
      pragma Assert (TF8 in 0 .. LMM1);
      pragma Assert (TF9 in 0 .. LMM1);
      pragma Assert (TF10 in 0 .. LMM1);
      pragma Assert (TF11 in 0 .. LMM1);
      pragma Assert (TF12 in 0 .. LMM1);
      pragma Assert (TF13 in 0 .. LMM1);
      pragma Assert (TF14 in 0 .. LMM1);
      pragma Assert (TF15 in 0 .. LMM1);
      declare
         O32sn : constant Seminormal_GF :=
           Seminormal_GF'(Seminormal_GF_LSL (TF0),
                          GF32_Normal_Limb (TF1),
                          GF32_Normal_Limb (TF2),
                          GF32_Normal_Limb (TF3),
                          GF32_Normal_Limb (TF4),
                          GF32_Normal_Limb (TF5),
                          GF32_Normal_Limb (TF6),
                          GF32_Normal_Limb (TF7),
                          GF32_Normal_Limb (TF8),
                          GF32_Normal_Limb (TF9),
                          GF32_Normal_Limb (TF10),
                          GF32_Normal_Limb (TF11),
                          GF32_Normal_Limb (TF12),
                          GF32_Normal_Limb (TF13),
                          GF32_Normal_Limb (TF14),
                          GF32_Normal_Limb (TF15));
         O32nn : constant Nearlynormal_GF :=
           Car.Seminormal_To_Nearlynormal (O32sn);
         Result : constant Normal_GF :=
           Car.Nearlynormal_To_Normal (O32nn);
      begin
         return Result;
      end;

   end "*";


end S2;
