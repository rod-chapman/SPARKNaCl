package SPARKNaCl.Debug
  with SPARK_Mode => On
is
   --  as per Boolean'Image (B) but does not violate the
   --  No_Enumeration_Maps restriction
   function Img (B : in Boolean) return String is
      (if B then "TRUE" else "FALSE");

   procedure DH  (S : in String; D : in Byte_Seq);
   procedure DH  (S : in String; D : in Boolean);

   procedure DH  (S : in String; D : in I64);
   --  Same but output in hex
   procedure DHH  (S : in String; D : in I64);

end SPARKNaCl.Debug;
