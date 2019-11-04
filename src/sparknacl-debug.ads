package SPARKNaCl.Debug
is
   procedure DH  (S : in String; D : in Byte_Seq);
   procedure DH  (S : in String; D : in GF);
   procedure DH  (S : in String; D : in Boolean);

   procedure DH  (S : in String; D : in I64);
   --  Same but output in hex
   procedure DHH  (S : in String; D : in I64);

   procedure DHS (S : in String; D : in I64_Seq_64);
end SPARKNaCl.Debug;
