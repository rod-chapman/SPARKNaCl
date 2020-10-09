with HAL.UART;
with FE310.UART;
with FE310.Device;

package body IO is

   type BToCT is array (Byte range 0 .. 15) of Character;
   BToC : constant BToCT :=
     ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
      'A', 'B', 'C', 'D', 'E', 'F');

   ---------
   -- Put --
   ---------

   procedure Put (C : Character) is
      B : HAL.UART.UART_Data_8b (0 .. 0);
      S : HAL.UART.UART_Status;
   begin
      B (0) := Character'Pos (C);
      FE310.UART.Transmit (FE310.Device.UART0, B, S);
      pragma Unreferenced (S);
   end Put;

   --------------
   -- New_Line --
   --------------

   procedure New_Line (Spacing : Positive := 1) is
   begin
      for J in 1 .. Spacing loop
         Put (ASCII.CR);
         Put (ASCII.LF);
      end loop;
   end New_Line;

   ---------
   -- Put --
   ---------

   procedure Put (X : Integer) is
      Int   : Integer;
      S     : String (1 .. Integer'Width);
      First : Natural := S'Last + 1;
      Val   : Integer;

   begin
      --  Work on negative values to avoid overflows
      Int := (if X < 0 then X else -X);

      loop
         --  Cf RM 4.5.5 Multiplying Operators.  The rem operator will return
         --  negative values for negative values of Int.
         Val := Int rem 10;
         Int := (Int - Val) / 10;
         First := First - 1;
         S (First) := Character'Val (Character'Pos ('0') - Val);
         exit when Int = 0;
      end loop;

      if X < 0 then
         First := First - 1;
         S (First) := '-';
      end if;

      Put (S (First .. S'Last));
   end Put;

   procedure Put (X : UInt64)
   is
      Int   : UInt64 := X;
      S     : String (1 .. UInt64'Width) := (others => ' ');
      First : Natural := S'Last + 1;
      Val   : UInt64;
   begin
      loop
         Val := Int rem 10;
         Int := (Int - Val) / 10;
         First := First - 1;
         S (First) := Character'Val (Character'Pos ('0') + Val);
         exit when Int = 0;
      end loop;

      --  Fixed width output
      Put (S);
   end Put;

   ---------
   -- Put --
   ---------

   procedure Put (S : String) is
   begin
      for J in S'Range loop
         Put (S (J));
      end loop;
   end Put;

   --------------
   -- Put_Line --
   --------------

   procedure Put_Line (S : String) is
   begin
      Put (S);
      New_Line;
   end Put_Line;

   procedure Put_Line (S : String; X : Unsigned_64)
   is
   begin
      Put (S);
      Put (UInt64 (X));
      New_Line;
   end Put_Line;

   procedure Put (B : in Byte)
   is
   begin
      Put ("16#");
      Put (BToC (B / 16));
      Put (BToC (B mod 16));
      Put ("# ");
   end Put;

   procedure Put  (S : in String; D : in Byte_Seq)
   is
   begin
      Put_Line (S);
      for I in D'Range loop
         Put (D (I));
         if I mod 8 = 7 then
            New_Line;
         end if;
      end loop;
      New_Line;
   end Put;

end IO;
