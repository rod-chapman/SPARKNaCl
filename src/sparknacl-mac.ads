with SPARKNaCl.Hashing.SHA256;
with SPARKNaCl.Hashing.SHA512;
package SPARKNaCl.MAC
  with Pure,
       SPARK_Mode => On
is
   --  Limited, so no assignment or comparison, and always
   --  pass-by-reference.
   type Poly_1305_Key is limited private;

   function Construct (K : in Bytes_32) return Poly_1305_Key
     with Global => null;

   procedure Construct (K :    out Poly_1305_Key;
                        X : in     Bytes_32)
     with Global => null;

   function Serialize (K : in Poly_1305_Key) return Bytes_32
     with Global => null;

   procedure Sanitize (K : out Poly_1305_Key)
     with Global => null;

   --------------------------------------------------------
   --  One-time authentication
   --------------------------------------------------------

   procedure Onetimeauth (Output :    out Bytes_16;
                          M      : in     Byte_Seq;
                          K      : in     Poly_1305_Key)
     with Global => null,
          Pre    => M'First = 0;

   function Onetimeauth_Verify (H : in Bytes_16;
                                M : in Byte_Seq;
                                K : in Poly_1305_Key) return Boolean
     with Global => null,
          Pre    => M'First = 0;

   --------------------------------------------------------
   --  Hash-based MAC
   --------------------------------------------------------

   procedure HMAC_SHA_256 (Output :    out Hashing.SHA256.Digest;
                           M      : in     Byte_Seq;
                           K      : in     Byte_Seq)
     with Global => null,
          Relaxed_Initialization => Output,
          Pre    => M'First = 0 and
                    M'Last <= N32'Last - 64 and
                    (if K'Length > 0 then K'First = 0),
          Post   => Output'Initialized;

   procedure HMAC_SHA_512 (Output :    out Hashing.SHA512.Digest;
                           M      : in     Byte_Seq;
                           K      : in     Byte_Seq)
     with Global => null,
          Pre    => M'First = 0 and
                    M'Last <= N32'Last - 128 and
                    (if K'Length > 0 then K'First = 0),
          Post   => Same (Output, HMAC_SHA_512 (M, K));

   --  Logical identity of two digests, for specifications. The provers
   --  see Ada "=" on arrays as element-wise equality, from which they
   --  cannot derive that an uninterpreted term such as HMAC_SHA_512 (X, K)
   --  equals HMAC_SHA_512 (Y, K); Same lets them carry a digest through
   --  such terms. At run time it is plain equality.
   function Same (X, Y : Hashing.SHA512.Digest) return Boolean
     with Ghost,
          Global   => null,
          Annotate => (GNATprove, Logical_Equal);

   --  Functional interface: HMAC-SHA-512 of message M under key K
   --  (RFC 2104), a pure function for use in specifications.
   function HMAC_SHA_512 (M : in Byte_Seq;
                          K : in Byte_Seq) return Hashing.SHA512.Digest
     with Global => null,
          Pre    => M'First = 0 and
                    M'Last <= N32'Last - 128 and
                    (if K'Length > 0 then K'First = 0);

private
   --  Note - also limited here in the full view to ensure
   --  no assignment and pass-by-reference in the body.
   type Poly_1305_Key is limited record
      F : Bytes_32;
   end record;
end SPARKNaCl.MAC;
