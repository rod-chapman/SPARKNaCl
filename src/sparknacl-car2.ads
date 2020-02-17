private package SPARKNaCl.Car2
  with SPARK_Mode => On
is
   --=================================================
   --  Further implementations of the main "Carry"
   --  function, based on Donenfeld's implementation
   --  in WireGuard.
   --
   --  These are for reference, and experimentation
   --  with additional proof techniques.
   --=================================================

   --  Simple translation of Donenfeld's original C code from
   --  WireGuard.  Here for reference as an oracle for testing
   procedure Carry (R : in out GF);



   type Limb_LUT is array (Index_16) of I64 with Ghost;

   --  "UB" = "Upper Bound"

   --  Upperbound on _input_ limbs, as per the definition
   --  of Product_GF
   --  function Limb_UB (I : in Index_16) return I64 is
   --     ((MGFLC - 37 * GF_Any_Limb (I)) * MGFLP);

   --  LnC = "Limb and Carry"
   --  Note: recursive definition!
   --  function LnC_UB (I : in Index_16) return I64 is
   --     (if I = 0 then (Limb_UB (0))
   --               else (Limb_UB (I) + (LnC_UB (I - 1) / 65536)));
   LnC_UB : constant Limb_LUT :=
     (0 => 16#23AFB8A023B#,
      1 => 16#215FE0EFDA0#,
      2 => 16#1F0FE33FFFF#,
      3 => 16#1CBFE58FFFF#,
      4 => 16#1A6FE7DFFFF#,
      5 => 16#181FEA2FFFF#,
      6 => 16#15CFEC7FFFF#,
      7 => 16#137FEECFFFF#,
      8 => 16#112FF11FFFF#,
      9 => 16#EDFF36FFFF#,
      10 => 16#C8FF5BFFFF#,
      11 => 16#A3FF80FFFF#,
      12 => 16#7EFFA5FFFF#,
      13 => 16#59FFCAFFFF#,
      14 => 16#34FFEFFFFF#,
      15 => 16#100014FFFF#) with Ghost;

   --   function Carry_UB (I : in Index_16) return I64 is
   --      (LnC_UB (I) / 65536);
   Carry_UB : constant Limb_LUT :=
     (0 => 16#23AFB8A#,
      1 => 16#215FE0E#,
      2 => 16#1F0FE33#,
      3 => 16#1CBFE58#,
      4 => 16#1A6FE7D#,
      5 => 16#181FEA2#,
      6 => 16#15CFEC7#,
      7 => 16#137FEEC#,
      8 => 16#112FF11#,
      9 => 16#EDFF36#,
      10 => 16#C8FF5B#,
      11 => 16#A3FF80#,
      12 => 16#7EFFA5#,
      13 => 16#59FFCA#,
      14 => 16#34FFEF#,
      15 => 16#100014#) with Ghost;

   --  Distinct named number here so the table above can be "Ghost".
   Carry_UB_15 : constant := 16#100014#;
   subtype New_Seminormal_GF_LSL is I64
     range 0 .. 65535 + 38 * Carry_UB_15;

   --  Limbs 1 though 15 are in 0 .. 65535, but the
   --  Least Significant Limb 0 is in GF_Seminormal_Product_LSL
   subtype New_Seminormal_GF is GF
     with Dynamic_Predicate =>
       (New_Seminormal_GF (0) in New_Seminormal_GF_LSL and
         (for all I in Index_16 range 1 .. 15 =>
           New_Seminormal_GF (I) in GF_Normal_Limb));


   --  Supporting "*"
   function Product_To_Seminormal
    (X : in Product_GF)
       return New_Seminormal_GF
     with Global => null;

end SPARKNaCl.Car2;
