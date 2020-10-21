with HAL; use HAL;
with HiFive1.LEDs; use HiFive1.LEDs;
with FE310;
with FE310.CLINT;
with FE310.Time; use FE310.Time;

with Interfaces; use Interfaces;

with IO;

with SPARKNaCl;        use SPARKNaCl;
with SPARKNaCl.Scalar;

with TweetNaCl_API;

with RISCV.CSR; use RISCV.CSR;
with FE310.Performance_Monitor; use FE310.Performance_Monitor;

procedure TSM is
   subtype U64 is Unsigned_64;

   N : constant Bytes_32 := (0, 1, 2, 3, 4, 5, 6, 7,
                             0, 1, 2, 3, 4, 5, 6, 7,
                             0, 1, 2, 3, 4, 5, 6, 7,
                             0, 1, 2, 3, 4, 5, 6, 7);

   P : constant Bytes_32 := (10, 11, 12, 13, 14, 15, 16, 17,
                             10, 11, 12, 13, 14, 15, 16, 17,
                             10, 11, 12, 13, 14, 15, 16, 17,
                             10, 11, 12, 13, 14, 15, 16, 17);

   Q : Bytes_32;
   Q2 : Bytes_32;

   T1, T2 : UInt64;
   Total_Time : Unsigned_64;

   CPU_Hz1, CPU_Hz2 : UInt32;

   procedure Report;

   procedure Tweet_Mult (Q :    out Bytes_32;
                         N : in     Bytes_32;
                         P : in     Bytes_32);

   procedure Tweet_Mult (Q :    out Bytes_32;
                         N : in     Bytes_32;
                         P : in     Bytes_32)
   is
   begin
      TweetNaCl_API.Crypto_Scalarmult (Q, N, P);
   end Tweet_Mult;

   procedure Report
   is
   begin
      IO.Put_Line ("Total time:  ", Total_Time);
   end Report;

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

   IO.Put_Line ("SPARKNaCl.Scalar.Mult test");

   T1 := Mcycle.Read;
   Q := SPARKNaCl.Scalar.Mult (N, P);
   T2 := Mcycle.Read;

   Total_Time := Unsigned_64 (T2 - T1);
   Report;

   Turn_Off (Red_LED);
   Turn_On (Green_LED);

   IO.New_Line;
   IO.Put_Line ("TweetNaCl.Scalar.Mult test");

   T1 := Mcycle.Read;
   Tweet_Mult (Q2, N, P);
   T2 := Mcycle.Read;
   Total_Time := Unsigned_64 (T2 - T1);

   Report;

   if Q = Q2 then
      IO.Put ("Pass");
   else
      IO.Put ("Fail");
   end if;
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
end TSM;
