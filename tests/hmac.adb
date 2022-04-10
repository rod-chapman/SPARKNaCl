with SPARKNaCl;       use SPARKNaCl;
with SPARKNaCl.MAC;   use SPARKNaCl.MAC;
with SPARKNaCl.Debug; use SPARKNaCl.Debug;
procedure HMAC
is
   function To_Byte_Seq (s : String) return Byte_Seq is
      ret : Byte_Seq (N32 (s'First - 1) .. N32 (s'Last - 1));
   begin
      for i in s'Range loop
         ret (N32 (i - 1)) := Character'Pos (s (i));
      end loop;
      return ret;
   end To_Byte_Seq;

   --  Test vectors from RFC 4231
   --  https://www.rfc-editor.org/rfc/rfc4231.html

   Key1  : constant Byte_Seq (0 .. 19) := (others => 16#0b#);
   Data1 : constant Byte_Seq := To_Byte_Seq ("Hi There");

   --  key shorter than length of HMAC output

   Key2  : constant Byte_Seq := To_Byte_Seq ("Jefe");
   Data2 : constant Byte_Seq := To_Byte_Seq (
      "what do ya want for nothing?");

   --  combined length of key and data larger than 64 bytes

   Key3  : constant Byte_Seq (0 .. 19) := (others => 16#aa#);
   Data3 : constant Byte_Seq (0 .. 49) := (others => 16#dd#);

   --  combined length of key and data larger than 64 bytes

   Key4  : constant Byte_Seq (0 .. 24) := (
      16#01#, 16#02#, 16#03#, 16#04#, 16#05#, 16#06#, 16#07#, 16#08#, 
      16#09#, 16#0a#, 16#0b#, 16#0c#, 16#0d#, 16#0e#, 16#0f#, 16#10#,
      16#11#, 16#12#, 16#13#, 16#14#, 16#15#, 16#16#, 16#17#, 16#18#, 
      16#19#
   );

   Data4 : constant Byte_Seq (0 .. 49) := (others => 16#cd#);

   --  test with truncation of output to 128 bits

   Key5  : constant Byte_Seq (0 .. 19) := (others => 16#0c#);

   Data5 : constant Byte_Seq := To_Byte_Seq (
      "Test With Truncation");

   --  test with key larger than 128 bytes

   Key6  : constant Byte_Seq (0 .. 130) := (others => 16#aa#);
   Data6 : constant Byte_Seq := To_Byte_Seq (
      "Test Using Larger Than Block-Size Key - Hash Key First");

   --  test with key and data larger than 128 bytes

   Key7  : constant Byte_Seq (0 .. 130) := (others => 16#aa#);
   Data7 : constant Byte_Seq := To_Byte_Seq (
      "This is a test using a larger than block-size key and a larger " &
      "than block-size data. The key needs to be hashed before being " &
      "used by the HMAC algorithm.");

   D : Bytes_32;
begin

   HMAC_SHA_256 (D, Data1, Key1);
   DH ("D1 is", D);

   HMAC_SHA_256 (D, Data2, Key2);
   DH ("D2 is", D);

   HMAC_SHA_256 (D, Data3, Key3);
   DH ("D3 is", D);
   
   HMAC_SHA_256 (D, Data4, Key4);
   DH ("D4 is", D);

   HMAC_SHA_256 (D, Data5, Key5);
   DH ("D5 is", D (0 .. 15));
   
   HMAC_SHA_256 (D, Data6, Key6);
   DH ("D6 is", D);
   
   HMAC_SHA_256 (D, Data7, Key7);
   DH ("D7 is", D);

end HMAC;
