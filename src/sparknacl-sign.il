Source recreated from tree for Sparknacl.Sign (body)
----------------------------------------------------

with sparknacl;
with sparknacl;
with sparknacl.sparknacl__utils;
with sparknacl.sparknacl__hashing;
with interfaces;

package body sparknacl.sparknacl__sign is
   pragma spark_mode (on);
   sparknacl__sign__gf_d : constant sparknacl__normal_gf := (30883,
     4953, 19914, 30187, 55467, 16705, 2637, 112, 59544, 30585, 16505,
     36039, 65139, 11119, 27886, 20995);
   sparknacl__sign__gf_i : constant sparknacl__normal_gf := (41136,
     18958, 6951, 50414, 58488, 44335, 6150, 12099, 55207, 15867, 153,
     11085, 57099, 20417, 9344, 11139);
   sparknacl__sign__gf_x : constant sparknacl__normal_gf := (54554,
     36645, 11616, 51542, 42930, 38181, 51040, 26924, 56412, 64982,
     57905, 49316, 21502, 52590, 14035, 8553);
   sparknacl__sign__gf_y : constant sparknacl__normal_gf := (26200,
     26214, 26214, 26214, 26214, 26214, 26214, 26214, 26214, 26214,
     26214, 26214, 26214, 26214, 26214, 26214);
   sparknacl__sign__gf_xy : constant sparknacl__normal_gf := (
     56720, 42423, 35507, 28126, 21237, 30545, 40832, 8432, 58237,
     25771, 20110, 26346, 30309, 55179, 24335, 59271);
   sparknacl__sign__gf_d2 : constant sparknacl__normal_gf := (
     61785, 9906, 39828, 60374, 45398, 33411, 5274, 224, 53552,
     61171, 33010, 6542, 64743, 22239, 55772, 9222);
   type sparknacl__sign__gf_vector_4 is array (0 .. 3) of
     sparknacl__normal_gf;
   sparknacl__sign__mbp : constant  := (65025);
   sparknacl__sign__max_x_limb : constant  := 2081055;
   function sparknacl__sign__modl (x : in sparknacl__i64_seq_64)
     return sparknacl__bytes_32
     with pure_function,
          global => null,
          pre => ( for all k in sparknacl__index_64 => x (k) in 0 ..
            2081055);
   pragma precondition (check => ( for all k in sparknacl__index_64 =>
     x (k) in 0 .. 2081055), message =>
     "failed precondition from sparknacl-sign.adb:57");
   pragma global (null);
   pragma pure_function (sparknacl__sign__modl);
   procedure sparknacl__sign__sanitize_gf_vector_4 (r : out
     sparknacl__sign__gf_vector_4)
     with global => null;
   pragma global (null);
   function sparknacl__sign__Oadd (left : in
     sparknacl__sign__gf_vector_4; right : in
     sparknacl__sign__gf_vector_4) return sparknacl__sign__gf_vector_4
     with pure_function,
          global => null;
   pragma global (null);
   pragma pure_function (sparknacl__sign__Oadd);
   function sparknacl__sign__scalarmult (q : in
     sparknacl__sign__gf_vector_4; s : in sparknacl__bytes_32) return
     sparknacl__sign__gf_vector_4
     with pure_function,
          global => null;
   pragma global (null);
   pragma pure_function (sparknacl__sign__scalarmult);
   function sparknacl__sign__scalarbase (s : in sparknacl__bytes_32)
     return sparknacl__sign__gf_vector_4
     with pure_function,
          global => null;
   pragma global (null);
   pragma pure_function (sparknacl__sign__scalarbase);
   function sparknacl__sign__pack (p : in sparknacl__sign__gf_vector_4)
     return sparknacl__bytes_32
     with pure_function,
          global => null;
   pragma global (null);
   pragma pure_function (sparknacl__sign__pack);
   subtype sparknacl__sign__bit is sparknacl__byte range 0 .. 1;
   function sparknacl__sign__par_25519 (a : in sparknacl__normal_gf)
     return sparknacl__sign__bit
     with pure_function,
          global => null;
   pragma global (null);
   pragma pure_function (sparknacl__sign__par_25519);
   function sparknacl__sign__hash_reduce (m : in sparknacl__byte_seq)
     return sparknacl__bytes_32
     with pure_function,
          global => null;
   pragma global (null);
   pragma pure_function (sparknacl__sign__hash_reduce);
   procedure sparknacl__sign__unpackneg (r : out
     sparknacl__sign__gf_vector_4; ok : out boolean; p : in
     sparknacl__bytes_32)
     with global => null;
   pragma global (null);
   [type sparknacl__sign__Tgf_vector_4B is array (0 .. 3 range <>) of
     sparknacl__normal_gf]
   freeze sparknacl__sign__Tgf_vector_4B [
      procedure sparknacl__sign__Tgf_vector_4BIP (_init : in out
        sparknacl__sign__Tgf_vector_4B) is
      begin
         return;
      end sparknacl__sign__Tgf_vector_4BIP;
   ]

   procedure sparknacl__sign__sanitize_gf_vector_4 (r : out
     sparknacl__sign__gf_vector_4) is
      L_1 : label
   begin
      L_1 : for i in 0 .. 3 loop
         pragma loop_optimize (no_unroll);
         sparknacl__sanitize_gf16 (r (i));
      end loop L_1;
      return;
   end sparknacl__sign__sanitize_gf_vector_4;

   function sparknacl__sign__Oadd (left : in
     sparknacl__sign__gf_vector_4; right : in
     sparknacl__sign__gf_vector_4) return sparknacl__sign__gf_vector_4 is
      a : sparknacl__normal_gf;
      b : sparknacl__normal_gf;
      c : sparknacl__normal_gf;
      d : sparknacl__normal_gf;
      e : sparknacl__normal_gf;
      f : sparknacl__normal_gf;
      g : sparknacl__normal_gf;
      h : sparknacl__normal_gf;
      function sparknacl__sign__Oadd__double (x : in
        sparknacl__normal_gf) return sparknacl__normal_gf
        with pure_function,
             global => null;
      pragma global (null);
      pragma pure_function (sparknacl__sign__Oadd__double);

      function sparknacl__sign__Oadd__double (x : in
        sparknacl__normal_gf) return sparknacl__normal_gf is
      begin
         return (sparknacl__Oadd (x, x));
      end sparknacl__sign__Oadd__double;
   begin
      a := sparknacl__Omultiply ((sparknacl__Osubtract (left (1), left
        (0))), (sparknacl__Osubtract (right (1), right (0))));
      b := sparknacl__Omultiply ((sparknacl__Oadd (left (0), left (
        1))), (sparknacl__Oadd (right (0), right (1))));
      c := sparknacl__Omultiply ((sparknacl__Omultiply (left (3), right
        (3))), sparknacl__sign__gf_d2);
      d := sparknacl__sign__Oadd__double (sparknacl__Omultiply (left (
        2), right (2)));
      e := sparknacl__Osubtract (d, c);
      f := sparknacl__Oadd (d, c);
      g := sparknacl__Osubtract (b, a);
      h := sparknacl__Oadd (b, a);
      return sparknacl__sign__gf_vector_4'((sparknacl__Omultiply (g, e),
        sparknacl__Omultiply (h, f), sparknacl__Omultiply (f, e),
        sparknacl__Omultiply (g, h)));
   end sparknacl__sign__Oadd;

   function sparknacl__sign__scalarmult (q : in
     sparknacl__sign__gf_vector_4; s : in sparknacl__bytes_32) return
     sparknacl__sign__gf_vector_4 is
      cb : sparknacl__byte;
      swap : boolean;
      lp : sparknacl__sign__gf_vector_4;
      lq : sparknacl__sign__gf_vector_4;
      procedure sparknacl__sign__scalarmult__cswap (p : in out
        sparknacl__sign__gf_vector_4; q : in out
        sparknacl__sign__gf_vector_4; swap : in boolean)
        with global => null;
      pragma global (null);

      procedure sparknacl__sign__scalarmult__cswap (p : in out
        sparknacl__sign__gf_vector_4; q : in out
        sparknacl__sign__gf_vector_4; swap : in boolean) is
         L_2 : label
      begin
         L_2 : for i in 0 .. 3 loop
            pragma loop_optimize (no_unroll);
            sparknacl__utils.sparknacl__utils__cswap16 (p (i), q (i),
              swap);
         end loop L_2;
         return;
      end sparknacl__sign__scalarmult__cswap;

      L_4 : label
      L_3 : label
   begin
      lp := (sparknacl__gf_0, sparknacl__gf_1, sparknacl__gf_1,
        sparknacl__gf_0);
      lq := q;
      L_3 : for i in reverse 0 .. 31 loop
         pragma loop_optimize (no_unroll);
         cb := s (i);
         L_4 : for j in reverse natural range 0 .. 7 loop
            pragma loop_optimize (no_unroll);
            swap := boolean?(interfaces__shift_right!(cb, j) rem 2);
            sparknacl__sign__scalarmult__cswap (lp, lq, swap);
            lq := sparknacl__sign__Oadd (lq, lp);
            lp := sparknacl__sign__Oadd (lp, lp);
            sparknacl__sign__scalarmult__cswap (lp, lq, swap);
         end loop L_4;
      end loop L_3;
      return lp;
   end sparknacl__sign__scalarmult;

   function sparknacl__sign__scalarbase (s : in sparknacl__bytes_32)
     return sparknacl__sign__gf_vector_4 is
   begin
      return sparknacl__sign__scalarmult (sparknacl__sign__gf_vector_4'(
        (sparknacl__sign__gf_x, sparknacl__sign__gf_y, sparknacl__gf_1,
        sparknacl__sign__gf_xy)), s);
   end sparknacl__sign__scalarbase;

   function sparknacl__sign__par_25519 (a : in sparknacl__normal_gf)
     return sparknacl__sign__bit is
      d : sparknacl__bytes_32;
   begin
      d := sparknacl__utils.sparknacl__utils__pack_25519 (a);
      return (sparknacl__sign__bit((d (0) rem 2)));
   end sparknacl__sign__par_25519;

   function sparknacl__sign__pack (p : in sparknacl__sign__gf_vector_4)
     return sparknacl__bytes_32 is
      tx : sparknacl__normal_gf;
      ty : sparknacl__normal_gf;
      zi : sparknacl__normal_gf;
      r : sparknacl__bytes_32;
   begin
      zi := sparknacl__utils.sparknacl__utils__inv_25519 (p (2));
      tx := sparknacl__Omultiply (p (0), zi);
      ty := sparknacl__Omultiply (p (1), zi);
      r := sparknacl__utils.sparknacl__utils__pack_25519 (ty);
      r (31) := r (31) xor (sparknacl__sign__par_25519 (tx) * 128);
      return r;
   end sparknacl__sign__pack;

   sparknacl__sign__max_l : constant  := 249;
   sparknacl__sign__l31 : constant  := 16;
   subtype sparknacl__sign__l_limb is sparknacl__i64_byte range 0 ..
     249;
   type sparknacl__sign__l_table is array (0 .. 31) of
     sparknacl__sign__l_limb;
   [type sparknacl__sign__Tl_tableB is array (0 .. 31 range <>) of
     sparknacl__sign__l_limb]
   freeze sparknacl__sign__Tl_tableB [
      procedure sparknacl__sign__Tl_tableBIP (_init : in out
        sparknacl__sign__Tl_tableB) is
      begin
         return;
      end sparknacl__sign__Tl_tableBIP;
   ]
   sparknacl__sign__l : constant sparknacl__sign__l_table := (237,
     211, 245, 92, 26, 99, 18, 88, 214, 156, 247, 162, 222, 249, 222,
     20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16);
   subtype sparknacl__sign__l16_limb is sparknacl__i64 range 0 .. (
     3984);
   type sparknacl__sign__l16_table is array (0 .. 31) of
     sparknacl__sign__l16_limb;
   [type sparknacl__sign__Tl16_tableB is array (0 .. 31 range <>) of
     sparknacl__sign__l16_limb]
   freeze sparknacl__sign__Tl16_tableB [
      procedure sparknacl__sign__Tl16_tableBIP (_init : in out
        sparknacl__sign__Tl16_tableB) is
      begin
         return;
      end sparknacl__sign__Tl16_tableBIP;
   ]
   sparknacl__sign__l16 : constant sparknacl__sign__l16_table := (3792,
     3376, 3920, 1472, 416, 1584, 288, 1408, 3424, 2496, 3952, 2592,
     3552, 3984, 3552, 320, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
     0, 0, 256);

   function sparknacl__sign__modl (x : in sparknacl__i64_seq_64)
     return sparknacl__bytes_32 is
      max_carry : constant  := 16384;
      min_carry : constant  := -16#2000_000#;
      subtype sparknacl__sign__modl__carry_t is sparknacl__i64 range
        -16#2000_000# .. 16384;
      min_adjustment : constant  := (-133680857088);
      max_adjustment : constant  := (8356196976);
      subtype sparknacl__sign__modl__adjustment_t is sparknacl__i64
        range -133680857088 .. 8356196976;
      subtype sparknacl__sign__modl__xl_limb is sparknacl__i64 range
        -33299444949360 .. (33299444949360);
      type sparknacl__sign__modl__xl_table is array (0 .. 63) of
        sparknacl__sign__modl__xl_limb;
      [type sparknacl__sign__modl__Txl_tableB is array (0 .. 63 range <>) of
        sparknacl__sign__modl__xl_limb]
      freeze sparknacl__sign__modl__Txl_tableB []
      xl : sparknacl__sign__modl__xl_table;
      subtype sparknacl__sign__modl__prl is sparknacl__i64 range -129 ..
        128;
      subtype sparknacl__sign__modl__frl is sparknacl__sign__modl__prl
        range -128 .. 127;
      r : sparknacl__bytes_32;
      max_l63_carry : constant  := 8161;
      subtype sparknacl__sign__modl__xl51_t is sparknacl__i64 range
        0 .. (2089216);
      procedure sparknacl__sign__modl__initialize_xl
        with global => (
                input => x,
                output => xl),
             pre => ( for all k in sparknacl__index_64 => x (k) in
               0 .. 2081055),
             post => ( for all k in sparknacl__index_64 => xl (k) >=
               0) and ( for all k in sparknacl__index_64 => xl (k) <=
               2081055) and ( for all k in sparknacl__index_64 => xl (k) =
               sparknacl__sign__modl__xl_limb(x (k)));
      pragma postcondition (check => ( for all k in sparknacl__index_64 =>
        xl (k) >= 0) and ( for all k in sparknacl__index_64 => xl (k) <=
        2081055) and ( for all k in sparknacl__index_64 => xl (k) =
        sparknacl__sign__modl__xl_limb(x (k))), message =>
        "failed postcondition from sparknacl-sign.adb:282");
      pragma precondition (check => ( for all k in sparknacl__index_64 =>
        x (k) in 0 .. 2081055), message =>
        "failed precondition from sparknacl-sign.adb:281");
      pragma global ((
         input => x,
         output => xl));
      procedure sparknacl__sign__modl__eliminate_limb_63
        with global => (
                proof_in => x,
                in_out => xl),
             pre =>  for all k in sparknacl__index_64 => xl (k) =
               sparknacl__sign__modl__xl_limb(x (k)),
             pre =>  for all k in sparknacl__index_64 => xl (k) <=
               2081055,
             pre =>  for all k in sparknacl__index_64 => xl (k) >=
               0,
             pre => ( for all k in sparknacl__index_64 => x (k) in
               0 .. 2081055),
             post => ( for all k in sparknacl__index_64 range 0 ..
               30 => xl (k) = x (k)) and ( for all k in
               sparknacl__index_64 range 31 .. 50 => xl (k) in
               sparknacl__sign__modl__frl) and (xl (51) in
               sparknacl__sign__modl__xl51_t) and ( for all k in
               sparknacl__index_64 range 52 .. 62 => xl (k) = x (k)) and
               (xl (63) = 0);
      pragma postcondition (check => ( for all k in sparknacl__index_64
        range 0 .. 30 => xl (k) = x (k)) and ( for all k in
        sparknacl__index_64 range 31 .. 50 => xl (k) in
        sparknacl__sign__modl__frl) and (xl (51) in
        sparknacl__sign__modl__xl51_t) and ( for all k in
        sparknacl__index_64 range 52 .. 62 => xl (k) = x (k)) and (xl (
        63) = 0), message =>
        "failed postcondition from sparknacl-sign.adb:294");
      pragma precondition (check => ( for all k in sparknacl__index_64 =>
        x (k) in 0 .. 2081055), message =>
        "failed precondition from sparknacl-sign.adb:289");
      pragma precondition (check =>  for all k in sparknacl__index_64 =>
        xl (k) >= 0, message =>
        "failed precondition from sparknacl-sign.adb:291");
      pragma precondition (check =>  for all k in sparknacl__index_64 =>
        xl (k) <= 2081055, message =>
        "failed precondition from sparknacl-sign.adb:292");
      pragma precondition (check =>  for all k in sparknacl__index_64 =>
        xl (k) = sparknacl__sign__modl__xl_limb(x (k)), message =>
        "failed precondition from sparknacl-sign.adb:293");
      pragma global ((
         proof_in => x,
         in_out => xl));
      procedure sparknacl__sign__modl__eliminate_limbs_62_to_32
        with global => (
                proof_in => x,
                in_out => xl),
             pre => (( for all k in sparknacl__index_64 range 0 ..
               30 => xl (k) = x (k) and xl (k) in 0 .. 2081055) and ( for all
               k in sparknacl__index_64 range 31 .. 50 => xl (k) in
               sparknacl__sign__modl__frl) and (xl (51) in
               sparknacl__sign__modl__xl51_t) and ( for all k in
               sparknacl__index_64 range 52 .. 62 => xl (k) = x (k) and
               xl (k) in 0 .. 2081055) and (xl (63) = 0)),
             post => (( for all k in sparknacl__index_64 range 0 ..
               19 => xl (k) in sparknacl__sign__modl__frl) and ( for all
               k in sparknacl__index_64 range 20 .. 31 => xl (k) in
               sparknacl__sign__modl__prl) and ( for all k in
               sparknacl__index_64 range 32 .. 63 => xl (k) = 0));
      pragma postcondition (check => (( for all k in
        sparknacl__index_64 range 0 .. 19 => xl (k) in
        sparknacl__sign__modl__frl) and ( for all k in
        sparknacl__index_64 range 20 .. 31 => xl (k) in
        sparknacl__sign__modl__prl) and ( for all k in
        sparknacl__index_64 range 32 .. 63 => xl (k) = 0)), message =>
        "failed postcondition from sparknacl-sign.adb:316");
      pragma precondition (check => (( for all k in sparknacl__index_64
        range 0 .. 30 => xl (k) = x (k) and xl (k) in 0 .. 2081055) and
        ( for all k in sparknacl__index_64 range 31 .. 50 => xl (k) in
        sparknacl__sign__modl__frl) and (xl (51) in
        sparknacl__sign__modl__xl51_t) and ( for all k in
        sparknacl__index_64 range 52 .. 62 => xl (k) = x (k) and xl (k) in
        0 .. 2081055) and (xl (63) = 0)), message =>
        "failed precondition from sparknacl-sign.adb:306");
      pragma global ((
         proof_in => x,
         in_out => xl));
      procedure sparknacl__sign__modl__finalize
        with global => (
                in_out => xl,
                output => r),
             pre => (( for all k in sparknacl__index_64 range 0 ..
               19 => xl (k) in sparknacl__sign__modl__frl) and ( for all
               k in sparknacl__index_64 range 20 .. 31 => xl (k) in
               sparknacl__sign__modl__prl) and ( for all k in
               sparknacl__index_64 range 32 .. 63 => xl (k) = 0));
      pragma precondition (check => (( for all k in sparknacl__index_64
        range 0 .. 19 => xl (k) in sparknacl__sign__modl__frl) and ( for all
        k in sparknacl__index_64 range 20 .. 31 => xl (k) in
        sparknacl__sign__modl__prl) and ( for all k in
        sparknacl__index_64 range 32 .. 63 => xl (k) = 0)), message =>
        "failed precondition from sparknacl-sign.adb:325");
      pragma global ((
         in_out => xl,
         output => r));

      procedure sparknacl__sign__modl__initialize_xl is
         L_5 : label
      begin
         xl := (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
           0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
           0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
           0, 0, 0, 0, 0, 0, 0, 0, 0);
         L_5 : for k in 0 .. 63 loop
            pragma loop_optimize (no_unroll);
            R91b : constant sparknacl__i64 := x (k);
            [constraint_error when
              not (R91b in -33299444949360 .. 33299444949360)
              "range check failed"]
            xl (k) := sparknacl__sign__modl__xl_limb(R91b);
         end loop L_5;
         return;
      end sparknacl__sign__modl__initialize_xl;

      procedure sparknacl__sign__modl__eliminate_limb_63 is
         max_l63_adjustment : constant  := 8290923120;
         subtype
           sparknacl__sign__modl__eliminate_limb_63__l63_adjustment_t is
           sparknacl__i64 range 0 .. 8290923120;
         min_l63_carry : constant  := -32513424;
         subtype sparknacl__sign__modl__eliminate_limb_63__l63_carry_t is
           sparknacl__i64 range -32513424 .. 8161;
         carry : sparknacl__sign__modl__eliminate_limb_63__l63_carry_t;
         adjustment :
           sparknacl__sign__modl__eliminate_limb_63__l63_adjustment_t;
         xl63 : sparknacl__sign__modl__xl_limb;
         B_7 : label
         L_6 : label
         B_8 : label
      begin
         carry := 0;
         xl63 := xl (63);
         L_6 : for j in sparknacl__i32 range 31 .. 46 loop
            pragma loop_optimize (no_unroll);
            B_7 : declare
               xlj : sparknacl__sign__modl__xl_limb renames xl (j);
            begin
               [type interfaces__Tinteger_64B is new long_long_integer]
               R102b : constant interfaces__Tinteger_64B := (
                 sparknacl__sign__l16 (j - 31)) * xl63;
               [constraint_error when
                 not (R102b in 0 .. 8290923120)
                 "range check failed"]
               adjustment := R102b;
               R103b : constant interfaces__Tinteger_64B := xlj + carry -
                 adjustment;
               [constraint_error when
                 not (R103b in -33299444949360 .. 33299444949360)
                 "range check failed"]
               xlj := R103b;
               R104b : constant sparknacl__i64 := sparknacl__asr_8 (xlj +
                 128);
               [constraint_error when
                 not (R104b in -32513424 .. 8161)
                 "range check failed"]
               carry := R104b;
               R105b : constant interfaces__Tinteger_64B := xlj - (
                 carry * 256);
               [constraint_error when
                 not (R105b in -33299444949360 .. 33299444949360)
                 "range check failed"]
               xlj := R105b;
            end B_7;
         end loop L_6;
         B_8 : declare
            min_xl47_carry : constant  := -127006;
            min_xl48_carry : constant  := -496;
            min_xl49_carry : constant  := -2;
            min_xl50_carry : constant  := (0);
         begin
            R148b : constant interfaces__Tinteger_64B := xl (47) +
              carry;
            [constraint_error when
              not (R148b in -33299444949360 .. 33299444949360)
              "range check failed"]
            xl (47) := R148b;
            R149b : constant sparknacl__i64 := sparknacl__asr_8 (xl (
              47) + 128);
            [constraint_error when
              not (R149b in -32513424 .. 8161)
              "range check failed"]
            carry := R149b;
            R150b : constant interfaces__Tinteger_64B := xl (47) - (
              carry * 256);
            [constraint_error when
              not (R150b in -33299444949360 .. 33299444949360)
              "range check failed"]
            xl (47) := R150b;
            R151b : constant interfaces__Tinteger_64B := xl (48) +
              carry;
            [constraint_error when
              not (R151b in -33299444949360 .. 33299444949360)
              "range check failed"]
            xl (48) := R151b;
            R152b : constant sparknacl__i64 := sparknacl__asr_8 (xl (
              48) + 128);
            [constraint_error when
              not (R152b in -32513424 .. 8161)
              "range check failed"]
            carry := R152b;
            R153b : constant interfaces__Tinteger_64B := xl (48) - (
              carry * 256);
            [constraint_error when
              not (R153b in -33299444949360 .. 33299444949360)
              "range check failed"]
            xl (48) := R153b;
            R154b : constant interfaces__Tinteger_64B := xl (49) +
              carry;
            [constraint_error when
              not (R154b in -33299444949360 .. 33299444949360)
              "range check failed"]
            xl (49) := R154b;
            R155b : constant sparknacl__i64 := sparknacl__asr_8 (xl (
              49) + 128);
            [constraint_error when
              not (R155b in -32513424 .. 8161)
              "range check failed"]
            carry := R155b;
            R156b : constant interfaces__Tinteger_64B := xl (49) - (
              carry * 256);
            [constraint_error when
              not (R156b in -33299444949360 .. 33299444949360)
              "range check failed"]
            xl (49) := R156b;
            R157b : constant interfaces__Tinteger_64B := xl (50) +
              carry;
            [constraint_error when
              not (R157b in -33299444949360 .. 33299444949360)
              "range check failed"]
            xl (50) := R157b;
            R158b : constant sparknacl__i64 := sparknacl__asr_8 (xl (
              50) + 128);
            [constraint_error when
              not (R158b in -32513424 .. 8161)
              "range check failed"]
            carry := R158b;
            R159b : constant interfaces__Tinteger_64B := xl (50) - (
              carry * 256);
            [constraint_error when
              not (R159b in -33299444949360 .. 33299444949360)
              "range check failed"]
            xl (50) := R159b;
         end B_8;
         R178b : constant interfaces__Tinteger_64B := xl (51) + carry;
         [constraint_error when
           not (R178b in -33299444949360 .. 33299444949360)
           "range check failed"]
         xl (51) := R178b;
         xl (63) := 0;
         return;
      end sparknacl__sign__modl__eliminate_limb_63;

      procedure sparknacl__sign__modl__eliminate_limbs_62_to_32 is
         carry : sparknacl__sign__modl__carry_t;
         adjustment : sparknacl__sign__modl__adjustment_t;
         xli : sparknacl__sign__modl__xl_limb;
         B_11 : label
         L_10 : label
         L_9 : label
      begin
         L_9 : for i in reverse sparknacl__i32 range 32 .. 62 loop
            pragma loop_optimize (no_unroll);
            carry := 0;
            xli := xl (i);
            L_10 : for j in sparknacl__i32 range (i - 32) .. (i - 17)
              loop
               pragma loop_optimize (no_unroll);
               B_11 : declare
                  xlj : sparknacl__sign__modl__xl_limb renames xl (j);
               begin
                  [constraint_error when
                    not (j {-} (i - 32) in 0 .. 31)
                    "index check failed"]
                  R181b : constant interfaces__Tinteger_64B := (
                    sparknacl__sign__l16 (j - (i - 32))) * xli;
                  [constraint_error when
                    not (R181b in -133680857088 .. 8356196976)
                    "range check failed"]
                  adjustment := R181b;
                  R182b : constant interfaces__Tinteger_64B := xlj +
                    carry - adjustment;
                  [constraint_error when
                    not (R182b in -33299444949360 .. 33299444949360)
                    "range check failed"]
                  xlj := R182b;
                  R183b : constant sparknacl__i64 := sparknacl__asr_8 (
                    xlj + 128);
                  [constraint_error when
                    not (R183b in -16#2000_000# .. 16384)
                    "range check failed"]
                  carry := R183b;
                  R184b : constant interfaces__Tinteger_64B := xlj - (
                    carry * 256);
                  [constraint_error when
                    not (R184b in -33299444949360 .. 33299444949360)
                    "range check failed"]
                  xlj := R184b;
               end B_11;
            end loop L_10;
            R244b : constant interfaces__Tinteger_64B := xl (i - 16) +
              carry;
            [constraint_error when
              not (R244b in -33299444949360 .. 33299444949360)
              "range check failed"]
            xl (i - 16) := R244b;
            R245b : constant sparknacl__i64 := sparknacl__asr_8 (xl (i -
              16) + 128);
            [constraint_error when
              not (R245b in -16#2000_000# .. 16384)
              "range check failed"]
            carry := R245b;
            R246b : constant interfaces__Tinteger_64B := xl (i - 16) -
              (carry * 256);
            [constraint_error when
              not (R246b in -33299444949360 .. 33299444949360)
              "range check failed"]
            xl (i - 16) := R246b;
            R253b : constant interfaces__Tinteger_64B := xl (i - 15) +
              carry;
            [constraint_error when
              not (R253b in -33299444949360 .. 33299444949360)
              "range check failed"]
            xl (i - 15) := R253b;
            R254b : constant sparknacl__i64 := sparknacl__asr_8 (xl (i -
              15) + 128);
            [constraint_error when
              not (R254b in -16#2000_000# .. 16384)
              "range check failed"]
            carry := R254b;
            R255b : constant interfaces__Tinteger_64B := xl (i - 15) -
              (carry * 256);
            [constraint_error when
              not (R255b in -33299444949360 .. 33299444949360)
              "range check failed"]
            xl (i - 15) := R255b;
            R262b : constant interfaces__Tinteger_64B := xl (i - 14) +
              carry;
            [constraint_error when
              not (R262b in -33299444949360 .. 33299444949360)
              "range check failed"]
            xl (i - 14) := R262b;
            R263b : constant sparknacl__i64 := sparknacl__asr_8 (xl (i -
              14) + 128);
            [constraint_error when
              not (R263b in -16#2000_000# .. 16384)
              "range check failed"]
            carry := R263b;
            R264b : constant interfaces__Tinteger_64B := xl (i - 14) -
              (carry * 256);
            [constraint_error when
              not (R264b in -33299444949360 .. 33299444949360)
              "range check failed"]
            xl (i - 14) := R264b;
            R271b : constant interfaces__Tinteger_64B := xl (i - 13) +
              carry;
            [constraint_error when
              not (R271b in -33299444949360 .. 33299444949360)
              "range check failed"]
            xl (i - 13) := R271b;
            R272b : constant sparknacl__i64 := sparknacl__asr_8 (xl (i -
              13) + 128);
            [constraint_error when
              not (R272b in -16#2000_000# .. 16384)
              "range check failed"]
            carry := R272b;
            R273b : constant interfaces__Tinteger_64B := xl (i - 13) -
              (carry * 256);
            [constraint_error when
              not (R273b in -33299444949360 .. 33299444949360)
              "range check failed"]
            xl (i - 13) := R273b;
            R280b : constant interfaces__Tinteger_64B := xl (i - 12) +
              carry;
            [constraint_error when
              not (R280b in -33299444949360 .. 33299444949360)
              "range check failed"]
            xl (i - 12) := R280b;
            xl (i) := 0;
         end loop L_9;
         return;
      end sparknacl__sign__modl__eliminate_limbs_62_to_32;

      procedure sparknacl__sign__modl__finalize is
         final_carry_min : constant  := -9;
         final_carry_max : constant  := 9;
         subtype sparknacl__sign__modl__finalize__final_carry_t is
           sparknacl__i64 range -9 .. 9;
         subtype sparknacl__sign__modl__finalize__step1_xl_limb is
           sparknacl__i64 range (-2304) .. 2559;
         subtype sparknacl__sign__modl__finalize__step2_xl_limb is
           sparknacl__i64 range -2241 .. 2496;
         carry : sparknacl__sign__modl__finalize__final_carry_t;
         L_12 : label
         L_13 : label
         B_14 : label
      begin
         carry := 0;
         L_12 : for j in 0 .. 31 loop
            pragma loop_optimize (no_unroll);
            R326b : constant interfaces__Tinteger_64B := xl (j) {+} (
              carry {-} sparknacl__asr_4 (xl (31)) {*}
              sparknacl__sign__l (j));
            [constraint_error when
              not (R326b in -33299444949360 .. 33299444949360)
              "range check failed"]
            xl (j) := R326b;
            R327b : constant sparknacl__i64 := sparknacl__asr_8 (xl (j));
            [constraint_error when
              not (R327b in -9 .. 9)
              "range check failed"]
            carry := R327b;
            xl (j) := xl (j) mod 256;
         end loop L_12;
         L_13 : for j in 0 .. 31 loop
            pragma loop_optimize (no_unroll);
            R372b : constant interfaces__Tinteger_64B := xl (j) - carry *
              sparknacl__sign__l (j);
            [constraint_error when
              not (R372b in -33299444949360 .. 33299444949360)
              "range check failed"]
            xl (j) := R372b;
         end loop L_13;
         B_14 : declare
            mxlc : constant  := 10;
            subtype sparknacl__sign__modl__finalize__B_14__s3ct is
              sparknacl__i64 range -10 .. 10;
            s3c : sparknacl__sign__modl__finalize__B_14__s3ct;
            L_15 : label
         begin
            L_15 : for i in 0 .. 31 loop
               pragma loop_optimize (no_unroll);
               R399b : constant sparknacl__i64 := sparknacl__asr_8 (xl
                 (i));
               [constraint_error when
                 not (R399b in -10 .. 10)
                 "range check failed"]
               s3c := R399b;
               R400b : constant interfaces__Tinteger_64B := xl (i +
                 1) + s3c;
               [constraint_error when
                 not (R400b in -33299444949360 .. 33299444949360)
                 "range check failed"]
               xl (i + 1) := R400b;
               r (i) := sparknacl__byte(xl (i) mod 256);
            end loop L_15;
         end B_14;
         return;
      end sparknacl__sign__modl__finalize;
   begin
      sparknacl__sign__modl__initialize_xl;
      sparknacl__sign__modl__eliminate_limb_63;
      sparknacl__sign__modl__eliminate_limbs_62_to_32;
      sparknacl__sign__modl__finalize;
      return r;
   end sparknacl__sign__modl;

   function sparknacl__sign__hash_reduce (m : in sparknacl__byte_seq)
     return sparknacl__bytes_32 is
      subtype sparknacl__sign__hash_reduce__S426b is
        sparknacl__byte_seq (m'first(1) .. m'last(1));
      r : sparknacl__hashing.sparknacl__hashing__digest;
      x : sparknacl__i64_seq_64;
      L_16 : label
   begin
      sparknacl__hashing.sparknacl__hashing__hash (r, m);
      x := (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0);
      L_16 : for i in 0 .. 63 loop
         pragma loop_optimize (no_unroll);
         x (i) := sparknacl__i64(r (i));
      end loop L_16;
      return sparknacl__sign__modl (x);
   end sparknacl__sign__hash_reduce;

   procedure sparknacl__sign__unpackneg (r : out
     sparknacl__sign__gf_vector_4; ok : out boolean; p : in
     sparknacl__bytes_32) is
      function sparknacl__sign__unpackneg__Oeq (left : in
        sparknacl__normal_gf; right : in sparknacl__normal_gf) return
        boolean
        with pure_function,
             global => null;
      pragma global (null);
      pragma pure_function (sparknacl__sign__unpackneg__Oeq);
      function sparknacl__sign__unpackneg__pow_2523 (i : in
        sparknacl__normal_gf) return sparknacl__normal_gf
        with pure_function,
             global => null;
      pragma global (null);
      pragma pure_function (sparknacl__sign__unpackneg__pow_2523);

      function sparknacl__sign__unpackneg__Oeq (left : in
        sparknacl__normal_gf; right : in sparknacl__normal_gf) return
        boolean is
      begin
         return sparknacl__equal (sparknacl__bytes_32'(sparknacl__utils.
           sparknacl__utils__pack_25519 (left)), sparknacl__bytes_32'(
           sparknacl__utils.sparknacl__utils__pack_25519 (right)));
      end sparknacl__sign__unpackneg__Oeq;

      function sparknacl__sign__unpackneg__pow_2523 (i : in
        sparknacl__normal_gf) return sparknacl__normal_gf is
         c : sparknacl__normal_gf;
         c2 : sparknacl__normal_gf;
         L_17 : label
      begin
         c := i;
         L_17 : for a in reverse 0 .. 250 loop
            pragma loop_optimize (no_unroll);
            c2 := sparknacl__square (c);
            if a = 1 then
               c := c2;
            else
               c := sparknacl__Omultiply (c2, i);
            end if;
         end loop L_17;
         return c;
      end sparknacl__sign__unpackneg__pow_2523;

      r1 : constant sparknacl__normal_gf := sparknacl__utils.
        sparknacl__utils__unpack_25519 (p);
      r2 : sparknacl__normal_gf renames sparknacl__gf_1;
      r1_squared : constant sparknacl__normal_gf := sparknacl__square (
        r1);
      num : constant sparknacl__normal_gf := sparknacl__Osubtract (
        r1_squared, r2);
      den : constant sparknacl__normal_gf := sparknacl__Oadd (r2, (
        sparknacl__Omultiply (r1_squared, sparknacl__sign__gf_d)));
      den_power_2 : constant sparknacl__normal_gf := sparknacl__square
        (den);
      den_power_4 : constant sparknacl__normal_gf := sparknacl__square
        (den_power_2);
      num_den2 : constant sparknacl__normal_gf := sparknacl__Omultiply
        ((sparknacl__Omultiply (num, den)), den_power_2);
      r0 : sparknacl__normal_gf := sparknacl__Omultiply (
        sparknacl__sign__unpackneg__pow_2523 ((sparknacl__Omultiply (
        den_power_4, num_den2))), num_den2);
      check : sparknacl__normal_gf;
   begin
      check := sparknacl__Omultiply (sparknacl__square (r0), den);
      if not (sparknacl__sign__unpackneg__Oeq (check, num)) then
         r0 := sparknacl__Omultiply (r0, sparknacl__sign__gf_i);
      end if;
      check := sparknacl__Omultiply (sparknacl__square (r0), den);
      if not (sparknacl__sign__unpackneg__Oeq (check, num)) then
         L450b : for J449b in 0 .. 3 loop
            r (J449b) := sparknacl__gf_0;
         end loop L450b;
         ok := false;
         return;
      end if;
      if sparknacl__sign__par_25519 (r0) = (p (31) / 128) then
         r0 := sparknacl__Osubtract (sparknacl__gf_0, r0);
      end if;
      r := (r0, r1, r2, sparknacl__Omultiply (r0, r1));
      ok := true;
      return;
   end sparknacl__sign__unpackneg;

   function sparknacl__sign__serialize (k : in
     sparknacl__sign__signing_sk) return sparknacl__bytes_64 is
   begin
      return k.f;
   end sparknacl__sign__serialize;

   function sparknacl__sign__serialize__2 (k : in
     sparknacl__sign__signing_pk) return sparknacl__bytes_32 is
   begin
      return k.f;
   end sparknacl__sign__serialize;

   procedure sparknacl__sign__sanitize (k : out
     sparknacl__sign__signing_pk) is
   begin
      sparknacl.sparknacl__sanitize (k.f);
      return;
   end sparknacl__sign__sanitize;

   procedure sparknacl__sign__sanitize__2 (k : out
     sparknacl__sign__signing_sk) is
   begin
      sparknacl.sparknacl__sanitize (k.f);
      return;
   end sparknacl__sign__sanitize;

   procedure sparknacl__sign__keypair (sk_raw : in sparknacl__bytes_32;
     pk : out sparknacl__sign__signing_pk; sk : out
     sparknacl__sign__signing_sk) is
      d : sparknacl__bytes_64;
      lpk : sparknacl__bytes_32;
   begin
      sparknacl__hashing.sparknacl__hashing__hash (d, sk_raw);
      d (0) := d (0) and 248;
      d (31) := (d (31) and 127) or 64;
      [type interfaces__Tinteger_32B is new integer]
      [subtype sparknacl__sign__keypair__T459b is
        interfaces__Tinteger_32B range 0 .. 31]
      [subtype sparknacl__sign__keypair__T460b is sparknacl__byte_seq (
        sparknacl__sign__keypair__T459b)]
      reference sparknacl__sign__keypair__T460b
      lpk := sparknacl__sign__pack (sparknacl__sign__scalarbase (d (
        0 .. 31)));
      pk.f := lpk;
      subtype sparknacl__sign__keypair__TS461bS is sparknacl__byte_seq
        (0 .. 63);
      S461b : sparknacl__byte_seq (0 .. 63);
      [subtype sparknacl__sign__keypair__T462b is
        interfaces__Tinteger_32B range 0 .. 31]
      [subtype sparknacl__sign__keypair__T463b is sparknacl__byte_seq (
        sparknacl__sign__keypair__T462b)]
      reference sparknacl__sign__keypair__T463b
      S461b (0 .. 31) := sk_raw;
      [subtype sparknacl__sign__keypair__T464b is
        interfaces__Tinteger_32B range 32 .. 63]
      [subtype sparknacl__sign__keypair__T465b is sparknacl__byte_seq (
        sparknacl__sign__keypair__T464b)]
      reference sparknacl__sign__keypair__T465b
      S461b (32 .. 63) := lpk;
      sk.f := S461b;
      sparknacl__sanitize (d);
      sparknacl__sanitize (lpk);
      pragma unreferenced (d);
      pragma unreferenced (lpk);
      return;
   end sparknacl__sign__keypair;

   procedure sparknacl__sign__pk_from_bytes (pk_raw : in
     sparknacl__bytes_32; pk : out sparknacl__sign__signing_pk) is
   begin
      pk.f := pk_raw;
      return;
   end sparknacl__sign__pk_from_bytes;

   procedure sparknacl__sign__sign (sm : out sparknacl__byte_seq; m :
     in sparknacl__byte_seq; sk : in sparknacl__sign__signing_sk) is
      subtype sparknacl__sign__sign__S467b is sparknacl__byte_seq (m'
        first(1) .. m'last(1));
      subtype sparknacl__sign__sign__S466b is sparknacl__byte_seq (sm'
        first(1) .. sm'last(1));
      subtype sparknacl__sign__sign__byte_product is sparknacl__i64
        range 0 .. 65025;
      d : sparknacl__bytes_64;
      h : sparknacl__bytes_32;
      r : sparknacl__bytes_32;
      x : sparknacl__i64_seq_64;
      t : sparknacl__sign__sign__byte_product;
      p : sparknacl__sign__gf_vector_4;
      procedure sparknacl__sign__sign__initialize_sm (x : out
        sparknacl__byte_seq)
        with global => (
                input => (m, d)),
             depends => (
                x => (x, m, d)),
             pre => x'length = m'length + 64 and x'last = m'last +
               64,
             pre => (m'first = 0 and x'first = 0 and m'last <=
               2147483583),
             post => (x = sparknacl__zero_bytes_32 & d (32 .. 63) & m) and
               x'initialized,
             relaxed_initialization => x,
             inline;
      pragma inline (sparknacl__sign__sign__initialize_sm);
      pragma postcondition (check => (x = sparknacl__zero_bytes_32 & d
        (32 .. 63) & m) and x'initialized, message =>
        "failed postcondition from sparknacl-sign.adb:914");
      pragma precondition (check => (m'first = 0 and x'first = 0 and m'
        last <= 2147483583), message =>
        "failed precondition from sparknacl-sign.adb:909");
      pragma precondition (check => x'length = m'length + 64 and x'last =
        m'last + 64, message =>
        "failed precondition from sparknacl-sign.adb:912");
      pragma depends ((
         x => (x, m, d)));
      pragma global ((
         input => (m, d)));

      procedure sparknacl__sign__sign__initialize_sm (x : out
        sparknacl__byte_seq) is
         subtype sparknacl__sign__sign__initialize_sm__S473b is
           sparknacl__byte_seq (x'first(1) .. x'last(1));
      begin
         [constraint_error when
           [subtype sparknacl__sign__sign__initialize_sm__TS473bP1 is
             interfaces__Tinteger_32B range x'first(1) .. x'last(1)]
           0 < sparknacl__sign__sign__initialize_sm__TS473bP1'first or else
             31 > sparknacl__sign__sign__initialize_sm__TS473bP1'last
           "range check failed"]
         [subtype sparknacl__sign__sign__initialize_sm__T475b is
         [subtype sparknacl__sign__sign__initialize_sm__T474b is
           interfaces__Tinteger_32B range 0 .. 31]
           sparknacl__byte_seq (
           sparknacl__sign__sign__initialize_sm__T474b)]
         reference sparknacl__sign__sign__initialize_sm__T475b
         x (0 .. 31) := sparknacl__zero_bytes_32;
         [constraint_error when
           32 < sparknacl__sign__sign__initialize_sm__TS473bP1'first or else
             63 > sparknacl__sign__sign__initialize_sm__TS473bP1'last
           "range check failed"]
         [subtype sparknacl__sign__sign__initialize_sm__T477b is
         [subtype sparknacl__sign__sign__initialize_sm__T476b is
           interfaces__Tinteger_32B range 32 .. 63]
           sparknacl__byte_seq (
           sparknacl__sign__sign__initialize_sm__T476b)]
         reference sparknacl__sign__sign__initialize_sm__T477b
         [subtype sparknacl__sign__sign__initialize_sm__T479b is
         [subtype sparknacl__sign__sign__initialize_sm__T478b is
           interfaces__Tinteger_32B range 32 .. 63]
           sparknacl__byte_seq (
           sparknacl__sign__sign__initialize_sm__T478b)]
         reference sparknacl__sign__sign__initialize_sm__T479b
         x (32 .. 63) := d (32 .. 63);
         [constraint_error when
           x'last >= 64 and then (64 <
             sparknacl__sign__sign__initialize_sm__TS473bP1'first or else
             x'last > sparknacl__sign__sign__initialize_sm__TS473bP1'
             last)
           "range check failed"]
         [subtype sparknacl__sign__sign__initialize_sm__T481b is
         [subtype sparknacl__sign__sign__initialize_sm__T480b is
           interfaces__Tinteger_32B range 64 .. x'last]
           sparknacl__byte_seq (
           sparknacl__sign__sign__initialize_sm__T480b)]
         reference sparknacl__sign__sign__initialize_sm__T481b
         [constraint_error when
           long_long_integer(
             sparknacl__sign__sign__initialize_sm__T481b'length) /=
             long_long_integer(sparknacl__sign__sign__S467b'length)
           "length check failed"]
         x (64 .. x'last) := m;
         return;
      end sparknacl__sign__sign__initialize_sm;

      L_18 : label
      L_20 : label
      L_19 : label
   begin
      [subtype sparknacl__sign__sign__T482b is interfaces__Tinteger_32B range
        0 .. 31]
      [subtype sparknacl__sign__sign__T483b is sparknacl__byte_seq (
        sparknacl__sign__sign__T482b)]
      reference sparknacl__sign__sign__T483b
      sparknacl__hashing.sparknacl__hashing__hash (d,
        sparknacl__sign__serialize (sk) (0 .. 31));
      d (0) := d (0) and 248;
      d (31) := (d (31) and 127) or 64;
      sparknacl__sign__sign__initialize_sm (sm);
      [constraint_error when
        [subtype sparknacl__sign__sign__TS466bP1 is
          interfaces__Tinteger_32B range sm'first(1) .. sm'last(1)]
        sm'last >= 32 and then (32 < sparknacl__sign__sign__TS466bP1'
          first or else sm'last > sparknacl__sign__sign__TS466bP1'last)
        "range check failed"]
      [subtype sparknacl__sign__sign__T484b is interfaces__Tinteger_32B range
        32 .. sm'last]
      [subtype sparknacl__sign__sign__T485b is sparknacl__byte_seq (
        sparknacl__sign__sign__T484b)]
      reference sparknacl__sign__sign__T485b
      r := sparknacl__sign__hash_reduce (sm (32 .. sm'last));
      p := sparknacl__sign__scalarbase (r);
      [constraint_error when
        0 < sparknacl__sign__sign__TS466bP1'first or else 31 >
          sparknacl__sign__sign__TS466bP1'last
        "range check failed"]
      [subtype sparknacl__sign__sign__T486b is interfaces__Tinteger_32B range
        0 .. 31]
      [subtype sparknacl__sign__sign__T487b is sparknacl__byte_seq (
        sparknacl__sign__sign__T486b)]
      reference sparknacl__sign__sign__T487b
      sm (0 .. 31) := sparknacl__sign__pack (p);
      [constraint_error when
        32 < sparknacl__sign__sign__TS466bP1'first or else 63 >
          sparknacl__sign__sign__TS466bP1'last
        "range check failed"]
      [subtype sparknacl__sign__sign__T488b is interfaces__Tinteger_32B range
        32 .. 63]
      [subtype sparknacl__sign__sign__T489b is sparknacl__byte_seq (
        sparknacl__sign__sign__T488b)]
      reference sparknacl__sign__sign__T489b
      [subtype sparknacl__sign__sign__T490b is interfaces__Tinteger_32B range
        32 .. 63]
      [subtype sparknacl__sign__sign__T491b is sparknacl__byte_seq (
        sparknacl__sign__sign__T490b)]
      reference sparknacl__sign__sign__T491b
      sm (32 .. 63) := sparknacl__sign__serialize (sk) (32 .. 63);
      h := sparknacl__sign__hash_reduce (sm);
      x := (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0);
      L_18 : for i in 0 .. 31 loop
         pragma loop_optimize (no_unroll);
         x (i) := sparknacl__i64(r (i));
      end loop L_18;
      pragma warnings (off, "explicit membership test may be optimized");
      L_19 : for i in 0 .. 31 loop
         pragma loop_optimize (no_unroll);
         L_20 : for j in 0 .. 31 loop
            pragma loop_optimize (no_unroll);
            t := sparknacl__sign__sign__byte_product(h (i)) *
              sparknacl__sign__sign__byte_product(d (j));
            x (i + j) := x (i + j) {+} t;
         end loop L_20;
      end loop L_19;
      [constraint_error when
        32 < sparknacl__sign__sign__TS466bP1'first or else 63 >
          sparknacl__sign__sign__TS466bP1'last
        "range check failed"]
      [subtype sparknacl__sign__sign__T639b is interfaces__Tinteger_32B range
        32 .. 63]
      [subtype sparknacl__sign__sign__T640b is sparknacl__byte_seq (
        sparknacl__sign__sign__T639b)]
      reference sparknacl__sign__sign__T640b
      sm (32 .. 63) := sparknacl__sign__modl (x);
      sparknacl__sanitize (d);
      sparknacl__sanitize (h);
      sparknacl__sanitize (r);
      sparknacl__sanitize_i64_seq (x);
      pragma unreferenced (d, h, r, x);
      return;
   end sparknacl__sign__sign;

   procedure sparknacl__sign__open (m : out sparknacl__byte_seq; status :
     out boolean; mlen : out sparknacl__i32; sm : in
     sparknacl__byte_seq; pk : in sparknacl__sign__signing_pk) is
      subtype sparknacl__sign__open__S642b is sparknacl__byte_seq (sm'
        first(1) .. sm'last(1));
      subtype sparknacl__sign__open__S641b is sparknacl__byte_seq (m'
        first(1) .. m'last(1));
      t : sparknacl__bytes_32;
      p : sparknacl__sign__gf_vector_4;
      q : sparknacl__sign__gf_vector_4;
      ln : sparknacl__i32;
   begin
      mlen := -1;
      if long_long_integer!(sm'first) + 63 > long_long_integer!(sm'last)
        then
         m := (
            others => 0);
         status := false;
         return;
      end if;
      sparknacl__sign__unpackneg (q, status,
        sparknacl__sign__serialize__2 (pk));
      if not status then
         m := (
            others => 0);
         sparknacl__sign__sanitize_gf_vector_4 (q);
         return;
      end if;
      [constraint_error when
        long_long_integer(sparknacl__sign__open__S641b'length) /=
          long_long_integer(sparknacl__sign__open__S642b'length)
        "length check failed"]
      m := sm;
      [constraint_error when
        [subtype sparknacl__sign__open__TS641bP1 is
          interfaces__Tinteger_32B range m'first(1) .. m'last(1)]
        32 < sparknacl__sign__open__TS641bP1'first or else 63 >
          sparknacl__sign__open__TS641bP1'last
        "range check failed"]
      [subtype sparknacl__sign__open__T649b is interfaces__Tinteger_32B range
        32 .. 63]
      [subtype sparknacl__sign__open__T650b is sparknacl__byte_seq (
        sparknacl__sign__open__T649b)]
      reference sparknacl__sign__open__T650b
      m (32 .. 63) := sparknacl__sign__serialize__2 (pk);
      p := sparknacl__sign__scalarmult (q, sparknacl__sign__hash_reduce
        (m));
      [constraint_error when
        [subtype sparknacl__sign__open__TS642bP1 is
          interfaces__Tinteger_32B range sm'first(1) .. sm'last(1)]
        32 < sparknacl__sign__open__TS642bP1'first or else 63 >
          sparknacl__sign__open__TS642bP1'last
        "range check failed"]
      [subtype sparknacl__sign__open__T651b is interfaces__Tinteger_32B range
        32 .. 63]
      [subtype sparknacl__sign__open__T652b is sparknacl__byte_seq (
        sparknacl__sign__open__T651b)]
      reference sparknacl__sign__open__T652b
      q := sparknacl__sign__scalarbase (sm (32 .. 63));
      p := sparknacl__sign__Oadd (p, q);
      t := sparknacl__sign__pack (p);
      [constraint_error when
        0 < sparknacl__sign__open__TS642bP1'first or else 31 >
          sparknacl__sign__open__TS642bP1'last
        "range check failed"]
      [subtype sparknacl__sign__open__T653b is interfaces__Tinteger_32B range
        0 .. 31]
      [subtype sparknacl__sign__open__T654b is sparknacl__byte_seq (
        sparknacl__sign__open__T653b)]
      reference sparknacl__sign__open__T654b
      if not sparknacl__equal (sm (0 .. 31), t) then
         m := (
            others => 0);
         status := false;
         sparknacl__sanitize (t);
         sparknacl__sign__sanitize_gf_vector_4 (p);
         sparknacl__sign__sanitize_gf_vector_4 (q);
         return;
      end if;
      ln := sparknacl__i32(sparknacl__i64(sm'length) - 64);
      R658b : constant interfaces__Tinteger_32B := ln {-} 1;
      [constraint_error when
        R658b >= 0 and then (0 < sparknacl__sign__open__TS641bP1'first or else
          R658b > sparknacl__sign__open__TS641bP1'last)
        "range check failed"]
      [subtype sparknacl__sign__open__T659b is interfaces__Tinteger_32B range
        0 .. R658b]
      [subtype sparknacl__sign__open__T660b is sparknacl__byte_seq (
        sparknacl__sign__open__T659b)]
      reference sparknacl__sign__open__T660b
      R661b : constant interfaces__Tinteger_32B := ln {+} 63;
      [constraint_error when
        R661b >= 64 and then (64 < sparknacl__sign__open__TS642bP1'
          first or else R661b > sparknacl__sign__open__TS642bP1'last)
        "range check failed"]
      [subtype sparknacl__sign__open__T662b is interfaces__Tinteger_32B range
        64 .. R661b]
      [subtype sparknacl__sign__open__T663b is sparknacl__byte_seq (
        sparknacl__sign__open__T662b)]
      reference sparknacl__sign__open__T663b
      [constraint_error when
        integer(sparknacl__sign__open__T660b'length) /= integer(
          sparknacl__sign__open__T663b'length)
        "length check failed"]
      m (0 .. R658b) := sm (64 .. R661b);
      mlen := ln;
      status := true;
      sparknacl__sanitize (t);
      sparknacl__sign__sanitize_gf_vector_4 (p);
      sparknacl__sign__sanitize_gf_vector_4 (q);
      pragma unreferenced (t, p, q);
      return;
   end sparknacl__sign__open;
begin
   null;
end sparknacl.sparknacl__sign
  with spark_mode => on;

Source recreated from tree for Sparknacl.Sign (spec)
----------------------------------------------------

with sparknacl;
sparknacl__sign_E : short_integer := 0;

package sparknacl.sparknacl__sign with pure,spark_mode => on is
   pragma spark_mode (on);
   type sparknacl__sign__signing_pk is limited private;
   type sparknacl__sign__signing_sk is limited private;
   procedure sparknacl__sign__keypair (sk_raw : in sparknacl__bytes_32;
     pk : out sparknacl__sign__signing_pk; sk : out
     sparknacl__sign__signing_sk)
     with global => null;
   pragma global (null);
   procedure sparknacl__sign__pk_from_bytes (pk_raw : in
     sparknacl__bytes_32; pk : out sparknacl__sign__signing_pk)
     with global => null;
   pragma global (null);
   function sparknacl__sign__serialize (k : in
     sparknacl__sign__signing_sk) return sparknacl__bytes_64
     with global => null;
   pragma global (null);
   function sparknacl__sign__serialize__2 (k : in
     sparknacl__sign__signing_pk) return sparknacl__bytes_32
     with global => null;
   pragma global (null);
   procedure sparknacl__sign__sanitize (k : out
     sparknacl__sign__signing_pk)
     with global => null;
   pragma global (null);
   procedure sparknacl__sign__sanitize__2 (k : out
     sparknacl__sign__signing_sk)
     with global => null;
   pragma global (null);
   sparknacl__sign__sign_bytes : constant  := 64;
   procedure sparknacl__sign__sign (sm : out sparknacl__byte_seq; m :
     in sparknacl__byte_seq; sk : in sparknacl__sign__signing_sk)
     with global => null,
          relaxed_initialization => sm,
          pre => sm'length = m'length + 64 and sm'last = m'last + 64,
          pre => (m'first = 0 and sm'first = 0 and m'last <=
            2147483583),
          post => sm'initialized;
   pragma postcondition (check => sm'initialized, message =>
     "failed postcondition from sparknacl-sign.ads:50");
   pragma precondition (check => (m'first = 0 and sm'first = 0 and m'
     last <= 2147483583), message =>
     "failed precondition from sparknacl-sign.ads:45");
   pragma precondition (check => sm'length = m'length + 64 and sm'last =
     m'last + 64, message =>
     "failed precondition from sparknacl-sign.ads:48");
   pragma global (null);
   procedure sparknacl__sign__open (m : out sparknacl__byte_seq; status :
     out boolean; mlen : out sparknacl__i32; sm : in
     sparknacl__byte_seq; pk : in sparknacl__sign__signing_pk)
     with global => null,
          pre => m'first = 0 and sm'first = 0 and sm'length = m'length and
            sm'last = m'last and sm'length >= 64;
   pragma precondition (check => m'first = 0 and sm'first = 0 and sm'
     length = m'length and sm'last = m'last and sm'length >= 64,
     message => "failed precondition from sparknacl-sign.ads:58");
   pragma global (null);
private
   type sparknacl__sign__signing_pk is limited record
      f : sparknacl__bytes_32;
   end record;
   type sparknacl__sign__signing_sk is limited record
      f : sparknacl__bytes_64;
   end record;
   freeze sparknacl__sign__signing_pk [
      procedure sparknacl__sign__signing_pkIP (_init : out
        sparknacl__sign__signing_pk) is
      begin
         return;
      end sparknacl__sign__signing_pkIP;
   ]
   freeze sparknacl__sign__signing_sk [
      procedure sparknacl__sign__signing_skIP (_init : out
        sparknacl__sign__signing_sk) is
      begin
         return;
      end sparknacl__sign__signing_skIP;
   ]
end sparknacl.sparknacl__sign;

pragma pure (sparknacl__sign);

