--  Ghost model and general lemmas for the functional correctness proof
--  of SPARKNaCl.Sign.ModL.
--
--  A sequence of up to 64 limbs, each with weight 256**K, is modelled as
--  a Big_Arr (an array of Big_Integer), and its value as Big_Value (A, N),
--  the sum of A (K) * 256**K for K in 0 .. N - 1.
--
--  Everything here is at assertion level SPARKlib_Logic, which depends
--  on Static, so none of it is ever compiled into executable code.
pragma Ada_2022;
with SPARK.Big_Integers; use SPARK.Big_Integers;
private package SPARKNaCl.Sign.ModL_Lemmas
  with Pure,
       SPARK_Mode => On,
       Ghost      => SPARKlib_Logic
is
   package I64_Conv is new Signed_Conversions (Int => I64);

   function To_Big (X : in I64) return Big_Integer
     renames I64_Conv.To_Big_Integer;

   --  Number of limbs, or a limb position, in the range 0 .. 64
   subtype Pos is I32 range 0 .. 64;

   type Big_Arr is array (Index_64) of Big_Integer;

   --  The bodies of the recursive functions P, Big_Value and LP below are
   --  hidden from proof by default (Hide_Info), so that their definitions
   --  are not unfolded in every verification condition of the code that
   --  uses them. Callers use the lemmas below instead.

   --  P (K) = 256**K
   function P (K : in Pos) return Big_Integer
   is (if K = 0 then 1 else 256 * P (K - 1))
     with Subprogram_Variant => (Decreases => K),
          Annotate => (GNATprove, Hide_Info, "Expression_Function_Body");

   --  Big_Value (A, N) = Sum (K in 0 .. N - 1) of A (K) * 256**K
   function Big_Value (A : in Big_Arr;
                   N : in Pos) return Big_Integer
   is (if N = 0 then 0 else Big_Value (A, N - 1) + A (N - 1) * P (N - 1))
     with Subprogram_Variant => (Decreases => N),
          Annotate => (GNATprove, Hide_Info, "Expression_Function_Body");

   function To_Big_Arr (X : in I64_Seq_64) return Big_Arr
   is [for K in Index_64 => To_Big (X (K))];

   --  A Bytes_32 is modelled with zeroes in limbs 32 .. 63
   function To_Big_Arr (R : in Bytes_32) return Big_Arr
   is [for K in Index_64 =>
         (if K <= 31 then To_Big (I64 (R (K))) else 0)];

   function Value (X : in I64_Seq_64) return Big_Integer
   is (Big_Value (To_Big_Arr (X), 64));

   function Value (R : in Bytes_32) return Big_Integer
   is (Big_Value (To_Big_Arr (R), 32));

   --  The low 125 bits of L, called "D" in the comment in the body of
   --  SPARKNaCl.Sign, and equal to the value of limbs L (0 .. 15) of the
   --  table L there. D = 16#14def9dea2f79cd65812631a5cf5d3ed#
   function Delta_Big return Big_Integer
   is (27742317777372353535851937790883648493);

   --  L = 2**252 + D = 16 * 256**31 + D, the order of the base point.
   --  Written as a constant expression (256**15 * 256**16 = 256**31) so
   --  that its value, and so L_Big /= 0, is known without unfolding P.
   function L_Big return Big_Integer
   is (16 * 1329227995784915872903807060280344576 *
            340282366920938463463374607431768211456 +
       27742317777372353535851937790883648493);

   --------------------------------------------------------------
   --  Lemmas on P
   --------------------------------------------------------------

   procedure Lemma_P_Succ (K : in Pos)
     with Pre  => K < 64,
          Post => P (K + 1) = 256 * P (K);

   procedure Lemma_P_Pos (K : in Pos)
     with Post => P (K) > 0,
          Subprogram_Variant => (Decreases => K);

   procedure Lemma_P_Add (A, B : in Pos)
     with Pre  => A + B <= 64,
          Post => P (A + B) = P (A) * P (B),
          Subprogram_Variant => (Decreases => B);

   --  Constant values of P used in the proof
   procedure Lemma_P_Constants
     with Post =>
       P (15) = 1329227995784915872903807060280344576 and
       P (16) = 340282366920938463463374607431768211456 and
       P (31) = 1329227995784915872903807060280344576 *
                340282366920938463463374607431768211456 and
       P (32) = 340282366920938463463374607431768211456 *
                340282366920938463463374607431768211456;

   --------------------------------------------------------------
   --  Lemmas on Big_Value
   --------------------------------------------------------------

   --  Changing a single limb J < N changes Big_Value (A, N) by the
   --  difference times 256**J
   procedure Lemma_Value_Update (A, B : in Big_Arr;
                                 J     : in Index_64;
                                 N     : in Pos)
     with Pre  => J < N and
                  (for all K in Index_64 => (if K /= J then A (K) = B (K))),
          Post => Big_Value (B, N) =
                    Big_Value (A, N) + (B (J) - A (J)) * P (J),
          Subprogram_Variant => (Decreases => N);

   procedure Lemma_Value_Zero (A : in Big_Arr)
     with Post => Big_Value (A, 0) = 0;

   procedure Lemma_Value_Succ (A : in Big_Arr;
                               N : in Pos)
     with Pre  => N < 64,
          Post => Big_Value (A, N + 1) = Big_Value (A, N) + A (N) * P (N);

   --  Big_Value (A, N) depends only on A (0 .. N - 1)
   procedure Lemma_Value_Prefix (A, B : in Big_Arr;
                                 N    : in Pos)
     with Pre  => (for all K in Index_64 => (if K < N then A (K) = B (K))),
          Post => Big_Value (A, N) = Big_Value (B, N),
          Subprogram_Variant => (Decreases => N);

   --  Zero limbs M .. N - 1 contribute nothing
   procedure Lemma_Value_Zero_Tail (A    : in Big_Arr;
                                    M, N : in Pos)
     with Pre  => M <= N and
                  (for all K in Index_64 =>
                     (if K in M .. N - 1 then A (K) = 0)),
          Post => Big_Value (A, N) = Big_Value (A, M),
          Subprogram_Variant => (Decreases => N);

   --  If every limb below N is in Lo .. Hi, with Lo <= 0 <= Hi, then
   --    Lo * (256**N - 1) <= 255 * Big_Value (A, N) <= Hi * (256**N - 1)
   procedure Lemma_Value_Bounds (A      : in Big_Arr;
                                 N      : in Pos;
                                 Lo, Hi : in Big_Integer)
     with Pre  => Lo <= 0 and 0 <= Hi and
                  (for all K in Index_64 =>
                     (if K < N then A (K) >= Lo and A (K) <= Hi)),
          Post => Lo * (P (N) - 1) <= 255 * Big_Value (A, N) and
                  255 * Big_Value (A, N) <= Hi * (P (N) - 1),
          Subprogram_Variant => (Decreases => N);

   --------------------------------------------------------------
   --  Model of the table L in the body of SPARKNaCl.Sign
   --------------------------------------------------------------

   --  The 32 radix 2**8 limbs of L, with zeroes in limbs 32 .. 63.
   --  Limbs 0 .. 15 hold D, limbs 16 .. 30 are zero and limb 31 is 16.
   --  (Decimal literals are used here as GNATprove does not accept based
   --  literals for Big_Integer.)
   function L_Arr return Big_Arr
   is [0  => 237, 1  => 211, 2  => 245, 3  =>  92,
       4  =>  26, 5  =>  99, 6  =>  18, 7  =>  88,
       8  => 214, 9  => 156, 10 => 247, 11 => 162,
       12 => 222, 13 => 249, 14 => 222, 15 =>  20,
       31 => 16, others => 0];

   --  LP (B, M) = Sum (T in 0 .. M - 1) of L (T) * 256**(B + T),
   --  that is the first M limbs of L, shifted up by B limbs.
   function LP (B, M : in Pos) return Big_Integer
   is (if M = 0 then 0 else LP (B, M - 1) + L_Arr (M - 1) * P (B + M - 1))
     with Pre                => M <= 32 and B + M <= 64,
          Subprogram_Variant => (Decreases => M),
          Annotate => (GNATprove, Hide_Info, "Expression_Function_Body");

   procedure Lemma_LP_Zero (B : in Pos)
     with Post => LP (B, 0) = 0;

   procedure Lemma_LP_Succ (B, M : in Pos)
     with Pre  => M < 32 and B + M < 64,
          Post => LP (B, M + 1) = LP (B, M) + L_Arr (M) * P (B + M);

   procedure Lemma_LP_Scale (B, M : in Pos)
     with Pre  => M <= 32 and B + M <= 64,
          Post => LP (B, M) = LP (0, M) * P (B),
          Subprogram_Variant => (Decreases => M);

   procedure Lemma_LP_Delta
     with Post => LP (0, 16) = Delta_Big;

   procedure Lemma_LP_L
     with Post => LP (0, 32) = L_Big;

   --  The identity behind the elimination of a limb: since
   --  16 * L = 2**256 + 16 * D, subtracting 16 * L * 256**B is the same
   --  as subtracting 16 * D * 256**B and 256**(B + 32).
   procedure Lemma_Elim (B : in Pos)
     with Pre  => B <= 32,
          Post => 16 * LP (B, 16) + P (B + 32) = 16 * L_Big * P (B);

   --------------------------------------------------------------
   --  Algebra of a single carry-propagation step
   --------------------------------------------------------------

   --  Limb J changes from X_Old to X_New = X_Old + C_Old - A - 256 * C_New
   --  where C_Old is the carry in, A is a subtracted adjustment, and
   --  C_New is the carry out. Then the value plus the pending carry
   --  decreases by exactly A * 256**J.
   procedure Lemma_Carry_Step (V_Old, V_New : in Big_Integer;
                               X_Old, X_New : in Big_Integer;
                               C_Old, C_New : in Big_Integer;
                               A            : in Big_Integer;
                               J            : in Pos)
     with Pre  => J < 64 and
                  V_New = V_Old + (X_New - X_Old) * P (J) and
                  X_New - X_Old = C_Old - A - 256 * C_New,
          Post => V_New + C_New * P (J + 1) =
                  V_Old + C_Old * P (J) - A * P (J);

   --  Ring identity used to extend the subtracted multiple of L by one
   --  more limb
   procedure Lemma_Adjust (S, X, LPT, LT, PJ : in Big_Integer)
     with Post => S - 16 * X * LPT - (16 * LT) * X * PJ =
                  S - 16 * X * (LPT + LT * PJ);

   --  The same identity without the factor 16
   procedure Lemma_Distrib (S, X, LPT, LT, PJ : in Big_Integer)
     with Post => S - X * LPT - (X * LT) * PJ = S - X * (LPT + LT * PJ);

   --  For the floor carries in Finalize: X mod 256 is X less 256 times
   --  the carry ASR_8 (X)
   procedure Lemma_ASR_8_Mod (X : in I64)
     with Pre  => X in -2**50 .. 2**50,
          Post => X mod 256 = X - 256 * ASR_8 (X);

   --------------------------------------------------------------
   --  Lemmas on mod L
   --------------------------------------------------------------

   procedure Lemma_Mod_Sub_Multiple (A, Q : in Big_Integer)
     with Post => (A - Q * L_Big) mod L_Big = A mod L_Big;

   procedure Lemma_Mod_Small (A : in Big_Integer)
     with Pre  => 0 <= A and A < L_Big,
          Post => A mod L_Big = A;

   --  Bound on the value at the end of Step 1 of Finalize in the body of
   --  SPARKNaCl.Sign. On entry, limbs 0 .. 30 are in PRL, limb 31 is
   --  16 * Q + (0 .. 15) with Q = XL (31) / 16 in -9 .. 8, and the rest
   --  are zero. Subtracting Q * L leaves a value in
   --  -2**248 - 9 * D .. 16 * 2**248.
   procedure Lemma_Step1_Range (A : in Big_Arr;
                                Q : in Big_Integer)
     with Pre  => (for all K in Index_64 =>
                     (if K < 31 then A (K) >= -129 and A (K) <= 128)) and
                  A (31) - 16 * Q >= 0 and A (31) - 16 * Q <= 15 and
                  Q >= -9 and Q <= 8 and
                  (for all K in Index_64 => (if K >= 32 then A (K) = 0)),
          Post => Big_Value (A, 64) - Q * L_Big > -P (31) - 9 * Delta_Big and
                  Big_Value (A, 64) - Q * L_Big < 16 * P (31);

   --  The arithmetic at the heart of Finalize in the body of
   --  SPARKNaCl.Sign. Let A = V0 - Q * L, where Q = XL (31) / 16 on entry
   --  to Finalize.
   --    Step 1 leaves W1 in 0 .. 2**256 - 1 with carry C1 out of limb 31:
   --      W1 + C1 * 2**256 = A
   --    Step 2 subtracts C1 * L, giving V2
   --    Step 3 leaves the result Rv in 0 .. 2**256 - 1 with carry C out
   --    of limb 31: Rv + C * 2**256 = V2
   --  Because A is known to be in -2**248 - 9 * D .. 16 * 2**248, C1 is
   --  -1 or 0, C = -C1, and Rv = V0 - (Q + C1) * L is in 0 .. L - 1.
   procedure Lemma_Final_Reduce (V0, Q, W1, C1, V2, Rv, C : in Big_Integer)
     with Pre  => V0 - Q * L_Big > -P (31) - 9 * Delta_Big and
                  V0 - Q * L_Big < 16 * P (31) and
                  W1 >= 0 and W1 < P (32) and
                  W1 + C1 * P (32) = V0 - Q * L_Big and
                  V2 = W1 - C1 * L_Big and
                  Rv >= 0 and Rv < P (32) and
                  Rv + C * P (32) = V2,
          Post => Rv = V0 mod L_Big;

end SPARKNaCl.Sign.ModL_Lemmas;
