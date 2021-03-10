with SPARKNaCl.PDebug;
with SPARKNaCl.Debug;
with SPARKNaCl.Utils;
with SPARKNaCl.Car;
with Ada.Text_IO; use Ada.Text_IO;
package body SPARKNaCl.Tests
is
   GF_2 : constant Normal_GF := (2, others => 0);

   P : constant Normal_GF := (0      => 16#FFED#,
                              15     => 16#7FFF#,
                              others => 16#FFFF#);

   P_Minus_1 : constant Normal_GF := (0      => 16#FFEC#,
                                      15     => 16#7FFF#,
                                      others => 16#FFFF#);

   P_Plus_1 : constant Normal_GF := (0      => 16#FFEE#,
                                     15     => 16#7FFF#,
                                     others => 16#FFFF#);

   procedure GF_Stress
   is
      A, B, C : Normal_GF;
      C2      : GF32;
      D       : Product_GF;
   begin
      Put_Line ("GF_Stress case 1 - 0 * 0");
      A := (others => 0);
      B := (others => 0);
      C := A * B;
      PDebug.DH16 ("Result is", C);

      Put_Line ("GF_Stress case 2 - FFFF * FFFF");
      A := (others => 16#FFFF#);
      B := (others => 16#FFFF#);
      C := A * B;
      PDebug.DH16 ("Result is", C);

      Put_Line ("GF_Stress case 3 - Seminormal Product GF Max");
      D := (0 => 132_051_011, others => 16#FFFF#);
      C2 := Car.Product_To_Seminormal (D);
      PDebug.DH32 ("Result is", C2);

      Put_Line ("GF_Stress case 4 - Seminormal Product tricky case");
      D := (0 => 131_071, others => 16#FFFF#);
      C2 := Car.Product_To_Seminormal (D);
      PDebug.DH32 ("Result is", C2);
   end GF_Stress;

   procedure Car_Stress
   is
      A    : GF64;
      C    : Product_GF;
      SN   : Seminormal_GF;
      NGF  : Nearlynormal_GF;
      R    : Normal_GF;
   begin
      --  Case 1 - using typed API
      A := (0 .. 14 => 65535, 15 => 65535 + 2**32);
      PDebug.DH64 ("Case 1 - A is", A);
      SN := Car.Product_To_Seminormal (A);
      PDebug.DH32 ("Case 1 - SN is", SN);
      NGF := Car.Seminormal_To_Nearlynormal (SN);
      PDebug.DH32 ("Case 1 - NGF is", NGF);
      R := Car.Nearlynormal_To_Normal (NGF);
      PDebug.DH16 ("Case 1 - R is", R);

      --  Case 2 Upper bounds on all limbs of a Product_GF
      C := (0 => MGFLC * MGFLP,
            1 => (MGFLC - 37 * 1) * MGFLP,
            2 => (MGFLC - 37 * 2) * MGFLP,
            3 => (MGFLC - 37 * 3) * MGFLP,
            4 => (MGFLC - 37 * 4) * MGFLP,
            5 => (MGFLC - 37 * 5) * MGFLP,
            6 => (MGFLC - 37 * 6) * MGFLP,
            7 => (MGFLC - 37 * 7) * MGFLP,
            8 => (MGFLC - 37 * 8) * MGFLP,
            9 => (MGFLC - 37 * 9) * MGFLP,
            10 => (MGFLC - 37 * 10) * MGFLP,
            11 => (MGFLC - 37 * 11) * MGFLP,
            12 => (MGFLC - 37 * 12) * MGFLP,
            13 => (MGFLC - 37 * 13) * MGFLP,
            14 => (MGFLC - 37 * 14) * MGFLP,
            15 => (MGFLC - 37 * 15) * MGFLP);
      PDebug.DH64 ("Case 2 - C is", C);
      SN := Car.Product_To_Seminormal (C);
      PDebug.DH32 ("Case 2 - SN is", SN);
      NGF := Car.Seminormal_To_Nearlynormal (SN);
      PDebug.DH32 ("Case 2 - NGF is", NGF);
      R := Car.Nearlynormal_To_Normal (NGF);
      PDebug.DH16 ("Case 2 - R is", R);


      --  Intermediate (pre-normalization) result of
      --  Square (Normal_GF'(others => 16#FFFF))
      A := (16#23AFB8A023B#,
            16#215FBD40216#,
            16#1F0FC1E01F1#,
            16#1CBFC6801CC#,
            16#1A6FCB201A7#,
            16#181FCFC0182#,
            16#15CFD46015D#,
            16#137FD900138#,
            16#112FDDA0113#,
            16#EDFE2400EE#,
            16#C8FE6E00C9#,
            16#A3FEB800A4#,
            16#7EFF02007F#,
            16#59FF4C005A#,
            16#34FF960035#,
            16#FFFE00010#);
      PDebug.DH64 ("Case 3 - A is", A);
      SN := Car.Product_To_Seminormal (A);
      PDebug.DH32 ("Case 3 - SN is", SN);
      NGF := Car.Seminormal_To_Nearlynormal (SN);
      PDebug.DH32 ("Case 3 - NGF is", NGF);
      R := Car.Nearlynormal_To_Normal (NGF);
      PDebug.DH16 ("Case 3 - R is", R);



   end Car_Stress;

   procedure Diff_Car_Stress

   is
      C : Nearlynormal_GF;
      R : Normal_GF;
   begin
      C := (others => 0);
      PDebug.DH32 ("Case 1 - C is", C);
      R := Car.Nearlynormal_To_Normal (C);
      PDebug.DH16 ("Case 1 - R is", R);

      C := (others => 16#ffff#);
      PDebug.DH32 ("Case 2 - C is", C);
      R := Car.Nearlynormal_To_Normal (C);
      PDebug.DH16 ("Case 2 - R is", R);

      for I in I32 range 65536 .. 65573 loop
         C (0) := I;
         PDebug.DH32 ("Case 3," & I'Img & " C is", C);
         R := Car.Nearlynormal_To_Normal (C);
         PDebug.DH16 ("Case 3 - R is", R);
      end loop;

      C := (others => 0);
      for I in I32 range -38 .. -1 loop
         C (0) := I;
         PDebug.DH32 ("Case 4," & I'Img & " C is", C);
         R := Car.Nearlynormal_To_Normal (C);
         PDebug.DH16 ("Case 4 - R is", R);
      end loop;


   end Diff_Car_Stress;



   procedure Pack_Stress
   is
      A : Normal_GF;
      R : Bytes_32;
      Two_P : constant Normal_GF := P * GF_2;
      Two_P_Minus_1 : constant Normal_GF := Two_P - GF_1;
      Two_P_Plus_1 : constant Normal_GF := Two_P + GF_1;
   begin
      A := (others => 0);
      PDebug.DH16 ("Pack Stress - Case 1 - A is", A);
      R := Utils.Pack_25519 (A);
      Debug.DH ("Pack Stress - Case 1 - R is", R);

      A := (others => 65535);
      PDebug.DH16 ("Pack Stress - Case 2 - A is", A);
      R := Utils.Pack_25519 (A);
      Debug.DH ("Pack Stress - Case 2 - R is", R);

      A := P;
      PDebug.DH16 ("Pack Stress - Case 3 - A is P", A);
      R := Utils.Pack_25519 (A);
      Debug.DH ("Pack Stress - Case 3 - R is", R);

      A := P_Minus_1;
      PDebug.DH16 ("Pack Stress - Case 4 - A is P_Minus_1", A);
      R := Utils.Pack_25519 (A);
      Debug.DH ("Pack Stress - Case 4 - R is", R);

      A := P_Plus_1;
      PDebug.DH16 ("Pack Stress - Case 5 - A is P_Plus_1", A);
      R := Utils.Pack_25519 (A);
      Debug.DH ("Pack Stress - Case 5 - R is", R);

      A := Two_P;
      PDebug.DH16 ("Pack Stress - Case 6 - A is Two_P", A);
      R := Utils.Pack_25519 (A);
      Debug.DH ("Pack Stress - Case 6 - R is", R);

      A := Two_P_Minus_1;
      PDebug.DH16 ("Pack Stress - Case 7 - A is Two_P_Minus_1", A);
      R := Utils.Pack_25519 (A);
      Debug.DH ("Pack Stress - Case 7 - R is", R);

      A := Two_P_Plus_1;
      PDebug.DH16 ("Pack Stress - Case 8 - A is Two_P_Plus_1", A);
      R := Utils.Pack_25519 (A);
      Debug.DH ("Pack Stress - Case 8 - R is", R);

   end Pack_Stress;

end SPARKNaCl.Tests;
