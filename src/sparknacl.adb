package body SPARKNaCl
  with SPARK_Mode => On
is
   --===============================
   --  Local subprogram bodies
   --===============================

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

   procedure M (O    :    out GF;
                A, B : in     GF)
   is
      subtype TA is I64_Seq (Index_31);
      T : TA;
   begin
      pragma Assert ((for all I in Index_16 => A (I) >= -65535),
                     "M input A - limb too negative");
      pragma Assert ((for all I in Index_16 => A (I) <= 196605),
                     "M input A - limb too big");

      pragma Assert ((for all I in Index_16 => B (I) >= -65535),
                     "M input B - limb too negative");
      pragma Assert ((for all I in Index_16 => B (I) <= 196605),
                     "M input B - limb too big");


      T := (others => 0);

      for I in Index_16 loop
         for J in Index_16 loop
            T (I + J) := T (I + J) + (A (I) * B (J)); --  POV * 2
         end loop;
      end loop;

      --  Here T(I) >= 0 and T(I) <= N*(131070**2), where N ranges
      --  from 1 (for I = 0 and I = 30) up to 16 (for I = 15, which is a bit
      --  less than 2**38)

      pragma Assert ((for all I in Index_31 => T (I) >= -2**38),
                     "M output 0 - limb too negative");
      pragma Assert ((for all I in Index_31 => T (I) <= 2**38),
                     "M output 0 - limb too large");


      for I in Index_15 loop
         T (I) := T (I) + 38 * T (I + 16); --  POV * 2
      end loop;

      O := T (0 .. 15);

      pragma Assert ((for all I in Index_16 =>
                        O (I) >= -(2**38 + (38 * 2**38))),
                     "M output 1 - limb too negative");
      pragma Assert ((for all I in Index_16 =>
                        O (I) <= (2**38 + (38 * 2**38))),
                     "M output 1 - limb too large");

      Car_25519 (O);
      Car_25519 (O);

      --  Check that O is normalized
      pragma Assert ((for all I in Index_16 => O (I) >= 0),
                     "M output 3 - limb too negative");
      pragma Assert ((for all I in Index_16 => O (I) <= 65535),
                     "M output 3 - limb too large");
   end M;

   procedure A (O    :    out GF;
                A, B : in     GF)
   is
   begin
      pragma Assert ((for all I in Index_16 => A (I) >= -65535),
                     "A input A - limb too negative");
      pragma Assert ((for all I in Index_16 => A (I) <= 131070),
                     "A input A - limb too big");

      pragma Assert ((for all I in Index_16 => B (I) >= -65535),
                     "A input B - limb too negative");
      pragma Assert ((for all I in Index_16 => B (I) <= 65535),
                     "A input B - limb too big");


      for I in Index_16 loop
         O (I) := A (I) + B (I); --  POV
      end loop;
      pragma Assert ((for all I in Index_16 => O (I) >= -65535),
                     "A output - limb too negative");
      pragma Assert ((for all I in Index_16 => O (I) <= 196605),
                     "A output - limb too large");
   end A;

   procedure Z (O    :    out GF;
                A, B : in     GF)
   is
   begin
      pragma Assert ((for all I in Index_16 => A (I) >= 0),
                     "Z input A - limb negative");
      pragma Assert ((for all I in Index_16 => A (I) <= 131070),
                     "Z input A - limb too big");

      pragma Assert ((for all I in Index_16 => B (I) >= -65535),
                     "Z input B - limb too negative");
      pragma Assert ((for all I in Index_16 => B (I) <= 65535),
                     "Z input B - limb too big");

      for I in Index_16 loop
         O (I) := A (I) - B (I); --  POV
      end loop;

      pragma Assert ((for all I in Index_16 => O (I) >= -65535),
                     "Z output O - limb too negative");
      pragma Assert ((for all I in Index_16 => O (I) <= 131070),
                     "Z output O - limb too large");
   end Z;

   --  POK
   procedure S (O :    out GF;
                A : in     GF)
   is
   begin
      pragma Assert ((for all I in Index_16 => A (I) >= -65535),
                     "S input A - limb too negative");
      pragma Assert ((for all I in Index_16 => A (I) <= 131070),
                     "S input A - limb too big");

      M (O, A, A);

      pragma Assert ((for all I in Index_16 => O (I) >= 0),
                     "S output - limb too negative");
      pragma Assert ((for all I in Index_16 => O (I) <= 65535),
                     "S output - limb too large");
   end S;

   --===============================
   --  Exported subprogram bodies
   --===============================

   --------------------------------------------------------
   --  Constant time equality test
   --------------------------------------------------------

   --  POK
   function Equal (X, Y : in Byte_Seq) return Boolean
   is
      D : Byte := 0;
   begin
      for I in X'Range loop
         D := D or (X (I) xor Y (I));
      end loop;
      --  D = 0         iff X and Y are equal
      --  D in 1 .. 255 iff X and Y are not equal

      return (D = 0);
   end Equal;

   --------------------------------------------------------
   --  RNG
   --------------------------------------------------------

   --  POK
   procedure Random_Bytes (R : out Byte_Seq)
   is
   begin
      for I in R'Range loop
         R (I) := Random.Random_Byte;
      end loop;
   end Random_Bytes;

   --------------------------------------------------------
   --  Data sanitization
   --------------------------------------------------------

   procedure Sanitize (R : out Byte_Seq) is separate;

end SPARKNaCl;
