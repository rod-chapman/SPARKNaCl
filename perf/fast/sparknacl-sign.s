
sparknacl-sign.o:     file format elf32-littleriscv


Disassembly of section .text.sparknacl__sign__signing_pkIP:

00000000 <sparknacl__sign__signing_pkIP>:
   0:	8082                	ret

Disassembly of section .text.sparknacl__sign__signing_skIP:

00000000 <sparknacl__sign__signing_skIP>:
   0:	8082                	ret

Disassembly of section .text.sparknacl__sign__Tgf_vector_4BIP:

00000000 <sparknacl__sign__Tgf_vector_4BIP>:
   0:	8082                	ret

Disassembly of section .text.sparknacl__sign__sanitize_gf_vector_4:

00000000 <sparknacl__sign__sanitize_gf_vector_4>:

   --============================================
   --  Local subprogram bodies
   --============================================

   procedure Sanitize_GF_Vector_4 (R : out GF_Vector_4)
   0:	1141                	addi	sp,sp,-16
   2:	c606                	sw	ra,12(sp)
   4:	c422                	sw	s0,8(sp)
   6:	842a                	mv	s0,a0

00000008 <.LBB295>:
   is
   begin
      for I in R'Range loop
         Sanitize_GF (R (I));
   8:	00000097          	auipc	ra,0x0
   c:	000080e7          	jalr	ra # 8 <.LBB295>

00000010 <.LVL1>:
  10:	08040513          	addi	a0,s0,128
  14:	00000097          	auipc	ra,0x0
  18:	000080e7          	jalr	ra # 14 <.LVL1+0x4>

0000001c <.LVL2>:
  1c:	10040513          	addi	a0,s0,256
  20:	00000097          	auipc	ra,0x0
  24:	000080e7          	jalr	ra # 20 <.LVL2+0x4>

00000028 <.LVL3>:
  28:	18040513          	addi	a0,s0,384

0000002c <.LBE295>:
      end loop;
   end Sanitize_GF_Vector_4;
  2c:	4422                	lw	s0,8(sp)

0000002e <.LVL4>:
  2e:	40b2                	lw	ra,12(sp)
  30:	0141                	addi	sp,sp,16

00000032 <.LBB296>:
         Sanitize_GF (R (I));
  32:	00000317          	auipc	t1,0x0
  36:	00030067          	jr	t1 # 32 <.LBB296>

Disassembly of section .text.sparknacl__sign__add:

00000000 <sparknacl__sign__add>:

   procedure Add (Left  : in out GF_Vector_4;
   0:	c6010113          	addi	sp,sp,-928
   4:	39212823          	sw	s2,912(sp)
                  Right : in     GF_Vector_4)
   is
      L0 : GF renames Left (0);
      L1 : GF renames Left (1);
   8:	08050913          	addi	s2,a0,128
      R1 : GF renames Right (1);
      R2 : GF renames Right (2);
      R3 : GF renames Right (3);
      A, B, C, D, E, F : GF;
   begin
      A := (L1 - L0) * (R1 - R0);
   c:	862a                	mv	a2,a0
   procedure Add (Left  : in out GF_Vector_4;
   e:	38912a23          	sw	s1,916(sp)
  12:	39512223          	sw	s5,900(sp)
  16:	84aa                	mv	s1,a0

00000018 <.LVL7>:
  18:	8aae                	mv	s5,a1

0000001a <.LVL8>:
      A := (L1 - L0) * (R1 - R0);
  1a:	0508                	addi	a0,sp,640

0000001c <.LVL9>:
  1c:	85ca                	mv	a1,s2

0000001e <.LVL10>:
   procedure Add (Left  : in out GF_Vector_4;
  1e:	38112e23          	sw	ra,924(sp)
  22:	38812c23          	sw	s0,920(sp)
  26:	39312623          	sw	s3,908(sp)
  2a:	39412423          	sw	s4,904(sp)
      R1 : GF renames Right (1);
  2e:	080a8993          	addi	s3,s5,128
      A := (L1 - L0) * (R1 - R0);
  32:	00000097          	auipc	ra,0x0
  36:	000080e7          	jalr	ra # 32 <.LVL10+0x14>

0000003a <.LVL11>:
  3a:	8656                	mv	a2,s5
  3c:	85ce                	mv	a1,s3
  3e:	0608                	addi	a0,sp,768
  40:	00000097          	auipc	ra,0x0
  44:	000080e7          	jalr	ra # 40 <.LVL11+0x6>

00000048 <.LVL12>:
  48:	0610                	addi	a2,sp,768
  4a:	050c                	addi	a1,sp,640
  4c:	850a                	mv	a0,sp
  4e:	00000097          	auipc	ra,0x0
  52:	000080e7          	jalr	ra # 4e <.LVL12+0x6>

00000056 <.LVL13>:
  56:	011c                	addi	a5,sp,128
  58:	870a                	mv	a4,sp
  5a:	843e                	mv	s0,a5
  5c:	86be                	mv	a3,a5

0000005e <.L8>:
  5e:	00072803          	lw	a6,0(a4)
  62:	4348                	lw	a0,4(a4)
  64:	470c                	lw	a1,8(a4)
  66:	4750                	lw	a2,12(a4)
  68:	0107a023          	sw	a6,0(a5)
  6c:	c3c8                	sw	a0,4(a5)
  6e:	c78c                	sw	a1,8(a5)
  70:	c7d0                	sw	a2,12(a5)
  72:	0741                	addi	a4,a4,16
  74:	07c1                	addi	a5,a5,16
  76:	fed714e3          	bne	a4,a3,5e <.L8>
      B := (L0 + L1) * (R0 + R1);
  7a:	864a                	mv	a2,s2
  7c:	85a6                	mv	a1,s1
  7e:	0508                	addi	a0,sp,640
  80:	00000097          	auipc	ra,0x0
  84:	000080e7          	jalr	ra # 80 <.L8+0x22>

00000088 <.LVL14>:
  88:	864e                	mv	a2,s3
  8a:	85d6                	mv	a1,s5
  8c:	0608                	addi	a0,sp,768
  8e:	00000097          	auipc	ra,0x0
  92:	000080e7          	jalr	ra # 8e <.LVL14+0x6>

00000096 <.LVL15>:
  96:	0610                	addi	a2,sp,768
  98:	050c                	addi	a1,sp,640
  9a:	850a                	mv	a0,sp
  9c:	00000097          	auipc	ra,0x0
  a0:	000080e7          	jalr	ra # 9c <.LVL15+0x6>

000000a4 <.LVL16>:
  a4:	878a                	mv	a5,sp
  a6:	0218                	addi	a4,sp,256

000000a8 <.L9>:
  a8:	4388                	lw	a0,0(a5)
  aa:	43cc                	lw	a1,4(a5)
  ac:	4790                	lw	a2,8(a5)
  ae:	47d4                	lw	a3,12(a5)
  b0:	c308                	sw	a0,0(a4)
  b2:	c34c                	sw	a1,4(a4)
  b4:	c710                	sw	a2,8(a4)
  b6:	c754                	sw	a3,12(a4)
  b8:	07c1                	addi	a5,a5,16
  ba:	0741                	addi	a4,a4,16
  bc:	fe8796e3          	bne	a5,s0,a8 <.L9>
      E := B - A;
  c0:	8622                	mv	a2,s0
  c2:	020c                	addi	a1,sp,256
  c4:	850a                	mv	a0,sp
  c6:	00000097          	auipc	ra,0x0
  ca:	000080e7          	jalr	ra # c6 <.L9+0x1e>

000000ce <.LVL17>:
  ce:	878a                	mv	a5,sp
  d0:	0418                	addi	a4,sp,512

000000d2 <.L10>:
  d2:	4388                	lw	a0,0(a5)
  d4:	43cc                	lw	a1,4(a5)
  d6:	4790                	lw	a2,8(a5)
  d8:	47d4                	lw	a3,12(a5)
  da:	c308                	sw	a0,0(a4)
  dc:	c34c                	sw	a1,4(a4)
  de:	c710                	sw	a2,8(a4)
  e0:	c754                	sw	a3,12(a4)
  e2:	07c1                	addi	a5,a5,16
  e4:	0741                	addi	a4,a4,16
  e6:	fe8796e3          	bne	a5,s0,d2 <.L10>
      F := B + A;
  ea:	8622                	mv	a2,s0
  ec:	020c                	addi	a1,sp,256
  ee:	850a                	mv	a0,sp
  f0:	00000097          	auipc	ra,0x0
  f4:	000080e7          	jalr	ra # f0 <.L10+0x1e>

000000f8 <.LVL18>:
  f8:	878a                	mv	a5,sp
  fa:	0518                	addi	a4,sp,640

000000fc <.L11>:
  fc:	4388                	lw	a0,0(a5)
  fe:	43cc                	lw	a1,4(a5)
 100:	4790                	lw	a2,8(a5)
 102:	47d4                	lw	a3,12(a5)
 104:	c308                	sw	a0,0(a4)
 106:	c34c                	sw	a1,4(a4)
 108:	c710                	sw	a2,8(a4)
 10a:	c754                	sw	a3,12(a4)
 10c:	07c1                	addi	a5,a5,16
 10e:	0741                	addi	a4,a4,16
 110:	fe8796e3          	bne	a5,s0,fc <.L11>
      L3 : GF renames Left (3);
 114:	18048993          	addi	s3,s1,384

00000118 <.LVL19>:

      --  We are now done with A and B, so these variables can now
      --  be re-used. This saves yet more stack.
      C := (L3 * R3) * GF_D2;
 118:	180a8613          	addi	a2,s5,384
 11c:	85ce                	mv	a1,s3
 11e:	0608                	addi	a0,sp,768
 120:	00000097          	auipc	ra,0x0
 124:	000080e7          	jalr	ra # 120 <.LVL19+0x8>

00000128 <.LVL20>:
 128:	00000637          	lui	a2,0x0
 12c:	00060613          	mv	a2,a2
 130:	060c                	addi	a1,sp,768
 132:	850a                	mv	a0,sp
 134:	00000097          	auipc	ra,0x0
 138:	000080e7          	jalr	ra # 134 <.LVL20+0xc>

0000013c <.LVL21>:
 13c:	878a                	mv	a5,sp
 13e:	0318                	addi	a4,sp,384

00000140 <.L12>:
 140:	4388                	lw	a0,0(a5)
 142:	43cc                	lw	a1,4(a5)
 144:	4790                	lw	a2,8(a5)
 146:	47d4                	lw	a3,12(a5)
 148:	c308                	sw	a0,0(a4)
 14a:	c34c                	sw	a1,4(a4)
 14c:	c710                	sw	a2,8(a4)
 14e:	c754                	sw	a3,12(a4)
 150:	07c1                	addi	a5,a5,16
 152:	0741                	addi	a4,a4,16
 154:	fe8796e3          	bne	a5,s0,140 <.L12>
      L2 : GF renames Left (2);
 158:	10048a13          	addi	s4,s1,256
      D := L2 * R2;
 15c:	100a8613          	addi	a2,s5,256
 160:	85d2                	mv	a1,s4
 162:	850a                	mv	a0,sp
 164:	00000097          	auipc	ra,0x0
 168:	000080e7          	jalr	ra # 164 <.L12+0x24>

0000016c <.LVL22>:
 16c:	878a                	mv	a5,sp
 16e:	0618                	addi	a4,sp,768

00000170 <.L13>:
 170:	4388                	lw	a0,0(a5)
 172:	43cc                	lw	a1,4(a5)
 174:	4790                	lw	a2,8(a5)
 176:	47d4                	lw	a3,12(a5)
 178:	c308                	sw	a0,0(a4)
 17a:	c34c                	sw	a1,4(a4)
 17c:	c710                	sw	a2,8(a4)
 17e:	c754                	sw	a3,12(a4)
 180:	07c1                	addi	a5,a5,16
 182:	0741                	addi	a4,a4,16
 184:	fe8796e3          	bne	a5,s0,170 <.L13>
      D := D + D;
 188:	0610                	addi	a2,sp,768
 18a:	85b2                	mv	a1,a2
 18c:	850a                	mv	a0,sp
 18e:	00000097          	auipc	ra,0x0
 192:	000080e7          	jalr	ra # 18e <.L13+0x1e>

00000196 <.LVL23>:
 196:	878a                	mv	a5,sp
 198:	0618                	addi	a4,sp,768

0000019a <.L14>:
 19a:	4388                	lw	a0,0(a5)
 19c:	43cc                	lw	a1,4(a5)
 19e:	4790                	lw	a2,8(a5)
 1a0:	47d4                	lw	a3,12(a5)
 1a2:	c308                	sw	a0,0(a4)
 1a4:	c34c                	sw	a1,4(a4)
 1a6:	c710                	sw	a2,8(a4)
 1a8:	c754                	sw	a3,12(a4)
 1aa:	07c1                	addi	a5,a5,16
 1ac:	0741                	addi	a4,a4,16
 1ae:	fe8796e3          	bne	a5,s0,19a <.L14>
      A := D - C;
 1b2:	0310                	addi	a2,sp,384
 1b4:	060c                	addi	a1,sp,768
 1b6:	850a                	mv	a0,sp
 1b8:	00000097          	auipc	ra,0x0
 1bc:	000080e7          	jalr	ra # 1b8 <.L14+0x1e>

000001c0 <.LVL24>:
 1c0:	878a                	mv	a5,sp
 1c2:	8722                	mv	a4,s0

000001c4 <.L15>:
 1c4:	4388                	lw	a0,0(a5)
 1c6:	43cc                	lw	a1,4(a5)
 1c8:	4790                	lw	a2,8(a5)
 1ca:	47d4                	lw	a3,12(a5)
 1cc:	c308                	sw	a0,0(a4)
 1ce:	c34c                	sw	a1,4(a4)
 1d0:	c710                	sw	a2,8(a4)
 1d2:	c754                	sw	a3,12(a4)
 1d4:	07c1                	addi	a5,a5,16
 1d6:	0741                	addi	a4,a4,16
 1d8:	fe8796e3          	bne	a5,s0,1c4 <.L15>
      B := D + C;
 1dc:	0310                	addi	a2,sp,384
 1de:	060c                	addi	a1,sp,768
 1e0:	850a                	mv	a0,sp
 1e2:	00000097          	auipc	ra,0x0
 1e6:	000080e7          	jalr	ra # 1e2 <.L15+0x1e>

000001ea <.LVL25>:
 1ea:	878a                	mv	a5,sp
 1ec:	0218                	addi	a4,sp,256

000001ee <.L16>:
 1ee:	4388                	lw	a0,0(a5)
 1f0:	43cc                	lw	a1,4(a5)
 1f2:	4790                	lw	a2,8(a5)
 1f4:	47d4                	lw	a3,12(a5)
 1f6:	c308                	sw	a0,0(a4)
 1f8:	c34c                	sw	a1,4(a4)
 1fa:	c710                	sw	a2,8(a4)
 1fc:	c754                	sw	a3,12(a4)
 1fe:	07c1                	addi	a5,a5,16
 200:	0741                	addi	a4,a4,16
 202:	fe8796e3          	bne	a5,s0,1ee <.L16>

      --  Assign to Left element-by-element to avoid extra
      --  temporary and copy needed by an aggregate assignment.
      L0 := E * A;
 206:	8622                	mv	a2,s0
 208:	040c                	addi	a1,sp,512
 20a:	850a                	mv	a0,sp
 20c:	00000097          	auipc	ra,0x0
 210:	000080e7          	jalr	ra # 20c <.L16+0x1e>

00000214 <.LVL26>:
 214:	878a                	mv	a5,sp

00000216 <.L17>:
 216:	438c                	lw	a1,0(a5)
 218:	43d0                	lw	a2,4(a5)
 21a:	4794                	lw	a3,8(a5)
 21c:	47d8                	lw	a4,12(a5)
 21e:	c08c                	sw	a1,0(s1)
 220:	c0d0                	sw	a2,4(s1)
 222:	c494                	sw	a3,8(s1)
 224:	c4d8                	sw	a4,12(s1)
 226:	07c1                	addi	a5,a5,16
 228:	04c1                	addi	s1,s1,16
 22a:	fe8796e3          	bne	a5,s0,216 <.L17>
      L1 := F * B;
 22e:	0210                	addi	a2,sp,256
 230:	050c                	addi	a1,sp,640
 232:	850a                	mv	a0,sp
 234:	00000097          	auipc	ra,0x0
 238:	000080e7          	jalr	ra # 234 <.L17+0x1e>

0000023c <.LVL28>:
 23c:	878a                	mv	a5,sp
 23e:	864a                	mv	a2,s2

00000240 <.L18>:
 240:	4388                	lw	a0,0(a5)
 242:	43cc                	lw	a1,4(a5)
 244:	4794                	lw	a3,8(a5)
 246:	47d8                	lw	a4,12(a5)
 248:	c208                	sw	a0,0(a2)
 24a:	c24c                	sw	a1,4(a2)
 24c:	c614                	sw	a3,8(a2)
 24e:	c658                	sw	a4,12(a2)
 250:	07c1                	addi	a5,a5,16
 252:	0641                	addi	a2,a2,16
 254:	fe8796e3          	bne	a5,s0,240 <.L18>
      L2 := B * A;
 258:	020c                	addi	a1,sp,256
 25a:	8622                	mv	a2,s0
 25c:	850a                	mv	a0,sp
 25e:	00000097          	auipc	ra,0x0
 262:	000080e7          	jalr	ra # 25e <.L18+0x1e>

00000266 <.LVL29>:
 266:	878a                	mv	a5,sp
 268:	85d2                	mv	a1,s4

0000026a <.L19>:
 26a:	4388                	lw	a0,0(a5)
 26c:	43d0                	lw	a2,4(a5)
 26e:	4794                	lw	a3,8(a5)
 270:	47d8                	lw	a4,12(a5)
 272:	c188                	sw	a0,0(a1)
 274:	c1d0                	sw	a2,4(a1)
 276:	c594                	sw	a3,8(a1)
 278:	c5d8                	sw	a4,12(a1)
 27a:	07c1                	addi	a5,a5,16
 27c:	05c1                	addi	a1,a1,16
 27e:	fe8796e3          	bne	a5,s0,26a <.L19>
      L3 := E * F;
 282:	040c                	addi	a1,sp,512
 284:	0510                	addi	a2,sp,640
 286:	850a                	mv	a0,sp
 288:	00000097          	auipc	ra,0x0
 28c:	000080e7          	jalr	ra # 288 <.L19+0x1e>

00000290 <.LVL30>:
 290:	878a                	mv	a5,sp
 292:	85ce                	mv	a1,s3

00000294 <.L20>:
 294:	4388                	lw	a0,0(a5)
 296:	43d0                	lw	a2,4(a5)
 298:	4794                	lw	a3,8(a5)
 29a:	47d8                	lw	a4,12(a5)
 29c:	c188                	sw	a0,0(a1)
 29e:	c1d0                	sw	a2,4(a1)
 2a0:	c594                	sw	a3,8(a1)
 2a2:	c5d8                	sw	a4,12(a1)
 2a4:	07c1                	addi	a5,a5,16
 2a6:	05c1                	addi	a1,a1,16
 2a8:	fe8796e3          	bne	a5,s0,294 <.L20>
   end Add;
 2ac:	39c12083          	lw	ra,924(sp)
 2b0:	39812403          	lw	s0,920(sp)
 2b4:	39412483          	lw	s1,916(sp)
 2b8:	39012903          	lw	s2,912(sp)

000002bc <.LVL31>:
 2bc:	38c12983          	lw	s3,908(sp)

000002c0 <.LVL32>:
 2c0:	38812a03          	lw	s4,904(sp)

000002c4 <.LVL33>:
 2c4:	38412a83          	lw	s5,900(sp)

000002c8 <.LVL34>:
 2c8:	3a010113          	addi	sp,sp,928
 2cc:	8082                	ret

Disassembly of section .text.sparknacl__sign__double:

00000000 <sparknacl__sign__double>:

   procedure Double (P : in out GF_Vector_4)
   0:	df010113          	addi	sp,sp,-528
   4:	20112623          	sw	ra,524(sp)
   is
      --  Ada's anti-aliasing rules require an extra copy here.
      T : constant GF_Vector_4 := P;
   8:	87aa                	mv	a5,a0
   a:	870a                	mv	a4,sp
   c:	20050693          	addi	a3,a0,512

00000010 <.L36>:
  10:	0007a883          	lw	a7,0(a5)
  14:	0047a803          	lw	a6,4(a5)
  18:	478c                	lw	a1,8(a5)
  1a:	47d0                	lw	a2,12(a5)
  1c:	01172023          	sw	a7,0(a4)
  20:	01072223          	sw	a6,4(a4)
  24:	c70c                	sw	a1,8(a4)
  26:	c750                	sw	a2,12(a4)
  28:	07c1                	addi	a5,a5,16
  2a:	0741                	addi	a4,a4,16
  2c:	fed792e3          	bne	a5,a3,10 <.L36>
   begin
      Add (P, T);
  30:	858a                	mv	a1,sp
  32:	00000097          	auipc	ra,0x0
  36:	000080e7          	jalr	ra # 32 <.L36+0x22>

0000003a <.LVL36>:
   end Double;
  3a:	20c12083          	lw	ra,524(sp)
  3e:	21010113          	addi	sp,sp,528
  42:	8082                	ret

Disassembly of section .text.sparknacl__sign__scalarmult:

00000000 <sparknacl__sign__scalarmult>:

   function Scalarmult (Q : in GF_Vector_4;
   0:	9e010113          	addi	sp,sp,-1568
   4:	60812c23          	sw	s0,1560(sp)
   8:	61412423          	sw	s4,1544(sp)
   c:	842e                	mv	s0,a1
   e:	61512223          	sw	s5,1540(sp)
  12:	8a32                	mv	s4,a2
  14:	8aaa                	mv	s5,a0
         for I in Index_4 loop
            Utils.CSwap (P (I), Q (I), Swap);
         end loop;
      end CSwap;
   begin
      LP := (0 => GF_0,
  16:	20000613          	li	a2,512

0000001a <.LVL38>:
  1a:	4581                	li	a1,0

0000001c <.LVL39>:
  1c:	850a                	mv	a0,sp
   function Scalarmult (Q : in GF_Vector_4;
  1e:	60912a23          	sw	s1,1556(sp)
  22:	60112e23          	sw	ra,1564(sp)
  26:	61212823          	sw	s2,1552(sp)
  2a:	61312623          	sw	s3,1548(sp)
  2e:	61612023          	sw	s6,1536(sp)
      LP := (0 => GF_0,
  32:	00000097          	auipc	ra,0x0
  36:	000080e7          	jalr	ra # 32 <.LVL39+0x16>

0000003a <.LVL41>:
  3a:	4605                	li	a2,1
  3c:	4681                	li	a3,0
             1 => GF_1,
             2 => GF_1,
             3 => GF_0);
      LQ := Q;
  3e:	0404                	addi	s1,sp,512
  40:	87a2                	mv	a5,s0
      LP := (0 => GF_0,
  42:	c132                	sw	a2,128(sp)
  44:	c336                	sw	a3,132(sp)
  46:	10c12023          	sw	a2,256(sp)
  4a:	10d12223          	sw	a3,260(sp)
      LQ := Q;
  4e:	8726                	mv	a4,s1
  50:	20040813          	addi	a6,s0,512

00000054 <.L40>:
  54:	4388                	lw	a0,0(a5)
  56:	43cc                	lw	a1,4(a5)
  58:	4790                	lw	a2,8(a5)
  5a:	47d4                	lw	a3,12(a5)
  5c:	c308                	sw	a0,0(a4)
  5e:	c34c                	sw	a1,4(a4)
  60:	c710                	sw	a2,8(a4)
  62:	c754                	sw	a3,12(a4)
  64:	07c1                	addi	a5,a5,16
  66:	0741                	addi	a4,a4,16
  68:	ff0796e3          	bne	a5,a6,54 <.L40>

0000006c <.LVL42>:
  6c:	01fa0993          	addi	s3,s4,31

00000070 <.L43>:

      --  For each byte of S, starting at the MSB
      for I in reverse Index_32 loop
         CB := S (I);
  70:	0009c903          	lbu	s2,0(s3)

00000074 <.LBB313>:
         --  For each bit of CB, starting with bit 7 (the MSB)
         for J in reverse Natural range 0 .. 7 loop
  74:	4b21                	li	s6,8

00000076 <.L42>:
  76:	1b7d                	addi	s6,s6,-1
            Swap := Boolean'Val (Shift_Right (CB, J) mod 2);
  78:	01695433          	srl	s0,s2,s6
  7c:	8805                	andi	s0,s0,1

0000007e <.LBB314>:
            Utils.CSwap (P (I), Q (I), Swap);
  7e:	8622                	mv	a2,s0
  80:	85a6                	mv	a1,s1
  82:	850a                	mv	a0,sp
  84:	00000097          	auipc	ra,0x0
  88:	000080e7          	jalr	ra # 84 <.LBB314+0x6>

0000008c <.LVL48>:
  8c:	8622                	mv	a2,s0
  8e:	050c                	addi	a1,sp,640
  90:	0108                	addi	a0,sp,128
  92:	00000097          	auipc	ra,0x0
  96:	000080e7          	jalr	ra # 92 <.LVL48+0x6>

0000009a <.LVL49>:
  9a:	8622                	mv	a2,s0
  9c:	060c                	addi	a1,sp,768
  9e:	0208                	addi	a0,sp,256
  a0:	00000097          	auipc	ra,0x0
  a4:	000080e7          	jalr	ra # a0 <.LVL49+0x6>

000000a8 <.LVL50>:
  a8:	8622                	mv	a2,s0
  aa:	070c                	addi	a1,sp,896
  ac:	0308                	addi	a0,sp,384
  ae:	00000097          	auipc	ra,0x0
  b2:	000080e7          	jalr	ra # ae <.LVL50+0x6>

000000b6 <.LBE314>:

            CSwap (LP, LQ, Swap);
            Add (LQ, LP);
  b6:	858a                	mv	a1,sp
  b8:	8526                	mv	a0,s1
  ba:	00000097          	auipc	ra,0x0
  be:	000080e7          	jalr	ra # ba <.LBE314+0x4>

000000c2 <.LBB316>:
      T : constant GF_Vector_4 := P;
  c2:	878a                	mv	a5,sp
  c4:	40010713          	addi	a4,sp,1024

000000c8 <.L41>:
  c8:	4388                	lw	a0,0(a5)
  ca:	43cc                	lw	a1,4(a5)
  cc:	4790                	lw	a2,8(a5)
  ce:	47d4                	lw	a3,12(a5)
  d0:	c308                	sw	a0,0(a4)
  d2:	c34c                	sw	a1,4(a4)
  d4:	c710                	sw	a2,8(a4)
  d6:	c754                	sw	a3,12(a4)
  d8:	07c1                	addi	a5,a5,16
  da:	0741                	addi	a4,a4,16
  dc:	fe9796e3          	bne	a5,s1,c8 <.L41>
      Add (P, T);
  e0:	40010593          	addi	a1,sp,1024
  e4:	850a                	mv	a0,sp
  e6:	00000097          	auipc	ra,0x0
  ea:	000080e7          	jalr	ra # e6 <.L41+0x1e>

000000ee <.LBB318>:
            Utils.CSwap (P (I), Q (I), Swap);
  ee:	8622                	mv	a2,s0
  f0:	85a6                	mv	a1,s1
  f2:	850a                	mv	a0,sp
  f4:	00000097          	auipc	ra,0x0
  f8:	000080e7          	jalr	ra # f4 <.LBB318+0x6>

000000fc <.LVL54>:
  fc:	8622                	mv	a2,s0
  fe:	050c                	addi	a1,sp,640
 100:	0108                	addi	a0,sp,128
 102:	00000097          	auipc	ra,0x0
 106:	000080e7          	jalr	ra # 102 <.LVL54+0x6>

0000010a <.LVL55>:
 10a:	8622                	mv	a2,s0
 10c:	060c                	addi	a1,sp,768
 10e:	0208                	addi	a0,sp,256
 110:	00000097          	auipc	ra,0x0
 114:	000080e7          	jalr	ra # 110 <.LVL55+0x6>

00000118 <.LVL56>:
 118:	8622                	mv	a2,s0
 11a:	070c                	addi	a1,sp,896
 11c:	0308                	addi	a0,sp,384
 11e:	00000097          	auipc	ra,0x0
 122:	000080e7          	jalr	ra # 11e <.LVL56+0x6>

00000126 <.LBE318>:
         for J in reverse Natural range 0 .. 7 loop
 126:	f40b18e3          	bnez	s6,76 <.L42>

0000012a <.LBE312>:
      for I in reverse Index_32 loop
 12a:	fff98793          	addi	a5,s3,-1
 12e:	013a0463          	beq	s4,s3,136 <.L51>
 132:	89be                	mv	s3,a5

00000134 <.LVL58>:
 134:	bf35                	j	70 <.L43>

00000136 <.L51>:
            Double (LP);
            CSwap (LP, LQ, Swap);
         end loop;
      end loop;

      return LP;
 136:	878a                	mv	a5,sp
 138:	8756                	mv	a4,s5

0000013a <.L44>:
 13a:	4388                	lw	a0,0(a5)
 13c:	43cc                	lw	a1,4(a5)
 13e:	4790                	lw	a2,8(a5)
 140:	47d4                	lw	a3,12(a5)
 142:	c308                	sw	a0,0(a4)
 144:	c34c                	sw	a1,4(a4)
 146:	c710                	sw	a2,8(a4)
 148:	c754                	sw	a3,12(a4)
 14a:	07c1                	addi	a5,a5,16
 14c:	0741                	addi	a4,a4,16
 14e:	fe9796e3          	bne	a5,s1,13a <.L44>
   end Scalarmult;
 152:	61c12083          	lw	ra,1564(sp)
 156:	61812403          	lw	s0,1560(sp)

0000015a <.LVL60>:
 15a:	61412483          	lw	s1,1556(sp)
 15e:	61012903          	lw	s2,1552(sp)

00000162 <.LVL61>:
 162:	60c12983          	lw	s3,1548(sp)

00000166 <.LVL62>:
 166:	60812a03          	lw	s4,1544(sp)

0000016a <.LVL63>:
 16a:	60012b03          	lw	s6,1536(sp)

0000016e <.LVL64>:
 16e:	8556                	mv	a0,s5
 170:	60412a83          	lw	s5,1540(sp)
 174:	62010113          	addi	sp,sp,1568
 178:	8082                	ret

Disassembly of section .text.sparknacl__sign__scalarbase:

00000000 <sparknacl__sign__scalarbase>:

   function Scalarbase (S : in Bytes_32) return GF_Vector_4
   0:	862e                	mv	a2,a1
   is
   begin
      return Scalarmult (Scalarbase_Q, S);
   2:	000005b7          	lui	a1,0x0

00000006 <.LVL67>:
   function Scalarbase (S : in Bytes_32) return GF_Vector_4
   6:	1141                	addi	sp,sp,-16
      return Scalarmult (Scalarbase_Q, S);
   8:	00058593          	mv	a1,a1
   function Scalarbase (S : in Bytes_32) return GF_Vector_4
   c:	c422                	sw	s0,8(sp)
   e:	c606                	sw	ra,12(sp)
  10:	842a                	mv	s0,a0
      return Scalarmult (Scalarbase_Q, S);
  12:	00000097          	auipc	ra,0x0
  16:	000080e7          	jalr	ra # 12 <.LVL67+0xc>

0000001a <.LVL68>:
   end Scalarbase;
  1a:	40b2                	lw	ra,12(sp)
  1c:	8522                	mv	a0,s0
  1e:	4422                	lw	s0,8(sp)
  20:	0141                	addi	sp,sp,16
  22:	8082                	ret

Disassembly of section .text.sparknacl__sign__par_25519:

00000000 <sparknacl__sign__par_25519>:

   function Par_25519 (A : in Normal_GF) return Bit
   0:	7179                	addi	sp,sp,-48
   2:	85aa                	mv	a1,a0
   is
      D : Bytes_32;
   begin
      D := Utils.Pack_25519 (A);
   4:	850a                	mv	a0,sp

00000006 <.LVL71>:
   function Par_25519 (A : in Normal_GF) return Bit
   6:	d606                	sw	ra,44(sp)
      D := Utils.Pack_25519 (A);
   8:	00000097          	auipc	ra,0x0
   c:	000080e7          	jalr	ra # 8 <.LVL71+0x2>

00000010 <.LVL72>:
      return (D (0) mod 2);
  10:	00014503          	lbu	a0,0(sp)
   end Par_25519;
  14:	50b2                	lw	ra,44(sp)
  16:	8905                	andi	a0,a0,1
  18:	6145                	addi	sp,sp,48
  1a:	8082                	ret

Disassembly of section .text.sparknacl__sign__pack:

00000000 <sparknacl__sign__pack>:

   function Pack (P : in GF_Vector_4) return Bytes_32
   0:	dd010113          	addi	sp,sp,-560
   4:	22812423          	sw	s0,552(sp)
   8:	22912223          	sw	s1,548(sp)
   c:	842a                	mv	s0,a0
   e:	84ae                	mv	s1,a1
   is
      TX, TY, ZI : Normal_GF;
      R : Bytes_32;
   begin
      ZI := Utils.Inv_25519 (P (2));
  10:	850a                	mv	a0,sp

00000012 <.LVL74>:
  12:	10058593          	addi	a1,a1,256 # 100 <.L180>

00000016 <.LVL75>:
   function Pack (P : in GF_Vector_4) return Bytes_32
  16:	23212023          	sw	s2,544(sp)
  1a:	22112623          	sw	ra,556(sp)
      ZI := Utils.Inv_25519 (P (2));
  1e:	00000097          	auipc	ra,0x0
  22:	000080e7          	jalr	ra # 1e <.LVL75+0x8>

00000026 <.LVL76>:
  26:	08010913          	addi	s2,sp,128
  2a:	878a                	mv	a5,sp
  2c:	1318                	addi	a4,sp,416

0000002e <.L57>:
  2e:	4388                	lw	a0,0(a5)
  30:	43cc                	lw	a1,4(a5)
  32:	4790                	lw	a2,8(a5)
  34:	47d4                	lw	a3,12(a5)
  36:	c308                	sw	a0,0(a4)
  38:	c34c                	sw	a1,4(a4)
  3a:	c710                	sw	a2,8(a4)
  3c:	c754                	sw	a3,12(a4)
  3e:	07c1                	addi	a5,a5,16
  40:	0741                	addi	a4,a4,16
  42:	fef916e3          	bne	s2,a5,2e <.L57>
      TX := P (0) * ZI;
  46:	1310                	addi	a2,sp,416
  48:	85a6                	mv	a1,s1
  4a:	850a                	mv	a0,sp
  4c:	00000097          	auipc	ra,0x0
  50:	000080e7          	jalr	ra # 4c <.L57+0x1e>

00000054 <.LVL77>:
  54:	878a                	mv	a5,sp
  56:	1118                	addi	a4,sp,160

00000058 <.L58>:
  58:	4388                	lw	a0,0(a5)
  5a:	43cc                	lw	a1,4(a5)
  5c:	4790                	lw	a2,8(a5)
  5e:	47d4                	lw	a3,12(a5)
  60:	c308                	sw	a0,0(a4)
  62:	c34c                	sw	a1,4(a4)
  64:	c710                	sw	a2,8(a4)
  66:	c754                	sw	a3,12(a4)
  68:	07c1                	addi	a5,a5,16
  6a:	0741                	addi	a4,a4,16
  6c:	fef916e3          	bne	s2,a5,58 <.L58>
      TY := P (1) * ZI;
  70:	1310                	addi	a2,sp,416
  72:	08048593          	addi	a1,s1,128
  76:	850a                	mv	a0,sp
  78:	00000097          	auipc	ra,0x0
  7c:	000080e7          	jalr	ra # 78 <.L58+0x20>

00000080 <.LVL78>:
  80:	878a                	mv	a5,sp
  82:	1218                	addi	a4,sp,288

00000084 <.L59>:
  84:	4388                	lw	a0,0(a5)
  86:	43cc                	lw	a1,4(a5)
  88:	4790                	lw	a2,8(a5)
  8a:	47d4                	lw	a3,12(a5)
  8c:	c308                	sw	a0,0(a4)
  8e:	c34c                	sw	a1,4(a4)
  90:	c710                	sw	a2,8(a4)
  92:	c754                	sw	a3,12(a4)
  94:	07c1                	addi	a5,a5,16
  96:	0741                	addi	a4,a4,16
  98:	fef916e3          	bne	s2,a5,84 <.L59>
      R := Utils.Pack_25519 (TY);
  9c:	120c                	addi	a1,sp,288
  9e:	8522                	mv	a0,s0
  a0:	00000097          	auipc	ra,0x0
  a4:	000080e7          	jalr	ra # a0 <.L59+0x1c>

000000a8 <.LBB320>:
      D := Utils.Pack_25519 (A);
  a8:	854a                	mv	a0,s2
  aa:	110c                	addi	a1,sp,160

000000ac <.LBE320>:
      R (31) := R (31) xor (Par_25519 (TX) * 128);
  ac:	01f44483          	lbu	s1,31(s0)

000000b0 <.LBB324>:
      D := Utils.Pack_25519 (A);
  b0:	00000097          	auipc	ra,0x0
  b4:	000080e7          	jalr	ra # b0 <.LBB324>

000000b8 <.LVL81>:
      return (D (0) mod 2);
  b8:	08014783          	lbu	a5,128(sp)

000000bc <.LBE324>:
      return R;
   end Pack;
  bc:	22c12083          	lw	ra,556(sp)
  c0:	8522                	mv	a0,s0

000000c2 <.LBB325>:
      return (D (0) mod 2);
  c2:	8b85                	andi	a5,a5,1

000000c4 <.LBE325>:
      R (31) := R (31) xor (Par_25519 (TX) * 128);
  c4:	079e                	slli	a5,a5,0x7
  c6:	8fa5                	xor	a5,a5,s1
  c8:	00f40fa3          	sb	a5,31(s0)
   end Pack;
  cc:	22812403          	lw	s0,552(sp)

000000d0 <.LVL83>:
  d0:	22412483          	lw	s1,548(sp)
  d4:	22012903          	lw	s2,544(sp)
  d8:	23010113          	addi	sp,sp,560
  dc:	8082                	ret

Disassembly of section .text.sparknacl__sign__Tl_tableBIP:

00000000 <sparknacl__sign__Tl_tableBIP>:
   0:	8082                	ret

Disassembly of section .text.sparknacl__sign__modl:

00000000 <sparknacl__sign__modl>:
                            16#00#, 16#00#, 16#00#, 16#00#,
                            16#00#, 16#00#, 16#00#, 16#00#,
                            16#00#, 16#00#, 16#00#, 16#00#,
                            16#00#, 16#00#, 16#00#, 16#10#);

   function ModL (X : in I64_Seq_64) return Bytes_32
       0:	d5010113          	addi	sp,sp,-688
       4:	87aa                	mv	a5,a0
       6:	20000613          	li	a2,512
       a:	1888                	addi	a0,sp,112
       c:	2a112623          	sw	ra,684(sp)
      10:	2a812423          	sw	s0,680(sp)
      14:	2a912223          	sw	s1,676(sp)
      18:	2b212023          	sw	s2,672(sp)
      1c:	29312e23          	sw	s3,668(sp)
      20:	29412c23          	sw	s4,664(sp)
      24:	29512a23          	sw	s5,660(sp)
      28:	29612823          	sw	s6,656(sp)
      2c:	29712623          	sw	s7,652(sp)
      30:	29812423          	sw	s8,648(sp)
      34:	29912223          	sw	s9,644(sp)
      38:	29a12023          	sw	s10,640(sp)
      3c:	27b12e23          	sw	s11,636(sp)
      40:	c03e                	sw	a5,0(sp)
      42:	00000097          	auipc	ra,0x0
      46:	000080e7          	jalr	ra # 42 <sparknacl__sign__modl+0x42>

0000004a <.LVL87>:
      4a:	26812783          	lw	a5,616(sp)
      4e:	26c12703          	lw	a4,620(sp)

00000052 <.LBB370>:
         --  In this implementation, though, we choose to loop over the
         --  first 16 elements of L first, since these are all non-zero,
         --  and manually unroll the final 4 iterations where L (16)
         --  through L (19) are all zero.
         for J in I32 range 31 .. 46 loop
            Adjustment := (16 * L (J - 31)) * XL (63);
      52:	6685                	lui	a3,0x1
      54:	ed068613          	addi	a2,a3,-304 # ed0 <.LBE670>
      58:	02c70d33          	mul	s10,a4,a2
            XL (J) := XL (J) + Carry - Adjustment;
      5c:	16812583          	lw	a1,360(sp)
            Adjustment := (16 * L (J - 31)) * XL (63);
      60:	00379f13          	slli	t5,a5,0x3
      64:	01d7d393          	srli	t2,a5,0x1d
      68:	00371313          	slli	t1,a4,0x3
      6c:	00ff02b3          	add	t0,t5,a5
      70:	0063e333          	or	t1,t2,t1
      74:	d3068513          	addi	a0,a3,-720
      78:	01e2bf33          	sltu	t5,t0,t5
      7c:	f5068893          	addi	a7,a3,-176
      80:	02c784b3          	mul	s1,a5,a2
      84:	01b2d393          	srli	t2,t0,0x1b
      88:	5c000c93          	li	s9,1472
      8c:	1a000b13          	li	s6,416
      90:	63000a93          	li	s5,1584
      94:	58000a13          	li	s4,1408
      98:	d6068993          	addi	s3,a3,-672
      9c:	02c7b633          	mulhu	a2,a5,a2
            XL (J) := XL (J) + Carry - Adjustment;
      a0:	409584b3          	sub	s1,a1,s1
            Carry := ASR_8 (XL (J) + 128);
      a4:	08048e13          	addi	t3,s1,128
            XL (J) := XL (J) + Carry - Adjustment;
      a8:	0095b5b3          	sltu	a1,a1,s1
            Carry := ASR_8 (XL (J) + 128);
      ac:	009e3fb3          	sltu	t6,t3,s1

000000b0 <.LBB373>:

   --  returns equivalent of X >> 8 in C, doing an arithmetic
   --  shift right when X is negative, assuming 2's complement
   --  representation
   function ASR_8 (X : in I64) return I64
   is (To_I64 (Shift_Right_Arithmetic (To_U64 (X), 8)))
      b0:	008e5e13          	srli	t3,t3,0x8

000000b4 <.LBE373>:
            Adjustment := (16 * L (J - 31)) * XL (63);
      b4:	966a                	add	a2,a2,s10
            XL (J) := XL (J) + Carry - Adjustment;
      b6:	16c12d03          	lw	s10,364(sp)
            Adjustment := (16 * L (J - 31)) * XL (63);
      ba:	02a70eb3          	mul	t4,a4,a0
            XL (J) := XL (J) + Carry - Adjustment;
      be:	40cd0d33          	sub	s10,s10,a2
      c2:	40bd0d33          	sub	s10,s10,a1
            Carry := ASR_8 (XL (J) + 128);
      c6:	9fea                	add	t6,t6,s10

000000c8 <.LBB416>:
      c8:	018f9613          	slli	a2,t6,0x18
      cc:	01c66e33          	or	t3,a2,t3

000000d0 <.LBE416>:
            XL (J) := XL (J) + Carry - Adjustment;
      d0:	17412603          	lw	a2,372(sp)

000000d4 <.LBB417>:
      d4:	408fd813          	srai	a6,t6,0x8

000000d8 <.LBE417>:
      d8:	17012583          	lw	a1,368(sp)
      dc:	9832                	add	a6,a6,a2

000000de <.LVL91>:
            Adjustment := (16 * L (J - 31)) * XL (63);
      de:	00e30633          	add	a2,t1,a4
      e2:	02a78433          	mul	s0,a5,a0
      e6:	9f32                	add	t5,t5,a2
            XL (J) := XL (J) + Carry - Adjustment;
      e8:	95f2                	add	a1,a1,t3
      ea:	01c5bbb3          	sltu	s7,a1,t3
      ee:	9bc2                	add	s7,s7,a6
            Adjustment := (16 * L (J - 31)) * XL (63);
      f0:	0f16                	slli	t5,t5,0x5
      f2:	01e3ef33          	or	t5,t2,t5
            XL (J) := XL (J) - (Carry * 256);
      f6:	f00fff93          	andi	t6,t6,-256
      fa:	018e5393          	srli	t2,t3,0x18
      fe:	01f3efb3          	or	t6,t2,t6
            Adjustment := (16 * L (J - 31)) * XL (63);
     102:	02a7b633          	mulhu	a2,a5,a0
     106:	00529513          	slli	a0,t0,0x5
            XL (J) := XL (J) + Carry - Adjustment;
     10a:	40858433          	sub	s0,a1,s0
            Carry := ASR_8 (XL (J) + 128);
     10e:	08040313          	addi	t1,s0,128
            XL (J) := XL (J) + Carry - Adjustment;
     112:	0085b5b3          	sltu	a1,a1,s0
            Carry := ASR_8 (XL (J) + 128);
     116:	00833833          	sltu	a6,t1,s0

0000011a <.LBB418>:
     11a:	00835313          	srli	t1,t1,0x8

0000011e <.LBE418>:
            Adjustment := (16 * L (J - 31)) * XL (63);
     11e:	c42a                	sw	a0,8(sp)
            XL (J) := XL (J) - (Carry * 256);
     120:	0e22                	slli	t3,t3,0x8
     122:	41c48e33          	sub	t3,s1,t3
            Adjustment := (16 * L (J - 31)) * XL (63);
     126:	031702b3          	mul	t0,a4,a7
     12a:	9676                	add	a2,a2,t4
            XL (J) := XL (J) + Carry - Adjustment;
     12c:	40cb8bb3          	sub	s7,s7,a2
     130:	40bb8bb3          	sub	s7,s7,a1
            Carry := ASR_8 (XL (J) + 128);
     134:	985e                	add	a6,a6,s7
            XL (J) := XL (J) + Carry - Adjustment;
     136:	17812583          	lw	a1,376(sp)
     13a:	17c12e83          	lw	t4,380(sp)

0000013e <.LBB419>:
     13e:	01881613          	slli	a2,a6,0x18
     142:	00666333          	or	t1,a2,t1

00000146 <.LBE419>:
     146:	959a                	add	a1,a1,t1
            Adjustment := (16 * L (J - 31)) * XL (63);
     148:	031780b3          	mul	ra,a5,a7

0000014c <.LBB420>:
     14c:	40885613          	srai	a2,a6,0x8

00000150 <.LBE420>:
            XL (J) := XL (J) + Carry - Adjustment;
     150:	0065b533          	sltu	a0,a1,t1
     154:	9676                	add	a2,a2,t4
     156:	9532                	add	a0,a0,a2
            XL (J) := XL (J) - (Carry * 256);
     158:	01835d93          	srli	s11,t1,0x18
     15c:	f0087813          	andi	a6,a6,-256
     160:	010de833          	or	a6,s11,a6
     164:	410b8833          	sub	a6,s7,a6
            XL (J) := XL (J) + Carry - Adjustment;
     168:	18c12d83          	lw	s11,396(sp)
            Adjustment := (16 * L (J - 31)) * XL (63);
     16c:	0317b8b3          	mulhu	a7,a5,a7
            XL (J) := XL (J) + Carry - Adjustment;
     170:	401580b3          	sub	ra,a1,ra
            Carry := ASR_8 (XL (J) + 128);
     174:	08008613          	addi	a2,ra,128
            XL (J) := XL (J) + Carry - Adjustment;
     178:	0015b5b3          	sltu	a1,a1,ra
            Carry := ASR_8 (XL (J) + 128);
     17c:	00163eb3          	sltu	t4,a2,ra

00000180 <.LBB421>:
     180:	8221                	srli	a2,a2,0x8

00000182 <.LBE421>:
            XL (J) := XL (J) - (Carry * 256);
     182:	01c4b4b3          	sltu	s1,s1,t3
     186:	41fd0fb3          	sub	t6,s10,t6
     18a:	409f8fb3          	sub	t6,t6,s1
     18e:	0322                	slli	t1,t1,0x8
            Adjustment := (16 * L (J - 31)) * XL (63);
     190:	02ec8c33          	mul	s8,s9,a4
     194:	9896                	add	a7,a7,t0
            XL (J) := XL (J) + Carry - Adjustment;
     196:	41150533          	sub	a0,a0,a7
     19a:	40b50933          	sub	s2,a0,a1
            Carry := ASR_8 (XL (J) + 128);
     19e:	9eca                	add	t4,t4,s2
            XL (J) := XL (J) + Carry - Adjustment;
     1a0:	18012503          	lw	a0,384(sp)
     1a4:	18412883          	lw	a7,388(sp)

000001a8 <.LBB422>:
     1a8:	018e9593          	slli	a1,t4,0x18
     1ac:	8e4d                	or	a2,a2,a1

000001ae <.LBE422>:
     1ae:	9532                	add	a0,a0,a2
            Adjustment := (16 * L (J - 31)) * XL (63);
     1b0:	02fc83b3          	mul	t2,s9,a5

000001b4 <.LBB423>:
     1b4:	408ed593          	srai	a1,t4,0x8

000001b8 <.LBE423>:
            XL (J) := XL (J) + Carry - Adjustment;
     1b8:	00c532b3          	sltu	t0,a0,a2
     1bc:	95c6                	add	a1,a1,a7
     1be:	92ae                	add	t0,t0,a1
            XL (J) := XL (J) - (Carry * 256);
     1c0:	01865593          	srli	a1,a2,0x18
     1c4:	0622                	slli	a2,a2,0x8
     1c6:	40c088b3          	sub	a7,ra,a2
     1ca:	f00efe93          	andi	t4,t4,-256
     1ce:	01d5eeb3          	or	t4,a1,t4
            Adjustment := (16 * L (J - 31)) * XL (63);
     1d2:	02fcbcb3          	mulhu	s9,s9,a5
            XL (J) := XL (J) + Carry - Adjustment;
     1d6:	407503b3          	sub	t2,a0,t2
     1da:	00753633          	sltu	a2,a0,t2
            Carry := ASR_8 (XL (J) + 128);
     1de:	08038593          	addi	a1,t2,128
     1e2:	0075b533          	sltu	a0,a1,t2

000001e6 <.LBB424>:
     1e6:	81a1                	srli	a1,a1,0x8

000001e8 <.LBE424>:
            XL (J) := XL (J) - (Carry * 256);
     1e8:	41d90eb3          	sub	t4,s2,t4
     1ec:	40640333          	sub	t1,s0,t1
     1f0:	0110b0b3          	sltu	ra,ra,a7
     1f4:	00643433          	sltu	s0,s0,t1
            Adjustment := (16 * L (J - 31)) * XL (63);
     1f8:	9ce2                	add	s9,s9,s8
            XL (J) := XL (J) + Carry - Adjustment;
     1fa:	419282b3          	sub	t0,t0,s9
     1fe:	40c28cb3          	sub	s9,t0,a2
            Adjustment := (16 * L (J - 31)) * XL (63);
     202:	02eb0bb3          	mul	s7,s6,a4
            Carry := ASR_8 (XL (J) + 128);
     206:	9566                	add	a0,a0,s9
            XL (J) := XL (J) + Carry - Adjustment;
     208:	18812c03          	lw	s8,392(sp)

0000020c <.LBB425>:
     20c:	01851613          	slli	a2,a0,0x18
     210:	8dd1                	or	a1,a1,a2

00000212 <.LBE425>:
     212:	9c2e                	add	s8,s8,a1

00000214 <.LBB426>:
     214:	40855613          	srai	a2,a0,0x8

00000218 <.LBE426>:
     218:	00bc3d33          	sltu	s10,s8,a1
     21c:	966e                	add	a2,a2,s11
     21e:	9d32                	add	s10,s10,a2
            Adjustment := (16 * L (J - 31)) * XL (63);
     220:	02fb02b3          	mul	t0,s6,a5
            XL (J) := XL (J) - (Carry * 256);
     224:	0185d613          	srli	a2,a1,0x18
     228:	f0057513          	andi	a0,a0,-256
     22c:	8d51                	or	a0,a0,a2
     22e:	401e80b3          	sub	ra,t4,ra
     232:	40ac8533          	sub	a0,s9,a0
     236:	40880833          	sub	a6,a6,s0
            XL (J) := XL (J) + Carry - Adjustment;
     23a:	19412c83          	lw	s9,404(sp)
            XL (J) := XL (J) - (Carry * 256);
     23e:	17c12423          	sw	t3,360(sp)
     242:	05a2                	slli	a1,a1,0x8
            Adjustment := (16 * L (J - 31)) * XL (63);
     244:	02fb3b33          	mulhu	s6,s6,a5
            XL (J) := XL (J) + Carry - Adjustment;
     248:	405c02b3          	sub	t0,s8,t0
            Carry := ASR_8 (XL (J) + 128);
     24c:	08028613          	addi	a2,t0,128
            XL (J) := XL (J) + Carry - Adjustment;
     250:	005c3c33          	sltu	s8,s8,t0
            Carry := ASR_8 (XL (J) + 128);
     254:	00563db3          	sltu	s11,a2,t0

00000258 <.LBB427>:
     258:	8221                	srli	a2,a2,0x8

0000025a <.LBE427>:
            XL (J) := XL (J) - (Carry * 256);
     25a:	40b385b3          	sub	a1,t2,a1
     25e:	00b3b3b3          	sltu	t2,t2,a1
     262:	17f12623          	sw	t6,364(sp)
     266:	16612823          	sw	t1,368(sp)
            Adjustment := (16 * L (J - 31)) * XL (63);
     26a:	02ea84b3          	mul	s1,s5,a4
     26e:	9b5e                	add	s6,s6,s7
            XL (J) := XL (J) + Carry - Adjustment;
     270:	416d0d33          	sub	s10,s10,s6
     274:	418d0c33          	sub	s8,s10,s8
            Carry := ASR_8 (XL (J) + 128);
     278:	018d8eb3          	add	t4,s11,s8
            XL (J) := XL (J) + Carry - Adjustment;
     27c:	19012b03          	lw	s6,400(sp)

00000280 <.LBB428>:
     280:	018e9413          	slli	s0,t4,0x18
     284:	8e41                	or	a2,a2,s0

00000286 <.LBE428>:
     286:	9b32                	add	s6,s6,a2

00000288 <.LBB429>:
     288:	408ed413          	srai	s0,t4,0x8

0000028c <.LBE429>:
            Adjustment := (16 * L (J - 31)) * XL (63);
     28c:	02fa8933          	mul	s2,s5,a5
            XL (J) := XL (J) + Carry - Adjustment;
     290:	00cb3bb3          	sltu	s7,s6,a2
     294:	9466                	add	s0,s0,s9
            XL (J) := XL (J) - (Carry * 256);
     296:	f00efe93          	andi	t4,t4,-256
     29a:	01865c93          	srli	s9,a2,0x18
            XL (J) := XL (J) + Carry - Adjustment;
     29e:	9ba2                	add	s7,s7,s0
            XL (J) := XL (J) - (Carry * 256);
     2a0:	01dceeb3          	or	t4,s9,t4
     2a4:	0622                	slli	a2,a2,0x8
     2a6:	40c28433          	sub	s0,t0,a2
     2aa:	41dc0633          	sub	a2,s8,t4
            Adjustment := (16 * L (J - 31)) * XL (63);
     2ae:	02fabab3          	mulhu	s5,s5,a5
            XL (J) := XL (J) + Carry - Adjustment;
     2b2:	412b0933          	sub	s2,s6,s2
            Carry := ASR_8 (XL (J) + 128);
     2b6:	08090e93          	addi	t4,s2,128
            XL (J) := XL (J) + Carry - Adjustment;
     2ba:	012b3b33          	sltu	s6,s6,s2
            Carry := ASR_8 (XL (J) + 128);
     2be:	012ebc33          	sltu	s8,t4,s2
            XL (J) := XL (J) - (Carry * 256);
     2c2:	40750cb3          	sub	s9,a0,t2
     2c6:	0082b2b3          	sltu	t0,t0,s0

000002ca <.LVL97>:
            XL (J) := XL (J) + Carry - Adjustment;
     2ca:	19c12383          	lw	t2,412(sp)
            XL (J) := XL (J) - (Carry * 256);
     2ce:	405602b3          	sub	t0,a2,t0
            XL (J) := XL (J) + Carry - Adjustment;
     2d2:	19812503          	lw	a0,408(sp)
            Adjustment := (16 * L (J - 31)) * XL (63);
     2d6:	01548e33          	add	t3,s1,s5
            XL (J) := XL (J) + Carry - Adjustment;
     2da:	41cb8e33          	sub	t3,s7,t3
     2de:	416e0e33          	sub	t3,t3,s6
            Carry := ASR_8 (XL (J) + 128);
     2e2:	01cc04b3          	add	s1,s8,t3

000002e6 <.LBB430>:
     2e6:	01849613          	slli	a2,s1,0x18
     2ea:	008ede93          	srli	t4,t4,0x8
     2ee:	01d66eb3          	or	t4,a2,t4
     2f2:	4084d613          	srai	a2,s1,0x8

000002f6 <.LBE430>:
            XL (J) := XL (J) + Carry - Adjustment;
     2f6:	961e                	add	a2,a2,t2
     2f8:	43a2                	lw	t2,8(sp)
     2fa:	9576                	add	a0,a0,t4
            Adjustment := (16 * L (J - 31)) * XL (63);
     2fc:	02ea0bb3          	mul	s7,s4,a4
            XL (J) := XL (J) + Carry - Adjustment;
     300:	01d53fb3          	sltu	t6,a0,t4
     304:	40750ab3          	sub	s5,a0,t2
     308:	9fb2                	add	t6,t6,a2
     30a:	41ef8f33          	sub	t5,t6,t5
            Carry := ASR_8 (XL (J) + 128);
     30e:	080a8613          	addi	a2,s5,128
            XL (J) := XL (J) + Carry - Adjustment;
     312:	01553533          	sltu	a0,a0,s5
     316:	40af0533          	sub	a0,t5,a0
            Carry := ASR_8 (XL (J) + 128);
     31a:	015633b3          	sltu	t2,a2,s5
     31e:	93aa                	add	t2,t2,a0
            Adjustment := (16 * L (J - 31)) * XL (63);
     320:	02fa0d33          	mul	s10,s4,a5

00000324 <.LBB431>:
     324:	01839f13          	slli	t5,t2,0x18

00000328 <.LBE431>:
            XL (J) := XL (J) + Carry - Adjustment;
     328:	1a012b03          	lw	s6,416(sp)

0000032c <.LBB432>:
     32c:	8221                	srli	a2,a2,0x8
     32e:	00cf6633          	or	a2,t5,a2

00000332 <.LBE432>:
     332:	1a412f03          	lw	t5,420(sp)
     336:	9b32                	add	s6,s6,a2

00000338 <.LBB433>:
     338:	4083dc13          	srai	s8,t2,0x8

0000033c <.LBE433>:
     33c:	00cb3fb3          	sltu	t6,s6,a2
     340:	9f62                	add	t5,t5,s8
            Adjustment := (16 * L (J - 31)) * XL (63);
     342:	02fa3a33          	mulhu	s4,s4,a5
            XL (J) := XL (J) + Carry - Adjustment;
     346:	01ef8c33          	add	s8,t6,t5
            XL (J) := XL (J) - (Carry * 256);
     34a:	c266                	sw	s9,4(sp)
            XL (J) := XL (J) + Carry - Adjustment;
     34c:	41ab0cb3          	sub	s9,s6,s10
            Carry := ASR_8 (XL (J) + 128);
     350:	080c8f93          	addi	t6,s9,128
            XL (J) := XL (J) + Carry - Adjustment;
     354:	019b3b33          	sltu	s6,s6,s9
            XL (J) := XL (J) - (Carry * 256);
     358:	018edd13          	srli	s10,t4,0x18
     35c:	f004f493          	andi	s1,s1,-256
     360:	0ea2                	slli	t4,t4,0x8
            Carry := ASR_8 (XL (J) + 128);
     362:	019fbf33          	sltu	t5,t6,s9
            Adjustment := (16 * L (J - 31)) * XL (63);
     366:	9a5e                	add	s4,s4,s7
            XL (J) := XL (J) + Carry - Adjustment;
     368:	414c0a33          	sub	s4,s8,s4
     36c:	416a0a33          	sub	s4,s4,s6
            XL (J) := XL (J) - (Carry * 256);
     370:	41d90eb3          	sub	t4,s2,t4
     374:	009d64b3          	or	s1,s10,s1
            Adjustment := (16 * L (J - 31)) * XL (63);
     378:	03370b33          	mul	s6,a4,s3
            Carry := ASR_8 (XL (J) + 128);
     37c:	9f52                	add	t5,t5,s4
            XL (J) := XL (J) - (Carry * 256);
     37e:	409e04b3          	sub	s1,t3,s1
            Carry := ASR_8 (XL (J) + 128);
     382:	c452                	sw	s4,8(sp)
            XL (J) := XL (J) - (Carry * 256);
     384:	01d93933          	sltu	s2,s2,t4

00000388 <.LBB434>:
     388:	008fda13          	srli	s4,t6,0x8

0000038c <.LBE434>:
     38c:	41248933          	sub	s2,s1,s2
     390:	4492                	lw	s1,4(sp)
     392:	01865d93          	srli	s11,a2,0x18
     396:	0622                	slli	a2,a2,0x8
            Adjustment := (16 * L (J - 31)) * XL (63);
     398:	03378fb3          	mul	t6,a5,s3
            XL (J) := XL (J) - (Carry * 256);
     39c:	40ca8633          	sub	a2,s5,a2
     3a0:	17012a23          	sw	a6,372(sp)
     3a4:	17112c23          	sw	a7,376(sp)
     3a8:	16112e23          	sw	ra,380(sp)
     3ac:	18b12023          	sw	a1,384(sp)
     3b0:	18912223          	sw	s1,388(sp)
     3b4:	18812423          	sw	s0,392(sp)
     3b8:	18512623          	sw	t0,396(sp)
     3bc:	00cabab3          	sltu	s5,s5,a2
            Adjustment := (16 * L (J - 31)) * XL (63);
     3c0:	0337b9b3          	mulhu	s3,a5,s3
            XL (J) := XL (J) - (Carry * 256);
     3c4:	18c12c23          	sw	a2,408(sp)
            XL (J) := XL (J) + Carry - Adjustment;
     3c8:	1a812603          	lw	a2,424(sp)
     3cc:	1ac12303          	lw	t1,428(sp)

000003d0 <.LBB435>:
     3d0:	018f1b93          	slli	s7,t5,0x18

000003d4 <.LBE435>:
            XL (J) := XL (J) - (Carry * 256);
     3d4:	f003f393          	andi	t2,t2,-256

000003d8 <.LBB436>:
     3d8:	014bea33          	or	s4,s7,s4

000003dc <.LBE436>:
     3dc:	007de3b3          	or	t2,s11,t2
            XL (J) := XL (J) + Carry - Adjustment;
     3e0:	9652                	add	a2,a2,s4
            XL (J) := XL (J) - (Carry * 256);
     3e2:	407503b3          	sub	t2,a0,t2

000003e6 <.LBB437>:
     3e6:	408f5893          	srai	a7,t5,0x8

000003ea <.LBE437>:
     3ea:	008a1513          	slli	a0,s4,0x8
            Adjustment := (16 * L (J - 31)) * XL (63);
     3ee:	9c068813          	addi	a6,a3,-1600
            XL (J) := XL (J) - (Carry * 256);
     3f2:	40ac8533          	sub	a0,s9,a0
            XL (J) := XL (J) + Carry - Adjustment;
     3f6:	014635b3          	sltu	a1,a2,s4
     3fa:	989a                	add	a7,a7,t1
     3fc:	41f60e33          	sub	t3,a2,t6
            Adjustment := (16 * L (J - 31)) * XL (63);
     400:	0307b2b3          	mulhu	t0,a5,a6
            XL (J) := XL (J) + Carry - Adjustment;
     404:	95c6                	add	a1,a1,a7
            XL (J) := XL (J) - (Carry * 256);
     406:	c0aa                	sw	a0,64(sp)
     408:	1aa12023          	sw	a0,416(sp)
            Adjustment := (16 * L (J - 31)) * XL (63);
     40c:	99da                	add	s3,s3,s6
            Carry := ASR_8 (XL (J) + 128);
     40e:	080e0893          	addi	a7,t3,128
            XL (J) := XL (J) + Carry - Adjustment;
     412:	413589b3          	sub	s3,a1,s3
     416:	01c63633          	sltu	a2,a2,t3
     41a:	40c98633          	sub	a2,s3,a2
            Carry := ASR_8 (XL (J) + 128);
     41e:	01c8b9b3          	sltu	s3,a7,t3
            Adjustment := (16 * L (J - 31)) * XL (63);
     422:	03070533          	mul	a0,a4,a6
            Carry := ASR_8 (XL (J) + 128);
     426:	99b2                	add	s3,s3,a2
     428:	c632                	sw	a2,12(sp)

0000042a <.LBB438>:
     42a:	0088d893          	srli	a7,a7,0x8
     42e:	01899613          	slli	a2,s3,0x18
     432:	011668b3          	or	a7,a2,a7

00000436 <.LBE438>:
            XL (J) := XL (J) + Carry - Adjustment;
     436:	1b012603          	lw	a2,432(sp)
            XL (J) := XL (J) - (Carry * 256);
     43a:	19d12823          	sw	t4,400(sp)

0000043e <.LBB439>:
     43e:	4089de93          	srai	t4,s3,0x8

00000442 <.LBE439>:
            XL (J) := XL (J) + Carry - Adjustment;
     442:	9646                	add	a2,a2,a7
            Adjustment := (16 * L (J - 31)) * XL (63);
     444:	03078333          	mul	t1,a5,a6
            XL (J) := XL (J) + Carry - Adjustment;
     448:	1b412803          	lw	a6,436(sp)
            Adjustment := (16 * L (J - 31)) * XL (63);
     44c:	f7068f93          	addi	t6,a3,-144
            XL (J) := XL (J) + Carry - Adjustment;
     450:	011635b3          	sltu	a1,a2,a7
     454:	9ec2                	add	t4,t4,a6
            Adjustment := (16 * L (J - 31)) * XL (63);
     456:	9516                	add	a0,a0,t0
            XL (J) := XL (J) + Carry - Adjustment;
     458:	95f6                	add	a1,a1,t4
     45a:	8d89                	sub	a1,a1,a0
            XL (J) := XL (J) - (Carry * 256);
     45c:	19212a23          	sw	s2,404(sp)

00000460 <.LVL99>:
     460:	41538ab3          	sub	s5,t2,s5
            XL (J) := XL (J) + Carry - Adjustment;
     464:	40660333          	sub	t1,a2,t1
            Adjustment := (16 * L (J - 31)) * XL (63);
     468:	03f70eb3          	mul	t4,a4,t6
            Carry := ASR_8 (XL (J) + 128);
     46c:	08030813          	addi	a6,t1,128
            XL (J) := XL (J) + Carry - Adjustment;
     470:	00663633          	sltu	a2,a2,t1
     474:	40c58433          	sub	s0,a1,a2
            Carry := ASR_8 (XL (J) + 128);
     478:	00683933          	sltu	s2,a6,t1
     47c:	9922                	add	s2,s2,s0

0000047e <.LBB440>:
     47e:	01891613          	slli	a2,s2,0x18
     482:	00885813          	srli	a6,a6,0x8
     486:	01066833          	or	a6,a2,a6

0000048a <.LBE440>:
            XL (J) := XL (J) + Carry - Adjustment;
     48a:	1b812603          	lw	a2,440(sp)
            Adjustment := (16 * L (J - 31)) * XL (63);
     48e:	03f782b3          	mul	t0,a5,t6
            XL (J) := XL (J) + Carry - Adjustment;
     492:	1bc12383          	lw	t2,444(sp)
     496:	9642                	add	a2,a2,a6

00000498 <.LBB441>:
     498:	40895593          	srai	a1,s2,0x8

0000049c <.LBE441>:
     49c:	01063533          	sltu	a0,a2,a6
     4a0:	959e                	add	a1,a1,t2
            Adjustment := (16 * L (J - 31)) * XL (63);
     4a2:	a2068093          	addi	ra,a3,-1504
            XL (J) := XL (J) + Carry - Adjustment;
     4a6:	95aa                	add	a1,a1,a0
            Adjustment := (16 * L (J - 31)) * XL (63);
     4a8:	f9068393          	addi	t2,a3,-112
     4ac:	de068c13          	addi	s8,a3,-544
     4b0:	03f7bfb3          	mulhu	t6,a5,t6
            XL (J) := XL (J) + Carry - Adjustment;
     4b4:	405602b3          	sub	t0,a2,t0
            Carry := ASR_8 (XL (J) + 128);
     4b8:	08028513          	addi	a0,t0,128
            XL (J) := XL (J) + Carry - Adjustment;
     4bc:	00563633          	sltu	a2,a2,t0
            Carry := ASR_8 (XL (J) + 128);
     4c0:	005534b3          	sltu	s1,a0,t0

000004c4 <.LBB442>:
     4c4:	8121                	srli	a0,a0,0x8

000004c6 <.LBE442>:
            XL (J) := XL (J) - (Carry * 256);
     4c6:	19512e23          	sw	s5,412(sp)

000004ca <.LVL100>:
            Adjustment := (16 * L (J - 31)) * XL (63);
     4ca:	00271d13          	slli	s10,a4,0x2
     4ce:	01e7da93          	srli	s5,a5,0x1e
     4d2:	01aaed33          	or	s10,s5,s10
     4d6:	9ff6                	add	t6,t6,t4
     4d8:	02170bb3          	mul	s7,a4,ra
            XL (J) := XL (J) + Carry - Adjustment;
     4dc:	41f585b3          	sub	a1,a1,t6
     4e0:	40c586b3          	sub	a3,a1,a2
            Carry := ASR_8 (XL (J) + 128);
     4e4:	94b6                	add	s1,s1,a3
     4e6:	ce36                	sw	a3,28(sp)

000004e8 <.LBB443>:
     4e8:	01849693          	slli	a3,s1,0x18
     4ec:	8d55                	or	a0,a0,a3

000004ee <.LBE443>:
            XL (J) := XL (J) + Carry - Adjustment;
     4ee:	1c012683          	lw	a3,448(sp)
     4f2:	1c412583          	lw	a1,452(sp)

000004f6 <.LBB444>:
     4f6:	4084d613          	srai	a2,s1,0x8

000004fa <.LBE444>:
            Adjustment := (16 * L (J - 31)) * XL (63);
     4fa:	02178fb3          	mul	t6,a5,ra
            XL (J) := XL (J) + Carry - Adjustment;
     4fe:	96aa                	add	a3,a3,a0
     500:	00a6beb3          	sltu	t4,a3,a0
     504:	962e                	add	a2,a2,a1
     506:	9eb2                	add	t4,t4,a2
            Adjustment := (16 * L (J - 31)) * XL (63);
     508:	9d3a                	add	s10,s10,a4
            Carry := ASR_8 (XL (J) + 128);
     50a:	ca22                	sw	s0,20(sp)
            Adjustment := (16 * L (J - 31)) * XL (63);
     50c:	00279593          	slli	a1,a5,0x2
     510:	00f58b33          	add	s6,a1,a5
     514:	00bb35b3          	sltu	a1,s6,a1
     518:	0217b0b3          	mulhu	ra,a5,ra
            XL (J) := XL (J) + Carry - Adjustment;
     51c:	41f68fb3          	sub	t6,a3,t6
     520:	01f6b6b3          	sltu	a3,a3,t6
            Carry := ASR_8 (XL (J) + 128);
     524:	080f8613          	addi	a2,t6,128
     528:	01f63433          	sltu	s0,a2,t6

0000052c <.LBB445>:
     52c:	8221                	srli	a2,a2,0x8

0000052e <.LBE445>:
            Adjustment := (16 * L (J - 31)) * XL (63);
     52e:	95ea                	add	a1,a1,s10
     530:	059a                	slli	a1,a1,0x6
     532:	01ab5d13          	srli	s10,s6,0x1a
     536:	00bd65b3          	or	a1,s10,a1
     53a:	90de                	add	ra,ra,s7
            XL (J) := XL (J) + Carry - Adjustment;
     53c:	401e80b3          	sub	ra,t4,ra
     540:	40d08eb3          	sub	t4,ra,a3
            Adjustment := (16 * L (J - 31)) * XL (63);
     544:	038700b3          	mul	ra,a4,s8
            Carry := ASR_8 (XL (J) + 128);
     548:	01d40ab3          	add	s5,s0,t4

0000054c <.LBB446>:
     54c:	018a9693          	slli	a3,s5,0x18

00000550 <.LBE446>:
     550:	d276                	sw	t4,36(sp)
            XL (J) := XL (J) + Carry - Adjustment;
     552:	1c812e83          	lw	t4,456(sp)

00000556 <.LBB447>:
     556:	8e55                	or	a2,a2,a3

00000558 <.LBE447>:
     558:	1cc12683          	lw	a3,460(sp)
     55c:	9eb2                	add	t4,t4,a2

0000055e <.LBB448>:
     55e:	408adb93          	srai	s7,s5,0x8

00000562 <.LBE448>:
     562:	00ceb433          	sltu	s0,t4,a2
            Adjustment := (16 * L (J - 31)) * XL (63);
     566:	02770733          	mul	a4,a4,t2
     56a:	cc06                	sw	ra,24(sp)
            XL (J) := XL (J) + Carry - Adjustment;
     56c:	96de                	add	a3,a3,s7
     56e:	00d40bb3          	add	s7,s0,a3
            XL (J) := XL (J) - (Carry * 256);
     572:	018a5d13          	srli	s10,s4,0x18
     576:	c26a                	sw	s10,4(sp)
     578:	0188dd13          	srli	s10,a7,0x18
     57c:	08a2                	slli	a7,a7,0x8
     57e:	c2c6                	sw	a7,68(sp)
     580:	c86a                	sw	s10,16(sp)
            Adjustment := (16 * L (J - 31)) * XL (63);
     582:	03878db3          	mul	s11,a5,s8
     586:	da3a                	sw	a4,52(sp)
     588:	4762                	lw	a4,24(sp)
            XL (J) := XL (J) - (Carry * 256);
     58a:	00851d13          	slli	s10,a0,0x8
            Adjustment := (16 * L (J - 31)) * XL (63);
     58e:	0b1a                	slli	s6,s6,0x6
            XL (J) := XL (J) - (Carry * 256);
     590:	f00f7f13          	andi	t5,t5,-256
     594:	f009f993          	andi	s3,s3,-256
     598:	f0097913          	andi	s2,s2,-256
     59c:	f004f493          	andi	s1,s1,-256
            Adjustment := (16 * L (J - 31)) * XL (63);
     5a0:	0387bc33          	mulhu	s8,a5,s8
            XL (J) := XL (J) + Carry - Adjustment;
     5a4:	41be80b3          	sub	ra,t4,s11
            Carry := ASR_8 (XL (J) + 128);
     5a8:	08008693          	addi	a3,ra,128
            XL (J) := XL (J) + Carry - Adjustment;
     5ac:	001ebeb3          	sltu	t4,t4,ra
            Carry := ASR_8 (XL (J) + 128);
     5b0:	0016b433          	sltu	s0,a3,ra

000005b4 <.LBB449>:
     5b4:	82a1                	srli	a3,a3,0x8

000005b6 <.LBE449>:
            Adjustment := (16 * L (J - 31)) * XL (63);
     5b6:	01870a33          	add	s4,a4,s8
            XL (J) := XL (J) + Carry - Adjustment;
     5ba:	414b8bb3          	sub	s7,s7,s4
     5be:	41db8733          	sub	a4,s7,t4
            Carry := ASR_8 (XL (J) + 128);
     5c2:	00e40bb3          	add	s7,s0,a4
            Adjustment := (16 * L (J - 31)) * XL (63);
     5c6:	027788b3          	mul	a7,a5,t2
            XL (J) := XL (J) + Carry - Adjustment;
     5ca:	1d412c03          	lw	s8,468(sp)
            Carry := ASR_8 (XL (J) + 128);
     5ce:	d63a                	sw	a4,44(sp)

000005d0 <.LBB450>:
     5d0:	018b9713          	slli	a4,s7,0x18
     5d4:	8ed9                	or	a3,a3,a4
     5d6:	408bd713          	srai	a4,s7,0x8

000005da <.LBE450>:
            XL (J) := XL (J) + Carry - Adjustment;
     5da:	9762                	add	a4,a4,s8
            XL (J) := XL (J) - (Carry * 256);
     5dc:	01885c13          	srli	s8,a6,0x18
     5e0:	0822                	slli	a6,a6,0x8
     5e2:	c4c2                	sw	a6,72(sp)
            Adjustment := (16 * L (J - 31)) * XL (63);
     5e4:	0277b7b3          	mulhu	a5,a5,t2
            XL (J) := XL (J) - (Carry * 256);
     5e8:	01855813          	srli	a6,a0,0x18
     5ec:	00861393          	slli	t2,a2,0x8
            XL (J) := XL (J) + Carry - Adjustment;
     5f0:	1d012403          	lw	s0,464(sp)
            XL (J) := XL (J) - (Carry * 256);
     5f4:	cc62                	sw	s8,24(sp)
     5f6:	d042                	sw	a6,32(sp)
     5f8:	01865c13          	srli	s8,a2,0x18
     5fc:	d462                	sw	s8,40(sp)
     5fe:	c69e                	sw	t2,76(sp)
     600:	0186d393          	srli	t2,a3,0x18
     604:	d81e                	sw	t2,48(sp)
            Adjustment := (16 * L (J - 31)) * XL (63);
     606:	53d2                	lw	t2,52(sp)
            XL (J) := XL (J) + Carry - Adjustment;
     608:	9436                	add	s0,s0,a3
     60a:	00d43eb3          	sltu	t4,s0,a3
     60e:	411408b3          	sub	a7,s0,a7
     612:	9eba                	add	t4,t4,a4
            Adjustment := (16 * L (J - 31)) * XL (63);
     614:	979e                	add	a5,a5,t2
            XL (J) := XL (J) + Carry - Adjustment;
     616:	01143833          	sltu	a6,s0,a7
            Carry := ASR_8 (XL (J) + 128);
     61a:	08088713          	addi	a4,a7,128
            XL (J) := XL (J) + Carry - Adjustment;
     61e:	40fe87b3          	sub	a5,t4,a5
            Carry := ASR_8 (XL (J) + 128);
     622:	01173533          	sltu	a0,a4,a7
            XL (J) := XL (J) + Carry - Adjustment;
     626:	410787b3          	sub	a5,a5,a6
            Carry := ASR_8 (XL (J) + 128);
     62a:	00f50633          	add	a2,a0,a5
     62e:	da3e                	sw	a5,52(sp)
            XL (J) := XL (J) + Carry - Adjustment;
     630:	1d812503          	lw	a0,472(sp)

00000634 <.LBB451>:
     634:	01861793          	slli	a5,a2,0x18
     638:	8321                	srli	a4,a4,0x8
     63a:	8f5d                	or	a4,a4,a5

0000063c <.LBE451>:
     63c:	1dc12783          	lw	a5,476(sp)
     640:	953a                	add	a0,a0,a4

00000642 <.LBB452>:
     642:	40865e93          	srai	t4,a2,0x8

00000646 <.LBE452>:
     646:	00e53833          	sltu	a6,a0,a4
     64a:	97f6                	add	a5,a5,t4
     64c:	983e                	add	a6,a6,a5
     64e:	41b50eb3          	sub	t4,a0,s11
            Carry := ASR_8 (XL (J) + 128);
     652:	080e8793          	addi	a5,t4,128
            XL (J) := XL (J) + Carry - Adjustment;
     656:	01d53533          	sltu	a0,a0,t4
     65a:	41480833          	sub	a6,a6,s4
     65e:	40a80833          	sub	a6,a6,a0
            Carry := ASR_8 (XL (J) + 128);
     662:	01d7b3b3          	sltu	t2,a5,t4
     666:	93c2                	add	t2,t2,a6

00000668 <.LBB453>:
     668:	01839513          	slli	a0,t2,0x18
     66c:	83a1                	srli	a5,a5,0x8
     66e:	8fc9                	or	a5,a5,a0

00000670 <.LBE453>:
            XL (J) := XL (J) + Carry - Adjustment;
     670:	1e012503          	lw	a0,480(sp)
     674:	1e412a03          	lw	s4,484(sp)
            Carry := ASR_8 (XL (J) + 128);
     678:	dc42                	sw	a6,56(sp)
            XL (J) := XL (J) + Carry - Adjustment;
     67a:	953e                	add	a0,a0,a5

0000067c <.LBB454>:
     67c:	4083d813          	srai	a6,t2,0x8

00000680 <.LBE454>:
            XL (J) := XL (J) - (Carry * 256);
     680:	f00af413          	andi	s0,s5,-256
            XL (J) := XL (J) + Carry - Adjustment;
     684:	9a42                	add	s4,s4,a6
     686:	00f53ab3          	sltu	s5,a0,a5
     68a:	41650833          	sub	a6,a0,s6
     68e:	9a56                	add	s4,s4,s5
     690:	01053533          	sltu	a0,a0,a6
            Carry := ASR_8 (XL (J) + 128);
     694:	08080a93          	addi	s5,a6,128
            XL (J) := XL (J) + Carry - Adjustment;
     698:	40ba0a33          	sub	s4,s4,a1
     69c:	40aa0b33          	sub	s6,s4,a0
            Carry := ASR_8 (XL (J) + 128);
     6a0:	010ab533          	sltu	a0,s5,a6
     6a4:	955a                	add	a0,a0,s6

000006a6 <.LBB455>:
     6a6:	01851593          	slli	a1,a0,0x18
     6aa:	008add93          	srli	s11,s5,0x8
     6ae:	01b5edb3          	or	s11,a1,s11

000006b2 <.LBE455>:
            XL (J) := XL (J) - (Carry * 256);
     6b2:	f003f393          	andi	t2,t2,-256
     6b6:	0187d593          	srli	a1,a5,0x18
     6ba:	0075e3b3          	or	t2,a1,t2
     6be:	4586                	lw	a1,64(sp)
     6c0:	4a96                	lw	s5,68(sp)
            Carry := ASR_8 (XL (J) + 128);
     6c2:	de5a                	sw	s6,60(sp)
            XL (J) := XL (J) - (Carry * 256);
     6c4:	41a28b33          	sub	s6,t0,s10
     6c8:	4d12                	lw	s10,4(sp)
     6ca:	00bcbcb3          	sltu	s9,s9,a1
     6ce:	45a2                	lw	a1,8(sp)
     6d0:	415e0c33          	sub	s8,t3,s5
     6d4:	4aa6                	lw	s5,72(sp)
     6d6:	01ed6f33          	or	t5,s10,t5
     6da:	4d42                	lw	s10,16(sp)
     6dc:	41e585b3          	sub	a1,a1,t5
     6e0:	4f32                	lw	t5,12(sp)
     6e2:	41530ab3          	sub	s5,t1,s5
     6e6:	1b512823          	sw	s5,432(sp)
     6ea:	013d69b3          	or	s3,s10,s3
     6ee:	413f09b3          	sub	s3,t5,s3
     6f2:	1b012f03          	lw	t5,432(sp)
     6f6:	4d62                	lw	s10,24(sp)
     6f8:	06a2                	slli	a3,a3,0x8
     6fa:	01e33333          	sltu	t1,t1,t5
     6fe:	4f52                	lw	t5,20(sp)
     700:	012d6933          	or	s2,s10,s2
     704:	5d02                	lw	s10,32(sp)
     706:	412f0933          	sub	s2,t5,s2
     70a:	4f72                	lw	t5,28(sp)
     70c:	009d64b3          	or	s1,s10,s1
     710:	5d22                	lw	s10,40(sp)
     712:	409f04b3          	sub	s1,t5,s1
     716:	5f12                	lw	t5,36(sp)
     718:	40d086b3          	sub	a3,ra,a3
     71c:	008d6433          	or	s0,s10,s0
     720:	5d42                	lw	s10,48(sp)
     722:	408f0433          	sub	s0,t5,s0
     726:	00d0bf33          	sltu	t5,ra,a3
     72a:	50b2                	lw	ra,44(sp)
     72c:	f00bfb93          	andi	s7,s7,-256
     730:	017d6bb3          	or	s7,s10,s7
     734:	417080b3          	sub	ra,ra,s7
     738:	5bd2                	lw	s7,52(sp)
     73a:	01875a13          	srli	s4,a4,0x18
     73e:	f0067613          	andi	a2,a2,-256
     742:	00ca6633          	or	a2,s4,a2
     746:	4ab6                	lw	s5,76(sp)
     748:	40cb8633          	sub	a2,s7,a2
     74c:	5be2                	lw	s7,56(sp)
     74e:	07a2                	slli	a5,a5,0x8
     750:	40fe87b3          	sub	a5,t4,a5
     754:	415f8ab3          	sub	s5,t6,s5
     758:	407b83b3          	sub	t2,s7,t2
     75c:	00febeb3          	sltu	t4,t4,a5
     760:	419585b3          	sub	a1,a1,s9
     764:	41d38eb3          	sub	t4,t2,t4
     768:	015fbfb3          	sltu	t6,t6,s5
     76c:	1ab12223          	sw	a1,420(sp)
     770:	41f40fb3          	sub	t6,s0,t6
     774:	0722                	slli	a4,a4,0x8
     776:	5472                	lw	s0,60(sp)
     778:	1b812423          	sw	s8,424(sp)
     77c:	1dd12e23          	sw	t4,476(sp)

00000780 <.LBB457>:
              ((Min_XL48_Carry + 128 + 1) / 2**8) - 1;
            pragma Assert (Min_XL49_Carry = -2);
            Min_XL50_Carry : constant := ((Min_XL49_Carry + 128) / 2**8);
            pragma Assert (Min_XL50_Carry = 0);
         begin
            XL (47) := XL (47) + Carry;
     780:	1e812e83          	lw	t4,488(sp)

00000784 <.LBB474>:
            XL (J) := XL (J) - (Carry * 256);
     784:	40e88733          	sub	a4,a7,a4
     788:	1cd12423          	sw	a3,456(sp)

0000078c <.LBB475>:
            XL (47) := XL (47) + Carry;
     78c:	1ec12683          	lw	a3,492(sp)

00000790 <.LBB476>:
            XL (J) := XL (J) - (Carry * 256);
     790:	00e8b8b3          	sltu	a7,a7,a4
     794:	f0057d13          	andi	s10,a0,-256
     798:	018ddb93          	srli	s7,s11,0x18
     79c:	008d9a13          	slli	s4,s11,0x8

000007a0 <.LBB477>:
            XL (47) := XL (47) + Carry;
     7a0:	9eee                	add	t4,t4,s11

000007a2 <.LBB478>:
            XL (J) := XL (J) - (Carry * 256);
     7a2:	41480a33          	sub	s4,a6,s4
     7a6:	41160633          	sub	a2,a2,a7
     7aa:	01abed33          	or	s10,s7,s10
     7ae:	1ce12823          	sw	a4,464(sp)

000007b2 <.LBB456>:
     7b2:	40855713          	srai	a4,a0,0x8

000007b6 <.LBB479>:
            XL (47) := XL (47) + Carry;
     7b6:	9736                	add	a4,a4,a3

000007b8 <.LBB480>:
            XL (J) := XL (J) - (Carry * 256);
     7b8:	01483833          	sltu	a6,a6,s4
     7bc:	41a40d33          	sub	s10,s0,s10
     7c0:	1cc12a23          	sw	a2,468(sp)
     7c4:	1cf12c23          	sw	a5,472(sp)

000007c8 <.LBB481>:
            Carry := ASR_8 (XL (47) + 128);
     7c8:	080e8613          	addi	a2,t4,128
            XL (47) := XL (47) + Carry;
     7cc:	01beb7b3          	sltu	a5,t4,s11
     7d0:	97ba                	add	a5,a5,a4

000007d2 <.LBB482>:
            XL (J) := XL (J) - (Carry * 256);
     7d2:	1df12223          	sw	t6,452(sp)
     7d6:	410d0833          	sub	a6,s10,a6

000007da <.LBB483>:
            Carry := ASR_8 (XL (47) + 128);
     7da:	01d63fb3          	sltu	t6,a2,t4
     7de:	9fbe                	add	t6,t6,a5

000007e0 <.LBB484>:
            XL (J) := XL (J) - (Carry * 256);
     7e0:	1f012223          	sw	a6,484(sp)

000007e4 <.LBB485>:
            XL (47) := XL (47) - (Carry * 256);

            pragma Assert (Carry >= Min_XL47_Carry);

            XL (48) := XL (48) + Carry;
     7e4:	1f012803          	lw	a6,496(sp)
     7e8:	1f412403          	lw	s0,500(sp)

000007ec <.LBB458>:
     7ec:	018f9713          	slli	a4,t6,0x18
     7f0:	8221                	srli	a2,a2,0x8
     7f2:	8e59                	or	a2,a2,a4

000007f4 <.LBB486>:
            XL (J) := XL (J) - (Carry * 256);
     7f4:	018e3e33          	sltu	t3,t3,s8

000007f8 <.LBB487>:
            XL (48) := XL (48) + Carry;
     7f8:	9832                	add	a6,a6,a2

000007fa <.LBB488>:
            XL (J) := XL (J) - (Carry * 256);
     7fa:	41c98e33          	sub	t3,s3,t3

000007fe <.LBB461>:
     7fe:	408fd713          	srai	a4,t6,0x8

00000802 <.LBE461>:
            Carry := ASR_8 (XL (48) + 128);
     802:	08080693          	addi	a3,a6,128

00000806 <.LBB490>:
            XL (J) := XL (J) - (Carry * 256);
     806:	1bc12623          	sw	t3,428(sp)

0000080a <.LBB491>:
            XL (48) := XL (48) + Carry;
     80a:	9722                	add	a4,a4,s0
     80c:	00c83e33          	sltu	t3,a6,a2
     810:	00ee0433          	add	s0,t3,a4
            Carry := ASR_8 (XL (48) + 128);
     814:	0106be33          	sltu	t3,a3,a6
            XL (48) := XL (48) - (Carry * 256);

            pragma Assert (Carry >= Min_XL48_Carry);

            XL (49) := XL (49) + Carry;
     818:	1f812503          	lw	a0,504(sp)
            Carry := ASR_8 (XL (48) + 128);
     81c:	9e22                	add	t3,t3,s0
            XL (49) := XL (49) + Carry;
     81e:	1fc12383          	lw	t2,508(sp)

00000822 <.LBB462>:
     822:	018e1713          	slli	a4,t3,0x18
     826:	82a1                	srli	a3,a3,0x8
     828:	8ed9                	or	a3,a3,a4

0000082a <.LBE462>:
     82a:	9536                	add	a0,a0,a3

0000082c <.LBB492>:
            XL (J) := XL (J) - (Carry * 256);
     82c:	40690333          	sub	t1,s2,t1

00000830 <.LBB465>:
     830:	408e5593          	srai	a1,t3,0x8

00000834 <.LBE465>:
            Carry := ASR_8 (XL (49) + 128);
     834:	08050713          	addi	a4,a0,128

00000838 <.LBB494>:
            XL (J) := XL (J) - (Carry * 256);
     838:	1a612a23          	sw	t1,436(sp)

0000083c <.LBB495>:
            XL (49) := XL (49) + Carry;
     83c:	959e                	add	a1,a1,t2
     83e:	00d53333          	sltu	t1,a0,a3
     842:	00b303b3          	add	t2,t1,a1
            Carry := ASR_8 (XL (49) + 128);
     846:	00a73333          	sltu	t1,a4,a0
     84a:	931e                	add	t1,t1,t2

0000084c <.LBB466>:
     84c:	01831593          	slli	a1,t1,0x18
     850:	8321                	srli	a4,a4,0x8
     852:	8f4d                	or	a4,a4,a1

00000854 <.LBE466>:
            XL (49) := XL (49) - (Carry * 256);

            pragma Assert (Carry >= Min_XL49_Carry);

            XL (50) := XL (50) + Carry;
     854:	20012583          	lw	a1,512(sp)

00000858 <.LBB496>:
            XL (J) := XL (J) - (Carry * 256);
     858:	41e08f33          	sub	t5,ra,t5

0000085c <.LBB497>:
            XL (50) := XL (50) + Carry;
     85c:	20412083          	lw	ra,516(sp)

00000860 <.LBB498>:
            XL (J) := XL (J) - (Carry * 256);
     860:	0162b2b3          	sltu	t0,t0,s6

00000864 <.LBB499>:
            XL (50) := XL (50) + Carry;
     864:	95ba                	add	a1,a1,a4

00000866 <.LBB500>:
            XL (J) := XL (J) - (Carry * 256);
     866:	405482b3          	sub	t0,s1,t0

0000086a <.LBB469>:
     86a:	40835893          	srai	a7,t1,0x8

0000086e <.LBB502>:
     86e:	1a512e23          	sw	t0,444(sp)

00000872 <.LVL104>:
     872:	1de12623          	sw	t5,460(sp)

00000876 <.LBB503>:
            XL (50) := XL (50) + Carry;
     876:	00e5b2b3          	sltu	t0,a1,a4
            Carry := ASR_8 (XL (50) + 128);
     87a:	08058f13          	addi	t5,a1,128
            XL (50) := XL (50) + Carry;
     87e:	9886                	add	a7,a7,ra

00000880 <.LVL106>:
     880:	9896                	add	a7,a7,t0
            Carry := ASR_8 (XL (50) + 128);
     882:	00bf3933          	sltu	s2,t5,a1
     886:	9946                	add	s2,s2,a7

00000888 <.LBB470>:
     888:	01891293          	slli	t0,s2,0x18
     88c:	008f5f13          	srli	t5,t5,0x8
     890:	01e2ef33          	or	t5,t0,t5

00000894 <.LBB504>:
            XL (J) := XL (J) - (Carry * 256);
     894:	1b612c23          	sw	s6,440(sp)

00000898 <.LBB505>:
            XL (47) := XL (47) - (Carry * 256);
     898:	f00fff93          	andi	t6,t6,-256
     89c:	01865b13          	srli	s6,a2,0x18
     8a0:	0622                	slli	a2,a2,0x8

000008a2 <.LBE505>:
            (for all K in Index_64 range 51 .. 63 => XL (K) = X (K)));

         --  Note XL (51) is adjusted here but is NOT normalized
         --  to be in FRL... hence it's a special case in the post-
         --  condition above.
         XL (51) := XL (51) + Carry;
     8a2:	20812083          	lw	ra,520(sp)

000008a6 <.LBB506>:
            XL (50) := XL (50) - (Carry * 256);
     8a6:	018f5993          	srli	s3,t5,0x18
            XL (47) := XL (47) - (Carry * 256);
     8aa:	40ce8633          	sub	a2,t4,a2
     8ae:	01fb6fb3          	or	t6,s6,t6
            XL (50) := XL (50) - (Carry * 256);
     8b2:	f0097493          	andi	s1,s2,-256

000008b6 <.LBB507>:
            XL (J) := XL (J) - (Carry * 256);
     8b6:	1d512023          	sw	s5,448(sp)
     8ba:	1f412023          	sw	s4,480(sp)

000008be <.LBB508>:
            XL (48) := XL (48) - (Carry * 256);
     8be:	0186da93          	srli	s5,a3,0x18
            XL (49) := XL (49) - (Carry * 256);
     8c2:	01875a13          	srli	s4,a4,0x18
            XL (50) := XL (50) - (Carry * 256);
     8c6:	008f1293          	slli	t0,t5,0x8
     8ca:	0099e4b3          	or	s1,s3,s1
            XL (48) := XL (48) - (Carry * 256);
     8ce:	f00e7e13          	andi	t3,t3,-256
            XL (47) := XL (47) - (Carry * 256);
     8d2:	00ceb9b3          	sltu	s3,t4,a2
            XL (48) := XL (48) - (Carry * 256);
     8d6:	06a2                	slli	a3,a3,0x8
            XL (47) := XL (47) - (Carry * 256);
     8d8:	41f78eb3          	sub	t4,a5,t6
            XL (49) := XL (49) - (Carry * 256);
     8dc:	f0037313          	andi	t1,t1,-256

000008e0 <.LBE508>:
         XL (51) := XL (51) + Carry;
     8e0:	20c12f83          	lw	t6,524(sp)

000008e4 <.LBB509>:
            XL (49) := XL (49) - (Carry * 256);
     8e4:	0722                	slli	a4,a4,0x8
     8e6:	40e50733          	sub	a4,a0,a4
            XL (48) := XL (48) - (Carry * 256);
     8ea:	40d806b3          	sub	a3,a6,a3
            XL (50) := XL (50) - (Carry * 256);
     8ee:	405582b3          	sub	t0,a1,t0
            XL (48) := XL (48) - (Carry * 256);
     8f2:	01caee33          	or	t3,s5,t3
            XL (49) := XL (49) - (Carry * 256);
     8f6:	006a6333          	or	t1,s4,t1

000008fa <.LBE509>:
         XL (51) := XL (51) + Carry;
     8fa:	9f06                	add	t5,t5,ra

000008fc <.LBB510>:
            XL (49) := XL (49) - (Carry * 256);
     8fc:	00e53533          	sltu	a0,a0,a4

00000900 <.LBB473>:
     900:	40895913          	srai	s2,s2,0x8

00000904 <.LBE473>:
            XL (48) := XL (48) - (Carry * 256);
     904:	00d83833          	sltu	a6,a6,a3
     908:	41c40e33          	sub	t3,s0,t3
            XL (49) := XL (49) - (Carry * 256);
     90c:	40638333          	sub	t1,t2,t1
            XL (50) := XL (50) - (Carry * 256);
     910:	0055b5b3          	sltu	a1,a1,t0
     914:	409888b3          	sub	a7,a7,s1

00000918 <.LBE510>:
         XL (51) := XL (51) + Carry;
     918:	001f37b3          	sltu	a5,t5,ra

0000091c <.LBB511>:
            XL (48) := XL (48) - (Carry * 256);
     91c:	410e0833          	sub	a6,t3,a6

00000920 <.LBE511>:
         XL (51) := XL (51) + Carry;
     920:	997e                	add	s2,s2,t6

00000922 <.LBB512>:
            XL (47) := XL (47) - (Carry * 256);
     922:	413e8eb3          	sub	t4,t4,s3
            XL (49) := XL (49) - (Carry * 256);
     926:	40a30533          	sub	a0,t1,a0
            XL (50) := XL (50) - (Carry * 256);
     92a:	40b885b3          	sub	a1,a7,a1

0000092e <.LBE512>:
         XL (51) := XL (51) + Carry;
     92e:	97ca                	add	a5,a5,s2

00000930 <.LBB513>:
            XL (48) := XL (48) - (Carry * 256);
     930:	1f012a23          	sw	a6,500(sp)
            XL (49) := XL (49) - (Carry * 256);
     934:	1ee12c23          	sw	a4,504(sp)
            XL (47) := XL (47) - (Carry * 256);
     938:	1ec12423          	sw	a2,488(sp)
     93c:	1fd12623          	sw	t4,492(sp)
            XL (48) := XL (48) - (Carry * 256);
     940:	1ed12823          	sw	a3,496(sp)
            XL (49) := XL (49) - (Carry * 256);
     944:	1ea12e23          	sw	a0,508(sp)
            XL (50) := XL (50) - (Carry * 256);
     948:	20512023          	sw	t0,512(sp)
     94c:	20b12223          	sw	a1,516(sp)

00000950 <.LBE513>:
         XL (51) := XL (51) + Carry;
     950:	21e12423          	sw	t5,520(sp)
     954:	20f12623          	sw	a5,524(sp)
         pragma Assert (XL (51) in XL51_T);
         XL (63) := 0;
     958:	4781                	li	a5,0
     95a:	4801                	li	a6,0
     95c:	26f12423          	sw	a5,616(sp)
     960:	07010093          	addi	ra,sp,112
     964:	000007b7          	lui	a5,0x0
     968:	00000bb7          	lui	s7,0x0
     96c:	27012623          	sw	a6,620(sp)
     970:	14b8                	addi	a4,sp,616
     972:	17010b13          	addi	s6,sp,368
     976:	00078c13          	mv	s8,a5
     97a:	080b8b93          	addi	s7,s7,128 # 80 <.LBB370+0x2e>
     97e:	c206                	sw	ra,4(sp)

00000980 <.L67>:
     980:	84e2                	mv	s1,s8

00000982 <.LBE370>:
   function ModL (X : in I64_Seq_64) return Bytes_32
     982:	883a                	mv	a6,a4
     984:	88e2                	mv	a7,s8

00000986 <.LBB514>:
      is
         Carry      : Carry_T;
         Adjustment : Adjustment_T;
      begin
         for I in reverse I32 range 32 .. 62 loop
            Carry := 0;
     986:	4681                	li	a3,0
     988:	4581                	li	a1,0

0000098a <.L66>:
            --  As above, this loop iterates over limbs 0 .. 15 of L
            --  leaving the final four (zero) limbs unrolled below.
            for J in I32 range (I - 32) .. (I - 17) loop
               Adjustment := (16 * L (J - (I - 32))) * XL (I);
               XL (J) := XL (J) + Carry - Adjustment;
     98a:	ef882603          	lw	a2,-264(a6)
     98e:	efc82f03          	lw	t5,-260(a6)
               Adjustment := (16 * L (J - (I - 32))) * XL (I);
     992:	ff872e03          	lw	t3,-8(a4)
     996:	0008a783          	lw	a5,0(a7)
     99a:	ffc72303          	lw	t1,-4(a4)
     99e:	0048a503          	lw	a0,4(a7)
               XL (J) := XL (J) + Carry - Adjustment;
     9a2:	9636                	add	a2,a2,a3
     9a4:	00d636b3          	sltu	a3,a2,a3

000009a8 <.LVL115>:
     9a8:	95fa                	add	a1,a1,t5
               Adjustment := (16 * L (J - (I - 32))) * XL (I);
     9aa:	03c50533          	mul	a0,a0,t3
               XL (J) := XL (J) + Carry - Adjustment;
     9ae:	95b6                	add	a1,a1,a3
            for J in I32 range (I - 32) .. (I - 17) loop
     9b0:	0821                	addi	a6,a6,8
     9b2:	08a1                	addi	a7,a7,8

000009b4 <.LVL116>:
               Adjustment := (16 * L (J - (I - 32))) * XL (I);
     9b4:	02f306b3          	mul	a3,t1,a5
     9b8:	03c7beb3          	mulhu	t4,a5,t3
     9bc:	9536                	add	a0,a0,a3
     9be:	03c787b3          	mul	a5,a5,t3
     9c2:	9576                	add	a0,a0,t4
     9c4:	0512                	slli	a0,a0,0x4
     9c6:	01c7d693          	srli	a3,a5,0x1c
     9ca:	0792                	slli	a5,a5,0x4
               XL (J) := XL (J) + Carry - Adjustment;
     9cc:	40f607b3          	sub	a5,a2,a5
               Adjustment := (16 * L (J - (I - 32))) * XL (I);
     9d0:	8d55                	or	a0,a0,a3
               XL (J) := XL (J) + Carry - Adjustment;
     9d2:	8d89                	sub	a1,a1,a0
               Carry := ASR_8 (XL (J) + 128);
     9d4:	08078693          	addi	a3,a5,128 # 80 <.LBB370+0x2e>
               XL (J) := XL (J) + Carry - Adjustment;
     9d8:	00f63633          	sltu	a2,a2,a5
     9dc:	40c58633          	sub	a2,a1,a2
               Carry := ASR_8 (XL (J) + 128);
     9e0:	00f6b5b3          	sltu	a1,a3,a5
     9e4:	95b2                	add	a1,a1,a2

000009e6 <.LBB519>:
     9e6:	01859513          	slli	a0,a1,0x18
     9ea:	82a1                	srli	a3,a3,0x8
     9ec:	8ec9                	or	a3,a3,a0

000009ee <.LBE519>:
               XL (J) := XL (J) - (Carry * 256);
     9ee:	f005f313          	andi	t1,a1,-256
     9f2:	0186de13          	srli	t3,a3,0x18
     9f6:	00869513          	slli	a0,a3,0x8
     9fa:	40a78533          	sub	a0,a5,a0
     9fe:	006e6333          	or	t1,t3,t1
     a02:	00a7b7b3          	sltu	a5,a5,a0
     a06:	40660633          	sub	a2,a2,t1
     a0a:	40f607b3          	sub	a5,a2,a5
     a0e:	eea82823          	sw	a0,-272(a6)

00000a12 <.LVL119>:
     a12:	eef82a23          	sw	a5,-268(a6)

00000a16 <.LBB522>:
     a16:	85a1                	srai	a1,a1,0x8

00000a18 <.LBE522>:
            for J in I32 range (I - 32) .. (I - 17) loop
     a18:	f71b99e3          	bne	s7,a7,98a <.L66>

00000a1c <.LBE518>:
              (for all K in Index_64 range I - 32 .. I - 17 =>
                 XL (K) in FRL);

            pragma Assert (XL (I - 16) in FRL);
            --  Carry is in Carry_T here
            XL (I - 16) := XL (I - 16) + Carry;
     a1c:	f7872f83          	lw	t6,-136(a4)
     a20:	f7c72783          	lw	a5,-132(a4)
            --  Now we can start to prove that Carry is converging.
            --  Each further reduction reduces the lower and upper bound
            --  of Carry by about 2**8, except that the addition of 128 and
            --  ASR_8 actually mean that Carry converges on the range -1 .. 1
            pragma Assert (Carry in -2**17 .. 64);
            XL (I - 15) := XL (I - 15) + Carry;
     a24:	f8072f03          	lw	t5,-128(a4)
            XL (I - 16) := XL (I - 16) + Carry;
     a28:	9fb6                	add	t6,t6,a3
            Carry := ASR_8 (XL (I - 16) + 128);
     a2a:	080f8613          	addi	a2,t6,128
            XL (I - 16) := XL (I - 16) + Carry;
     a2e:	00dfb6b3          	sltu	a3,t6,a3

00000a32 <.LVL121>:
     a32:	95be                	add	a1,a1,a5
     a34:	00b687b3          	add	a5,a3,a1
            Carry := ASR_8 (XL (I - 16) + 128);
     a38:	01f638b3          	sltu	a7,a2,t6
     a3c:	98be                	add	a7,a7,a5
            XL (I - 15) := XL (I - 15) + Carry;
     a3e:	f8472803          	lw	a6,-124(a4)

00000a42 <.LBB523>:
     a42:	01889693          	slli	a3,a7,0x18
     a46:	00865593          	srli	a1,a2,0x8
     a4a:	8dd5                	or	a1,a1,a3

00000a4c <.LBE523>:
     a4c:	9f2e                	add	t5,t5,a1

00000a4e <.LBB526>:
     a4e:	4088d693          	srai	a3,a7,0x8

00000a52 <.LBE526>:
            Carry := ASR_8 (XL (I - 15) + 128);
     a52:	080f0613          	addi	a2,t5,128
            XL (I - 15) := XL (I - 15) + Carry;
     a56:	00bf39b3          	sltu	s3,t5,a1
     a5a:	96c2                	add	a3,a3,a6

00000a5c <.LVL124>:
     a5c:	99b6                	add	s3,s3,a3
            Carry := ASR_8 (XL (I - 15) + 128);
     a5e:	01e63833          	sltu	a6,a2,t5
              (for all K in Index_64 range I - 32 .. I - 15 =>
                 XL (K) in FRL);

            pragma Assert (XL (I - 14) in FRL);
            pragma Assert (Carry in -512 .. 1);
            XL (I - 14) := XL (I - 14) + Carry;
     a62:	f8872e83          	lw	t4,-120(a4)
            Carry := ASR_8 (XL (I - 15) + 128);
     a66:	984e                	add	a6,a6,s3
            XL (I - 14) := XL (I - 14) + Carry;
     a68:	f8c72303          	lw	t1,-116(a4)

00000a6c <.LBB527>:
     a6c:	01881693          	slli	a3,a6,0x18
     a70:	8221                	srli	a2,a2,0x8
     a72:	8e55                	or	a2,a2,a3

00000a74 <.LBE527>:
     a74:	9eb2                	add	t4,t4,a2

00000a76 <.LBB530>:
     a76:	40885513          	srai	a0,a6,0x8

00000a7a <.LBE530>:
            Carry := ASR_8 (XL (I - 14) + 128);
     a7a:	080e8693          	addi	a3,t4,128
            XL (I - 14) := XL (I - 14) + Carry;
     a7e:	00ceb933          	sltu	s2,t4,a2
     a82:	951a                	add	a0,a0,t1

00000a84 <.LVL127>:
     a84:	992a                	add	s2,s2,a0
            Carry := ASR_8 (XL (I - 14) + 128);
     a86:	01d6b533          	sltu	a0,a3,t4
              (for all K in Index_64 range I - 32 .. I - 14 =>
                 XL (K) in FRL);

            pragma Assert (XL (I - 13) in FRL);
            pragma Assert (Carry in -2 .. 1);
            XL (I - 13) := XL (I - 13) + Carry;
     a8a:	f9072e03          	lw	t3,-112(a4)
            Carry := ASR_8 (XL (I - 14) + 128);
     a8e:	954a                	add	a0,a0,s2
            XL (I - 13) := XL (I - 13) + Carry;
     a90:	f9472083          	lw	ra,-108(a4)

00000a94 <.LBB531>:
     a94:	01851313          	slli	t1,a0,0x18
     a98:	82a1                	srli	a3,a3,0x8
     a9a:	00d366b3          	or	a3,t1,a3

00000a9e <.LBE531>:
     a9e:	9e36                	add	t3,t3,a3

00000aa0 <.LBB534>:
     aa0:	40855293          	srai	t0,a0,0x8

00000aa4 <.LBE534>:
     aa4:	00de33b3          	sltu	t2,t3,a3
            Carry := ASR_8 (XL (I - 13) + 128);
     aa8:	080e0313          	addi	t1,t3,128
            XL (I - 13) := XL (I - 13) + Carry;
     aac:	9286                	add	t0,t0,ra

00000aae <.LVL130>:
     aae:	929e                	add	t0,t0,t2
            Carry := ASR_8 (XL (I - 13) + 128);
     ab0:	01c333b3          	sltu	t2,t1,t3
     ab4:	9396                	add	t2,t2,t0
            XL (I - 16) := XL (I - 16) - (Carry * 256);
     ab6:	0185dd93          	srli	s11,a1,0x18
     aba:	f008f893          	andi	a7,a7,-256
            pragma Assert (Carry in -1 .. 1);

            --  If Carry in -1 .. 1, then the final adjustment of
            --  XL (I - 12) means that this limb can end up being
            --  -129 or +128, so in PRL but not in FRL
            XL (I - 12) := XL (I - 12) + Carry;
     abe:	f9872083          	lw	ra,-104(a4)

00000ac2 <.LBB535>:
     ac2:	01839413          	slli	s0,t2,0x18

00000ac6 <.LBE535>:
            XL (I - 16) := XL (I - 16) - (Carry * 256);
     ac6:	011de8b3          	or	a7,s11,a7

00000aca <.LBB539>:
     aca:	00835313          	srli	t1,t1,0x8
     ace:	00646333          	or	t1,s0,t1

00000ad2 <.LBE539>:
     ad2:	411787b3          	sub	a5,a5,a7
            XL (I - 15) := XL (I - 15) - (Carry * 256);
     ad6:	01865d13          	srli	s10,a2,0x18
            XL (I - 12) := XL (I - 12) + Carry;
     ada:	f9c72883          	lw	a7,-100(a4)
            XL (I - 15) := XL (I - 15) - (Carry * 256);
     ade:	f0087813          	andi	a6,a6,-256
     ae2:	0622                	slli	a2,a2,0x8
            XL (I - 14) := XL (I - 14) - (Carry * 256);
     ae4:	0186dc93          	srli	s9,a3,0x18
            XL (I - 13) := XL (I - 13) - (Carry * 256);
     ae8:	01835a93          	srli	s5,t1,0x18
     aec:	f003fa13          	andi	s4,t2,-256
     af0:	00831413          	slli	s0,t1,0x8
            XL (I - 15) := XL (I - 15) - (Carry * 256);
     af4:	40cf0633          	sub	a2,t5,a2
            XL (I - 16) := XL (I - 16) - (Carry * 256);
     af8:	05a2                	slli	a1,a1,0x8
            XL (I - 14) := XL (I - 14) - (Carry * 256);
     afa:	f0057513          	andi	a0,a0,-256
     afe:	06a2                	slli	a3,a3,0x8
            XL (I - 15) := XL (I - 15) - (Carry * 256);
     b00:	010d6833          	or	a6,s10,a6
            XL (I - 16) := XL (I - 16) - (Carry * 256);
     b04:	40bf85b3          	sub	a1,t6,a1
            XL (I - 14) := XL (I - 14) - (Carry * 256);
     b08:	40de86b3          	sub	a3,t4,a3
            XL (I - 13) := XL (I - 13) - (Carry * 256);
     b0c:	408e0433          	sub	s0,t3,s0
            XL (I - 12) := XL (I - 12) + Carry;
     b10:	9306                	add	t1,t1,ra
            XL (I - 14) := XL (I - 14) - (Carry * 256);
     b12:	00ace533          	or	a0,s9,a0

00000b16 <.LBB540>:
     b16:	4083d393          	srai	t2,t2,0x8

00000b1a <.LBE540>:
            XL (I - 13) := XL (I - 13) - (Carry * 256);
     b1a:	014aea33          	or	s4,s5,s4
            XL (I - 15) := XL (I - 15) - (Carry * 256);
     b1e:	00cf3f33          	sltu	t5,t5,a2
     b22:	41098833          	sub	a6,s3,a6
     b26:	41e80833          	sub	a6,a6,t5
            XL (I - 16) := XL (I - 16) - (Carry * 256);
     b2a:	00bfbfb3          	sltu	t6,t6,a1
            XL (I - 14) := XL (I - 14) - (Carry * 256);
     b2e:	00debeb3          	sltu	t4,t4,a3
     b32:	40a90533          	sub	a0,s2,a0
            XL (I - 13) := XL (I - 13) - (Carry * 256);
     b36:	008e3e33          	sltu	t3,t3,s0
     b3a:	414282b3          	sub	t0,t0,s4
            XL (I - 12) := XL (I - 12) + Carry;
     b3e:	001330b3          	sltu	ra,t1,ra
     b42:	93c6                	add	t2,t2,a7
            XL (I - 16) := XL (I - 16) - (Carry * 256);
     b44:	41f78fb3          	sub	t6,a5,t6
            XL (I - 15) := XL (I - 15) - (Carry * 256);
     b48:	f9072223          	sw	a6,-124(a4)
            XL (I - 14) := XL (I - 14) - (Carry * 256);
     b4c:	41d50533          	sub	a0,a0,t4
            XL (I - 13) := XL (I - 13) - (Carry * 256);
     b50:	41c282b3          	sub	t0,t0,t3
            XL (I - 12) := XL (I - 12) + Carry;
     b54:	909e                	add	ra,ra,t2
            pragma Assert (XL (I - 12) in PRL);

            --  XL (I) is now eliminated, so it gets zeroed out now.
            XL (I) := 0;
     b56:	4781                	li	a5,0
     b58:	4801                	li	a6,0
            XL (I - 16) := XL (I - 16) - (Carry * 256);
     b5a:	f6b72c23          	sw	a1,-136(a4)
     b5e:	f7f72e23          	sw	t6,-132(a4)
            XL (I - 15) := XL (I - 15) - (Carry * 256);
     b62:	f8c72023          	sw	a2,-128(a4)
            XL (I - 14) := XL (I - 14) - (Carry * 256);
     b66:	f8d72423          	sw	a3,-120(a4)
     b6a:	f8a72623          	sw	a0,-116(a4)
            XL (I - 13) := XL (I - 13) - (Carry * 256);
     b6e:	f8872823          	sw	s0,-112(a4)
     b72:	f8572a23          	sw	t0,-108(a4)
            XL (I - 12) := XL (I - 12) + Carry;
     b76:	f8672c23          	sw	t1,-104(a4)
     b7a:	f8172e23          	sw	ra,-100(a4)
            XL (I) := 0;
     b7e:	fef72c23          	sw	a5,-8(a4)
     b82:	ff072e23          	sw	a6,-4(a4)

00000b86 <.LBE517>:
         for I in reverse I32 range 32 .. 62 loop
     b86:	1761                	addi	a4,a4,-8
     b88:	df671ce3          	bne	a4,s6,980 <.L67>
     b8c:	4092                	lw	ra,4(sp)

00000b8e <.LBB543>:
           I64_Byte'Last  - (Final_Carry_Min * Max_L);

         Carry : Final_Carry_T;
      begin
         --  Step 1
         Carry := 0;
     b8e:	4681                	li	a3,0

00000b90 <.LBB692>:
     b90:	8362                	mv	t1,s8
     b92:	1888                	addi	a0,sp,112

00000b94 <.LBB693>:
     b94:	88b6                	mv	a7,a3

00000b96 <.L68>:

   --  returns equivalent of X >> 4 in C, doing an arithmetic
   --  shift right when X is negative, assuming 2's complement
   --  representation
   function ASR_4 (X : in I64) return I64
   is (To_I64 (Shift_Right_Arithmetic (To_U64 (X), 4)))
     b96:	16c12603          	lw	a2,364(sp)
     b9a:	16812583          	lw	a1,360(sp)

00000b9e <.LBE546>:
         for J in Index_32 loop
            pragma Assert (XL (31) in PRL);
            XL (J) := XL (J) + (Carry - ASR_4 (XL (31)) * L (J));
     b9e:	00032803          	lw	a6,0(t1)
     ba2:	00432e03          	lw	t3,4(t1)

00000ba6 <.LBB549>:
     ba6:	01c61713          	slli	a4,a2,0x1c
     baa:	8191                	srli	a1,a1,0x4
     bac:	8dd9                	or	a1,a1,a4
     bae:	8611                	srai	a2,a2,0x4

00000bb0 <.LBE549>:
     bb0:	02be0e33          	mul	t3,t3,a1
     bb4:	4114                	lw	a3,0(a0)
     bb6:	00452e83          	lw	t4,4(a0)

            pragma Assert (XL (J) >= Step1_XL_Limb'First);
            pragma Assert (XL (J) <= Step1_XL_Limb'Last);

            Carry := ASR_8 (XL (J));
            XL (J) := XL (J) mod 256;
     bba:	00052223          	sw	zero,4(a0)
         for J in Index_32 loop
     bbe:	0521                	addi	a0,a0,8
     bc0:	0321                	addi	t1,t1,8
            XL (J) := XL (J) + (Carry - ASR_4 (XL (31)) * L (J));
     bc2:	02c80633          	mul	a2,a6,a2
     bc6:	02b80733          	mul	a4,a6,a1
     bca:	9672                	add	a2,a2,t3
     bcc:	02b835b3          	mulhu	a1,a6,a1
     bd0:	40e88733          	sub	a4,a7,a4
     bd4:	00e8b833          	sltu	a6,a7,a4
     bd8:	96ba                	add	a3,a3,a4
     bda:	00e6b733          	sltu	a4,a3,a4
            XL (J) := XL (J) mod 256;
     bde:	0ff6fe13          	andi	t3,a3,255

00000be2 <.LBB550>:
   is (To_I64 (Shift_Right_Arithmetic (To_U64 (X), 8)))
     be2:	0086d893          	srli	a7,a3,0x8

00000be6 <.LBE550>:
     be6:	ffc52c23          	sw	t3,-8(a0)
            XL (J) := XL (J) + (Carry - ASR_4 (XL (31)) * L (J));
     bea:	962e                	add	a2,a2,a1
     bec:	40c78633          	sub	a2,a5,a2
     bf0:	41060633          	sub	a2,a2,a6
     bf4:	9676                	add	a2,a2,t4
     bf6:	9732                	add	a4,a4,a2

00000bf8 <.LBB553>:
     bf8:	01871793          	slli	a5,a4,0x18
     bfc:	0117e8b3          	or	a7,a5,a7
     c00:	40875793          	srai	a5,a4,0x8

00000c04 <.LBE553>:
         for J in Index_32 loop
     c04:	f8ab19e3          	bne	s6,a0,b96 <.L68>
     c08:	86c6                	mv	a3,a7

00000c0a <.L69>:
         pragma Assert
           (for all K in Index_64 range 32 .. 63 => XL (K) = 0);

         --  Step 2
         for J in Index_32 loop
            XL (J) := XL (J) - Carry * L (J);
     c0a:	408c                	lw	a1,0(s1)
     c0c:	0044a883          	lw	a7,4(s1)
     c10:	0000a503          	lw	a0,0(ra)
     c14:	02f58633          	mul	a2,a1,a5
     c18:	0040a703          	lw	a4,4(ra)
         for J in Index_32 loop
     c1c:	00a1                	addi	ra,ra,8
     c1e:	04a1                	addi	s1,s1,8
            XL (J) := XL (J) - Carry * L (J);
     c20:	02d888b3          	mul	a7,a7,a3
     c24:	02d58833          	mul	a6,a1,a3
     c28:	9646                	add	a2,a2,a7
     c2a:	02d5b5b3          	mulhu	a1,a1,a3
     c2e:	41050833          	sub	a6,a0,a6
     c32:	01053533          	sltu	a0,a0,a6
     c36:	ff00ac23          	sw	a6,-8(ra)
     c3a:	962e                	add	a2,a2,a1
     c3c:	8f11                	sub	a4,a4,a2
     c3e:	8f09                	sub	a4,a4,a0
     c40:	fee0ae23          	sw	a4,-4(ra)
         for J in Index_32 loop
     c44:	fc1b13e3          	bne	s6,ra,c0a <.L69>
     c48:	5d46                	lw	s10,112(sp)
     c4a:	5756                	lw	a4,116(sp)

00000c4c <.LBB555>:
            for I in Index_32 loop

               pragma Assert (XL (I) >=
                                Step2_XL_Limb'First - MXLC * I64 (I));
               S3C := ASR_8 (XL (I));
               XL (I + 1) := XL (I + 1) + S3C;
     c4c:	5be6                	lw	s7,120(sp)

00000c4e <.LBB557>:
     c4e:	008d5793          	srli	a5,s10,0x8

00000c52 <.LVL142>:
     c52:	01871693          	slli	a3,a4,0x18
     c56:	8fd5                	or	a5,a5,a3

00000c58 <.LBE557>:
     c58:	56f6                	lw	a3,124(sp)
     c5a:	9bbe                	add	s7,s7,a5

00000c5c <.LBB622>:
     c5c:	8721                	srai	a4,a4,0x8

00000c5e <.LBE622>:
     c5e:	00fbb7b3          	sltu	a5,s7,a5
     c62:	9736                	add	a4,a4,a3
     c64:	973e                	add	a4,a4,a5

00000c66 <.LVL144>:
     c66:	408a                	lw	ra,128(sp)

00000c68 <.LBB623>:
     c68:	01871693          	slli	a3,a4,0x18
     c6c:	008bd793          	srli	a5,s7,0x8
     c70:	8fd5                	or	a5,a5,a3

00000c72 <.LBE623>:
     c72:	469a                	lw	a3,132(sp)
     c74:	90be                	add	ra,ra,a5

00000c76 <.LBB624>:
     c76:	8721                	srai	a4,a4,0x8

00000c78 <.LBE624>:
     c78:	00f0b7b3          	sltu	a5,ra,a5
     c7c:	9736                	add	a4,a4,a3
     c7e:	973e                	add	a4,a4,a5

00000c80 <.LVL146>:
     c80:	4caa                	lw	s9,136(sp)

00000c82 <.LBB625>:
     c82:	01871693          	slli	a3,a4,0x18
     c86:	0080d793          	srli	a5,ra,0x8
     c8a:	8fd5                	or	a5,a5,a3

00000c8c <.LBE625>:
     c8c:	46ba                	lw	a3,140(sp)
     c8e:	9cbe                	add	s9,s9,a5

00000c90 <.LBB626>:
     c90:	8721                	srai	a4,a4,0x8

00000c92 <.LBE626>:
     c92:	00fcb7b3          	sltu	a5,s9,a5
     c96:	9736                	add	a4,a4,a3
     c98:	973e                	add	a4,a4,a5

00000c9a <.LVL148>:
     c9a:	484a                	lw	a6,144(sp)

00000c9c <.LBB627>:
     c9c:	01871693          	slli	a3,a4,0x18
     ca0:	008cd793          	srli	a5,s9,0x8
     ca4:	8fd5                	or	a5,a5,a3

00000ca6 <.LBE627>:
     ca6:	46da                	lw	a3,148(sp)
     ca8:	983e                	add	a6,a6,a5

00000caa <.LBB628>:
     caa:	8721                	srai	a4,a4,0x8

00000cac <.LBE628>:
     cac:	00f837b3          	sltu	a5,a6,a5
     cb0:	9736                	add	a4,a4,a3
     cb2:	973e                	add	a4,a4,a5

00000cb4 <.LVL150>:
     cb4:	4b6a                	lw	s6,152(sp)

00000cb6 <.LBB629>:
     cb6:	01871693          	slli	a3,a4,0x18
     cba:	00885793          	srli	a5,a6,0x8
     cbe:	8fd5                	or	a5,a5,a3

00000cc0 <.LBE629>:
     cc0:	46fa                	lw	a3,156(sp)
     cc2:	9b3e                	add	s6,s6,a5

00000cc4 <.LBB630>:
     cc4:	8721                	srai	a4,a4,0x8

00000cc6 <.LBE630>:
     cc6:	00fb37b3          	sltu	a5,s6,a5
     cca:	9736                	add	a4,a4,a3
     ccc:	973e                	add	a4,a4,a5

00000cce <.LVL152>:
     cce:	538a                	lw	t2,160(sp)

00000cd0 <.LBB631>:
     cd0:	01871693          	slli	a3,a4,0x18
     cd4:	008b5793          	srli	a5,s6,0x8
     cd8:	8fd5                	or	a5,a5,a3

00000cda <.LBE631>:
     cda:	569a                	lw	a3,164(sp)
     cdc:	93be                	add	t2,t2,a5

00000cde <.LBB632>:
     cde:	8721                	srai	a4,a4,0x8

00000ce0 <.LBE632>:
     ce0:	00f3b7b3          	sltu	a5,t2,a5
     ce4:	9736                	add	a4,a4,a3
     ce6:	973e                	add	a4,a4,a5

00000ce8 <.LBB633>:
     ce8:	01871693          	slli	a3,a4,0x18
     cec:	0083d793          	srli	a5,t2,0x8
     cf0:	8fd5                	or	a5,a5,a3

00000cf2 <.LBE633>:
     cf2:	56aa                	lw	a3,168(sp)

00000cf4 <.LBB634>:
     cf4:	8721                	srai	a4,a4,0x8

00000cf6 <.LBE634>:
     cf6:	554a                	lw	a0,176(sp)
     cf8:	00d78633          	add	a2,a5,a3
     cfc:	56ba                	lw	a3,172(sp)
     cfe:	00f637b3          	sltu	a5,a2,a5
     d02:	5a6a                	lw	s4,184(sp)
     d04:	9736                	add	a4,a4,a3
     d06:	973e                	add	a4,a4,a5

00000d08 <.LBB635>:
     d08:	01871693          	slli	a3,a4,0x18
     d0c:	00865793          	srli	a5,a2,0x8
     d10:	8fd5                	or	a5,a5,a3

00000d12 <.LBE635>:
     d12:	56da                	lw	a3,180(sp)
     d14:	953e                	add	a0,a0,a5

00000d16 <.LBB636>:
     d16:	8721                	srai	a4,a4,0x8

00000d18 <.LBE636>:
     d18:	00f537b3          	sltu	a5,a0,a5
     d1c:	9736                	add	a4,a4,a3
     d1e:	973e                	add	a4,a4,a5

00000d20 <.LBB637>:
     d20:	01871693          	slli	a3,a4,0x18
     d24:	00855793          	srli	a5,a0,0x8
     d28:	8fd5                	or	a5,a5,a3

00000d2a <.LBE637>:
     d2a:	56fa                	lw	a3,188(sp)
     d2c:	9a3e                	add	s4,s4,a5

00000d2e <.LBB638>:
     d2e:	8721                	srai	a4,a4,0x8

00000d30 <.LBE638>:
     d30:	00fa37b3          	sltu	a5,s4,a5
     d34:	9736                	add	a4,a4,a3
     d36:	973e                	add	a4,a4,a5

00000d38 <.LVL160>:
     d38:	428e                	lw	t0,192(sp)

00000d3a <.LBB639>:
     d3a:	01871693          	slli	a3,a4,0x18
     d3e:	008a5793          	srli	a5,s4,0x8
     d42:	8fd5                	or	a5,a5,a3

00000d44 <.LBE639>:
     d44:	469e                	lw	a3,196(sp)
     d46:	92be                	add	t0,t0,a5

00000d48 <.LBB640>:
     d48:	8721                	srai	a4,a4,0x8

00000d4a <.LBE640>:
     d4a:	00f2b7b3          	sltu	a5,t0,a5
     d4e:	9736                	add	a4,a4,a3
     d50:	973e                	add	a4,a4,a5

00000d52 <.LBB641>:
     d52:	01871693          	slli	a3,a4,0x18
     d56:	0082d793          	srli	a5,t0,0x8
     d5a:	8fd5                	or	a5,a5,a3

00000d5c <.LBE641>:
     d5c:	46ae                	lw	a3,200(sp)

00000d5e <.LBB642>:
     d5e:	8721                	srai	a4,a4,0x8

00000d60 <.LBE642>:
     d60:	49ee                	lw	s3,216(sp)
     d62:	00d785b3          	add	a1,a5,a3
     d66:	46be                	lw	a3,204(sp)
     d68:	00f5b7b3          	sltu	a5,a1,a5

00000d6c <.LBB643>:
     d6c:	c42e                	sw	a1,8(sp)

00000d6e <.LBE643>:
     d6e:	9736                	add	a4,a4,a3
     d70:	973e                	add	a4,a4,a5

00000d72 <.LBB644>:
     d72:	01871693          	slli	a3,a4,0x18
     d76:	0085d793          	srli	a5,a1,0x8

00000d7a <.LBE644>:
     d7a:	45ce                	lw	a1,208(sp)

00000d7c <.LBB645>:
     d7c:	8fd5                	or	a5,a5,a3

00000d7e <.LBE645>:
     d7e:	46de                	lw	a3,212(sp)
     d80:	95be                	add	a1,a1,a5

00000d82 <.LBB646>:
     d82:	8721                	srai	a4,a4,0x8

00000d84 <.LBE646>:
     d84:	00f5b7b3          	sltu	a5,a1,a5
     d88:	9736                	add	a4,a4,a3
     d8a:	973e                	add	a4,a4,a5

00000d8c <.LBB647>:
     d8c:	01871693          	slli	a3,a4,0x18
     d90:	0085d793          	srli	a5,a1,0x8
     d94:	8fd5                	or	a5,a5,a3

00000d96 <.LBE647>:
     d96:	46fe                	lw	a3,220(sp)
     d98:	99be                	add	s3,s3,a5

00000d9a <.LBB648>:
     d9a:	8721                	srai	a4,a4,0x8

00000d9c <.LBE648>:
     d9c:	00f9b7b3          	sltu	a5,s3,a5
     da0:	9736                	add	a4,a4,a3
     da2:	973e                	add	a4,a4,a5

00000da4 <.LVL169>:
     da4:	5f8e                	lw	t6,224(sp)

00000da6 <.LBB649>:
     da6:	01871693          	slli	a3,a4,0x18
     daa:	0089d793          	srli	a5,s3,0x8
     dae:	8fd5                	or	a5,a5,a3

00000db0 <.LBE649>:
     db0:	569e                	lw	a3,228(sp)
     db2:	9fbe                	add	t6,t6,a5

00000db4 <.LBB650>:
     db4:	8721                	srai	a4,a4,0x8

00000db6 <.LBE650>:
     db6:	00ffb7b3          	sltu	a5,t6,a5
     dba:	9736                	add	a4,a4,a3
     dbc:	973e                	add	a4,a4,a5

00000dbe <.LBB651>:
     dbe:	01871693          	slli	a3,a4,0x18
     dc2:	008fd793          	srli	a5,t6,0x8
     dc6:	c232                	sw	a2,4(sp)
     dc8:	8fd5                	or	a5,a5,a3

00000dca <.LBE651>:
     dca:	56ae                	lw	a3,232(sp)

00000dcc <.LBB652>:
     dcc:	8721                	srai	a4,a4,0x8

00000dce <.LBE652>:
     dce:	564e                	lw	a2,240(sp)
     dd0:	00d78433          	add	s0,a5,a3
     dd4:	56be                	lw	a3,236(sp)
     dd6:	00f437b3          	sltu	a5,s0,a5
     dda:	596e                	lw	s2,248(sp)
     ddc:	9736                	add	a4,a4,a3
     dde:	973e                	add	a4,a4,a5

00000de0 <.LBB653>:
     de0:	01871693          	slli	a3,a4,0x18
     de4:	00845793          	srli	a5,s0,0x8
     de8:	8fd5                	or	a5,a5,a3

00000dea <.LBE653>:
     dea:	56de                	lw	a3,244(sp)
     dec:	963e                	add	a2,a2,a5

00000dee <.LBB654>:
     dee:	8721                	srai	a4,a4,0x8

00000df0 <.LBE654>:
     df0:	00f637b3          	sltu	a5,a2,a5
     df4:	9736                	add	a4,a4,a3
     df6:	973e                	add	a4,a4,a5

00000df8 <.LBB655>:
     df8:	01871693          	slli	a3,a4,0x18
     dfc:	00865793          	srli	a5,a2,0x8
     e00:	8fd5                	or	a5,a5,a3

00000e02 <.LBE655>:
     e02:	56fe                	lw	a3,252(sp)
     e04:	993e                	add	s2,s2,a5

00000e06 <.LBB656>:
     e06:	8721                	srai	a4,a4,0x8

00000e08 <.LBE656>:
     e08:	00f937b3          	sltu	a5,s2,a5
     e0c:	9736                	add	a4,a4,a3
     e0e:	973e                	add	a4,a4,a5

00000e10 <.LVL177>:
     e10:	10012f03          	lw	t5,256(sp)

00000e14 <.LBB657>:
     e14:	01871693          	slli	a3,a4,0x18
     e18:	00895793          	srli	a5,s2,0x8
     e1c:	8fd5                	or	a5,a5,a3

00000e1e <.LBE657>:
     e1e:	10412683          	lw	a3,260(sp)
     e22:	9f3e                	add	t5,t5,a5

00000e24 <.LBB658>:
     e24:	8721                	srai	a4,a4,0x8

00000e26 <.LBE658>:
     e26:	00ff37b3          	sltu	a5,t5,a5
     e2a:	9736                	add	a4,a4,a3
     e2c:	973e                	add	a4,a4,a5

00000e2e <.LBB659>:
     e2e:	01871693          	slli	a3,a4,0x18
     e32:	008f5793          	srli	a5,t5,0x8
     e36:	8fd5                	or	a5,a5,a3

00000e38 <.LBE659>:
     e38:	10812683          	lw	a3,264(sp)

00000e3c <.LBB660>:
     e3c:	8721                	srai	a4,a4,0x8

00000e3e <.LBE660>:
     e3e:	11412883          	lw	a7,276(sp)
     e42:	00d784b3          	add	s1,a5,a3
     e46:	10c12683          	lw	a3,268(sp)
     e4a:	00f4b7b3          	sltu	a5,s1,a5

00000e4e <.LBB661>:
     e4e:	c826                	sw	s1,16(sp)

00000e50 <.LBE661>:
     e50:	9736                	add	a4,a4,a3
     e52:	973e                	add	a4,a4,a5

00000e54 <.LBB662>:
     e54:	01871693          	slli	a3,a4,0x18
     e58:	0084d793          	srli	a5,s1,0x8
     e5c:	8fd5                	or	a5,a5,a3

00000e5e <.LBE662>:
     e5e:	11012683          	lw	a3,272(sp)

00000e62 <.LBB663>:
     e62:	8721                	srai	a4,a4,0x8

00000e64 <.LBE663>:
     e64:	9746                	add	a4,a4,a7
     e66:	96be                	add	a3,a3,a5
     e68:	00f6b7b3          	sltu	a5,a3,a5
     e6c:	973e                	add	a4,a4,a5

00000e6e <.LVL183>:
     e6e:	11812483          	lw	s1,280(sp)

00000e72 <.LBB664>:
     e72:	01871893          	slli	a7,a4,0x18
     e76:	0086d793          	srli	a5,a3,0x8
     e7a:	00f8e7b3          	or	a5,a7,a5

00000e7e <.LBE664>:
     e7e:	11c12883          	lw	a7,284(sp)
     e82:	94be                	add	s1,s1,a5

00000e84 <.LBB665>:
     e84:	8721                	srai	a4,a4,0x8

00000e86 <.LBE665>:
     e86:	9746                	add	a4,a4,a7
     e88:	00f4b7b3          	sltu	a5,s1,a5
     e8c:	97ba                	add	a5,a5,a4

00000e8e <.LVL185>:
     e8e:	12012e83          	lw	t4,288(sp)

00000e92 <.LBB666>:
     e92:	01879893          	slli	a7,a5,0x18
     e96:	0084d713          	srli	a4,s1,0x8
     e9a:	00e8e733          	or	a4,a7,a4

00000e9e <.LBE666>:
     e9e:	12412883          	lw	a7,292(sp)
     ea2:	9eba                	add	t4,t4,a4

00000ea4 <.LBB667>:
     ea4:	87a1                	srai	a5,a5,0x8

00000ea6 <.LBE667>:
     ea6:	00eeb733          	sltu	a4,t4,a4
     eaa:	97c6                	add	a5,a5,a7
     eac:	97ba                	add	a5,a5,a4

00000eae <.LBB668>:
     eae:	01879713          	slli	a4,a5,0x18
     eb2:	008ed893          	srli	a7,t4,0x8
     eb6:	011768b3          	or	a7,a4,a7

00000eba <.LBE668>:
     eba:	12812703          	lw	a4,296(sp)

00000ebe <.LBB669>:
     ebe:	87a1                	srai	a5,a5,0x8
     ec0:	c622                	sw	s0,12(sp)

00000ec2 <.LBE669>:
     ec2:	00e88333          	add	t1,a7,a4
     ec6:	12c12703          	lw	a4,300(sp)
     eca:	011338b3          	sltu	a7,t1,a7

00000ece <.LBB670>:
     ece:	ca1a                	sw	t1,20(sp)

00000ed0 <.LBE670>:
     ed0:	97ba                	add	a5,a5,a4
     ed2:	97c6                	add	a5,a5,a7

00000ed4 <.LBB671>:
     ed4:	01879713          	slli	a4,a5,0x18
     ed8:	00835313          	srli	t1,t1,0x8
     edc:	00676333          	or	t1,a4,t1

00000ee0 <.LBE671>:
     ee0:	13012703          	lw	a4,304(sp)

00000ee4 <.LBB672>:
     ee4:	87a1                	srai	a5,a5,0x8

00000ee6 <.LBE672>:
     ee6:	13812403          	lw	s0,312(sp)
     eea:	971a                	add	a4,a4,t1
     eec:	006738b3          	sltu	a7,a4,t1
     ef0:	13412303          	lw	t1,308(sp)
     ef4:	14012e03          	lw	t3,320(sp)
     ef8:	14812c03          	lw	s8,328(sp)
     efc:	979a                	add	a5,a5,t1
     efe:	97c6                	add	a5,a5,a7

00000f00 <.LBB673>:
     f00:	01879313          	slli	t1,a5,0x18
     f04:	00875893          	srli	a7,a4,0x8
     f08:	011368b3          	or	a7,t1,a7

00000f0c <.LBE673>:
     f0c:	13c12303          	lw	t1,316(sp)
     f10:	9446                	add	s0,s0,a7

00000f12 <.LBB674>:
     f12:	87a1                	srai	a5,a5,0x8

00000f14 <.LBE674>:
     f14:	011438b3          	sltu	a7,s0,a7
     f18:	979a                	add	a5,a5,t1
     f1a:	97c6                	add	a5,a5,a7

00000f1c <.LBB675>:
     f1c:	01879313          	slli	t1,a5,0x18
     f20:	00845893          	srli	a7,s0,0x8
     f24:	011368b3          	or	a7,t1,a7

00000f28 <.LBE675>:
     f28:	14412303          	lw	t1,324(sp)
     f2c:	9e46                	add	t3,t3,a7

00000f2e <.LBB676>:
     f2e:	87a1                	srai	a5,a5,0x8

00000f30 <.LBE676>:
     f30:	011e38b3          	sltu	a7,t3,a7
     f34:	979a                	add	a5,a5,t1
     f36:	97c6                	add	a5,a5,a7

00000f38 <.LBB677>:
     f38:	01879313          	slli	t1,a5,0x18
     f3c:	008e5893          	srli	a7,t3,0x8
     f40:	011368b3          	or	a7,t1,a7

00000f44 <.LBE677>:
     f44:	14c12303          	lw	t1,332(sp)
     f48:	9c46                	add	s8,s8,a7

00000f4a <.LBB678>:
     f4a:	87a1                	srai	a5,a5,0x8

00000f4c <.LBE678>:
     f4c:	979a                	add	a5,a5,t1
     f4e:	011c38b3          	sltu	a7,s8,a7
     f52:	98be                	add	a7,a7,a5

00000f54 <.LBB679>:
     f54:	01889793          	slli	a5,a7,0x18
     f58:	008c5313          	srli	t1,s8,0x8
     f5c:	0067e333          	or	t1,a5,t1

00000f60 <.LBE679>:
     f60:	15012783          	lw	a5,336(sp)
     f64:	15412a83          	lw	s5,340(sp)

00000f68 <.LBB680>:
     f68:	4088d893          	srai	a7,a7,0x8

00000f6c <.LBE680>:
     f6c:	979a                	add	a5,a5,t1
     f6e:	0067b333          	sltu	t1,a5,t1
     f72:	98d6                	add	a7,a7,s5
     f74:	989a                	add	a7,a7,t1

00000f76 <.LBB681>:
     f76:	01889a93          	slli	s5,a7,0x18
     f7a:	0087d313          	srli	t1,a5,0x8
     f7e:	006ae333          	or	t1,s5,t1

00000f82 <.LBE681>:
     f82:	15812a83          	lw	s5,344(sp)
     f86:	15c12d83          	lw	s11,348(sp)

00000f8a <.LBB682>:
     f8a:	4088d893          	srai	a7,a7,0x8

00000f8e <.LBE682>:
     f8e:	9a9a                	add	s5,s5,t1
     f90:	006ab333          	sltu	t1,s5,t1
     f94:	98ee                	add	a7,a7,s11
     f96:	989a                	add	a7,a7,t1

00000f98 <.LBB683>:
     f98:	08e2                	slli	a7,a7,0x18
     f9a:	008add93          	srli	s11,s5,0x8
     f9e:	01b8edb3          	or	s11,a7,s11

00000fa2 <.LBE683>:
               R (I) := Byte (XL (I) mod 256);
     fa2:	0ffd7893          	andi	a7,s10,255
               XL (I + 1) := XL (I + 1) + S3C;
     fa6:	16012d03          	lw	s10,352(sp)
     faa:	0ffafa93          	andi	s5,s5,255
     fae:	0aa2                	slli	s5,s5,0x8
     fb0:	9d6e                	add	s10,s10,s11
               R (I) := Byte (XL (I) mod 256);
     fb2:	0ffbfb93          	andi	s7,s7,255
     fb6:	0ffb7b13          	andi	s6,s6,255
     fba:	0ffa7a13          	andi	s4,s4,255
     fbe:	0ff9f993          	andi	s3,s3,255
     fc2:	0ff97913          	andi	s2,s2,255
     fc6:	0ff4f493          	andi	s1,s1,255
     fca:	0ff47413          	andi	s0,s0,255
     fce:	ff010337          	lui	t1,0xff010
     fd2:	0ff7f793          	andi	a5,a5,255
     fd6:	137d                	addi	t1,t1,-1
     fd8:	0ba2                	slli	s7,s7,0x8
     fda:	0b22                	slli	s6,s6,0x8
     fdc:	0a22                	slli	s4,s4,0x8
     fde:	09a2                	slli	s3,s3,0x8
     fe0:	0922                	slli	s2,s2,0x8
     fe2:	04a2                	slli	s1,s1,0x8
     fe4:	0422                	slli	s0,s0,0x8
     fe6:	0157e7b3          	or	a5,a5,s5
     fea:	0ff87813          	andi	a6,a6,255
     fee:	0ffd7a93          	andi	s5,s10,255
     ff2:	0ff57513          	andi	a0,a0,255
     ff6:	0ff5f593          	andi	a1,a1,255
     ffa:	0ff67613          	andi	a2,a2,255
     ffe:	0ff6f693          	andi	a3,a3,255
    1002:	0ff77713          	andi	a4,a4,255
    1006:	0178e8b3          	or	a7,a7,s7
    100a:	01686833          	or	a6,a6,s6
    100e:	01456533          	or	a0,a0,s4
    1012:	0135e5b3          	or	a1,a1,s3
    1016:	01266633          	or	a2,a2,s2
    101a:	8ec5                	or	a3,a3,s1
    101c:	8f41                	or	a4,a4,s0
    101e:	0ac2                	slli	s5,s5,0x10
    1020:	0067f7b3          	and	a5,a5,t1
    1024:	0066f4b3          	and	s1,a3,t1
    1028:	00667633          	and	a2,a2,t1
    102c:	00677733          	and	a4,a4,t1
    1030:	0068f8b3          	and	a7,a7,t1
    1034:	00687833          	and	a6,a6,t1
    1038:	00657533          	and	a0,a0,t1
    103c:	0065f5b3          	and	a1,a1,t1
    1040:	0157e333          	or	t1,a5,s5
               XL (I + 1) := XL (I + 1) + S3C;
    1044:	16812783          	lw	a5,360(sp)

00001048 <.LBB684>:
    1048:	008d5d13          	srli	s10,s10,0x8

0000104c <.LBE684>:
               R (I) := Byte (XL (I) mod 256);
    104c:	0ff0f093          	andi	ra,ra,255
               XL (I + 1) := XL (I + 1) + S3C;
    1050:	9d3e                	add	s10,s10,a5
               R (I) := Byte (XL (I) mod 256);
    1052:	4792                	lw	a5,4(sp)
    1054:	0ffe7e13          	andi	t3,t3,255
    1058:	00c2                	slli	ra,ra,0x10
    105a:	0e42                	slli	t3,t3,0x10
    105c:	0018e8b3          	or	a7,a7,ra
    1060:	01879093          	slli	ra,a5,0x18
    1064:	01c767b3          	or	a5,a4,t3
    1068:	4722                	lw	a4,8(sp)
    106a:	01000437          	lui	s0,0x1000
    106e:	147d                	addi	s0,s0,-1
    1070:	00837e33          	and	t3,t1,s0
    1074:	0ff2f293          	andi	t0,t0,255
    1078:	01871313          	slli	t1,a4,0x18
    107c:	4732                	lw	a4,12(sp)
    107e:	02c2                	slli	t0,t0,0x10
    1080:	0088f8b3          	and	a7,a7,s0
    1084:	00556533          	or	a0,a0,t0
    1088:	0ff3f393          	andi	t2,t2,255
    108c:	0ce2                	slli	s9,s9,0x18
    108e:	0198ecb3          	or	s9,a7,s9
    1092:	03c2                	slli	t2,t2,0x10
    1094:	008578b3          	and	a7,a0,s0
    1098:	0fffff93          	andi	t6,t6,255
    109c:	01871513          	slli	a0,a4,0x18
    10a0:	0fff7f13          	andi	t5,t5,255
    10a4:	4752                	lw	a4,20(sp)
    10a6:	0ffefe93          	andi	t4,t4,255
    10aa:	00786833          	or	a6,a6,t2
    10ae:	0fc2                	slli	t6,t6,0x10
    10b0:	0f42                	slli	t5,t5,0x10
    10b2:	0ec2                	slli	t4,t4,0x10
    10b4:	00887833          	and	a6,a6,s0
    10b8:	01f5e5b3          	or	a1,a1,t6
    10bc:	01e666b3          	or	a3,a2,t5
    10c0:	01d4eeb3          	or	t4,s1,t4
    10c4:	44c2                	lw	s1,16(sp)
    10c6:	001860b3          	or	ra,a6,ra
    10ca:	01871613          	slli	a2,a4,0x18
    10ce:	0085f833          	and	a6,a1,s0
    10d2:	008ef733          	and	a4,t4,s0
    10d6:	8ee1                	and	a3,a3,s0
    10d8:	8fe1                	and	a5,a5,s0

000010da <.LBE555>:
      Eliminate_Limbs_62_To_32;

      pragma Warnings (GNATProve, Off, "unused assignment");
      --  Unused assignment to XL here expected
      Finalize;
      return R;
    10da:	4402                	lw	s0,0(sp)

000010dc <.LBB687>:
               R (I) := Byte (XL (I) mod 256);
    10dc:	01849593          	slli	a1,s1,0x18
    10e0:	0d62                	slli	s10,s10,0x18
    10e2:	0c62                	slli	s8,s8,0x18
    10e4:	01ae6e33          	or	t3,t3,s10
    10e8:	00a86833          	or	a6,a6,a0
    10ec:	8ecd                	or	a3,a3,a1
    10ee:	8f51                	or	a4,a4,a2
    10f0:	0187e7b3          	or	a5,a5,s8
    10f4:	0068e8b3          	or	a7,a7,t1

000010f8 <.LBE687>:
      return R;
    10f8:	088c                	addi	a1,sp,80
    10fa:	8522                	mv	a0,s0
    10fc:	02000613          	li	a2,32

00001100 <.LBB688>:
               R (I) := Byte (XL (I) mod 256);
    1100:	c8e6                	sw	s9,80(sp)
    1102:	ca86                	sw	ra,84(sp)
    1104:	ccc6                	sw	a7,88(sp)
    1106:	cec2                	sw	a6,92(sp)
    1108:	d0b6                	sw	a3,96(sp)
    110a:	d2ba                	sw	a4,100(sp)
    110c:	d4be                	sw	a5,104(sp)
    110e:	d6f2                	sw	t3,108(sp)

00001110 <.LBE688>:
      return R;
    1110:	00000097          	auipc	ra,0x0
    1114:	000080e7          	jalr	ra # 1110 <.LBE688>

00001118 <.LVL205>:
   end ModL;
    1118:	2ac12083          	lw	ra,684(sp)
    111c:	8522                	mv	a0,s0
    111e:	2a812403          	lw	s0,680(sp)
    1122:	2a412483          	lw	s1,676(sp)
    1126:	2a012903          	lw	s2,672(sp)
    112a:	29c12983          	lw	s3,668(sp)
    112e:	29812a03          	lw	s4,664(sp)
    1132:	29412a83          	lw	s5,660(sp)
    1136:	29012b03          	lw	s6,656(sp)
    113a:	28c12b83          	lw	s7,652(sp)
    113e:	28812c03          	lw	s8,648(sp)
    1142:	28412c83          	lw	s9,644(sp)
    1146:	28012d03          	lw	s10,640(sp)
    114a:	27c12d83          	lw	s11,636(sp)
    114e:	2b010113          	addi	sp,sp,688
    1152:	8082                	ret

Disassembly of section .text.sparknacl__sign__hash_reduce:

00000000 <sparknacl__sign__hash_reduce>:

   function Hash_Reduce (M : in Byte_Seq) return Bytes_32
   0:	db010113          	addi	sp,sp,-592
   4:	24812423          	sw	s0,584(sp)
   8:	842a                	mv	s0,a0
   is
      R : Hashing.Digest;
      X : I64_Seq_64;
   begin
      Hashing.Hash (R, M);
   a:	850a                	mv	a0,sp
   function Hash_Reduce (M : in Byte_Seq) return Bytes_32
   c:	24112623          	sw	ra,588(sp)
      Hashing.Hash (R, M);
  10:	00000097          	auipc	ra,0x0
  14:	000080e7          	jalr	ra # 10 <sparknacl__sign__hash_reduce+0x10>

00000018 <.LVL209>:
      X := (others => 0);
  18:	20000613          	li	a2,512
  1c:	4581                	li	a1,0
  1e:	0088                	addi	a0,sp,64
  20:	00000097          	auipc	ra,0x0
  24:	000080e7          	jalr	ra # 20 <.LVL209+0x8>

00000028 <.LVL210>:
  28:	870a                	mv	a4,sp
  2a:	009c                	addi	a5,sp,64
  2c:	0490                	addi	a2,sp,576

0000002e <.L76>:
      for I in Index_64 loop
         X (I) := I64 (R (I));
  2e:	00074683          	lbu	a3,0(a4)
  32:	0007a223          	sw	zero,4(a5)
      for I in Index_64 loop
  36:	07a1                	addi	a5,a5,8
         X (I) := I64 (R (I));
  38:	fed7ac23          	sw	a3,-8(a5)
      for I in Index_64 loop
  3c:	0705                	addi	a4,a4,1

0000003e <.LVL212>:
  3e:	fec798e3          	bne	a5,a2,2e <.L76>

00000042 <.LBE697>:
      end loop;

      pragma Assert
        (for all K in Index_64 => X (K) in I64_Byte);

      return ModL (X);
  42:	8522                	mv	a0,s0
  44:	008c                	addi	a1,sp,64
  46:	00000097          	auipc	ra,0x0
  4a:	000080e7          	jalr	ra # 46 <.LBE697+0x4>

0000004e <.LVL213>:
   end Hash_Reduce;
  4e:	24c12083          	lw	ra,588(sp)
  52:	8522                	mv	a0,s0
  54:	24812403          	lw	s0,584(sp)
  58:	25010113          	addi	sp,sp,592
  5c:	8082                	ret

Disassembly of section .text.sparknacl__sign__unpackneg:

00000000 <sparknacl__sign__unpackneg>:

   procedure Unpackneg (R  :    out GF_Vector_4;
   0:	85010113          	addi	sp,sp,-1968
   4:	79312e23          	sw	s3,1948(sp)

00000008 <.LBB724>:

      --  Note: refactoring here to functional/SSA form reduces the
      --  number of calls to "*" from 8 in the original TweetNaCl code
      --  to 5 from here until the initialization of R0, but only if
      --  "*" on GF is commutative.
      R1          : constant Normal_GF := Utils.Unpack_25519 (P);
   8:	08010993          	addi	s3,sp,128

0000000c <.LBE724>:
   procedure Unpackneg (R  :    out GF_Vector_4;
   c:	7a812423          	sw	s0,1960(sp)
  10:	842a                	mv	s0,a0

00000012 <.LBB758>:
      R1          : constant Normal_GF := Utils.Unpack_25519 (P);
  12:	854e                	mv	a0,s3

00000014 <.LBE758>:
   procedure Unpackneg (R  :    out GF_Vector_4;
  14:	7a112623          	sw	ra,1964(sp)
  18:	7a912223          	sw	s1,1956(sp)
  1c:	79412c23          	sw	s4,1944(sp)
  20:	79612823          	sw	s6,1936(sp)

00000024 <.LBB725>:

   function "*" (Left, Right : in Normal_GF) return Normal_GF
     with Global => null;

   function Square (A : in Normal_GF) return Normal_GF
     is (A * A)
  24:	10010a13          	addi	s4,sp,256

00000028 <.LBE725>:
  28:	8b2e                	mv	s6,a1
  2a:	7b212023          	sw	s2,1952(sp)
  2e:	79512a23          	sw	s5,1940(sp)
  32:	79712623          	sw	s7,1932(sp)
  36:	79812423          	sw	s8,1928(sp)

0000003a <.LBB760>:
      R1          : constant Normal_GF := Utils.Unpack_25519 (P);
  3a:	00000097          	auipc	ra,0x0
  3e:	000080e7          	jalr	ra # 3a <.LBB760>

00000042 <.LBB728>:
  42:	864e                	mv	a2,s3
  44:	85ce                	mv	a1,s3
  46:	8552                	mv	a0,s4
  48:	00000097          	auipc	ra,0x0
  4c:	000080e7          	jalr	ra # 48 <.LBB728+0x6>

00000050 <.LBE728>:
      R2          :          Normal_GF renames GF_1;
      R1_Squared  : constant Normal_GF := Square (R1);
      Num         : constant Normal_GF := R1_Squared - R2;
  50:	000004b7          	lui	s1,0x0
  54:	00048613          	mv	a2,s1
  58:	85d2                	mv	a1,s4
  5a:	0308                	addi	a0,sp,384
  5c:	00000097          	auipc	ra,0x0
  60:	000080e7          	jalr	ra # 5c <.LBE728+0xc>

00000064 <.LVL219>:
      Den         : constant Normal_GF := R2 + (R1_Squared * GF_D);
  64:	00000637          	lui	a2,0x0
  68:	00060613          	mv	a2,a2
  6c:	85d2                	mv	a1,s4
  6e:	0408                	addi	a0,sp,512
  70:	00000097          	auipc	ra,0x0
  74:	000080e7          	jalr	ra # 70 <.LVL219+0xc>

00000078 <.LVL220>:
  78:	00048593          	mv	a1,s1
  7c:	0410                	addi	a2,sp,512
  7e:	0508                	addi	a0,sp,640
  80:	00000097          	auipc	ra,0x0
  84:	000080e7          	jalr	ra # 80 <.LVL220+0x8>

00000088 <.LBB729>:
  88:	0510                	addi	a2,sp,640

0000008a <.LVL222>:
  8a:	85b2                	mv	a1,a2
  8c:	0608                	addi	a0,sp,768
  8e:	00000097          	auipc	ra,0x0
  92:	000080e7          	jalr	ra # 8e <.LVL222+0x4>

00000096 <.LBB731>:
  96:	0610                	addi	a2,sp,768

00000098 <.LVL224>:
  98:	85b2                	mv	a1,a2
  9a:	0708                	addi	a0,sp,896
  9c:	00000097          	auipc	ra,0x0
  a0:	000080e7          	jalr	ra # 9c <.LVL224+0x4>

000000a4 <.LBE731>:
      Den_Power_2 : constant Normal_GF := Square (Den);
      Den_Power_4 : constant Normal_GF := Square (Den_Power_2);
      Num_Den2    : constant Normal_GF := (Num * Den) * Den_Power_2;
  a4:	0510                	addi	a2,sp,640
  a6:	030c                	addi	a1,sp,384
  a8:	40010513          	addi	a0,sp,1024
  ac:	00000097          	auipc	ra,0x0
  b0:	000080e7          	jalr	ra # ac <.LBE731+0x8>

000000b4 <.LVL226>:
  b4:	0610                	addi	a2,sp,768
  b6:	40010593          	addi	a1,sp,1024
  ba:	48010513          	addi	a0,sp,1152
  be:	00000097          	auipc	ra,0x0
  c2:	000080e7          	jalr	ra # be <.LVL226+0xa>

000000c6 <.LVL227>:

      R0    : Normal_GF := Pow_2523 ((Den_Power_4 * Num_Den2)) * Num_Den2;
  c6:	48010613          	addi	a2,sp,1152
  ca:	070c                	addi	a1,sp,896
  cc:	58010513          	addi	a0,sp,1408
  d0:	00000097          	auipc	ra,0x0
  d4:	000080e7          	jalr	ra # d0 <.LVL227+0xa>

000000d8 <.LBB734>:
         C := I;
  d8:	60010713          	addi	a4,sp,1536
  dc:	58010793          	addi	a5,sp,1408

000000e0 <.LVL229>:
  e0:	84ba                	mv	s1,a4
  e2:	883a                	mv	a6,a4

000000e4 <.L80>:
  e4:	4388                	lw	a0,0(a5)
  e6:	43cc                	lw	a1,4(a5)
  e8:	4790                	lw	a2,8(a5)
  ea:	47d4                	lw	a3,12(a5)
  ec:	c308                	sw	a0,0(a4)
  ee:	c34c                	sw	a1,4(a4)
  f0:	c710                	sw	a2,8(a4)
  f2:	c754                	sw	a3,12(a4)
  f4:	07c1                	addi	a5,a5,16
  f6:	0741                	addi	a4,a4,16
  f8:	ff0796e3          	bne	a5,a6,e4 <.L80>

000000fc <.LBB736>:
         for A in reverse 0 .. 250 loop
  fc:	0fb00c13          	li	s8,251
 100:	70010913          	addi	s2,sp,1792
 104:	68010a93          	addi	s5,sp,1664
 108:	4b85                	li	s7,1

0000010a <.L81>:
 10a:	8626                	mv	a2,s1
 10c:	85a6                	mv	a1,s1
 10e:	854a                	mv	a0,s2
 110:	00000097          	auipc	ra,0x0
 114:	000080e7          	jalr	ra # 110 <.L81+0x6>

00000118 <.LBE737>:
 118:	1c7d                	addi	s8,s8,-1
            C2 := Square (C);
 11a:	87ca                	mv	a5,s2
 11c:	8756                	mv	a4,s5

0000011e <.L82>:
 11e:	47d4                	lw	a3,12(a5)
 120:	4388                	lw	a0,0(a5)
 122:	43cc                	lw	a1,4(a5)
 124:	4790                	lw	a2,8(a5)
 126:	c754                	sw	a3,12(a4)
 128:	c308                	sw	a0,0(a4)
 12a:	c34c                	sw	a1,4(a4)
 12c:	c710                	sw	a2,8(a4)
 12e:	07c1                	addi	a5,a5,16
 130:	78010693          	addi	a3,sp,1920
 134:	0741                	addi	a4,a4,16
 136:	fed794e3          	bne	a5,a3,11e <.L82>
            if A = 1 then
 13a:	357c0b63          	beq	s8,s7,490 <.L112>
               C := C2 * I;
 13e:	58010613          	addi	a2,sp,1408

00000142 <.LVL235>:
 142:	85d6                	mv	a1,s5
 144:	850a                	mv	a0,sp
 146:	00000097          	auipc	ra,0x0
 14a:	000080e7          	jalr	ra # 146 <.LVL235+0x4>

0000014e <.LVL236>:
 14e:	878a                	mv	a5,sp
 150:	8726                	mv	a4,s1

00000152 <.L86>:
 152:	4388                	lw	a0,0(a5)
 154:	43cc                	lw	a1,4(a5)
 156:	4790                	lw	a2,8(a5)
 158:	47d4                	lw	a3,12(a5)
 15a:	c308                	sw	a0,0(a4)
 15c:	c34c                	sw	a1,4(a4)
 15e:	c710                	sw	a2,8(a4)
 160:	c754                	sw	a3,12(a4)
 162:	07c1                	addi	a5,a5,16
 164:	0741                	addi	a4,a4,16
 166:	ff3796e3          	bne	a5,s3,152 <.L86>
         for A in reverse 0 .. 250 loop
 16a:	fa0c10e3          	bnez	s8,10a <.L81>

0000016e <.LBE736>:
         return C;
 16e:	87a6                	mv	a5,s1
 170:	50010713          	addi	a4,sp,1280

00000174 <.L87>:
 174:	4388                	lw	a0,0(a5)
 176:	43cc                	lw	a1,4(a5)
 178:	4790                	lw	a2,8(a5)
 17a:	47d4                	lw	a3,12(a5)
 17c:	c308                	sw	a0,0(a4)
 17e:	c34c                	sw	a1,4(a4)
 180:	c710                	sw	a2,8(a4)
 182:	c754                	sw	a3,12(a4)
 184:	07c1                	addi	a5,a5,16
 186:	0741                	addi	a4,a4,16
 188:	ff5796e3          	bne	a5,s5,174 <.L87>

0000018c <.LBE734>:
      R0    : Normal_GF := Pow_2523 ((Den_Power_4 * Num_Den2)) * Num_Den2;
 18c:	48010613          	addi	a2,sp,1152
 190:	50010593          	addi	a1,sp,1280
 194:	8526                	mv	a0,s1
 196:	00000097          	auipc	ra,0x0
 19a:	000080e7          	jalr	ra # 196 <.LBE734+0xa>

0000019e <.LBB743>:
 19e:	8626                	mv	a2,s1
 1a0:	85a6                	mv	a1,s1
 1a2:	854a                	mv	a0,s2
 1a4:	00000097          	auipc	ra,0x0
 1a8:	000080e7          	jalr	ra # 1a4 <.LBB743+0x6>

000001ac <.LBE743>:
      Check : Normal_GF;
   begin
      Check := Square (R0) * Den;
 1ac:	0510                	addi	a2,sp,640
 1ae:	85ca                	mv	a1,s2
 1b0:	850a                	mv	a0,sp
 1b2:	00000097          	auipc	ra,0x0
 1b6:	000080e7          	jalr	ra # 1b2 <.LBE743+0x6>

000001ba <.LVL240>:
 1ba:	878a                	mv	a5,sp
 1bc:	8756                	mv	a4,s5

000001be <.L88>:
 1be:	4388                	lw	a0,0(a5)
 1c0:	43cc                	lw	a1,4(a5)
 1c2:	4790                	lw	a2,8(a5)
 1c4:	47d4                	lw	a3,12(a5)
 1c6:	c308                	sw	a0,0(a4)
 1c8:	c34c                	sw	a1,4(a4)
 1ca:	c710                	sw	a2,8(a4)
 1cc:	c754                	sw	a3,12(a4)
 1ce:	07c1                	addi	a5,a5,16
 1d0:	0741                	addi	a4,a4,16
 1d2:	ff3796e3          	bne	a5,s3,1be <.L88>

000001d6 <.LBB745>:
         return Equal (Bytes_32'(Utils.Pack_25519 (Left)),
 1d6:	85d6                	mv	a1,s5
 1d8:	854a                	mv	a0,s2
 1da:	00000097          	auipc	ra,0x0
 1de:	000080e7          	jalr	ra # 1da <.LBB745+0x4>

000001e2 <.LVL242>:
                       Bytes_32'(Utils.Pack_25519 (Right)));
 1e2:	030c                	addi	a1,sp,384

000001e4 <.LVL243>:
 1e4:	58010513          	addi	a0,sp,1408
 1e8:	00000097          	auipc	ra,0x0
 1ec:	000080e7          	jalr	ra # 1e8 <.LVL243+0x4>

000001f0 <.LVL244>:
         return Equal (Bytes_32'(Utils.Pack_25519 (Left)),
 1f0:	00000bb7          	lui	s7,0x0
 1f4:	58010613          	addi	a2,sp,1408
 1f8:	000b8693          	mv	a3,s7
 1fc:	854a                	mv	a0,s2
 1fe:	000b8593          	mv	a1,s7
 202:	00000097          	auipc	ra,0x0
 206:	000080e7          	jalr	ra # 202 <.LVL244+0x12>

0000020a <.LBE745>:

      if Check /= Num then
 20a:	2a050263          	beqz	a0,4ae <.L113>

0000020e <.L89>:
 20e:	8626                	mv	a2,s1
 210:	85a6                	mv	a1,s1
 212:	854a                	mv	a0,s2
 214:	00000097          	auipc	ra,0x0
 218:	000080e7          	jalr	ra # 214 <.L89+0x6>

0000021c <.LBE748>:
         R0 := R0 * GF_I;
      end if;

      Check := Square (R0) * Den;
 21c:	0510                	addi	a2,sp,640
 21e:	85ca                	mv	a1,s2
 220:	850a                	mv	a0,sp
 222:	00000097          	auipc	ra,0x0
 226:	000080e7          	jalr	ra # 222 <.LBE748+0x6>

0000022a <.LVL248>:
 22a:	878a                	mv	a5,sp
 22c:	8756                	mv	a4,s5

0000022e <.L91>:
 22e:	4388                	lw	a0,0(a5)
 230:	43cc                	lw	a1,4(a5)
 232:	4790                	lw	a2,8(a5)
 234:	47d4                	lw	a3,12(a5)
 236:	c308                	sw	a0,0(a4)
 238:	c34c                	sw	a1,4(a4)
 23a:	c710                	sw	a2,8(a4)
 23c:	c754                	sw	a3,12(a4)
 23e:	07c1                	addi	a5,a5,16
 240:	0741                	addi	a4,a4,16
 242:	ff3796e3          	bne	a5,s3,22e <.L91>

00000246 <.LBB750>:
         return Equal (Bytes_32'(Utils.Pack_25519 (Left)),
 246:	85d6                	mv	a1,s5
 248:	854a                	mv	a0,s2
 24a:	00000097          	auipc	ra,0x0
 24e:	000080e7          	jalr	ra # 24a <.LBB750+0x4>

00000252 <.LVL250>:
                       Bytes_32'(Utils.Pack_25519 (Right)));
 252:	030c                	addi	a1,sp,384

00000254 <.LVL251>:
 254:	58010513          	addi	a0,sp,1408
 258:	00000097          	auipc	ra,0x0
 25c:	000080e7          	jalr	ra # 258 <.LVL251+0x4>

00000260 <.LVL252>:
         return Equal (Bytes_32'(Utils.Pack_25519 (Left)),
 260:	000b8693          	mv	a3,s7
 264:	000b8593          	mv	a1,s7
 268:	58010613          	addi	a2,sp,1408
 26c:	854a                	mv	a0,s2
 26e:	00000097          	auipc	ra,0x0
 272:	000080e7          	jalr	ra # 26e <.LVL252+0xe>

00000276 <.LVL253>:
 276:	8baa                	mv	s7,a0

00000278 <.LBE750>:

      if Check /= Num then
 278:	26051463          	bnez	a0,4e0 <.L92>
         R  := (others => GF_0);
 27c:	4781                	li	a5,0
 27e:	4801                	li	a6,0
 280:	c01c                	sw	a5,0(s0)
 282:	01042223          	sw	a6,4(s0) # 1000004 <.LLST56+0xffe77e>
 286:	c41c                	sw	a5,8(s0)
 288:	01042623          	sw	a6,12(s0)
 28c:	c81c                	sw	a5,16(s0)
 28e:	01042a23          	sw	a6,20(s0)
 292:	cc1c                	sw	a5,24(s0)
 294:	01042e23          	sw	a6,28(s0)
 298:	d01c                	sw	a5,32(s0)
 29a:	03042223          	sw	a6,36(s0)
 29e:	d41c                	sw	a5,40(s0)
 2a0:	03042623          	sw	a6,44(s0)
 2a4:	d81c                	sw	a5,48(s0)
 2a6:	03042a23          	sw	a6,52(s0)
 2aa:	dc1c                	sw	a5,56(s0)
 2ac:	03042e23          	sw	a6,60(s0)
 2b0:	c03c                	sw	a5,64(s0)
 2b2:	05042223          	sw	a6,68(s0)
 2b6:	c43c                	sw	a5,72(s0)
 2b8:	05042623          	sw	a6,76(s0)
 2bc:	c83c                	sw	a5,80(s0)
 2be:	05042a23          	sw	a6,84(s0)
 2c2:	cc3c                	sw	a5,88(s0)
 2c4:	05042e23          	sw	a6,92(s0)
 2c8:	d03c                	sw	a5,96(s0)
 2ca:	07042223          	sw	a6,100(s0)
 2ce:	d43c                	sw	a5,104(s0)
 2d0:	07042623          	sw	a6,108(s0)
 2d4:	d83c                	sw	a5,112(s0)
 2d6:	07042a23          	sw	a6,116(s0)
 2da:	dc3c                	sw	a5,120(s0)
 2dc:	07042e23          	sw	a6,124(s0)
 2e0:	08f42023          	sw	a5,128(s0)
 2e4:	09042223          	sw	a6,132(s0)
 2e8:	08f42423          	sw	a5,136(s0)
 2ec:	09042623          	sw	a6,140(s0)
 2f0:	08f42823          	sw	a5,144(s0)
 2f4:	09042a23          	sw	a6,148(s0)
 2f8:	08f42c23          	sw	a5,152(s0)
 2fc:	09042e23          	sw	a6,156(s0)
 300:	0af42023          	sw	a5,160(s0)
 304:	0b042223          	sw	a6,164(s0)
 308:	0af42423          	sw	a5,168(s0)
 30c:	0b042623          	sw	a6,172(s0)
 310:	0af42823          	sw	a5,176(s0)
 314:	0b042a23          	sw	a6,180(s0)
 318:	0af42c23          	sw	a5,184(s0)
 31c:	0b042e23          	sw	a6,188(s0)
 320:	0cf42023          	sw	a5,192(s0)
 324:	0d042223          	sw	a6,196(s0)
 328:	0cf42423          	sw	a5,200(s0)
 32c:	0d042623          	sw	a6,204(s0)
 330:	0cf42823          	sw	a5,208(s0)
 334:	0d042a23          	sw	a6,212(s0)
 338:	0cf42c23          	sw	a5,216(s0)
 33c:	0d042e23          	sw	a6,220(s0)
 340:	0ef42023          	sw	a5,224(s0)
 344:	0f042223          	sw	a6,228(s0)
 348:	0ef42423          	sw	a5,232(s0)
 34c:	0f042623          	sw	a6,236(s0)
 350:	0ef42823          	sw	a5,240(s0)
 354:	0f042a23          	sw	a6,244(s0)
 358:	0ef42c23          	sw	a5,248(s0)
 35c:	0f042e23          	sw	a6,252(s0)
 360:	10f42023          	sw	a5,256(s0)
 364:	11042223          	sw	a6,260(s0)
 368:	10f42423          	sw	a5,264(s0)
 36c:	11042623          	sw	a6,268(s0)
 370:	10f42823          	sw	a5,272(s0)
 374:	11042a23          	sw	a6,276(s0)
 378:	10f42c23          	sw	a5,280(s0)
 37c:	11042e23          	sw	a6,284(s0)
 380:	12f42023          	sw	a5,288(s0)
 384:	13042223          	sw	a6,292(s0)
 388:	12f42423          	sw	a5,296(s0)
 38c:	13042623          	sw	a6,300(s0)
 390:	12f42823          	sw	a5,304(s0)
 394:	13042a23          	sw	a6,308(s0)
 398:	12f42c23          	sw	a5,312(s0)
 39c:	13042e23          	sw	a6,316(s0)
 3a0:	14f42023          	sw	a5,320(s0)
 3a4:	15042223          	sw	a6,324(s0)
 3a8:	14f42423          	sw	a5,328(s0)
 3ac:	15042623          	sw	a6,332(s0)
 3b0:	14f42823          	sw	a5,336(s0)
 3b4:	15042a23          	sw	a6,340(s0)
 3b8:	14f42c23          	sw	a5,344(s0)
 3bc:	15042e23          	sw	a6,348(s0)
 3c0:	16f42023          	sw	a5,352(s0)
 3c4:	17042223          	sw	a6,356(s0)
 3c8:	16f42423          	sw	a5,360(s0)
 3cc:	17042623          	sw	a6,364(s0)
 3d0:	16f42823          	sw	a5,368(s0)
 3d4:	17042a23          	sw	a6,372(s0)
 3d8:	16f42c23          	sw	a5,376(s0)
 3dc:	17042e23          	sw	a6,380(s0)
 3e0:	18f42023          	sw	a5,384(s0)
 3e4:	19042223          	sw	a6,388(s0)
 3e8:	18f42423          	sw	a5,392(s0)
 3ec:	19042623          	sw	a6,396(s0)
 3f0:	18f42823          	sw	a5,400(s0)
 3f4:	19042a23          	sw	a6,404(s0)
 3f8:	18f42c23          	sw	a5,408(s0)
 3fc:	19042e23          	sw	a6,412(s0)
 400:	1af42023          	sw	a5,416(s0)
 404:	1b042223          	sw	a6,420(s0)
 408:	1af42423          	sw	a5,424(s0)
 40c:	1b042623          	sw	a6,428(s0)
 410:	1af42823          	sw	a5,432(s0)
 414:	1b042a23          	sw	a6,436(s0)
 418:	1af42c23          	sw	a5,440(s0)
 41c:	1b042e23          	sw	a6,444(s0)
 420:	1cf42023          	sw	a5,448(s0)
 424:	1d042223          	sw	a6,452(s0)
 428:	1cf42423          	sw	a5,456(s0)
 42c:	1d042623          	sw	a6,460(s0)
 430:	1cf42823          	sw	a5,464(s0)
 434:	1d042a23          	sw	a6,468(s0)
 438:	1cf42c23          	sw	a5,472(s0)
 43c:	1d042e23          	sw	a6,476(s0)
 440:	1ef42023          	sw	a5,480(s0)
 444:	1f042223          	sw	a6,484(s0)
 448:	1ef42423          	sw	a5,488(s0)
 44c:	1f042623          	sw	a6,492(s0)
 450:	1ef42823          	sw	a5,496(s0)
 454:	1f042a23          	sw	a6,500(s0)
 458:	1ef42c23          	sw	a5,504(s0)
 45c:	1f042e23          	sw	a6,508(s0)

00000460 <.L93>:
      R := (0 => R0,
            1 => R1,
            2 => R2,
            3 => R0 * R1);
      OK := True;
   end Unpackneg;
 460:	7ac12083          	lw	ra,1964(sp)
 464:	7a812403          	lw	s0,1960(sp)
 468:	7a412483          	lw	s1,1956(sp)
 46c:	7a012903          	lw	s2,1952(sp)
 470:	79c12983          	lw	s3,1948(sp)
 474:	79812a03          	lw	s4,1944(sp)
 478:	79412a83          	lw	s5,1940(sp)
 47c:	79012b03          	lw	s6,1936(sp)

00000480 <.LVL256>:
 480:	78812c03          	lw	s8,1928(sp)
 484:	855e                	mv	a0,s7
 486:	78c12b83          	lw	s7,1932(sp)

0000048a <.LVL257>:
 48a:	7b010113          	addi	sp,sp,1968
 48e:	8082                	ret

00000490 <.L112>:
               C := C2;
 490:	87d6                	mv	a5,s5
 492:	8726                	mv	a4,s1

00000494 <.L84>:
 494:	4388                	lw	a0,0(a5)
 496:	43cc                	lw	a1,4(a5)
 498:	4790                	lw	a2,8(a5)
 49a:	47d4                	lw	a3,12(a5)
 49c:	c308                	sw	a0,0(a4)
 49e:	c34c                	sw	a1,4(a4)
 4a0:	c710                	sw	a2,8(a4)
 4a2:	c754                	sw	a3,12(a4)
 4a4:	07c1                	addi	a5,a5,16
 4a6:	0741                	addi	a4,a4,16
 4a8:	ff2796e3          	bne	a5,s2,494 <.L84>
 4ac:	b9b9                	j	10a <.L81>

000004ae <.L113>:
         R0 := R0 * GF_I;
 4ae:	00000637          	lui	a2,0x0
 4b2:	00060613          	mv	a2,a2
 4b6:	85a6                	mv	a1,s1
 4b8:	850a                	mv	a0,sp
 4ba:	00000097          	auipc	ra,0x0
 4be:	000080e7          	jalr	ra # 4ba <.L113+0xc>

000004c2 <.LVL260>:
 4c2:	878a                	mv	a5,sp
 4c4:	8726                	mv	a4,s1

000004c6 <.L90>:
 4c6:	4388                	lw	a0,0(a5)
 4c8:	43cc                	lw	a1,4(a5)
 4ca:	4790                	lw	a2,8(a5)
 4cc:	47d4                	lw	a3,12(a5)
 4ce:	c308                	sw	a0,0(a4)
 4d0:	c34c                	sw	a1,4(a4)
 4d2:	c710                	sw	a2,8(a4)
 4d4:	c754                	sw	a3,12(a4)
 4d6:	07c1                	addi	a5,a5,16
 4d8:	0741                	addi	a4,a4,16
 4da:	ff3796e3          	bne	a5,s3,4c6 <.L90>
 4de:	bb05                	j	20e <.L89>

000004e0 <.L92>:
      D := Utils.Pack_25519 (A);
 4e0:	85a6                	mv	a1,s1
 4e2:	854a                	mv	a0,s2
 4e4:	00000097          	auipc	ra,0x0
 4e8:	000080e7          	jalr	ra # 4e4 <.L92+0x4>

000004ec <.LVL262>:
      return (D (0) mod 2);
 4ec:	70014783          	lbu	a5,1792(sp)

000004f0 <.LBE754>:
      if Par_25519 (R0) = (P (31) / 128) then
 4f0:	01fb4703          	lbu	a4,31(s6)

000004f4 <.LBB757>:
      return (D (0) mod 2);
 4f4:	8b85                	andi	a5,a5,1

000004f6 <.LBE757>:
      if Par_25519 (R0) = (P (31) / 128) then
 4f6:	831d                	srli	a4,a4,0x7
 4f8:	10f70163          	beq	a4,a5,5fa <.L114>

000004fc <.L94>:
            3 => R0 * R1);
 4fc:	864e                	mv	a2,s3
 4fe:	85a6                	mv	a1,s1
 500:	854a                	mv	a0,s2
 502:	00000097          	auipc	ra,0x0
 506:	000080e7          	jalr	ra # 502 <.L94+0x6>

0000050a <.LVL264>:
      R := (0 => R0,
 50a:	87a2                	mv	a5,s0

0000050c <.L96>:
 50c:	408c                	lw	a1,0(s1)
 50e:	40d0                	lw	a2,4(s1)
 510:	4494                	lw	a3,8(s1)
 512:	44d8                	lw	a4,12(s1)
 514:	c38c                	sw	a1,0(a5)
 516:	c3d0                	sw	a2,4(a5)
 518:	c794                	sw	a3,8(a5)
 51a:	c7d8                	sw	a4,12(a5)
 51c:	04c1                	addi	s1,s1,16
 51e:	07c1                	addi	a5,a5,16
 520:	ff5496e3          	bne	s1,s5,50c <.L96>
 524:	08040793          	addi	a5,s0,128

00000528 <.L97>:
 528:	0009a583          	lw	a1,0(s3)
 52c:	0049a603          	lw	a2,4(s3)
 530:	0089a683          	lw	a3,8(s3)
 534:	00c9a703          	lw	a4,12(s3)
 538:	c38c                	sw	a1,0(a5)
 53a:	c3d0                	sw	a2,4(a5)
 53c:	c794                	sw	a3,8(a5)
 53e:	c7d8                	sw	a4,12(a5)
 540:	09c1                	addi	s3,s3,16
 542:	07c1                	addi	a5,a5,16
 544:	ff4992e3          	bne	s3,s4,528 <.L97>
 548:	4781                	li	a5,0
 54a:	4801                	li	a6,0
 54c:	10f42223          	sw	a5,260(s0)
 550:	4705                	li	a4,1
 552:	4781                	li	a5,0
 554:	10e42023          	sw	a4,256(s0)
 558:	10f42423          	sw	a5,264(s0)
 55c:	11042623          	sw	a6,268(s0)
 560:	10f42823          	sw	a5,272(s0)
 564:	11042a23          	sw	a6,276(s0)
 568:	10f42c23          	sw	a5,280(s0)
 56c:	11042e23          	sw	a6,284(s0)
 570:	12f42023          	sw	a5,288(s0)
 574:	13042223          	sw	a6,292(s0)
 578:	12f42423          	sw	a5,296(s0)
 57c:	13042623          	sw	a6,300(s0)
 580:	12f42823          	sw	a5,304(s0)
 584:	13042a23          	sw	a6,308(s0)
 588:	12f42c23          	sw	a5,312(s0)
 58c:	13042e23          	sw	a6,316(s0)
 590:	14f42023          	sw	a5,320(s0)
 594:	15042223          	sw	a6,324(s0)
 598:	14f42423          	sw	a5,328(s0)
 59c:	15042623          	sw	a6,332(s0)
 5a0:	14f42823          	sw	a5,336(s0)
 5a4:	15042a23          	sw	a6,340(s0)
 5a8:	14f42c23          	sw	a5,344(s0)
 5ac:	15042e23          	sw	a6,348(s0)
 5b0:	16f42023          	sw	a5,352(s0)
 5b4:	17042223          	sw	a6,356(s0)
 5b8:	16f42423          	sw	a5,360(s0)
 5bc:	17042623          	sw	a6,364(s0)
 5c0:	16f42823          	sw	a5,368(s0)
 5c4:	17042a23          	sw	a6,372(s0)
 5c8:	16f42c23          	sw	a5,376(s0)
 5cc:	17042e23          	sw	a6,380(s0)
 5d0:	78010593          	addi	a1,sp,1920
 5d4:	18040413          	addi	s0,s0,384

000005d8 <.L98>:
 5d8:	00092603          	lw	a2,0(s2)
 5dc:	00492683          	lw	a3,4(s2)
 5e0:	00892703          	lw	a4,8(s2)
 5e4:	00c92783          	lw	a5,12(s2)
 5e8:	c010                	sw	a2,0(s0)
 5ea:	c054                	sw	a3,4(s0)
 5ec:	c418                	sw	a4,8(s0)
 5ee:	c45c                	sw	a5,12(s0)
 5f0:	0941                	addi	s2,s2,16
 5f2:	0441                	addi	s0,s0,16
 5f4:	feb912e3          	bne	s2,a1,5d8 <.L98>
 5f8:	b5a5                	j	460 <.L93>

000005fa <.L114>:
         R0 := GF_0 - R0;
 5fa:	000005b7          	lui	a1,0x0
 5fe:	8626                	mv	a2,s1
 600:	00058593          	mv	a1,a1
 604:	850a                	mv	a0,sp
 606:	00000097          	auipc	ra,0x0
 60a:	000080e7          	jalr	ra # 606 <.L114+0xc>

0000060e <.LVL267>:
 60e:	878a                	mv	a5,sp
 610:	8726                	mv	a4,s1

00000612 <.L95>:
 612:	4388                	lw	a0,0(a5)
 614:	43cc                	lw	a1,4(a5)
 616:	4790                	lw	a2,8(a5)
 618:	47d4                	lw	a3,12(a5)
 61a:	c308                	sw	a0,0(a4)
 61c:	c34c                	sw	a1,4(a4)
 61e:	c710                	sw	a2,8(a4)
 620:	c754                	sw	a3,12(a4)
 622:	07c1                	addi	a5,a5,16
 624:	0741                	addi	a4,a4,16
 626:	ff3796e3          	bne	a5,s3,612 <.L95>
 62a:	bdc9                	j	4fc <.L94>

Disassembly of section .text.sparknacl__sign__serialize:

00000000 <sparknacl__sign__serialize>:

   --============================================
   --  Exported subprogram bodies
   --============================================

   function Serialize (K : in Signing_SK) return Bytes_64
   0:	1141                	addi	sp,sp,-16
   is
   begin
      return K.F;
   2:	04000613          	li	a2,64
   function Serialize (K : in Signing_SK) return Bytes_64
   6:	c422                	sw	s0,8(sp)
   8:	c606                	sw	ra,12(sp)
   a:	842a                	mv	s0,a0
      return K.F;
   c:	00000097          	auipc	ra,0x0
  10:	000080e7          	jalr	ra # c <sparknacl__sign__serialize+0xc>

00000014 <.LVL269>:
   end Serialize;
  14:	40b2                	lw	ra,12(sp)
  16:	8522                	mv	a0,s0
  18:	4422                	lw	s0,8(sp)
  1a:	0141                	addi	sp,sp,16
  1c:	8082                	ret

Disassembly of section .text.sparknacl__sign__serialize__2:

00000000 <sparknacl__sign__serialize__2>:

   function Serialize (K : in Signing_PK) return Bytes_32
   0:	1141                	addi	sp,sp,-16
   is
   begin
      return K.F;
   2:	02000613          	li	a2,32
   function Serialize (K : in Signing_PK) return Bytes_32
   6:	c422                	sw	s0,8(sp)
   8:	c606                	sw	ra,12(sp)
   a:	842a                	mv	s0,a0
      return K.F;
   c:	00000097          	auipc	ra,0x0
  10:	000080e7          	jalr	ra # c <sparknacl__sign__serialize__2+0xc>

00000014 <.LVL272>:
   end Serialize;
  14:	40b2                	lw	ra,12(sp)
  16:	8522                	mv	a0,s0
  18:	4422                	lw	s0,8(sp)
  1a:	0141                	addi	sp,sp,16
  1c:	8082                	ret

Disassembly of section .text.sparknacl__sign__sanitize:

00000000 <sparknacl__sign__sanitize>:

   procedure Sanitize (K : out Signing_PK)
   is
   begin
      SPARKNaCl.Sanitize (K.F);
   0:	000005b7          	lui	a1,0x0
   4:	00058593          	mv	a1,a1
   8:	00000317          	auipc	t1,0x0
   c:	00030067          	jr	t1 # 8 <sparknacl__sign__sanitize+0x8>

Disassembly of section .text.sparknacl__sign__sanitize__2:

00000000 <sparknacl__sign__sanitize__2>:
   end Sanitize;

   procedure Sanitize (K : out Signing_SK)
   is
   begin
      SPARKNaCl.Sanitize (K.F);
   0:	000005b7          	lui	a1,0x0
   4:	00058593          	mv	a1,a1
   8:	00000317          	auipc	t1,0x0
   c:	00030067          	jr	t1 # 8 <sparknacl__sign__sanitize__2+0x8>

Disassembly of section .text.sparknacl__sign__keypair_from_bytes:

00000000 <sparknacl__sign__keypair_from_bytes>:
   end Sanitize;

   procedure Keypair_From_Bytes (SK_Raw : in     Bytes_32; -- random please!
   0:	d6010113          	addi	sp,sp,-672
   4:	29312623          	sw	s3,652(sp)

   is
      D   : Bytes_64;
      LPK : Bytes_32;
   begin
      Hashing.Hash (D, SK_Raw);
   8:	000009b7          	lui	s3,0x0
   procedure Keypair_From_Bytes (SK_Raw : in     Bytes_32; -- random please!
   c:	28812c23          	sw	s0,664(sp)
  10:	28912a23          	sw	s1,660(sp)
  14:	29212823          	sw	s2,656(sp)
  18:	842a                	mv	s0,a0
  1a:	892e                	mv	s2,a1
  1c:	84b2                	mv	s1,a2
      Hashing.Hash (D, SK_Raw);
  1e:	85aa                	mv	a1,a0

00000020 <.LVL279>:
  20:	00098613          	mv	a2,s3

00000024 <.LVL280>:
  24:	0088                	addi	a0,sp,64

00000026 <.LVL281>:
   procedure Keypair_From_Bytes (SK_Raw : in     Bytes_32; -- random please!
  26:	28112e23          	sw	ra,668(sp)
      Hashing.Hash (D, SK_Raw);
  2a:	00000097          	auipc	ra,0x0
  2e:	000080e7          	jalr	ra # 2a <.LVL281+0x4>

00000032 <.LVL282>:
      D (0)  := D (0) and 248;
      D (31) := (D (31) and 127) or 64;
  32:	05f14783          	lbu	a5,95(sp)
      D (0)  := D (0) and 248;
  36:	04014703          	lbu	a4,64(sp)

0000003a <.LBB763>:
      return Scalarmult (Scalarbase_Q, S);
  3a:	000005b7          	lui	a1,0x0

0000003e <.LBE763>:
      D (31) := (D (31) and 127) or 64;
  3e:	03f7f793          	andi	a5,a5,63
      D (0)  := D (0) and 248;
  42:	9b61                	andi	a4,a4,-8
      D (31) := (D (31) and 127) or 64;
  44:	0407e793          	ori	a5,a5,64

00000048 <.LBB767>:
      return Scalarmult (Scalarbase_Q, S);
  48:	0090                	addi	a2,sp,64
  4a:	0108                	addi	a0,sp,128
  4c:	00058593          	mv	a1,a1

00000050 <.LBE767>:
      D (0)  := D (0) and 248;
  50:	04e10023          	sb	a4,64(sp)
      D (31) := (D (31) and 127) or 64;
  54:	04f10fa3          	sb	a5,95(sp)

00000058 <.LBB768>:
      return Scalarmult (Scalarbase_Q, S);
  58:	00000097          	auipc	ra,0x0
  5c:	000080e7          	jalr	ra # 58 <.LBB768>

00000060 <.LBE768>:

      LPK := Pack (Scalarbase (D (0 .. 31)));
  60:	010c                	addi	a1,sp,128
  62:	850a                	mv	a0,sp
  64:	00000097          	auipc	ra,0x0
  68:	000080e7          	jalr	ra # 64 <.LBE768+0x4>

0000006c <.LVL285>:
  6c:	858a                	mv	a1,sp
  6e:	02000613          	li	a2,32
  72:	1008                	addi	a0,sp,32
  74:	00000097          	auipc	ra,0x0
  78:	000080e7          	jalr	ra # 74 <.LVL285+0x8>

0000007c <.LVL286>:

      PK.F := LPK;
  7c:	100c                	addi	a1,sp,32
  7e:	02000613          	li	a2,32
  82:	854a                	mv	a0,s2
  84:	00000097          	auipc	ra,0x0
  88:	000080e7          	jalr	ra # 84 <.LVL286+0x8>

0000008c <.LVL287>:
      SK.F := SK_Raw & LPK;
  8c:	85a2                	mv	a1,s0
  8e:	02000613          	li	a2,32
  92:	0108                	addi	a0,sp,128
  94:	00000097          	auipc	ra,0x0
  98:	000080e7          	jalr	ra # 94 <.LVL287+0x8>

0000009c <.LVL288>:
  9c:	5782                	lw	a5,32(sp)
  9e:	04000613          	li	a2,64
  a2:	010c                	addi	a1,sp,128
  a4:	d13e                	sw	a5,160(sp)
  a6:	5792                	lw	a5,36(sp)
  a8:	8526                	mv	a0,s1
  aa:	d33e                	sw	a5,164(sp)
  ac:	57a2                	lw	a5,40(sp)
  ae:	d53e                	sw	a5,168(sp)
  b0:	57b2                	lw	a5,44(sp)
  b2:	d73e                	sw	a5,172(sp)
  b4:	57c2                	lw	a5,48(sp)
  b6:	d93e                	sw	a5,176(sp)
  b8:	57d2                	lw	a5,52(sp)
  ba:	db3e                	sw	a5,180(sp)
  bc:	57e2                	lw	a5,56(sp)
  be:	dd3e                	sw	a5,184(sp)
  c0:	57f2                	lw	a5,60(sp)
  c2:	df3e                	sw	a5,188(sp)
  c4:	00000097          	auipc	ra,0x0
  c8:	000080e7          	jalr	ra # c4 <.LVL288+0x28>

000000cc <.LVL289>:

      --  Sanitize intermediate values used in key generation
      pragma Warnings (GNATProve, Off, "statement has no effect");
      Sanitize (D);
  cc:	000005b7          	lui	a1,0x0
  d0:	0088                	addi	a0,sp,64
  d2:	00058593          	mv	a1,a1
  d6:	00000097          	auipc	ra,0x0
  da:	000080e7          	jalr	ra # d6 <.LVL289+0xa>

000000de <.LVL290>:
      Sanitize (LPK);
  de:	1008                	addi	a0,sp,32
  e0:	00098593          	mv	a1,s3
  e4:	00000097          	auipc	ra,0x0
  e8:	000080e7          	jalr	ra # e4 <.LVL290+0x6>

000000ec <.LVL291>:
      pragma Unreferenced (D);
      pragma Unreferenced (LPK);
   end Keypair_From_Bytes;
  ec:	29c12083          	lw	ra,668(sp)
  f0:	29812403          	lw	s0,664(sp)

000000f4 <.LVL292>:
  f4:	29412483          	lw	s1,660(sp)

000000f8 <.LVL293>:
  f8:	29012903          	lw	s2,656(sp)

000000fc <.LVL294>:
  fc:	28c12983          	lw	s3,652(sp)
 100:	2a010113          	addi	sp,sp,672
 104:	8082                	ret

Disassembly of section .text.sparknacl__sign__keypair:

00000000 <sparknacl__sign__keypair>:

   procedure Keypair (PK : out Signing_PK;
   0:	715d                	addi	sp,sp,-80
   2:	c4a2                	sw	s0,72(sp)
   4:	842a                	mv	s0,a0
                      SK : out Signing_SK)
   is
      RB  : Bytes_32;
   begin
      RB  := Utils.Random_Bytes_32;
   6:	850a                	mv	a0,sp

00000008 <.LVL296>:
   procedure Keypair (PK : out Signing_PK;
   8:	c686                	sw	ra,76(sp)
   a:	c2a6                	sw	s1,68(sp)
   c:	84ae                	mv	s1,a1
      RB  := Utils.Random_Bytes_32;
   e:	00000097          	auipc	ra,0x0
  12:	000080e7          	jalr	ra # e <.LVL296+0x6>

00000016 <.LVL297>:
  16:	858a                	mv	a1,sp
  18:	02000613          	li	a2,32
  1c:	1008                	addi	a0,sp,32
  1e:	00000097          	auipc	ra,0x0
  22:	000080e7          	jalr	ra # 1e <.LVL297+0x8>

00000026 <.LVL298>:
      Keypair_From_Bytes (RB, PK, SK);
  26:	8626                	mv	a2,s1
  28:	85a2                	mv	a1,s0
  2a:	1008                	addi	a0,sp,32
  2c:	00000097          	auipc	ra,0x0
  30:	000080e7          	jalr	ra # 2c <.LVL298+0x6>

00000034 <.LVL299>:

      --  Sanitize intermediate values used in key generation
      pragma Warnings (GNATProve, Off, "statement has no effect");
      Sanitize (RB);
  34:	000005b7          	lui	a1,0x0
  38:	1008                	addi	a0,sp,32
  3a:	00058593          	mv	a1,a1
  3e:	00000097          	auipc	ra,0x0
  42:	000080e7          	jalr	ra # 3e <.LVL299+0xa>

00000046 <.LVL300>:
      pragma Unreferenced (RB);
   end Keypair;
  46:	40b6                	lw	ra,76(sp)
  48:	4426                	lw	s0,72(sp)

0000004a <.LVL301>:
  4a:	4496                	lw	s1,68(sp)

0000004c <.LVL302>:
  4c:	6161                	addi	sp,sp,80
  4e:	8082                	ret

Disassembly of section .text.sparknacl__sign__pk_from_bytes:

00000000 <sparknacl__sign__pk_from_bytes>:

   procedure PK_From_Bytes (PK_Raw : in     Bytes_32;
   0:	87ae                	mv	a5,a1
   2:	1141                	addi	sp,sp,-16
                            PK     :    out Signing_PK)
   is
   begin
      PK.F := PK_Raw;
   4:	85aa                	mv	a1,a0

00000006 <.LVL304>:
   6:	02000613          	li	a2,32
   a:	853e                	mv	a0,a5

0000000c <.LVL305>:
   procedure PK_From_Bytes (PK_Raw : in     Bytes_32;
   c:	c606                	sw	ra,12(sp)
      PK.F := PK_Raw;
   e:	00000097          	auipc	ra,0x0
  12:	000080e7          	jalr	ra # e <.LVL305+0x2>

00000016 <.LVL306>:
   end PK_From_Bytes;
  16:	40b2                	lw	ra,12(sp)
  18:	0141                	addi	sp,sp,16
  1a:	8082                	ret

Disassembly of section .text.sparknacl__sign__sign:

00000000 <sparknacl__sign__sign>:

   procedure Sign (SM :    out Byte_Seq;
   0:	a8010113          	addi	sp,sp,-1408
   4:	56812c23          	sw	s0,1400(sp)
   8:	57412423          	sw	s4,1384(sp)
   c:	842a                	mv	s0,a0
   e:	8a2e                	mv	s4,a1
  10:	55712e23          	sw	s7,1372(sp)

00000014 <.LBB790>:
      return K.F;
  14:	85ba                	mv	a1,a4

00000016 <.LBE790>:
   procedure Sign (SM :    out Byte_Seq;
  16:	8bb2                	mv	s7,a2

00000018 <.LBB794>:
      return K.F;
  18:	0e88                	addi	a0,sp,848

0000001a <.LVL308>:
  1a:	04000613          	li	a2,64

0000001e <.LBE794>:
   procedure Sign (SM :    out Byte_Seq;
  1e:	56112e23          	sw	ra,1404(sp)
  22:	56912a23          	sw	s1,1396(sp)
  26:	57212823          	sw	s2,1392(sp)
  2a:	57312623          	sw	s3,1388(sp)
  2e:	57512223          	sw	s5,1380(sp)
  32:	57612023          	sw	s6,1376(sp)
  36:	000a2903          	lw	s2,0(s4)
  3a:	8b3a                	mv	s6,a4

0000003c <.LVL310>:
         X (64 .. X'Last) := M;
      end Initialize_SM;


   begin
      Hashing.Hash (D, Serialize (SK) (0 .. 31));
  3c:	000004b7          	lui	s1,0x0

00000040 <.LBB795>:
      return K.F;
  40:	00000097          	auipc	ra,0x0
  44:	000080e7          	jalr	ra # 40 <.LBB795>

00000048 <.LBE795>:
      Hashing.Hash (D, Serialize (SK) (0 .. 31));
  48:	0e8c                	addi	a1,sp,848
  4a:	00048613          	mv	a2,s1
  4e:	0a08                	addi	a0,sp,272
  50:	00000097          	auipc	ra,0x0
  54:	000080e7          	jalr	ra # 50 <.LBE795+0x8>

00000058 <.LVL312>:
      D (0)  := D (0) and 248;
      D (31) := (D (31) and 127) or 64;
  58:	12f14783          	lbu	a5,303(sp)
      D (0)  := D (0) and 248;
  5c:	11014703          	lbu	a4,272(sp)

00000060 <.LBB798>:
      procedure Initialize_SM (X : out Byte_Seq)
  60:	000a2a83          	lw	s5,0(s4)

00000064 <.LBE798>:
      D (31) := (D (31) and 127) or 64;
  64:	03f7f793          	andi	a5,a5,63

00000068 <.LBB803>:
         X (0  .. 31)     := Zero_Bytes_32;
  68:	000005b7          	lui	a1,0x0

0000006c <.LBE803>:
      D (31) := (D (31) and 127) or 64;
  6c:	0407e793          	ori	a5,a5,64
      D (0)  := D (0) and 248;
  70:	9b61                	andi	a4,a4,-8

00000072 <.LBB804>:
         X (0  .. 31)     := Zero_Bytes_32;
  72:	02000613          	li	a2,32
  76:	00058593          	mv	a1,a1
  7a:	41540533          	sub	a0,s0,s5

0000007e <.LBE804>:
      D (31) := (D (31) and 127) or 64;
  7e:	12f107a3          	sb	a5,303(sp)

00000082 <.LVL313>:
      D (0)  := D (0) and 248;
  82:	10e10823          	sb	a4,272(sp)

00000086 <.LBB805>:
         X (0  .. 31)     := Zero_Bytes_32;
  86:	00000097          	auipc	ra,0x0
  8a:	000080e7          	jalr	ra # 86 <.LBB805>

0000008e <.LVL314>:
         X (32 .. 63)     := D (32 .. 63);
  8e:	13010993          	addi	s3,sp,304
  92:	41540533          	sub	a0,s0,s5
  96:	02000613          	li	a2,32
  9a:	85ce                	mv	a1,s3
  9c:	02050513          	addi	a0,a0,32
  a0:	00000097          	auipc	ra,0x0
  a4:	000080e7          	jalr	ra # a0 <.LVL314+0x12>

000000a8 <.LVL315>:
         X (64 .. X'Last) := M;
  a8:	004a2603          	lw	a2,4(s4)
  ac:	03f00793          	li	a5,63
  b0:	00f65463          	bge	a2,a5,b8 <.L128>
  b4:	03f00613          	li	a2,63

000000b8 <.L128>:
  b8:	41540533          	sub	a0,s0,s5
  bc:	fc160613          	addi	a2,a2,-63 # ffffffc1 <.LLST56+0xffffe73b>
  c0:	85de                	mv	a1,s7
  c2:	04050513          	addi	a0,a0,64
  c6:	00000097          	auipc	ra,0x0
  ca:	000080e7          	jalr	ra # c6 <.L128+0xe>

000000ce <.LBE805>:

      Initialize_SM (SM);
      R := Hash_Reduce (SM (32 .. SM'Last));
  ce:	02000793          	li	a5,32
  d2:	004a2703          	lw	a4,4(s4)
  d6:	41278ab3          	sub	s5,a5,s2
  da:	9aa2                	add	s5,s5,s0

000000dc <.LBB806>:
      Hashing.Hash (R, M);
  dc:	85d6                	mv	a1,s5
  de:	1030                	addi	a2,sp,40
  e0:	0a88                	addi	a0,sp,336

000000e2 <.LBE806>:
      R := Hash_Reduce (SM (32 .. SM'Last));
  e2:	d43e                	sw	a5,40(sp)
  e4:	d63a                	sw	a4,44(sp)

000000e6 <.LBB810>:
      Hashing.Hash (R, M);
  e6:	00000097          	auipc	ra,0x0
  ea:	000080e7          	jalr	ra # e6 <.LBB810>

000000ee <.LVL317>:
      X := (others => 0);
  ee:	20000613          	li	a2,512
  f2:	4581                	li	a1,0
  f4:	0e88                	addi	a0,sp,848
  f6:	00000097          	auipc	ra,0x0
  fa:	000080e7          	jalr	ra # f6 <.LVL317+0x8>

000000fe <.LVL318>:
  fe:	0a98                	addi	a4,sp,336
 100:	0e9c                	addi	a5,sp,848
 102:	55010613          	addi	a2,sp,1360

00000106 <.L129>:
         X (I) := I64 (R (I));
 106:	00074683          	lbu	a3,0(a4)
 10a:	0007a223          	sw	zero,4(a5)
      for I in Index_64 loop
 10e:	07a1                	addi	a5,a5,8
         X (I) := I64 (R (I));
 110:	fed7ac23          	sw	a3,-8(a5)
      for I in Index_64 loop
 114:	0705                	addi	a4,a4,1

00000116 <.LVL320>:
 116:	fec798e3          	bne	a5,a2,106 <.L129>

0000011a <.LBE808>:
      return ModL (X);
 11a:	0e8c                	addi	a1,sp,848
 11c:	0988                	addi	a0,sp,208
 11e:	00000097          	auipc	ra,0x0
 122:	000080e7          	jalr	ra # 11e <.LBE808+0x4>

00000126 <.LBE810>:
      R := Hash_Reduce (SM (32 .. SM'Last));
 126:	47ce                	lw	a5,208(sp)

00000128 <.LBB811>:
      return Scalarmult (Scalarbase_Q, S);
 128:	000005b7          	lui	a1,0x0
 12c:	0890                	addi	a2,sp,80

0000012e <.LBE811>:
      R := Hash_Reduce (SM (32 .. SM'Last));
 12e:	c8be                	sw	a5,80(sp)
 130:	47de                	lw	a5,212(sp)

00000132 <.LBB815>:
      return Scalarmult (Scalarbase_Q, S);
 132:	00058593          	mv	a1,a1
 136:	0e88                	addi	a0,sp,848

00000138 <.LBE815>:
      R := Hash_Reduce (SM (32 .. SM'Last));
 138:	cabe                	sw	a5,84(sp)
 13a:	47ee                	lw	a5,216(sp)
 13c:	ccbe                	sw	a5,88(sp)
 13e:	47fe                	lw	a5,220(sp)
 140:	cebe                	sw	a5,92(sp)
 142:	578e                	lw	a5,224(sp)
 144:	d0be                	sw	a5,96(sp)
 146:	579e                	lw	a5,228(sp)
 148:	d2be                	sw	a5,100(sp)
 14a:	57ae                	lw	a5,232(sp)
 14c:	d4be                	sw	a5,104(sp)
 14e:	57be                	lw	a5,236(sp)
 150:	d6be                	sw	a5,108(sp)

00000152 <.LBB816>:
      return Scalarmult (Scalarbase_Q, S);
 152:	00000097          	auipc	ra,0x0
 156:	000080e7          	jalr	ra # 152 <.LBB816>

0000015a <.LBE816>:

      P := Scalarbase (R);
 15a:	0e9c                	addi	a5,sp,848
 15c:	0a98                	addi	a4,sp,336

0000015e <.L130>:
 15e:	47d4                	lw	a3,12(a5)
 160:	4388                	lw	a0,0(a5)
 162:	43cc                	lw	a1,4(a5)
 164:	4790                	lw	a2,8(a5)
 166:	c754                	sw	a3,12(a4)
 168:	c308                	sw	a0,0(a4)
 16a:	c34c                	sw	a1,4(a4)
 16c:	c710                	sw	a2,8(a4)
 16e:	07c1                	addi	a5,a5,16
 170:	55010693          	addi	a3,sp,1360
 174:	0741                	addi	a4,a4,16
 176:	fed794e3          	bne	a5,a3,15e <.L130>

      SM (0 .. 31) := Pack (P);
 17a:	0a8c                	addi	a1,sp,336
 17c:	850a                	mv	a0,sp
 17e:	00000097          	auipc	ra,0x0
 182:	000080e7          	jalr	ra # 17e <.L130+0x20>

00000186 <.LVL324>:
 186:	02000613          	li	a2,32
 18a:	858a                	mv	a1,sp
 18c:	41240533          	sub	a0,s0,s2
 190:	00000097          	auipc	ra,0x0
 194:	000080e7          	jalr	ra # 190 <.LVL324+0xa>

00000198 <.LBB817>:
      return K.F;
 198:	04000613          	li	a2,64
 19c:	85da                	mv	a1,s6
 19e:	0908                	addi	a0,sp,144
 1a0:	00000097          	auipc	ra,0x0
 1a4:	000080e7          	jalr	ra # 1a0 <.LBB817+0x8>

000001a8 <.LBE817>:
      SM (32 .. 63) := Serialize (SK) (32 .. 63);
 1a8:	02000613          	li	a2,32
 1ac:	190c                	addi	a1,sp,176
 1ae:	8556                	mv	a0,s5
 1b0:	00000097          	auipc	ra,0x0
 1b4:	000080e7          	jalr	ra # 1b0 <.LBE817+0x8>

000001b8 <.LBB819>:
      Hashing.Hash (R, M);
 1b8:	85a2                	mv	a1,s0
 1ba:	8652                	mv	a2,s4
 1bc:	0988                	addi	a0,sp,208
 1be:	00000097          	auipc	ra,0x0
 1c2:	000080e7          	jalr	ra # 1be <.LBB819+0x6>

000001c6 <.LVL328>:
      X := (others => 0);
 1c6:	20000613          	li	a2,512
 1ca:	4581                	li	a1,0
 1cc:	0e88                	addi	a0,sp,848
 1ce:	00000097          	auipc	ra,0x0
 1d2:	000080e7          	jalr	ra # 1ce <.LVL328+0x8>

000001d6 <.LVL329>:
 1d6:	0998                	addi	a4,sp,208
 1d8:	0e9c                	addi	a5,sp,848
 1da:	55010613          	addi	a2,sp,1360

000001de <.L131>:
         X (I) := I64 (R (I));
 1de:	00074683          	lbu	a3,0(a4)
 1e2:	0007a223          	sw	zero,4(a5)
      for I in Index_64 loop
 1e6:	07a1                	addi	a5,a5,8
         X (I) := I64 (R (I));
 1e8:	fed7ac23          	sw	a3,-8(a5)
      for I in Index_64 loop
 1ec:	0705                	addi	a4,a4,1

000001ee <.LVL331>:
 1ee:	fef618e3          	bne	a2,a5,1de <.L131>

000001f2 <.LBE821>:
      return ModL (X);
 1f2:	0e8c                	addi	a1,sp,848
 1f4:	1888                	addi	a0,sp,112
 1f6:	00000097          	auipc	ra,0x0
 1fa:	000080e7          	jalr	ra # 1f6 <.LBE821+0x4>

000001fe <.LBE819>:

      H := Hash_Reduce (SM);
 1fe:	57c6                	lw	a5,112(sp)

      X := (others => 0);
 200:	20000613          	li	a2,512
 204:	4581                	li	a1,0
      H := Hash_Reduce (SM);
 206:	d83e                	sw	a5,48(sp)
 208:	57d6                	lw	a5,116(sp)
      X := (others => 0);
 20a:	0e88                	addi	a0,sp,848
      H := Hash_Reduce (SM);
 20c:	da3e                	sw	a5,52(sp)
 20e:	57e6                	lw	a5,120(sp)
 210:	dc3e                	sw	a5,56(sp)
 212:	57f6                	lw	a5,124(sp)
 214:	de3e                	sw	a5,60(sp)
 216:	478a                	lw	a5,128(sp)
 218:	c0be                	sw	a5,64(sp)
 21a:	479a                	lw	a5,132(sp)
 21c:	c2be                	sw	a5,68(sp)
 21e:	47aa                	lw	a5,136(sp)
 220:	c4be                	sw	a5,72(sp)
 222:	47ba                	lw	a5,140(sp)
 224:	c6be                	sw	a5,76(sp)
      X := (others => 0);
 226:	00000097          	auipc	ra,0x0
 22a:	000080e7          	jalr	ra # 226 <.LBE819+0x28>

0000022e <.LVL333>:
 22e:	35010313          	addi	t1,sp,848
 232:	0898                	addi	a4,sp,80
 234:	45010613          	addi	a2,sp,1104
 238:	879a                	mv	a5,t1

0000023a <.L132>:
      for I in Index_32 loop
         X (I) := I64 (R (I));
 23a:	00074683          	lbu	a3,0(a4)
 23e:	0007a223          	sw	zero,4(a5)
      for I in Index_32 loop
 242:	07a1                	addi	a5,a5,8
         X (I) := I64 (R (I));
 244:	fed7ac23          	sw	a3,-8(a5)
      for I in Index_32 loop
 248:	0705                	addi	a4,a4,1

0000024a <.LVL335>:
 24a:	fec798e3          	bne	a5,a2,23a <.L132>
 24e:	03010893          	addi	a7,sp,48

00000252 <.LBB823>:
         (for all K in Index_64 => X (K) in I64_Byte)
        );

      pragma Warnings (Off, "explicit membership test may be optimized");

      for I in Index_32 loop
 252:	587d                	li	a6,-1
 254:	4e7d                	li	t3,31

00000256 <.L134>:
 256:	0008c503          	lbu	a0,0(a7)
 25a:	0805                	addi	a6,a6,1

0000025c <.LVL337>:
 25c:	0a10                	addi	a2,sp,272
 25e:	869a                	mv	a3,t1

00000260 <.L133>:
         for J in Index_32 loop
            T := Byte_Product (H (I)) * Byte_Product (D (J));
 260:	00064703          	lbu	a4,0(a2)
            X (I + J) := X (I + J) + T;
 264:	429c                	lw	a5,0(a3)
 266:	42cc                	lw	a1,4(a3)
            T := Byte_Product (H (I)) * Byte_Product (D (J));
 268:	02a70733          	mul	a4,a4,a0
         for J in Index_32 loop
 26c:	06a1                	addi	a3,a3,8
 26e:	0605                	addi	a2,a2,1

00000270 <.LVL339>:
            X (I + J) := X (I + J) + T;
 270:	973e                	add	a4,a4,a5
 272:	00f737b3          	sltu	a5,a4,a5
 276:	97ae                	add	a5,a5,a1
 278:	fee6ac23          	sw	a4,-8(a3)
 27c:	fef6ae23          	sw	a5,-4(a3)
         for J in Index_32 loop
 280:	fec990e3          	bne	s3,a2,260 <.L133>

00000284 <.LBE824>:
      for I in Index_32 loop
 284:	0885                	addi	a7,a7,1
 286:	0321                	addi	t1,t1,8
 288:	fdc817e3          	bne	a6,t3,256 <.L134>

0000028c <.LBE823>:

      --  Simplify - this assert is equivalent to the precondition of ModL
      pragma Assert
        (for all K in Index_64 => X (K) in 0 .. (32 * MBP + 255));

      SM (32 .. 63) := ModL (X);
 28c:	0e8c                	addi	a1,sp,848
 28e:	0988                	addi	a0,sp,208

00000290 <.LVL340>:
 290:	00000097          	auipc	ra,0x0
 294:	000080e7          	jalr	ra # 290 <.LVL340>

00000298 <.LVL341>:
 298:	41240533          	sub	a0,s0,s2
 29c:	02000613          	li	a2,32
 2a0:	098c                	addi	a1,sp,208
 2a2:	02050513          	addi	a0,a0,32
 2a6:	00000097          	auipc	ra,0x0
 2aa:	000080e7          	jalr	ra # 2a6 <.LVL341+0xe>

000002ae <.LVL342>:

      Sanitize (D);
 2ae:	000005b7          	lui	a1,0x0
 2b2:	0a08                	addi	a0,sp,272
 2b4:	00058593          	mv	a1,a1
 2b8:	00000097          	auipc	ra,0x0
 2bc:	000080e7          	jalr	ra # 2b8 <.LVL342+0xa>

000002c0 <.LVL343>:
      Sanitize (H);
 2c0:	1808                	addi	a0,sp,48
 2c2:	00048593          	mv	a1,s1
 2c6:	00000097          	auipc	ra,0x0
 2ca:	000080e7          	jalr	ra # 2c6 <.LVL343+0x6>

000002ce <.LVL344>:
      Sanitize (R);
 2ce:	0888                	addi	a0,sp,80
 2d0:	00048593          	mv	a1,s1
 2d4:	00000097          	auipc	ra,0x0
 2d8:	000080e7          	jalr	ra # 2d4 <.LVL344+0x6>

000002dc <.LVL345>:
      Sanitize_I64_Seq (X);
 2dc:	000005b7          	lui	a1,0x0
 2e0:	0e88                	addi	a0,sp,848
 2e2:	00058593          	mv	a1,a1
 2e6:	00000097          	auipc	ra,0x0
 2ea:	000080e7          	jalr	ra # 2e6 <.LVL345+0xa>

000002ee <.LVL346>:

      pragma Unreferenced (D, H, R, X);
   end Sign;
 2ee:	57c12083          	lw	ra,1404(sp)
 2f2:	57812403          	lw	s0,1400(sp)

000002f6 <.LVL347>:
 2f6:	57412483          	lw	s1,1396(sp)
 2fa:	57012903          	lw	s2,1392(sp)
 2fe:	56c12983          	lw	s3,1388(sp)
 302:	56812a03          	lw	s4,1384(sp)
 306:	56412a83          	lw	s5,1380(sp)
 30a:	56012b03          	lw	s6,1376(sp)

0000030e <.LVL348>:
 30e:	55c12b83          	lw	s7,1372(sp)
 312:	58010113          	addi	sp,sp,1408
 316:	8082                	ret

Disassembly of section .text.sparknacl__sign__sign2:

00000000 <sparknacl__sign__sign2>:
with HAL;       use HAL;
with RISCV.CSR; use RISCV.CSR;

separate (SPARKNaCl.Sign)
procedure Sign2 (SM                   :    out Byte_Seq;
   0:	a5010113          	addi	sp,sp,-1456
   4:	5a812423          	sw	s0,1448(sp)
   8:	5a912223          	sw	s1,1444(sp)
   c:	5b212023          	sw	s2,1440(sp)
  10:	59712623          	sw	s7,1420(sp)
  14:	59912223          	sw	s9,1412(sp)
  18:	57b12e23          	sw	s11,1404(sp)
  1c:	5a112623          	sw	ra,1452(sp)

00000020 <.LBB916>:
  20:	00062d83          	lw	s11,0(a2)

00000024 <.LBE916>:
  24:	59312e23          	sw	s3,1436(sp)
  28:	59412c23          	sw	s4,1432(sp)
  2c:	59512a23          	sw	s5,1428(sp)
  30:	59612823          	sw	s6,1424(sp)
  34:	59812423          	sw	s8,1416(sp)
  38:	59a12023          	sw	s10,1408(sp)
  3c:	8bb2                	mv	s7,a2
  3e:	842a                	mv	s0,a0
  40:	84ae                	mv	s1,a1

00000042 <.LVL350>:
  42:	8936                	mv	s2,a3

00000044 <.LVL351>:
  44:	8cbe                	mv	s9,a5

00000046 <.LBB1015>:
   --------------

   function Read_CSR return Reg_Type is
      Ret : Reg_Type;
   begin
      Asm ("csrr %0, " & Reg_Name,
  46:	b80027f3          	csrr	a5,mcycleh

0000004a <.LBB921>:
  4a:	b00026f3          	csrr	a3,mcycle

0000004e <.LBB923>:
  4e:	b8002773          	csrr	a4,mcycleh

00000052 <.LBE923>:
   --  Read the High register twice in case Low overflows while we read
   High_1 := R_High;
   Low := R_Low;
   High_2 := R_High;

   if High_2 /= High_1 then
  52:	48e78463          	beq	a5,a4,4da <.L143>
      return Shift_Left (UInt64 (High_2), 32);
  56:	c63a                	sw	a4,12(sp)
  58:	c402                	sw	zero,8(sp)

0000005a <.L144>:
      return K.F;
  5a:	85e6                	mv	a1,s9
  5c:	04000613          	li	a2,64
  60:	1e88                	addi	a0,sp,880
  62:	00000097          	auipc	ra,0x0
  66:	000080e7          	jalr	ra # 62 <.L144+0x8>

0000006a <.LBE927>:


begin
   T1 := Mcycle.Read;

   Hashing.Hash (D, Serialize (SK) (0 .. 31));
  6a:	000007b7          	lui	a5,0x0
  6e:	00078613          	mv	a2,a5
  72:	1e8c                	addi	a1,sp,880
  74:	1a08                	addi	a0,sp,304
  76:	00000097          	auipc	ra,0x0
  7a:	000080e7          	jalr	ra # 76 <.LBE927+0xc>

0000007e <.LVL358>:
   D (0)  := D (0) and 248;
   D (31) := (D (31) and 127) or 64;
  7e:	14f14783          	lbu	a5,335(sp)
   D (0)  := D (0) and 248;
  82:	13014703          	lbu	a4,304(sp)
   D (31) := (D (31) and 127) or 64;
  86:	03f7f793          	andi	a5,a5,63
   D (0)  := D (0) and 248;
  8a:	9b61                	andi	a4,a4,-8
   D (31) := (D (31) and 127) or 64;
  8c:	0407e793          	ori	a5,a5,64
   D (0)  := D (0) and 248;
  90:	12e10823          	sb	a4,304(sp)
   D (31) := (D (31) and 127) or 64;
  94:	14f107a3          	sb	a5,335(sp)

00000098 <.LBB929>:
  98:	b80029f3          	csrr	s3,mcycleh

0000009c <.LBB933>:
  9c:	b0002b73          	csrr	s6,mcycle

000000a0 <.LBB935>:
  a0:	b80027f3          	csrr	a5,mcycleh

000000a4 <.LBE935>:
   if High_2 /= High_1 then
  a4:	00f98463          	beq	s3,a5,ac <.L146>
      return Shift_Left (UInt64 (High_2), 32);
  a8:	89be                	mv	s3,a5

000000aa <.LVL362>:
  aa:	4b01                	li	s6,0

000000ac <.L146>:
   procedure Initialize_SM (X : out Byte_Seq)
  ac:	000baa03          	lw	s4,0(s7) # 0 <sparknacl__sign__sign2>
      X (0  .. 31)     := Zero_Bytes_32;
  b0:	000005b7          	lui	a1,0x0
  b4:	02000613          	li	a2,32
  b8:	00058593          	mv	a1,a1
  bc:	41448533          	sub	a0,s1,s4
  c0:	00000097          	auipc	ra,0x0
  c4:	000080e7          	jalr	ra # c0 <.L146+0x14>

000000c8 <.LVL364>:
      X (32 .. 63)     := D (32 .. 63);
  c8:	15010d13          	addi	s10,sp,336
  cc:	41448533          	sub	a0,s1,s4
  d0:	02000613          	li	a2,32
  d4:	85ea                	mv	a1,s10
  d6:	02050513          	addi	a0,a0,32
  da:	00000097          	auipc	ra,0x0
  de:	000080e7          	jalr	ra # da <.LVL364+0x12>

000000e2 <.LVL365>:
      X (64 .. X'Last) := M;
  e2:	004ba603          	lw	a2,4(s7)
  e6:	03f00793          	li	a5,63
  ea:	00f65463          	bge	a2,a5,f2 <.L147>
  ee:	03f00613          	li	a2,63

000000f2 <.L147>:
  f2:	41448533          	sub	a0,s1,s4
  f6:	fc160613          	addi	a2,a2,-63
  fa:	85ca                	mv	a1,s2
  fc:	04050513          	addi	a0,a0,64
 100:	00000097          	auipc	ra,0x0
 104:	000080e7          	jalr	ra # 100 <.L147+0xe>

00000108 <.LBE937>:

   T2 := Mcycle.Read;

   Initialize_SM (SM);
   R := Hash_Reduce (SM (32 .. SM'Last));
 108:	02000793          	li	a5,32
 10c:	004ba703          	lw	a4,4(s7)
 110:	41b78c33          	sub	s8,a5,s11
 114:	9c26                	add	s8,s8,s1

00000116 <.LBB939>:
      Hashing.Hash (R, M);
 116:	85e2                	mv	a1,s8
 118:	00b0                	addi	a2,sp,72
 11a:	1a88                	addi	a0,sp,368

0000011c <.LBE939>:
 11c:	c4be                	sw	a5,72(sp)
 11e:	c6ba                	sw	a4,76(sp)

00000120 <.LBB943>:
 120:	00000097          	auipc	ra,0x0
 124:	000080e7          	jalr	ra # 120 <.LBB943>

00000128 <.LVL367>:
      X := (others => 0);
 128:	20000613          	li	a2,512
 12c:	4581                	li	a1,0
 12e:	1e88                	addi	a0,sp,880
 130:	00000097          	auipc	ra,0x0
 134:	000080e7          	jalr	ra # 130 <.LVL367+0x8>

00000138 <.LVL368>:
 138:	1a98                	addi	a4,sp,368
 13a:	1e9c                	addi	a5,sp,880
 13c:	57010613          	addi	a2,sp,1392

00000140 <.L148>:
         X (I) := I64 (R (I));
 140:	00074683          	lbu	a3,0(a4)
 144:	0007a223          	sw	zero,4(a5) # 4 <sparknacl__sign__sign2+0x4>
      for I in Index_64 loop
 148:	07a1                	addi	a5,a5,8
         X (I) := I64 (R (I));
 14a:	fed7ac23          	sw	a3,-8(a5)
      for I in Index_64 loop
 14e:	0705                	addi	a4,a4,1

00000150 <.LVL370>:
 150:	fec798e3          	bne	a5,a2,140 <.L148>

00000154 <.LBE941>:
      return ModL (X);
 154:	1e8c                	addi	a1,sp,880
 156:	1988                	addi	a0,sp,240
 158:	00000097          	auipc	ra,0x0
 15c:	000080e7          	jalr	ra # 158 <.LBE941+0x4>

00000160 <.LBE943>:
 160:	57ce                	lw	a5,240(sp)
 162:	d8be                	sw	a5,112(sp)
 164:	57de                	lw	a5,244(sp)
 166:	dabe                	sw	a5,116(sp)
 168:	57ee                	lw	a5,248(sp)
 16a:	dcbe                	sw	a5,120(sp)
 16c:	57fe                	lw	a5,252(sp)
 16e:	debe                	sw	a5,124(sp)
 170:	10012783          	lw	a5,256(sp)
 174:	c13e                	sw	a5,128(sp)
 176:	10412783          	lw	a5,260(sp)
 17a:	c33e                	sw	a5,132(sp)
 17c:	10812783          	lw	a5,264(sp)
 180:	c53e                	sw	a5,136(sp)
 182:	10c12783          	lw	a5,268(sp)
 186:	c73e                	sw	a5,140(sp)

00000188 <.LBB944>:
 188:	b8002973          	csrr	s2,mcycleh

0000018c <.LBB948>:
 18c:	b0002af3          	csrr	s5,mcycle

00000190 <.LBB950>:
 190:	b80027f3          	csrr	a5,mcycleh

00000194 <.LBE950>:
   if High_2 /= High_1 then
 194:	00f90463          	beq	s2,a5,19c <.L150>
      return Shift_Left (UInt64 (High_2), 32);
 198:	893e                	mv	s2,a5

0000019a <.LVL375>:
 19a:	4a81                	li	s5,0

0000019c <.L150>:
      return Scalarmult (Scalarbase_Q, S);
 19c:	000005b7          	lui	a1,0x0
 1a0:	1890                	addi	a2,sp,112

000001a2 <.LVL377>:
 1a2:	00058593          	mv	a1,a1
 1a6:	1e88                	addi	a0,sp,880
 1a8:	00000097          	auipc	ra,0x0
 1ac:	000080e7          	jalr	ra # 1a8 <.LVL377+0x6>

000001b0 <.LBE952>:

   T3 := Mcycle.Read;

   P := Scalarbase (R);
 1b0:	1e9c                	addi	a5,sp,880
 1b2:	1a98                	addi	a4,sp,368

000001b4 <.L151>:
 1b4:	47d4                	lw	a3,12(a5)
 1b6:	4388                	lw	a0,0(a5)
 1b8:	43cc                	lw	a1,4(a5)
 1ba:	4790                	lw	a2,8(a5)
 1bc:	c754                	sw	a3,12(a4)
 1be:	c308                	sw	a0,0(a4)
 1c0:	c34c                	sw	a1,4(a4)
 1c2:	c710                	sw	a2,8(a4)
 1c4:	07c1                	addi	a5,a5,16
 1c6:	57010693          	addi	a3,sp,1392
 1ca:	0741                	addi	a4,a4,16
 1cc:	fed794e3          	bne	a5,a3,1b4 <.L151>

000001d0 <.LBB954>:
 1d0:	b80027f3          	csrr	a5,mcycleh

000001d4 <.LBB958>:
 1d4:	b0002a73          	csrr	s4,mcycle

000001d8 <.LBB960>:
 1d8:	b8002773          	csrr	a4,mcycleh

000001dc <.LBE960>:
   if High_2 /= High_1 then
 1dc:	30e78463          	beq	a5,a4,4e4 <.L152>
      return Shift_Left (UInt64 (High_2), 32);
 1e0:	c23a                	sw	a4,4(sp)
 1e2:	4a01                	li	s4,0

000001e4 <.L153>:

   T4 := Mcycle.Read;

   SM (0 .. 31) := Pack (P);
 1e4:	1a8c                	addi	a1,sp,368
 1e6:	1008                	addi	a0,sp,32
 1e8:	00000097          	auipc	ra,0x0
 1ec:	000080e7          	jalr	ra # 1e8 <.L153+0x4>

000001f0 <.LVL383>:
 1f0:	100c                	addi	a1,sp,32
 1f2:	41b48533          	sub	a0,s1,s11
 1f6:	02000613          	li	a2,32
 1fa:	00000097          	auipc	ra,0x0
 1fe:	000080e7          	jalr	ra # 1fa <.LVL383+0xa>

00000202 <.LBB963>:
      return K.F;
 202:	85e6                	mv	a1,s9
 204:	04000613          	li	a2,64
 208:	1908                	addi	a0,sp,176
 20a:	00000097          	auipc	ra,0x0
 20e:	000080e7          	jalr	ra # 20a <.LBB963+0x8>

00000212 <.LBE963>:
   SM (32 .. 63) := Serialize (SK) (32 .. 63);
 212:	02000613          	li	a2,32
 216:	098c                	addi	a1,sp,208
 218:	8562                	mv	a0,s8
 21a:	00000097          	auipc	ra,0x0
 21e:	000080e7          	jalr	ra # 21a <.LBE963+0x8>

00000222 <.LBB965>:
 222:	b8002cf3          	csrr	s9,mcycleh

00000226 <.LBB969>:
 226:	b0002c73          	csrr	s8,mcycle

0000022a <.LBB971>:
 22a:	b80027f3          	csrr	a5,mcycleh

0000022e <.LBE971>:
   if High_2 /= High_1 then
 22e:	00fc8463          	beq	s9,a5,236 <.L155>
      return Shift_Left (UInt64 (High_2), 32);
 232:	8cbe                	mv	s9,a5

00000234 <.LVL390>:
 234:	4c01                	li	s8,0

00000236 <.L155>:
      Hashing.Hash (R, M);
 236:	85a6                	mv	a1,s1
 238:	865e                	mv	a2,s7
 23a:	1988                	addi	a0,sp,240
 23c:	00000097          	auipc	ra,0x0
 240:	000080e7          	jalr	ra # 23c <.L155+0x6>

00000244 <.LVL392>:
      X := (others => 0);
 244:	20000613          	li	a2,512
 248:	4581                	li	a1,0
 24a:	1e88                	addi	a0,sp,880
 24c:	00000097          	auipc	ra,0x0
 250:	000080e7          	jalr	ra # 24c <.LVL392+0x8>

00000254 <.LVL393>:
 254:	1998                	addi	a4,sp,240
 256:	1e9c                	addi	a5,sp,880
 258:	57010613          	addi	a2,sp,1392

0000025c <.L156>:
         X (I) := I64 (R (I));
 25c:	00074683          	lbu	a3,0(a4)
 260:	0007a223          	sw	zero,4(a5)
      for I in Index_64 loop
 264:	07a1                	addi	a5,a5,8
         X (I) := I64 (R (I));
 266:	fed7ac23          	sw	a3,-8(a5)
      for I in Index_64 loop
 26a:	0705                	addi	a4,a4,1

0000026c <.LVL395>:
 26c:	fef618e3          	bne	a2,a5,25c <.L156>

00000270 <.LBE975>:
      return ModL (X);
 270:	1e8c                	addi	a1,sp,880
 272:	0908                	addi	a0,sp,144
 274:	00000097          	auipc	ra,0x0
 278:	000080e7          	jalr	ra # 274 <.LBE975+0x4>

0000027c <.LBE973>:

   T5 := Mcycle.Read;

   H := Hash_Reduce (SM);
 27c:	47ca                	lw	a5,144(sp)
 27e:	c8be                	sw	a5,80(sp)
 280:	47da                	lw	a5,148(sp)
 282:	cabe                	sw	a5,84(sp)
 284:	47ea                	lw	a5,152(sp)
 286:	ccbe                	sw	a5,88(sp)
 288:	47fa                	lw	a5,156(sp)
 28a:	cebe                	sw	a5,92(sp)
 28c:	578a                	lw	a5,160(sp)
 28e:	d0be                	sw	a5,96(sp)
 290:	579a                	lw	a5,164(sp)
 292:	d2be                	sw	a5,100(sp)
 294:	57aa                	lw	a5,168(sp)
 296:	d4be                	sw	a5,104(sp)
 298:	57ba                	lw	a5,172(sp)
 29a:	d6be                	sw	a5,108(sp)

0000029c <.LBB976>:
 29c:	b80027f3          	csrr	a5,mcycleh

000002a0 <.LBB980>:
 2a0:	b0002bf3          	csrr	s7,mcycle

000002a4 <.LBB982>:
 2a4:	b8002773          	csrr	a4,mcycleh

000002a8 <.LBE982>:
   if High_2 /= High_1 then
 2a8:	22e78c63          	beq	a5,a4,4e0 <.L157>
      return Shift_Left (UInt64 (High_2), 32);
 2ac:	c03a                	sw	a4,0(sp)
 2ae:	4b81                	li	s7,0

000002b0 <.L158>:

   T6 := Mcycle.Read;

   X := (others => 0);
 2b0:	20000613          	li	a2,512
 2b4:	4581                	li	a1,0
 2b6:	1e88                	addi	a0,sp,880
 2b8:	00000097          	auipc	ra,0x0
 2bc:	000080e7          	jalr	ra # 2b8 <.L158+0x8>

000002c0 <.LVL401>:
 2c0:	37010e93          	addi	t4,sp,880
 2c4:	1898                	addi	a4,sp,112
 2c6:	47010613          	addi	a2,sp,1136
 2ca:	87f6                	mv	a5,t4

000002cc <.L159>:
   for I in Index_32 loop
      X (I) := I64 (R (I));
 2cc:	00074683          	lbu	a3,0(a4)
 2d0:	0007a223          	sw	zero,4(a5)
   for I in Index_32 loop
 2d4:	07a1                	addi	a5,a5,8
      X (I) := I64 (R (I));
 2d6:	fed7ac23          	sw	a3,-8(a5)
   for I in Index_32 loop
 2da:	0705                	addi	a4,a4,1

000002dc <.LVL403>:
 2dc:	fec798e3          	bne	a5,a2,2cc <.L159>

000002e0 <.LBB986>:
 2e0:	b80028f3          	csrr	a7,mcycleh

000002e4 <.LBB990>:
 2e4:	b0002373          	csrr	t1,mcycle

000002e8 <.LBB992>:
 2e8:	b80027f3          	csrr	a5,mcycleh

000002ec <.LBE992>:
   if High_2 /= High_1 then
 2ec:	00f88463          	beq	a7,a5,2f4 <.L161>
      return Shift_Left (UInt64 (High_2), 32);
 2f0:	88be                	mv	a7,a5

000002f2 <.LVL407>:
 2f2:	4301                	li	t1,0

000002f4 <.L161>:
 2f4:	05010e13          	addi	t3,sp,80

000002f8 <.LBB994>:
        (for all K in Index_64 => X (K) in I64_Byte)
     );

   pragma Warnings (Off, "explicit membership test may be optimized");

   for I in Index_32 loop
 2f8:	557d                	li	a0,-1
 2fa:	4f7d                	li	t5,31

000002fc <.L163>:
 2fc:	000e4803          	lbu	a6,0(t3)
 300:	0505                	addi	a0,a0,1

00000302 <.LVL410>:
 302:	1a10                	addi	a2,sp,304
 304:	86f6                	mv	a3,t4

00000306 <.L162>:
      for J in Index_32 loop
         T := Byte_Product (H (I)) * Byte_Product (D (J));
 306:	00064703          	lbu	a4,0(a2)
         X (I + J) := X (I + J) + T;
 30a:	429c                	lw	a5,0(a3)
 30c:	42cc                	lw	a1,4(a3)
         T := Byte_Product (H (I)) * Byte_Product (D (J));
 30e:	03070733          	mul	a4,a4,a6
      for J in Index_32 loop
 312:	06a1                	addi	a3,a3,8
 314:	0605                	addi	a2,a2,1

00000316 <.LVL412>:
         X (I + J) := X (I + J) + T;
 316:	973e                	add	a4,a4,a5
 318:	00f737b3          	sltu	a5,a4,a5
 31c:	97ae                	add	a5,a5,a1
 31e:	fee6ac23          	sw	a4,-8(a3)
 322:	fef6ae23          	sw	a5,-4(a3)
      for J in Index_32 loop
 326:	fecd10e3          	bne	s10,a2,306 <.L162>

0000032a <.LBE995>:
   for I in Index_32 loop
 32a:	0e05                	addi	t3,t3,1
 32c:	0ea1                	addi	t4,t4,8
 32e:	fde517e3          	bne	a0,t5,2fc <.L163>

00000332 <.LBB996>:
 332:	b8002773          	csrr	a4,mcycleh

00000336 <.LBB1000>:
 336:	b00027f3          	csrr	a5,mcycle

0000033a <.LBB1002>:
 33a:	b80026f3          	csrr	a3,mcycleh

0000033e <.LBE1002>:
   if High_2 /= High_1 then
 33e:	00d70463          	beq	a4,a3,346 <.L165>
      return Shift_Left (UInt64 (High_2), 32);
 342:	8736                	mv	a4,a3

00000344 <.LVL416>:
 344:	4781                	li	a5,0

00000346 <.L165>:

   --  Simplify - this assert is equivalent to the precondition of ModL
   pragma Assert
     (for all K in Index_64 => X (K) in 0 .. (32 * MBP + 255));

   SM (32 .. 63) := ModL (X);
 346:	1e8c                	addi	a1,sp,880
 348:	1988                	addi	a0,sp,240

0000034a <.LVL418>:
 34a:	ce3a                	sw	a4,28(sp)

0000034c <.LVL419>:
 34c:	cc3e                	sw	a5,24(sp)
 34e:	ca46                	sw	a7,20(sp)
 350:	c81a                	sw	t1,16(sp)
 352:	00000097          	auipc	ra,0x0
 356:	000080e7          	jalr	ra # 352 <.LVL419+0x6>

0000035a <.LVL420>:
 35a:	41b48533          	sub	a0,s1,s11
 35e:	02000613          	li	a2,32
 362:	198c                	addi	a1,sp,240
 364:	02050513          	addi	a0,a0,32
 368:	00000097          	auipc	ra,0x0
 36c:	000080e7          	jalr	ra # 368 <.LVL420+0xe>

00000370 <.LBB1004>:
 370:	b80024f3          	csrr	s1,mcycleh

00000374 <.LBB1008>:
 374:	b0002df3          	csrr	s11,mcycle

00000378 <.LBB1010>:
 378:	b80026f3          	csrr	a3,mcycleh

0000037c <.LBE1010>:
   if High_2 /= High_1 then
 37c:	4342                	lw	t1,16(sp)
 37e:	48d2                	lw	a7,20(sp)
 380:	47e2                	lw	a5,24(sp)
 382:	4772                	lw	a4,28(sp)
 384:	00d48463          	beq	s1,a3,38c <.L167>
      return Shift_Left (UInt64 (High_2), 32);
 388:	84b6                	mv	s1,a3

0000038a <.LVL425>:
 38a:	4d81                	li	s11,0

0000038c <.L167>:

   T9 := Mcycle.Read;

   Sanitize (D);
 38c:	000005b7          	lui	a1,0x0
 390:	1a08                	addi	a0,sp,304
 392:	00058593          	mv	a1,a1
 396:	ce3a                	sw	a4,28(sp)
 398:	cc3e                	sw	a5,24(sp)
 39a:	ca46                	sw	a7,20(sp)

0000039c <.LVL427>:
 39c:	c81a                	sw	t1,16(sp)

0000039e <.LVL428>:
   Sanitize (H);
 39e:	00000d37          	lui	s10,0x0
   Sanitize (D);
 3a2:	00000097          	auipc	ra,0x0
 3a6:	000080e7          	jalr	ra # 3a2 <.LVL428+0x4>

000003aa <.LVL429>:
   Sanitize (H);
 3aa:	0888                	addi	a0,sp,80
 3ac:	000d0593          	mv	a1,s10
 3b0:	00000097          	auipc	ra,0x0
 3b4:	000080e7          	jalr	ra # 3b0 <.LVL429+0x6>

000003b8 <.LVL430>:
   Sanitize (R);
 3b8:	1888                	addi	a0,sp,112
 3ba:	000d0593          	mv	a1,s10
 3be:	00000097          	auipc	ra,0x0
 3c2:	000080e7          	jalr	ra # 3be <.LVL430+0x6>

000003c6 <.LVL431>:
   Sanitize_I64_Seq (X);
 3c6:	000005b7          	lui	a1,0x0
 3ca:	1e88                	addi	a0,sp,880
 3cc:	00058593          	mv	a1,a1
 3d0:	00000097          	auipc	ra,0x0
 3d4:	000080e7          	jalr	ra # 3d0 <.LVL431+0xa>

000003d8 <.LVL432>:

   Hash_SK_Time         := Unsigned_64 (T2 - T1);
 3d8:	4732                	lw	a4,12(sp)
 3da:	47a2                	lw	a5,8(sp)
   Hash_Reduce_SM1_Time := Unsigned_64 (T3 - T2);
   Scalarbase_R_Time    := Unsigned_64 (T4 - T3);
   Pack_P_Time          := Unsigned_64 (T5 - T4);
   Hash_Reduce_SM2_Time := Unsigned_64 (T6 - T5);
   Initialize_X_Time    := Unsigned_64 (T7 - T6);
 3dc:	48d2                	lw	a7,20(sp)
   Hash_SK_Time         := Unsigned_64 (T2 - T1);
 3de:	40e98fb3          	sub	t6,s3,a4
   Scalarbase_R_Time    := Unsigned_64 (T4 - T3);
 3e2:	4712                	lw	a4,4(sp)
   Hash_Reduce_SM1_Time := Unsigned_64 (T3 - T2);
 3e4:	413909b3          	sub	s3,s2,s3

000003e8 <.LVL433>:
   Initialize_X_Time    := Unsigned_64 (T7 - T6);
 3e8:	4342                	lw	t1,16(sp)
   Pack_P_Time          := Unsigned_64 (T5 - T4);
 3ea:	40ec82b3          	sub	t0,s9,a4
   Scalarbase_R_Time    := Unsigned_64 (T4 - T3);
 3ee:	41270933          	sub	s2,a4,s2

000003f2 <.LVL434>:
   Hash_Reduce_SM2_Time := Unsigned_64 (T6 - T5);
 3f2:	4702                	lw	a4,0(sp)
   Hash_SK_Time         := Unsigned_64 (T2 - T1);
 3f4:	40fb0f33          	sub	t5,s6,a5
   Assign_X_Time        := Unsigned_64 (T8 - T7);
 3f8:	47e2                	lw	a5,24(sp)
   Hash_Reduce_SM2_Time := Unsigned_64 (T6 - T5);
 3fa:	41970cb3          	sub	s9,a4,s9

000003fe <.LVL435>:
   Initialize_X_Time    := Unsigned_64 (T7 - T6);
 3fe:	40e883b3          	sub	t2,a7,a4
   Assign_X_Time        := Unsigned_64 (T8 - T7);
 402:	4772                	lw	a4,28(sp)
   Hash_Reduce_SM2_Time := Unsigned_64 (T6 - T5);
 404:	418b8533          	sub	a0,s7,s8
   Hash_Reduce_SM1_Time := Unsigned_64 (T3 - T2);
 408:	416a8eb3          	sub	t4,s5,s6
   Scalarbase_R_Time    := Unsigned_64 (T4 - T3);
 40c:	415a0e33          	sub	t3,s4,s5
   Pack_P_Time          := Unsigned_64 (T5 - T4);
 410:	414c0833          	sub	a6,s8,s4
   Initialize_X_Time    := Unsigned_64 (T7 - T6);
 414:	417305b3          	sub	a1,t1,s7
   Assign_X_Time        := Unsigned_64 (T8 - T7);
 418:	40678633          	sub	a2,a5,t1
   ModL_X_Time          := Unsigned_64 (T9 - T8);
 41c:	40fd86b3          	sub	a3,s11,a5
   Hash_Reduce_SM1_Time := Unsigned_64 (T3 - T2);
 420:	01dabab3          	sltu	s5,s5,t4
   Scalarbase_R_Time    := Unsigned_64 (T4 - T3);
 424:	01ca3a33          	sltu	s4,s4,t3

00000428 <.LVL436>:
   Hash_Reduce_SM2_Time := Unsigned_64 (T6 - T5);
 428:	00abbbb3          	sltu	s7,s7,a0

0000042c <.LVL437>:
   Assign_X_Time        := Unsigned_64 (T8 - T7);
 42c:	00c7b7b3          	sltu	a5,a5,a2
 430:	411708b3          	sub	a7,a4,a7
   ModL_X_Time          := Unsigned_64 (T9 - T8);
 434:	00ddbdb3          	sltu	s11,s11,a3

00000438 <.LVL438>:
 438:	40e48733          	sub	a4,s1,a4
   Hash_SK_Time         := Unsigned_64 (T2 - T1);
 43c:	01eb3b33          	sltu	s6,s6,t5
   Pack_P_Time          := Unsigned_64 (T5 - T4);
 440:	010c3c33          	sltu	s8,s8,a6
   Initialize_X_Time    := Unsigned_64 (T7 - T6);
 444:	00b33333          	sltu	t1,t1,a1
   Hash_Reduce_SM1_Time := Unsigned_64 (T3 - T2);
 448:	415989b3          	sub	s3,s3,s5
   Scalarbase_R_Time    := Unsigned_64 (T4 - T3);
 44c:	41490933          	sub	s2,s2,s4
   Hash_Reduce_SM2_Time := Unsigned_64 (T6 - T5);
 450:	417c8bb3          	sub	s7,s9,s7
   Hash_SK_Time         := Unsigned_64 (T2 - T1);
 454:	416f8b33          	sub	s6,t6,s6
   Pack_P_Time          := Unsigned_64 (T5 - T4);
 458:	41828c33          	sub	s8,t0,s8
   Assign_X_Time        := Unsigned_64 (T8 - T7);
 45c:	40f888b3          	sub	a7,a7,a5
   Initialize_X_Time    := Unsigned_64 (T7 - T6);
 460:	40638333          	sub	t1,t2,t1
   ModL_X_Time          := Unsigned_64 (T9 - T8);
 464:	41b707b3          	sub	a5,a4,s11

00000468 <.LBE1015>:

   pragma Unreferenced (D, H, R, X);
end Sign2;
 468:	01642223          	sw	s6,4(s0)
 46c:	01342623          	sw	s3,12(s0)
 470:	01242a23          	sw	s2,20(s0)
 474:	01842e23          	sw	s8,28(s0)
 478:	d008                	sw	a0,32(s0)
 47a:	5ac12083          	lw	ra,1452(sp)
 47e:	01e42023          	sw	t5,0(s0)
 482:	01d42423          	sw	t4,8(s0)
 486:	01c42823          	sw	t3,16(s0)
 48a:	01042c23          	sw	a6,24(s0)
 48e:	03742223          	sw	s7,36(s0)
 492:	d40c                	sw	a1,40(s0)
 494:	02642623          	sw	t1,44(s0)
 498:	d810                	sw	a2,48(s0)
 49a:	03142a23          	sw	a7,52(s0)
 49e:	dc14                	sw	a3,56(s0)
 4a0:	dc5c                	sw	a5,60(s0)
 4a2:	8522                	mv	a0,s0
 4a4:	5a812403          	lw	s0,1448(sp)
 4a8:	5a412483          	lw	s1,1444(sp)
 4ac:	5a012903          	lw	s2,1440(sp)
 4b0:	59c12983          	lw	s3,1436(sp)
 4b4:	59812a03          	lw	s4,1432(sp)
 4b8:	59412a83          	lw	s5,1428(sp)
 4bc:	59012b03          	lw	s6,1424(sp)
 4c0:	58c12b83          	lw	s7,1420(sp)
 4c4:	58812c03          	lw	s8,1416(sp)
 4c8:	58412c83          	lw	s9,1412(sp)
 4cc:	58012d03          	lw	s10,1408(sp)
 4d0:	57c12d83          	lw	s11,1404(sp)
 4d4:	5b010113          	addi	sp,sp,1456

000004d8 <.LVL440>:
 4d8:	8082                	ret

000004da <.L143>:
   else
      return Shift_Left (UInt64 (High_1), 32) + UInt64 (Low);
 4da:	c436                	sw	a3,8(sp)
 4dc:	c63e                	sw	a5,12(sp)
 4de:	beb5                	j	5a <.L144>

000004e0 <.L157>:
 4e0:	c03e                	sw	a5,0(sp)
 4e2:	b3f9                	j	2b0 <.L158>

000004e4 <.L152>:
 4e4:	c23e                	sw	a5,4(sp)
 4e6:	b9fd                	j	1e4 <.L153>

Disassembly of section .text.sparknacl__sign__open:

00000000 <sparknacl__sign__open>:
                    Initialize_X_Time    :    out Unsigned_64;
                    Assign_X_Time        :    out Unsigned_64;
                    ModL_X_Time          :    out Unsigned_64)
   is separate;

   procedure Open (M      :    out Byte_Seq;
   0:	7171                	addi	sp,sp,-176
   2:	c75e                	sw	s7,140(sp)

00000004 <.LBB1044>:
   4:	0006ab83          	lw	s7,0(a3)
      T    : Bytes_32;
      P, Q : GF_Vector_4;
      LN   : I32;
   begin
      MLen := -1;
      if SM'Length < 64 then
   8:	0046a883          	lw	a7,4(a3)

0000000c <.LBE1044>:
   procedure Open (M      :    out Byte_Seq;
   c:	d522                	sw	s0,168(sp)

0000000e <.LBB1068>:
      if SM'Length < 64 then
   e:	03eb8813          	addi	a6,s7,62
  12:	41fbd313          	srai	t1,s7,0x1f
  16:	017837b3          	sltu	a5,a6,s7

0000001a <.LBE1068>:
   procedure Open (M      :    out Byte_Seq;
  1a:	d326                	sw	s1,164(sp)
  1c:	d14a                	sw	s2,160(sp)
  1e:	cf4e                	sw	s3,156(sp)
  20:	cb56                	sw	s5,148(sp)
  22:	c95a                	sw	s6,144(sp)
  24:	d706                	sw	ra,172(sp)
  26:	cd52                	sw	s4,152(sp)
  28:	8436                	mv	s0,a3

0000002a <.LBB1069>:
      if SM'Length < 64 then
  2a:	979a                	add	a5,a5,t1
  2c:	41f8d693          	srai	a3,a7,0x1f
   procedure Open (M      :    out Byte_Seq;
  30:	0005ab03          	lw	s6,0(a1) # 0 <sparknacl__sign__open>

00000034 <.LBE1069>:
  34:	81010113          	addi	sp,sp,-2032
  38:	84ae                	mv	s1,a1
  3a:	892a                	mv	s2,a0

0000003c <.LVL445>:
  3c:	89b2                	mv	s3,a2

0000003e <.LVL446>:
  3e:	8aba                	mv	s5,a4

00000040 <.LBB1070>:
      if SM'Length < 64 then
  40:	04d7c563          	blt	a5,a3,8a <.L176>
  44:	04f68163          	beq	a3,a5,86 <.L202>

00000048 <.L196>:
   procedure Open (M      :    out Byte_Seq;
  48:	40dc                	lw	a5,4(s1)
         M := (others => 0);
  4a:	4601                	li	a2,0
  4c:	0367d963          	bge	a5,s6,7e <.L203>

00000050 <.L178>:
  50:	4581                	li	a1,0
  52:	854a                	mv	a0,s2
  54:	00000097          	auipc	ra,0x0
  58:	000080e7          	jalr	ra # 54 <.L178+0x4>

0000005c <.LVL449>:
      MLen := -1;
  5c:	547d                	li	s0,-1

0000005e <.LVL450>:
         Status := False;
  5e:	4a01                	li	s4,0

00000060 <.L179>:

      Sanitize (T);
      Sanitize_GF_Vector_4 (P);
      Sanitize_GF_Vector_4 (Q);
      pragma Unreferenced (T, P, Q);
   end Open;
  60:	7f010113          	addi	sp,sp,2032
  64:	50ba                	lw	ra,172(sp)
  66:	8552                	mv	a0,s4
  68:	85a2                	mv	a1,s0
  6a:	549a                	lw	s1,164(sp)

0000006c <.LVL452>:
  6c:	542a                	lw	s0,168(sp)

0000006e <.LVL453>:
  6e:	590a                	lw	s2,160(sp)
  70:	49fa                	lw	s3,156(sp)
  72:	4a6a                	lw	s4,152(sp)

00000074 <.LVL454>:
  74:	4ada                	lw	s5,148(sp)
  76:	4b4a                	lw	s6,144(sp)
  78:	4bba                	lw	s7,140(sp)
  7a:	614d                	addi	sp,sp,176
  7c:	8082                	ret

0000007e <.L203>:
         M := (others => 0);
  7e:	0785                	addi	a5,a5,1
  80:	41678633          	sub	a2,a5,s6
  84:	b7f1                	j	50 <.L178>

00000086 <.L202>:
      if SM'Length < 64 then
  86:	fd1871e3          	bgeu	a6,a7,48 <.L196>

0000008a <.L176>:
      return K.F;
  8a:	02000613          	li	a2,32
  8e:	85d6                	mv	a1,s5
  90:	67010513          	addi	a0,sp,1648
  94:	00000097          	auipc	ra,0x0
  98:	000080e7          	jalr	ra # 94 <.L176+0xa>

0000009c <.LBE1046>:
      Unpackneg (Q, Status, Serialize (PK));
  9c:	67010593          	addi	a1,sp,1648
  a0:	47010513          	addi	a0,sp,1136
  a4:	00000097          	auipc	ra,0x0
  a8:	000080e7          	jalr	ra # a4 <.LBE1046+0x8>

000000ac <.LVL459>:
  ac:	8a2a                	mv	s4,a0

000000ae <.LVL460>:
      if not Status then
  ae:	e929                	bnez	a0,100 <.L180>
         M := (others => 0);
  b0:	40dc                	lw	a5,4(s1)
  b2:	4098                	lw	a4,0(s1)
  b4:	4601                	li	a2,0
  b6:	00e7c563          	blt	a5,a4,c0 <.L181>
  ba:	0785                	addi	a5,a5,1
  bc:	40e78633          	sub	a2,a5,a4

000000c0 <.L181>:
  c0:	4581                	li	a1,0
  c2:	854a                	mv	a0,s2

000000c4 <.LVL464>:
  c4:	00000097          	auipc	ra,0x0
  c8:	000080e7          	jalr	ra # c4 <.LVL464>

000000cc <.L201>:
         Sanitize_GF (R (I));
  cc:	47010513          	addi	a0,sp,1136
  d0:	00000097          	auipc	ra,0x0
  d4:	000080e7          	jalr	ra # d0 <.L201+0x4>

000000d8 <.LVL466>:
  d8:	4f010513          	addi	a0,sp,1264
  dc:	00000097          	auipc	ra,0x0
  e0:	000080e7          	jalr	ra # dc <.LVL466+0x4>

000000e4 <.LVL467>:
  e4:	57010513          	addi	a0,sp,1392
  e8:	00000097          	auipc	ra,0x0
  ec:	000080e7          	jalr	ra # e8 <.LVL467+0x4>

000000f0 <.LVL468>:
  f0:	5f010513          	addi	a0,sp,1520
  f4:	00000097          	auipc	ra,0x0
  f8:	000080e7          	jalr	ra # f4 <.LVL468+0x4>

000000fc <.LBE1048>:
      MLen := -1;
  fc:	547d                	li	s0,-1

000000fe <.LVL470>:
  fe:	b78d                	j	60 <.L179>

00000100 <.L180>:
      M := SM; -- precondition ensures lengths match
 100:	405c                	lw	a5,4(s0)
 102:	4018                	lw	a4,0(s0)
 104:	4601                	li	a2,0
 106:	00e7c563          	blt	a5,a4,110 <.L182>
 10a:	0785                	addi	a5,a5,1
 10c:	40e78633          	sub	a2,a5,a4

00000110 <.L182>:
 110:	85ce                	mv	a1,s3
 112:	854a                	mv	a0,s2

00000114 <.LVL472>:
 114:	00000097          	auipc	ra,0x0
 118:	000080e7          	jalr	ra # 114 <.LVL472>

0000011c <.LBB1051>:
      return K.F;
 11c:	02000613          	li	a2,32
 120:	85d6                	mv	a1,s5
 122:	0c88                	addi	a0,sp,592
 124:	00000097          	auipc	ra,0x0
 128:	000080e7          	jalr	ra # 124 <.LBB1051+0x8>

0000012c <.LBE1051>:
      M (32 .. 63) := Serialize (PK);
 12c:	41690533          	sub	a0,s2,s6
 130:	02000613          	li	a2,32
 134:	0c8c                	addi	a1,sp,592
 136:	02050513          	addi	a0,a0,32
 13a:	00000097          	auipc	ra,0x0
 13e:	000080e7          	jalr	ra # 13a <.LBE1051+0xe>

00000142 <.LBB1054>:
      Hashing.Hash (R, M);
 142:	85ca                	mv	a1,s2
 144:	8626                	mv	a2,s1
 146:	1c88                	addi	a0,sp,624
 148:	00000097          	auipc	ra,0x0
 14c:	000080e7          	jalr	ra # 148 <.LBB1054+0x6>

00000150 <.LVL476>:
      X := (others => 0);
 150:	20000613          	li	a2,512
 154:	4581                	li	a1,0
 156:	67010513          	addi	a0,sp,1648
 15a:	00000097          	auipc	ra,0x0
 15e:	000080e7          	jalr	ra # 15a <.LVL476+0xa>

00000162 <.LVL477>:
 162:	6685                	lui	a3,0x1
 164:	86068613          	addi	a2,a3,-1952 # 860 <.LBB498>
 168:	0814                	addi	a3,sp,16
 16a:	1c98                	addi	a4,sp,624
 16c:	67010793          	addi	a5,sp,1648
 170:	9636                	add	a2,a2,a3

00000172 <.L183>:
         X (I) := I64 (R (I));
 172:	00074683          	lbu	a3,0(a4)
 176:	0007a223          	sw	zero,4(a5)
      for I in Index_64 loop
 17a:	07a1                	addi	a5,a5,8
         X (I) := I64 (R (I));
 17c:	fed7ac23          	sw	a3,-8(a5)
      for I in Index_64 loop
 180:	0705                	addi	a4,a4,1

00000182 <.LVL479>:
 182:	fec798e3          	bne	a5,a2,172 <.L183>

00000186 <.LBE1056>:
      return ModL (X);
 186:	67010593          	addi	a1,sp,1648
 18a:	1c08                	addi	a0,sp,560
 18c:	00000097          	auipc	ra,0x0
 190:	000080e7          	jalr	ra # 18c <.LBE1056+0x6>

00000194 <.LBE1054>:
      P := Scalarmult (Q, Hash_Reduce (M));
 194:	6a85                	lui	s5,0x1

00000196 <.LVL481>:
 196:	0818                	addi	a4,sp,16
 198:	7a7d                	lui	s4,0xfffff
 19a:	860a8793          	addi	a5,s5,-1952 # 860 <.LBB498>
 19e:	97ba                	add	a5,a5,a4
 1a0:	7c0a0513          	addi	a0,s4,1984 # fffff7c0 <.LLST56+0xffffdf3a>
 1a4:	953e                	add	a0,a0,a5
 1a6:	1c10                	addi	a2,sp,560
 1a8:	47010593          	addi	a1,sp,1136
 1ac:	00000097          	auipc	ra,0x0
 1b0:	000080e7          	jalr	ra # 1ac <.LVL481+0x16>

000001b4 <.LVL482>:
 1b4:	0818                	addi	a4,sp,16
 1b6:	860a8793          	addi	a5,s5,-1952
 1ba:	97ba                	add	a5,a5,a4
 1bc:	97d2                	add	a5,a5,s4
 1be:	c63e                	sw	a5,12(sp)
 1c0:	7c078793          	addi	a5,a5,1984
 1c4:	1c98                	addi	a4,sp,624
 1c6:	20078813          	addi	a6,a5,512

000001ca <.L184>:
 1ca:	4388                	lw	a0,0(a5)
 1cc:	43cc                	lw	a1,4(a5)
 1ce:	4790                	lw	a2,8(a5)
 1d0:	47d4                	lw	a3,12(a5)
 1d2:	c308                	sw	a0,0(a4)
 1d4:	c34c                	sw	a1,4(a4)
 1d6:	c710                	sw	a2,8(a4)
 1d8:	c754                	sw	a3,12(a4)
 1da:	07c1                	addi	a5,a5,16
 1dc:	0741                	addi	a4,a4,16
 1de:	ff0796e3          	bne	a5,a6,1ca <.L184>

000001e2 <.LVL483>:
      Q := Scalarbase (SM (32 .. 63));
 1e2:	41798633          	sub	a2,s3,s7

000001e6 <.LBB1057>:
      return Scalarmult (Scalarbase_Q, S);
 1e6:	000005b7          	lui	a1,0x0
 1ea:	02060613          	addi	a2,a2,32

000001ee <.LVL484>:
 1ee:	00058593          	mv	a1,a1
 1f2:	67010513          	addi	a0,sp,1648
 1f6:	00000097          	auipc	ra,0x0
 1fa:	000080e7          	jalr	ra # 1f6 <.LVL484+0x8>

000001fe <.LBE1057>:
      Q := Scalarbase (SM (32 .. 63));
 1fe:	6685                	lui	a3,0x1
 200:	86068813          	addi	a6,a3,-1952 # 860 <.LBB498>
 204:	0814                	addi	a3,sp,16
 206:	67010793          	addi	a5,sp,1648
 20a:	47010713          	addi	a4,sp,1136
 20e:	9836                	add	a6,a6,a3

00000210 <.L185>:
 210:	4388                	lw	a0,0(a5)
 212:	43cc                	lw	a1,4(a5)
 214:	4790                	lw	a2,8(a5)
 216:	47d4                	lw	a3,12(a5)
 218:	c308                	sw	a0,0(a4)
 21a:	c34c                	sw	a1,4(a4)
 21c:	c710                	sw	a2,8(a4)
 21e:	c754                	sw	a3,12(a4)
 220:	07c1                	addi	a5,a5,16
 222:	0741                	addi	a4,a4,16
 224:	ff0796e3          	bne	a5,a6,210 <.L185>
      Add (P, Q);
 228:	47010593          	addi	a1,sp,1136
 22c:	1c88                	addi	a0,sp,624
 22e:	00000097          	auipc	ra,0x0
 232:	000080e7          	jalr	ra # 22e <.L185+0x1e>

00000236 <.LVL486>:
      T := Pack (P);
 236:	6a85                	lui	s5,0x1
 238:	7a7d                	lui	s4,0xfffff
 23a:	0818                	addi	a4,sp,16
 23c:	860a8793          	addi	a5,s5,-1952 # 860 <.LBB498>
 240:	97ba                	add	a5,a5,a4
 242:	7a0a0513          	addi	a0,s4,1952 # fffff7a0 <.LLST56+0xffffdf1a>
 246:	953e                	add	a0,a0,a5
 248:	1c8c                	addi	a1,sp,624
 24a:	00000097          	auipc	ra,0x0
 24e:	000080e7          	jalr	ra # 24a <.LVL486+0x14>

00000252 <.LVL487>:
 252:	0818                	addi	a4,sp,16
 254:	860a8793          	addi	a5,s5,-1952
 258:	97ba                	add	a5,a5,a4
 25a:	97d2                	add	a5,a5,s4
 25c:	7a078593          	addi	a1,a5,1952
 260:	02000613          	li	a2,32
 264:	67010513          	addi	a0,sp,1648
 268:	c63e                	sw	a5,12(sp)
      if not Equal (SM (0 .. 31), T) then
 26a:	00000ab7          	lui	s5,0x0
      T := Pack (P);
 26e:	00000097          	auipc	ra,0x0
 272:	000080e7          	jalr	ra # 26e <.LVL487+0x1c>

00000276 <.LVL488>:
      if not Equal (SM (0 .. 31), T) then
 276:	67010613          	addi	a2,sp,1648
 27a:	000a8693          	mv	a3,s5
 27e:	41798533          	sub	a0,s3,s7
 282:	000a8593          	mv	a1,s5
 286:	00000097          	auipc	ra,0x0
 28a:	000080e7          	jalr	ra # 286 <.LVL488+0x10>

0000028e <.LVL489>:
 28e:	8a2a                	mv	s4,a0
 290:	ed21                	bnez	a0,2e8 <.L186>
         M := (others => 0);
 292:	40dc                	lw	a5,4(s1)
 294:	4098                	lw	a4,0(s1)
 296:	4601                	li	a2,0
 298:	00e7c563          	blt	a5,a4,2a2 <.L187>
 29c:	0785                	addi	a5,a5,1
 29e:	40e78633          	sub	a2,a5,a4

000002a2 <.L187>:
 2a2:	4581                	li	a1,0
 2a4:	854a                	mv	a0,s2
 2a6:	00000097          	auipc	ra,0x0
 2aa:	000080e7          	jalr	ra # 2a6 <.L187+0x4>

000002ae <.LVL493>:
         Sanitize (T);
 2ae:	000a8593          	mv	a1,s5
 2b2:	67010513          	addi	a0,sp,1648
 2b6:	00000097          	auipc	ra,0x0
 2ba:	000080e7          	jalr	ra # 2b6 <.LVL493+0x8>

000002be <.LBB1059>:
         Sanitize_GF (R (I));
 2be:	1c88                	addi	a0,sp,624

000002c0 <.LVL495>:
 2c0:	00000097          	auipc	ra,0x0
 2c4:	000080e7          	jalr	ra # 2c0 <.LVL495>

000002c8 <.LVL496>:
 2c8:	1d88                	addi	a0,sp,752
 2ca:	00000097          	auipc	ra,0x0
 2ce:	000080e7          	jalr	ra # 2ca <.LVL496+0x2>

000002d2 <.LVL497>:
 2d2:	1e88                	addi	a0,sp,880
 2d4:	00000097          	auipc	ra,0x0
 2d8:	000080e7          	jalr	ra # 2d4 <.LVL497+0x2>

000002dc <.LVL498>:
 2dc:	1f88                	addi	a0,sp,1008
 2de:	00000097          	auipc	ra,0x0
 2e2:	000080e7          	jalr	ra # 2de <.LVL498+0x2>

000002e6 <.LVL499>:
 2e6:	b3dd                	j	cc <.L201>

000002e8 <.L186>:
      LN := I32 (I64 (SM'Length) - 64);
 2e8:	405c                	lw	a5,4(s0)
 2ea:	4000                	lw	s0,0(s0)

000002ec <.LVL501>:
 2ec:	417989b3          	sub	s3,s3,s7
 2f0:	41690533          	sub	a0,s2,s6
 2f4:	04098593          	addi	a1,s3,64 # 40 <.LBB1070>
 2f8:	0687de63          	bge	a5,s0,374 <.L204>
 2fc:	4601                	li	a2,0
 2fe:	fc000413          	li	s0,-64

00000302 <.L188>:
      M (0 .. LN - 1) := SM (64 .. LN + 63);
 302:	00000097          	auipc	ra,0x0
 306:	000080e7          	jalr	ra # 302 <.L188>

0000030a <.LVL502>:
      Sanitize (T);
 30a:	000a8593          	mv	a1,s5
 30e:	67010513          	addi	a0,sp,1648
 312:	00000097          	auipc	ra,0x0
 316:	000080e7          	jalr	ra # 312 <.LVL502+0x8>

0000031a <.LBB1062>:
         Sanitize_GF (R (I));
 31a:	1c88                	addi	a0,sp,624

0000031c <.LVL504>:
 31c:	00000097          	auipc	ra,0x0
 320:	000080e7          	jalr	ra # 31c <.LVL504>

00000324 <.LVL505>:
 324:	1d88                	addi	a0,sp,752
 326:	00000097          	auipc	ra,0x0
 32a:	000080e7          	jalr	ra # 326 <.LVL505+0x2>

0000032e <.LVL506>:
 32e:	1e88                	addi	a0,sp,880
 330:	00000097          	auipc	ra,0x0
 334:	000080e7          	jalr	ra # 330 <.LVL506+0x2>

00000338 <.LVL507>:
 338:	1f88                	addi	a0,sp,1008
 33a:	00000097          	auipc	ra,0x0
 33e:	000080e7          	jalr	ra # 33a <.LVL507+0x2>

00000342 <.LBB1065>:
 342:	47010513          	addi	a0,sp,1136
 346:	00000097          	auipc	ra,0x0
 34a:	000080e7          	jalr	ra # 346 <.LBB1065+0x4>

0000034e <.LVL509>:
 34e:	4f010513          	addi	a0,sp,1264
 352:	00000097          	auipc	ra,0x0
 356:	000080e7          	jalr	ra # 352 <.LVL509+0x4>

0000035a <.LVL510>:
 35a:	57010513          	addi	a0,sp,1392
 35e:	00000097          	auipc	ra,0x0
 362:	000080e7          	jalr	ra # 35e <.LVL510+0x4>

00000366 <.LVL511>:
 366:	5f010513          	addi	a0,sp,1520
 36a:	00000097          	auipc	ra,0x0
 36e:	000080e7          	jalr	ra # 36a <.LVL511+0x4>

00000372 <.LVL512>:
 372:	b1fd                	j	60 <.L179>

00000374 <.L204>:
      LN := I32 (I64 (SM'Length) - 64);
 374:	fc178793          	addi	a5,a5,-63
 378:	40878433          	sub	s0,a5,s0
 37c:	fff44613          	not	a2,s0
 380:	867d                	srai	a2,a2,0x1f
 382:	8e61                	and	a2,a2,s0
 384:	bfbd                	j	302 <.L188>
