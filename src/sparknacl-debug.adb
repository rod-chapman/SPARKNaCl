with Ada.Text_IO; use Ada.Text_IO;
package body SPARKNaCl.Debug
  with SPARK_Mode => Off
is
   On : constant Boolean := True;

   package I64IO is new Ada.Text_IO.Integer_IO (Integer_64);

   type BToCT is array (Byte range 0 .. 15) of Character;
   BToC : constant BToCT :=
     ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
      'A', 'B', 'C', 'D', 'E', 'F');

   procedure PB (X : in Byte);

   procedure PB (X : in Byte)
   is
   begin
      if On then
         Put ("16#");
         Put (BToC (X / 16));
         Put (BToC (X mod 16));
         Put ("# ");
      end if;
   end PB;

   procedure PU32 (X : in U32);

   procedure PU32 (X : in U32)
   is
      B1 : constant Byte := Byte (16#FF# and Shift_Right (X, 24));
      B2 : constant Byte := Byte (16#FF# and Shift_Right (X, 16));
      B3 : constant Byte := Byte (16#FF# and Shift_Right (X, 8));
      B4 : constant Byte := Byte (16#FF# and X);
   begin
      if On then
         Put ("16#");
         Put (BToC (B1 / 16));
         Put (BToC (B1 mod 16));
         Put (BToC (B2 / 16));
         Put (BToC (B2 mod 16));
         Put (BToC (B3 / 16));
         Put (BToC (B3 mod 16));
         Put (BToC (B4 / 16));
         Put (BToC (B4 mod 16));
         Put ("# ");
      end if;
   end PU32;

   procedure DH (S : in String; D : in Byte_Seq)
   is
   begin
      if On then
         Put_Line (S);
         for I in D'Range loop
            PB (D (I));
            if I mod 8 = 7 then
               New_Line;
            end if;
         end loop;
         New_Line;
      end if;
   end DH;

   procedure DH (S : in String; D : in I64)
   is
   begin
      if On then
         Put (S & ' ');
         I64IO.Put (D, Width => 0);
         New_Line;
      end if;
   end DH;

   procedure DH (S : in String; D : in U32_Seq)
   is
   begin
      if On then
         Put_Line (S);
         for I in D'Range loop
            PU32 (D (I));
            if I mod 8 = 7 then
               New_Line;
            end if;
         end loop;
         New_Line;
      end if;
   end DH;

   procedure DH  (S : in String; D : in Boolean)
   is
   begin
      if On then
         Put_Line (S);
         Put (Img (D));
         New_Line;
      end if;
   end DH;

   procedure DHH  (S : in String; D : in I64)
   is
   begin
      if On then
         Put_Line (S);
         I64IO.Put (D, Width => 0, Base => 16);
         New_Line;
      end if;
   end DHH;

end SPARKNaCl.Debug;
