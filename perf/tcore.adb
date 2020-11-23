with HAL; use HAL;
with HiFive1.LEDs; use HiFive1.LEDs;
with FE310;
with FE310.CLINT;
with FE310.Time; use FE310.Time;

with Interfaces; use Interfaces;

with IO;

with SPARKNaCl;        use SPARKNaCl;
with SPARKNaCl.Core;   use SPARKNaCl.Core;
with SPARKNaCl.Stream; use SPARKNaCl.Stream;

with TweetNaCl_API;

with RISCV.CSR; use RISCV.CSR;
with FE310.Performance_Monitor; use FE310.Performance_Monitor;

procedure TCore is
   subtype U64 is Unsigned_64;

   C1, C2 : Byte_Seq (0 .. 2047);
   N : HSalsa20_Nonce;
   K : Salsa20_Key;

   T1, T2 : UInt64;
   Total_Time : Unsigned_64;

   CPU_Hz1, CPU_Hz2 : UInt32;

   procedure Report;

   procedure Report
   is
   begin
      IO.Put_Line ("Total time:  ", Total_Time);
   end Report;

   procedure Tweet_HSalsa20 (C :    out Byte_Seq;       --  Output stream
                             N : in     HSalsa20_Nonce; --  Nonce
                             K : in     Salsa20_Key);    --  Key

   procedure Tweet_HSalsa20 (C :    out Byte_Seq;
                             N : in     HSalsa20_Nonce;
                             K : in     Salsa20_Key)
   is
   begin
      TweetNaCl_API.HSalsa20 (C, U64 (C'Length), N, K);
   end Tweet_HSalsa20;

begin
   CPU_Hz1 := FE310.CPU_Frequency;

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

   CPU_Hz2 := FE310.CPU_Frequency;

   IO.Put_Line ("CPU Frequency reset was: ", U64 (CPU_Hz1));
   IO.Put_Line ("CPU Frequency now is:    ", U64 (CPU_Hz2));

   FE310.Performance_Monitor.Set_Commit_Events (3, No_Commit_Events);
   FE310.Performance_Monitor.Set_Commit_Events (4, No_Commit_Events);

   Turn_On (Red_LED);

   T1 := FE310.CLINT.Machine_Time;
   T2 := FE310.CLINT.Machine_Time;
   IO.Put_Line ("Null timing test:", U64 (T2 - T1));

   T1 := Mcycle.Read;
   Delay_S (1);
   T2 := Mcycle.Read;
   IO.Put_Line ("One second test (CYCLE):  ", U64 (T2 - T1));

   T1 := Minstret.Read;
   Delay_S (1);
   T2 := Minstret.Read;
   IO.Put_Line ("One second test (INSTRET):", U64 (T2 - T1));

   T1 := FE310.CLINT.Machine_Time;
   Delay_S (1);
   T2 := FE310.CLINT.Machine_Time;
   IO.Put_Line ("One second test (CLINT):  ", U64 (T2 - T1));

   IO.Put_Line ("SPARKNaCl.Stream.HSalsa20 test");

   --  Arbitrary nonce.
   N := (0, 1, 2, 3, 4, 5, 6, 7,
         8, 9, 10, 11, 12, 13, 14, 15,
         16, 17, 18, 19, 20, 21, 22, 23);

   --  Arbitrary key
   Construct (K, Bytes_32'(5, 1, 5, 1, 5, 1, 5, 1,
                           5, 1, 5, 1, 5, 1, 5, 1,
                           5, 1, 5, 1, 5, 1, 5, 1,
                           5, 1, 5, 1, 5, 1, 5, 1));

   T1 := Mcycle.Read;
   SPARKNaCl.Stream.HSalsa20 (C1, N, K);
   T2 := Mcycle.Read;

   Total_Time := Unsigned_64 (T2 - T1);
   Report;

   Turn_Off (Red_LED);
   Turn_On (Green_LED);

   IO.New_Line;
   IO.Put_Line ("TweetNaCl.Core test");

   T1 := Mcycle.Read;
   Tweet_HSalsa20 (C2, N, K);
   T2 := Mcycle.Read;
   Total_Time := Unsigned_64 (T2 - T1);

   Report;
   if C1 = C2 then
      IO.Put ("Pass");
   else
      IO.Put ("Fail");
   end if;
   IO.New_Line;
   IO.New_Line;

   Turn_Off (Green_LED);

   --  Blinky!
   loop
      Turn_On (Red_LED);
      Delay_S (1);
      Turn_Off (Red_LED);

      Turn_On (Green_LED);
      Delay_S (1);
      Turn_Off (Green_LED);

      Turn_On (Blue_LED);
      Delay_S (1);
      Turn_Off (Blue_LED);

   end loop;
end TCore;
