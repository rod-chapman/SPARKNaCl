with HAL; use HAL;
with HiFive1.LEDs; use HiFive1.LEDs;
with FE310;
with FE310.CLINT;
with FE310.Time; use FE310.Time;

with Interfaces; use Interfaces;

with IO;

with SPARKNaCl;           use SPARKNaCl;
with SPARKNaCl.Cryptobox; use SPARKNaCl.Cryptobox;
with SPARKNaCl.Stream;

with TweetNaCl_API;

with RISCV.CSR; use RISCV.CSR;

procedure TBox

is
   subtype U64 is Unsigned_64;

--   AlicePK : constant Public_Key :=
--     Construct ((16#85#, 16#20#, 16#f0#, 16#09#,
--                 16#89#, 16#30#, 16#a7#, 16#54#,
--                 16#74#, 16#8b#, 16#7d#, 16#dc#,
--                 16#b4#, 16#3e#, 16#f7#, 16#5a#,
--                 16#0d#, 16#bf#, 16#3a#, 16#0d#,
--                 16#26#, 16#38#, 16#1a#, 16#f4#,
--                 16#eb#, 16#a4#, 16#a9#, 16#8e#,
--                 16#aa#, 16#9b#, 16#4e#, 16#6a#));

   AliceSK : constant Secret_Key :=
     Construct ((16#77#, 16#07#, 16#6d#, 16#0a#,
                 16#73#, 16#18#, 16#a5#, 16#7d#,
                 16#3c#, 16#16#, 16#c1#, 16#72#,
                 16#51#, 16#b2#, 16#66#, 16#45#,
                 16#df#, 16#4c#, 16#2f#, 16#87#,
                 16#eb#, 16#c0#, 16#99#, 16#2a#,
                 16#b1#, 16#77#, 16#fb#, 16#a5#,
                 16#1d#, 16#b9#, 16#2c#, 16#2a#));

   BobPK : constant Public_Key :=
     Construct ((16#de#, 16#9e#, 16#db#, 16#7d#,
                 16#7b#, 16#7d#, 16#c1#, 16#b4#,
                 16#d3#, 16#5b#, 16#61#, 16#c2#,
                 16#ec#, 16#e4#, 16#35#, 16#37#,
                 16#3f#, 16#83#, 16#43#, 16#c8#,
                 16#5b#, 16#78#, 16#67#, 16#4d#,
                 16#ad#, 16#fc#, 16#7e#, 16#14#,
                 16#6f#, 16#88#, 16#2b#, 16#4f#));

--   BobSK : constant Secret_Key :=
--     Construct ((16#5d#, 16#ab#, 16#08#, 16#7e#,
--                 16#62#, 16#4a#, 16#8a#, 16#4b#,
--                 16#79#, 16#e1#, 16#7f#, 16#8b#,
--                 16#83#, 16#80#, 16#0e#, 16#e6#,
--                 16#6f#, 16#3b#, 16#b1#, 16#29#,
--                 16#26#, 16#18#, 16#b6#, 16#fd#,
--                 16#1c#, 16#2f#, 16#8b#, 16#27#,
--                 16#ff#, 16#88#, 16#e0#, 16#eb#));

   Nonce : constant Stream.HSalsa20_Nonce :=
     (16#69#, 16#69#, 16#6e#, 16#e9#,
      16#55#, 16#b6#, 16#2b#, 16#73#,
      16#cd#, 16#62#, 16#bd#, 16#a8#,
      16#75#, 16#fc#, 16#73#, 16#d6#,
      16#82#, 16#19#, 16#e0#, 16#03#,
      16#6b#, 16#7a#, 16#0b#, 16#37#);


   M : constant Byte_Seq (0 .. 162) :=
     (0,    0,    0,    0,    0,    0,    0,    0,
      0,    0,    0,    0,    0,    0,    0,    0,
      0,    0,    0,    0,    0,    0,    0,    0,
      0,    0,    0,    0,    0,    0,    0,    0,
      16#be#, 16#07#, 16#5f#, 16#c5#, 16#3c#, 16#81#, 16#f2#, 16#d5#,
      16#cf#, 16#14#, 16#13#, 16#16#, 16#eb#, 16#eb#, 16#0c#, 16#7b#,
      16#52#, 16#28#, 16#c5#, 16#2a#, 16#4c#, 16#62#, 16#cb#, 16#d4#,
      16#4b#, 16#66#, 16#84#, 16#9b#, 16#64#, 16#24#, 16#4f#, 16#fc#,
      16#e5#, 16#ec#, 16#ba#, 16#af#, 16#33#, 16#bd#, 16#75#, 16#1a#,
      16#1a#, 16#c7#, 16#28#, 16#d4#, 16#5e#, 16#6c#, 16#61#, 16#29#,
      16#6c#, 16#dc#, 16#3c#, 16#01#, 16#23#, 16#35#, 16#61#, 16#f4#,
      16#1d#, 16#b6#, 16#6c#, 16#ce#, 16#31#, 16#4a#, 16#db#, 16#31#,
      16#0e#, 16#3b#, 16#e8#, 16#25#, 16#0c#, 16#46#, 16#f0#, 16#6d#,
      16#ce#, 16#ea#, 16#3a#, 16#7f#, 16#a1#, 16#34#, 16#80#, 16#57#,
      16#e2#, 16#f6#, 16#55#, 16#6a#, 16#d6#, 16#b1#, 16#31#, 16#8a#,
      16#02#, 16#4a#, 16#83#, 16#8f#, 16#21#, 16#af#, 16#1f#, 16#de#,
      16#04#, 16#89#, 16#77#, 16#eb#, 16#48#, 16#f5#, 16#9f#, 16#fd#,
      16#49#, 16#24#, 16#ca#, 16#1c#, 16#60#, 16#90#, 16#2e#, 16#52#,
      16#f0#, 16#a0#, 16#89#, 16#bc#, 16#76#, 16#89#, 16#70#, 16#40#,
      16#e0#, 16#82#, 16#f9#, 16#37#, 16#76#, 16#38#, 16#48#, 16#64#,
      16#5e#, 16#07#, 16#05#);


   C1 : Byte_Seq (0 .. 162);
   C2 : Byte_Seq (0 .. 162);
   Status : Boolean;


   T1, T2 : UInt64;

   Total_Time   : Unsigned_64;

   CPU_Hz1, CPU_Hz2 : UInt32;


   procedure Report;

   procedure Tweet_Cryptobox (C            :    out Byte_Seq;
                              Status       :    out Boolean;
                              M            : in     Byte_Seq;
                              N            : in     Stream.HSalsa20_Nonce;
                              Recipient_PK : in     Public_Key;
                              Sender_SK    : in     Secret_Key);

   procedure Tweet_Cryptobox (C            :    out Byte_Seq;
                              Status       :    out Boolean;
                              M            : in     Byte_Seq;
                              N            : in     Stream.HSalsa20_Nonce;
                              Recipient_PK : in     Public_Key;
                              Sender_SK    : in     Secret_Key)
   is
   begin
      TweetNaCl_API.Crypto_Box (C,
                                M,
                                M'Length,
                                N,
                                Recipient_PK,
                                Sender_SK);
      Status := True;
   end Tweet_Cryptobox;

   procedure Report
   is
   begin
      IO.Put      ("Total:           ");
      IO.Put      (UInt64 (Total_Time));
      IO.Put_Line (" cycles");
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

   IO.Put_Line ("SPARKNaCl.Cryptobox.Create test");

   T1 := Mcycle.Read;
   SPARKNaCl.Cryptobox.Create (C1, Status, M, Nonce, BobPK, AliceSK);
   T2 := Mcycle.Read;
   Total_Time := Unsigned_64 (T2 - T1);
   Report;

   Turn_Off (Red_LED);
   Turn_On (Green_LED);

   IO.New_Line;
   IO.Put_Line ("TweetNaCl.Cryptobox test");
   TweetNaCl_API.Reset;
   T1 := Mcycle.Read;
   Tweet_Cryptobox (C2, Status, M, Nonce, BobPK, AliceSK);
   T2 := Mcycle.Read;
   Total_Time := Unsigned_64 (T2 - T1);

   Report;

   if C1 = C2 then
      IO.Put_Line ("Pass");
   else
      IO.Put_Line ("Fail");
   end if;

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

end TBox;
