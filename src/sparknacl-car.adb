package body SPARKNaCl.Car
  with SPARK_Mode => On
is
   pragma Warnings (GNATProve, Off, "pragma * ignored (not yet supported)");

   --===============================================
   --  Functions supporting normalization
   --  of GF values following "+", "-" or "*"
   --  operations.
   --
   --  The core algorithm is actually a variant
   --  of that used in the TweetNaCl sources, as
   --  suggested by Jason Donenfeld and used in
   --  WireGuard (See the "Embeddable WG Library"
   --  in the WireGuard sources for full details.)
   --
   --  This algorithm is simpler and avoids the need
   --  for a left-shift of a signed integer
   --  (which is, strictly speaking, an undefined
   --   behaviour in C, so best avoided.)
   --===============================================

   function Nearlynormal_To_Normal
     (X : in Nearlynormal_GF) return Normal_GF
   is
      --  True iff the initial value of X and the current
      --  state of G are necessary and sufficient for Carry = 1 after
      --  the I'th loop iteration
      function Carrying_Plus_One (G : in GF32;
                                  X : in Nearlynormal_GF;
                                  I : in Index_16) return Boolean
      is ((X (0) in LM .. LMM1 + R2256) and --  X (O) will carry +1
            --  ...therefore G (0) will be in 0 .. 37 ...
          (G (0) = X (0) mod LM) and
          (G (0) in 0 .. R2256 - 1) and
            --  ... AND all values of X (K) between 1 and I
            --  are LMM1 and G (K) = (X (K) + Carry) mod LM = 0
          (for all K in Index_16 range 1 .. I =>
             (G (K) = 0 and X (K) = LMM1)))
        with Relaxed_Initialization => G,
             Pre => G (0)'Initialized and
                    (for all K in Index_16 range 1 .. I => G (K)'Initialized);


      --  True iff the initial value of X and the current
      --  state of G are necessary and sufficient for Carry = -1 after
      --  the I'th loop iteration
      function Carrying_Minus_One (G : in GF32;
                                   X : in Nearlynormal_GF;
                                   I : in Index_16) return Boolean
      is ((X (0) in   -R2256 .. -1) and --  X (O) will carry -1
          --  ...therefore G (0) will be in 65498 .. 65535 ...
          (G (0) = X (0) mod LM) and
          (G (0) in (LM - R2256) .. LMM1) and
          --  ... AND all values of X (K) between 1 and I
          --  are 0 and G (K) = (X (K) + Carry) mod LM = LMM1
          (for all K in Index_16 range 1 .. I =>
             (G (K) = LMM1 and X (K) = 0)))
        with Relaxed_Initialization => G,
             Pre => G (0)'Initialized and
                    (for all K in Index_16 range 1 .. I => G (K)'Initialized);

      subtype Carry_T is I32 range -1 .. 1;
      Carry : Carry_T;
      R     : GF32 with Relaxed_Initialization;
   begin
      --  Expand X's subtype predicate
      pragma Assert
        ((X (0) in -R2256 .. LMM1 + R2256) and
           (for all K in Index_16 range 1 .. 15 =>
              (X (K) in GF32_Normal_Limb)));

      --  Carry and normalize limb 0
      Carry := ASR32_16 (X (0));
      R (0) := X (0) mod LM;
      R (1) := X (1) + Carry;

      pragma Assert (R (0)'Initialized);
      pragma Assert (R (0) in GF32_Normal_Limb);
      pragma Assert (R (0) = X (0) mod LM);
      pragma Assert (R (1)'Initialized);
      pragma Assert (R (1) in -1 .. LM);

      --  Establish the crux invariant
      pragma Assert
        ((Carry = 1) = Carrying_Plus_One (R, X, 0));
      pragma Assert
        ((Carry = -1) = Carrying_Minus_One (R, X, 0));

      for I in Index_16 range 1 .. 14 loop
         pragma Loop_Optimize (No_Unroll);
         Carry := ASR32_16 (R (I));
         R (I) := R (I) mod LM;
         R (I + 1) := X (I + 1) + Carry;


         pragma Loop_Invariant
           (for all K in Index_16 range 0 .. I => R (K)'Initialized);
         pragma Loop_Invariant
           (for all K in Index_16 range 0 .. I => (R (K) in GF32_Normal_Limb));
         pragma Loop_Invariant (R (I + 1)'Initialized);
         pragma Loop_Invariant (R (I + 1) in -1 .. LM);
         pragma Loop_Invariant (R (I + 1) = X (I + 1) + Carry);

         --  The crux of the invariant - relate the current value
         --  of Carry after I loop iterations to the _initial_
         --  value of X, and therefore the value of R (0)
         pragma Loop_Invariant
           ((Carry = 1) = Carrying_Plus_One (R, X, I));
         pragma Loop_Invariant
           ((Carry = -1) = Carrying_Minus_One (R, X, I));
      end loop;

      --  Expand loop invariant with I = 14
      pragma Assert (R'Initialized);
      pragma Assert
        (for all K in Index_16 range 0 .. 14 => (R (K) in GF32_Normal_Limb));
      pragma Assert (R (15) in -1 .. LM);
      pragma Assert (R (15) = X (15) + Carry);
      pragma Assert
        ((Carry = 1) = Carrying_Plus_One (R, X, 14));
      pragma Assert
        ((Carry = -1) = Carrying_Minus_One (R, X, 14));

      --  Finally, deal with limb 15
      Carry := ASR32_16 (R (15));
      R (15) := R (15) mod LM;

      pragma Assert
        ((Carry = 1) = Carrying_Plus_One (R, X, 15));
      pragma Assert
        ((Carry = -1) = Carrying_Minus_One (R, X, 15));
      pragma Assert
        (for all K in Index_16 range 0 .. 15 => (R (K) in GF32_Normal_Limb));

      --  At last, we know that:
      --  if Carry = +1, then R (0) in 0 .. 37
      --  if Carry = -1, then R (0) in 65498 .. 65535
      --  if Carry =  0, then it doesn't matter since R (0) in GF32_Normal_Limb
      --  Therefore this multiplication and assignment will never overflow and
      --  R (0) remains in GF32_Normal_Limb. Phew!
      R (0) := R (0) + R2256 * Carry;

      pragma Assert (R (0) in GF32_Normal_Limb);
      return Normal_GF'(0  => U16 (R (0)),
                        1  => U16 (R (1)),
                        2  => U16 (R (2)),
                        3  => U16 (R (3)),
                        4  => U16 (R (4)),
                        5  => U16 (R (5)),
                        6  => U16 (R (6)),
                        7  => U16 (R (7)),
                        8  => U16 (R (8)),
                        9  => U16 (R (9)),
                        10 => U16 (R (10)),
                        11 => U16 (R (11)),
                        12 => U16 (R (12)),
                        13 => U16 (R (13)),
                        14 => U16 (R (14)),
                        15 => U16 (R (15)));
   end Nearlynormal_To_Normal;

end SPARKNaCl.Car;
