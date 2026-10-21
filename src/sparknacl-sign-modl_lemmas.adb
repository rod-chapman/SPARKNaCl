pragma Ada_2022;
package body SPARKNaCl.Sign.ModL_Lemmas
  with SPARK_Mode => On
is
   --  Several lemmas are proved from their contracts alone, so their
   --  formal parameters are not referenced in the body.
   pragma Warnings (Off, "formal parameter * is not referenced");

   procedure Lemma_P_Succ (K : in Pos)
   is
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body", P);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       Big_Value);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       LP);
   begin
      null;
   end Lemma_P_Succ;

   procedure Lemma_LP_Zero (B : in Pos)
   is
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body", P);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       Big_Value);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       LP);
   begin
      null;
   end Lemma_LP_Zero;

   procedure Lemma_LP_Succ (B, M : in Pos)
   is
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body", P);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       Big_Value);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       LP);
   begin
      null;
   end Lemma_LP_Succ;

   procedure Lemma_P_Pos (K : in Pos)
   is
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body", P);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       Big_Value);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       LP);
   begin
      if K > 0 then
         Lemma_P_Pos (K - 1);
      end if;
   end Lemma_P_Pos;

   procedure Lemma_P_Add (A, B : in Pos)
   is
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body", P);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       Big_Value);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       LP);
   begin
      if B > 0 then
         Lemma_P_Add (A, B - 1);
         pragma Assert (P (A + B) = 256 * P (A + B - 1));
         pragma Assert (P (A + B) = 256 * (P (A) * P (B - 1)));
         pragma Assert (P (A + B) = P (A) * (256 * P (B - 1)));
      end if;
   end Lemma_P_Add;

   procedure Lemma_P_Constants
   is
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body", P);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       Big_Value);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       LP);
   begin
      pragma Assert (P (1) = 256);
      pragma Assert (P (2) = 65536);
      pragma Assert (P (3) = 16777216);
      pragma Assert (P (4) = 4294967296);
      pragma Assert (P (5) = 1099511627776);
      pragma Assert (P (6) = 281474976710656);
      pragma Assert (P (7) = 72057594037927936);
      pragma Assert (P (8) = 18446744073709551616);
      pragma Assert (P (9) = 4722366482869645213696);
      pragma Assert (P (10) = 1208925819614629174706176);
      pragma Assert (P (11) = 309485009821345068724781056);
      pragma Assert (P (12) = 79228162514264337593543950336);
      pragma Assert (P (13) = 20282409603651670423947251286016);
      pragma Assert (P (14) = 5192296858534827628530496329220096);
      pragma Assert (P (15) = 1329227995784915872903807060280344576);
      pragma Assert (P (16) = 340282366920938463463374607431768211456);
      Lemma_P_Add (15, 16);
      Lemma_P_Add (16, 16);
   end Lemma_P_Constants;

   procedure Lemma_Value_Update (A, B : in Big_Arr;
                                 J     : in Index_64;
                                 N     : in Pos)
   is
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body", P);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       Big_Value);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       LP);
   begin
      if J = N - 1 then
         Lemma_Value_Prefix (A, B, N - 1);
      else
         Lemma_Value_Update (A, B, J, N - 1);
         pragma Assert (A (N - 1) = B (N - 1));
      end if;
   end Lemma_Value_Update;

   procedure Lemma_Value_Prefix (A, B : in Big_Arr;
                                 N    : in Pos)
   is
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body", P);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       Big_Value);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       LP);
   begin
      if N > 0 then
         Lemma_Value_Prefix (A, B, N - 1);
      end if;
   end Lemma_Value_Prefix;

   procedure Lemma_Value_Zero_Tail (A    : in Big_Arr;
                                    M, N : in Pos)
   is
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body", P);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       Big_Value);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       LP);
   begin
      if N > M then
         Lemma_Value_Zero_Tail (A, M, N - 1);
      end if;
   end Lemma_Value_Zero_Tail;

   procedure Lemma_Value_Bounds (A      : in Big_Arr;
                                 N      : in Pos;
                                 Lo, Hi : in Big_Integer)
   is
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body", P);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       Big_Value);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       LP);
   begin
      if N > 0 then
         Lemma_Value_Bounds (A, N - 1, Lo, Hi);
         Lemma_P_Pos (N - 1);
         pragma Assert (A (N - 1) * P (N - 1) <= Hi * P (N - 1));
         pragma Assert (Lo * P (N - 1) <= A (N - 1) * P (N - 1));
         pragma Assert (P (N) = 256 * P (N - 1));
      end if;
   end Lemma_Value_Bounds;


   procedure Lemma_LP_Scale (B, M : in Pos)
   is
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body", P);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       Big_Value);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       LP);
   begin
      if M > 0 then
         Lemma_LP_Scale (B, M - 1);
         Lemma_P_Add (B, M - 1);
         pragma Assert (LP (B, M) =
                          LP (0, M - 1) * P (B) +
                          L_Arr (M - 1) * (P (B) * P (M - 1)));
         pragma Assert (LP (B, M) =
                          (LP (0, M - 1) + L_Arr (M - 1) * P (M - 1)) * P (B));
      end if;
   end Lemma_LP_Scale;

   procedure Lemma_LP_Delta
   is
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body", P);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       Big_Value);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       LP);
   begin
      pragma Assert (P (0) = 1);
      pragma Assert (LP (0, 1) = 237);
      pragma Assert (P (1) = 256);
      pragma Assert (LP (0, 2) = 54253);
      pragma Assert (P (2) = 65536);
      pragma Assert (LP (0, 3) = 16110573);
      pragma Assert (P (3) = 16777216);
      pragma Assert (LP (0, 4) = 1559614445);
      pragma Assert (P (4) = 4294967296);
      pragma Assert (LP (0, 5) = 113228764141);
      pragma Assert (P (5) = 1099511627776);
      pragma Assert (LP (0, 6) = 108964879913965);
      pragma Assert (P (6) = 281474976710656);
      pragma Assert (LP (0, 7) = 5175514460705773);
      pragma Assert (P (7) = 72057594037927936);
      pragma Assert (LP (0, 8) = 6346243789798364141);
      pragma Assert (P (8) = 18446744073709551616);
      pragma Assert (LP (0, 9) = 3953949475563642409965);
      pragma Assert (P (9) = 4722366482869645213696);
      pragma Assert (LP (0, 10) = 740643120803228295746541);
      pragma Assert (P (10) = 1208925819614629174706176);
      pragma Assert (LP (0, 11) = 299345320565616634448172013);
      pragma Assert (P (11) = 309485009821345068724781056);
      pragma Assert (LP (0, 12) = 50435916911623517767862703085);
      pragma Assert (P (12) = 79228162514264337593543950336);
      pragma Assert (LP (0, 13) = 17639087995078306463534619677677);
      pragma Assert (P (13) = 20282409603651670423947251286016);
      pragma Assert (LP (0, 14) = 5067959079304344242026400189895661);
      pragma Assert (P (14) = 5192296858534827628530496329220096);
      pragma Assert (LP (0, 15) = 1157757861674036077775796585276756973);
      pragma Assert (P (15) = 1329227995784915872903807060280344576);
      pragma Assert (LP (0, 16) = 27742317777372353535851937790883648493);
   end Lemma_LP_Delta;

   procedure Lemma_LP_L
   is
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body", P);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       Big_Value);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       LP);
   begin
      Lemma_LP_Delta;
      Lemma_P_Constants;
      pragma Assert (LP (0, 17) = LP (0, 16));
      pragma Assert (LP (0, 18) = LP (0, 16));
      pragma Assert (LP (0, 19) = LP (0, 16));
      pragma Assert (LP (0, 20) = LP (0, 16));
      pragma Assert (LP (0, 21) = LP (0, 16));
      pragma Assert (LP (0, 22) = LP (0, 16));
      pragma Assert (LP (0, 23) = LP (0, 16));
      pragma Assert (LP (0, 24) = LP (0, 16));
      pragma Assert (LP (0, 25) = LP (0, 16));
      pragma Assert (LP (0, 26) = LP (0, 16));
      pragma Assert (LP (0, 27) = LP (0, 16));
      pragma Assert (LP (0, 28) = LP (0, 16));
      pragma Assert (LP (0, 29) = LP (0, 16));
      pragma Assert (LP (0, 30) = LP (0, 16));
      pragma Assert (LP (0, 31) = LP (0, 16));
      pragma Assert (LP (0, 32) = LP (0, 16) + 16 * P (31));
   end Lemma_LP_L;

   procedure Lemma_Elim (B : in Pos)
   is
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body", P);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       Big_Value);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       LP);
   begin
      Lemma_LP_Scale (B, 16);
      Lemma_LP_Delta;
      Lemma_P_Add (B, 32);
      pragma Assert (P (32) = 256 * P (31));
      pragma Assert (16 * L_Big = 16 * Delta_Big + P (32));
      pragma Assert (16 * LP (B, 16) + P (B + 32) =
                       (16 * Delta_Big + P (32)) * P (B));
   end Lemma_Elim;

   procedure Lemma_Carry_Step (V_Old, V_New : in Big_Integer;
                               X_Old, X_New : in Big_Integer;
                               C_Old, C_New : in Big_Integer;
                               A            : in Big_Integer;
                               J            : in Pos)
   is
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body", P);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       Big_Value);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       LP);
   begin
      pragma Assert (P (J + 1) = 256 * P (J));
      pragma Assert (V_New = V_Old + (C_Old - A - 256 * C_New) * P (J));
      pragma Assert (C_New * P (J + 1) = 256 * C_New * P (J));
   end Lemma_Carry_Step;

   procedure Lemma_Adjust (S, X, LPT, LT, PJ : in Big_Integer)
   is null;

   procedure Lemma_Distrib (S, X, LPT, LT, PJ : in Big_Integer)
   is null;

   procedure Lemma_ASR_8_Mod (X : in I64)
   is
   begin
      if X >= 0 then
         pragma Assert (ASR_8 (X) = X / 256);
      else
         pragma Assert (ASR_8 (X) = ((X + 1) / 256) - 1);
      end if;
   end Lemma_ASR_8_Mod;

   procedure Lemma_Value_Zero (A : in Big_Arr)
   is
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body", P);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       Big_Value);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       LP);
   begin
      null;
   end Lemma_Value_Zero;

   procedure Lemma_Value_Succ (A : in Big_Arr;
                               N : in Pos)
   is
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body", P);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       Big_Value);
      pragma Annotate (GNATprove, Unhide_Info, "Expression_Function_Body",
                       LP);
   begin
      null;
   end Lemma_Value_Succ;

   procedure Lemma_L_Value
     with Post => L_Big = 16 * 1329227995784915872903807060280344576 *
                          340282366920938463463374607431768211456 +
                          27742317777372353535851937790883648493;

   procedure Lemma_L_Value
   is
   begin
      Lemma_P_Constants;
   end Lemma_L_Value;

   procedure Lemma_Mod_Sub_Multiple (A, Q : in Big_Integer)
   is
   begin
      Lemma_L_Value;
   end Lemma_Mod_Sub_Multiple;

   procedure Lemma_Mod_Small (A : in Big_Integer)
   is
   begin
      Lemma_L_Value;
   end Lemma_Mod_Small;

   procedure Lemma_Step1_Range (A : in Big_Arr;
                                Q : in Big_Integer)
   is
      V31 : constant Big_Integer := Big_Value (A, 31);
      Rm  : constant Big_Integer := A (31) - 16 * Q;
   begin
      Lemma_Value_Zero_Tail (A, 32, 64);
      Lemma_Value_Succ (A, 31);
      Lemma_Value_Bounds (A, 31, -129, 128);
      Lemma_P_Constants;
      pragma Assert (Big_Value (A, 64) = V31 + A (31) * P (31));
      pragma Assert (Q * L_Big = 16 * Q * P (31) + Q * Delta_Big);
      pragma Assert (Big_Value (A, 64) - Q * L_Big =
                       V31 + Rm * P (31) - Q * Delta_Big);
      pragma Assert (Rm * P (31) >= 0 and Rm * P (31) <= 15 * P (31));
      pragma Assert (-Q * Delta_Big >= -8 * Delta_Big);
      pragma Assert (-Q * Delta_Big <= 9 * Delta_Big);
      pragma Assert (255 * V31 >= -129 * (P (31) - 1));
      pragma Assert (255 * V31 <= 128 * (P (31) - 1));
   end Lemma_Step1_Range;

   procedure Lemma_Final_Reduce (V0, Q, W1, C1, V2, Rv, C : in Big_Integer)
   is
      A : constant Big_Integer := V0 - Q * L_Big;
   begin
      Lemma_P_Constants;
      Lemma_L_Value;
      pragma Assert (P (32) = 256 * P (31));
      pragma Assert (A > -P (32) and A < P (32));
      pragma Assert (C1 * P (32) = A - W1);
      pragma Assert (C1 * P (32) > -2 * P (32) and C1 * P (32) < P (32));
      pragma Assert (C1 = 0 or C1 = -1);
      if C1 = 0 then
         pragma Assert (A >= 0);
         pragma Assert (V2 = A);
         pragma Assert (C * P (32) = A - Rv);
         pragma Assert (C = 0);
         pragma Assert (Rv = A);
         pragma Assert (Rv < L_Big);
      else
         pragma Assert (A < 0);
         pragma Assert (V2 = A + P (32) + L_Big);
         pragma Assert (A + L_Big >= 0 and A + L_Big < P (32));
         pragma Assert ((C - 1) * P (32) = A + L_Big - Rv);
         pragma Assert (C = 1);
         pragma Assert (Rv = A + L_Big);
         pragma Assert (Rv < L_Big);
      end if;
      pragma Assert (Rv = V0 - (Q + C1) * L_Big);
      Lemma_Mod_Sub_Multiple (V0, Q + C1);
      Lemma_Mod_Small (Rv);
   end Lemma_Final_Reduce;

end SPARKNaCl.Sign.ModL_Lemmas;
