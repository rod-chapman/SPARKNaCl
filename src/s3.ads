with Interfaces; use Interfaces;

package S3
  with -- Pure,
       SPARK_Mode => On
is
   subtype I32      is Integer_32;
   subtype I64      is Integer_64;
   subtype Index_16 is I32 range 0 .. 15;

   subtype U16 is Unsigned_16;
   subtype U32 is Unsigned_32;
   subtype U64 is Unsigned_64;

   LM   : constant := 65536;
   LMM1 : constant := 65535;

   R2256 : constant := 38;

   MGFLC : constant := (R2256 * 15) + 1;

   MGFLP : constant := LMM1 * LMM1;

   subtype GF64_Any_Limb is I64 range -LM .. (MGFLC * MGFLP);
   type GF64 is array (Index_16) of GF64_Any_Limb;

   subtype GF64_Normal_Limb is GF64_Any_Limb range 0 .. LMM1;
   subtype GF16_Normal_Limb is U16;

   subtype Normal_GF64 is GF64
     with Dynamic_Predicate =>
       (for all I in Index_16 => Normal_GF64 (I) in GF64_Normal_Limb);

   type Normal_GF is array (Index_16) of GF16_Normal_Limb
     with Alignment => 4;

   function M2 (Left, Right : in Normal_GF) return Normal_GF
     with Pure_Function,
          Global => null;

end S3;
