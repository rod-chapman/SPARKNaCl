with SPARKNaCl.Utils;
package body SPARKNaCl
  with SPARK_Mode => On
is
   --===============================
   --  Local subprogram bodies
   --===============================

   function "*" (Left, Right : in GF) return GF
   is
      subtype TA is I64_Seq (Index_31);
      T : TA;
      O : GF;
   begin
      pragma Assert ((for all I in Index_16 => Left (I) >= -65535),
                     "* input A - limb too negative");
      pragma Assert ((for all I in Index_16 => Left (I) <= 196605),
                     "* input A - limb too big");

      pragma Assert ((for all I in Index_16 => Right (I) >= -65535),
                     "* input B - limb too negative");
      pragma Assert ((for all I in Index_16 => Right (I) <= 196605),
                     "* input B - limb too big");


      T := (others => 0);

      for I in Index_16 loop
         for J in Index_16 loop
            T (I + J) := T (I + J) + (Left (I) * Right (J)); --  POV * 2
         end loop;
      end loop;

      --  Here T(I) >= 0 and T(I) <= N*(131070**2), where N ranges
      --  from 1 (for I = 0 and I = 30) up to 16 (for I = 15, which is a bit
      --  less than 2**38)

      pragma Assert ((for all I in Index_31 => T (I) >= -2**38),
                     "* output 0 - limb too negative");
      pragma Assert ((for all I in Index_31 => T (I) <= 2**38),
                     "* output 0 - limb too large");


      for I in Index_15 loop
         T (I) := T (I) + 38 * T (I + 16); --  POV * 2
      end loop;

      O := T (0 .. 15);

      pragma Assert ((for all I in Index_16 =>
                        O (I) >= -(2**38 + (38 * 2**38))),
                     "* output 1 - limb too negative");
      pragma Assert ((for all I in Index_16 =>
                        O (I) <= (2**38 + (38 * 2**38))),
                     "* output 1 - limb too large");

      Utils.Car_25519 (O);
      Utils.Car_25519 (O);

      --  Check that O is normalized
      pragma Assert ((for all I in Index_16 => O (I) >= 0),
                     "* output 3 - limb too negative");
      pragma Assert ((for all I in Index_16 => O (I) <= 65535),
                     "* output 3 - limb too large");
      return O;
   end "*";


   function "+" (Left, Right : in GF) return GF
   is
      O : GF;
   begin
      pragma Assert ((for all I in Index_16 => Left (I) >= -65535),
                     "+ input Left - limb too negative");
      pragma Assert ((for all I in Index_16 => Left (I) <= 131070),
                     "+ input Left - limb too big");

      pragma Assert ((for all I in Index_16 => Right (I) >= -65535),
                     "+ input Right - limb too negative");
      pragma Assert ((for all I in Index_16 => Right (I) <= 65535),
                     "+ input Right - limb too big");


      for I in Index_16 loop
         O (I) := Left (I) + Right (I); --  POV
      end loop;
      pragma Assert ((for all I in Index_16 => O (I) >= -65535),
                     "+ output - limb too negative");
      pragma Assert ((for all I in Index_16 => O (I) <= 196605),
                     "+ output - limb too large");
      return O;
   end "+";

   function "-" (Left, Right : in GF) return GF
   is
      O : GF;
   begin
      pragma Assert ((for all I in Index_16 => Left (I) >= 0),
                     "- input Left - limb negative");
      pragma Assert ((for all I in Index_16 => Left (I) <= 131070),
                     "- input Left - limb too big");

      pragma Assert ((for all I in Index_16 => Right (I) >= -65535),
                     "- input Right - limb too negative");
      pragma Assert ((for all I in Index_16 => Right (I) <= 65535),
                     "- input Right - limb too big");

      for I in Index_16 loop
         O (I) := Left (I) - Right (I); --  POV
      end loop;

      pragma Assert ((for all I in Index_16 => O (I) >= -65535),
                     "- output O - limb too negative");
      pragma Assert ((for all I in Index_16 => O (I) <= 131070),
                     "- output O - limb too large");
      return O;
   end "-";

   --  POK
   function Square (A : in GF) return GF
   is
      O : GF;
   begin
      pragma Assert ((for all I in Index_16 => A (I) >= -65535),
                     "S input A - limb too negative");
      pragma Assert ((for all I in Index_16 => A (I) <= 131070),
                     "S input A - limb too big");

      O := A * A;

      pragma Assert ((for all I in Index_16 => O (I) >= 0),
                     "S output - limb too negative");
      pragma Assert ((for all I in Index_16 => O (I) <= 65535),
                     "S output - limb too large");
      return O;
   end Square;

   --===============================
   --  Exported subprogram bodies
   --===============================

   --------------------------------------------------------
   --  Constant time equality test
   --------------------------------------------------------

   --  POK
   function Equal (X, Y : in Byte_Seq) return Boolean
   is
      D : Boolean := True;
   begin
      for I in N32 range X'Range loop
         D := D and (X (I) = Y (I));
         pragma Loop_Invariant
           (D = (for all J in N32 range X'First .. I => X (J) = Y (J)));
      end loop;

      return D;
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
