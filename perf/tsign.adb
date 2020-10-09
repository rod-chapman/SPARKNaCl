with HAL; use HAL;
with HiFive1.LEDs; use HiFive1.LEDs;
with FE310;
with FE310.CLINT;
with FE310.Time; use FE310.Time;

with Interfaces; use Interfaces;

with IO;

with SPARKNaCl;      use SPARKNaCl;
with SPARKNaCl.Sign; use SPARKNaCl.Sign;
with SPARKNaCl.Sign.Utils; use SPARKNaCl.Sign.Utils;

with SPARKNaCl.Count;

with TweetNaCl_API;

with RISCV.CSR; use RISCV.CSR;
with FE310.Performance_Monitor; use FE310.Performance_Monitor;

procedure TSign is
   subtype U64 is Unsigned_64;

   M : constant Byte_Seq (0 .. 255) := (0 => 16#55#, others => 16#aa#);

   SK : Signing_SK;
   SM1 : Byte_Seq (0 .. 319) := (others => 0);
   SM2 : Byte_Seq (0 .. 319) := (others => 0);

   My_SK : constant Bytes_64 :=
     (16#56#, 16#89#, 16#60#, 16#72#, 16#D7#, 16#E1#, 16#B5#, 16#35#,
      16#2B#, 16#12#, 16#B6#, 16#FC#, 16#69#, 16#94#, 16#F3#, 16#76#,
      16#A7#, 16#5C#, 16#42#, 16#DF#, 16#70#, 16#1E#, 16#AC#, 16#F0#,
      16#A0#, 16#EF#, 16#30#, 16#C6#, 16#A1#, 16#D8#, 16#27#, 16#F6#,
      16#D6#, 16#40#, 16#DA#, 16#F4#, 16#0B#, 16#0B#, 16#35#, 16#EF#,
      16#03#, 16#25#, 16#5B#, 16#EF#, 16#A3#, 16#4E#, 16#31#, 16#D4#,
      16#35#, 16#A1#, 16#A2#, 16#E2#, 16#FF#, 16#AA#, 16#EA#, 16#72#,
      16#82#, 16#82#, 16#D2#, 16#D0#, 16#93#, 16#6C#, 16#19#, 16#10#);

   T1, T2 : UInt64;

   Hash_SK_Time,
   Hash_Reduce_SM1_Time,
   Hash_Reduce_SM2_Time,
   Scalarbase_R_Time,
   Pack_P_Time,
   Initialize_X_Time,
   Assign_X_Time,
   ModL_X_Time,
   Total_Time   : Unsigned_64;

   CPU_Hz1, CPU_Hz2 : UInt32;

--   C2 : UInt64;
--   CES : Set_Of_Commit_Events;

--   function Read_MHPMCounter3 return UInt64
--     with Import,
--          Convention => Assembler,
--          Link_Name  => "_rv32_read_mhpmcounter3";

   procedure Report;

   procedure Tweet_Sign (SM :    out Byte_Seq;
                         M  : in     Byte_Seq;
                         SK : in     Signing_SK);

   procedure Tweet_Sign2 (SM :    out Byte_Seq;
                          M  : in     Byte_Seq;
                          SK : in     Signing_SK;
                          Hash_SK_Time : out Unsigned_64;
                          Hash_Reduce_SM1_Time : out Unsigned_64;
                          Scalarbase_R_Time    : out Unsigned_64;
                          Pack_P_Time          : out Unsigned_64;
                          Hash_Reduce_SM2_Time : out Unsigned_64;
                          Initialize_X_Time    : out Unsigned_64;
                          Assign_X_Time        : out Unsigned_64;
                          ModL_X_Time          : out Unsigned_64);

   procedure Tweet_Sign (SM :    out Byte_Seq;
                         M  : in     Byte_Seq;
                         SK : in     Signing_SK)
   is
      SMLen : Unsigned_64;
   begin
      TweetNaCl_API.Crypto_Sign (SM,
                                 SMLen,
                                 M,
                                 M'Length,
                                 SK);
   end Tweet_Sign;

   procedure Tweet_Sign2 (SM :    out Byte_Seq;
                          M  : in     Byte_Seq;
                          SK : in     Signing_SK;
                          Hash_SK_Time : out Unsigned_64;
                          Hash_Reduce_SM1_Time : out Unsigned_64;
                          Scalarbase_R_Time    : out Unsigned_64;
                          Pack_P_Time          : out Unsigned_64;
                          Hash_Reduce_SM2_Time : out Unsigned_64;
                          Initialize_X_Time    : out Unsigned_64;
                          Assign_X_Time        : out Unsigned_64;
                          ModL_X_Time          : out Unsigned_64)
   is
      SMLen : Unsigned_64;
   begin
      TweetNaCl_API.Crypto_Sign2 (SM,
                                  SMLen,
                                  M,
                                  M'Length,
                                  SK,
                                  Hash_SK_Time,
                                  Hash_Reduce_SM1_Time,
                                  Scalarbase_R_Time,
                                  Pack_P_Time,
                                  Hash_Reduce_SM2_Time,
                                  Initialize_X_Time,
                                  Assign_X_Time,
                                  ModL_X_Time);
   end Tweet_Sign2;

   procedure Report
   is
   begin
      IO.Put_Line ("Hash SK:         ", Hash_SK_Time);
      IO.Put_Line ("Hash_Reduce SM1: ", Hash_Reduce_SM1_Time);
      IO.Put_Line ("Scalarbase R:    ", Scalarbase_R_Time);
      IO.Put_Line ("Pack P:          ", Pack_P_Time);
      IO.Put_Line ("Hash_Reduce SM2: ", Hash_Reduce_SM2_Time);
      IO.Put_Line ("Initialize X:    ", Initialize_X_Time);
      IO.Put_Line ("Assign X:        ", Assign_X_Time);
      IO.Put_Line ("ModL X:          ", ModL_X_Time);
      IO.Put      ("Total:           ");
      IO.Put      (UInt64 (Total_Time));
      IO.Put_Line (" cycles");
   end Report;

   pragma Unreferenced (Tweet_Sign);
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

   Construct (My_SK, SK);

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

   IO.Put_Line ("SPARKNaCl.Sign test");
   SPARKNaCl.Count.Reset;
   T1 := Mcycle.Read;

   SPARKNaCl.Sign.Sign2 (SM1, M, SK,
                         Hash_SK_Time,
                         Hash_Reduce_SM1_Time,
                         Scalarbase_R_Time,
                         Pack_P_Time,
                         Hash_Reduce_SM2_Time,
                         Initialize_X_Time,
                         Assign_X_Time,
                         ModL_X_Time);
   T2 := Mcycle.Read;
   Total_Time := Unsigned_64 (T2 - T1);
   Report;

   IO.New_Line;
   IO.Put ("SPARKNaCl GF_Add is ");
   IO.Put (UInt64 (SPARKNaCl.Count.GF_Add));
   IO.New_Line;
   IO.Put ("SPARKNaCl GF_Sub is ");
   IO.Put (UInt64 (SPARKNaCl.Count.GF_Sub));
   IO.New_Line;
   IO.Put ("SPARKNaCl GF_Mul is ");
   IO.Put (UInt64 (SPARKNaCl.Count.GF_Mul));
   IO.New_Line;
   IO.Put ("SPARKNaCl GF_Car is ");
   IO.Put (UInt64 (SPARKNaCl.Count.GF_Car));
   IO.New_Line;

   Turn_Off (Red_LED);
   Turn_On (Green_LED);

   IO.New_Line;
   IO.Put_Line ("TweetNaCl.Sign test");
   TweetNaCl_API.Reset;
   T1 := Mcycle.Read;
   Tweet_Sign2
     (SM2, M, SK,
      Hash_SK_Time,
      Hash_Reduce_SM1_Time,
      Scalarbase_R_Time,
      Pack_P_Time,
      Hash_Reduce_SM2_Time,
      Initialize_X_Time,
      Assign_X_Time,
      ModL_X_Time);
   T2 := Mcycle.Read;
   Total_Time := Unsigned_64 (T2 - T1);

   Report;

   IO.Put ("TweetNaCl GF_Add is ");
   IO.Put (UInt64 (TweetNaCl_API.GF_Add));
   IO.New_Line;
   IO.Put ("TweetNaCl GF_Sub is ");
   IO.Put (UInt64 (TweetNaCl_API.GF_Sub));
   IO.New_Line;
   IO.Put ("TweetNaCl GF_Mul is ");
   IO.Put (UInt64 (TweetNaCl_API.GF_Mul));
   IO.New_Line;
   IO.Put ("TweetNaCl GF_Car is ");
   IO.Put (UInt64 (TweetNaCl_API.GF_Car));
   IO.New_Line;

--   IO.Put ("Tweet SM (0 ..63) is", SM (0 .. 63));
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
end TSign;
