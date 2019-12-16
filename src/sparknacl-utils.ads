private package SPARKNaCl.Utils
  with SPARK_Mode => On
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

   --  Carry reduction of all elements of O
   procedure Car_25519 (O : in out GF)
     with Global => null;
   --  Pre all limbs in -65535 .. (38 * 2**36)
   --  Post all limbs in -37 .. 65535 ???

   function Car_Any_To_Seminormal (X : in Unnormalized_GF_Product)
                                  return Seminormal_GF
     with Global => null;

   function Car_Summation_To_Seminormal (X : in Summation_GF)
                                        return Seminormal_GF
     with Global => null;

   function Car_Difference_To_Seminormal (X : in Difference_GF)
                                        return Seminormal_GF
     with Global => null;

   function Car_Seminormal_To_Normal (X : in Seminormal_GF)
                                  return Normal_GF
     with Global => null;

   --  Constant time conditional swap of P and Q.
   procedure Sel_25519 (P    : in out Normal_GF;
                        Q    : in out Normal_GF;
                        Swap : in     Boolean)
     with Global => null,
          Contract_Cases => (Swap     => (P = Q'Old and Q = P'Old),
                             not Swap => (P = P'Old and Q = Q'Old));

   --  Reduces N modulo (2**255 - 19) then packs the
   --  value into 32 bytes little-endian.
   function Pack_25519 (N : in GF) return Bytes_32
     with Global => null;

   function Inv_25519 (I : in Normal_GF) return Normal_GF
     with Global => null;

   function Unpack_25519 (N : in Bytes_32) return Normal_GF
     with Global => null;

   function Random_Bytes_32 return Bytes_32
     with Global => Random.Entropy,
          Volatile_Function;

end SPARKNaCl.Utils;
