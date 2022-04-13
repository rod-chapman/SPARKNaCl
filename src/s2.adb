with S2.Car;
--  with SPARKNaCl.PDebug;
--  with SPARKNaCl.Debug;
package body S2
  with SPARK_Mode => On
is
   pragma Warnings (Off, "lower bound test optimized away");
   pragma Warnings (Off, "value is known to be in range");
   pragma Warnings (Off, "explicit membership test may be optimized away");
   pragma Warnings (Off, "use 'Valid attribute instead");
   function "*" (Left, Right : in Normal_GF) return Normal_GF
   is
      L : Normal_GF renames Left;
      R : Normal_GF renames Right;

      subtype U32NL is U32 range 0 .. LMM1;
      subtype U64NL is U64 range 0 .. LMM1;

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

      subtype GF64_Natural_Limb is U64 range 0 .. (MGFLC * MGFLP);

      --  Limb Product - a subtype for representing the product
      --  of two normalized GF64 Limbs
      subtype LP   is GF64_Natural_Limb range 0 .. MGFLP;
      subtype LP2  is GF64_Natural_Limb range 0 .. 2 * MGFLP;
      subtype LP3  is GF64_Natural_Limb range 0 .. 3 * MGFLP;
      subtype LP4  is GF64_Natural_Limb range 0 .. 4 * MGFLP;
      subtype LP5  is GF64_Natural_Limb range 0 .. 5 * MGFLP;
      subtype LP6  is GF64_Natural_Limb range 0 .. 6 * MGFLP;
      subtype LP7  is GF64_Natural_Limb range 0 .. 7 * MGFLP;
      subtype LP8  is GF64_Natural_Limb range 0 .. 8 * MGFLP;
      subtype LP9  is GF64_Natural_Limb range 0 .. 9 * MGFLP;
      subtype LP10 is GF64_Natural_Limb range 0 .. 10 * MGFLP;
      subtype LP11 is GF64_Natural_Limb range 0 .. 11 * MGFLP;
      subtype LP12 is GF64_Natural_Limb range 0 .. 12 * MGFLP;
      subtype LP13 is GF64_Natural_Limb range 0 .. 13 * MGFLP;
      subtype LP14 is GF64_Natural_Limb range 0 .. 14 * MGFLP;
      subtype LP15 is GF64_Natural_Limb range 0 .. 15 * MGFLP;
      subtype LP16 is GF64_Natural_Limb range 0 .. 16 * MGFLP;

      T0 : LP;
      T1 : LP2;
      T2 : LP3;
      T3 : LP4;
      T4 : LP5;
      T5 : LP6;
      T6 : LP7;
      T7 : LP8;
      T8 : LP9;
      T9 : LP10;
      T10 : LP11;
      T11 : LP12;
      T12 : LP13;
      T13 : LP14;
      T14 : LP15;
      T15 : LP16;

      T16 : LP15;
      T17 : LP14;
      T18 : LP13;
      T19 : LP12;
      T20 : LP11;
      T21 : LP10;
      T22 : LP9;
      T23 : LP8;
      T24 : LP7;
      T25 : LP6;
      T26 : LP5;
      T27 : LP4;
      T28 : LP3;
      T29 : LP2;
      T30 : LP;


      TF0, TF1, TF2, TF3, TF4,
      TF5, TF6, TF7, TF8, TF9,
      TF10, TF11, TF12, TF13, TF14, TF15  : GF64_Natural_Limb;

      C : GF64_Natural_Limb;
   begin
      T0 := LP (L0 * R0);
      T16 := LP (L15 * R1)  + LP (L14 * R2)  + LP (L13 * R3) +
             LP (L12 * R4)  + LP (L11 * R5)  + LP (L10 * R6) +
             LP (L9  * R7)  + LP (L8  * R8)  + LP (L7  * R9) +
             LP (L6  * R10) + LP (L5  * R11) + LP (L4  * R12) +
             LP (L3  * R13) + LP (L2  * R14) + LP (L1  * R15);
      TF0  := T0  + R2256 * T16;
      pragma Assert (TF0 in GF64_Natural_Limb);
      C := TF0 / LM;
      pragma Assert (C in 0 .. 37419914);
      TF0 := TF0 mod LM;
      pragma Assert_And_Cut (TF0 in U64NL and C in 0 .. 37419914);

      T1 := LP (L1 * R0) + LP (L0 * R1);
      T17 := LP (L15 * R2)  + LP (L14 * R3)  + LP (L13 * R4) +
             LP (L12 * R5)  + LP (L11 * R6)  + LP (L10 * R7) +
             LP (L9  * R8)  + LP (L8  * R9)  + LP (L7  * R10) +
             LP (L6  * R11) + LP (L5  * R12) + LP (L4  * R13) +
             LP (L3  * R14) + LP (L2  * R15);
      TF1  := T1  + R2256 * T17 + C;
      pragma Assert (TF1 in 0 .. 534 * MGFLP + 37419914);
      C := TF1 / LM;
      pragma Assert (C in 0 .. 34995726);
      TF1 := TF1 mod LM;
      pragma Assert_And_Cut (TF0 in U64NL
                             and TF1 in U64NL
                             and C in 0 .. 34995726);

      T2 := LP (L2 * R0) + LP (L1 * R1) + LP (L0 * R2);
      T18 := LP (L15 * R3)  + LP (L14 * R4)  + LP (L13 * R5) +
             LP (L12 * R6)  + LP (L11 * R7)  + LP (L10 * R8) +
             LP (L9  * R9)  + LP (L8  * R10) + LP (L7  * R11) +
             LP (L6  * R12) + LP (L5  * R13) + LP (L4  * R14) +
             LP (L3  * R15);
      TF2  := T2  + R2256 * T18 + C;
      pragma Assert (TF2 in 0 .. 497 * MGFLP + 34995726);
      C := TF2 / LM;
      pragma Assert (C in 0 .. 32570931);
      TF2 := TF2 mod LM;
      pragma Assert_And_Cut (TF0 in U64NL and
                             TF1 in U64NL and
                             TF2 in U64NL and
                             C in 0 .. 32570931);

      T3 := LP (L3 * R0) + LP (L2 * R1) + LP (L1 * R2) +
            LP (L0 * R3);
      T19 := LP (L15 * R4)  + LP (L14 * R5)  + LP (L13 * R6) +
             LP (L12 * R7)  + LP (L11 * R8)  + LP (L10 * R9) +
             LP (L9  * R10) + LP (L8  * R11) + LP (L7  * R12) +
             LP (L6  * R13) + LP (L5  * R14) + LP (L4  * R15);
      TF3  := T3  + R2256 * T19 + C;
      pragma Assert (TF3 in 0 .. 460 * MGFLP + 32570931);
      C := TF3 / LM;
      pragma Assert (C in 0 .. 30146136);
      TF3 := TF3 mod LM;
      pragma Assert_And_Cut (TF0 in U64NL and
                             TF1 in U64NL and
                             TF2 in U64NL and
                             TF3 in U64NL and
                             C in 0 .. 30146136);



      T4 := LP (L4 * R0) + LP (L3 * R1) + LP (L2 * R2) +
            LP (L1 * R3) + LP (L0 * R4);
      T20 := LP (L15 * R5)  + LP (L14 * R6)  + LP (L13 * R7) +
             LP (L12 * R8)  + LP (L11 * R9)  + LP (L10 * R10) +
             LP (L9  * R11) + LP (L8  * R12) + LP (L7  * R13) +
             LP (L6  * R14) + LP (L5  * R15);
      TF4  := T4  + R2256 * T20 + C;
      pragma Assert (TF4 in 0 .. 423 * MGFLP + 30146136);
      C := TF4 / LM;
      pragma Assert (C in 0 .. 27721341);
      TF4 := TF4 mod LM;
      pragma Assert_And_Cut (TF0 in U64NL and
                             TF1 in U64NL and
                             TF2 in U64NL and
                             TF3 in U64NL and
                             TF4 in U64NL and
                             C in 0 .. 27721341);

      T5 := LP (L5 * R0) + LP (L4 * R1) + LP (L3 * R2) +
            LP (L2 * R3) + LP (L1 * R4) + LP (L0 * R5);
      T21 := LP (L15 * R6)  + LP (L14 * R7)  + LP (L13 * R8) +
             LP (L12 * R9)  + LP (L11 * R10) + LP (L10 * R11) +
             LP (L9  * R12) + LP (L8  * R13) + LP (L7  * R14) +
             LP (L6  * R15);
      TF5  := T5  + R2256 * T21 + C;
      pragma Assert (TF5 in 0 .. 386 * MGFLP + 27721341);
      C := TF5 / LM;
      pragma Assert (C in 0 .. 25296546);
      TF5 := TF5 mod LM;
      pragma Assert_And_Cut (TF0 in U64NL and
                             TF1 in U64NL and
                             TF2 in U64NL and
                             TF3 in U64NL and
                             TF4 in U64NL and
                             TF5 in U64NL and
                             C in 0 .. 25296546);

      T6 := LP (L6 * R0) + LP (L5 * R1) + LP (L4 * R2) +
            LP (L3 * R3) + LP (L2 * R4) + LP (L1 * R5) +
            LP (L0 * R6);
      T22 := LP (L15 * R7)  + LP (L14 * R8)  + LP (L13 * R9) +
             LP (L12 * R10) + LP (L11 * R11) + LP (L10 * R12) +
             LP (L9  * R13) + LP (L8  * R14) + LP (L7  * R15);
      TF6  := T6  + R2256 * T22 + C;
      pragma Assert (TF6 in 0 .. 349 * MGFLP + 25296546);
      C := TF6 / LM;
      pragma Assert (C in 0 .. 22871751);
      TF6 := TF6 mod LM;

      pragma Assert_And_Cut (TF0 in U64NL and
                             TF1 in U64NL and
                             TF2 in U64NL and
                             TF3 in U64NL and
                             TF4 in U64NL and
                             TF5 in U64NL and
                             TF6 in U64NL and
                             C in 0 .. 22871751);

      T7 := LP (L7 * R0) + LP (L6 * R1) + LP (L5 * R2) +
            LP (L4 * R3) + LP (L3 * R4) + LP (L2 * R5) +
            LP (L1 * R6) + LP (L0 * R7);
      T23 := LP (L15 * R8)  + LP (L14 * R9)  + LP (L13 * R10) +
             LP (L12 * R11) + LP (L11 * R12) + LP (L10 * R13) +
             LP (L9  * R14) + LP (L8  * R15);
      TF7  := T7  + R2256 * T23 + C;
      pragma Assert (TF7 in 0 .. 312 * MGFLP + 22871751);
      C := TF7 / LM;
      pragma Assert (C in 0 .. 20446956);
      TF7 := TF7 mod LM;

      pragma Assert_And_Cut (TF0 in U64NL and
                             TF1 in U64NL and
                             TF2 in U64NL and
                             TF3 in U64NL and
                             TF4 in U64NL and
                             TF5 in U64NL and
                             TF6 in U64NL and
                             TF7 in U64NL and
                             C in 0 .. 20446956);


      T8 := LP (L8 * R0) + LP (L7 * R1) + LP (L6 * R2) +
            LP (L5 * R3) + LP (L4 * R4) + LP (L3 * R5) +
            LP (L2 * R6) + LP (L1 * R7) + LP (L0 * R8);
      T24 := LP (L15 * R9)  + LP (L14 * R10) + LP (L13 * R11) +
             LP (L12 * R12) + LP (L11 * R13) + LP (L10 * R14) +
             LP (L9  * R15);
      TF8  := T8  + R2256 * T24 + C;
      pragma Assert (TF8 in 0 .. 275 * MGFLP + 20446956);
      C := TF8 / LM;
      pragma Assert (C in 0 .. 18022161);
      TF8 := TF8 mod LM;

      pragma Assert_And_Cut (TF0 in U64NL and
                             TF1 in U64NL and
                             TF2 in U64NL and
                             TF3 in U64NL and
                             TF4 in U64NL and
                             TF5 in U64NL and
                             TF6 in U64NL and
                             TF7 in U64NL and
                             TF8 in U64NL and
                             C in 0 .. 18022161);


      T9 := LP (L9 * R0) + LP (L8 * R1) + LP (L7 * R2) +
        LP (L6 * R3) + LP (L5 * R4) + LP (L4 * R5) +
        LP (L3 * R6) + LP (L2 * R7) + LP (L1 * R8) +
        LP (L0 * R9);
      T25 := LP (L15 * R10) + LP (L14 * R11) + LP (L13 * R12) +
        LP (L12 * R13) + LP (L11 * R14) + LP (L10 * R15);
      TF9  := T9  + R2256 * T25 + C;
      pragma Assert (TF9 in 0 .. 238 * MGFLP + 18022161);
      C := TF9 / LM;
      pragma Assert (C in 0 .. 15597366);
      TF9 := TF9 mod LM;

      pragma Assert_And_Cut (TF0 in U64NL and
                             TF1 in U64NL and
                             TF2 in U64NL and
                             TF3 in U64NL and
                             TF4 in U64NL and
                             TF5 in U64NL and
                             TF6 in U64NL and
                             TF7 in U64NL and
                             TF8 in U64NL and
                             TF9 in U64NL and
                             C in 0 .. 15597366);

      T10 := LP (L10 * R0) + LP (L9 * R1) + LP (L8 * R2) +
        LP (L7  * R3) + LP (L6 * R4) + LP (L5 * R5) +
        LP (L4  * R6) + LP (L3 * R7) + LP (L2 * R8) +
        LP (L1  * R9) + LP (L0 * R10);
      T26 := LP (L15 * R11) + LP (L14 * R12) + LP (L13 * R13) +
        LP (L12 * R14) + LP (L11 * R15);
      TF10 := T10 + R2256 * T26 + C;
      pragma Assert (TF10 in 0 .. 201 * MGFLP + 15597366);
      C := TF10 / LM;
      pragma Assert (C in 0 .. 13172571);
      TF10 := TF10 mod LM;

      pragma Assert_And_Cut (TF0 in U64NL and
                             TF1 in U64NL and
                             TF2 in U64NL and
                             TF3 in U64NL and
                             TF4 in U64NL and
                             TF5 in U64NL and
                             TF6 in U64NL and
                             TF7 in U64NL and
                             TF8 in U64NL and
                             TF9 in U64NL and
                             TF10 in U64NL and
                             C in 0 .. 13172571);

      T11 := LP (L11 * R0) + LP (L10 * R1)  + LP (L9 * R2) +
        LP (L8  * R3) + LP (L7  * R4)  + LP (L6 * R5) +
        LP (L5  * R6) + LP (L4  * R7)  + LP (L3 * R8) +
        LP (L2  * R9) + LP (L1  * R10) + LP (L0 * R11);
      T27 := LP (L15 * R12) + LP (L14 * R13) + LP (L13 * R14) +
        LP (L12 * R15);
      TF11 := T11 + R2256 * T27 + C;
      pragma Assert (TF11 in 0 ..  164 * MGFLP + 13172571);
      C := TF11 / LM;
      pragma Assert (C in 0 .. 10747776);
      TF11 := TF11 mod LM;

      pragma Assert_And_Cut (TF0 in U64NL and
                             TF1 in U64NL and
                             TF2 in U64NL and
                             TF3 in U64NL and
                             TF4 in U64NL and
                             TF5 in U64NL and
                             TF6 in U64NL and
                             TF7 in U64NL and
                             TF8 in U64NL and
                             TF9 in U64NL and
                             TF10 in U64NL and
                             TF11 in U64NL and
                             C in 0 .. 10747776);


      T12 := LP (L12 * R0) + LP (L11 * R1)  + LP (L10 * R2) +
        LP (L9  * R3) + LP (L8  * R4)  + LP (L7  * R5) +
        LP (L6  * R6) + LP (L5  * R7)  + LP (L4  * R8) +
        LP (L3  * R9) + LP (L2  * R10) + LP (L1  * R11) +
        LP (L0  * R12);
      T28 := LP (L15 * R13) + LP (L14 * R14) + LP (L13 * R15);
      TF12 := T12 + R2256 * T28 + C;
      pragma Assert (TF12 in 0 ..  127 * MGFLP + 10747776);
      C := TF12 / LM;
      pragma Assert (C in 0 .. 8322981);
      TF12 := TF12 mod LM;

      pragma Assert_And_Cut (TF0 in U64NL and
                             TF1 in U64NL and
                             TF2 in U64NL and
                             TF3 in U64NL and
                             TF4 in U64NL and
                             TF5 in U64NL and
                             TF6 in U64NL and
                             TF7 in U64NL and
                             TF8 in U64NL and
                             TF9 in U64NL and
                             TF10 in U64NL and
                             TF11 in U64NL and
                             TF12 in U64NL and
                             C in 0 .. 8322981);


      T13 := LP (L13 * R0)  + LP (L12 * R1)  + LP (L11 * R2) +
        LP (L10 * R3)  + LP (L9  * R4)  + LP (L8  * R5) +
        LP (L7  * R6)  + LP (L6  * R7)  + LP (L5  * R8) +
        LP (L4  * R9)  + LP (L3  * R10) + LP (L2  * R11) +
        LP (L1  * R12) + LP (L0  * R13);
      T29 := LP (L15 * R14) + LP (L14 * R15);
      TF13 := T13 + R2256 * T29 + C;
      pragma Assert (TF13 in 0 ..  90 * MGFLP + 8322981);
      C := TF13 / LM;
      pragma Assert (C in 0 .. 5898186);
      TF13 := TF13 mod LM;

      pragma Assert_And_Cut (TF0 in U64NL and
                             TF1 in U64NL and
                             TF2 in U64NL and
                             TF3 in U64NL and
                             TF4 in U64NL and
                             TF5 in U64NL and
                             TF6 in U64NL and
                             TF7 in U64NL and
                             TF8 in U64NL and
                             TF9 in U64NL and
                             TF10 in U64NL and
                             TF11 in U64NL and
                             TF12 in U64NL and
                             TF13 in U64NL and
                             C in 0 .. 5898186);

      T14 := LP (L14 * R0)  + LP (L13 * R1)  + LP (L12 * R2) +
        LP (L11 * R3)  + LP (L10 * R4)  + LP (L9  * R5) +
        LP (L8  * R6)  + LP (L7  * R7)  + LP (L6  * R8) +
        LP (L5  * R9)  + LP (L4  * R10) + LP (L3  * R11) +
        LP (L2  * R12) + LP (L1  * R13) + LP (L0  * R14);
      T30 := LP (L15 * R15);
      TF14 := T14 + R2256 * T30 + C;
      pragma Assert (TF14 in 0 ..  53 * MGFLP + 5898186);
      C := TF14 / LM;
      pragma Assert (C in 0 .. 3473391);
      TF14 := TF14 mod LM;

      pragma Assert_And_Cut (TF0 in U64NL and
                             TF1 in U64NL and
                             TF2 in U64NL and
                             TF3 in U64NL and
                             TF4 in U64NL and
                             TF5 in U64NL and
                             TF6 in U64NL and
                             TF7 in U64NL and
                             TF8 in U64NL and
                             TF9 in U64NL and
                             TF10 in U64NL and
                             TF11 in U64NL and
                             TF12 in U64NL and
                             TF13 in U64NL and
                             TF14 in U64NL and
                             C in 0 .. 3473391);

      T15 := LP (L15 * R0)  + LP (L14 * R1)  + LP (L13 * R2) +
             LP (L12 * R3)  + LP (L11 * R4)  + LP (L10 * R5) +
             LP (L9  * R6)  + LP (L8  * R7)  + LP (L7  * R8) +
             LP (L6  * R9)  + LP (L5  * R10) + LP (L4  * R11) +
             LP (L3  * R12) + LP (L2  * R13) + LP (L1  * R14) +
             LP (L0  * R15);
      TF15 := T15 + C;
      pragma Assert (TF15 in 0 ..  16 * MGFLP + 3473391);
      C := TF15 / LM;
      pragma Assert (C in 0 .. 1048596);
      TF15 := TF15 mod LM;

      pragma Assert_And_Cut (TF0 in U64NL and
                             TF1 in U64NL and
                             TF2 in U64NL and
                             TF3 in U64NL and
                             TF4 in U64NL and
                             TF5 in U64NL and
                             TF6 in U64NL and
                             TF7 in U64NL and
                             TF8 in U64NL and
                             TF9 in U64NL and
                             TF10 in U64NL and
                             TF11 in U64NL and
                             TF12 in U64NL and
                             TF13 in U64NL and
                             TF14 in U64NL and
                             TF15 in U64NL and
                             C in 0 .. 1048596);

      TF0 := TF0 + R2256 * C;
      pragma Assert (TF0 in 0 .. LMM1 + R2256 * 1048596);
      pragma Assert (TF0 in 0 .. GF32_Any_Limb_Max);

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
