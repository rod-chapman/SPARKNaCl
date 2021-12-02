
sparknacl-hashing.o:     file format elf32-littleriscv


Disassembly of section .text.sparknacl__hashing__Tk_tableBIP:

00000000 <sparknacl__hashing__Tk_tableBIP>:
   0:	8082                	ret

Disassembly of section .text.sparknacl__hashing__hashblocks:

00000000 <sparknacl__hashing__hashblocks>:
             Shift_Left (U32 (X (I + 6)), 8) or
                         U32 (X (I + 7));
      return Shift_Left (U64 (MSW), 32) or U64 (LSW);
   end DL64;

   procedure Hashblocks
       0:	cd010113          	addi	sp,sp,-816
       4:	86aa                	mv	a3,a0

00000006 <.LBB119>:
             Shift_Left (U32 (X (I + 2)), 8) or
       6:	00354783          	lbu	a5,3(a0)

0000000a <.LBB138>:
       a:	00b6c803          	lbu	a6,11(a3)
       e:	00a6c883          	lbu	a7,10(a3)

00000012 <.LBE138>:
   procedure Hashblocks
      12:	8732                	mv	a4,a2
      14:	32912423          	sw	s1,808(sp)

00000018 <.LBB159>:
             Shift_Left (U32 (X (I + 2)), 8) or
      18:	00254603          	lbu	a2,2(a0)
             Shift_Left (U32 (X (I + 6)), 8) or
      1c:	0066c483          	lbu	s1,6(a3)

00000020 <.LBE159>:
   procedure Hashblocks
      20:	31712823          	sw	s7,784(sp)
      24:	31812623          	sw	s8,780(sp)

00000028 <.LBB160>:
             Shift_Left (U32 (X (I + 5)), 16) or
      28:	00554b83          	lbu	s7,5(a0)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
      2c:	00454c03          	lbu	s8,4(a0)

00000030 <.LBE160>:
   procedure Hashblocks
      30:	31912423          	sw	s9,776(sp)
      34:	31a12223          	sw	s10,772(sp)

00000038 <.LBB161>:
             Shift_Left (U32 (X (I + 1)), 16) or
      38:	00154c83          	lbu	s9,1(a0)
      MSW := Shift_Left (U32 (X (I)),     24) or
      3c:	00054d03          	lbu	s10,0(a0)

00000040 <.LBE161>:
   procedure Hashblocks
      40:	22a12623          	sw	a0,556(sp)

00000044 <.LBB162>:
             Shift_Left (U32 (X (I + 6)), 8) or
      44:	00754503          	lbu	a0,7(a0)

00000048 <.LBE162>:
   procedure Hashblocks
      48:	32812623          	sw	s0,812(sp)
      4c:	33212223          	sw	s2,804(sp)
      50:	31412e23          	sw	s4,796(sp)
      54:	31512c23          	sw	s5,792(sp)

00000058 <.LBB163>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
      58:	00c6ca03          	lbu	s4,12(a3)
             Shift_Left (U32 (X (I + 1)), 16) or
      5c:	0096ca83          	lbu	s5,9(a3)

00000060 <.LBE163>:
   procedure Hashblocks
      60:	31612a23          	sw	s6,788(sp)
      64:	31b12023          	sw	s11,768(sp)

00000068 <.LBB164>:
      MSW := Shift_Left (U32 (X (I)),     24) or
      68:	0086cb03          	lbu	s6,8(a3)

0000006c <.LBB165>:
             Shift_Left (U32 (X (I + 2)), 8) or
      6c:	c23e                	sw	a5,4(sp)
      6e:	c432                	sw	a2,8(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
      70:	c62a                	sw	a0,12(sp)
      72:	c826                	sw	s1,16(sp)

00000074 <.LBB166>:
             Shift_Left (U32 (X (I + 2)), 8) or
      74:	ca42                	sw	a6,20(sp)
      76:	cc46                	sw	a7,24(sp)

00000078 <.LBE166>:
   procedure Hashblocks
      78:	33312023          	sw	s3,800(sp)

0000007c <.LBB167>:
             Shift_Left (U32 (X (I + 5)), 16) or
      7c:	00d6c983          	lbu	s3,13(a3)
             Shift_Left (U32 (X (I + 6)), 8) or
      80:	00e6ce83          	lbu	t4,14(a3)

00000084 <.LBB168>:
             Shift_Left (U32 (X (I + 2)), 8) or
      84:	0136cf03          	lbu	t5,19(a3)
      88:	0126cf83          	lbu	t6,18(a3)
             Shift_Left (U32 (X (I + 6)), 8) or
      8c:	0176c283          	lbu	t0,23(a3)
      90:	0166cd83          	lbu	s11,22(a3)

00000094 <.LBB183>:
      94:	00f6c303          	lbu	t1,15(a3)

00000098 <.LBB184>:
             Shift_Left (U32 (X (I + 2)), 8) or
      98:	01b6c783          	lbu	a5,27(a3)
      9c:	01a6c603          	lbu	a2,26(a3)

000000a0 <.LBB203>:
      MSW := Shift_Left (U32 (X (I)),     24) or
      a0:	0106c903          	lbu	s2,16(a3)
             Shift_Left (U32 (X (I + 1)), 16) or
      a4:	0116c483          	lbu	s1,17(a3)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
      a8:	0146c403          	lbu	s0,20(a3)
             Shift_Left (U32 (X (I + 5)), 16) or
      ac:	0156c383          	lbu	t2,21(a3)

000000b0 <.LBB204>:
             Shift_Left (U32 (X (I + 6)), 8) or
      b0:	d076                	sw	t4,32(sp)

000000b2 <.LBB205>:
             Shift_Left (U32 (X (I + 2)), 8) or
      b2:	d27a                	sw	t5,36(sp)

000000b4 <.LBB206>:
             Shift_Left (U32 (X (I + 5)), 16) or
      b4:	01d6ce83          	lbu	t4,29(a3)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
      b8:	01c6cf03          	lbu	t5,28(a3)

000000bc <.LBB207>:
             Shift_Left (U32 (X (I + 2)), 8) or
      bc:	d47e                	sw	t6,40(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
      be:	d616                	sw	t0,44(sp)

000000c0 <.LBB208>:
             Shift_Left (U32 (X (I + 1)), 16) or
      c0:	0196cf83          	lbu	t6,25(a3)
      MSW := Shift_Left (U32 (X (I)),     24) or
      c4:	0186c283          	lbu	t0,24(a3)

000000c8 <.LBB209>:
             Shift_Left (U32 (X (I + 6)), 8) or
      c8:	d86e                	sw	s11,48(sp)

000000ca <.LBB210>:
             Shift_Left (U32 (X (I + 1)), 16) or
      ca:	8db6                	mv	s11,a3
             Shift_Left (U32 (X (I + 6)), 8) or
      cc:	01f6c683          	lbu	a3,31(a3)

000000d0 <.LBB211>:
      MSW := Shift_Left (U32 (X (I)),     24) or
      d0:	020dce03          	lbu	t3,32(s11)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
      d4:	024dc883          	lbu	a7,36(s11)

000000d8 <.LBE211>:
   procedure Hashblocks
      d8:	4348                	lw	a0,4(a4)

000000da <.LBB228>:
             Shift_Left (U32 (X (I + 6)), 8) or
      da:	ce1a                	sw	t1,28(sp)

000000dc <.LBB229>:
             Shift_Left (U32 (X (I + 2)), 8) or
      dc:	da3e                	sw	a5,52(sp)

000000de <.LBB230>:
             Shift_Left (U32 (X (I + 1)), 16) or
      de:	021dc303          	lbu	t1,33(s11)

000000e2 <.LBE230>:
   procedure Hashblocks
      e2:	431c                	lw	a5,0(a4)

000000e4 <.LBB231>:
             Shift_Left (U32 (X (I + 2)), 8) or
      e4:	dc32                	sw	a2,56(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
      e6:	de36                	sw	a3,60(sp)

000000e8 <.LBB232>:
             Shift_Left (U32 (X (I + 5)), 16) or
      e8:	025dc803          	lbu	a6,37(s11)

000000ec <.LBB233>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
      ec:	02cdc703          	lbu	a4,44(s11)
      MSW := Shift_Left (U32 (X (I)),     24) or
      f0:	028dc603          	lbu	a2,40(s11)
             Shift_Left (U32 (X (I + 1)), 16) or
      f4:	029dc683          	lbu	a3,41(s11)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
      f8:	ceba                	sw	a4,92(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
      fa:	02ddc703          	lbu	a4,45(s11)

000000fe <.LBB253>:
      MSW := Shift_Left (U32 (X (I)),     24) or
      fe:	0962                	slli	s2,s2,0x18
             Shift_Left (U32 (X (I + 1)), 16) or
     100:	04c2                	slli	s1,s1,0x10

00000102 <.LBB254>:
             Shift_Left (U32 (X (I + 5)), 16) or
     102:	d0ba                	sw	a4,96(sp)

00000104 <.LBB255>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     104:	030dc703          	lbu	a4,48(s11)

00000108 <.LBB273>:
     108:	009964b3          	or	s1,s2,s1

0000010c <.LBB274>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     10c:	0a62                	slli	s4,s4,0x18

0000010e <.LBB275>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     10e:	d6ba                	sw	a4,108(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     110:	031dc703          	lbu	a4,49(s11)

00000114 <.LBB276>:
             Shift_Left (U32 (X (I + 5)), 16) or
     114:	09c2                	slli	s3,s3,0x10
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     116:	013a69b3          	or	s3,s4,s3

0000011a <.LBB277>:
             Shift_Left (U32 (X (I + 1)), 16) or
     11a:	d8ba                	sw	a4,112(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     11c:	034dc703          	lbu	a4,52(s11)

00000120 <.LBB278>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     120:	0662                	slli	a2,a2,0x18
             Shift_Left (U32 (X (I + 1)), 16) or
     122:	06c2                	slli	a3,a3,0x10

00000124 <.LBB279>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     124:	deba                	sw	a4,124(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     126:	035dc703          	lbu	a4,53(s11)

0000012a <.LBB280>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     12a:	8ed1                	or	a3,a3,a2

0000012c <.LBB281>:
     12c:	0e62                	slli	t3,t3,0x18

0000012e <.LBB282>:
             Shift_Left (U32 (X (I + 5)), 16) or
     12e:	c13a                	sw	a4,128(sp)

00000130 <.LBB283>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     130:	038dc703          	lbu	a4,56(s11)

00000134 <.LBB302>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     134:	08e2                	slli	a7,a7,0x18
             Shift_Left (U32 (X (I + 1)), 16) or
     136:	0342                	slli	t1,t1,0x10

00000138 <.LBB303>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     138:	c73a                	sw	a4,140(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     13a:	039dc703          	lbu	a4,57(s11)

0000013e <.LBB304>:
             Shift_Left (U32 (X (I + 5)), 16) or
     13e:	0842                	slli	a6,a6,0x10
      MSW := Shift_Left (U32 (X (I)),     24) or
     140:	006e6333          	or	t1,t3,t1

00000144 <.LBB305>:
             Shift_Left (U32 (X (I + 1)), 16) or
     144:	c93a                	sw	a4,144(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     146:	03cdc703          	lbu	a4,60(s11)

0000014a <.LBB306>:
     14a:	0108e833          	or	a6,a7,a6

0000014e <.LBB307>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     14e:	0b62                	slli	s6,s6,0x18

00000150 <.LBB308>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     150:	cf3a                	sw	a4,156(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     152:	03ddc703          	lbu	a4,61(s11)

00000156 <.LBB309>:
             Shift_Left (U32 (X (I + 1)), 16) or
     156:	0ac2                	slli	s5,s5,0x10

00000158 <.LBB310>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     158:	0c62                	slli	s8,s8,0x18

0000015a <.LBB311>:
             Shift_Left (U32 (X (I + 5)), 16) or
     15a:	d13a                	sw	a4,160(sp)

0000015c <.LBB312>:
             Shift_Left (U32 (X (I + 6)), 8) or
     15c:	01edc703          	lbu	a4,30(s11)

00000160 <.LBB313>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     160:	015b6ab3          	or	s5,s6,s5

00000164 <.LBB314>:
             Shift_Left (U32 (X (I + 5)), 16) or
     164:	0bc2                	slli	s7,s7,0x10

00000166 <.LBB315>:
             Shift_Left (U32 (X (I + 6)), 8) or
     166:	c0ba                	sw	a4,64(sp)

00000168 <.LBB316>:
             Shift_Left (U32 (X (I + 2)), 8) or
     168:	023dc703          	lbu	a4,35(s11)

0000016c <.LBB317>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     16c:	017c6bb3          	or	s7,s8,s7

00000170 <.LBB318>:
     170:	0f62                	slli	t5,t5,0x18

00000172 <.LBB319>:
             Shift_Left (U32 (X (I + 2)), 8) or
     172:	c2ba                	sw	a4,68(sp)
     174:	022dc703          	lbu	a4,34(s11)

00000178 <.LBB320>:
             Shift_Left (U32 (X (I + 5)), 16) or
     178:	0ec2                	slli	t4,t4,0x10
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     17a:	01df6eb3          	or	t4,t5,t4

0000017e <.LBB321>:
             Shift_Left (U32 (X (I + 2)), 8) or
     17e:	c4ba                	sw	a4,72(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
     180:	027dc703          	lbu	a4,39(s11)

00000184 <.LBB322>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     184:	0462                	slli	s0,s0,0x18
             Shift_Left (U32 (X (I + 5)), 16) or
     186:	03c2                	slli	t2,t2,0x10

00000188 <.LBB323>:
             Shift_Left (U32 (X (I + 6)), 8) or
     188:	c6ba                	sw	a4,76(sp)
     18a:	026dc703          	lbu	a4,38(s11)

0000018e <.LBB324>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     18e:	007463b3          	or	t2,s0,t2

00000192 <.LBB325>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     192:	0d62                	slli	s10,s10,0x18

00000194 <.LBB326>:
             Shift_Left (U32 (X (I + 6)), 8) or
     194:	c8ba                	sw	a4,80(sp)

00000196 <.LBB327>:
             Shift_Left (U32 (X (I + 2)), 8) or
     196:	02bdc703          	lbu	a4,43(s11)

0000019a <.LBB328>:
             Shift_Left (U32 (X (I + 1)), 16) or
     19a:	0cc2                	slli	s9,s9,0x10
      MSW := Shift_Left (U32 (X (I)),     24) or
     19c:	019d6cb3          	or	s9,s10,s9

000001a0 <.LBB329>:
             Shift_Left (U32 (X (I + 2)), 8) or
     1a0:	caba                	sw	a4,84(sp)
     1a2:	02adc703          	lbu	a4,42(s11)

000001a6 <.LBB330>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     1a6:	02e2                	slli	t0,t0,0x18
             Shift_Left (U32 (X (I + 1)), 16) or
     1a8:	0fc2                	slli	t6,t6,0x10

000001aa <.LBB331>:
             Shift_Left (U32 (X (I + 2)), 8) or
     1aa:	ccba                	sw	a4,88(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
     1ac:	02fdc703          	lbu	a4,47(s11)

000001b0 <.LBB332>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     1b0:	01f2efb3          	or	t6,t0,t6

000001b4 <.LBB333>:
             Shift_Left (U32 (X (I + 6)), 8) or
     1b4:	d2ba                	sw	a4,100(sp)
     1b6:	02edc703          	lbu	a4,46(s11)
     1ba:	d4ba                	sw	a4,104(sp)

000001bc <.LBB334>:
             Shift_Left (U32 (X (I + 2)), 8) or
     1bc:	033dc703          	lbu	a4,51(s11)
     1c0:	daba                	sw	a4,116(sp)
     1c2:	032dc703          	lbu	a4,50(s11)
     1c6:	dcba                	sw	a4,120(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
     1c8:	037dc703          	lbu	a4,55(s11)
     1cc:	c33a                	sw	a4,132(sp)
     1ce:	036dc703          	lbu	a4,54(s11)
     1d2:	c53a                	sw	a4,136(sp)

000001d4 <.LBB335>:
             Shift_Left (U32 (X (I + 2)), 8) or
     1d4:	03bdc703          	lbu	a4,59(s11)
     1d8:	cb3a                	sw	a4,148(sp)
     1da:	03adc703          	lbu	a4,58(s11)
     1de:	cd3a                	sw	a4,152(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
     1e0:	03fdc703          	lbu	a4,63(s11)
     1e4:	03edcd83          	lbu	s11,62(s11)

000001e8 <.LVL4>:
     1e8:	d33a                	sw	a4,164(sp)

000001ea <.LBB336>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     1ea:	4776                	lw	a4,92(sp)

000001ec <.LBB337>:
             Shift_Left (U32 (X (I + 6)), 8) or
     1ec:	0da2                	slli	s11,s11,0x8

000001ee <.LBB338>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     1ee:	0762                	slli	a4,a4,0x18
     1f0:	ceba                	sw	a4,92(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     1f2:	5706                	lw	a4,96(sp)
     1f4:	0742                	slli	a4,a4,0x10
     1f6:	d0ba                	sw	a4,96(sp)

000001f8 <.LBB339>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     1f8:	5736                	lw	a4,108(sp)
     1fa:	0762                	slli	a4,a4,0x18
     1fc:	d6ba                	sw	a4,108(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     1fe:	5746                	lw	a4,112(sp)
     200:	0742                	slli	a4,a4,0x10
     202:	d8ba                	sw	a4,112(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     204:	5776                	lw	a4,124(sp)
     206:	0762                	slli	a4,a4,0x18
     208:	deba                	sw	a4,124(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     20a:	470a                	lw	a4,128(sp)

0000020c <.LBB340>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     20c:	5906                	lw	s2,96(sp)

0000020e <.LBB341>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     20e:	5a46                	lw	s4,112(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     210:	0742                	slli	a4,a4,0x10
     212:	c13a                	sw	a4,128(sp)

00000214 <.LBB342>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     214:	473a                	lw	a4,140(sp)

00000216 <.LBB343>:
     216:	4e52                	lw	t3,20(sp)

00000218 <.LBB344>:
     218:	4412                	lw	s0,4(sp)

0000021a <.LBB345>:
     21a:	0762                	slli	a4,a4,0x18
     21c:	c73a                	sw	a4,140(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     21e:	474a                	lw	a4,144(sp)

00000220 <.LBB346>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     220:	01caeab3          	or	s5,s5,t3
             Shift_Left (U32 (X (I + 2)), 8) or
     224:	4e62                	lw	t3,24(sp)

00000226 <.LBB347>:
             Shift_Left (U32 (X (I + 1)), 16) or
     226:	0742                	slli	a4,a4,0x10
     228:	c93a                	sw	a4,144(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     22a:	477a                	lw	a4,156(sp)

0000022c <.LBB348>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     22c:	008cecb3          	or	s9,s9,s0
             Shift_Left (U32 (X (I + 2)), 8) or
     230:	4422                	lw	s0,8(sp)

00000232 <.LBB349>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     232:	0762                	slli	a4,a4,0x18
     234:	cf3a                	sw	a4,156(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     236:	570a                	lw	a4,160(sp)

00000238 <.LBB350>:
             Shift_Left (U32 (X (I + 2)), 8) or
     238:	00841293          	slli	t0,s0,0x8
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     23c:	4432                	lw	s0,12(sp)

0000023e <.LBB351>:
             Shift_Left (U32 (X (I + 5)), 16) or
     23e:	0742                	slli	a4,a4,0x10
     240:	d13a                	sw	a4,160(sp)

00000242 <.LBB352>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     242:	4776                	lw	a4,92(sp)

00000244 <.LBB353>:
     244:	008bebb3          	or	s7,s7,s0
             Shift_Left (U32 (X (I + 6)), 8) or
     248:	4442                	lw	s0,16(sp)

0000024a <.LBB354>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     24a:	01276733          	or	a4,a4,s2

0000024e <.LBB355>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     24e:	5936                	lw	s2,108(sp)

00000250 <.LBB356>:
             Shift_Left (U32 (X (I + 6)), 8) or
     250:	0422                	slli	s0,s0,0x8

00000252 <.LBB357>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     252:	01496633          	or	a2,s2,s4
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     256:	5976                	lw	s2,124(sp)
     258:	4a0a                	lw	s4,128(sp)
     25a:	014968b3          	or	a7,s2,s4

0000025e <.LBB358>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     25e:	493a                	lw	s2,140(sp)
     260:	4a4a                	lw	s4,144(sp)
     262:	01496c33          	or	s8,s2,s4
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     266:	497a                	lw	s2,156(sp)
     268:	5a0a                	lw	s4,160(sp)
     26a:	01496f33          	or	t5,s2,s4

0000026e <.LBB359>:
             Shift_Left (U32 (X (I + 2)), 8) or
     26e:	008e1913          	slli	s2,t3,0x8
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     272:	4e72                	lw	t3,28(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     274:	c24a                	sw	s2,4(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     276:	01c9e9b3          	or	s3,s3,t3
             Shift_Left (U32 (X (I + 6)), 8) or
     27a:	5e02                	lw	t3,32(sp)
     27c:	008e1a13          	slli	s4,t3,0x8

00000280 <.LBB360>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     280:	5e12                	lw	t3,36(sp)
     282:	01c4eb33          	or	s6,s1,t3
             Shift_Left (U32 (X (I + 2)), 8) or
     286:	54a2                	lw	s1,40(sp)
     288:	00849e13          	slli	t3,s1,0x8
     28c:	c472                	sw	t3,8(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     28e:	54b2                	lw	s1,44(sp)
     290:	0093e3b3          	or	t2,t2,s1
             Shift_Left (U32 (X (I + 6)), 8) or
     294:	54c2                	lw	s1,48(sp)
     296:	00849d13          	slli	s10,s1,0x8

0000029a <.LBB361>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     29a:	54d2                	lw	s1,52(sp)
     29c:	009fefb3          	or	t6,t6,s1
             Shift_Left (U32 (X (I + 2)), 8) or
     2a0:	54e2                	lw	s1,56(sp)
      MSW := Shift_Left (U32 (X (I)),     24) or
     2a2:	c67e                	sw	t6,12(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     2a4:	00849e13          	slli	t3,s1,0x8
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     2a8:	54f2                	lw	s1,60(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     2aa:	c872                	sw	t3,16(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     2ac:	009eeeb3          	or	t4,t4,s1
             Shift_Left (U32 (X (I + 6)), 8) or
     2b0:	4486                	lw	s1,64(sp)
     2b2:	00849f93          	slli	t6,s1,0x8

000002b6 <.LBB362>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     2b6:	4496                	lw	s1,68(sp)

000002b8 <.LBB363>:
             Shift_Left (U32 (X (I + 6)), 8) or
     2b8:	ca7e                	sw	t6,20(sp)

000002ba <.LBB364>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     2ba:	00936333          	or	t1,t1,s1
             Shift_Left (U32 (X (I + 2)), 8) or
     2be:	44a6                	lw	s1,72(sp)
     2c0:	00849913          	slli	s2,s1,0x8
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     2c4:	44b6                	lw	s1,76(sp)
      MSW := Shift_Left (U32 (X (I)),     24) or
     2c6:	01236933          	or	s2,t1,s2
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     2ca:	00986833          	or	a6,a6,s1
             Shift_Left (U32 (X (I + 6)), 8) or
     2ce:	44c6                	lw	s1,80(sp)
     2d0:	04a2                	slli	s1,s1,0x8
     2d2:	cc26                	sw	s1,24(sp)

000002d4 <.LBB365>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     2d4:	44d6                	lw	s1,84(sp)
     2d6:	8cd5                	or	s1,s1,a3
             Shift_Left (U32 (X (I + 2)), 8) or
     2d8:	46e6                	lw	a3,88(sp)
      MSW := Shift_Left (U32 (X (I)),     24) or
     2da:	ce26                	sw	s1,28(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     2dc:	00869493          	slli	s1,a3,0x8
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     2e0:	5696                	lw	a3,100(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     2e2:	d226                	sw	s1,36(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     2e4:	00d76e33          	or	t3,a4,a3
             Shift_Left (U32 (X (I + 6)), 8) or
     2e8:	5726                	lw	a4,104(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     2ea:	d472                	sw	t3,40(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
     2ec:	00871e13          	slli	t3,a4,0x8

000002f0 <.LBB366>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     2f0:	5756                	lw	a4,116(sp)
     2f2:	8e59                	or	a2,a2,a4
             Shift_Left (U32 (X (I + 2)), 8) or
     2f4:	5766                	lw	a4,120(sp)
     2f6:	00871f93          	slli	t6,a4,0x8
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     2fa:	471a                	lw	a4,132(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     2fc:	d67e                	sw	t6,44(sp)

000002fe <.LBB367>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     2fe:	005cefb3          	or	t6,s9,t0

00000302 <.LBB368>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     302:	00e8e8b3          	or	a7,a7,a4
             Shift_Left (U32 (X (I + 6)), 8) or
     306:	472a                	lw	a4,136(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     308:	d846                	sw	a7,48(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
     30a:	00871893          	slli	a7,a4,0x8

0000030e <.LBB369>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     30e:	475a                	lw	a4,148(sp)

00000310 <.LBB370>:
             Shift_Left (U32 (X (I + 6)), 8) or
     310:	da46                	sw	a7,52(sp)

00000312 <.LBB371>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     312:	0149e8b3          	or	a7,s3,s4

00000316 <.LBB372>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     316:	00ec6c33          	or	s8,s8,a4
             Shift_Left (U32 (X (I + 2)), 8) or
     31a:	476a                	lw	a4,152(sp)
      MSW := Shift_Left (U32 (X (I)),     24) or
     31c:	dc62                	sw	s8,56(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     31e:	00871c13          	slli	s8,a4,0x8
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     322:	571a                	lw	a4,164(sp)
     324:	00ef6733          	or	a4,t5,a4
     328:	de3a                	sw	a4,60(sp)

0000032a <.LBB373>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     32a:	4692                	lw	a3,4(sp)

0000032c <.LBB374>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     32c:	008be733          	or	a4,s7,s0

00000330 <.LBB375>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     330:	42c2                	lw	t0,16(sp)

00000332 <.LBB376>:
     332:	00dae4b3          	or	s1,s5,a3

00000336 <.LBB377>:
     336:	46a2                	lw	a3,8(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     338:	01a3ef33          	or	t5,t2,s10

0000033c <.LBB378>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     33c:	5312                	lw	t1,36(sp)

0000033e <.LBB379>:
     33e:	00db6433          	or	s0,s6,a3

00000342 <.LBB380>:
     342:	46b2                	lw	a3,12(sp)

00000344 <.LBB381>:
     344:	d022                	sw	s0,32(sp)

00000346 <.LBE381>:
            3 => DL64 (X, 24),
            4 => DL64 (X, 32),
            5 => DL64 (X, 40),
            6 => DL64 (X, 48),
            7 => DL64 (X, 56));
      Z := A;
     346:	24e12023          	sw	a4,576(sp)

0000034a <.LBB382>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     34a:	0056ed33          	or	s10,a3,t0
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     34e:	46d2                	lw	a3,20(sp)

00000350 <.LBE382>:
      Z := A;
     350:	25f12223          	sw	t6,580(sp)
     354:	25112423          	sw	a7,584(sp)

00000358 <.LBB383>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     358:	00deeeb3          	or	t4,t4,a3

0000035c <.LBB384>:
     35c:	46e2                	lw	a3,24(sp)

0000035e <.LBE384>:
      Z := A;
     35e:	24912623          	sw	s1,588(sp)
     362:	25e12823          	sw	t5,592(sp)

00000366 <.LBB385>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     366:	00d866b3          	or	a3,a6,a3

0000036a <.LBB386>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     36a:	4872                	lw	a6,28(sp)

0000036c <.LBE386>:
      Z := A;
     36c:	24812a23          	sw	s0,596(sp)
     370:	25d12c23          	sw	t4,600(sp)

00000374 <.LBB387>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     374:	00686833          	or	a6,a6,t1
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     378:	5322                	lw	t1,40(sp)
      MSW := Shift_Left (U32 (X (I)),     24) or
     37a:	d242                	sw	a6,36(sp)

0000037c <.LBE387>:
      Z := A;
     37c:	25a12e23          	sw	s10,604(sp)

00000380 <.LBB388>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     380:	01c36e33          	or	t3,t1,t3

00000384 <.LBB389>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     384:	5332                	lw	t1,44(sp)

00000386 <.LBE389>:
      Z := A;
     386:	26d12023          	sw	a3,608(sp)
     38a:	27212223          	sw	s2,612(sp)

0000038e <.LBB390>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     38e:	00666bb3          	or	s7,a2,t1
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     392:	5352                	lw	t1,52(sp)
     394:	5642                	lw	a2,48(sp)

00000396 <.LBE390>:
      Z := A;
     396:	27c12423          	sw	t3,616(sp)
     39a:	27012623          	sw	a6,620(sp)

0000039e <.LBB391>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     39e:	00666633          	or	a2,a2,t1

000003a2 <.LBB392>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     3a2:	5362                	lw	t1,56(sp)

000003a4 <.LBE392>:
      Z := A;
     3a4:	26c12823          	sw	a2,624(sp)
     3a8:	27712a23          	sw	s7,628(sp)

000003ac <.LBB393>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     3ac:	01836c33          	or	s8,t1,s8
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     3b0:	5372                	lw	t1,60(sp)

000003b2 <.LBE393>:
      Z := A;
     3b2:	27812e23          	sw	s8,636(sp)

000003b6 <.LBB394>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     3b6:	01b36333          	or	t1,t1,s11

000003ba <.LBE394>:
      Z := A;
     3ba:	26612c23          	sw	t1,632(sp)

000003be <.LBB395>:
      return Shift_Left (U64 (MSW), 32) or U64 (LSW);
     3be:	c246                	sw	a7,4(sp)
     3c0:	c426                	sw	s1,8(sp)

000003c2 <.LBB396>:
     3c2:	d6fa                	sw	t5,108(sp)
     3c4:	ce22                	sw	s0,28(sp)

000003c6 <.LBB397>:
     3c6:	c672                	sw	t3,12(sp)
     3c8:	c842                	sw	a6,16(sp)

000003ca <.LBB398>:
     3ca:	ca32                	sw	a2,20(sp)
     3cc:	cc5e                	sw	s7,24(sp)

000003ce <.LBE398>:

      LN := I64 (M'Length);
     3ce:	68f548e3          	blt	a0,a5,125e <.L4>
     3d2:	41f7d813          	srai	a6,a5,0x1f
     3d6:	82ae                	mv	t0,a1

000003d8 <.LVL10>:
     3d8:	40f507b3          	sub	a5,a0,a5
     3dc:	41f55593          	srai	a1,a0,0x1f
     3e0:	410585b3          	sub	a1,a1,a6
     3e4:	00f53533          	sltu	a0,a0,a5
     3e8:	8d89                	sub	a1,a1,a0
     3ea:	8cba                	mv	s9,a4
     3ec:	8dfe                	mv	s11,t6
     3ee:	8af6                	mv	s5,t4
     3f0:	8b6a                	mv	s6,s10
     3f2:	8a36                	mv	s4,a3
     3f4:	89ca                	mv	s3,s2
     3f6:	839a                	mv	t2,t1
     3f8:	8462                	mv	s0,s8

000003fa <.LVL12>:
      CB := M'First; -- Current block base offset

      while (LN >= 128) loop
     3fa:	64b05de3          	blez	a1,1254 <.L18>

000003fe <.L13>:
     3fe:	f8178793          	addi	a5,a5,-127
     402:	f807f793          	andi	a5,a5,-128
     406:	9796                	add	a5,a5,t0
     408:	22f12223          	sw	a5,548(sp)
     40c:	5792                	lw	a5,36(sp)
     40e:	d0ea                	sw	s10,96(sp)
     410:	5d36                	lw	s10,108(sp)

00000412 <.LVL14>:
     412:	c8be                	sw	a5,80(sp)
     414:	5782                	lw	a5,32(sp)
     416:	ccde                	sw	s7,88(sp)
     418:	d25a                	sw	s6,36(sp)
     41a:	dc3e                	sw	a5,56(sp)
     41c:	000007b7          	lui	a5,0x0
     420:	00078793          	mv	a5,a5
     424:	d416                	sw	t0,40(sp)
     426:	cab2                	sw	a2,84(sp)
     428:	d636                	sw	a3,44(sp)
     42a:	d84a                	sw	s2,48(sp)
     42c:	c2ba                	sw	a4,68(sp)
     42e:	c4fe                	sw	t6,72(sp)
     430:	de46                	sw	a7,60(sp)
     432:	c0a6                	sw	s1,64(sp)
     434:	d29a                	sw	t1,100(sp)
     436:	d4e2                	sw	s8,104(sp)
     438:	c6f2                	sw	t3,76(sp)
     43a:	cef6                	sw	t4,92(sp)
     43c:	da7a                	sw	t5,52(sp)
     43e:	22f12423          	sw	a5,552(sp)
     442:	8b56                	mv	s6,s5

00000444 <.LVL15>:
     444:	881e                	mv	a6,t2
     446:	8b96                	mv	s7,t0

00000448 <.L12>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     448:	000bc783          	lbu	a5,0(s7)
             Shift_Left (U32 (X (I + 2)), 8) or
     44c:	003bc683          	lbu	a3,3(s7)
     450:	002bc603          	lbu	a2,2(s7)
             Shift_Left (U32 (X (I + 6)), 8) or
     454:	007bc583          	lbu	a1,7(s7)
     458:	006bc503          	lbu	a0,6(s7)

0000045c <.LBB412>:
             Shift_Left (U32 (X (I + 2)), 8) or
     45c:	00bbc483          	lbu	s1,11(s7)
     460:	00abc883          	lbu	a7,10(s7)
             Shift_Left (U32 (X (I + 6)), 8) or
     464:	00fbce03          	lbu	t3,15(s7)
     468:	00ebce83          	lbu	t4,14(s7)

0000046c <.LBB426>:
             Shift_Left (U32 (X (I + 2)), 8) or
     46c:	013bcf03          	lbu	t5,19(s7)
     470:	012bcf83          	lbu	t6,18(s7)

00000474 <.LBB441>:
             Shift_Left (U32 (X (I + 5)), 16) or
     474:	00dbc303          	lbu	t1,13(s7)

00000478 <.LBB442>:
             Shift_Left (U32 (X (I + 1)), 16) or
     478:	001bc703          	lbu	a4,1(s7)
      MSW := Shift_Left (U32 (X (I)),     24) or
     47c:	d03e                	sw	a5,32(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     47e:	d6b6                	sw	a3,108(sp)
     480:	d8b2                	sw	a2,112(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     482:	004bc683          	lbu	a3,4(s7)
             Shift_Left (U32 (X (I + 5)), 16) or
     486:	005bc603          	lbu	a2,5(s7)
             Shift_Left (U32 (X (I + 6)), 8) or
     48a:	daae                	sw	a1,116(sp)
     48c:	dcaa                	sw	a0,120(sp)

0000048e <.LBB443>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     48e:	008bc583          	lbu	a1,8(s7)
             Shift_Left (U32 (X (I + 1)), 16) or
     492:	009bc503          	lbu	a0,9(s7)
             Shift_Left (U32 (X (I + 2)), 8) or
     496:	dea6                	sw	s1,124(sp)
     498:	c146                	sw	a7,128(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
     49a:	c372                	sw	t3,132(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     49c:	00cbc883          	lbu	a7,12(s7)

000004a0 <.LBB444>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     4a0:	010bce03          	lbu	t3,16(s7)

000004a4 <.LBB445>:
             Shift_Left (U32 (X (I + 6)), 8) or
     4a4:	c576                	sw	t4,136(sp)

000004a6 <.LBB446>:
             Shift_Left (U32 (X (I + 2)), 8) or
     4a6:	c77a                	sw	t5,140(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     4a8:	011bce83          	lbu	t4,17(s7)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     4ac:	014bcf03          	lbu	t5,20(s7)
             Shift_Left (U32 (X (I + 2)), 8) or
     4b0:	c97e                	sw	t6,144(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     4b2:	015bcf83          	lbu	t6,21(s7)

000004b6 <.LBB447>:
             Shift_Left (U32 (X (I + 6)), 8) or
     4b6:	01fbcc03          	lbu	s8,31(s7)
             Shift_Left (U32 (X (I + 2)), 8) or
     4ba:	01abca83          	lbu	s5,26(s7)

000004be <.LBB463>:
             Shift_Left (U32 (X (I + 6)), 8) or
     4be:	017bc283          	lbu	t0,23(s7)

000004c2 <.LBB464>:
     4c2:	d362                	sw	s8,164(sp)

000004c4 <.LBB465>:
             Shift_Left (U32 (X (I + 1)), 16) or
     4c4:	021bcc03          	lbu	s8,33(s7)

000004c8 <.LBB483>:
             Shift_Left (U32 (X (I + 6)), 8) or
     4c8:	016bc383          	lbu	t2,22(s7)

000004cc <.LBB484>:
             Shift_Left (U32 (X (I + 2)), 8) or
     4cc:	01bbc903          	lbu	s2,27(s7)

000004d0 <.LBB485>:
             Shift_Left (U32 (X (I + 1)), 16) or
     4d0:	d762                	sw	s8,172(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     4d2:	023bcc03          	lbu	s8,35(s7)

000004d6 <.LBB486>:
     4d6:	d156                	sw	s5,160(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
     4d8:	01ebca83          	lbu	s5,30(s7)

000004dc <.LBB487>:
             Shift_Left (U32 (X (I + 2)), 8) or
     4dc:	d962                	sw	s8,176(sp)
     4de:	022bcc03          	lbu	s8,34(s7)

000004e2 <.LBB488>:
             Shift_Left (U32 (X (I + 6)), 8) or
     4e2:	cb16                	sw	t0,148(sp)
     4e4:	cd1e                	sw	t2,152(sp)

000004e6 <.LBB489>:
             Shift_Left (U32 (X (I + 2)), 8) or
     4e6:	db62                	sw	s8,180(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     4e8:	8c5e                	mv	s8,s7
             Shift_Left (U32 (X (I + 5)), 16) or
     4ea:	025c4783          	lbu	a5,37(s8)

000004ee <.LBB490>:
             Shift_Left (U32 (X (I + 2)), 8) or
     4ee:	cf4a                	sw	s2,156(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
     4f0:	d556                	sw	s5,168(sp)

000004f2 <.LBB491>:
             Shift_Left (U32 (X (I + 5)), 16) or
     4f2:	dd3e                	sw	a5,184(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
     4f4:	87e2                	mv	a5,s8
     4f6:	027c4c03          	lbu	s8,39(s8)

000004fa <.LBB492>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     4fa:	018bc283          	lbu	t0,24(s7)
             Shift_Left (U32 (X (I + 1)), 16) or
     4fe:	019bc383          	lbu	t2,25(s7)

00000502 <.LBB493>:
             Shift_Left (U32 (X (I + 6)), 8) or
     502:	df62                	sw	s8,188(sp)
     504:	0267cc03          	lbu	s8,38(a5) # 26 <.LBE159+0x6>

00000508 <.LBB494>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     508:	01cbc483          	lbu	s1,28(s7)
             Shift_Left (U32 (X (I + 5)), 16) or
     50c:	01dbc903          	lbu	s2,29(s7)

00000510 <.LBB495>:
             Shift_Left (U32 (X (I + 6)), 8) or
     510:	c1e2                	sw	s8,192(sp)

00000512 <.LBB496>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     512:	0287cc03          	lbu	s8,40(a5)

00000516 <.LBB515>:
     516:	020bca83          	lbu	s5,32(s7)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     51a:	024bcb83          	lbu	s7,36(s7)

0000051e <.LBB516>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     51e:	c3e2                	sw	s8,196(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     520:	0297cc03          	lbu	s8,41(a5)

00000524 <.LBB517>:
     524:	0742                	slli	a4,a4,0x10

00000526 <.LBB518>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     526:	08e2                	slli	a7,a7,0x18

00000528 <.LBB519>:
             Shift_Left (U32 (X (I + 1)), 16) or
     528:	c5e2                	sw	s8,200(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     52a:	02b7cc03          	lbu	s8,43(a5)

0000052e <.LBB520>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     52e:	0ae2                	slli	s5,s5,0x18

00000530 <.LBB521>:
             Shift_Left (U32 (X (I + 5)), 16) or
     530:	0642                	slli	a2,a2,0x10

00000532 <.LBB522>:
             Shift_Left (U32 (X (I + 2)), 8) or
     532:	c7e2                	sw	s8,204(sp)
     534:	02a7cc03          	lbu	s8,42(a5)

00000538 <.LBB523>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     538:	06e2                	slli	a3,a3,0x18
     53a:	8ed1                	or	a3,a3,a2

0000053c <.LBB524>:
             Shift_Left (U32 (X (I + 2)), 8) or
     53c:	c9e2                	sw	s8,208(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     53e:	02c7cc03          	lbu	s8,44(a5)

00000542 <.LBB525>:
             Shift_Left (U32 (X (I + 1)), 16) or
     542:	0542                	slli	a0,a0,0x10
      MSW := Shift_Left (U32 (X (I)),     24) or
     544:	05e2                	slli	a1,a1,0x18

00000546 <.LBB526>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     546:	cbe2                	sw	s8,212(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     548:	02d7cc03          	lbu	s8,45(a5)

0000054c <.LBB527>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     54c:	8dc9                	or	a1,a1,a0

0000054e <.LBB528>:
             Shift_Left (U32 (X (I + 1)), 16) or
     54e:	0ec2                	slli	t4,t4,0x10

00000550 <.LBB529>:
             Shift_Left (U32 (X (I + 5)), 16) or
     550:	cde2                	sw	s8,216(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
     552:	02f7cc03          	lbu	s8,47(a5)

00000556 <.LBB530>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     556:	0e62                	slli	t3,t3,0x18
     558:	01de6e33          	or	t3,t3,t4

0000055c <.LBB531>:
             Shift_Left (U32 (X (I + 6)), 8) or
     55c:	cfe2                	sw	s8,220(sp)
     55e:	02e7cc03          	lbu	s8,46(a5)

00000562 <.LBB532>:
             Shift_Left (U32 (X (I + 5)), 16) or
     562:	0fc2                	slli	t6,t6,0x10
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     564:	0f62                	slli	t5,t5,0x18

00000566 <.LBB533>:
             Shift_Left (U32 (X (I + 6)), 8) or
     566:	d1e2                	sw	s8,224(sp)

00000568 <.LBB534>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     568:	0307cc03          	lbu	s8,48(a5)

0000056c <.LBB549>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     56c:	01ff6f33          	or	t5,t5,t6

00000570 <.LBB550>:
             Shift_Left (U32 (X (I + 1)), 16) or
     570:	03c2                	slli	t2,t2,0x10

00000572 <.LBB551>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     572:	d3e2                	sw	s8,228(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     574:	0317cc03          	lbu	s8,49(a5)

00000578 <.LBB552>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     578:	02e2                	slli	t0,t0,0x18
     57a:	0072e2b3          	or	t0,t0,t2

0000057e <.LBB553>:
             Shift_Left (U32 (X (I + 1)), 16) or
     57e:	d5e2                	sw	s8,232(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     580:	0337cc03          	lbu	s8,51(a5)

00000584 <.LBB554>:
             Shift_Left (U32 (X (I + 5)), 16) or
     584:	0942                	slli	s2,s2,0x10
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     586:	04e2                	slli	s1,s1,0x18

00000588 <.LBB555>:
             Shift_Left (U32 (X (I + 2)), 8) or
     588:	d7e2                	sw	s8,236(sp)
     58a:	0327cc03          	lbu	s8,50(a5)

0000058e <.LBB556>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     58e:	0124e4b3          	or	s1,s1,s2

00000592 <.LBB557>:
     592:	0be2                	slli	s7,s7,0x18

00000594 <.LBB558>:
             Shift_Left (U32 (X (I + 2)), 8) or
     594:	d9e2                	sw	s8,240(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     596:	0347cc03          	lbu	s8,52(a5)
     59a:	dbe2                	sw	s8,244(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     59c:	0357cc03          	lbu	s8,53(a5)
     5a0:	dde2                	sw	s8,248(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
     5a2:	0377cc03          	lbu	s8,55(a5)
     5a6:	dfe2                	sw	s8,252(sp)
     5a8:	0367cc03          	lbu	s8,54(a5)
     5ac:	11812023          	sw	s8,256(sp)

000005b0 <.LBB559>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     5b0:	0387cc03          	lbu	s8,56(a5)
     5b4:	11812223          	sw	s8,260(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     5b8:	0397cc03          	lbu	s8,57(a5)
     5bc:	11812423          	sw	s8,264(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     5c0:	03b7cc03          	lbu	s8,59(a5)
     5c4:	11812623          	sw	s8,268(sp)
     5c8:	03a7cc03          	lbu	s8,58(a5)
     5cc:	11812823          	sw	s8,272(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     5d0:	03c7cc03          	lbu	s8,60(a5)
     5d4:	11812a23          	sw	s8,276(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     5d8:	03d7cc03          	lbu	s8,61(a5)
     5dc:	11812c23          	sw	s8,280(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
     5e0:	03f7cc03          	lbu	s8,63(a5)
     5e4:	11812e23          	sw	s8,284(sp)
     5e8:	03e7cc03          	lbu	s8,62(a5)
     5ec:	13812023          	sw	s8,288(sp)

000005f0 <.LBB569>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     5f0:	0407cc03          	lbu	s8,64(a5)
     5f4:	13812223          	sw	s8,292(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     5f8:	0417cc03          	lbu	s8,65(a5)
     5fc:	13812423          	sw	s8,296(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     600:	0437cc03          	lbu	s8,67(a5)
     604:	13812623          	sw	s8,300(sp)
     608:	0427cc03          	lbu	s8,66(a5)
     60c:	13812823          	sw	s8,304(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     610:	0447cc03          	lbu	s8,68(a5)
     614:	13812a23          	sw	s8,308(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     618:	0457cc03          	lbu	s8,69(a5)
     61c:	13812c23          	sw	s8,312(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
     620:	0477cc03          	lbu	s8,71(a5)
     624:	13812e23          	sw	s8,316(sp)
     628:	0467cc03          	lbu	s8,70(a5)
     62c:	15812023          	sw	s8,320(sp)

00000630 <.LBB578>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     630:	0487cc03          	lbu	s8,72(a5)
     634:	15812223          	sw	s8,324(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     638:	0497cc03          	lbu	s8,73(a5)
     63c:	15812423          	sw	s8,328(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     640:	04b7cc03          	lbu	s8,75(a5)
     644:	15812623          	sw	s8,332(sp)
     648:	04a7cc03          	lbu	s8,74(a5)
     64c:	15812823          	sw	s8,336(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     650:	04c7cc03          	lbu	s8,76(a5)
     654:	15812a23          	sw	s8,340(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     658:	04d7cc03          	lbu	s8,77(a5)
     65c:	15812c23          	sw	s8,344(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
     660:	04f7cc03          	lbu	s8,79(a5)
     664:	15812e23          	sw	s8,348(sp)
     668:	04e7cc03          	lbu	s8,78(a5)
     66c:	17812023          	sw	s8,352(sp)

00000670 <.LBB589>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     670:	0507cc03          	lbu	s8,80(a5)
     674:	17812223          	sw	s8,356(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     678:	0517cc03          	lbu	s8,81(a5)
     67c:	17812423          	sw	s8,360(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     680:	0537cc03          	lbu	s8,83(a5)
     684:	17812623          	sw	s8,364(sp)
     688:	0527cc03          	lbu	s8,82(a5)
     68c:	17812823          	sw	s8,368(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     690:	0547cc03          	lbu	s8,84(a5)
     694:	17812a23          	sw	s8,372(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     698:	0557cc03          	lbu	s8,85(a5)
     69c:	17812c23          	sw	s8,376(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
     6a0:	0577cc03          	lbu	s8,87(a5)
     6a4:	17812e23          	sw	s8,380(sp)
     6a8:	0567cc03          	lbu	s8,86(a5)
     6ac:	19812023          	sw	s8,384(sp)

000006b0 <.LBB600>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     6b0:	0587cc03          	lbu	s8,88(a5)
     6b4:	19812223          	sw	s8,388(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     6b8:	0597cc03          	lbu	s8,89(a5)
     6bc:	19812423          	sw	s8,392(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     6c0:	05b7cc03          	lbu	s8,91(a5)
     6c4:	19812623          	sw	s8,396(sp)
     6c8:	05a7cc03          	lbu	s8,90(a5)
     6cc:	19812823          	sw	s8,400(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     6d0:	05c7cc03          	lbu	s8,92(a5)
     6d4:	19812a23          	sw	s8,404(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     6d8:	05d7cc03          	lbu	s8,93(a5)
     6dc:	19812c23          	sw	s8,408(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
     6e0:	05f7cc03          	lbu	s8,95(a5)
     6e4:	19812e23          	sw	s8,412(sp)
     6e8:	05e7cc03          	lbu	s8,94(a5)
     6ec:	1b812023          	sw	s8,416(sp)

000006f0 <.LBB608>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     6f0:	0607cc03          	lbu	s8,96(a5)
     6f4:	1b812223          	sw	s8,420(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     6f8:	0617cc03          	lbu	s8,97(a5)
     6fc:	1b812423          	sw	s8,424(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     700:	0647cc03          	lbu	s8,100(a5)
     704:	1b812a23          	sw	s8,436(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     708:	0657cc03          	lbu	s8,101(a5)
     70c:	1b812c23          	sw	s8,440(sp)

00000710 <.LBB617>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     710:	0687cc03          	lbu	s8,104(a5)
     714:	1d812223          	sw	s8,452(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     718:	0697cc03          	lbu	s8,105(a5)
     71c:	1d812423          	sw	s8,456(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     720:	06c7cc03          	lbu	s8,108(a5)
     724:	1d812a23          	sw	s8,468(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     728:	06d7cc03          	lbu	s8,109(a5)
     72c:	1d812c23          	sw	s8,472(sp)

00000730 <.LBB626>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     730:	0707cc03          	lbu	s8,112(a5)
     734:	1f812223          	sw	s8,484(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     738:	0717cc03          	lbu	s8,113(a5)
     73c:	1f812423          	sw	s8,488(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     740:	0747cc03          	lbu	s8,116(a5)
     744:	1f812a23          	sw	s8,500(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     748:	0757cc03          	lbu	s8,117(a5)
     74c:	1f812c23          	sw	s8,504(sp)

00000750 <.LBB636>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     750:	0787cc03          	lbu	s8,120(a5)
     754:	21812223          	sw	s8,516(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     758:	0797cc03          	lbu	s8,121(a5)
     75c:	21812423          	sw	s8,520(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     760:	07c7cc03          	lbu	s8,124(a5)
     764:	21812a23          	sw	s8,532(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     768:	07d7cc03          	lbu	s8,125(a5)
     76c:	21812c23          	sw	s8,536(sp)

00000770 <.LBB649>:
             Shift_Left (U32 (X (I + 2)), 8) or
     770:	0637cc03          	lbu	s8,99(a5)
     774:	1b812623          	sw	s8,428(sp)
     778:	0627cc03          	lbu	s8,98(a5)
     77c:	1b812823          	sw	s8,432(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
     780:	0677cc03          	lbu	s8,103(a5)
     784:	1b812e23          	sw	s8,444(sp)
     788:	0667cc03          	lbu	s8,102(a5)
     78c:	1d812023          	sw	s8,448(sp)

00000790 <.LBB650>:
             Shift_Left (U32 (X (I + 2)), 8) or
     790:	06b7cc03          	lbu	s8,107(a5)
     794:	1d812623          	sw	s8,460(sp)
     798:	06a7cc03          	lbu	s8,106(a5)
     79c:	1d812823          	sw	s8,464(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
     7a0:	06f7cc03          	lbu	s8,111(a5)
     7a4:	1d812e23          	sw	s8,476(sp)
     7a8:	06e7cc03          	lbu	s8,110(a5)
     7ac:	1f812023          	sw	s8,480(sp)

000007b0 <.LBB651>:
             Shift_Left (U32 (X (I + 2)), 8) or
     7b0:	0737cc03          	lbu	s8,115(a5)
     7b4:	1f812623          	sw	s8,492(sp)
     7b8:	0727cc03          	lbu	s8,114(a5)
     7bc:	1f812823          	sw	s8,496(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
     7c0:	0777cc03          	lbu	s8,119(a5)
     7c4:	1f812e23          	sw	s8,508(sp)
     7c8:	0767cc03          	lbu	s8,118(a5)
     7cc:	21812023          	sw	s8,512(sp)

000007d0 <.LBB652>:
             Shift_Left (U32 (X (I + 2)), 8) or
     7d0:	07b7cc03          	lbu	s8,123(a5)
     7d4:	21812623          	sw	s8,524(sp)
     7d8:	07a7cc03          	lbu	s8,122(a5)
     7dc:	21812823          	sw	s8,528(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
     7e0:	07f7cc03          	lbu	s8,127(a5)
     7e4:	21812e23          	sw	s8,540(sp)
     7e8:	07e7cc03          	lbu	s8,126(a5)

000007ec <.LBB653>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     7ec:	5782                	lw	a5,32(sp)

000007ee <.LBB654>:
             Shift_Left (U32 (X (I + 6)), 8) or
     7ee:	23812023          	sw	s8,544(sp)

000007f2 <.LBB655>:
             Shift_Left (U32 (X (I + 5)), 16) or
     7f2:	01031c13          	slli	s8,t1,0x10
     7f6:	d062                	sw	s8,32(sp)

000007f8 <.LBB656>:
             Shift_Left (U32 (X (I + 1)), 16) or
     7f8:	5c3a                	lw	s8,172(sp)

000007fa <.LBB657>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     7fa:	07e2                	slli	a5,a5,0x18
     7fc:	8fd9                	or	a5,a5,a4

000007fe <.LBB658>:
             Shift_Left (U32 (X (I + 1)), 16) or
     7fe:	010c1313          	slli	t1,s8,0x10
     802:	d71a                	sw	t1,172(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     804:	536a                	lw	t1,184(sp)
     806:	01031c13          	slli	s8,t1,0x10

0000080a <.LBB659>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     80a:	431e                	lw	t1,196(sp)

0000080c <.LBB660>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     80c:	018bebb3          	or	s7,s7,s8

00000810 <.LBB661>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     810:	0362                	slli	t1,t1,0x18
     812:	dd1a                	sw	t1,184(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     814:	432e                	lw	t1,200(sp)
     816:	0342                	slli	t1,t1,0x10
     818:	c39a                	sw	t1,196(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     81a:	435e                	lw	t1,212(sp)
     81c:	0362                	slli	t1,t1,0x18
     81e:	c59a                	sw	t1,200(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     820:	436e                	lw	t1,216(sp)
     822:	0342                	slli	t1,t1,0x10
     824:	cb9a                	sw	t1,212(sp)

00000826 <.LBB662>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     826:	531e                	lw	t1,228(sp)
     828:	0362                	slli	t1,t1,0x18
     82a:	cd9a                	sw	t1,216(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     82c:	532e                	lw	t1,232(sp)
     82e:	0342                	slli	t1,t1,0x10
     830:	d39a                	sw	t1,228(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     832:	535e                	lw	t1,244(sp)
     834:	0362                	slli	t1,t1,0x18
     836:	d59a                	sw	t1,232(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     838:	536e                	lw	t1,248(sp)
     83a:	0342                	slli	t1,t1,0x10
     83c:	db9a                	sw	t1,244(sp)

0000083e <.LBB663>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     83e:	10412303          	lw	t1,260(sp)
     842:	0362                	slli	t1,t1,0x18
     844:	dd9a                	sw	t1,248(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     846:	10812303          	lw	t1,264(sp)
     84a:	0342                	slli	t1,t1,0x10
     84c:	10612223          	sw	t1,260(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     850:	11412303          	lw	t1,276(sp)
     854:	0362                	slli	t1,t1,0x18
     856:	10612423          	sw	t1,264(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     85a:	11812303          	lw	t1,280(sp)
     85e:	0342                	slli	t1,t1,0x10
     860:	10612a23          	sw	t1,276(sp)

00000864 <.LBB664>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     864:	12412303          	lw	t1,292(sp)
     868:	0362                	slli	t1,t1,0x18
     86a:	10612c23          	sw	t1,280(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     86e:	12812303          	lw	t1,296(sp)
     872:	0342                	slli	t1,t1,0x10
     874:	12612223          	sw	t1,292(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     878:	13412303          	lw	t1,308(sp)
     87c:	0362                	slli	t1,t1,0x18
     87e:	12612423          	sw	t1,296(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     882:	13812303          	lw	t1,312(sp)
     886:	0342                	slli	t1,t1,0x10
     888:	12612a23          	sw	t1,308(sp)

0000088c <.LBB665>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     88c:	14412303          	lw	t1,324(sp)
     890:	0362                	slli	t1,t1,0x18
     892:	12612c23          	sw	t1,312(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     896:	14812303          	lw	t1,328(sp)
     89a:	0342                	slli	t1,t1,0x10
     89c:	14612223          	sw	t1,324(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     8a0:	15412303          	lw	t1,340(sp)
     8a4:	0362                	slli	t1,t1,0x18
     8a6:	14612423          	sw	t1,328(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     8aa:	15812303          	lw	t1,344(sp)
     8ae:	0342                	slli	t1,t1,0x10
     8b0:	14612a23          	sw	t1,340(sp)

000008b4 <.LBB666>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     8b4:	16412303          	lw	t1,356(sp)
     8b8:	0362                	slli	t1,t1,0x18
     8ba:	14612c23          	sw	t1,344(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     8be:	16812303          	lw	t1,360(sp)
     8c2:	0342                	slli	t1,t1,0x10
     8c4:	16612223          	sw	t1,356(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     8c8:	17412303          	lw	t1,372(sp)
     8cc:	0362                	slli	t1,t1,0x18
     8ce:	16612423          	sw	t1,360(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     8d2:	17812303          	lw	t1,376(sp)
     8d6:	0342                	slli	t1,t1,0x10
     8d8:	16612a23          	sw	t1,372(sp)

000008dc <.LBB667>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     8dc:	18412303          	lw	t1,388(sp)
     8e0:	0362                	slli	t1,t1,0x18
     8e2:	16612c23          	sw	t1,376(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     8e6:	18812303          	lw	t1,392(sp)
     8ea:	0342                	slli	t1,t1,0x10
     8ec:	18612223          	sw	t1,388(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     8f0:	19412303          	lw	t1,404(sp)
     8f4:	0362                	slli	t1,t1,0x18
     8f6:	18612423          	sw	t1,392(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     8fa:	19812303          	lw	t1,408(sp)
     8fe:	0342                	slli	t1,t1,0x10
     900:	18612a23          	sw	t1,404(sp)

00000904 <.LBB668>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     904:	1a412303          	lw	t1,420(sp)
     908:	0362                	slli	t1,t1,0x18
     90a:	18612c23          	sw	t1,408(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     90e:	1a812303          	lw	t1,424(sp)
     912:	0342                	slli	t1,t1,0x10
     914:	1a612223          	sw	t1,420(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     918:	1b412303          	lw	t1,436(sp)
     91c:	0362                	slli	t1,t1,0x18
     91e:	1a612423          	sw	t1,424(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     922:	1b812303          	lw	t1,440(sp)
     926:	0342                	slli	t1,t1,0x10
     928:	1a612a23          	sw	t1,436(sp)

0000092c <.LBB669>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     92c:	1c412303          	lw	t1,452(sp)
     930:	0362                	slli	t1,t1,0x18
     932:	1a612c23          	sw	t1,440(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     936:	1c812303          	lw	t1,456(sp)
     93a:	0342                	slli	t1,t1,0x10
     93c:	1c612223          	sw	t1,452(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     940:	1d412303          	lw	t1,468(sp)
     944:	0362                	slli	t1,t1,0x18
     946:	1c612423          	sw	t1,456(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     94a:	1d812303          	lw	t1,472(sp)
     94e:	0342                	slli	t1,t1,0x10
     950:	1c612a23          	sw	t1,468(sp)

00000954 <.LBB670>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     954:	1e412303          	lw	t1,484(sp)
     958:	0362                	slli	t1,t1,0x18
     95a:	1c612c23          	sw	t1,472(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     95e:	1e812303          	lw	t1,488(sp)
     962:	0342                	slli	t1,t1,0x10
     964:	1e612223          	sw	t1,484(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     968:	1f412303          	lw	t1,500(sp)
     96c:	0362                	slli	t1,t1,0x18
     96e:	1e612423          	sw	t1,488(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     972:	1f812303          	lw	t1,504(sp)

00000976 <.LBB671>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     976:	5702                	lw	a4,32(sp)

00000978 <.LBB672>:
     978:	11412e83          	lw	t4,276(sp)

0000097c <.LBB673>:
             Shift_Left (U32 (X (I + 5)), 16) or
     97c:	0342                	slli	t1,t1,0x10
     97e:	1e612a23          	sw	t1,500(sp)

00000982 <.LBB674>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     982:	20412303          	lw	t1,516(sp)

00000986 <.LBB675>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     986:	00e8e8b3          	or	a7,a7,a4

0000098a <.LBB676>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     98a:	471e                	lw	a4,196(sp)

0000098c <.LBB677>:
     98c:	0362                	slli	t1,t1,0x18
     98e:	1e612c23          	sw	t1,504(sp)
             Shift_Left (U32 (X (I + 1)), 16) or
     992:	20812303          	lw	t1,520(sp)

00000996 <.LBB678>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     996:	12412f83          	lw	t6,292(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     99a:	13412383          	lw	t2,308(sp)

0000099e <.LBB679>:
             Shift_Left (U32 (X (I + 1)), 16) or
     99e:	0342                	slli	t1,t1,0x10
     9a0:	20612223          	sw	t1,516(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     9a4:	21412303          	lw	t1,532(sp)
     9a8:	0362                	slli	t1,t1,0x18
     9aa:	20612423          	sw	t1,520(sp)
             Shift_Left (U32 (X (I + 5)), 16) or
     9ae:	21812303          	lw	t1,536(sp)
     9b2:	0342                	slli	t1,t1,0x10
     9b4:	20612a23          	sw	t1,532(sp)

000009b8 <.LBB680>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     9b8:	533a                	lw	t1,172(sp)
     9ba:	006aeab3          	or	s5,s5,t1

000009be <.LBB681>:
     9be:	536a                	lw	t1,184(sp)
     9c0:	00e36633          	or	a2,t1,a4
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     9c4:	432e                	lw	t1,200(sp)
     9c6:	475e                	lw	a4,212(sp)
      MSW := Shift_Left (U32 (X (I)),     24) or
     9c8:	d732                	sw	a2,172(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     9ca:	00e36533          	or	a0,t1,a4

000009ce <.LBB682>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     9ce:	436e                	lw	t1,216(sp)
     9d0:	571e                	lw	a4,228(sp)

000009d2 <.LBB683>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     9d2:	dd2a                	sw	a0,184(sp)

000009d4 <.LBB684>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     9d4:	00e36633          	or	a2,t1,a4
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     9d8:	532e                	lw	t1,232(sp)
     9da:	575e                	lw	a4,244(sp)
     9dc:	00e36533          	or	a0,t1,a4

000009e0 <.LBB685>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     9e0:	536e                	lw	t1,248(sp)
     9e2:	10412703          	lw	a4,260(sp)
     9e6:	00e36733          	or	a4,t1,a4
     9ea:	c3ba                	sw	a4,196(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     9ec:	10812703          	lw	a4,264(sp)
     9f0:	01d76eb3          	or	t4,a4,t4

000009f4 <.LBB686>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     9f4:	11812703          	lw	a4,280(sp)
     9f8:	01f76fb3          	or	t6,a4,t6
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     9fc:	12812703          	lw	a4,296(sp)
     a00:	007763b3          	or	t2,a4,t2

00000a04 <.LBB687>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     a04:	13812703          	lw	a4,312(sp)
     a08:	14412903          	lw	s2,324(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     a0c:	15412c03          	lw	s8,340(sp)

00000a10 <.LBB688>:
     a10:	17412303          	lw	t1,372(sp)

00000a14 <.LBB689>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     a14:	01276933          	or	s2,a4,s2
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     a18:	14812703          	lw	a4,328(sp)
     a1c:	01876733          	or	a4,a4,s8
     a20:	c5ba                	sw	a4,200(sp)

00000a22 <.LBB690>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     a22:	16412c03          	lw	s8,356(sp)
     a26:	15812703          	lw	a4,344(sp)
     a2a:	01876c33          	or	s8,a4,s8
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     a2e:	16812703          	lw	a4,360(sp)
     a32:	00676733          	or	a4,a4,t1
     a36:	cbba                	sw	a4,212(sp)

00000a38 <.LBB691>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     a38:	17812303          	lw	t1,376(sp)
     a3c:	18412703          	lw	a4,388(sp)
     a40:	00e36733          	or	a4,t1,a4
     a44:	cdba                	sw	a4,216(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     a46:	18812303          	lw	t1,392(sp)
     a4a:	19412703          	lw	a4,404(sp)
     a4e:	00e36733          	or	a4,t1,a4
     a52:	d3ba                	sw	a4,228(sp)

00000a54 <.LBB692>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     a54:	19812303          	lw	t1,408(sp)
     a58:	1a412703          	lw	a4,420(sp)
     a5c:	00e36733          	or	a4,t1,a4
     a60:	d5ba                	sw	a4,232(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     a62:	1a812303          	lw	t1,424(sp)
     a66:	1b412703          	lw	a4,436(sp)
     a6a:	00e36733          	or	a4,t1,a4
     a6e:	dbba                	sw	a4,244(sp)

00000a70 <.LBB693>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     a70:	1b812303          	lw	t1,440(sp)
     a74:	1c412703          	lw	a4,452(sp)
     a78:	00e36333          	or	t1,t1,a4
     a7c:	dd9a                	sw	t1,248(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     a7e:	1d412703          	lw	a4,468(sp)
     a82:	1c812303          	lw	t1,456(sp)
     a86:	00e36333          	or	t1,t1,a4
     a8a:	10612223          	sw	t1,260(sp)

00000a8e <.LBB694>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     a8e:	1e412703          	lw	a4,484(sp)
     a92:	1d812303          	lw	t1,472(sp)
     a96:	00e36333          	or	t1,t1,a4
     a9a:	10612423          	sw	t1,264(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     a9e:	1f412703          	lw	a4,500(sp)
     aa2:	1e812303          	lw	t1,488(sp)
     aa6:	00e36333          	or	t1,t1,a4
     aaa:	10612a23          	sw	t1,276(sp)

00000aae <.LBB695>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     aae:	20412703          	lw	a4,516(sp)
     ab2:	1f812303          	lw	t1,504(sp)
     ab6:	00e36333          	or	t1,t1,a4
     aba:	10612c23          	sw	t1,280(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     abe:	21412703          	lw	a4,532(sp)
     ac2:	20812303          	lw	t1,520(sp)
     ac6:	00e36333          	or	t1,t1,a4

00000aca <.LBB696>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     aca:	5736                	lw	a4,108(sp)

00000acc <.LBB697>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     acc:	12612223          	sw	t1,292(sp)

00000ad0 <.LBB698>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     ad0:	00e7e333          	or	t1,a5,a4
             Shift_Left (U32 (X (I + 2)), 8) or
     ad4:	57c6                	lw	a5,112(sp)
      MSW := Shift_Left (U32 (X (I)),     24) or
     ad6:	d01a                	sw	t1,32(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     ad8:	07a2                	slli	a5,a5,0x8
     ada:	d6be                	sw	a5,108(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     adc:	57d6                	lw	a5,116(sp)
     ade:	8edd                	or	a3,a3,a5
             Shift_Left (U32 (X (I + 6)), 8) or
     ae0:	57e6                	lw	a5,120(sp)
     ae2:	07a2                	slli	a5,a5,0x8
     ae4:	d8be                	sw	a5,112(sp)

00000ae6 <.LBB699>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     ae6:	57f6                	lw	a5,124(sp)
     ae8:	8ddd                	or	a1,a1,a5
             Shift_Left (U32 (X (I + 2)), 8) or
     aea:	478a                	lw	a5,128(sp)
     aec:	00879313          	slli	t1,a5,0x8
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     af0:	479a                	lw	a5,132(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     af2:	da9a                	sw	t1,116(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     af4:	00f8e8b3          	or	a7,a7,a5
             Shift_Left (U32 (X (I + 6)), 8) or
     af8:	47aa                	lw	a5,136(sp)
     afa:	00879313          	slli	t1,a5,0x8

00000afe <.LBB700>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     afe:	47ba                	lw	a5,140(sp)

00000b00 <.LBB701>:
             Shift_Left (U32 (X (I + 6)), 8) or
     b00:	dc9a                	sw	t1,120(sp)

00000b02 <.LBB702>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     b02:	00fe6e33          	or	t3,t3,a5
             Shift_Left (U32 (X (I + 2)), 8) or
     b06:	47ca                	lw	a5,144(sp)
     b08:	00879313          	slli	t1,a5,0x8
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     b0c:	47da                	lw	a5,148(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     b0e:	de9a                	sw	t1,124(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     b10:	00ff6f33          	or	t5,t5,a5
             Shift_Left (U32 (X (I + 6)), 8) or
     b14:	47ea                	lw	a5,152(sp)
     b16:	00879313          	slli	t1,a5,0x8

00000b1a <.LBB703>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     b1a:	47fa                	lw	a5,156(sp)

00000b1c <.LBB704>:
             Shift_Left (U32 (X (I + 6)), 8) or
     b1c:	c11a                	sw	t1,128(sp)

00000b1e <.LBB705>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     b1e:	00f2e2b3          	or	t0,t0,a5
             Shift_Left (U32 (X (I + 2)), 8) or
     b22:	578a                	lw	a5,160(sp)
     b24:	00879313          	slli	t1,a5,0x8
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     b28:	579a                	lw	a5,164(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     b2a:	c31a                	sw	t1,132(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     b2c:	8cdd                	or	s1,s1,a5
             Shift_Left (U32 (X (I + 6)), 8) or
     b2e:	57aa                	lw	a5,168(sp)
     b30:	00879313          	slli	t1,a5,0x8

00000b34 <.LBB706>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     b34:	57ca                	lw	a5,176(sp)

00000b36 <.LBB707>:
             Shift_Left (U32 (X (I + 6)), 8) or
     b36:	c51a                	sw	t1,136(sp)

00000b38 <.LBB708>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     b38:	00faeab3          	or	s5,s5,a5
             Shift_Left (U32 (X (I + 2)), 8) or
     b3c:	57da                	lw	a5,180(sp)
     b3e:	00879313          	slli	t1,a5,0x8
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     b42:	57fa                	lw	a5,188(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     b44:	c71a                	sw	t1,140(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     b46:	00fbebb3          	or	s7,s7,a5
             Shift_Left (U32 (X (I + 6)), 8) or
     b4a:	478e                	lw	a5,192(sp)
     b4c:	00879313          	slli	t1,a5,0x8
     b50:	c91a                	sw	t1,144(sp)

00000b52 <.LBB709>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     b52:	47be                	lw	a5,204(sp)
     b54:	533a                	lw	t1,172(sp)
     b56:	00f36333          	or	t1,t1,a5
             Shift_Left (U32 (X (I + 2)), 8) or
     b5a:	47ce                	lw	a5,208(sp)
      MSW := Shift_Left (U32 (X (I)),     24) or
     b5c:	cb1a                	sw	t1,148(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     b5e:	00879313          	slli	t1,a5,0x8
     b62:	cd1a                	sw	t1,152(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     b64:	47fe                	lw	a5,220(sp)
     b66:	536a                	lw	t1,184(sp)
     b68:	00f36333          	or	t1,t1,a5
             Shift_Left (U32 (X (I + 6)), 8) or
     b6c:	578e                	lw	a5,224(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     b6e:	cf1a                	sw	t1,156(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
     b70:	00879313          	slli	t1,a5,0x8

00000b74 <.LBB710>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     b74:	57be                	lw	a5,236(sp)

00000b76 <.LBB711>:
             Shift_Left (U32 (X (I + 6)), 8) or
     b76:	d11a                	sw	t1,160(sp)

00000b78 <.LBB712>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     b78:	8e5d                	or	a2,a2,a5
             Shift_Left (U32 (X (I + 2)), 8) or
     b7a:	57ce                	lw	a5,240(sp)
     b7c:	00879713          	slli	a4,a5,0x8
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     b80:	57fe                	lw	a5,252(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     b82:	d33a                	sw	a4,164(sp)

00000b84 <.LBB713>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     b84:	471e                	lw	a4,196(sp)

00000b86 <.LBB714>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     b86:	8d5d                	or	a0,a0,a5
             Shift_Left (U32 (X (I + 6)), 8) or
     b88:	10012783          	lw	a5,256(sp)
     b8c:	00879313          	slli	t1,a5,0x8

00000b90 <.LBB715>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     b90:	10c12783          	lw	a5,268(sp)

00000b94 <.LBB716>:
             Shift_Left (U32 (X (I + 6)), 8) or
     b94:	d51a                	sw	t1,168(sp)

00000b96 <.LBB717>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     b96:	00f76333          	or	t1,a4,a5
             Shift_Left (U32 (X (I + 2)), 8) or
     b9a:	11012783          	lw	a5,272(sp)
     b9e:	00879713          	slli	a4,a5,0x8
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     ba2:	11c12783          	lw	a5,284(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     ba6:	d73a                	sw	a4,172(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     ba8:	00feeeb3          	or	t4,t4,a5
             Shift_Left (U32 (X (I + 6)), 8) or
     bac:	12012783          	lw	a5,288(sp)
     bb0:	00879713          	slli	a4,a5,0x8

00000bb4 <.LBB718>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     bb4:	12c12783          	lw	a5,300(sp)

00000bb8 <.LBB719>:
             Shift_Left (U32 (X (I + 6)), 8) or
     bb8:	d93a                	sw	a4,176(sp)

00000bba <.LBB720>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     bba:	00ffefb3          	or	t6,t6,a5
             Shift_Left (U32 (X (I + 2)), 8) or
     bbe:	13012783          	lw	a5,304(sp)
     bc2:	00879713          	slli	a4,a5,0x8
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     bc6:	13c12783          	lw	a5,316(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     bca:	db3a                	sw	a4,180(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     bcc:	00f3e3b3          	or	t2,t2,a5
             Shift_Left (U32 (X (I + 6)), 8) or
     bd0:	14012783          	lw	a5,320(sp)
     bd4:	00879713          	slli	a4,a5,0x8

00000bd8 <.LBB721>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     bd8:	14c12783          	lw	a5,332(sp)

00000bdc <.LBB722>:
             Shift_Left (U32 (X (I + 6)), 8) or
     bdc:	dd3a                	sw	a4,184(sp)

00000bde <.LBB723>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     bde:	00f96933          	or	s2,s2,a5
             Shift_Left (U32 (X (I + 2)), 8) or
     be2:	15012783          	lw	a5,336(sp)
     be6:	00879713          	slli	a4,a5,0x8
     bea:	df3a                	sw	a4,188(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     bec:	15c12783          	lw	a5,348(sp)
     bf0:	472e                	lw	a4,200(sp)
     bf2:	8f5d                	or	a4,a4,a5
             Shift_Left (U32 (X (I + 6)), 8) or
     bf4:	16012783          	lw	a5,352(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     bf8:	c1ba                	sw	a4,192(sp)

00000bfa <.LBB724>:
     bfa:	475e                	lw	a4,212(sp)

00000bfc <.LBB725>:
             Shift_Left (U32 (X (I + 6)), 8) or
     bfc:	07a2                	slli	a5,a5,0x8
     bfe:	c3be                	sw	a5,196(sp)

00000c00 <.LBB726>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     c00:	16c12783          	lw	a5,364(sp)
     c04:	00fc6c33          	or	s8,s8,a5
             Shift_Left (U32 (X (I + 2)), 8) or
     c08:	17012783          	lw	a5,368(sp)
     c0c:	07a2                	slli	a5,a5,0x8
     c0e:	c5be                	sw	a5,200(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     c10:	17c12783          	lw	a5,380(sp)
     c14:	8f5d                	or	a4,a4,a5
             Shift_Left (U32 (X (I + 6)), 8) or
     c16:	18012783          	lw	a5,384(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     c1a:	c7ba                	sw	a4,204(sp)

00000c1c <.LBB727>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     c1c:	476e                	lw	a4,216(sp)

00000c1e <.LBB728>:
             Shift_Left (U32 (X (I + 6)), 8) or
     c1e:	07a2                	slli	a5,a5,0x8
     c20:	c9be                	sw	a5,208(sp)

00000c22 <.LBB729>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     c22:	18c12783          	lw	a5,396(sp)
     c26:	8f5d                	or	a4,a4,a5
             Shift_Left (U32 (X (I + 2)), 8) or
     c28:	19012783          	lw	a5,400(sp)
      MSW := Shift_Left (U32 (X (I)),     24) or
     c2c:	cbba                	sw	a4,212(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     c2e:	571e                	lw	a4,228(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     c30:	07a2                	slli	a5,a5,0x8
     c32:	cdbe                	sw	a5,216(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     c34:	19c12783          	lw	a5,412(sp)
     c38:	8f5d                	or	a4,a4,a5
             Shift_Left (U32 (X (I + 6)), 8) or
     c3a:	1a012783          	lw	a5,416(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     c3e:	cfba                	sw	a4,220(sp)

00000c40 <.LBB730>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     c40:	572e                	lw	a4,232(sp)

00000c42 <.LBB731>:
             Shift_Left (U32 (X (I + 6)), 8) or
     c42:	07a2                	slli	a5,a5,0x8
     c44:	d1be                	sw	a5,224(sp)

00000c46 <.LBB732>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     c46:	1ac12783          	lw	a5,428(sp)
     c4a:	8f5d                	or	a4,a4,a5
             Shift_Left (U32 (X (I + 2)), 8) or
     c4c:	1b012783          	lw	a5,432(sp)
      MSW := Shift_Left (U32 (X (I)),     24) or
     c50:	d3ba                	sw	a4,228(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     c52:	07a2                	slli	a5,a5,0x8
     c54:	d5be                	sw	a5,232(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     c56:	575e                	lw	a4,244(sp)
     c58:	1bc12783          	lw	a5,444(sp)
     c5c:	8f5d                	or	a4,a4,a5
             Shift_Left (U32 (X (I + 6)), 8) or
     c5e:	1c012783          	lw	a5,448(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     c62:	d7ba                	sw	a4,236(sp)

00000c64 <.LBB733>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     c64:	576e                	lw	a4,248(sp)

00000c66 <.LBB734>:
             Shift_Left (U32 (X (I + 6)), 8) or
     c66:	07a2                	slli	a5,a5,0x8
     c68:	d9be                	sw	a5,240(sp)

00000c6a <.LBB735>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     c6a:	1cc12783          	lw	a5,460(sp)
     c6e:	8fd9                	or	a5,a5,a4
     c70:	dbbe                	sw	a5,244(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     c72:	1d012783          	lw	a5,464(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     c76:	10412703          	lw	a4,260(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     c7a:	07a2                	slli	a5,a5,0x8
     c7c:	ddbe                	sw	a5,248(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     c7e:	1dc12783          	lw	a5,476(sp)
     c82:	8f5d                	or	a4,a4,a5
             Shift_Left (U32 (X (I + 6)), 8) or
     c84:	1e012783          	lw	a5,480(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     c88:	dfba                	sw	a4,252(sp)

00000c8a <.LBB736>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     c8a:	10812703          	lw	a4,264(sp)

00000c8e <.LBB737>:
             Shift_Left (U32 (X (I + 6)), 8) or
     c8e:	07a2                	slli	a5,a5,0x8
     c90:	10f12023          	sw	a5,256(sp)

00000c94 <.LBB738>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     c94:	1ec12783          	lw	a5,492(sp)
     c98:	8fd9                	or	a5,a5,a4
     c9a:	10f12223          	sw	a5,260(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     c9e:	1f012783          	lw	a5,496(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     ca2:	11412703          	lw	a4,276(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     ca6:	07a2                	slli	a5,a5,0x8
     ca8:	10f12423          	sw	a5,264(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     cac:	1fc12783          	lw	a5,508(sp)
     cb0:	8f5d                	or	a4,a4,a5
             Shift_Left (U32 (X (I + 6)), 8) or
     cb2:	20012783          	lw	a5,512(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     cb6:	10e12623          	sw	a4,268(sp)

00000cba <.LBB739>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     cba:	11812703          	lw	a4,280(sp)

00000cbe <.LBB740>:
             Shift_Left (U32 (X (I + 6)), 8) or
     cbe:	07a2                	slli	a5,a5,0x8
     cc0:	10f12823          	sw	a5,272(sp)

00000cc4 <.LBB741>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     cc4:	20c12783          	lw	a5,524(sp)
     cc8:	8fd9                	or	a5,a5,a4
     cca:	10f12a23          	sw	a5,276(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     cce:	21012783          	lw	a5,528(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     cd2:	12412703          	lw	a4,292(sp)
             Shift_Left (U32 (X (I + 2)), 8) or
     cd6:	07a2                	slli	a5,a5,0x8
     cd8:	10f12c23          	sw	a5,280(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     cdc:	21c12783          	lw	a5,540(sp)
     ce0:	8f5d                	or	a4,a4,a5
     ce2:	10e12e23          	sw	a4,284(sp)
             Shift_Left (U32 (X (I + 6)), 8) or
     ce6:	22012783          	lw	a5,544(sp)

00000cea <.LBB742>:
      return Shift_Left (U64 (MSW), 32) or U64 (LSW);
     cea:	5702                	lw	a4,32(sp)

00000cec <.LBB743>:
             Shift_Left (U32 (X (I + 6)), 8) or
     cec:	07a2                	slli	a5,a5,0x8
     cee:	12f12023          	sw	a5,288(sp)

00000cf2 <.LBB744>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     cf2:	57c6                	lw	a5,112(sp)
     cf4:	8fd5                	or	a5,a5,a3
      return Shift_Left (U64 (MSW), 32) or U64 (LSW);
     cf6:	56b6                	lw	a3,108(sp)
     cf8:	8f55                	or	a4,a4,a3

00000cfa <.LBB745>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     cfa:	56d6                	lw	a3,116(sp)
     cfc:	8dd5                	or	a1,a1,a3
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     cfe:	56e6                	lw	a3,120(sp)
     d00:	00d8e8b3          	or	a7,a7,a3

00000d04 <.LBB746>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     d04:	56f6                	lw	a3,124(sp)
     d06:	00de6e33          	or	t3,t3,a3
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     d0a:	468a                	lw	a3,128(sp)
     d0c:	00df6f33          	or	t5,t5,a3

00000d10 <.LBB747>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     d10:	469a                	lw	a3,132(sp)
     d12:	00d2e2b3          	or	t0,t0,a3
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     d16:	46aa                	lw	a3,136(sp)
     d18:	8cd5                	or	s1,s1,a3

00000d1a <.LBB748>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     d1a:	46ba                	lw	a3,140(sp)
     d1c:	00daeab3          	or	s5,s5,a3
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     d20:	46ca                	lw	a3,144(sp)
     d22:	00dbebb3          	or	s7,s7,a3
     d26:	2b712023          	sw	s7,672(sp)

00000d2a <.LBB749>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     d2a:	46da                	lw	a3,148(sp)
     d2c:	4bea                	lw	s7,152(sp)
     d2e:	0176ebb3          	or	s7,a3,s7
     d32:	2b712623          	sw	s7,684(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     d36:	46fa                	lw	a3,156(sp)
     d38:	5b8a                	lw	s7,160(sp)
     d3a:	0176ebb3          	or	s7,a3,s7

00000d3e <.LBB750>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     d3e:	569a                	lw	a3,164(sp)

00000d40 <.LBB751>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     d40:	2b712423          	sw	s7,680(sp)

00000d44 <.LBB752>:
     d44:	4b9e                	lw	s7,196(sp)

00000d46 <.LBB753>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     d46:	8e55                	or	a2,a2,a3
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     d48:	56aa                	lw	a3,168(sp)
     d4a:	8d55                	or	a0,a0,a3

00000d4c <.LBB754>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     d4c:	56ba                	lw	a3,172(sp)
     d4e:	00d36333          	or	t1,t1,a3
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     d52:	56ca                	lw	a3,176(sp)
     d54:	00deeeb3          	or	t4,t4,a3

00000d58 <.LBB755>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     d58:	56da                	lw	a3,180(sp)
     d5a:	00dfefb3          	or	t6,t6,a3
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     d5e:	56ea                	lw	a3,184(sp)
     d60:	00d3e3b3          	or	t2,t2,a3

00000d64 <.LBB756>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     d64:	56fa                	lw	a3,188(sp)
     d66:	00d96933          	or	s2,s2,a3
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     d6a:	468e                	lw	a3,192(sp)
     d6c:	0176ebb3          	or	s7,a3,s7

00000d70 <.LBB757>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     d70:	46ae                	lw	a3,200(sp)

00000d72 <.LBB758>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     d72:	2d712423          	sw	s7,712(sp)

00000d76 <.LBB759>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     d76:	00dc6c33          	or	s8,s8,a3
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     d7a:	46be                	lw	a3,204(sp)
     d7c:	4bce                	lw	s7,208(sp)

00000d7e <.LBE759>:
         pragma Loop_Invariant
           ((LN + I64 (CB) = I64 (M'Last) + 1) and
              (LN in 128 .. M'Length) and
              (CB in M'First .. (M'Last - 127)));

         W := (0  => DL64 (M, CB),
     d7e:	28f12023          	sw	a5,640(sp)

00000d82 <.LBB760>:
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     d82:	0176e6b3          	or	a3,a3,s7
     d86:	2cd12823          	sw	a3,720(sp)

00000d8a <.LBB761>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     d8a:	4bee                	lw	s7,216(sp)
     d8c:	46de                	lw	a3,212(sp)
     d8e:	0176e6b3          	or	a3,a3,s7
     d92:	2cd12e23          	sw	a3,732(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     d96:	5b8e                	lw	s7,224(sp)
     d98:	46fe                	lw	a3,220(sp)
     d9a:	0176e6b3          	or	a3,a3,s7
     d9e:	2cd12c23          	sw	a3,728(sp)

00000da2 <.LBB762>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     da2:	5bae                	lw	s7,232(sp)
     da4:	569e                	lw	a3,228(sp)
     da6:	0176e6b3          	or	a3,a3,s7
     daa:	2ed12223          	sw	a3,740(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     dae:	5bce                	lw	s7,240(sp)
     db0:	56be                	lw	a3,236(sp)
     db2:	0176e6b3          	or	a3,a3,s7
     db6:	2ed12023          	sw	a3,736(sp)

00000dba <.LBB763>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     dba:	5bee                	lw	s7,248(sp)
     dbc:	56de                	lw	a3,244(sp)
     dbe:	0176e6b3          	or	a3,a3,s7
     dc2:	2ed12623          	sw	a3,748(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     dc6:	10012b83          	lw	s7,256(sp)
     dca:	56fe                	lw	a3,252(sp)
     dcc:	0176e6b3          	or	a3,a3,s7
     dd0:	2ed12423          	sw	a3,744(sp)

00000dd4 <.LBB764>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     dd4:	10812b83          	lw	s7,264(sp)
     dd8:	10412683          	lw	a3,260(sp)
     ddc:	0176e6b3          	or	a3,a3,s7
     de0:	2ed12a23          	sw	a3,756(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     de4:	11012b83          	lw	s7,272(sp)
     de8:	10c12683          	lw	a3,268(sp)
     dec:	0176e6b3          	or	a3,a3,s7
     df0:	2ed12823          	sw	a3,752(sp)

00000df4 <.LBB765>:
      MSW := Shift_Left (U32 (X (I)),     24) or
     df4:	11812b83          	lw	s7,280(sp)
     df8:	11412683          	lw	a3,276(sp)
     dfc:	0176e6b3          	or	a3,a3,s7
     e00:	2ed12e23          	sw	a3,764(sp)
      LSW := Shift_Left (U32 (X (I + 4)), 24) or
     e04:	12012b83          	lw	s7,288(sp)
     e08:	11c12683          	lw	a3,284(sp)
     e0c:	0176e6b3          	or	a3,a3,s7

00000e10 <.LVL32>:
     e10:	22812b83          	lw	s7,552(sp)

00000e14 <.LBE765>:
         W := (0  => DL64 (M, CB),
     e14:	2d812a23          	sw	s8,724(sp)
     e18:	4c01                	li	s8,0
     e1a:	28e12223          	sw	a4,644(sp)
     e1e:	29c12a23          	sw	t3,660(sp)
     e22:	28512e23          	sw	t0,668(sp)
     e26:	2aa12823          	sw	a0,688(sp)
     e2a:	2c712023          	sw	t2,704(sp)
     e2e:	d06a                	sw	s10,32(sp)
     e30:	853a                	mv	a0,a4
     e32:	29112423          	sw	a7,648(sp)
     e36:	873e                	mv	a4,a5
     e38:	28b12623          	sw	a1,652(sp)
     e3c:	29e12823          	sw	t5,656(sp)
     e40:	28912c23          	sw	s1,664(sp)
     e44:	2b512223          	sw	s5,676(sp)
     e48:	2ac12a23          	sw	a2,692(sp)
     e4c:	2bd12c23          	sw	t4,696(sp)
     e50:	2a612e23          	sw	t1,700(sp)
     e54:	2df12223          	sw	t6,708(sp)
     e58:	2d212623          	sw	s2,716(sp)
     e5c:	2ed12c23          	sw	a3,760(sp)
     e60:	4e01                	li	t3,0
     e62:	83da                	mv	t2,s6
     e64:	82c2                	mv	t0,a6
     e66:	8d62                	mv	s10,s8

00000e68 <.LVL34>:
     e68:	87a2                	mv	a5,s0
     e6a:	a0b1                	j	eb6 <.L11>

00000e6c <.L20>:
               12 => DL64 (M, CB + 96),
               13 => DL64 (M, CB + 104),
               14 => DL64 (M, CB + 112),
               15 => DL64 (M, CB + 120));

         for I in Index_80 loop
     e6c:	0d05                	addi	s10,s10,1

00000e6e <.LVL36>:
     e6e:	05000793          	li	a5,80
     e72:	0ba1                	addi	s7,s7,8
     e74:	2afd0763          	beq	s10,a5,1122 <.L19>

00000e78 <.L7>:
     e78:	4732                	lw	a4,12(sp)
     e7a:	42d2                	lw	t0,20(sp)
     e7c:	00fd7e13          	andi	t3,s10,15
     e80:	ca3a                	sw	a4,20(sp)
     e82:	4742                	lw	a4,16(sp)
     e84:	061c                	addi	a5,sp,768
     e86:	003e1693          	slli	a3,t3,0x3
     e8a:	96be                	add	a3,a3,a5
     e8c:	47e2                	lw	a5,24(sp)
     e8e:	cc3a                	sw	a4,24(sp)
     e90:	4772                	lw	a4,28(sp)
     e92:	5382                	lw	t2,32(sp)
     e94:	f846a503          	lw	a0,-124(a3)
     e98:	d23a                	sw	a4,36(sp)
     e9a:	4712                	lw	a4,4(sp)
     e9c:	c652                	sw	s4,12(sp)
     e9e:	c84e                	sw	s3,16(sp)
     ea0:	d03a                	sw	a4,32(sp)

00000ea2 <.LVL38>:
     ea2:	4722                	lw	a4,8(sp)
     ea4:	c266                	sw	s9,4(sp)

00000ea6 <.LVL39>:
     ea6:	c46e                	sw	s11,8(sp)
     ea8:	ce3a                	sw	a4,28(sp)
     eaa:	f806a703          	lw	a4,-128(a3)

            T := A (7) + UC_Sigma1 (A (4)) + Ch (A (4), A (5), A (6)) +
                 K (I) + W (I mod 16);

            B (7) := T + UC_Sigma0 (A (0)) + Maj (A (0), A (1), A (2));
            B (3) := B (3) + T;
     eae:	8a7a                	mv	s4,t5
     eb0:	89da                	mv	s3,s6
            B (7) := T + UC_Sigma0 (A (0)) + Maj (A (0), A (1), A (2));
     eb2:	8ce2                	mv	s9,s8

00000eb4 <.LVL40>:
     eb4:	8dfe                	mv	s11,t6

00000eb6 <.L11>:
            T := A (7) + UC_Sigma1 (A (4)) + Ch (A (4), A (5), A (6)) +
     eb6:	00e28c33          	add	s8,t0,a4
     eba:	000ba803          	lw	a6,0(s7)
     ebe:	97aa                	add	a5,a5,a0
     ec0:	004ba483          	lw	s1,4(s7)

00000ec4 <.LBB768>:
      is (RR64 (X, 14) xor RR64 (X, 18) xor RR64 (X, 41))
     ec4:	012a5693          	srli	a3,s4,0x12
     ec8:	01299893          	slli	a7,s3,0x12
     ecc:	00ea5713          	srli	a4,s4,0xe

00000ed0 <.LBE768>:
            T := A (7) + UC_Sigma1 (A (4)) + Ch (A (4), A (5), A (6)) +
     ed0:	005c32b3          	sltu	t0,s8,t0

00000ed4 <.LBB779>:
      is (RR64 (X, 14) xor RR64 (X, 18) xor RR64 (X, 41))
     ed4:	00e99593          	slli	a1,s3,0xe

00000ed8 <.LBB780>:
      is ((X and Y) xor (X and Z) xor (Y and Z))
     ed8:	5b02                	lw	s6,32(sp)

00000eda <.LBB791>:
      is (RR64 (X, 14) xor RR64 (X, 18) xor RR64 (X, 41))
     eda:	8dd5                	or	a1,a1,a3
     edc:	00ea1f13          	slli	t5,s4,0xe
     ee0:	00e8e6b3          	or	a3,a7,a4
     ee4:	0129df93          	srli	t6,s3,0x12
     ee8:	00e9de93          	srli	t4,s3,0xe

00000eec <.LBE791>:
            T := A (7) + UC_Sigma1 (A (4)) + Ch (A (4), A (5), A (6)) +
     eec:	92be                	add	t0,t0,a5

00000eee <.LBB792>:
      is (RR64 (X, 14) xor RR64 (X, 18) xor RR64 (X, 41))
     eee:	012a1713          	slli	a4,s4,0x12

00000ef2 <.LBB793>:
      is ((X and Y) xor (X and Z) xor (Y and Z))
     ef2:	4792                	lw	a5,4(sp)

00000ef4 <.LBE793>:
            T := A (7) + UC_Sigma1 (A (4)) + Ch (A (4), A (5), A (6)) +
     ef4:	010c0533          	add	a0,s8,a6

00000ef8 <.LBB794>:
      is (RR64 (X, 14) xor RR64 (X, 18) xor RR64 (X, 41))
     ef8:	01ff6433          	or	s0,t5,t6
     efc:	01d76733          	or	a4,a4,t4
     f00:	8ead                	xor	a3,a3,a1
     f02:	009a5893          	srli	a7,s4,0x9
     f06:	01799593          	slli	a1,s3,0x17
     f0a:	00e44f33          	xor	t5,s0,a4

00000f0e <.LBE794>:
            T := A (7) + UC_Sigma1 (A (4)) + Ch (A (4), A (5), A (6)) +
     f0e:	01853c33          	sltu	s8,a0,s8
     f12:	92a6                	add	t0,t0,s1

00000f14 <.LBB795>:
      is (RR64 (X, 28) xor RR64 (X, 34) xor RR64 (X, 39))
     f14:	002dde93          	srli	t4,s11,0x2
     f18:	01ec9f93          	slli	t6,s9,0x1e

00000f1c <.LBB807>:
      is (RR64 (X, 14) xor RR64 (X, 18) xor RR64 (X, 41))
     f1c:	00b8e8b3          	or	a7,a7,a1

00000f20 <.LBB808>:
      is (RR64 (X, 28) xor RR64 (X, 34) xor RR64 (X, 39))
     f20:	01fee4b3          	or	s1,t4,t6

00000f24 <.LBB809>:
      is (RR64 (X, 14) xor RR64 (X, 18) xor RR64 (X, 41))
     f24:	011f48b3          	xor	a7,t5,a7

00000f28 <.LBB810>:
      is ((X and Y) xor (X and Z) xor (Y and Z))
     f28:	00fb4fb3          	xor	t6,s6,a5

00000f2c <.LBB811>:
      is ((X and Y) xor ((not X) and Z))
     f2c:	4ed2                	lw	t4,20(sp)

00000f2e <.LBE811>:
            T := A (7) + UC_Sigma1 (A (4)) + Ch (A (4), A (5), A (6)) +
     f2e:	005c07b3          	add	a5,s8,t0

00000f32 <.LBB822>:
      is (RR64 (X, 14) xor RR64 (X, 18) xor RR64 (X, 41))
     f32:	017a1313          	slli	t1,s4,0x17
     f36:	0099d613          	srli	a2,s3,0x9

00000f3a <.LBE822>:
            T := A (7) + UC_Sigma1 (A (4)) + Ch (A (4), A (5), A (6)) +
     f3a:	97c6                	add	a5,a5,a7

00000f3c <.LBB823>:
      is (RR64 (X, 14) xor RR64 (X, 18) xor RR64 (X, 41))
     f3c:	00666633          	or	a2,a2,t1

00000f40 <.LBB824>:
      is ((X and Y) xor ((not X) and Z))
     f40:	48e2                	lw	a7,24(sp)

00000f42 <.LBB825>:
      is (RR64 (X, 28) xor RR64 (X, 34) xor RR64 (X, 39))
     f42:	01ccd313          	srli	t1,s9,0x1c
     f46:	004d9813          	slli	a6,s11,0x4

00000f4a <.LBB826>:
      is (RR64 (X, 14) xor RR64 (X, 18) xor RR64 (X, 41))
     f4a:	8e35                	xor	a2,a2,a3

00000f4c <.LBB827>:
      is (RR64 (X, 28) xor RR64 (X, 34) xor RR64 (X, 39))
     f4c:	00686833          	or	a6,a6,t1
     f50:	01ed9a93          	slli	s5,s11,0x1e
     f54:	01cdd713          	srli	a4,s11,0x1c
     f58:	007dd693          	srli	a3,s11,0x7
     f5c:	019c9913          	slli	s2,s9,0x19

00000f60 <.LBB828>:
      is ((X and Y) xor ((not X) and Z))
     f60:	fffa4593          	not	a1,s4

00000f64 <.LBB829>:
      is (RR64 (X, 28) xor RR64 (X, 34) xor RR64 (X, 39))
     f64:	002cd413          	srli	s0,s9,0x2
     f68:	004c9313          	slli	t1,s9,0x4

00000f6c <.LBB830>:
      is ((X and Y) xor (X and Z) xor (Y and Z))
     f6c:	4c22                	lw	s8,8(sp)

00000f6e <.LBB831>:
      is ((X and Y) xor ((not X) and Z))
     f6e:	01d5f5b3          	and	a1,a1,t4

00000f72 <.LBB832>:
      is (RR64 (X, 28) xor RR64 (X, 34) xor RR64 (X, 39))
     f72:	01546433          	or	s0,s0,s5

00000f76 <.LBB833>:
      is ((X and Y) xor ((not X) and Z))
     f76:	4eb2                	lw	t4,12(sp)

00000f78 <.LBB834>:
      is ((X and Y) xor (X and Z) xor (Y and Z))
     f78:	4af2                	lw	s5,28(sp)

00000f7a <.LBB835>:
      is (RR64 (X, 28) xor RR64 (X, 34) xor RR64 (X, 39))
     f7a:	00e36333          	or	t1,t1,a4

00000f7e <.LBB836>:
      is ((X and Y) xor ((not X) and Z))
     f7e:	fff9c293          	not	t0,s3

00000f82 <.LBB837>:
      is (RR64 (X, 28) xor RR64 (X, 34) xor RR64 (X, 39))
     f82:	0126e733          	or	a4,a3,s2

00000f86 <.LBB838>:
      is ((X and Y) xor (X and Z) xor (Y and Z))
     f86:	019ff933          	and	s2,t6,s9
     f8a:	4f92                	lw	t6,4(sp)

00000f8c <.LBB839>:
      is ((X and Y) xor ((not X) and Z))
     f8c:	0112f2b3          	and	t0,t0,a7
     f90:	48c2                	lw	a7,16(sp)

00000f92 <.LBE839>:
            T := A (7) + UC_Sigma1 (A (4)) + Ch (A (4), A (5), A (6)) +
     f92:	9532                	add	a0,a0,a2

00000f94 <.LBB840>:
      is ((X and Y) xor (X and Z) xor (Y and Z))
     f94:	018ac6b3          	xor	a3,s5,s8
     f98:	01fb7fb3          	and	t6,s6,t6

00000f9c <.LBB841>:
      is ((X and Y) xor ((not X) and Z))
     f9c:	014eff33          	and	t5,t4,s4

00000fa0 <.LBB842>:
      is (RR64 (X, 28) xor RR64 (X, 34) xor RR64 (X, 39))
     fa0:	0104ceb3          	xor	t4,s1,a6
     fa4:	007cd813          	srli	a6,s9,0x7
     fa8:	019d9493          	slli	s1,s11,0x19
     fac:	00eec733          	xor	a4,t4,a4

00000fb0 <.LBE842>:
            T := A (7) + UC_Sigma1 (A (4)) + Ch (A (4), A (5), A (6)) +
     fb0:	00c53633          	sltu	a2,a0,a2

00000fb4 <.LBB843>:
      is ((X and Y) xor (X and Z) xor (Y and Z))
     fb4:	018afab3          	and	s5,s5,s8
     fb8:	01f94933          	xor	s2,s2,t6

00000fbc <.LBB844>:
      is ((X and Y) xor ((not X) and Z))
     fbc:	0138feb3          	and	t4,a7,s3
     fc0:	01e5cf33          	xor	t5,a1,t5

00000fc4 <.LBB845>:
      is (RR64 (X, 28) xor RR64 (X, 34) xor RR64 (X, 39))
     fc4:	00644333          	xor	t1,s0,t1
     fc8:	00986833          	or	a6,a6,s1

00000fcc <.LBB846>:
      is ((X and Y) xor (X and Z) xor (Y and Z))
     fcc:	01b6f6b3          	and	a3,a3,s11

00000fd0 <.LBE846>:
            T := A (7) + UC_Sigma1 (A (4)) + Ch (A (4), A (5), A (6)) +
     fd0:	9f2a                	add	t5,t5,a0
            B (7) := T + UC_Sigma0 (A (0)) + Maj (A (0), A (1), A (2));
     fd2:	993a                	add	s2,s2,a4
            T := A (7) + UC_Sigma1 (A (4)) + Ch (A (4), A (5), A (6)) +
     fd4:	963e                	add	a2,a2,a5

00000fd6 <.LBB847>:
      is ((X and Y) xor ((not X) and Z))
     fd6:	01d2ceb3          	xor	t4,t0,t4

00000fda <.LBE847>:
            B (3) := B (3) + T;
     fda:	5792                	lw	a5,36(sp)

00000fdc <.LBB848>:
      is (RR64 (X, 28) xor RR64 (X, 34) xor RR64 (X, 39))
     fdc:	01034333          	xor	t1,t1,a6

00000fe0 <.LBB849>:
      is ((X and Y) xor (X and Z) xor (Y and Z))
     fe0:	0156c6b3          	xor	a3,a3,s5

00000fe4 <.LBE849>:
            T := A (7) + UC_Sigma1 (A (4)) + Ch (A (4), A (5), A (6)) +
     fe4:	00af3533          	sltu	a0,t5,a0
     fe8:	9676                	add	a2,a2,t4
            B (7) := T + UC_Sigma0 (A (0)) + Maj (A (0), A (1), A (2));
     fea:	00e93733          	sltu	a4,s2,a4
     fee:	9336                	add	t1,t1,a3
            T := A (7) + UC_Sigma1 (A (4)) + Ch (A (4), A (5), A (6)) +
     ff0:	962a                	add	a2,a2,a0

00000ff2 <.LVL42>:
            B (7) := T + UC_Sigma0 (A (0)) + Maj (A (0), A (1), A (2));
     ff2:	01e90c33          	add	s8,s2,t5
     ff6:	971a                	add	a4,a4,t1
            B (3) := B (3) + T;
     ff8:	9f1e                	add	t5,t5,t2

00000ffa <.LVL43>:
            B (7) := T + UC_Sigma0 (A (0)) + Maj (A (0), A (1), A (2));
     ffa:	9732                	add	a4,a4,a2
     ffc:	012c3fb3          	sltu	t6,s8,s2
            B (3) := B (3) + T;
    1000:	963e                	add	a2,a2,a5
    1002:	007f3b33          	sltu	s6,t5,t2
                  4 => B (3),
                  5 => B (4),
                  6 => B (5),
                  7 => B (6));

            if (I mod 16 = 15) then
    1006:	47bd                	li	a5,15
            B (7) := T + UC_Sigma0 (A (0)) + Maj (A (0), A (1), A (2));
    1008:	9fba                	add	t6,t6,a4
            B (3) := B (3) + T;
    100a:	9b32                	add	s6,s6,a2

0000100c <.LVL44>:
            if (I mod 16 = 15) then
    100c:	e6fe10e3          	bne	t3,a5,e6c <.L20>
    1010:	28010e93          	addi	t4,sp,640
    1014:	4e25                	li	t3,9

00001016 <.L9>:
               for J in Index_16 loop
                  W (J) := W (J) + W ((J + 9) mod 16) +
                    LC_Sigma0 (W ((J + 1) mod 16)) +
    1016:	ff8e0713          	addi	a4,t3,-8
    101a:	8b3d                	andi	a4,a4,15
    101c:	0614                	addi	a3,sp,768
    101e:	070e                	slli	a4,a4,0x3
    1020:	9736                	add	a4,a4,a3
                    LC_Sigma1 (W ((J + 14) mod 16));
    1022:	005e0793          	addi	a5,t3,5
                    LC_Sigma0 (W ((J + 1) mod 16)) +
    1026:	f8472603          	lw	a2,-124(a4)
    102a:	f8072803          	lw	a6,-128(a4)
                  W (J) := W (J) + W ((J + 9) mod 16) +
    102e:	00fe7693          	andi	a3,t3,15
                    LC_Sigma1 (W ((J + 14) mod 16));
    1032:	8bbd                	andi	a5,a5,15
    1034:	0618                	addi	a4,sp,768
    1036:	078e                	slli	a5,a5,0x3
                  W (J) := W (J) + W ((J + 9) mod 16) +
    1038:	068e                	slli	a3,a3,0x3
                    LC_Sigma1 (W ((J + 14) mod 16));
    103a:	97ba                	add	a5,a5,a4
                  W (J) := W (J) + W ((J + 9) mod 16) +
    103c:	96ba                	add	a3,a3,a4
                    LC_Sigma1 (W ((J + 14) mod 16));
    103e:	f847a503          	lw	a0,-124(a5)
    1042:	f807a583          	lw	a1,-128(a5)
                  W (J) := W (J) + W ((J + 9) mod 16) +
    1046:	f806a283          	lw	t0,-128(a3)
    104a:	000ea703          	lw	a4,0(t4)

0000104e <.LBB851>:
      is (RR64 (X, 1) xor RR64 (X, 8) xor Shift_Right (X, 7))
    104e:	00865313          	srli	t1,a2,0x8
    1052:	01881a93          	slli	s5,a6,0x18

00001056 <.LBE851>:
                  W (J) := W (J) + W ((J + 9) mod 16) +
    1056:	f846a883          	lw	a7,-124(a3)

0000105a <.LBB859>:
      is (RR64 (X, 1) xor RR64 (X, 8) xor Shift_Right (X, 7))
    105a:	00885793          	srli	a5,a6,0x8
    105e:	01f61413          	slli	s0,a2,0x1f
    1062:	006aeab3          	or	s5,s5,t1
    1066:	01861393          	slli	t2,a2,0x18

0000106a <.LBE859>:
                  W (J) := W (J) + W ((J + 9) mod 16) +
    106a:	004ea303          	lw	t1,4(t4)

0000106e <.LBB860>:
      is (RR64 (X, 1) xor RR64 (X, 8) xor Shift_Right (X, 7))
    106e:	00185693          	srli	a3,a6,0x1
    1072:	8ec1                	or	a3,a3,s0
    1074:	00165493          	srli	s1,a2,0x1
    1078:	01961413          	slli	s0,a2,0x19
    107c:	00f3e3b3          	or	t2,t2,a5
    1080:	01f81913          	slli	s2,a6,0x1f
    1084:	00785813          	srli	a6,a6,0x7

00001088 <.LBE860>:
                  W (J) := W (J) + W ((J + 9) mod 16) +
    1088:	9716                	add	a4,a4,t0

0000108a <.LBB861>:
      is (RR64 (X, 1) xor RR64 (X, 8) xor Shift_Right (X, 7))
    108a:	00996933          	or	s2,s2,s1
    108e:	00d3c7b3          	xor	a5,t2,a3
    1092:	01046833          	or	a6,s0,a6

00001096 <.LBB862>:
      is (RR64 (X, 19) xor RR64 (X, 61) xor Shift_Right (X, 6))
    1096:	01d55493          	srli	s1,a0,0x1d
    109a:	0135d393          	srli	t2,a1,0x13
    109e:	00359693          	slli	a3,a1,0x3
    10a2:	00d51413          	slli	s0,a0,0xd

000010a6 <.LBE862>:
                  W (J) := W (J) + W ((J + 9) mod 16) +
    10a6:	005732b3          	sltu	t0,a4,t0
    10aa:	989a                	add	a7,a7,t1

000010ac <.LBB869>:
      is (RR64 (X, 1) xor RR64 (X, 8) xor Shift_Right (X, 7))
    10ac:	0107c7b3          	xor	a5,a5,a6
    10b0:	012ac333          	xor	t1,s5,s2

000010b4 <.LBB870>:
      is (RR64 (X, 19) xor RR64 (X, 61) xor Shift_Right (X, 6))
    10b4:	00351813          	slli	a6,a0,0x3
    10b8:	01d5da93          	srli	s5,a1,0x1d
    10bc:	8ec5                	or	a3,a3,s1
    10be:	00746433          	or	s0,s0,t2
    10c2:	01355913          	srli	s2,a0,0x13
    10c6:	00d59393          	slli	t2,a1,0xd
    10ca:	01a51493          	slli	s1,a0,0x1a

000010ce <.LBB871>:
      is (RR64 (X, 1) xor RR64 (X, 8) xor Shift_Right (X, 7))
    10ce:	821d                	srli	a2,a2,0x7

000010d0 <.LBB872>:
      is (RR64 (X, 19) xor RR64 (X, 61) xor Shift_Right (X, 6))
    10d0:	8199                	srli	a1,a1,0x6

000010d2 <.LBE872>:
                  W (J) := W (J) + W ((J + 9) mod 16) +
    10d2:	97ba                	add	a5,a5,a4
    10d4:	9896                	add	a7,a7,t0

000010d6 <.LBB873>:
      is (RR64 (X, 1) xor RR64 (X, 8) xor Shift_Right (X, 7))
    10d6:	00c34633          	xor	a2,t1,a2

000010da <.LBB874>:
      is (RR64 (X, 19) xor RR64 (X, 61) xor Shift_Right (X, 6))
    10da:	010ae833          	or	a6,s5,a6
    10de:	0123e3b3          	or	t2,t2,s2
    10e2:	8ea1                	xor	a3,a3,s0
    10e4:	8dc5                	or	a1,a1,s1

000010e6 <.LBE874>:
                  W (J) := W (J) + W ((J + 9) mod 16) +
    10e6:	00e7b733          	sltu	a4,a5,a4
    10ea:	98b2                	add	a7,a7,a2

000010ec <.LBB875>:
      is (RR64 (X, 19) xor RR64 (X, 61) xor Shift_Right (X, 6))
    10ec:	007843b3          	xor	t2,a6,t2
    10f0:	8119                	srli	a0,a0,0x6
    10f2:	8db5                	xor	a1,a1,a3

000010f4 <.LBE875>:
                    LC_Sigma0 (W ((J + 1) mod 16)) +
    10f4:	95be                	add	a1,a1,a5
                  W (J) := W (J) + W ((J + 9) mod 16) +
    10f6:	9746                	add	a4,a4,a7

000010f8 <.LBB876>:
      is (RR64 (X, 19) xor RR64 (X, 61) xor Shift_Right (X, 6))
    10f8:	00a3c533          	xor	a0,t2,a0

000010fc <.LBE876>:
                    LC_Sigma0 (W ((J + 1) mod 16)) +
    10fc:	00f5b7b3          	sltu	a5,a1,a5
    1100:	972a                	add	a4,a4,a0
    1102:	973e                	add	a4,a4,a5
                  W (J) := W (J) + W ((J + 9) mod 16) +
    1104:	00bea023          	sw	a1,0(t4)
    1108:	00eea223          	sw	a4,4(t4)
               for J in Index_16 loop
    110c:	0e05                	addi	t3,t3,1

0000110e <.LVL46>:
    110e:	47e5                	li	a5,25
    1110:	0ea1                	addi	t4,t4,8
    1112:	f0fe12e3          	bne	t3,a5,1016 <.L9>

00001116 <.LBE850>:
         for I in Index_80 loop
    1116:	0d05                	addi	s10,s10,1

00001118 <.LVL47>:
    1118:	05000793          	li	a5,80
    111c:	0ba1                	addi	s7,s7,8
    111e:	d4fd1de3          	bne	s10,a5,e78 <.L7>

00001122 <.L19>:
            end if;

         end loop;

         for I in Index_8 loop
            A (I) := A (I) + Z (I);
    1122:	5552                	lw	a0,52(sp)
    1124:	4792                	lw	a5,4(sp)
    1126:	5432                	lw	s0,44(sp)

00001128 <.LBB878>:
    1128:	5d02                	lw	s10,32(sp)

0000112a <.LBB879>:
    112a:	00f506b3          	add	a3,a0,a5
    112e:	00a6b8b3          	sltu	a7,a3,a0
    1132:	4526                	lw	a0,72(sp)
    1134:	47f6                	lw	a5,92(sp)
    1136:	4616                	lw	a2,68(sp)
    1138:	9faa                	add	t6,t6,a0

0000113a <.LVL49>:
    113a:	4506                	lw	a0,64(sp)
    113c:	55f2                	lw	a1,60(sp)
    113e:	00fd0733          	add	a4,s10,a5
    1142:	44b6                	lw	s1,76(sp)
    1144:	4ed6                	lw	t4,84(sp)
    1146:	9f22                	add	t5,t5,s0

00001148 <.LVL50>:
    1148:	47b2                	lw	a5,12(sp)
    114a:	9daa                	add	s11,s11,a0

0000114c <.LVL51>:
    114c:	008f3933          	sltu	s2,t5,s0
    1150:	5562                	lw	a0,56(sp)
    1152:	4422                	lw	s0,8(sp)
    1154:	9cae                	add	s9,s9,a1
    1156:	9a26                	add	s4,s4,s1
    1158:	97f6                	add	a5,a5,t4

0000115a <.LBB880>:
    115a:	83da                	mv	t2,s6

0000115c <.LBB881>:
    115c:	01860b33          	add	s6,a2,s8
    1160:	00cb3e33          	sltu	t3,s6,a2
    1164:	00bcb333          	sltu	t1,s9,a1
    1168:	01d7b633          	sltu	a2,a5,t4
    116c:	009a35b3          	sltu	a1,s4,s1
    1170:	00850eb3          	add	t4,a0,s0
    1174:	5486                	lw	s1,96(sp)
    1176:	4472                	lw	s0,28(sp)
    1178:	4bd2                	lw	s7,20(sp)
    117a:	5816                	lw	a6,100(sp)
    117c:	009402b3          	add	t0,s0,s1
    1180:	5442                	lw	s0,48(sp)
    1182:	44c2                	lw	s1,16(sp)
    1184:	985e                	add	a6,a6,s7
    1186:	00740ab3          	add	s5,s0,t2
    118a:	4446                	lw	s0,80(sp)
    118c:	01a73533          	sltu	a0,a4,s10
    1190:	9e7e                	add	t3,t3,t6
    1192:	99a2                	add	s3,s3,s0
    1194:	4466                	lw	s0,88(sp)
    1196:	01b30fb3          	add	t6,t1,s11
    119a:	9516                	add	a0,a0,t0
    119c:	009403b3          	add	t2,s0,s1
    11a0:	44e2                	lw	s1,24(sp)
    11a2:	01783433          	sltu	s0,a6,s7
    11a6:	5ba6                	lw	s7,104(sp)
    11a8:	01d88333          	add	t1,a7,t4
    11ac:	c2da                	sw	s6,68(sp)
    11ae:	013588b3          	add	a7,a1,s3
    11b2:	94de                	add	s1,s1,s7
    11b4:	dc1a                	sw	t1,56(sp)
    11b6:	8bda                	mv	s7,s6
    11b8:	c4f2                	sw	t3,72(sp)

000011ba <.LVL52>:
    11ba:	8b3a                	mv	s6,a4

000011bc <.LVL53>:
    11bc:	de66                	sw	s9,60(sp)
    11be:	01590733          	add	a4,s2,s5
    11c2:	c0fe                	sw	t6,64(sp)
    11c4:	da36                	sw	a3,52(sp)
    11c6:	d22a                	sw	a0,36(sp)
    11c8:	d67a                	sw	t5,44(sp)
    11ca:	d83a                	sw	a4,48(sp)
    11cc:	9426                	add	s0,s0,s1
    11ce:	c8c6                	sw	a7,80(sp)
            Z (I) := A (I);
    11d0:	849a                	mv	s1,t1
    11d2:	24612a23          	sw	t1,596(sp)
    11d6:	89ba                	mv	s3,a4
    11d8:	26e12223          	sw	a4,612(sp)
    11dc:	27112623          	sw	a7,620(sp)
    11e0:	8746                	mv	a4,a7

000011e2 <.LBE881>:
         end loop;

         exit when LN < 256;
    11e2:	22412303          	lw	t1,548(sp)
    11e6:	58a2                	lw	a7,40(sp)

000011e8 <.LBB882>:
            A (I) := A (I) + Z (I);
    11e8:	007605b3          	add	a1,a2,t2
    11ec:	c6d2                	sw	s4,76(sp)
    11ee:	cabe                	sw	a5,84(sp)
    11f0:	ccae                	sw	a1,88(sp)
            Z (I) := A (I);
    11f2:	25712023          	sw	s7,576(sp)
    11f6:	25c12223          	sw	t3,580(sp)

000011fa <.LVL54>:
    11fa:	25912423          	sw	s9,584(sp)
    11fe:	25f12623          	sw	t6,588(sp)

00001202 <.LVL55>:
    1202:	24d12823          	sw	a3,592(sp)
    1206:	25612c23          	sw	s6,600(sp)
    120a:	24a12e23          	sw	a0,604(sp)

0000120e <.LVL56>:
    120e:	27e12023          	sw	t5,608(sp)
    1212:	27412423          	sw	s4,616(sp)
    1216:	26f12823          	sw	a5,624(sp)
    121a:	26b12a23          	sw	a1,628(sp)

0000121e <.LVL57>:
    121e:	27012c23          	sw	a6,632(sp)
    1222:	26812e23          	sw	s0,636(sp)
            A (I) := A (I) + Z (I);
    1226:	8d36                	mv	s10,a3
            Z (I) := A (I);
    1228:	8df2                	mv	s11,t3

0000122a <.LBE882>:
         exit when LN < 256;
    122a:	03130a63          	beq	t1,a7,125e <.L4>
    122e:	08088893          	addi	a7,a7,128

00001232 <.LBB883>:
            A (I) := A (I) + Z (I);
    1232:	c652                	sw	s4,12(sp)
    1234:	c266                	sw	s9,4(sp)

00001236 <.LVL58>:
    1236:	d446                	sw	a7,40(sp)
    1238:	8cde                	mv	s9,s7

0000123a <.LBE883>:
         exit when LN < 256;
    123a:	d2c2                	sw	a6,100(sp)
    123c:	d4a2                	sw	s0,104(sp)
    123e:	ceda                	sw	s6,92(sp)
    1240:	d0aa                	sw	a0,96(sp)

00001242 <.LBB884>:
            A (I) := A (I) + Z (I);
    1242:	ca3e                	sw	a5,20(sp)
    1244:	cc2e                	sw	a1,24(sp)
    1246:	c83a                	sw	a4,16(sp)
    1248:	8a7a                	mv	s4,t5
    124a:	ce26                	sw	s1,28(sp)

0000124c <.LVL60>:
    124c:	c47e                	sw	t6,8(sp)
    124e:	8bc6                	mv	s7,a7

00001250 <.LVL61>:
    1250:	9f8ff06f          	j	448 <.L12>

00001254 <.L18>:
      while (LN >= 128) loop
    1254:	e589                	bnez	a1,125e <.L4>
    1256:	07e00593          	li	a1,126
    125a:	9af5e263          	bltu	a1,a5,3fe <.L13>

0000125e <.L4>:
         LN := LN - 128;
      end loop;


      for I in Index_8 loop
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    125e:	24412383          	lw	t2,580(sp)
    1262:	25c12303          	lw	t1,604(sp)
    1266:	24812f03          	lw	t5,584(sp)
    126a:	24c12f83          	lw	t6,588(sp)
    126e:	25012e03          	lw	t3,592(sp)
    1272:	25412e83          	lw	t4,596(sp)

00001276 <.LBB887>:
         T := Shift_Right (T, 8);
    1276:	0103dd13          	srli	s10,t2,0x10

0000127a <.LBE887>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    127a:	76c1                	lui	a3,0xffff0
    127c:	0ff68693          	addi	a3,a3,255 # ffff00ff <.LFE5+0xfffee93b>

00001280 <.LBB938>:
         T := Shift_Right (T, 8);
    1280:	01035713          	srli	a4,t1,0x10

00001284 <.LBE938>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    1284:	0183d893          	srli	a7,t2,0x18
    1288:	0ffd7d13          	andi	s10,s10,255

0000128c <.LBB939>:
         T := Shift_Right (T, 8);
    128c:	c23a                	sw	a4,4(sp)
    128e:	010fdc13          	srli	s8,t6,0x10
    1292:	010f5b93          	srli	s7,t5,0x10
    1296:	010edb13          	srli	s6,t4,0x10
    129a:	010e5a93          	srli	s5,t3,0x10

0000129e <.LBE939>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    129e:	0d22                	slli	s10,s10,0x8
    12a0:	00d8f8b3          	and	a7,a7,a3
    12a4:	018fd513          	srli	a0,t6,0x18
    12a8:	018f5593          	srli	a1,t5,0x18
    12ac:	018ed613          	srli	a2,t4,0x18
    12b0:	018e5793          	srli	a5,t3,0x18
    12b4:	01a8e8b3          	or	a7,a7,s10
    12b8:	0ffc7c13          	andi	s8,s8,255
    12bc:	00414d03          	lbu	s10,4(sp)
    12c0:	0ffbfb93          	andi	s7,s7,255
    12c4:	0ffb7b13          	andi	s6,s6,255
    12c8:	0ffafa93          	andi	s5,s5,255

000012cc <.LBB940>:
         T := Shift_Right (T, 8);
    12cc:	008ed413          	srli	s0,t4,0x8
    12d0:	008e5d93          	srli	s11,t3,0x8

000012d4 <.LBE940>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    12d4:	0c22                	slli	s8,s8,0x8
    12d6:	8d75                	and	a0,a0,a3

000012d8 <.LBB941>:
         T := Shift_Right (T, 8);
    12d8:	008fd913          	srli	s2,t6,0x8

000012dc <.LBE941>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    12dc:	0ba2                	slli	s7,s7,0x8
    12de:	8df5                	and	a1,a1,a3

000012e0 <.LBB942>:
         T := Shift_Right (T, 8);
    12e0:	008f5493          	srli	s1,t5,0x8

000012e4 <.LBE942>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    12e4:	0b22                	slli	s6,s6,0x8
    12e6:	8e75                	and	a2,a2,a3
    12e8:	0aa2                	slli	s5,s5,0x8
    12ea:	8ff5                	and	a5,a5,a3
    12ec:	ff010737          	lui	a4,0xff010
    12f0:	177d                	addi	a4,a4,-1
    12f2:	01666633          	or	a2,a2,s6
    12f6:	0157e7b3          	or	a5,a5,s5
    12fa:	01856533          	or	a0,a0,s8
    12fe:	0ffdfa93          	andi	s5,s11,255
    1302:	0175e5b3          	or	a1,a1,s7
    1306:	0ff47b13          	andi	s6,s0,255
    130a:	0ff97913          	andi	s2,s2,255
    130e:	01835413          	srli	s0,t1,0x18
    1312:	0ff4f493          	andi	s1,s1,255
    1316:	24012283          	lw	t0,576(sp)
    131a:	00e67bb3          	and	s7,a2,a4
    131e:	010a9c13          	slli	s8,s5,0x10
    1322:	0942                	slli	s2,s2,0x10
    1324:	00e7fab3          	and	s5,a5,a4
    1328:	8d79                	and	a0,a0,a4
    132a:	04c2                	slli	s1,s1,0x10
    132c:	8df9                	and	a1,a1,a4
    132e:	0d22                	slli	s10,s10,0x8
    1330:	8c75                	and	s0,s0,a3

00001332 <.LBB943>:
         T := Shift_Right (T, 8);
    1332:	00835613          	srli	a2,t1,0x8

00001336 <.LBE943>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    1336:	010007b7          	lui	a5,0x1000
    133a:	17fd                	addi	a5,a5,-1
    133c:	01256533          	or	a0,a0,s2
    1340:	8dc5                	or	a1,a1,s1
    1342:	018ae933          	or	s2,s5,s8
    1346:	01a46433          	or	s0,s0,s10
    134a:	0ff67613          	andi	a2,a2,255
    134e:	00f5f4b3          	and	s1,a1,a5
    1352:	8c79                	and	s0,s0,a4
    1354:	00f975b3          	and	a1,s2,a5
    1358:	0e62                	slli	t3,t3,0x18
    135a:	0642                	slli	a2,a2,0x10
    135c:	01c5e5b3          	or	a1,a1,t3
    1360:	8e41                	or	a2,a2,s0

00001362 <.LBB944>:
         T := Shift_Right (T, 8);
    1362:	0102dc93          	srli	s9,t0,0x10

00001366 <.LBE944>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    1366:	c432                	sw	a2,8(sp)
    1368:	0182d813          	srli	a6,t0,0x18
    136c:	0185d613          	srli	a2,a1,0x18
    1370:	0ffcfc93          	andi	s9,s9,255
    1374:	00c10223          	sb	a2,4(sp)

00001378 <.LBB945>:
         T := Shift_Right (T, 8);
    1378:	0083da13          	srli	s4,t2,0x8

0000137c <.LBE945>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    137c:	4622                	lw	a2,8(sp)
    137e:	0ca2                	slli	s9,s9,0x8
    1380:	00d87833          	and	a6,a6,a3

00001384 <.LBB946>:
         T := Shift_Right (T, 8);
    1384:	0082d993          	srli	s3,t0,0x8

00001388 <.LBE946>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    1388:	01986833          	or	a6,a6,s9
    138c:	0ffa7a13          	andi	s4,s4,255
    1390:	0ff9f993          	andi	s3,s3,255
    1394:	0a42                	slli	s4,s4,0x10
    1396:	00e8f8b3          	and	a7,a7,a4
    139a:	09c2                	slli	s3,s3,0x10
    139c:	00e87833          	and	a6,a6,a4
    13a0:	0b42                	slli	s6,s6,0x10
    13a2:	0148e8b3          	or	a7,a7,s4
    13a6:	01386833          	or	a6,a6,s3
    13aa:	016beb33          	or	s6,s7,s6
    13ae:	0362                	slli	t1,t1,0x18
    13b0:	8e7d                	and	a2,a2,a5
    13b2:	00666633          	or	a2,a2,t1
    13b6:	00f8f8b3          	and	a7,a7,a5
    13ba:	22c12303          	lw	t1,556(sp)
    13be:	00f87833          	and	a6,a6,a5
    13c2:	8d7d                	and	a0,a0,a5
    13c4:	00fb7b33          	and	s6,s6,a5
    13c8:	0fe2                	slli	t6,t6,0x18
    13ca:	0f62                	slli	t5,t5,0x18
    13cc:	0ee2                	slli	t4,t4,0x18
    13ce:	03e2                	slli	t2,t2,0x18
    13d0:	02e2                	slli	t0,t0,0x18
    13d2:	0078e3b3          	or	t2,a7,t2
    13d6:	005862b3          	or	t0,a6,t0
    13da:	01f568b3          	or	a7,a0,t6
    13de:	01e4e833          	or	a6,s1,t5
    13e2:	01db6533          	or	a0,s6,t4
    13e6:	0083dd13          	srli	s10,t2,0x8
    13ea:	0103dc93          	srli	s9,t2,0x10
    13ee:	0082db93          	srli	s7,t0,0x8
    13f2:	0102db13          	srli	s6,t0,0x10
    13f6:	0183dc13          	srli	s8,t2,0x18
    13fa:	0182da93          	srli	s5,t0,0x18
    13fe:	0088da13          	srli	s4,a7,0x8
    1402:	0108d993          	srli	s3,a7,0x10
    1406:	00885493          	srli	s1,a6,0x8
    140a:	01085413          	srli	s0,a6,0x10
    140e:	0188d913          	srli	s2,a7,0x18
    1412:	01885f93          	srli	t6,a6,0x18
    1416:	00855f13          	srli	t5,a0,0x8
    141a:	0105de13          	srli	t3,a1,0x10
    141e:	01055e93          	srli	t4,a0,0x10
    1422:	c672                	sw	t3,12(sp)
    1424:	00730023          	sb	t2,0(t1)
    1428:	01a300a3          	sb	s10,1(t1)
    142c:	01930123          	sb	s9,2(t1)
    1430:	018301a3          	sb	s8,3(t1)
    1434:	00530223          	sb	t0,4(t1)
    1438:	017302a3          	sb	s7,5(t1)
    143c:	01630323          	sb	s6,6(t1)
    1440:	015303a3          	sb	s5,7(t1)

00001444 <.LVL66>:
    1444:	01130423          	sb	a7,8(t1)
    1448:	014304a3          	sb	s4,9(t1)
    144c:	01330523          	sb	s3,10(t1)
    1450:	012305a3          	sb	s2,11(t1)
    1454:	01030623          	sb	a6,12(t1)
    1458:	009306a3          	sb	s1,13(t1)
    145c:	00830723          	sb	s0,14(t1)
    1460:	01f307a3          	sb	t6,15(t1)

00001464 <.LVL67>:
    1464:	00a30823          	sb	a0,16(t1)
    1468:	01e308a3          	sb	t5,17(t1)
    146c:	01d30923          	sb	t4,18(t1)
    1470:	27412e83          	lw	t4,628(sp)
    1474:	26c12f83          	lw	t6,620(sp)
    1478:	25812403          	lw	s0,600(sp)
    147c:	01855e13          	srli	t3,a0,0x18

00001480 <.LBB947>:
         T := Shift_Right (T, 8);
    1480:	010edd13          	srli	s10,t4,0x10

00001484 <.LBE947>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    1484:	01c309a3          	sb	t3,19(t1)

00001488 <.LBB948>:
         T := Shift_Right (T, 8);
    1488:	010fdb13          	srli	s6,t6,0x10

0000148c <.LBE948>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    148c:	4e32                	lw	t3,12(sp)
    148e:	0ffd7d13          	andi	s10,s10,255
    1492:	018fd813          	srli	a6,t6,0x18
    1496:	0d22                	slli	s10,s10,0x8
    1498:	0ffb7b13          	andi	s6,s6,255
    149c:	00414503          	lbu	a0,4(sp)
    14a0:	26812f03          	lw	t5,616(sp)
    14a4:	c26a                	sw	s10,4(sp)

000014a6 <.LBB949>:
         T := Shift_Right (T, 8);
    14a6:	01045c93          	srli	s9,s0,0x10

000014aa <.LBE949>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    14aa:	0b22                	slli	s6,s6,0x8
    14ac:	00d87833          	and	a6,a6,a3
    14b0:	01c30b23          	sb	t3,22(t1)
    14b4:	01686833          	or	a6,a6,s6
    14b8:	01845e13          	srli	t3,s0,0x18
    14bc:	4b12                	lw	s6,4(sp)
    14be:	0ffcfc93          	andi	s9,s9,255
    14c2:	00b30a23          	sb	a1,20(t1)
    14c6:	0085dd93          	srli	s11,a1,0x8
    14ca:	0ca2                	slli	s9,s9,0x8
    14cc:	018ed593          	srli	a1,t4,0x18
    14d0:	00de7e33          	and	t3,t3,a3

000014d4 <.LBB950>:
         T := Shift_Right (T, 8);
    14d4:	00845a13          	srli	s4,s0,0x8
    14d8:	010f5a93          	srli	s5,t5,0x10

000014dc <.LBE950>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    14dc:	8df5                	and	a1,a1,a3

000014de <.LBB951>:
         T := Shift_Right (T, 8);
    14de:	008edd13          	srli	s10,t4,0x8

000014e2 <.LBE951>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    14e2:	019e6e33          	or	t3,t3,s9
    14e6:	0ffa7a13          	andi	s4,s4,255
    14ea:	00a30ba3          	sb	a0,23(t1)

000014ee <.LVL68>:
    14ee:	26412383          	lw	t2,612(sp)
    14f2:	018f5513          	srli	a0,t5,0x18
    14f6:	0165e5b3          	or	a1,a1,s6
    14fa:	0a42                	slli	s4,s4,0x10
    14fc:	00ee7e33          	and	t3,t3,a4
    1500:	0ffafa93          	andi	s5,s5,255
    1504:	0ffd7d13          	andi	s10,s10,255
    1508:	01b30aa3          	sb	s11,21(t1)
    150c:	0aa2                	slli	s5,s5,0x8

0000150e <.LBB952>:
         T := Shift_Right (T, 8);
    150e:	008f5d93          	srli	s11,t5,0x8

00001512 <.LBE952>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    1512:	8d75                	and	a0,a0,a3
    1514:	0d42                	slli	s10,s10,0x10
    1516:	8df9                	and	a1,a1,a4
    1518:	014e6e33          	or	t3,t3,s4
    151c:	00c30c23          	sb	a2,24(t1)
    1520:	26012283          	lw	t0,608(sp)
    1524:	01556533          	or	a0,a0,s5
    1528:	01a5e5b3          	or	a1,a1,s10
    152c:	0ffdfa93          	andi	s5,s11,255
    1530:	01065d13          	srli	s10,a2,0x10
    1534:	00865d93          	srli	s11,a2,0x8
    1538:	0462                	slli	s0,s0,0x18
    153a:	00fe7e33          	and	t3,t3,a5
    153e:	8261                	srli	a2,a2,0x18
    1540:	008e6e33          	or	t3,t3,s0
    1544:	00c10223          	sb	a2,4(sp)

00001548 <.LBB953>:
         T := Shift_Right (T, 8);
    1548:	0103dc13          	srli	s8,t2,0x10

0000154c <.LBE953>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    154c:	22c12603          	lw	a2,556(sp)

00001550 <.LBB954>:
         T := Shift_Right (T, 8);
    1550:	008fd493          	srli	s1,t6,0x8

00001554 <.LBE954>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    1554:	008e5413          	srli	s0,t3,0x8
    1558:	0183d313          	srli	t1,t2,0x18
    155c:	0ffc7c13          	andi	s8,s8,255
    1560:	0ff4f493          	andi	s1,s1,255
    1564:	c422                	sw	s0,8(sp)

00001566 <.LBB955>:
         T := Shift_Right (T, 8);
    1566:	0102db93          	srli	s7,t0,0x10

0000156a <.LBE955>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    156a:	0c22                	slli	s8,s8,0x8
    156c:	00d37333          	and	t1,t1,a3

00001570 <.LBB956>:
         T := Shift_Right (T, 8);
    1570:	0083d993          	srli	s3,t2,0x8

00001574 <.LBE956>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    1574:	04c2                	slli	s1,s1,0x10
    1576:	00e87833          	and	a6,a6,a4
    157a:	018e5c93          	srli	s9,t3,0x18
    157e:	01c60e23          	sb	t3,28(a2)
    1582:	0182d893          	srli	a7,t0,0x18
    1586:	01836333          	or	t1,t1,s8
    158a:	00986833          	or	a6,a6,s1
    158e:	0ffbfb93          	andi	s7,s7,255
    1592:	010e5493          	srli	s1,t3,0x10
    1596:	0ff9f993          	andi	s3,s3,255
    159a:	4e22                	lw	t3,8(sp)
    159c:	0ba2                	slli	s7,s7,0x8
    159e:	00d8f8b3          	and	a7,a7,a3

000015a2 <.LBB957>:
         T := Shift_Right (T, 8);
    15a2:	0082d913          	srli	s2,t0,0x8

000015a6 <.LBE957>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    15a6:	09c2                	slli	s3,s3,0x10
    15a8:	00e37333          	and	t1,t1,a4
    15ac:	c626                	sw	s1,12(sp)
    15ae:	0178e8b3          	or	a7,a7,s7
    15b2:	01336333          	or	t1,t1,s3
    15b6:	0ff97913          	andi	s2,s2,255
    15ba:	01a60d23          	sb	s10,26(a2)
    15be:	01c60ea3          	sb	t3,29(a2)
    15c2:	00414d03          	lbu	s10,4(sp)
    15c6:	4e32                	lw	t3,12(sp)
    15c8:	0942                	slli	s2,s2,0x10
    15ca:	00e8f8b3          	and	a7,a7,a4
    15ce:	03e2                	slli	t2,t2,0x18
    15d0:	00f37333          	and	t1,t1,a5
    15d4:	00736333          	or	t1,t1,t2
    15d8:	0128e8b3          	or	a7,a7,s2
    15dc:	00835c13          	srli	s8,t1,0x8
    15e0:	0ac2                	slli	s5,s5,0x10
    15e2:	8d79                	and	a0,a0,a4
    15e4:	02e2                	slli	t0,t0,0x18
    15e6:	00f8f8b3          	and	a7,a7,a5
    15ea:	0fe2                	slli	t6,t6,0x18
    15ec:	00f87833          	and	a6,a6,a5
    15f0:	0058e8b3          	or	a7,a7,t0
    15f4:	01f86833          	or	a6,a6,t6
    15f8:	01035b93          	srli	s7,t1,0x10
    15fc:	01b60ca3          	sb	s11,25(a2)
    1600:	01a60da3          	sb	s10,27(a2)
    1604:	01c60f23          	sb	t3,30(a2)
    1608:	01960fa3          	sb	s9,31(a2)

0000160c <.LVL69>:
    160c:	02660023          	sb	t1,32(a2)
    1610:	038600a3          	sb	s8,33(a2)
    1614:	01556533          	or	a0,a0,s5
    1618:	03760123          	sb	s7,34(a2)
    161c:	0088da93          	srli	s5,a7,0x8
    1620:	03160223          	sb	a7,36(a2)
    1624:	03060423          	sb	a6,40(a2)
    1628:	0108da13          	srli	s4,a7,0x10
    162c:	01835b13          	srli	s6,t1,0x18
    1630:	0188d993          	srli	s3,a7,0x18
    1634:	27012303          	lw	t1,624(sp)
    1638:	27c12883          	lw	a7,636(sp)
    163c:	00885913          	srli	s2,a6,0x8
    1640:	01085493          	srli	s1,a6,0x10
    1644:	01885413          	srli	s0,a6,0x18
    1648:	0f62                	slli	t5,t5,0x18
    164a:	27812803          	lw	a6,632(sp)
    164e:	8d7d                	and	a0,a0,a5
    1650:	01e56533          	or	a0,a0,t5
    1654:	0ee2                	slli	t4,t4,0x18
    1656:	8dfd                	and	a1,a1,a5
    1658:	01d5e5b3          	or	a1,a1,t4
    165c:	00855393          	srli	t2,a0,0x8
    1660:	01055293          	srli	t0,a0,0x10
    1664:	01855f93          	srli	t6,a0,0x18
    1668:	036601a3          	sb	s6,35(a2)
    166c:	035602a3          	sb	s5,37(a2)
    1670:	03460323          	sb	s4,38(a2)
    1674:	033603a3          	sb	s3,39(a2)

00001678 <.LVL70>:
    1678:	032604a3          	sb	s2,41(a2)
    167c:	02960523          	sb	s1,42(a2)
    1680:	028605a3          	sb	s0,43(a2)
    1684:	02a60623          	sb	a0,44(a2)
    1688:	027606a3          	sb	t2,45(a2)
    168c:	02560723          	sb	t0,46(a2)
    1690:	03f607a3          	sb	t6,47(a2)

00001694 <.LVL71>:
    1694:	8432                	mv	s0,a2

00001696 <.LBB958>:
         T := Shift_Right (T, 8);
    1696:	01035393          	srli	t2,t1,0x10

0000169a <.LBE958>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    169a:	0185d613          	srli	a2,a1,0x18

0000169e <.LBB959>:
         T := Shift_Right (T, 8);
    169e:	01085f93          	srli	t6,a6,0x10
    16a2:	0108d293          	srli	t0,a7,0x10

000016a6 <.LBE959>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    16a6:	0085df13          	srli	t5,a1,0x8
    16aa:	0105de93          	srli	t4,a1,0x10
    16ae:	02b40823          	sb	a1,48(s0)
    16b2:	02c409a3          	sb	a2,51(s0)
    16b6:	01835513          	srli	a0,t1,0x18
    16ba:	01885613          	srli	a2,a6,0x18
    16be:	0188d593          	srli	a1,a7,0x18
    16c2:	0ff3f393          	andi	t2,t2,255
    16c6:	0ff2f293          	andi	t0,t0,255
    16ca:	0fffff93          	andi	t6,t6,255
    16ce:	8df5                	and	a1,a1,a3
    16d0:	03e408a3          	sb	t5,49(s0)
    16d4:	03d40923          	sb	t4,50(s0)
    16d8:	8d75                	and	a0,a0,a3

000016da <.LBB960>:
         T := Shift_Right (T, 8);
    16da:	00835f13          	srli	t5,t1,0x8
    16de:	0088de93          	srli	t4,a7,0x8

000016e2 <.LBE960>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    16e2:	8ef1                	and	a3,a3,a2

000016e4 <.LBB961>:
         T := Shift_Right (T, 8);
    16e4:	00885e13          	srli	t3,a6,0x8

000016e8 <.LBE961>:
         X (8 * I .. (8 * I + 7)) := TS64 (Z (I));
    16e8:	03a2                	slli	t2,t2,0x8
    16ea:	02a2                	slli	t0,t0,0x8
    16ec:	0fa2                	slli	t6,t6,0x8
    16ee:	00756533          	or	a0,a0,t2
    16f2:	0055e633          	or	a2,a1,t0
    16f6:	01f6e6b3          	or	a3,a3,t6
    16fa:	0ffe7e13          	andi	t3,t3,255
    16fe:	0fff7f13          	andi	t5,t5,255
    1702:	0ffefe93          	andi	t4,t4,255
    1706:	00e575b3          	and	a1,a0,a4
    170a:	8e79                	and	a2,a2,a4
    170c:	010e1513          	slli	a0,t3,0x10
    1710:	0f42                	slli	t5,t5,0x10
    1712:	0ec2                	slli	t4,t4,0x10
    1714:	8f75                	and	a4,a4,a3
    1716:	01e5e5b3          	or	a1,a1,t5
    171a:	01d666b3          	or	a3,a2,t4
    171e:	8f49                	or	a4,a4,a0
    1720:	00f5f633          	and	a2,a1,a5
    1724:	8efd                	and	a3,a3,a5
    1726:	0362                	slli	t1,t1,0x18
    1728:	08e2                	slli	a7,a7,0x18
    172a:	0862                	slli	a6,a6,0x18
    172c:	8ff9                	and	a5,a5,a4
    172e:	00666633          	or	a2,a2,t1
    1732:	0116e733          	or	a4,a3,a7
    1736:	0107e7b3          	or	a5,a5,a6
    173a:	00865f13          	srli	t5,a2,0x8
    173e:	01065e93          	srli	t4,a2,0x10
    1742:	01865e13          	srli	t3,a2,0x18
    1746:	00875313          	srli	t1,a4,0x8
    174a:	01075893          	srli	a7,a4,0x10
    174e:	0087d513          	srli	a0,a5,0x8
    1752:	0107d593          	srli	a1,a5,0x10
    1756:	01875813          	srli	a6,a4,0x18
    175a:	0187d693          	srli	a3,a5,0x18
    175e:	02c40a23          	sb	a2,52(s0)
    1762:	03e40aa3          	sb	t5,53(s0)
    1766:	03d40b23          	sb	t4,54(s0)
    176a:	03c40ba3          	sb	t3,55(s0)

0000176e <.LVL72>:
    176e:	02e40c23          	sb	a4,56(s0)
    1772:	02640ca3          	sb	t1,57(s0)
    1776:	03140d23          	sb	a7,58(s0)
    177a:	03040da3          	sb	a6,59(s0)
    177e:	02f40e23          	sb	a5,60(s0)
    1782:	02a40ea3          	sb	a0,61(s0)
    1786:	02b40f23          	sb	a1,62(s0)
    178a:	02d40fa3          	sb	a3,63(s0)

0000178e <.LBE885>:
      end loop;

   end Hashblocks;
    178e:	32c12403          	lw	s0,812(sp)
    1792:	32812483          	lw	s1,808(sp)
    1796:	32412903          	lw	s2,804(sp)
    179a:	32012983          	lw	s3,800(sp)
    179e:	31c12a03          	lw	s4,796(sp)
    17a2:	31812a83          	lw	s5,792(sp)
    17a6:	31412b03          	lw	s6,788(sp)
    17aa:	31012b83          	lw	s7,784(sp)
    17ae:	30c12c03          	lw	s8,780(sp)
    17b2:	30812c83          	lw	s9,776(sp)
    17b6:	30412d03          	lw	s10,772(sp)
    17ba:	30012d83          	lw	s11,768(sp)
    17be:	33010113          	addi	sp,sp,816

000017c2 <.LVL73>:
    17c2:	8082                	ret

Disassembly of section .text.sparknacl__hashing__hash:

00000000 <sparknacl__hashing__hash>:

   procedure Hash (Output :    out Digest;
   0:	7165                	addi	sp,sp,-400
   2:	17312e23          	sw	s3,380(sp)
      B     : Final_Block_Length;
      Final_Block_First : I32;
      ML_MSB  : Byte;
      ML_LSBs : U64;
   begin
      H := IV;
   6:	000007b7          	lui	a5,0x0
   procedure Hash (Output :    out Digest;
   a:	00062983          	lw	s3,0(a2)
      H := IV;
   e:	00078793          	mv	a5,a5
   procedure Hash (Output :    out Digest;
  12:	18912223          	sw	s1,388(sp)
  16:	19212023          	sw	s2,384(sp)
  1a:	17412c23          	sw	s4,376(sp)
  1e:	18112623          	sw	ra,396(sp)
  22:	8a2e                	mv	s4,a1

00000024 <.LVL75>:
  24:	18812423          	sw	s0,392(sp)
  28:	17512a23          	sw	s5,372(sp)
  2c:	17612823          	sw	s6,368(sp)
  30:	17712623          	sw	s7,364(sp)
  34:	17812423          	sw	s8,360(sp)
  38:	17912223          	sw	s9,356(sp)
  3c:	84b2                	mv	s1,a2

0000003e <.LVL76>:
  3e:	892a                	mv	s2,a0
      H := IV;
  40:	1018                	addi	a4,sp,32
  42:	04078593          	addi	a1,a5,64 # 40 <.LVL76+0x2>

00000046 <.L22>:
  46:	4388                	lw	a0,0(a5)
  48:	0047a803          	lw	a6,4(a5)
  4c:	4790                	lw	a2,8(a5)
  4e:	47d4                	lw	a3,12(a5)
  50:	c308                	sw	a0,0(a4)
  52:	01072223          	sw	a6,4(a4) # ff010004 <.LFE5+0xff00e840>
  56:	c710                	sw	a2,8(a4)
  58:	c754                	sw	a3,12(a4)
  5a:	07c1                	addi	a5,a5,16
  5c:	0741                	addi	a4,a4,16
  5e:	feb794e3          	bne	a5,a1,46 <.L22>
      X := (others => 0);
  62:	10000613          	li	a2,256
  66:	4581                	li	a1,0
  68:	1088                	addi	a0,sp,96
  6a:	00000097          	auipc	ra,0x0
  6e:	000080e7          	jalr	ra # 6a <.L22+0x24>

00000072 <.LVL78>:

      Hashblocks (H, M);
  72:	85d2                	mv	a1,s4
  74:	8626                	mv	a2,s1
  76:	1008                	addi	a0,sp,32
  78:	00000097          	auipc	ra,0x0
  7c:	000080e7          	jalr	ra # 78 <.LVL78+0x6>

00000080 <.LVL79>:

      B := Final_Block_Length (I64 (M'Length) mod 128);
  80:	40c0                	lw	s0,4(s1)
  82:	0004ab83          	lw	s7,0(s1)
  86:	07744e63          	blt	s0,s7,102 <.L23>
  8a:	41740733          	sub	a4,s0,s7
  8e:	41f45c93          	srai	s9,s0,0x1f
  92:	41fbdc13          	srai	s8,s7,0x1f
  96:	00e43ab3          	sltu	s5,s0,a4
  9a:	00170493          	addi	s1,a4,1

0000009e <.LVL80>:
  9e:	418c86b3          	sub	a3,s9,s8
  a2:	415686b3          	sub	a3,a3,s5
  a6:	00e4b733          	sltu	a4,s1,a4
  aa:	00d70ab3          	add	s5,a4,a3
  ae:	41fadb13          	srai	s6,s5,0x1f
  b2:	0164c633          	xor	a2,s1,s6
  b6:	41660633          	sub	a2,a2,s6
  ba:	07f67613          	andi	a2,a2,127
  be:	01664633          	xor	a2,a2,s6
  c2:	41660b33          	sub	s6,a2,s6

000000c6 <.LVL81>:

      if B > 0 then
  c6:	0f604263          	bgtz	s6,1aa <.L31>

000000ca <.LVL82>:
         X (0 .. B - 1) := M (Final_Block_First .. M'Last);
      end if;
      X (B) := 128;

      --  Final 9 bytes are the length of M in bits
      ML_MSB  := Byte (Shift_Right (U64'(M'Length), 61));
  ca:	00140713          	addi	a4,s0,1
  ce:	008737b3          	sltu	a5,a4,s0
  d2:	417706b3          	sub	a3,a4,s7
  d6:	97e6                	add	a5,a5,s9
  d8:	00d736b3          	sltu	a3,a4,a3
  dc:	418787b3          	sub	a5,a5,s8
      X (B) := 128;
  e0:	1298                	addi	a4,sp,352
  e2:	01670633          	add	a2,a4,s6
      ML_MSB  := Byte (Shift_Right (U64'(M'Length), 61));
  e6:	8f95                	sub	a5,a5,a3
      ML_LSBs := U64 (M'Length) * 8;
  e8:	01d4d713          	srli	a4,s1,0x1d
  ec:	003a9693          	slli	a3,s5,0x3
      X (B) := 128;
  f0:	f8000593          	li	a1,-128
      ML_LSBs := U64 (M'Length) * 8;
  f4:	8ed9                	or	a3,a3,a4
      X (B) := 128;
  f6:	f0b60023          	sb	a1,-256(a2)
      ML_MSB  := Byte (Shift_Right (U64'(M'Length), 61));
  fa:	83f5                	srli	a5,a5,0x1d

000000fc <.LVL83>:
      ML_LSBs := U64 (M'Length) * 8;
  fc:	00349713          	slli	a4,s1,0x3

00000100 <.LVL84>:
 100:	a801                	j	110 <.L27>

00000102 <.L23>:
      X (B) := 128;
 102:	f8000793          	li	a5,-128
 106:	06f10023          	sb	a5,96(sp)

0000010a <.LVL86>:
      ML_LSBs := U64 (M'Length) * 8;
 10a:	4701                	li	a4,0
      ML_MSB  := Byte (Shift_Right (U64'(M'Length), 61));
 10c:	4781                	li	a5,0
      ML_LSBs := U64 (M'Length) * 8;
 10e:	4681                	li	a3,0

00000110 <.L27>:
         X (I) := Byte (T mod 256);
 110:	01071593          	slli	a1,a4,0x10
 114:	81c1                	srli	a1,a1,0x10
 116:	00871613          	slli	a2,a4,0x8
 11a:	81a1                	srli	a1,a1,0x8
 11c:	8e4d                	or	a2,a2,a1
         T := Shift_Right (T, 8);
 11e:	01075513          	srli	a0,a4,0x10
         X (I) := Byte (T mod 256);
 122:	0186d593          	srli	a1,a3,0x18
         T := Shift_Right (T, 8);
 126:	8361                	srli	a4,a4,0x18
         X (I) := Byte (T mod 256);
 128:	00c11f23          	sh	a2,30(sp)
 12c:	00a10ea3          	sb	a0,29(sp)
 130:	00e10e23          	sb	a4,28(sp)
 134:	05a2                	slli	a1,a1,0x8
 136:	0186d713          	srli	a4,a3,0x18
 13a:	01071613          	slli	a2,a4,0x10

0000013e <.LBE964>:
      return X;
 13e:	4872                	lw	a6,28(sp)

00000140 <.LBB965>:
         X (I) := Byte (T mod 256);
 140:	8f4d                	or	a4,a4,a1
 142:	8f51                	or	a4,a4,a2
 144:	06e2                	slli	a3,a3,0x18

00000146 <.LBE962>:
      if B < 112 then
         X (119) := ML_MSB;
         X (120 .. 127) := TS64 (ML_LSBs);
         Hashblocks (H, X (0 .. 127));
 146:	00000637          	lui	a2,0x0

0000014a <.LBB966>:
         X (I) := Byte (T mod 256);
 14a:	8f55                	or	a4,a4,a3

0000014c <.LBE966>:
         Hashblocks (H, X (0 .. 127));
 14c:	108c                	addi	a1,sp,96
 14e:	00060613          	mv	a2,a2
 152:	1008                	addi	a0,sp,32
         X (119) := ML_MSB;
 154:	0cf10ba3          	sb	a5,215(sp)

00000158 <.LBB967>:
         X (I) := Byte (T mod 256);
 158:	cc3a                	sw	a4,24(sp)

0000015a <.LBE967>:
      return X;
 15a:	c83a                	sw	a4,16(sp)
 15c:	ca42                	sw	a6,20(sp)

0000015e <.LBE971>:
         X (120 .. 127) := TS64 (ML_LSBs);
 15e:	cdba                	sw	a4,216(sp)
 160:	cfc2                	sw	a6,220(sp)
         Hashblocks (H, X (0 .. 127));
 162:	00000097          	auipc	ra,0x0
 166:	000080e7          	jalr	ra # 162 <.LBE971+0x4>

0000016a <.L26>:
         X (247) := ML_MSB;
         X (248 .. 255) := TS64 (ML_LSBs);
         Hashblocks (H, X);
      end if;

      Output := H;
 16a:	100c                	addi	a1,sp,32
 16c:	854a                	mv	a0,s2
 16e:	04000613          	li	a2,64
 172:	00000097          	auipc	ra,0x0
 176:	000080e7          	jalr	ra # 172 <.L26+0x8>

0000017a <.LVL92>:
   end Hash;
 17a:	18c12083          	lw	ra,396(sp)
 17e:	18812403          	lw	s0,392(sp)
 182:	18412483          	lw	s1,388(sp)

00000186 <.LVL93>:
 186:	18012903          	lw	s2,384(sp)

0000018a <.LVL94>:
 18a:	17c12983          	lw	s3,380(sp)
 18e:	17812a03          	lw	s4,376(sp)
 192:	17412a83          	lw	s5,372(sp)
 196:	17012b03          	lw	s6,368(sp)
 19a:	16c12b83          	lw	s7,364(sp)
 19e:	16812c03          	lw	s8,360(sp)
 1a2:	16412c83          	lw	s9,356(sp)
 1a6:	6159                	addi	sp,sp,400
 1a8:	8082                	ret

000001aa <.L31>:
         Final_Block_First := (M'Last - B) + 1;
 1aa:	416405b3          	sub	a1,s0,s6
 1ae:	0585                	addi	a1,a1,1

000001b0 <.LVL96>:
         X (0 .. B - 1) := M (Final_Block_First .. M'Last);
 1b0:	413585b3          	sub	a1,a1,s3

000001b4 <.LVL97>:
 1b4:	865a                	mv	a2,s6
 1b6:	95d2                	add	a1,a1,s4
 1b8:	1088                	addi	a0,sp,96
 1ba:	00000097          	auipc	ra,0x0
 1be:	000080e7          	jalr	ra # 1ba <.LVL97+0x6>

000001c2 <.LVL98>:
      ML_MSB  := Byte (Shift_Right (U64'(M'Length), 61));
 1c2:	00140693          	addi	a3,s0,1
 1c6:	0086b7b3          	sltu	a5,a3,s0
 1ca:	41768bb3          	sub	s7,a3,s7
      X (B) := 128;
 1ce:	1298                	addi	a4,sp,352
      ML_MSB  := Byte (Shift_Right (U64'(M'Length), 61));
 1d0:	97e6                	add	a5,a5,s9
      X (B) := 128;
 1d2:	01670633          	add	a2,a4,s6
      ML_MSB  := Byte (Shift_Right (U64'(M'Length), 61));
 1d6:	0176bbb3          	sltu	s7,a3,s7
 1da:	418787b3          	sub	a5,a5,s8
      X (B) := 128;
 1de:	f8000593          	li	a1,-128
      ML_LSBs := U64 (M'Length) * 8;
 1e2:	01d4d713          	srli	a4,s1,0x1d
      ML_MSB  := Byte (Shift_Right (U64'(M'Length), 61));
 1e6:	417787b3          	sub	a5,a5,s7
      ML_LSBs := U64 (M'Length) * 8;
 1ea:	003a9693          	slli	a3,s5,0x3
      X (B) := 128;
 1ee:	f0b60023          	sb	a1,-256(a2) # ffffff00 <.LFE5+0xffffe73c>
      if B < 112 then
 1f2:	06f00613          	li	a2,111
      ML_LSBs := U64 (M'Length) * 8;
 1f6:	8ed9                	or	a3,a3,a4
      ML_MSB  := Byte (Shift_Right (U64'(M'Length), 61));
 1f8:	83f5                	srli	a5,a5,0x1d

000001fa <.LVL99>:
      ML_LSBs := U64 (M'Length) * 8;
 1fa:	00349713          	slli	a4,s1,0x3

000001fe <.LVL100>:
      if B < 112 then
 1fe:	f16659e3          	bge	a2,s6,110 <.L27>

00000202 <.LBB972>:
         X (I) := Byte (T mod 256);
 202:	01071613          	slli	a2,a4,0x10
 206:	8241                	srli	a2,a2,0x10
 208:	8221                	srli	a2,a2,0x8
 20a:	04ae                	slli	s1,s1,0xb
 20c:	8cd1                	or	s1,s1,a2
 20e:	0186d593          	srli	a1,a3,0x18
         T := Shift_Right (T, 8);
 212:	01075613          	srli	a2,a4,0x10
 216:	8361                	srli	a4,a4,0x18

00000218 <.LVL101>:
         X (I) := Byte (T mod 256);
 218:	00c10aa3          	sb	a2,21(sp)
 21c:	00e10a23          	sb	a4,20(sp)
 220:	00911b23          	sh	s1,22(sp)
 224:	0186d713          	srli	a4,a3,0x18
 228:	05a2                	slli	a1,a1,0x8

0000022a <.LBE974>:
      return X;
 22a:	4852                	lw	a6,20(sp)

0000022c <.LBB975>:
         X (I) := Byte (T mod 256);
 22c:	01071613          	slli	a2,a4,0x10
 230:	8f4d                	or	a4,a4,a1
 232:	06e2                	slli	a3,a3,0x18
 234:	8f51                	or	a4,a4,a2

00000236 <.LBE972>:
         Hashblocks (H, X);
 236:	00000637          	lui	a2,0x0

0000023a <.LBB976>:
         X (I) := Byte (T mod 256);
 23a:	8f55                	or	a4,a4,a3

0000023c <.LBE976>:
         Hashblocks (H, X);
 23c:	108c                	addi	a1,sp,96
 23e:	00060613          	mv	a2,a2
 242:	1008                	addi	a0,sp,32
         X (247) := ML_MSB;
 244:	14f10ba3          	sb	a5,343(sp)

00000248 <.LBB977>:
         X (I) := Byte (T mod 256);
 248:	c83a                	sw	a4,16(sp)

0000024a <.LBE977>:
      return X;
 24a:	cc3a                	sw	a4,24(sp)
 24c:	ce42                	sw	a6,28(sp)

0000024e <.LBE981>:
         X (248 .. 255) := TS64 (ML_LSBs);
 24e:	14e12c23          	sw	a4,344(sp)
 252:	15012e23          	sw	a6,348(sp)
         Hashblocks (H, X);
 256:	00000097          	auipc	ra,0x0
 25a:	000080e7          	jalr	ra # 256 <.LBE981+0x8>

0000025e <.LVL105>:
 25e:	b731                	j	16a <.L26>

Disassembly of section .text.sparknacl__hashing__hash__2:

00000000 <sparknacl__hashing__hash__2>:

   function Hash (M : in Byte_Seq) return Digest
   0:	715d                	addi	sp,sp,-80
   2:	c4a2                	sw	s0,72(sp)
   4:	842a                	mv	s0,a0
   is
      R : Digest;
   begin
      Hash (R, M);
   6:	850a                	mv	a0,sp
   function Hash (M : in Byte_Seq) return Digest
   8:	c686                	sw	ra,76(sp)
      Hash (R, M);
   a:	00000097          	auipc	ra,0x0
   e:	000080e7          	jalr	ra # a <sparknacl__hashing__hash__2+0xa>

00000012 <.LVL108>:
      return R;
  12:	858a                	mv	a1,sp
  14:	8522                	mv	a0,s0
  16:	04000613          	li	a2,64
  1a:	00000097          	auipc	ra,0x0
  1e:	000080e7          	jalr	ra # 1a <.LVL108+0x8>

00000022 <.LVL109>:
   end Hash;
  22:	40b6                	lw	ra,76(sp)
  24:	8522                	mv	a0,s0
  26:	4426                	lw	s0,72(sp)
  28:	6161                	addi	sp,sp,80
  2a:	8082                	ret
