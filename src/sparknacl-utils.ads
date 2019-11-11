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

   function Random_Bytes_32 return Bytes_32
     with Global => Random.Entropy,
          Volatile_Function;

   function Pack_25519 (N : in GF) return Bytes_32
     with Global => null;

   function Inv_25519 (I : in GF) return GF
     with Global => null;

   function Unpack_25519 (N : in Bytes_32) return GF
     with Global => null;

end SPARKNaCl.Utils;
