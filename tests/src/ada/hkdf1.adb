with SPARKNaCl;       use SPARKNaCl;
with SPARKNaCl.HKDF;  use SPARKNaCl.HKDF;
with SPARKNaCl.Debug; use SPARKNaCl.Debug;
procedure HKDF1
is

   --  Test vectors from RFC 5869 Appendix A
   --  https://www.rfc-editor.org/rfc/rfc5869.html

   --  Basic test case with SHA-256

   IKM_1  : constant Byte_Seq (0 .. 21) := (others => 16#0b#);

   Salt_1 : constant Byte_Seq := (
      16#00#, 16#01#, 16#02#, 16#03#, 16#04#, 16#05#, 16#06#, 16#07#,
      16#08#, 16#09#, 16#0a#, 16#0b#, 16#0c#
   );

   Info_1 : constant Byte_Seq := (
      16#f0#, 16#f1#, 16#f2#, 16#f3#, 16#f4#, 16#f5#, 16#f6#, 16#f7#,
      16#f8#, 16#f9#
   );

   --  Test with SHA-256 and longer inputs/outputs

   IKM_2  : constant Byte_Seq := (
      16#00#, 16#01#, 16#02#, 16#03#, 16#04#, 16#05#, 16#06#, 16#07#,
      16#08#, 16#09#, 16#0A#, 16#0B#, 16#0C#, 16#0D#, 16#0E#, 16#0F#,
      16#10#, 16#11#, 16#12#, 16#13#, 16#14#, 16#15#, 16#16#, 16#17#,
      16#18#, 16#19#, 16#1A#, 16#1B#, 16#1C#, 16#1D#, 16#1E#, 16#1F#,
      16#20#, 16#21#, 16#22#, 16#23#, 16#24#, 16#25#, 16#26#, 16#27#,
      16#28#, 16#29#, 16#2A#, 16#2B#, 16#2C#, 16#2D#, 16#2E#, 16#2F#,
      16#30#, 16#31#, 16#32#, 16#33#, 16#34#, 16#35#, 16#36#, 16#37#,
      16#38#, 16#39#, 16#3A#, 16#3B#, 16#3C#, 16#3D#, 16#3E#, 16#3F#,
      16#40#, 16#41#, 16#42#, 16#43#, 16#44#, 16#45#, 16#46#, 16#47#,
      16#48#, 16#49#, 16#4A#, 16#4B#, 16#4C#, 16#4D#, 16#4E#, 16#4F#
   );

   Salt_2 : constant Byte_Seq := (
      16#60#, 16#61#, 16#62#, 16#63#, 16#64#, 16#65#, 16#66#, 16#67#,
      16#68#, 16#69#, 16#6A#, 16#6B#, 16#6C#, 16#6D#, 16#6E#, 16#6F#,
      16#70#, 16#71#, 16#72#, 16#73#, 16#74#, 16#75#, 16#76#, 16#77#,
      16#78#, 16#79#, 16#7A#, 16#7B#, 16#7C#, 16#7D#, 16#7E#, 16#7F#,
      16#80#, 16#81#, 16#82#, 16#83#, 16#84#, 16#85#, 16#86#, 16#87#,
      16#88#, 16#89#, 16#8A#, 16#8B#, 16#8C#, 16#8D#, 16#8E#, 16#8F#,
      16#90#, 16#91#, 16#92#, 16#93#, 16#94#, 16#95#, 16#96#, 16#97#,
      16#98#, 16#99#, 16#9A#, 16#9B#, 16#9C#, 16#9D#, 16#9E#, 16#9F#,
      16#A0#, 16#A1#, 16#A2#, 16#A3#, 16#A4#, 16#A5#, 16#A6#, 16#A7#,
      16#A8#, 16#A9#, 16#AA#, 16#AB#, 16#AC#, 16#AD#, 16#AE#, 16#AF#
   );

   Info_2 : constant Byte_Seq := (
      16#B0#, 16#B1#, 16#B2#, 16#B3#, 16#B4#, 16#B5#, 16#B6#, 16#B7#,
      16#B8#, 16#B9#, 16#BA#, 16#BB#, 16#BC#, 16#BD#, 16#BE#, 16#BF#,
      16#C0#, 16#C1#, 16#C2#, 16#C3#, 16#C4#, 16#C5#, 16#C6#, 16#C7#,
      16#C8#, 16#C9#, 16#CA#, 16#CB#, 16#CC#, 16#CD#, 16#CE#, 16#CF#,
      16#D0#, 16#D1#, 16#D2#, 16#D3#, 16#D4#, 16#D5#, 16#D6#, 16#D7#,
      16#D8#, 16#D9#, 16#DA#, 16#DB#, 16#DC#, 16#DD#, 16#DE#, 16#DF#,
      16#E0#, 16#E1#, 16#E2#, 16#E3#, 16#E4#, 16#E5#, 16#E6#, 16#E7#,
      16#E8#, 16#E9#, 16#EA#, 16#EB#, 16#EC#, 16#ED#, 16#EE#, 16#EF#,
      16#F0#, 16#F1#, 16#F2#, 16#F3#, 16#F4#, 16#F5#, 16#F6#, 16#F7#,
      16#F8#, 16#F9#, 16#FA#, 16#FB#, 16#FC#, 16#FD#, 16#FE#, 16#FF#
   );

   --  Test with SHA-256 and zero-length salt/info

   IKM_3  : constant Byte_Seq (0 .. 21) := (others => 16#0b#);
   Salt_3 : constant Byte_Seq (1 .. 0) := (others => <>);   -- empty
   Info_3 : constant Byte_Seq (1 .. 0) := (others => <>);   -- empty

   PRK   : Bytes_32;
   OKM_1 : OKM_Seq (0 .. 41);
   OKM_2 : OKM_Seq (0 .. 81);
   OKM_3 : OKM_Seq (0 .. 41);

   --  Non-RFC 5869 tests from Project Wycheproof

   IKM_4 : constant Byte_Seq := (
      16#60#, 16#ab#, 16#7f#, 16#45#, 16#b0#, 16#ad#, 16#53#, 16#46#,
      16#83#, 16#b3#, 16#a6#, 16#c0#, 16#20#, 16#d4#, 16#f7#, 16#75#
   );

   Salt_4 : constant Byte_Seq (1 .. 0) := (others => <>);
   Info_4 : constant Byte_Seq (1 .. 0) := (others => <>);

   OKM_4 : OKM_Seq (0 .. 19);

   IKM_5 : constant Byte_Seq := (
      16#e3#, 16#db#, 16#76#, 16#e0#, 16#22#, 16#78#, 16#cb#, 16#d2#,
      16#ad#, 16#bc#, 16#b4#, 16#55#, 16#58#, 16#03#, 16#da#, 16#11#
   );

   Salt_5 : constant Byte_Seq (1 .. 0) := (others => <>);
   Info_5 : constant Byte_Seq (1 .. 0) := (others => <>);
   OKM_5  : OKM_Seq (0 .. 41);

   IKM_6 : constant Byte_Seq := (
      16#d4#, 16#dc#, 16#b9#, 16#2a#, 16#76#, 16#9f#, 16#57#, 16#c8#,
      16#ba#, 16#b8#, 16#a4#, 16#20#, 16#ee#, 16#0a#, 16#a3#, 16#51#
   );

   Salt_6 : constant Byte_Seq (1 .. 0) := (others => <>);
   Info_6 : constant Byte_Seq (1 .. 0) := (others => <>);
   OKM_6  : OKM_Seq (0 .. 63);

   IKM_7 : constant Byte_Seq := (
      16#2d#, 16#43#, 16#e5#, 16#4b#, 16#f0#, 16#c9#, 16#4c#, 16#9c#,
      16#bf#, 16#f4#, 16#30#, 16#0f#, 16#4a#, 16#a6#, 16#9a#, 16#b8#
   );

   Salt_7 : constant Byte_Seq (1 .. 0) := (others => <>);
   Info_7 : constant Byte_Seq := (
      16#d6#, 16#74#, 16#da#, 16#3b#, 16#b4#, 16#7d#, 16#5c#, 16#7e#,
      16#38#, 16#b5#, 16#01#, 16#e5#, 16#25#, 16#1d#, 16#93#, 16#48#,
      16#af#, 16#60#, 16#1c#, 16#44#
   );
   OKM_7 : OKM_Seq (0 .. 19);

   IKM_8  : constant Byte_Seq := (
      16#40#, 16#55#, 16#53#, 16#68#, 16#96#, 16#c4#, 16#06#, 16#d5#,
      16#fe#, 16#14#, 16#a6#, 16#cd#, 16#6b#, 16#99#, 16#9b#, 16#ff#
   );

   Salt_8 : constant Byte_Seq (1 .. 0) := (others => <>);
   Info_8 : constant Byte_Seq := (
      16#20#, 16#94#, 16#76#, 16#8a#, 16#88#, 16#16#, 16#f7#, 16#df#,
      16#07#, 16#0d#, 16#6e#, 16#08#, 16#b7#, 16#ad#, 16#93#, 16#75#,
      16#5d#, 16#c9#, 16#02#, 16#4b#
   );
   OKM_8  : OKM_Seq (0 .. 41);

   IKM_9  : constant Byte_Seq := (
      16#5b#, 16#01#, 16#b2#, 16#da#, 16#31#, 16#66#, 16#f2#, 16#17#,
      16#cd#, 16#d6#, 16#8d#, 16#e8#, 16#af#, 16#60#, 16#07#, 16#8f#
   );

   Salt_9 : constant Byte_Seq (1 .. 0) := (others => <>);
   Info_9 : constant Byte_Seq := (
      16#68#, 16#84#, 16#cf#, 16#a7#, 16#ff#, 16#e8#, 16#f2#, 16#7b#,
      16#f4#, 16#eb#, 16#c6#, 16#e4#, 16#6a#, 16#7e#, 16#01#, 16#48#,
      16#8c#, 16#79#, 16#24#, 16#3a#
   );
   OKM_9  : OKM_Seq (0 .. 63);

   IKM_10 : constant Byte_Seq := (
      16#46#, 16#74#, 16#03#, 16#c2#, 16#ec#, 16#02#, 16#a2#, 16#35#,
      16#bf#, 16#73#, 16#0f#, 16#f3#, 16#7e#, 16#8d#, 16#8f#, 16#f3#
   );

   Salt_10 : constant Byte_Seq := (
      16#41#, 16#f0#, 16#f1#, 16#73#, 16#d3#, 16#07#, 16#d4#, 16#04#,
      16#36#, 16#c2#, 16#58#, 16#56#, 16#cf#, 16#55#, 16#9f#, 16#96#
   );
   Info_10 : constant Byte_Seq (1 .. 0) := (others => <>);
   OKM_10  : OKM_Seq (0 .. 19);

   IKM_14  : constant Byte_Seq := (
      16#5d#, 16#3d#, 16#b2#, 16#0e#, 16#82#, 16#38#, 16#a9#, 16#0b#,
      16#62#, 16#a6#, 16#00#, 16#fa#, 16#57#, 16#fd#, 16#b3#, 16#18#
   );

   Salt_14 : constant Byte_Seq := (
      16#1d#, 16#6f#, 16#3b#, 16#38#, 16#a1#, 16#e6#, 16#07#, 16#b5#,
      16#e6#, 16#bc#, 16#d4#, 16#af#, 16#18#, 16#00#, 16#a9#, 16#d3#
   );

   Info_14 : constant Byte_Seq := (
      16#2b#, 16#c5#, 16#f3#, 16#90#, 16#32#, 16#b6#, 16#fc#, 16#87#,
      16#da#, 16#69#, 16#ba#, 16#87#, 16#11#, 16#ce#, 16#73#, 16#5b#,
      16#16#, 16#96#, 16#46#, 16#fd#
   );
   OKM_14 : OKM_Seq (0 .. 41);

   IKM_20 : constant Byte_Seq := (
      16#49#, 16#bf#, 16#15#, 16#5c#, 16#a1#, 16#02#, 16#02#, 16#6f#,
      16#2a#, 16#21#, 16#7e#, 16#a1#, 16#bc#, 16#98#, 16#43#, 16#ac#
   );

   Salt_20 : constant Byte_Seq := (
      16#76#, 16#77#, 16#6e#, 16#3b#, 16#4d#, 16#75#, 16#f8#, 16#f4#,
      16#3d#, 16#ce#, 16#4b#, 16#de#, 16#d7#, 16#1f#, 16#3b#, 16#1a#,
      16#e6#, 16#bc#, 16#b0#, 16#12#, 16#d9#, 16#c0#, 16#d5#, 16#9f#,
      16#78#, 16#24#, 16#8b#, 16#94#, 16#27#, 16#b8#
   );

   Info_20 : constant Byte_Seq := (
      16#85#, 16#1b#, 16#da#, 16#4f#, 16#aa#, 16#8f#, 16#7a#, 16#dd#,
      16#2a#, 16#3c#, 16#bf#, 16#0a#, 16#cf#, 16#9c#, 16#27#, 16#86#,
      16#f8#, 16#f9#, 16#55#, 16#b2#
   );

   OKM_20 : OKM_Seq (0 .. 41);

   IKM_48 : constant Byte_Seq := (
      16#e6#, 16#71#, 16#5c#, 16#c4#, 16#ee#, 16#13#, 16#c4#, 16#d9#,
      16#99#, 16#d8#, 16#f8#, 16#f5#, 16#00#, 16#24#, 16#3c#, 16#32#,
      16#1f#, 16#70#, 16#b0#, 16#be#
   );

   Salt_48 : constant Byte_Seq := (
      16#ec#, 16#fa#, 16#ca#, 16#2e#, 16#a3#, 16#30#, 16#1a#, 16#99#,
      16#2b#, 16#4d#, 16#e0#, 16#81#, 16#d9#, 16#d3#, 16#a4#, 16#cc#
   );

   Info_48 : constant Byte_Seq := (
      16#ef#, 16#17#, 16#c9#, 16#22#, 16#7a#, 16#5c#, 16#a6#, 16#54#,
      16#fb#, 16#db#, 16#35#, 16#dd#, 16#00#, 16#dd#, 16#6d#, 16#c7#,
      16#7b#, 16#63#, 16#21#, 16#de#
   );

   OKM_48 : OKM_Seq (0 .. 63);

   IKM_70 : constant Byte_Seq := (
      16#b1#, 16#8e#, 16#35#, 16#e6#, 16#3c#, 16#c4#, 16#fe#, 16#41#,
      16#17#, 16#bf#, 16#27#, 16#54#, 16#ec#, 16#3f#, 16#9e#, 16#bb#,
      16#53#, 16#46#, 16#db#, 16#b0#, 16#bf#, 16#6d#, 16#4e#, 16#5f#,
      16#24#, 16#22#, 16#41#, 16#87#, 16#71#, 16#81#, 16#6f#, 16#c4#
   );

   Salt_70 : constant Byte_Seq (1 .. 0) := (others => 0);
   Info_70 : constant Byte_Seq (1 .. 0) := (others => 0);

   OKM_70 : OKM_Seq (0 .. 19);

   IKM_88 : constant Byte_Seq := (
      16#17#, 16#63#, 16#25#, 16#81#, 16#c3#, 16#4a#, 16#b7#, 16#43#,
      16#99#, 16#2c#, 16#d9#, 16#93#, 16#18#, 16#88#, 16#9b#, 16#32#,
      16#f9#, 16#28#, 16#12#, 16#bd#, 16#37#, 16#f4#, 16#16#, 16#36#,
      16#b5#, 16#fb#, 16#bf#, 16#2b#, 16#12#, 16#19#, 16#0c#, 16#6f#
   );

   Salt_88 : constant Byte_Seq := (
      16#55#, 16#e3#, 16#94#, 16#31#, 16#c8#, 16#36#, 16#48#, 16#86#,
      16#7a#, 16#c9#, 16#8e#, 16#b7#, 16#ec#, 16#bb#, 16#c8#, 16#b4#,
      16#1c#, 16#5a#, 16#5e#, 16#77#, 16#46#, 16#46#, 16#b9#, 16#26#,
      16#a9#, 16#b4#, 16#9c#, 16#51#, 16#19#, 16#15#, 16#b0#, 16#de#,
      16#12#, 16#41#, 16#f8#, 16#66#, 16#6d#, 16#a1#, 16#98#, 16#f6#,
      16#ba#, 16#4b#, 16#f7#, 16#e9#, 16#02#, 16#5e#, 16#43#, 16#4b#,
      16#6d#, 16#7e#, 16#f7#, 16#94#, 16#e7#, 16#a5#, 16#63#, 16#30#,
      16#93#, 16#03#, 16#05#, 16#5f#, 16#e3#, 16#bb#, 16#e7#, 16#69#
   );

   Info_88 : constant Byte_Seq (1 .. 0) := (others => 0);
   OKM_88 : OKM_Seq (0 .. 41);

   IKM_92 : constant Byte_Seq := (
      16#2b#, 16#1c#, 16#ce#, 16#4f#, 16#55#, 16#1d#, 16#59#, 16#32#,
      16#7f#, 16#13#, 16#e0#, 16#eb#, 16#78#, 16#fe#, 16#51#, 16#ed#,
      16#5e#, 16#74#, 16#d1#, 16#c5#, 16#bc#, 16#e2#, 16#d5#, 16#00#,
      16#d8#, 16#32#, 16#b4#, 16#b8#, 16#80#, 16#c0#, 16#41#, 16#dd#
   );

   Salt_92 : constant Byte_Seq := (
      16#7b#, 16#9a#, 16#b6#, 16#28#, 16#7d#, 16#ea#, 16#79#, 16#63#,
      16#94#, 16#ab#, 16#0b#, 16#7d#, 16#26#, 16#04#, 16#76#, 16#d0#,
      16#2f#, 16#86#, 16#e0#, 16#22#, 16#66#, 16#bc#, 16#97#, 16#11#,
      16#f8#, 16#ba#, 16#48#, 16#61#, 16#ab#, 16#69#, 16#ac#, 16#8d#
   );

   Info_92 : constant Byte_Seq := (
      16#eb#, 16#d6#, 16#44#, 16#65#, 16#0e#, 16#75#, 16#a7#, 16#74#
   );

   OKM_92 : OKM_Seq (0 .. 127);

   IKM_97 : constant Byte_Seq := (
      16#2b#, 16#54#, 16#cb#, 16#a2#, 16#96#, 16#81#, 16#b6#, 16#ff#,
      16#2f#, 16#ea#, 16#a9#, 16#20#, 16#2b#, 16#87#, 16#32#, 16#2d#,
      16#86#, 16#1a#, 16#ff#, 16#8a#, 16#82#, 16#60#, 16#e1#, 16#bd#,
      16#a6#, 16#8d#, 16#61#, 16#97#, 16#9e#, 16#60#, 16#5b#, 16#2d#
   );

   Salt_97 : constant Byte_Seq := (
      16#01#, 16#02#, 16#c6#, 16#51#, 16#e0#, 16#47#, 16#fe#, 16#d9#,
      16#c2#, 16#17#, 16#bc#, 16#f9#, 16#15#, 16#52#, 16#05#, 16#32#,
      16#d4#, 16#49#, 16#99#, 16#53#, 16#4c#, 16#1e#, 16#7e#, 16#7c#,
      16#87#, 16#31#, 16#10#, 16#93#, 16#d7#, 16#a3#, 16#68#, 16#1a#,
      16#ff#, 16#3e#, 16#2d#, 16#33#, 16#5b#, 16#3c#, 16#61#, 16#39#,
      16#b9#, 16#fc#, 16#66#, 16#dc#, 16#fe#, 16#35#, 16#57#, 16#3b#,
      16#36#, 16#a3#, 16#29#, 16#a5#, 16#50#, 16#c4#, 16#cd#, 16#20#,
      16#bf#, 16#e2#, 16#a9#, 16#0d#, 16#fe#, 16#a5#, 16#01#, 16#67#,
      16#ff#
   );

   Info_97 : constant Byte_Seq := (
      16#13#, 16#01#, 16#b6#, 16#31#, 16#68#, 16#af#, 16#54#, 16#51#,
      16#37#, 16#77#, 16#17#, 16#f7#, 16#f5#, 16#ed#, 16#52#, 16#de#,
      16#36#, 16#a1#, 16#97#, 16#ff#
   );

   OKM_97 : OKM_Seq (0 .. 31);

   --  Test vectors from https://tools.ietf.org/html/draft-ietf-tls-tls13-vectors-07

   --  Extract secret "early"
   IKM_TLS_1  : Byte_Seq (0 .. 31) := (others => 0);
   Salt_TLS_1 : Byte_Seq (1 .. 0) := (others => <>);

   --  Derive secret for handshake "tls13 derived"
   PRK_TLS_2  : Byte_Seq := (
      16#33#, 16#ad#, 16#0a#, 16#1c#, 16#60#, 16#7e#, 16#c0#, 16#3b#,
      16#09#, 16#e6#, 16#cd#, 16#98#, 16#93#, 16#68#, 16#0c#, 16#e2#,
      16#10#, 16#ad#, 16#f3#, 16#00#, 16#aa#, 16#1f#, 16#26#, 16#60#,
      16#e1#, 16#b2#, 16#2e#, 16#10#, 16#f1#, 16#70#, 16#f9#, 16#2a#
   );

   Info_TLS_2 : Byte_Seq := (
      16#00#, 16#20#, 16#0d#, 16#74#, 16#6c#, 16#73#, 16#31#, 16#33#,
      16#20#, 16#64#, 16#65#, 16#72#, 16#69#, 16#76#, 16#65#, 16#64#,
      16#20#, 16#e3#, 16#b0#, 16#c4#, 16#42#, 16#98#, 16#fc#, 16#1c#,
      16#14#, 16#9a#, 16#fb#, 16#f4#, 16#c8#, 16#99#, 16#6f#, 16#b9#,
      16#24#, 16#27#, 16#ae#, 16#41#, 16#e4#, 16#64#, 16#9b#, 16#93#,
      16#4c#, 16#a4#, 16#95#, 16#99#, 16#1b#, 16#78#, 16#52#, 16#b8#,
      16#55#
   );

   OKM_TLS_2 : OKM_Seq (0 .. 31);

   --  Extract secret "handshake"
   IKM_TLS_3 : Byte_Seq := (
      16#8b#, 16#d4#, 16#05#, 16#4f#, 16#b5#, 16#5b#, 16#9d#, 16#63#,
      16#fd#, 16#fb#, 16#ac#, 16#f9#, 16#f0#, 16#4b#, 16#9f#, 16#0d#,
      16#35#, 16#e6#, 16#d6#, 16#3f#, 16#53#, 16#75#, 16#63#, 16#ef#,
      16#d4#, 16#62#, 16#72#, 16#90#, 16#0f#, 16#89#, 16#49#, 16#2d#
   );

   Salt_TLS_3 : Byte_Seq := (
      16#6f#, 16#26#, 16#15#, 16#a1#, 16#08#, 16#c7#, 16#02#, 16#c5#,
      16#67#, 16#8f#, 16#54#, 16#fc#, 16#9d#, 16#ba#, 16#b6#, 16#97#,
      16#16#, 16#c0#, 16#76#, 16#18#, 16#9c#, 16#48#, 16#25#, 16#0c#,
      16#eb#, 16#ea#, 16#c3#, 16#57#, 16#6c#, 16#36#, 16#11#, 16#ba#
   );

   --  Derive secret "tls13 c hs traffic"
   PRK_TLS_4 : Byte_Seq := (
      16#1d#, 16#c8#, 16#26#, 16#e9#, 16#36#, 16#06#, 16#aa#, 16#6f#,
      16#dc#, 16#0a#, 16#ad#, 16#c1#, 16#2f#, 16#74#, 16#1b#, 16#01#,
      16#04#, 16#6a#, 16#a6#, 16#b9#, 16#9f#, 16#69#, 16#1e#, 16#d2#,
      16#21#, 16#a9#, 16#f0#, 16#ca#, 16#04#, 16#3f#, 16#be#, 16#ac#
   );

   Info_TLS_4 : Byte_Seq := (
      16#00#, 16#20#, 16#12#, 16#74#, 16#6c#, 16#73#, 16#31#, 16#33#,
      16#20#, 16#63#, 16#20#, 16#68#, 16#73#, 16#20#, 16#74#, 16#72#,
      16#61#, 16#66#, 16#66#, 16#69#, 16#63#, 16#20#, 16#86#, 16#0c#,
      16#06#, 16#ed#, 16#c0#, 16#78#, 16#58#, 16#ee#, 16#8e#, 16#78#,
      16#f0#, 16#e7#, 16#42#, 16#8c#, 16#58#, 16#ed#, 16#d6#, 16#b4#,
      16#3f#, 16#2c#, 16#a3#, 16#e6#, 16#e9#, 16#5f#, 16#02#, 16#ed#,
      16#06#, 16#3c#, 16#f0#, 16#e1#, 16#ca#, 16#d8#
   );

   OKM_TLS_4 : OKM_Seq (0 .. 31);

   --  Derive secret "tls13 s hs traffic"
   PRK_TLS_5 : Byte_Seq := (
      16#1d#, 16#c8#, 16#26#, 16#e9#, 16#36#, 16#06#, 16#aa#, 16#6f#,
      16#dc#, 16#0a#, 16#ad#, 16#c1#, 16#2f#, 16#74#, 16#1b#, 16#01#,
      16#04#, 16#6a#, 16#a6#, 16#b9#, 16#9f#, 16#69#, 16#1e#, 16#d2#,
      16#21#, 16#a9#, 16#f0#, 16#ca#, 16#04#, 16#3f#, 16#be#, 16#ac#
   );

   Info_TLS_5 : Byte_Seq := (
      16#00#, 16#20#, 16#12#, 16#74#, 16#6c#, 16#73#, 16#31#, 16#33#,
      16#20#, 16#73#, 16#20#, 16#68#, 16#73#, 16#20#, 16#74#, 16#72#,
      16#61#, 16#66#, 16#66#, 16#69#, 16#63#, 16#20#, 16#86#, 16#0c#,
      16#06#, 16#ed#, 16#c0#, 16#78#, 16#58#, 16#ee#, 16#8e#, 16#78#,
      16#f0#, 16#e7#, 16#42#, 16#8c#, 16#58#, 16#ed#, 16#d6#, 16#b4#,
      16#3f#, 16#2c#, 16#a3#, 16#e6#, 16#e9#, 16#5f#, 16#02#, 16#ed#,
      16#06#, 16#3c#, 16#f0#, 16#e1#, 16#ca#, 16#d8#
   );

   OKM_TLS_5 : OKM_Seq (0 .. 31);

   --  Derive secret "tls13 derived"
   PRK_TLS_6 : Byte_Seq := (
      16#1d#, 16#c8#, 16#26#, 16#e9#, 16#36#, 16#06#, 16#aa#, 16#6f#,
      16#dc#, 16#0a#, 16#ad#, 16#c1#, 16#2f#, 16#74#, 16#1b#, 16#01#,
      16#04#, 16#6a#, 16#a6#, 16#b9#, 16#9f#, 16#69#, 16#1e#, 16#d2#,
      16#21#, 16#a9#, 16#f0#, 16#ca#, 16#04#, 16#3f#, 16#be#, 16#ac#
   );

   Info_TLS_6 : Byte_Seq := (
      16#00#, 16#20#, 16#0d#, 16#74#, 16#6c#, 16#73#, 16#31#, 16#33#,
      16#20#, 16#64#, 16#65#, 16#72#, 16#69#, 16#76#, 16#65#, 16#64#,
      16#20#, 16#e3#, 16#b0#, 16#c4#, 16#42#, 16#98#, 16#fc#, 16#1c#,
      16#14#, 16#9a#, 16#fb#, 16#f4#, 16#c8#, 16#99#, 16#6f#, 16#b9#,
      16#24#, 16#27#, 16#ae#, 16#41#, 16#e4#, 16#64#, 16#9b#, 16#93#,
      16#4c#, 16#a4#, 16#95#, 16#99#, 16#1b#, 16#78#, 16#52#, 16#b8#,
      16#55#
   );

   OKM_TLS_6 : OKM_Seq (0 .. 31);
begin

   Extract (PRK, IKM_1, Salt_1);
   DH ("PRK 1 is", PRK);
   Expand (OKM_1, PRK, Info_1);
   DH ("OKM 1 is", Byte_Seq (OKM_1));

   Extract (PRK, IKM_2, Salt_2);
   DH ("PRK 2 is", PRK);
   Expand (OKM_2, PRK, Info_2);
   DH ("OKM 2 is", Byte_Seq (OKM_2));

   Extract (PRK, IKM_3, Salt_3);
   DH ("PRK 3 is", PRK);
   Expand (OKM_3, PRK, Info_3);
   DH ("OKM 3 is", Byte_Seq (OKM_3));

   Extract (PRK, IKM_4, Salt_4);
   Expand (OKM_4, PRK, Info_4);
   DH ("OKM 4 is", Byte_Seq (OKM_4));

   Extract (PRK, IKM_5, Salt_5);
   Expand (OKM_5, PRK, Info_5);
   DH ("OKM 5 is", Byte_Seq (OKM_5));

   Extract (PRK, IKM_6, Salt_6);
   Expand (OKM_6, PRK, Info_6);
   DH ("OKM 6 is", Byte_Seq (OKM_6));

   Extract (PRK, IKM_7, Salt_7);
   Expand (OKM_7, PRK, Info_7);
   DH ("OKM 7 is", Byte_Seq (OKM_7));

   Extract (PRK, IKM_8, Salt_8);
   Expand (OKM_8, PRK, Info_8);
   DH ("OKM 8 is", Byte_Seq (OKM_8));

   Extract (PRK, IKM_9, Salt_9);
   Expand (OKM_9, PRK, Info_9);
   DH ("OKM 9 is", Byte_Seq (OKM_9));

   Extract (PRK, IKM_10, Salt_10);
   Expand (OKM_10, PRK, Info_10);
   DH ("OKM 10 is", Byte_Seq (OKM_10));

   Extract (PRK, IKM_14, Salt_14);
   Expand (OKM_14, PRK, Info_14);
   DH ("OKM 14 is", Byte_Seq (OKM_14));

   Extract (PRK, IKM_20, Salt_20);
   Expand (OKM_20, PRK, Info_20);
   DH ("OKM 20 is", Byte_Seq (OKM_20));

   Extract (PRK, IKM_48, Salt_48);
   Expand (OKM_48, PRK, Info_48);
   DH ("OKM 48 is", Byte_Seq (OKM_48));

   Extract (PRK, IKM_70, Salt_70);
   Expand (OKM_70, PRK, Info_70);
   DH ("OKM 70 is", Byte_Seq (OKM_70));

   Extract (PRK, IKM_88, Salt_88);
   Expand (OKM_88, PRK, Info_88);
   DH ("OKM 88 is", Byte_Seq (OKM_88));

   Extract (PRK, IKM_92, Salt_92);
   Expand (OKM_92, PRK, Info_92);
   DH ("OKM 92 is", Byte_Seq (OKM_92));

   Extract (PRK, IKM_97, Salt_97);
   Expand (OKM_97, PRK, Info_97);
   DH ("OKM 97 is", Byte_Seq (OKM_97));

   Extract (PRK, IKM_TLS_1, Salt_TLS_1);
   DH ("IKM TLS 1 is", PRK);

   Expand (OKM_TLS_2, PRK_TLS_2, Info_TLS_2);
   DH ("OKM TLS 2 is", Byte_Seq (OKM_TLS_2));

   Extract (PRK, IKM_TLS_3, Salt_TLS_3);
   DH ("IKM TLS 3 is", PRK);

   Expand (OKM_TLS_4, PRK_TLS_4, Info_TLS_4);
   DH ("OKM TLS 4 is", Byte_Seq (OKM_TLS_4));

   Expand (OKM_TLS_5, PRK_TLS_5, Info_TLS_5);
   DH ("OKM TLS 5 is", Byte_Seq (OKM_TLS_5));

   Expand (OKM_TLS_6, PRK_TLS_6, Info_TLS_6);
   DH ("OKM TLS 6 is", Byte_Seq (OKM_TLS_6));
end HKDF1;
