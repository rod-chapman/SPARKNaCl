--  with SPARKNaCl.PDebug;
--  with SPARKNaCl.Debug;
package body SPARKNaCl.Car
  with SPARK_Mode => On
is

   function Product_To_Seminormal (X : in Unnormalized_GF_Product)
                                      return Seminormal_Product_GF
   is
      subtype Temp_GF is GF
        with Dynamic_Predicate =>
          (for all I in Index_16 =>
             Temp_GF (I) >= 0 and Temp_GF (I) <= MGFLC * MGFLP);

      subtype Carry_Adjustment is I64 range 0 .. (MGFLC * MGFLP) / 65536;
      Carry : Carry_Adjustment;
      O     : Temp_GF;
   begin
      O := X;
      for I in Index_16 range 0 .. 14 loop
         Carry := ASR_16 (O (I));

         pragma Assert
           (X (I + 1) <= (MGFLC - 37 * GF_Any_Limb (I + 1)) * MGFLP);
         pragma Assert
           (X (I) <= (MGFLC - 37 * GF_Any_Limb (I)) * MGFLP);
         pragma Assert (O (I + 1) = X (I + 1));

         O (I + 1) := O (I + 1) + Carry;
         O (I) := O (I) mod 65536;

         pragma Loop_Invariant
           (for all K in Index_16 range 0 .. I => (O (K) in GF_Normal_Limb));
         pragma Loop_Invariant (O (I + 1) >= 0);
         pragma Loop_Invariant
           (O (I + 1) <= (MGFLC - 37 * GF_Any_Limb (I)) * MGFLP);
         pragma Loop_Invariant
           (for all K in Index_16 range I + 2 .. 15 => O (K) = X (K));

      end loop;

      --  Substitute I = 14 into the above loop invariant
      --  and simplify to yield:
      pragma Assert
        (for all K in Index_16 range 0 .. 14 => (O (K) in GF_Normal_Limb));
      pragma Assert (O (15) in 0 .. 53 * MGFLP);

      Carry := ASR_16 (O (15));

      pragma Assert (Carry <= ((53 * MGFLP) / 65536));

      O (0) := O (0) + 38 * Carry;

      pragma Assert (O (0) in GF_Seminormal_Product_LSL);

      O (15) := O (15) mod 65536;

      return Seminormal_Product_GF (O);
   end Product_To_Seminormal;

   function Seminormal_Product_To_Nearlynormal
     (X : in Seminormal_Product_GF)
       return Nearlynormal_GF
   is
      subtype First_Carry_T is I64 range
        0 .. GF_Seminormal_Product_LSL'Last / 65536;
      First_Carry : First_Carry_T;

      subtype Later_Carry_T is I64 range 0 .. 1;
      Carry : Later_Carry_T;

      subtype Temp_GF is GF
        with Dynamic_Predicate =>
        (Temp_GF (0) in GF_Seminormal_Product_LSL and
           (for all I in Index_16 range 1 .. 15 =>
              Temp_GF (I) in 0 .. GF_Normal_Limb'Last + First_Carry_T'Last));
      O : Temp_GF;

   begin
      O := X;

      First_Carry := ASR_16 (O (0));
      O (1) := O (1) + First_Carry;
      O (0) := O (0) mod 65536;

      pragma Assert (O (0) in GF_Normal_Limb);
      pragma Assert (O (1) in 0 .. GF_Normal_Limb'Last + First_Carry_T'Last);
      pragma Assert
        (for all K in Index_16 range 2 .. 15 => O (K) = X (K));

      for I in Index_16 range 1 .. 14 loop
         Carry := ASR_16 (O (I));
         O (I + 1) := O (I + 1) + Carry;
         O (I) := O (I) mod 65536;

         pragma Loop_Invariant
           (for all K in Index_16 range 0 .. I => (O (K) in GF_Normal_Limb));
         pragma Loop_Invariant (O (I + 1) in 0 .. 65536);
         pragma Loop_Invariant
           (for all K in Index_16 range I + 2 .. 15 => O (K) = X (K));

      end loop;

      pragma Assert
        (for all K in Index_16 range 0 .. 14 => (O (K) in GF_Normal_Limb));
      pragma Assert (O (15) in 0 .. 65536);

      Carry := ASR_16 (O (15));

      O (0) := O (0) + 38 * Carry;
      O (15) := O (15) mod 65536;

      return Nearlynormal_GF (O);
   end Seminormal_Product_To_Nearlynormal;


   function Summation_To_Nearlynormal
     (X : in Summation_GF)
       return Nearlynormal_GF
   is
      subtype Carry_T is I64 range 0 .. 1;
      Carry : Carry_T;

      subtype Temp_GF is GF
        with Dynamic_Predicate =>
          (for all I in Index_16 range 0 .. 15 =>
            Temp_GF (I) in 0 .. GF_Summation_Limb'Last + 1);
      O : Temp_GF;
   begin
      O := X;

      Carry := ASR_16 (O (0));
      O (1) := O (1) + Carry;
      O (0) := O (0) mod 65536;

      pragma Assert (O (0) in GF_Normal_Limb);
      pragma Assert (O (1) in 0 .. GF_Summation_Limb'Last + 1);
      pragma Assert
        (for all K in Index_16 range 2 .. 15 => O (K) = X (K));

      for I in Index_16 range 1 .. 14 loop
         Carry := ASR_16 (O (I));
         O (I + 1) := O (I + 1) + Carry;
         O (I) := O (I) mod 65536;

         pragma Loop_Invariant
           (for all K in Index_16 range 0 .. I => (O (K) in GF_Normal_Limb));
         pragma Loop_Invariant (O (I + 1) in 0 .. GF_Summation_Limb'Last + 1);
         pragma Loop_Invariant
           (for all K in Index_16 range I + 2 .. 15 => O (K) = X (K));

      end loop;

      pragma Assert
        (for all K in Index_16 range 0 .. 14 => (O (K) in GF_Normal_Limb));
      pragma Assert (O (15) in 0 .. GF_Summation_Limb'Last + 1);

      Carry := ASR_16 (O (15));

      O (0) := O (0) + 38 * Carry;
      O (15) := O (15) mod 65536;

      return Nearlynormal_GF (O);
   end Summation_To_Nearlynormal;



   function Difference_To_Nearlynormal
     (X : in Unnormalized_GF_Difference)
       return Nearlynormal_GF
   is
      --  Note that Carry can be negative in this case
      subtype Carry_T is I64 range -1 .. 1;
      Carry : Carry_T;
      O     : GF;
   begin
      O := X;

      pragma Assert (O in Unnormalized_GF_Difference);

      for I in Index_16 range 0 .. 14 loop
         Carry := ASR_16 (O (I));
         O (I + 1) := O (I + 1) + Carry;
         O (I) := O (I) mod 65536;

         pragma Loop_Invariant
           (for all K in Index_16 range 0 .. I => (O (K) in GF_Normal_Limb));
         pragma Loop_Invariant (O (I + 1) in -1 .. 131071);
         pragma Loop_Invariant
           (for all K in Index_16 range I + 2 .. 15 => O (K) = X (K));

      end loop;

      pragma Assert
        (for all K in Index_16 range 0 .. 14 => (O (K) in GF_Normal_Limb));
      pragma Assert (O (15) in -1 .. 131071);

      Carry := ASR_16 (O (15));

      O (0) := O (0) + 38 * Carry;
      O (15) := O (15) mod 65536;

      pragma Assert (O in Nearlynormal_GF);

      return Nearlynormal_GF (O);
   end Difference_To_Nearlynormal;



   function Nearlynormal_To_Normal
     (X : in Nearlynormal_GF)
       return Normal_GF
   is
      subtype Temp_GF is GF
        with Dynamic_Predicate =>
        ((Temp_GF (0) in -38 .. 65573) and
           (for all K in Index_16 range 1 .. 15 =>
              (Temp_GF (K) in -1 .. 65536)));

      function LCP (G : in Temp_GF;
                    I : in Index_16) return Boolean
      is ((G (0) in 0 .. 37) and
          (X (0) in 65536 .. 65573) and
          (G (0) = X (0) mod 65536) and
          (for all K in Index_16 range 1 .. I =>
             (G (K) = 0 and X (K) = 65535)))
        with Global => (Input => X);

      function LCN (G : in Temp_GF;
                    I : in Index_16) return Boolean
      is ((G (0) in 65498 .. 65535) and
          (X (0) in   -38 .. -1) and
          (G (0) = X (0) mod 65536) and
          (for all K in Index_16 range 1 .. I =>
             (G (K) = 65535 and X (K) = 0)))
        with Global => (Input => X);

      --  Note that Carry can be negative in this case
      subtype Carry_T is I64 range -1 .. 1;
      Carry : Carry_T;
      O     : Temp_GF;
   begin
      --  Expand X's subtype predicate
      pragma Assert
        ((X (0) in -38 .. 65573) and
           (for all K in Index_16 range 1 .. 15 =>
              (X (K) in GF_Normal_Limb)));

      O := X;

      pragma Assert
        ((O (0) in -38 .. 65573) and
         (O (0) = X (0)) and
           (for all K in Index_16 range 1 .. 15 =>
              (O (K) in GF_Normal_Limb and O (K) = X (K))));

      Carry := ASR_16 (O (0));
      O (1) := O (1) + Carry;
      O (0) := O (0) mod 65536;

      pragma Assert (O (0) in GF_Normal_Limb);
      pragma Assert (O (0) = X (0) mod 65536);
      pragma Assert (O (1) in -1 .. 65536);
      pragma Assert
        (for all K in Index_16 range 2 .. 15 =>
           (O (K) in GF_Normal_Limb and O (K) = X (K)));

      pragma Assert
        ((Carry = 1) = LCP (O, 0));
      pragma Assert
        ((Carry = -1) = LCN (O, 0));

      for I in Index_16 range 1 .. 14 loop
         Carry := ASR_16 (O (I));
         O (I + 1) := O (I + 1) + Carry;
         O (I) := O (I) mod 65536;

         pragma Loop_Invariant
           (for all K in Index_16 range 0 .. I => (O (K) in GF_Normal_Limb));
         pragma Loop_Invariant (O (I + 1) in -1 .. 65536);
         pragma Loop_Invariant
           (for all K in Index_16 range I + 2 .. 15 => O (K) = X (K));
         pragma Loop_Invariant (O (I + 1) = X (I + 1) + Carry);
         pragma Loop_Invariant
           ((Carry = 1) = LCP (O, I));
         pragma Loop_Invariant
           ((Carry = -1) = LCN (O, I));
      end loop;

      --  Expand loop invariant with I = 14
      pragma Assert
        (for all K in Index_16 range 0 .. 14 => (O (K) in GF_Normal_Limb));
      pragma Assert (O (15) in -1 .. 65536);
      pragma Assert (O (15) = X (15) + Carry);
      pragma Assert
        ((Carry = 1) = LCP (O, 14));
      pragma Assert
        ((Carry = -1) = LCN (O, 14));

      Carry := ASR_16 (O (15));
      O (15) := O (15) mod 65536;

      pragma Assert
        (if (Carry = 1) then LCP (O, 15));
      pragma Assert
        (if (Carry = -1) then LCN (O, 15));
      pragma Assert
        (for all K in Index_16 range 0 .. 15 => (O (K) in GF_Normal_Limb));

      O (0) := O (0) + 38 * Carry;

      pragma Assert (O (0) in GF_Normal_Limb);
      return Normal_GF (O);
   end Nearlynormal_To_Normal;

end SPARKNaCl.Car;
