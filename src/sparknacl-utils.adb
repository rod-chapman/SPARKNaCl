package body SPARKNaCl.Utils
  with SPARK_Mode => On
is

   type Bit_To_Swapmask_Table is array (Boolean) of U64;
   Bit_To_Swapmask : constant Bit_To_Swapmask_Table :=
     (False => 16#0000_0000_0000_0000#,
      True  => 16#FFFF_FFFF_FFFF_FFFF#);

   --  POK
   procedure Sel_25519 (P    : in out GF;
                        Q    : in out GF;
                        Swap : in     Boolean)
   is
      T : U64;
      C : constant U64 := Bit_To_Swapmask (Swap);
   begin
      for I in Index_16 loop
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
         P (I) := To_I64 (To_U64 (P (I)) xor T);
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
      end loop;
   end Sel_25519;


   procedure Car_25519 (O : in out GF)
   is
      C : I64;
   begin
      --  In SPARK, we unroll the final (I = 15)'th iteration
      --  of this loop below. This removes the need for
      --  a conditional statement or expression inside the loop
      --  body.
      for I in Index_16 range 0 .. 14 loop
         O (I) := O (I) + 2#1_0000_0000_0000_0000#; --  POV
         C := ASR_16 (O (I));
         O (I + 1) := O (I + 1) + C - 1; --  POV on second + and -

         --  The C code here uses (c << 16) which is UNDEFINED
         --  for negative c according to C standard 6.5.7 (4).
         --  TweetNaCl appears to depend on this being equivalent
         --  to sign-preserving multiplication by 65536.
         pragma Assert (C >= -2**47);
         pragma Assert (C <= (2**47) - 1);

         O (I) := O (I) - (C * 65536); --  POV on - and *
      end loop;

      --  Final iteration, as would be when I = 15
      O (15) := O (15) + 2#1_0000_0000_0000_0000#; --  POV
      C := ASR_16 (O (15));
      O (0) := O (0) + C - 1 + 37 * (C - 1); --  POV on 5 binary ops!
      O (15) := O (15) - (C * 65536); --  POV on - and *
   end Car_25519;


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
         C2 := Square (C);
         if (A /= 2 and A /= 4) then
            M (C, C2, I);
         else
            C := C2;
         end if;
      end loop;

      return C;
   end Inv_25519;


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

end SPARKNaCl.Utils;
