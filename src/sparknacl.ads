------------------------------------------------------------------------------
--  Copyright (c) 2020,2021 Protean Code Limited
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

with Interfaces; use Interfaces;

package SPARKNaCl
  with Pure,
       SPARK_Mode => On
is
   --==============================================
   --  Exported types and constants
   --
   --  These are needed by clients, or by the
   --  specifications of child packages
   --==============================================

   subtype Byte     is Unsigned_8;

   subtype I32      is Integer_32;
   subtype N32      is I32 range 0 .. I32'Last;
   subtype I32_Bit  is I32 range 0 .. 1;

   subtype I64      is Integer_64;
   subtype I64_Byte is I64 range 0 .. 255;
   subtype I64_Bit  is I64 range 0 .. 1;

   --  Byte_Seq and constrained subtypes thereof
   type Byte_Seq is array (N32 range <>) of Byte;

   subtype Index_8  is I32 range 0 .. 7;
   subtype Index_16 is I32 range 0 .. 15;
   subtype Index_24 is I32 range 0 .. 23;
   subtype Index_32 is I32 range 0 .. 31;
   subtype Index_64 is I32 range 0 .. 63;

   subtype Bytes_8  is Byte_Seq (Index_8);
   subtype Bytes_16 is Byte_Seq (Index_16);
   subtype Bytes_24 is Byte_Seq (Index_24);
   subtype Bytes_32 is Byte_Seq (Index_32);
   subtype Bytes_64 is Byte_Seq (Index_64);

   Zero_Bytes_16 : constant Bytes_16 := (others => 0);
   Zero_Bytes_32 : constant Bytes_32 := (others => 0);


   --  A sequence of I64 values, but where each is limited to
   --  values 0 .. 255;
   type I64_Byte_Seq  is array (N32 range <>) of I64_Byte;

   --  Sequences of I64 values and subtypes thereof
   type I64_Seq  is array (N32 range <>) of I64;
   subtype I64_Seq_64 is I64_Seq (Index_64);


   --------------------------------------------------------
   --  Intrinsic functions
   --
   --  GNAT supports Intrinsic Shift and Rotate operations
   --  on signed as well as unsigned integer types, and
   --  SPARK Community Edition 2021 knows the semantics
   --  of them.
   --------------------------------------------------------

   function Shift_Right_Arithmetic (Value  : I64;
                                    Amount : Natural) return I64
     with Import,
          Convention => Intrinsic;

   function Shift_Right_Arithmetic (Value  : I32;
                                    Amount : Natural) return I32
     with Import,
          Convention => Intrinsic;

   --------------------------------------------------------
   --  Constant time equality test
   --------------------------------------------------------

   --  Primitive operation of Byte_Seq, so inheritable
   function Equal (X, Y : in Byte_Seq) return Boolean
     with Pure_Function,
          Global => null,
          Pre    => X'First = Y'First and
                    X'Last  = Y'Last,
          Post   => Equal'Result =
                      (for all I in X'Range => X (I) = Y (I));

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

   subtype U16 is Unsigned_16;
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

   -------------------------------------------------------------------------
   --  Constants common to the whole library
   --
   --  Some "Huffman-lite coding" is applied to names here - the most
   --  frequently used constants having abbreviated names.
   -------------------------------------------------------------------------

   --  GF "Limbs" are stored modulo 65536
   --
   --  "LM"   = "Limb Modulus"
   --  "LMM1" = "Limb Modulus Minus 1"
   LM   : constant := 65536;
   LMM1 : constant := 65535;

   --  The modulus of curve 25519 is (2**255 - 19).
   --  In the reduction of GF values, we sometime need to multiply a limb
   --  value by 2**256 mod (2**255 - 19), which is actually equal to 38,
   --  since 2**256 = (2 * (2**255 - 19)) + 38
   --
   --  "R2256" = "Remainder of 2**256 (modulo 2**255-19)"
   R2256 : constant := 38;

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
   --  but this can be rounded down to -65536 by addition of a -1 carry,
   --  so the lower bound is -65536
   --
   --  Upper bound on GF_Any_Limb
   --
   --  During the "reduction modulo 2**255-19" phase of the "*"
   --  operation, each limb GF (I) is added to R2256 * GF (I + 16)
   --  The worst-case upper bound of this result is when I = 0,
   --  where GF (0) has upper bound MGFLP and GF (16) has upper bound
   --  15 * MGFLP.
   --
   --  Therefore the upper bound of Any_GF_Limb is
   --   (R2256 * 15 + 1) * MGFLP = 571 * MGFLP
   -------------------------------------------------------------------------

   --  "Maximum GF Limb Coefficient"
   MGFLC : constant := (R2256 * 15) + 1;

   --  In multiplying two normalized GFs, a simple product of
   --  two limbs is bounded to 65535**2. This comes up in
   --  predicates and subtypes below, so a named number here
   --  is called for.  The name "MGFLP" is short for
   --  "Maximum GF Limb Product"
   MGFLP : constant := LMM1 * LMM1;

   --  The max value of a GF32_Any_Limb is the upper bound on digit 0
   --  following ONE application of Product_To_Seminormal_GF to the
   --  intermidiate result of a "*" operation. This value is actually
   --  a bit less than 2**27 which justifies that subsequence normalization
   --  steps can all be done in 32-bit arithmetic.
   --
   --  See the declaration of Seminormal_GF_LSL below for detail of
   --  how this value is derived.
   GF32_Any_Limb_Max : constant := (LMM1 + R2256 * ((53 * MGFLP) / LM));
   subtype GF32_Any_Limb is I32
     range -LM .. GF32_Any_Limb_Max;
   type GF32 is array (Index_16) of GF32_Any_Limb;

   --  In the "*" operator for GF, intermediate results require
   --  64 bit integers before being normalized, so...
   subtype GF64_Any_Limb is I64 range -LM .. (MGFLC * MGFLP);
   type GF64 is array (Index_16) of GF64_Any_Limb;

   --  GF64 Product Accumulator - used in "*" to accumulate the
   --  intermediate results of Left * Right
   type GF64_PA is array (Index_31) of GF64_Any_Limb;

   -------------------------------------------------------------------------
   subtype GF64_Normal_Limb is GF64_Any_Limb range 0 .. LMM1;
   subtype GF32_Normal_Limb is GF32_Any_Limb range 0 .. LMM1;
   subtype GF16_Normal_Limb is U16;

   subtype Normal_GF64 is GF64
     with Dynamic_Predicate =>
       (for all I in Index_16 => Normal_GF64 (I) in GF64_Normal_Limb);

   subtype Normal_GF32 is GF32
     with Dynamic_Predicate =>
       (for all I in Index_16 => Normal_GF32 (I) in GF32_Normal_Limb);

   type Normal_GF is array (Index_16) of GF16_Normal_Limb
     with Alignment => 4;

   -------------------------------------------------------------------------


   -------------------------------------------------------------------------
   --  Subtypes supporting "+" operation on GF
   --
   --  In a "+" operation, intermediate result limbs peak at +131070, so
   subtype GF_Sum_Limb is I32 range 0 .. (LMM1 * 2);

   subtype Sum_GF is GF32
     with Dynamic_Predicate =>
       (for all I in Index_16 => Sum_GF (I) in GF_Sum_Limb);
   -------------------------------------------------------------------------

   -------------------------------------------------------------------------
   --  Subtypes supporting "-" operation on GF
   --
   --  In a "-" operation, each limb of the intermediate result is
   --  increased by 65536 to make sure it's not negative, and one
   --  is taken off the next limb up to balance the value.
   --
   --  This means that
   --   Limb 0 is in range (0 - 65535) + 65536 .. (65535 - 0) + 65536
   --              which is 1 .. 131071
   --   Limbs 1 .. 15 are in range (0 - 65535) + 65535 .. (65535 - 0) + 65535
   --              which is 0 .. 131070
   --
   --  Finally, to balance the -1 value carried into limb 16, limb 0
   --  is reduced by R2256, so...
   subtype Difference_GF is GF32
     with Dynamic_Predicate =>
        ((Difference_GF (0) in (1 - R2256) .. (2 * LMM1) + 1) and
           (for all K in Index_16 range 1 .. 15 =>
              Difference_GF (K) in 0 .. 2 * LMM1));

   -------------------------------------------------------------------------
   --  Subtypes supporting "*" operation on GF
   --
   --  A GF which is the result of multiplying two other Normalized GFs,
   --  but BEFORE normalization is applied has the following bounds on
   --  its limbs. The upperbound on Limb 0 is MGFLC * MGFLP as in
   --  GF_Any_Limb, but the upper bound reduces by 37 * MGFLP
   --  for each limb onwards...
   --
   --  Lower-bound here is 0 since "*" always takes Normal_GF
   --  parameters, so an intermediate limb can never be negative.
   subtype Product_GF is GF64
     with Dynamic_Predicate =>
       (for all I in Index_16 =>
         Product_GF (I) >= 0 and
         Product_GF (I) <=
           (MGFLC - 37 * GF64_Any_Limb (I)) * MGFLP);

   ----------------------------------------------------------------------
   --  A "Seminormal GF" is the result of applying a single
   --  normalization step to a Product_GF
   --
   --  Least Significant Limb ("LSL") of a Seminormal GF.
   --  LSL is initially normalized to 0 .. 65535, but gets
   --  R2256 * Carry added to it, where Carry is (Limb 15 / 65536)
   --  The upper-bound on Limb 15 is given by substituting I = 14
   --  into the Dynamic_Predicate above, so
   --    (MGFLC - 37 * 14) * MGFLP = 53 * MGFLP
   --  See the body of Product_To_Seminormal for the full
   --  proof of this upper-bound
   subtype Seminormal_GF_LSL is GF32_Any_Limb
     range 0 .. GF32_Any_Limb_Max;

   --  Limbs 1 though 15 are in 0 .. 65535, but the
   --  Least Significant Limb 0 is in GF_Seminormal_Product_LSL
   subtype Seminormal_GF is GF32
     with Dynamic_Predicate =>
       (Seminormal_GF (0) in Seminormal_GF_LSL and
         (for all I in Index_16 range 1 .. 15 =>
           Seminormal_GF (I) in GF32_Normal_Limb));

   ------------------------------------------------------------------------
   --  A "Nearly-normal GF" is the result of applying either:
   --  1. TWO normalization steps to a Product_GF
   --  OR
   --  2. ONE normalization step to the SUM of 2 normalized GFs
   --  OR
   --  3. ONE normalization step to the DIFFERENCE of 2 normalized GFs
   --
   --  The least-significant-limb is normalized to 0 .. 65535, but then
   --  has +R2256 or -R2256 added to it, so its range is...
   subtype Nearlynormal_GF is GF32
     with Dynamic_Predicate =>
        ((Nearlynormal_GF (0) in -R2256 .. LMM1 + R2256) and
           (for all K in Index_16 range 1 .. 15 =>
              (Nearlynormal_GF (K) in GF32_Normal_Limb)));

   ------------------------------------------------------------------------

   --=================================================
   --  Constants, used in more than one child package
   --=================================================

   GF_0      : constant Normal_GF   := (others => 0);
   GF32_0    : constant Normal_GF32 := (others => 0);
   GF_1      : constant Normal_GF   := (1, others => 0);

   --==================
   --  Local functions
   --==================

   --  returns equivalent of X >> 16 in C, doing an arithmetic
   --  shift right when X is negative, assuming 2's complement
   --  representation
   function ASR64_16 (X : in I64) return I64
   is (Shift_Right_Arithmetic (X, 16))
     with Post => (if X >= 0 then ASR64_16'Result = X / LM else
                                  ASR64_16'Result = ((X + 1) / LM) - 1);

   --  returns equivalent of X >> 16 in C, doing an arithmetic
   --  shift right when X is negative, assuming 2's complement
   --  representation
   function ASR32_16 (X : in I32) return I32
   is (Shift_Right_Arithmetic (X, 16))
     with Post => (if X >= 0 then ASR32_16'Result = X / LM else
                                  ASR32_16'Result = ((X + 1) / LM) - 1);

   --  returns equivalent of X >> 8 in C, doing an arithmetic
   --  shift right when X is negative, assuming 2's complement
   --  representation
   function ASR_8 (X : in I64) return I64
   is (Shift_Right_Arithmetic (X, 8))
     with Post => (if X >= 0 then ASR_8'Result = X / 256 else
                                  ASR_8'Result = ((X + 1) / 256) - 1);

   --  returns equivalent of X >> 4 in C, doing an arithmetic
   --  shift right when X is negative, assuming 2's complement
   --  representation
   function ASR_4 (X : in I64) return I64
   is (Shift_Right_Arithmetic (X, 4))
     with Post => (if X >= 0 then ASR_4'Result = X / 16 else
                                  ASR_4'Result = ((X + 1) / 16) - 1);

   --===============================
   --  Local subprogram declarations
   --===============================

   function "+" (Left, Right : in Normal_GF) return Normal_GF
     with Pure_Function,
          Global => null;

   function "-" (Left, Right : in Normal_GF) return Normal_GF
     with Pure_Function,
          Global => null;

   function "*" (Left, Right : in Normal_GF) return Normal_GF
     with Pure_Function,
          Global => null;

   function Square (A : in Normal_GF) return Normal_GF
     is (A * A)
     with Pure_Function,
          Global => null;


   --  Additional sanitization procedures for local types
   procedure Sanitize_U32 (R : out U32)
     with Global => null,
          No_Inline;

   procedure Sanitize_U16 (R : out U16)
     with Global => null,
          No_Inline;

   procedure Sanitize_U64 (R : out U64)
     with Global => null,
          No_Inline;

   procedure Sanitize_GF32 (R : out GF32)
     with Global => null,
          No_Inline,
          Post => R in Normal_GF32;

   procedure Sanitize_GF16 (R : out Normal_GF)
     with Global => null,
          No_Inline,
          Post => R in Normal_GF;

   procedure Sanitize_GF64_PA (R : out GF64_PA)
     with Global => null,
          No_Inline;

   procedure Sanitize_I64_Seq (R : out I64_Seq)
     with Global => null,
          No_Inline;

   procedure Sanitize_Boolean (R : out Boolean)
     with Global => null,
          No_Inline;

end SPARKNaCl;
