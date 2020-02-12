package SPARKNaCl.Debug
  with SPARK_Mode => On
is
   procedure DH  (S : in String; D : in Byte_Seq);
   procedure DH  (S : in String; D : in Boolean);

   procedure DH  (S : in String; D : in I64);
   --  Same but output in hex
   procedure DHH  (S : in String; D : in I64);

end SPARKNaCl.Debug;
