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
   OKM_1 : OKM_256 (0 .. 41);
   OKM_2 : OKM_256 (0 .. 81);
   OKM_3 : OKM_256 (0 .. 41);

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

end HKDF1;
