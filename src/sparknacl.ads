------------------------------------------------------------------------------
--  Copyright (c) 2019, Protean Code Limited
--  All rights reserved.
--
--  "Simplified" (2-Clause) BSD Licence
--
--  Redistribution and use in source and binary forms, with or without
--  modification, are permitted provided that the following conditions are
--  met:
--
--  1. Redistributions of source code must retain the above copyright notice,
--     This list of conditions and the following disclaimer.
--  2. Redistributions in binary form must reproduce the above copyright
--     notice, this list of conditions and the following disclaimer in the
--     documentation and/or other materials provided with the distribution.
--
--  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
--  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
--  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
--  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
--  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
--  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
--  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
--  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
--  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
--  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
------------------------------------------------------------------------------

with Ada.Unchecked_Conversion;
with Interfaces;      use Interfaces;
with Random;

package SPARKNaCl
  with SPARK_Mode => On
is
   --==============================
   --  Exported types and constants
   --  or needed by specifications
   --  of child packages
   --==============================

   subtype Byte is Unsigned_8;
   subtype I32 is Integer_32;
   subtype N32 is I32 range 0 .. I32'Last;
   subtype I64 is Integer_64;
   subtype I64_Byte is I64 range 0 .. 255;
   subtype N64 is I64 range 0 .. I64'Last;

   type Byte_Seq is array (N32 range <>) of Byte;

   --  Remove predefined "=" for Byte_Seq (and all subtypes thereof) since it
   --  is not guaranteed to be constant-time. See function Equal below.
   function "=" (Left, Right : in Byte_Seq) return Boolean is abstract;

   subtype Index_8  is I32 range 0 .. 7;
   subtype Index_16 is I32 range 0 .. 15;
   subtype Index_24 is I32 range 0 .. 23;
   subtype Index_32 is I32 range 0 .. 31;
   subtype Index_64 is I32 range 0 .. 63;

   type I64_Seq  is array (N32 range <>) of I64;

   --  A sequence of I64 values, but where each is limited to
   --  values 0 .. 255;
   type I64_Byte_Seq  is array (N32 range <>) of I64_Byte;


   subtype Bytes_8  is Byte_Seq (Index_8);
   subtype Bytes_16 is Byte_Seq (Index_16);
   subtype Bytes_24 is Byte_Seq (Index_24);
   subtype Bytes_32 is Byte_Seq (Index_32);
   subtype Bytes_64 is Byte_Seq (Index_64);

   subtype I64_Seq_64 is I64_Seq (Index_64);

   Zero_Bytes_16 : constant Bytes_16 := (others => 0);
   Zero_Bytes_32 : constant Bytes_32 := (others => 0);

   --------------------------------------------------------
   --  Constant time equality test
   --------------------------------------------------------

   --  Primitive operation of Byte_Seq, so inheritable
   function Equal (X, Y : in Byte_Seq) return Boolean
     with Global => null,
          Pre    => X'First = Y'First and
                    X'Last  = Y'Last,
          Post   => Equal'Result =
                      (for all I in X'Range => X (I) = Y (I));

   --------------------------------------------------------
   --  RNG
   --------------------------------------------------------

   --  Primitive operation of Byte_Seq, so inheritable
   procedure Random_Bytes (R : out Byte_Seq)
     with Global => Random.Entropy;

   --------------------------------------------------------
   --  Data sanitization
   --------------------------------------------------------

   --  Primitive operation of Byte_Seq, so inheritable.
   --  In their "Volatiles are mis-compiled..." paper,
   --  Regehr et al. recommend that calls to such subprograms
   --  should never be in-lined as a way to prevent
   --  the incorrect optimization (to nothing) of such a call,
   --  so we apply No_Inline here.
   pragma Warnings (GNATProve, Off, "No_Inline");
   procedure Sanitize (R : out Byte_Seq)
     with Global => null,
          No_Inline;


private
   --==============================================
   --  Local types - visible below, in this package
   --  body and in the bodies of child packages
   --==============================================

   subtype U32 is Unsigned_32;
   subtype U64 is Unsigned_64;

   subtype Index_4  is I32 range 0 .. 3;
   subtype Index_15 is I32 range 0 .. 14;
   subtype Index_20 is I32 range 0 .. 19;
   subtype Index_31 is I32 range 0 .. 30;
   subtype Index_256 is I32 range 0 .. 255;

   subtype Bytes_4  is Byte_Seq (Index_4);
   subtype Bytes_256 is Byte_Seq (Index_256);

   type U32_Seq  is array (N32 range <>) of U32;
   type U64_Seq  is array (N32 range <>) of U64;

   subtype U32_Seq_4   is U32_Seq (Index_4);
   subtype U32_Seq_16  is U32_Seq (Index_16);

   subtype I64_Byte_Seq_32 is I64_Byte_Seq (Index_32);

   subtype U64_Seq_16 is U64_Seq (Index_16);
   subtype U64_Seq_8  is U64_Seq (Index_8);

   --  Constant Sigma used for initialization of Core Salsa20
   --  function in both Stream and Cryptobox packages
   Sigma : constant Bytes_16 :=
     (0  => Character'Pos ('e'),
      1  => Character'Pos ('x'),
      2  => Character'Pos ('p'),
      3  => Character'Pos ('a'),
      4  => Character'Pos ('n'),
      5  => Character'Pos ('d'),
      6  => Character'Pos (' '),
      7  => Character'Pos ('3'),
      8  => Character'Pos ('2'),
      9  => Character'Pos ('-'),
      10 => Character'Pos ('b'),
      11 => Character'Pos ('y'),
      12 => Character'Pos ('t'),
      13 => Character'Pos ('e'),
      14 => Character'Pos (' '),
      15 => Character'Pos ('k'));



   --  In multlying two normalized GFs, a simple product of
   --  two limbs is bounded to 65535**2. This comes up in
   --  predicates and subtypes below, so a named number here
   --  is called for.  The name "MGFLP" is short for
   --  "Maximum GF Limb Product"
   MGFLP : constant := 65535 * 65535;


   -------------------------------------------------------------------------
   --  Bounds on All GF Limbs
   --
   --  In the most general case, we define GF_Any_Limb so it can take
   --  on the value of any GF limb at any point including intermediate
   --  values inside the "*", "-" and "+" operations.
   --
   --  Lower bound on GF_Any_Limb
   --
   --  During a subtraction of a GF, a limb can also reach -65535,
   --  but this can be rounded down to -65536 by addition of a -1 carry
   --  in Car_25519, so the lower bound is -65536
   --
   --  Upper bound on GF_Any_Limb
   --
   --  During the "reduction modulo 2**255-19" phase of the "*"
   --  operation, each limb GF (I) is added to 38 * GF (I + 16)
   --  The worst-case upper bound of this result is when I = 0,
   --  where I (0) has upper bound MGFLP an I (16) has upper bound
   --  15 * MGFLP.
   --
   --  Therefore the upper bound of Any_GF_Limb is
   --   (38 * 15 + 1) * MGFLP = 571 * MGFLP
   -------------------------------------------------------------------------

   --  "Maximum GF Limb Coefficient"
   MGFLC : constant := (38 * 15) + 1;

   subtype GF_Any_Limb        is I64 range -65536 .. (MGFLC * MGFLP);

   type GF is array (Index_16) of GF_Any_Limb;

   --  In a "+" operation, intermediate result limbs peak at +131070, so
   subtype GF_Summation_Limb is I64 range 0 .. 131070;

   subtype Summation_GF is GF
     with Dynamic_Predicate =>
       (for all I in Index_16 => Summation_GF (I) in GF_Summation_Limb);


   --  In a "-" operation, intermediate result limbs are in -65535 .. 65535
   subtype GF_Difference_Limb is I64 range -65535 .. 65535;
   subtype Difference_GF is GF
     with Dynamic_Predicate =>
       (for all I in Index_16 => Difference_GF (I) in GF_Difference_Limb);

   subtype Unnormalized_GF_Difference is GF
     with Dynamic_Predicate =>
        ((Unnormalized_GF_Difference (0) in -37 .. 131033) and
           (for all K in Index_16 range 1 .. 15 =>
              Unnormalized_GF_Difference (K) in 0 .. 131070));

   --  RCC Justification required here of the lower and upper bounds
   subtype GF_Seminormal_Limb is I64 range    -38 .. 39_847_219;

   subtype GF_Normal_Limb     is I64 range      0 .. 65535;

   --  In a "Seminornal" GF, limbs 1 through 15 are "normal", but
   --  Limb 0 is a GF_Seminormal_Limb
   subtype Seminormal_GF is GF
     with Dynamic_Predicate =>
       (Seminormal_GF (0) in GF_Seminormal_Limb and
          (for all I in Index_16 range 1 .. 15 =>
             Seminormal_GF (I) in GF_Normal_Limb));

   subtype Normal_GF is GF
     with Dynamic_Predicate =>
       (for all I in Index_16 => Normal_GF (I) in GF_Normal_Limb);

   --  A GF which is the result of multiplying two other Normalized GFs,
   --  but BEFORE normalization is applied has the following bounds on
   --  its coefficients. The upperbound on Unnormalized_GF_Product (0) is
   --  MGFLC * MGFLP as above, but the upper bound reduces by 37 * MGFLP
   --  for each element I+1 onwards...
   --
   --  Lower-bound here is 0 since "*" always takes Normal_GF
   --  parameters, so an intermediate limb can never be negative.
   subtype Unnormalized_GF_Product is GF
     with Dynamic_Predicate =>
       (for all I in Index_16 =>
         Unnormalized_GF_Product (I) >= 0 and
         Unnormalized_GF_Product (I) <=
           (MGFLC - 37 * GF_Any_Limb (I)) * MGFLP);

   ----------------------------------------------------------------------
   --  A "Seminormal GF Product" is the result of applying a single
   --  "Car_25519" normalization step to an Unnormalized_GF_Product

   --  Least Significant Limb of a Seminormal GF Product
   subtype GF_Seminormal_Product_LSL is I64
     range 0 .. (65535 + 38 * ((53 * MGFLP) / 65536));

   --  Limbs 1 though 15 are in 0 .. 65535, but the
   --  Least Significant Limb 0 is special..
   subtype Seminormal_Product_GF is GF
     with Dynamic_Predicate =>
       (Seminormal_Product_GF (0) in GF_Seminormal_Product_LSL and
         (for all I in Index_16 range 1 .. 15 =>
           Seminormal_Product_GF (I) in GF_Normal_Limb));

   ------------------------------------------------------------------------
   --  A "Nearly-normal GF" is the result of applying either:
   --  1. TWO "Car_25519" normalization steps to an Unnormalized_GF_Product
   --  OR
   --  2. ONE normalization step the the SUM of 2 normalized GFs
   --  OR
   --  3. ONE normalization step the the DIFFERENCE of 2 normalized GFs

   subtype Nearlynormal_GF is GF
     with Dynamic_Predicate =>
        ((Nearlynormal_GF (0) in -38 .. 65573) and
           (for all K in Index_16 range 1 .. 15 =>
              (Nearlynormal_GF (K) in GF_Normal_Limb)));

   ------------------------------------------------------------------------

   GF_0      : constant Normal_GF := (others => 0);
   GF_1      : constant Normal_GF := (1, others => 0);


   function To_U64 is new Ada.Unchecked_Conversion (I64, U64);
   function To_I64 is new Ada.Unchecked_Conversion (U64, I64);

   --===============================
   --  Local expression functions
   --===============================

   --  returns equivalent of X >> 16 in C, doing an arithmetic
   --  shift right when X is negative
   function ASR_16 (X : in I64) return I64
   is (To_I64 (Shift_Right_Arithmetic (To_U64 (X), 16)))
     with Post => (if X >= 0 then ASR_16'Result = X / 65536 else
                                  ASR_16'Result = ((X + 1) / 65536) - 1);
   pragma Annotate (GNATprove,
                    False_Positive,
                    "postcondition might fail",
                    "From definition of arithmetic shift right");

   --  returns equivalent of X >> 8 in C, doing an arithmetic
   --  shift right when X is negative
   function ASR_8 (X : in I64) return I64
   is (To_I64 (Shift_Right_Arithmetic (To_U64 (X), 8)))
     with Post => (if X >= 0 then ASR_8'Result = X / 256 else
                                  ASR_8'Result = ((X + 1) / 256) - 1);
   pragma Annotate (GNATprove,
                    False_Positive,
                    "postcondition might fail",
                    "From definition of arithmetic shift right");

   --  returns equivalent of X >> 4 in C, doing an arithmetic
   --  shift right when X is negative
   function ASR_4 (X : in I64) return I64
   is (To_I64 (Shift_Right_Arithmetic (To_U64 (X), 4)))
     with Post => (if X >= 0 then ASR_4'Result = X / 16 else
                                  ASR_4'Result = ((X + 1) / 16) - 1);
   pragma Annotate (GNATprove,
                    False_Positive,
                    "postcondition might fail",
                    "From definition of arithmetic shift right");

   --===============================
   --  Local subprogram declarations
   --===============================

   function "+" (Left, Right : in Normal_GF) return Normal_GF
     with Global => null;

   function "-" (Left, Right : in Normal_GF) return Normal_GF
     with Global => null;

   function "*" (Left, Right : in Normal_GF) return Normal_GF
     with Global => null;

   function Square (A : in Normal_GF) return Normal_GF
     with Global => null;

end SPARKNaCl;
