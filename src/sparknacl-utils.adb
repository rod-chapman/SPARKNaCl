package body SPARKNaCl.Utils
  with SPARK_Mode => On
is
   --  POK
   function Random_Bytes_32 return Bytes_32
   is
      Result : Bytes_32;
   begin
      for I in Result'Range loop
         Result (I) := Random.Random_Byte;
      end loop;
      return Result;
   end Random_Bytes_32;


   --  P?
   function Pack_25519 (N : in GF) return Bytes_32
   is
      Swap : Boolean;
      M, T : GF;
      O    : Bytes_32;
   begin
      M := (others => 0);
      T := N;

      --  RCC - Why 3 calls to Car_25519 here?
      Car_25519 (T);
      Car_25519 (T);
      Car_25519 (T);

      --  Check that T is normalized now
      pragma Assert ((for all I in Index_16 => T (I) >= 0),
                     "Pack_25519 - limb too negative");
      pragma Assert ((for all I in Index_16 => T (I) <= 65535),
                     "Pack_25519 - limb too large");

      for J in I32 range 0 .. 1 loop
         M (0) := T (0) - 16#FFED#; --  POV
         for I in I32 range 1 .. 14 loop

            M (I) := T (I) -
                     16#FFFF# -
                     (ASR_16 (M (I - 1)) mod 2); --  POV * 2

            M (I - 1) := M (I - 1) mod 65536;
         end loop;
         M (15) := T (15) - 16#7FFF# - (ASR_16 (M (14)) mod 2); --  POV * 2

         Swap := Boolean'Val (ASR_16 (M (15)) mod 2);

         M (14) := M (14) mod 65536;
         Sel_25519 (T, M, not Swap);
      end loop;

      O := (others => 0);
      for I in Index_16 loop
         pragma Assert (T (I) >= 0); --  PAssert? Depends on post of above loop
         pragma Assert (T (I) <= 65535); --  PAssert?

         O (2 * I)     := Byte (T (I) mod 256);
         O (2 * I + 1) := Byte ((T (I) / 256) mod 256);
      end loop;
      return O;
   end Pack_25519;

   --  POK
   function Unpack_25519 (N : in Bytes_32) return GF
   is
      O : GF;
   begin
      for I in Index_16 loop
         O (I) := I64 (N (2 * I)) + (I64 (N (2 * I + 1)) * 256);
      end loop;
      O (15) := O (15) mod 32768;
      return O;
   end Unpack_25519;


   --  POK
   function Inv_25519 (I : in GF) return GF
   is
      C, C2 : GF;
   begin
      C := I;

      for A in reverse 0 .. 253 loop
         --  Need C2 here to avoid aliasing C with C via pass by reference
         S (C2, C);
         if (A /= 2 and A /= 4) then
            M (C, C2, I);
         else
            C := C2;
         end if;
      end loop;

      return C;
   end Inv_25519;



end SPARKNaCl.Utils;
