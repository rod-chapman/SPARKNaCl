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


   --  In multlying two normalized GFs, a simple product of
   --  two limbs is bounded to 65535**2. This comes up in
   --  predicates and subtypes below, so a named number here
   --  is called for.  The name "MGFLP" is short for
   --  "Maximum GF Limb Product"
   MGFLP : constant := 65535 * 65535;


   --  RCC Justify 571 here!
   --  During a subtraction of a GF, a limb can also reach -65535,
   --  but this can be rounded down to -65536 by addition of a -1 carry
   --  in Car_25519, so...
   subtype GF_Any_Limb        is I64 range -65536 .. (571 * MGFLP);

   subtype GF_Seminormal_Limb is I64 range    -37 .. 39_847_219;  -- Explain

   subtype GF_Normal_Limb     is I64 range      0 .. 65535;

   type GF is array (Index_16) of GF_Any_Limb;

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
   --  its coefficients
   subtype Unnormalized_GF_Product is GF
     with Dynamic_Predicate =>
       (for all I in Index_16 =>
         Unnormalized_GF_Product (I) >= 0 and
         Unnormalized_GF_Product (I) <=
           (571 - 37 * GF_Any_Limb (I)) * MGFLP);

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

   subtype I64_Seq_32 is I64_Seq (Index_32);

   subtype U64_Seq_16 is U64_Seq (Index_16);
   subtype U64_Seq_8  is U64_Seq (Index_8);

   --  Local types for expressing a "Normalized" GF with
   --  all limbs in the range 0 .. 65535
   --
   --   subtype GF_Limb is I64 range 0 .. 65535;
   --   type GF_Normalized is new GF
   --     with Dynamic_Predicate => (for all I in Index_16 =>
   --                                  GF_Normalized (I) in GF_Limb);

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

   GF_0      : constant GF := (others => 0);
   GF_1      : constant GF := (1, others => 0);

   function To_U64 is new Ada.Unchecked_Conversion (I64, U64);
   function To_I64 is new Ada.Unchecked_Conversion (U64, I64);

   --===============================
   --  Local expression functions
   --===============================

   --  returns equivalent of X >> 16 in C, doing an arithmetic
   --  shift right when X is negative
   function ASR_16 (X : in I64) return I64
   is (To_I64 (Shift_Right_Arithmetic (To_U64 (X), 16)))
     with Post => ASR_16'Result >= -2**47 and
                  ASR_16'Result <= (2**47) - 1;

   --  returns equivalent of X >> 8 in C, doing an arithmetic
   --  shift right when X is negative
   function ASR_8 (X : in I64) return I64
   is (To_I64 (Shift_Right_Arithmetic (To_U64 (X), 8)))
     with Post => ASR_8'Result >= -2**55 and
                  ASR_8'Result <= (2**55) - 1;

   --  returns equivalent of X >> 4 in C, doing an arithmetic
   --  shift right when X is negative
   function ASR_4 (X : in I64) return I64
   is (To_I64 (Shift_Right_Arithmetic (To_U64 (X), 4)))
     with Post => ASR_4'Result >= -2**59 and
                  ASR_4'Result <= (2**59) - 1;

   --===============================
   --  Local subprogram declarations
   --===============================

   --  Remove predefined "=" for GF since it is not time-constant.
   --
   --  See Sign.Unpackneg.Eq_25519 which declares a time-constant
   --  algorithm where it is needed.
   function "=" (Left, Right : in GF) return Boolean is abstract;

   function "+" (Left, Right : in GF) return GF
     with Global => null,
          Pre => (for all I in Index_16 => (Left (I)  in GF_Normal_Limb and
                                            Right (I) in GF_Normal_Limb)),
          Post => (for all I in Index_16 =>
                      ("+"'Result (I) in GF_Normal_Limb));

   function "-" (Left, Right : in GF) return GF
     with Global => null,
          Pre => (for all I in Index_16 => (Left (I)  in GF_Normal_Limb and
                                            Right (I) in GF_Normal_Limb)),
          Post => (for all I in Index_16 =>
                      ("-"'Result (I) in GF_Normal_Limb));

   function "*" (Left, Right : in Normal_GF) return Normal_GF
     with Global => null,
          Pre => (for all I in Index_16 => (Left (I)  in GF_Normal_Limb and
                                            Right (I) in GF_Normal_Limb)),
          Post => (for all I in Index_16 =>
                      ("*"'Result (I) in GF_Normal_Limb));

   function Square (A : in GF) return GF
     with Global => null,
          Pre => (for all I in Index_16 => (A (I)  in GF_Normal_Limb)),
          Post => (for all I in Index_16 =>
                      (Square'Result (I) in GF_Normal_Limb));

end SPARKNaCl;
