private package SPARKNaCl.Utils
  with Pure,
       SPARK_Mode => On
is
   --===================================================
   --  Exported subprogram declarations
   --
   --  Note that these subprograms appear in a distinct
   --  private child package so they are NOT
   --  primitive operations of either types Byte_Seq or
   --  GF, but they ARE potentially usable by other
   --  public children of SPARKNaCl.
   --===================================================

   procedure Little_Endian_Unpack (Output :    out Bytes_8;
                                   Input  : in     U64)
     with Inline_Always,
          Global => null;

   procedure Big_Endian_Unpack (Output :    out Bytes_4;
                                Input  : in     U32)
     with Relaxed_Initialization => Output,
          Inline_Always,
          Global => null,
          Post   => Output'Initialized;

   function Big_Endian_Pack (Input : in Bytes_4) return U32
     with Inline_Always,
          Global => null;

   --  Do the following for every Byte in Input. Set all bits of the byte to
   --  the value of the bit at position "Index" in the given byte.
   function Broadcast_Bit_To_Byte (Input : in U32;
                                   Index : in Index_8) return U32
     with Pure_Function,
          Inline_Always,
          Global => null;

   --  Constant time conditional swap of P and Q. Note that
   --  if a Normal_GF is passed in, this property is retained
   --  on swapping (or not...)  This is required Pack_25519.
   --  In the original TweetNaCl sources, this was called
   --  "sel25519"
   procedure CSwap16 (P    : in out Normal_GF;
                      Q    : in out Normal_GF;
                      Swap : in     Boolean)
     with Global => null,
          Contract_Cases =>
            (Swap => (P = Q'Old and Q = P'Old),
             not Swap => (P = P'Old and Q = Q'Old));

   --  Reduces N modulo (2**255 - 19) then packs the
   --  value into 32 bytes little-endian.
   function Pack_25519 (N : in Normal_GF) return Bytes_32
     with Global => null,
          Pure_Function;

   function Inv_25519 (I : in Normal_GF) return Normal_GF
     with Global => null,
          Pure_Function;

   function Unpack_25519 (N : in Bytes_32) return Normal_GF
     with Global => null,
          Pure_Function;

end SPARKNaCl.Utils;
