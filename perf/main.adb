with HiFive1.LEDs; use HiFive1.LEDs;

with FE310;
with FE310.Time; use FE310.Time;

with IO;

with SPARKNaCl;      use SPARKNaCl;
with SPARKNaCl.Sign; use SPARKNaCl.Sign;
with SPARKNaCl.Sign.Utils; use SPARKNaCl.Sign.Utils;

procedure Main is
   M : constant Byte_Seq (0 .. 255) := (0 => 16#55#, others => 16#aa#);

   SK : Signing_SK;
   SM : Byte_Seq (0 .. 319) := (others => 0);

   --  Causes Carry = -1 when I = 58 and XL (I - 12) = -128
   --  after 371076 iterations
   My_SK : constant Bytes_64 :=
     (16#56#, 16#89#, 16#60#, 16#72#, 16#D7#, 16#E1#, 16#B5#, 16#35#,
      16#2B#, 16#12#, 16#B6#, 16#FC#, 16#69#, 16#94#, 16#F3#, 16#76#,
      16#A7#, 16#5C#, 16#42#, 16#DF#, 16#70#, 16#1E#, 16#AC#, 16#F0#,
      16#A0#, 16#EF#, 16#30#, 16#C6#, 16#A1#, 16#D8#, 16#27#, 16#F6#,
      16#D6#, 16#40#, 16#DA#, 16#F4#, 16#0B#, 16#0B#, 16#35#, 16#EF#,
      16#03#, 16#25#, 16#5B#, 16#EF#, 16#A3#, 16#4E#, 16#31#, 16#D4#,
      16#35#, 16#A1#, 16#A2#, 16#E2#, 16#FF#, 16#AA#, 16#EA#, 16#72#,
      16#82#, 16#82#, 16#D2#, 16#D0#, 16#93#, 16#6C#, 16#19#, 16#10#);

begin
   --  The SPI flash clock divider should be as small as possible to increase
   --  the execution speed of instructions that are not yet in the instruction
   --  cache.
   FE310.Set_SPI_Flash_Clock_Divider (2);

   --  Load the internal oscillator factory calibration to be sure it
   --  oscillates at a known frequency.
   FE310.Load_Internal_Oscilator_Calibration;

   --  Use the HiFive1 16 MHz crystal oscillator which is more acurate than the
   --  internal oscillator.
   FE310.Use_Crystal_Oscillator;

   HiFive1.LEDs.Initialize;

   Turn_On (Green_LED);
   IO.Put_Line ("Hello1");

   Construct (My_SK, SK);

   Turn_Off (Green_LED);
   Turn_On (Red_LED);
   IO.Put_Line ("Hello2");

   SPARKNaCl.Sign.Sign (SM, M, SK);

   IO.Put ("SM (0 ..63) is", SM (0 .. 63));
   
   Turn_Off (Red_LED);
   IO.Put_Line ("Done");

   --  Blinky!
   loop
      Turn_On (Red_LED);
      Delay_S (3);
      Turn_Off (Red_LED);

      Turn_On (Green_LED);
      Delay_S (3);
      Turn_Off (Green_LED);

      Turn_On (Blue_LED);
      Delay_S (3);
      Turn_Off (Blue_LED);

   end loop;
end Main;
