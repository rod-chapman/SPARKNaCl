
sparknacl-sign.o:     file format elf32-littleriscv


Disassembly of section .text.sparknacl__sign__add:

00000000 <sparknacl__sign__add>:
   0:	c6010113          	addi	sp,sp,-928
   4:	39212823          	sw	s2,912(sp)
   8:	08050913          	addi	s2,a0,128
   c:	862a                	mv	a2,a0
   e:	38912a23          	sw	s1,916(sp)
  12:	39512223          	sw	s5,900(sp)
  16:	84aa                	mv	s1,a0
  18:	8aae                	mv	s5,a1
  1a:	0508                	addi	a0,sp,640
  1c:	85ca                	mv	a1,s2
  1e:	38112e23          	sw	ra,924(sp)
  22:	38812c23          	sw	s0,920(sp)
  26:	39312623          	sw	s3,908(sp)
  2a:	39412423          	sw	s4,904(sp)
  2e:	080a8993          	addi	s3,s5,128
  32:	00000097          	auipc	ra,0x0
  36:	000080e7          	jalr	ra # 32 <sparknacl__sign__add+0x32>
  3a:	8656                	mv	a2,s5
  3c:	85ce                	mv	a1,s3
  3e:	0608                	addi	a0,sp,768
  40:	00000097          	auipc	ra,0x0
  44:	000080e7          	jalr	ra # 40 <sparknacl__sign__add+0x40>
  48:	0610                	addi	a2,sp,768
  4a:	050c                	addi	a1,sp,640
  4c:	850a                	mv	a0,sp
  4e:	00000097          	auipc	ra,0x0
  52:	000080e7          	jalr	ra # 4e <sparknacl__sign__add+0x4e>
  56:	011c                	addi	a5,sp,128
  58:	870a                	mv	a4,sp
  5a:	843e                	mv	s0,a5
  5c:	86be                	mv	a3,a5

0000005e <.L2>:
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
  76:	fed714e3          	bne	a4,a3,5e <.L2>
  7a:	864a                	mv	a2,s2
  7c:	85a6                	mv	a1,s1
  7e:	0508                	addi	a0,sp,640
  80:	00000097          	auipc	ra,0x0
  84:	000080e7          	jalr	ra # 80 <.L2+0x22>
  88:	864e                	mv	a2,s3
  8a:	85d6                	mv	a1,s5
  8c:	0608                	addi	a0,sp,768
  8e:	00000097          	auipc	ra,0x0
  92:	000080e7          	jalr	ra # 8e <.L2+0x30>
  96:	0610                	addi	a2,sp,768
  98:	050c                	addi	a1,sp,640
  9a:	850a                	mv	a0,sp
  9c:	00000097          	auipc	ra,0x0
  a0:	000080e7          	jalr	ra # 9c <.L2+0x3e>
  a4:	878a                	mv	a5,sp
  a6:	0218                	addi	a4,sp,256

000000a8 <.L3>:
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
  bc:	fe8796e3          	bne	a5,s0,a8 <.L3>
  c0:	8622                	mv	a2,s0
  c2:	020c                	addi	a1,sp,256
  c4:	850a                	mv	a0,sp
  c6:	00000097          	auipc	ra,0x0
  ca:	000080e7          	jalr	ra # c6 <.L3+0x1e>
  ce:	878a                	mv	a5,sp
  d0:	0418                	addi	a4,sp,512

000000d2 <.L4>:
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
  e6:	fe8796e3          	bne	a5,s0,d2 <.L4>
  ea:	8622                	mv	a2,s0
  ec:	020c                	addi	a1,sp,256
  ee:	850a                	mv	a0,sp
  f0:	00000097          	auipc	ra,0x0
  f4:	000080e7          	jalr	ra # f0 <.L4+0x1e>
  f8:	878a                	mv	a5,sp
  fa:	0518                	addi	a4,sp,640

000000fc <.L5>:
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
 110:	fe8796e3          	bne	a5,s0,fc <.L5>
 114:	18048993          	addi	s3,s1,384
 118:	180a8613          	addi	a2,s5,384
 11c:	85ce                	mv	a1,s3
 11e:	0608                	addi	a0,sp,768
 120:	00000097          	auipc	ra,0x0
 124:	000080e7          	jalr	ra # 120 <.L5+0x24>
 128:	00000637          	lui	a2,0x0
 12c:	00060613          	mv	a2,a2
 130:	060c                	addi	a1,sp,768
 132:	850a                	mv	a0,sp
 134:	00000097          	auipc	ra,0x0
 138:	000080e7          	jalr	ra # 134 <.L5+0x38>
 13c:	878a                	mv	a5,sp
 13e:	0318                	addi	a4,sp,384

00000140 <.L6>:
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
 154:	fe8796e3          	bne	a5,s0,140 <.L6>
 158:	10048a13          	addi	s4,s1,256
 15c:	100a8613          	addi	a2,s5,256
 160:	85d2                	mv	a1,s4
 162:	850a                	mv	a0,sp
 164:	00000097          	auipc	ra,0x0
 168:	000080e7          	jalr	ra # 164 <.L6+0x24>
 16c:	878a                	mv	a5,sp
 16e:	0618                	addi	a4,sp,768

00000170 <.L7>:
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
 184:	fe8796e3          	bne	a5,s0,170 <.L7>
 188:	0610                	addi	a2,sp,768
 18a:	85b2                	mv	a1,a2
 18c:	850a                	mv	a0,sp
 18e:	00000097          	auipc	ra,0x0
 192:	000080e7          	jalr	ra # 18e <.L7+0x1e>
 196:	878a                	mv	a5,sp
 198:	0618                	addi	a4,sp,768

0000019a <.L8>:
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
 1ae:	fe8796e3          	bne	a5,s0,19a <.L8>
 1b2:	0310                	addi	a2,sp,384
 1b4:	060c                	addi	a1,sp,768
 1b6:	850a                	mv	a0,sp
 1b8:	00000097          	auipc	ra,0x0
 1bc:	000080e7          	jalr	ra # 1b8 <.L8+0x1e>
 1c0:	878a                	mv	a5,sp
 1c2:	8722                	mv	a4,s0

000001c4 <.L9>:
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
 1d8:	fe8796e3          	bne	a5,s0,1c4 <.L9>
 1dc:	0310                	addi	a2,sp,384
 1de:	060c                	addi	a1,sp,768
 1e0:	850a                	mv	a0,sp
 1e2:	00000097          	auipc	ra,0x0
 1e6:	000080e7          	jalr	ra # 1e2 <.L9+0x1e>
 1ea:	878a                	mv	a5,sp
 1ec:	0218                	addi	a4,sp,256

000001ee <.L10>:
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
 202:	fe8796e3          	bne	a5,s0,1ee <.L10>
 206:	8622                	mv	a2,s0
 208:	040c                	addi	a1,sp,512
 20a:	850a                	mv	a0,sp
 20c:	00000097          	auipc	ra,0x0
 210:	000080e7          	jalr	ra # 20c <.L10+0x1e>
 214:	878a                	mv	a5,sp

00000216 <.L11>:
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
 22a:	fe8796e3          	bne	a5,s0,216 <.L11>
 22e:	0210                	addi	a2,sp,256
 230:	050c                	addi	a1,sp,640
 232:	850a                	mv	a0,sp
 234:	00000097          	auipc	ra,0x0
 238:	000080e7          	jalr	ra # 234 <.L11+0x1e>
 23c:	878a                	mv	a5,sp
 23e:	864a                	mv	a2,s2

00000240 <.L12>:
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
 254:	fe8796e3          	bne	a5,s0,240 <.L12>
 258:	020c                	addi	a1,sp,256
 25a:	8622                	mv	a2,s0
 25c:	850a                	mv	a0,sp
 25e:	00000097          	auipc	ra,0x0
 262:	000080e7          	jalr	ra # 25e <.L12+0x1e>
 266:	878a                	mv	a5,sp
 268:	85d2                	mv	a1,s4

0000026a <.L13>:
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
 27e:	fe8796e3          	bne	a5,s0,26a <.L13>
 282:	040c                	addi	a1,sp,512
 284:	0510                	addi	a2,sp,640
 286:	850a                	mv	a0,sp
 288:	00000097          	auipc	ra,0x0
 28c:	000080e7          	jalr	ra # 288 <.L13+0x1e>
 290:	878a                	mv	a5,sp
 292:	85ce                	mv	a1,s3

00000294 <.L14>:
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
 2a8:	fe8796e3          	bne	a5,s0,294 <.L14>
 2ac:	39c12083          	lw	ra,924(sp)
 2b0:	39812403          	lw	s0,920(sp)
 2b4:	39412483          	lw	s1,916(sp)
 2b8:	39012903          	lw	s2,912(sp)
 2bc:	38c12983          	lw	s3,908(sp)
 2c0:	38812a03          	lw	s4,904(sp)
 2c4:	38412a83          	lw	s5,900(sp)
 2c8:	3a010113          	addi	sp,sp,928
 2cc:	8082                	ret

Disassembly of section .text.sparknacl__sign__scalarmult:

00000000 <sparknacl__sign__scalarmult>:
   0:	9e010113          	addi	sp,sp,-1568
   4:	60812c23          	sw	s0,1560(sp)
   8:	61412423          	sw	s4,1544(sp)
   c:	842e                	mv	s0,a1
   e:	61512223          	sw	s5,1540(sp)
  12:	8a32                	mv	s4,a2
  14:	8aaa                	mv	s5,a0
  16:	20000613          	li	a2,512
  1a:	4581                	li	a1,0
  1c:	850a                	mv	a0,sp
  1e:	60912a23          	sw	s1,1556(sp)
  22:	60112e23          	sw	ra,1564(sp)
  26:	61212823          	sw	s2,1552(sp)
  2a:	61312623          	sw	s3,1548(sp)
  2e:	61612023          	sw	s6,1536(sp)
  32:	00000097          	auipc	ra,0x0
  36:	000080e7          	jalr	ra # 32 <sparknacl__sign__scalarmult+0x32>
  3a:	4605                	li	a2,1
  3c:	4681                	li	a3,0
  3e:	0404                	addi	s1,sp,512
  40:	87a2                	mv	a5,s0
  42:	c132                	sw	a2,128(sp)
  44:	c336                	sw	a3,132(sp)
  46:	10c12023          	sw	a2,256(sp)
  4a:	10d12223          	sw	a3,260(sp)
  4e:	8726                	mv	a4,s1
  50:	20040813          	addi	a6,s0,512

00000054 <.L31>:
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
  68:	ff0796e3          	bne	a5,a6,54 <.L31>
  6c:	01fa0993          	addi	s3,s4,31

00000070 <.L34>:
  70:	0009c903          	lbu	s2,0(s3)
  74:	4b21                	li	s6,8

00000076 <.L33>:
  76:	1b7d                	addi	s6,s6,-1
  78:	01695433          	srl	s0,s2,s6
  7c:	8805                	andi	s0,s0,1
  7e:	8622                	mv	a2,s0
  80:	85a6                	mv	a1,s1
  82:	850a                	mv	a0,sp
  84:	00000097          	auipc	ra,0x0
  88:	000080e7          	jalr	ra # 84 <.L33+0xe>
  8c:	8622                	mv	a2,s0
  8e:	050c                	addi	a1,sp,640
  90:	0108                	addi	a0,sp,128
  92:	00000097          	auipc	ra,0x0
  96:	000080e7          	jalr	ra # 92 <.L33+0x1c>
  9a:	8622                	mv	a2,s0
  9c:	060c                	addi	a1,sp,768
  9e:	0208                	addi	a0,sp,256
  a0:	00000097          	auipc	ra,0x0
  a4:	000080e7          	jalr	ra # a0 <.L33+0x2a>
  a8:	8622                	mv	a2,s0
  aa:	070c                	addi	a1,sp,896
  ac:	0308                	addi	a0,sp,384
  ae:	00000097          	auipc	ra,0x0
  b2:	000080e7          	jalr	ra # ae <.L33+0x38>
  b6:	858a                	mv	a1,sp
  b8:	8526                	mv	a0,s1
  ba:	00000097          	auipc	ra,0x0
  be:	000080e7          	jalr	ra # ba <.L33+0x44>
  c2:	878a                	mv	a5,sp
  c4:	40010713          	addi	a4,sp,1024

000000c8 <.L32>:
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
  dc:	fe9796e3          	bne	a5,s1,c8 <.L32>
  e0:	40010593          	addi	a1,sp,1024
  e4:	850a                	mv	a0,sp
  e6:	00000097          	auipc	ra,0x0
  ea:	000080e7          	jalr	ra # e6 <.L32+0x1e>
  ee:	8622                	mv	a2,s0
  f0:	85a6                	mv	a1,s1
  f2:	850a                	mv	a0,sp
  f4:	00000097          	auipc	ra,0x0
  f8:	000080e7          	jalr	ra # f4 <.L32+0x2c>
  fc:	8622                	mv	a2,s0
  fe:	050c                	addi	a1,sp,640
 100:	0108                	addi	a0,sp,128
 102:	00000097          	auipc	ra,0x0
 106:	000080e7          	jalr	ra # 102 <.L32+0x3a>
 10a:	8622                	mv	a2,s0
 10c:	060c                	addi	a1,sp,768
 10e:	0208                	addi	a0,sp,256
 110:	00000097          	auipc	ra,0x0
 114:	000080e7          	jalr	ra # 110 <.L32+0x48>
 118:	8622                	mv	a2,s0
 11a:	070c                	addi	a1,sp,896
 11c:	0308                	addi	a0,sp,384
 11e:	00000097          	auipc	ra,0x0
 122:	000080e7          	jalr	ra # 11e <.L32+0x56>
 126:	f40b18e3          	bnez	s6,76 <.L33>
 12a:	fff98793          	addi	a5,s3,-1
 12e:	013a0463          	beq	s4,s3,136 <.L42>
 132:	89be                	mv	s3,a5
 134:	bf35                	j	70 <.L34>

00000136 <.L42>:
 136:	878a                	mv	a5,sp
 138:	8756                	mv	a4,s5

0000013a <.L35>:
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
 14e:	fe9796e3          	bne	a5,s1,13a <.L35>
 152:	61c12083          	lw	ra,1564(sp)
 156:	61812403          	lw	s0,1560(sp)
 15a:	61412483          	lw	s1,1556(sp)
 15e:	61012903          	lw	s2,1552(sp)
 162:	60c12983          	lw	s3,1548(sp)
 166:	60812a03          	lw	s4,1544(sp)
 16a:	60012b03          	lw	s6,1536(sp)
 16e:	8556                	mv	a0,s5
 170:	60412a83          	lw	s5,1540(sp)
 174:	62010113          	addi	sp,sp,1568
 178:	8082                	ret

Disassembly of section .text.sparknacl__sign__pack:

00000000 <sparknacl__sign__pack>:
   0:	dd010113          	addi	sp,sp,-560
   4:	22812423          	sw	s0,552(sp)
   8:	22912223          	sw	s1,548(sp)
   c:	842a                	mv	s0,a0
   e:	84ae                	mv	s1,a1
  10:	850a                	mv	a0,sp
  12:	10058593          	addi	a1,a1,256
  16:	23212023          	sw	s2,544(sp)
  1a:	22112623          	sw	ra,556(sp)
  1e:	00000097          	auipc	ra,0x0
  22:	000080e7          	jalr	ra # 1e <sparknacl__sign__pack+0x1e>
  26:	08010913          	addi	s2,sp,128
  2a:	878a                	mv	a5,sp
  2c:	1318                	addi	a4,sp,416

0000002e <.L44>:
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
  42:	fef916e3          	bne	s2,a5,2e <.L44>
  46:	1310                	addi	a2,sp,416
  48:	85a6                	mv	a1,s1
  4a:	850a                	mv	a0,sp
  4c:	00000097          	auipc	ra,0x0
  50:	000080e7          	jalr	ra # 4c <.L44+0x1e>
  54:	878a                	mv	a5,sp
  56:	1118                	addi	a4,sp,160

00000058 <.L45>:
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
  6c:	fef916e3          	bne	s2,a5,58 <.L45>
  70:	1310                	addi	a2,sp,416
  72:	08048593          	addi	a1,s1,128
  76:	850a                	mv	a0,sp
  78:	00000097          	auipc	ra,0x0
  7c:	000080e7          	jalr	ra # 78 <.L45+0x20>
  80:	878a                	mv	a5,sp
  82:	1218                	addi	a4,sp,288

00000084 <.L46>:
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
  98:	fef916e3          	bne	s2,a5,84 <.L46>
  9c:	120c                	addi	a1,sp,288
  9e:	8522                	mv	a0,s0
  a0:	00000097          	auipc	ra,0x0
  a4:	000080e7          	jalr	ra # a0 <.L46+0x1c>
  a8:	854a                	mv	a0,s2
  aa:	110c                	addi	a1,sp,160
  ac:	01f44483          	lbu	s1,31(s0)
  b0:	00000097          	auipc	ra,0x0
  b4:	000080e7          	jalr	ra # b0 <.L46+0x2c>
  b8:	08014783          	lbu	a5,128(sp)
  bc:	22c12083          	lw	ra,556(sp)
  c0:	8522                	mv	a0,s0
  c2:	8b85                	andi	a5,a5,1
  c4:	079e                	slli	a5,a5,0x7
  c6:	8fa5                	xor	a5,a5,s1
  c8:	00f40fa3          	sb	a5,31(s0)
  cc:	22812403          	lw	s0,552(sp)
  d0:	22412483          	lw	s1,548(sp)
  d4:	22012903          	lw	s2,544(sp)
  d8:	23010113          	addi	sp,sp,560
  dc:	8082                	ret

Disassembly of section .text.sparknacl__sign__modl:

00000000 <sparknacl__sign__modl>:
       0:	d5010113          	addi	sp,sp,-688
       4:	2a112623          	sw	ra,684(sp)
       8:	2a812423          	sw	s0,680(sp)
       c:	2a912223          	sw	s1,676(sp)
      10:	2b212023          	sw	s2,672(sp)
      14:	29312e23          	sw	s3,668(sp)
      18:	29412c23          	sw	s4,664(sp)
      1c:	29512a23          	sw	s5,660(sp)
      20:	29612823          	sw	s6,656(sp)
      24:	29712623          	sw	s7,652(sp)
      28:	29812423          	sw	s8,648(sp)
      2c:	29912223          	sw	s9,644(sp)
      30:	29a12023          	sw	s10,640(sp)
      34:	27b12e23          	sw	s11,636(sp)
      38:	c02a                	sw	a0,0(sp)
      3a:	189c                	addi	a5,sp,112
      3c:	20058813          	addi	a6,a1,512

00000040 <.L52>:
      40:	4188                	lw	a0,0(a1)
      42:	41d0                	lw	a2,4(a1)
      44:	4594                	lw	a3,8(a1)
      46:	45d8                	lw	a4,12(a1)
      48:	c388                	sw	a0,0(a5)
      4a:	c3d0                	sw	a2,4(a5)
      4c:	c794                	sw	a3,8(a5)
      4e:	c7d8                	sw	a4,12(a5)
      50:	05c1                	addi	a1,a1,16
      52:	07c1                	addi	a5,a5,16
      54:	ff0596e3          	bne	a1,a6,40 <.L52>
      58:	26812783          	lw	a5,616(sp)
      5c:	26c12703          	lw	a4,620(sp)
      60:	6685                	lui	a3,0x1
      62:	ed068613          	addi	a2,a3,-304 # ed0 <.L56+0x2b8>
      66:	02c70d33          	mul	s10,a4,a2
      6a:	16812583          	lw	a1,360(sp)
      6e:	00379f13          	slli	t5,a5,0x3
      72:	01d7d393          	srli	t2,a5,0x1d
      76:	00371313          	slli	t1,a4,0x3
      7a:	00ff02b3          	add	t0,t5,a5
      7e:	0063e333          	or	t1,t2,t1
      82:	d3068513          	addi	a0,a3,-720
      86:	01e2bf33          	sltu	t5,t0,t5
      8a:	f5068893          	addi	a7,a3,-176
      8e:	02c784b3          	mul	s1,a5,a2
      92:	01b2d393          	srli	t2,t0,0x1b
      96:	5c000c93          	li	s9,1472
      9a:	1a000b13          	li	s6,416
      9e:	63000a93          	li	s5,1584
      a2:	58000a13          	li	s4,1408
      a6:	d6068993          	addi	s3,a3,-672
      aa:	02c7b633          	mulhu	a2,a5,a2
      ae:	409584b3          	sub	s1,a1,s1
      b2:	08048e13          	addi	t3,s1,128
      b6:	0095b5b3          	sltu	a1,a1,s1
      ba:	009e3fb3          	sltu	t6,t3,s1
      be:	008e5e13          	srli	t3,t3,0x8
      c2:	966a                	add	a2,a2,s10
      c4:	16c12d03          	lw	s10,364(sp)
      c8:	02a70eb3          	mul	t4,a4,a0
      cc:	40cd0d33          	sub	s10,s10,a2
      d0:	40bd0d33          	sub	s10,s10,a1
      d4:	9fea                	add	t6,t6,s10
      d6:	018f9613          	slli	a2,t6,0x18
      da:	01c66e33          	or	t3,a2,t3
      de:	17412603          	lw	a2,372(sp)
      e2:	408fd813          	srai	a6,t6,0x8
      e6:	17012583          	lw	a1,368(sp)
      ea:	9832                	add	a6,a6,a2
      ec:	00e30633          	add	a2,t1,a4
      f0:	02a78433          	mul	s0,a5,a0
      f4:	9f32                	add	t5,t5,a2
      f6:	95f2                	add	a1,a1,t3
      f8:	01c5bbb3          	sltu	s7,a1,t3
      fc:	9bc2                	add	s7,s7,a6
      fe:	0f16                	slli	t5,t5,0x5
     100:	01e3ef33          	or	t5,t2,t5
     104:	f00fff93          	andi	t6,t6,-256
     108:	018e5393          	srli	t2,t3,0x18
     10c:	01f3efb3          	or	t6,t2,t6
     110:	02a7b633          	mulhu	a2,a5,a0
     114:	00529513          	slli	a0,t0,0x5
     118:	40858433          	sub	s0,a1,s0
     11c:	08040313          	addi	t1,s0,128
     120:	0085b5b3          	sltu	a1,a1,s0
     124:	00833833          	sltu	a6,t1,s0
     128:	00835313          	srli	t1,t1,0x8
     12c:	c42a                	sw	a0,8(sp)
     12e:	0e22                	slli	t3,t3,0x8
     130:	41c48e33          	sub	t3,s1,t3
     134:	031702b3          	mul	t0,a4,a7
     138:	9676                	add	a2,a2,t4
     13a:	40cb8bb3          	sub	s7,s7,a2
     13e:	40bb8bb3          	sub	s7,s7,a1
     142:	985e                	add	a6,a6,s7
     144:	17812583          	lw	a1,376(sp)
     148:	17c12e83          	lw	t4,380(sp)
     14c:	01881613          	slli	a2,a6,0x18
     150:	00666333          	or	t1,a2,t1
     154:	959a                	add	a1,a1,t1
     156:	031780b3          	mul	ra,a5,a7
     15a:	40885613          	srai	a2,a6,0x8
     15e:	0065b533          	sltu	a0,a1,t1
     162:	9676                	add	a2,a2,t4
     164:	9532                	add	a0,a0,a2
     166:	01835d93          	srli	s11,t1,0x18
     16a:	f0087813          	andi	a6,a6,-256
     16e:	010de833          	or	a6,s11,a6
     172:	410b8833          	sub	a6,s7,a6
     176:	18c12d83          	lw	s11,396(sp)
     17a:	0317b8b3          	mulhu	a7,a5,a7
     17e:	401580b3          	sub	ra,a1,ra
     182:	08008613          	addi	a2,ra,128
     186:	0015b5b3          	sltu	a1,a1,ra
     18a:	00163eb3          	sltu	t4,a2,ra
     18e:	8221                	srli	a2,a2,0x8
     190:	01c4b4b3          	sltu	s1,s1,t3
     194:	41fd0fb3          	sub	t6,s10,t6
     198:	409f8fb3          	sub	t6,t6,s1
     19c:	0322                	slli	t1,t1,0x8
     19e:	02ec8c33          	mul	s8,s9,a4
     1a2:	9896                	add	a7,a7,t0
     1a4:	41150533          	sub	a0,a0,a7
     1a8:	40b50933          	sub	s2,a0,a1
     1ac:	9eca                	add	t4,t4,s2
     1ae:	18012503          	lw	a0,384(sp)
     1b2:	18412883          	lw	a7,388(sp)
     1b6:	018e9593          	slli	a1,t4,0x18
     1ba:	8e4d                	or	a2,a2,a1
     1bc:	9532                	add	a0,a0,a2
     1be:	02fc83b3          	mul	t2,s9,a5
     1c2:	408ed593          	srai	a1,t4,0x8
     1c6:	00c532b3          	sltu	t0,a0,a2
     1ca:	95c6                	add	a1,a1,a7
     1cc:	92ae                	add	t0,t0,a1
     1ce:	01865593          	srli	a1,a2,0x18
     1d2:	0622                	slli	a2,a2,0x8
     1d4:	40c088b3          	sub	a7,ra,a2
     1d8:	f00efe93          	andi	t4,t4,-256
     1dc:	01d5eeb3          	or	t4,a1,t4
     1e0:	02fcbcb3          	mulhu	s9,s9,a5
     1e4:	407503b3          	sub	t2,a0,t2
     1e8:	00753633          	sltu	a2,a0,t2
     1ec:	08038593          	addi	a1,t2,128
     1f0:	0075b533          	sltu	a0,a1,t2
     1f4:	81a1                	srli	a1,a1,0x8
     1f6:	41d90eb3          	sub	t4,s2,t4
     1fa:	40640333          	sub	t1,s0,t1
     1fe:	0110b0b3          	sltu	ra,ra,a7
     202:	00643433          	sltu	s0,s0,t1
     206:	9ce2                	add	s9,s9,s8
     208:	419282b3          	sub	t0,t0,s9
     20c:	40c28cb3          	sub	s9,t0,a2
     210:	02eb0bb3          	mul	s7,s6,a4
     214:	9566                	add	a0,a0,s9
     216:	18812c03          	lw	s8,392(sp)
     21a:	01851613          	slli	a2,a0,0x18
     21e:	8dd1                	or	a1,a1,a2
     220:	9c2e                	add	s8,s8,a1
     222:	40855613          	srai	a2,a0,0x8
     226:	00bc3d33          	sltu	s10,s8,a1
     22a:	966e                	add	a2,a2,s11
     22c:	9d32                	add	s10,s10,a2
     22e:	02fb02b3          	mul	t0,s6,a5
     232:	0185d613          	srli	a2,a1,0x18
     236:	f0057513          	andi	a0,a0,-256
     23a:	8d51                	or	a0,a0,a2
     23c:	401e80b3          	sub	ra,t4,ra
     240:	40ac8533          	sub	a0,s9,a0
     244:	40880833          	sub	a6,a6,s0
     248:	19412c83          	lw	s9,404(sp)
     24c:	17c12423          	sw	t3,360(sp)
     250:	05a2                	slli	a1,a1,0x8
     252:	02fb3b33          	mulhu	s6,s6,a5
     256:	405c02b3          	sub	t0,s8,t0
     25a:	08028613          	addi	a2,t0,128
     25e:	005c3c33          	sltu	s8,s8,t0
     262:	00563db3          	sltu	s11,a2,t0
     266:	8221                	srli	a2,a2,0x8
     268:	40b385b3          	sub	a1,t2,a1
     26c:	00b3b3b3          	sltu	t2,t2,a1
     270:	17f12623          	sw	t6,364(sp)
     274:	16612823          	sw	t1,368(sp)
     278:	02ea84b3          	mul	s1,s5,a4
     27c:	9b5e                	add	s6,s6,s7
     27e:	416d0d33          	sub	s10,s10,s6
     282:	418d0c33          	sub	s8,s10,s8
     286:	018d8eb3          	add	t4,s11,s8
     28a:	19012b03          	lw	s6,400(sp)
     28e:	018e9413          	slli	s0,t4,0x18
     292:	8e41                	or	a2,a2,s0
     294:	9b32                	add	s6,s6,a2
     296:	408ed413          	srai	s0,t4,0x8
     29a:	02fa8933          	mul	s2,s5,a5
     29e:	00cb3bb3          	sltu	s7,s6,a2
     2a2:	9466                	add	s0,s0,s9
     2a4:	f00efe93          	andi	t4,t4,-256
     2a8:	01865c93          	srli	s9,a2,0x18
     2ac:	9ba2                	add	s7,s7,s0
     2ae:	01dceeb3          	or	t4,s9,t4
     2b2:	0622                	slli	a2,a2,0x8
     2b4:	40c28433          	sub	s0,t0,a2
     2b8:	41dc0633          	sub	a2,s8,t4
     2bc:	02fabab3          	mulhu	s5,s5,a5
     2c0:	412b0933          	sub	s2,s6,s2
     2c4:	08090e93          	addi	t4,s2,128
     2c8:	012b3b33          	sltu	s6,s6,s2
     2cc:	012ebc33          	sltu	s8,t4,s2
     2d0:	40750cb3          	sub	s9,a0,t2
     2d4:	0082b2b3          	sltu	t0,t0,s0
     2d8:	19c12383          	lw	t2,412(sp)
     2dc:	405602b3          	sub	t0,a2,t0
     2e0:	19812503          	lw	a0,408(sp)
     2e4:	01548e33          	add	t3,s1,s5
     2e8:	41cb8e33          	sub	t3,s7,t3
     2ec:	416e0e33          	sub	t3,t3,s6
     2f0:	01cc04b3          	add	s1,s8,t3
     2f4:	01849613          	slli	a2,s1,0x18
     2f8:	008ede93          	srli	t4,t4,0x8
     2fc:	01d66eb3          	or	t4,a2,t4
     300:	4084d613          	srai	a2,s1,0x8
     304:	961e                	add	a2,a2,t2
     306:	43a2                	lw	t2,8(sp)
     308:	9576                	add	a0,a0,t4
     30a:	02ea0bb3          	mul	s7,s4,a4
     30e:	01d53fb3          	sltu	t6,a0,t4
     312:	40750ab3          	sub	s5,a0,t2
     316:	9fb2                	add	t6,t6,a2
     318:	41ef8f33          	sub	t5,t6,t5
     31c:	080a8613          	addi	a2,s5,128
     320:	01553533          	sltu	a0,a0,s5
     324:	40af0533          	sub	a0,t5,a0
     328:	015633b3          	sltu	t2,a2,s5
     32c:	93aa                	add	t2,t2,a0
     32e:	02fa0d33          	mul	s10,s4,a5
     332:	01839f13          	slli	t5,t2,0x18
     336:	1a012b03          	lw	s6,416(sp)
     33a:	8221                	srli	a2,a2,0x8
     33c:	00cf6633          	or	a2,t5,a2
     340:	1a412f03          	lw	t5,420(sp)
     344:	9b32                	add	s6,s6,a2
     346:	4083dc13          	srai	s8,t2,0x8
     34a:	00cb3fb3          	sltu	t6,s6,a2
     34e:	9f62                	add	t5,t5,s8
     350:	02fa3a33          	mulhu	s4,s4,a5
     354:	01ef8c33          	add	s8,t6,t5
     358:	c266                	sw	s9,4(sp)
     35a:	41ab0cb3          	sub	s9,s6,s10
     35e:	080c8f93          	addi	t6,s9,128
     362:	019b3b33          	sltu	s6,s6,s9
     366:	018edd13          	srli	s10,t4,0x18
     36a:	f004f493          	andi	s1,s1,-256
     36e:	0ea2                	slli	t4,t4,0x8
     370:	019fbf33          	sltu	t5,t6,s9
     374:	9a5e                	add	s4,s4,s7
     376:	414c0a33          	sub	s4,s8,s4
     37a:	416a0a33          	sub	s4,s4,s6
     37e:	41d90eb3          	sub	t4,s2,t4
     382:	009d64b3          	or	s1,s10,s1
     386:	03370b33          	mul	s6,a4,s3
     38a:	9f52                	add	t5,t5,s4
     38c:	409e04b3          	sub	s1,t3,s1
     390:	c452                	sw	s4,8(sp)
     392:	01d93933          	sltu	s2,s2,t4
     396:	008fda13          	srli	s4,t6,0x8
     39a:	41248933          	sub	s2,s1,s2
     39e:	4492                	lw	s1,4(sp)
     3a0:	01865d93          	srli	s11,a2,0x18
     3a4:	0622                	slli	a2,a2,0x8
     3a6:	03378fb3          	mul	t6,a5,s3
     3aa:	40ca8633          	sub	a2,s5,a2
     3ae:	17012a23          	sw	a6,372(sp)
     3b2:	17112c23          	sw	a7,376(sp)
     3b6:	16112e23          	sw	ra,380(sp)
     3ba:	18b12023          	sw	a1,384(sp)
     3be:	18912223          	sw	s1,388(sp)
     3c2:	18812423          	sw	s0,392(sp)
     3c6:	18512623          	sw	t0,396(sp)
     3ca:	00cabab3          	sltu	s5,s5,a2
     3ce:	0337b9b3          	mulhu	s3,a5,s3
     3d2:	18c12c23          	sw	a2,408(sp)
     3d6:	1a812603          	lw	a2,424(sp)
     3da:	1ac12303          	lw	t1,428(sp)
     3de:	018f1b93          	slli	s7,t5,0x18
     3e2:	f003f393          	andi	t2,t2,-256
     3e6:	014bea33          	or	s4,s7,s4
     3ea:	007de3b3          	or	t2,s11,t2
     3ee:	9652                	add	a2,a2,s4
     3f0:	407503b3          	sub	t2,a0,t2
     3f4:	408f5893          	srai	a7,t5,0x8
     3f8:	008a1513          	slli	a0,s4,0x8
     3fc:	9c068813          	addi	a6,a3,-1600
     400:	40ac8533          	sub	a0,s9,a0
     404:	014635b3          	sltu	a1,a2,s4
     408:	989a                	add	a7,a7,t1
     40a:	41f60e33          	sub	t3,a2,t6
     40e:	0307b2b3          	mulhu	t0,a5,a6
     412:	95c6                	add	a1,a1,a7
     414:	c0aa                	sw	a0,64(sp)
     416:	1aa12023          	sw	a0,416(sp)
     41a:	99da                	add	s3,s3,s6
     41c:	080e0893          	addi	a7,t3,128
     420:	413589b3          	sub	s3,a1,s3
     424:	01c63633          	sltu	a2,a2,t3
     428:	40c98633          	sub	a2,s3,a2
     42c:	01c8b9b3          	sltu	s3,a7,t3
     430:	03070533          	mul	a0,a4,a6
     434:	99b2                	add	s3,s3,a2
     436:	c632                	sw	a2,12(sp)
     438:	0088d893          	srli	a7,a7,0x8
     43c:	01899613          	slli	a2,s3,0x18
     440:	011668b3          	or	a7,a2,a7
     444:	1b012603          	lw	a2,432(sp)
     448:	19d12823          	sw	t4,400(sp)
     44c:	4089de93          	srai	t4,s3,0x8
     450:	9646                	add	a2,a2,a7
     452:	03078333          	mul	t1,a5,a6
     456:	1b412803          	lw	a6,436(sp)
     45a:	f7068f93          	addi	t6,a3,-144
     45e:	011635b3          	sltu	a1,a2,a7
     462:	9ec2                	add	t4,t4,a6
     464:	9516                	add	a0,a0,t0
     466:	95f6                	add	a1,a1,t4
     468:	8d89                	sub	a1,a1,a0
     46a:	19212a23          	sw	s2,404(sp)
     46e:	41538ab3          	sub	s5,t2,s5
     472:	40660333          	sub	t1,a2,t1
     476:	03f70eb3          	mul	t4,a4,t6
     47a:	08030813          	addi	a6,t1,128
     47e:	00663633          	sltu	a2,a2,t1
     482:	40c58433          	sub	s0,a1,a2
     486:	00683933          	sltu	s2,a6,t1
     48a:	9922                	add	s2,s2,s0
     48c:	01891613          	slli	a2,s2,0x18
     490:	00885813          	srli	a6,a6,0x8
     494:	01066833          	or	a6,a2,a6
     498:	1b812603          	lw	a2,440(sp)
     49c:	03f782b3          	mul	t0,a5,t6
     4a0:	1bc12383          	lw	t2,444(sp)
     4a4:	9642                	add	a2,a2,a6
     4a6:	40895593          	srai	a1,s2,0x8
     4aa:	01063533          	sltu	a0,a2,a6
     4ae:	959e                	add	a1,a1,t2
     4b0:	a2068093          	addi	ra,a3,-1504
     4b4:	95aa                	add	a1,a1,a0
     4b6:	f9068393          	addi	t2,a3,-112
     4ba:	de068c13          	addi	s8,a3,-544
     4be:	03f7bfb3          	mulhu	t6,a5,t6
     4c2:	405602b3          	sub	t0,a2,t0
     4c6:	08028513          	addi	a0,t0,128
     4ca:	00563633          	sltu	a2,a2,t0
     4ce:	005534b3          	sltu	s1,a0,t0
     4d2:	8121                	srli	a0,a0,0x8
     4d4:	19512e23          	sw	s5,412(sp)
     4d8:	00271d13          	slli	s10,a4,0x2
     4dc:	01e7da93          	srli	s5,a5,0x1e
     4e0:	01aaed33          	or	s10,s5,s10
     4e4:	9ff6                	add	t6,t6,t4
     4e6:	02170bb3          	mul	s7,a4,ra
     4ea:	41f585b3          	sub	a1,a1,t6
     4ee:	40c586b3          	sub	a3,a1,a2
     4f2:	94b6                	add	s1,s1,a3
     4f4:	ce36                	sw	a3,28(sp)
     4f6:	01849693          	slli	a3,s1,0x18
     4fa:	8d55                	or	a0,a0,a3
     4fc:	1c012683          	lw	a3,448(sp)
     500:	1c412583          	lw	a1,452(sp)
     504:	4084d613          	srai	a2,s1,0x8
     508:	02178fb3          	mul	t6,a5,ra
     50c:	96aa                	add	a3,a3,a0
     50e:	00a6beb3          	sltu	t4,a3,a0
     512:	962e                	add	a2,a2,a1
     514:	9eb2                	add	t4,t4,a2
     516:	9d3a                	add	s10,s10,a4
     518:	ca22                	sw	s0,20(sp)
     51a:	00279593          	slli	a1,a5,0x2
     51e:	00f58b33          	add	s6,a1,a5
     522:	00bb35b3          	sltu	a1,s6,a1
     526:	0217b0b3          	mulhu	ra,a5,ra
     52a:	41f68fb3          	sub	t6,a3,t6
     52e:	01f6b6b3          	sltu	a3,a3,t6
     532:	080f8613          	addi	a2,t6,128
     536:	01f63433          	sltu	s0,a2,t6
     53a:	8221                	srli	a2,a2,0x8
     53c:	95ea                	add	a1,a1,s10
     53e:	059a                	slli	a1,a1,0x6
     540:	01ab5d13          	srli	s10,s6,0x1a
     544:	00bd65b3          	or	a1,s10,a1
     548:	90de                	add	ra,ra,s7
     54a:	401e80b3          	sub	ra,t4,ra
     54e:	40d08eb3          	sub	t4,ra,a3
     552:	038700b3          	mul	ra,a4,s8
     556:	01d40ab3          	add	s5,s0,t4
     55a:	018a9693          	slli	a3,s5,0x18
     55e:	d276                	sw	t4,36(sp)
     560:	1c812e83          	lw	t4,456(sp)
     564:	8e55                	or	a2,a2,a3
     566:	1cc12683          	lw	a3,460(sp)
     56a:	9eb2                	add	t4,t4,a2
     56c:	408adb93          	srai	s7,s5,0x8
     570:	00ceb433          	sltu	s0,t4,a2
     574:	02770733          	mul	a4,a4,t2
     578:	cc06                	sw	ra,24(sp)
     57a:	96de                	add	a3,a3,s7
     57c:	00d40bb3          	add	s7,s0,a3
     580:	018a5d13          	srli	s10,s4,0x18
     584:	c26a                	sw	s10,4(sp)
     586:	0188dd13          	srli	s10,a7,0x18
     58a:	08a2                	slli	a7,a7,0x8
     58c:	c2c6                	sw	a7,68(sp)
     58e:	c86a                	sw	s10,16(sp)
     590:	03878db3          	mul	s11,a5,s8
     594:	da3a                	sw	a4,52(sp)
     596:	4762                	lw	a4,24(sp)
     598:	00851d13          	slli	s10,a0,0x8
     59c:	0b1a                	slli	s6,s6,0x6
     59e:	f00f7f13          	andi	t5,t5,-256
     5a2:	f009f993          	andi	s3,s3,-256
     5a6:	f0097913          	andi	s2,s2,-256
     5aa:	f004f493          	andi	s1,s1,-256
     5ae:	0387bc33          	mulhu	s8,a5,s8
     5b2:	41be80b3          	sub	ra,t4,s11
     5b6:	08008693          	addi	a3,ra,128
     5ba:	001ebeb3          	sltu	t4,t4,ra
     5be:	0016b433          	sltu	s0,a3,ra
     5c2:	82a1                	srli	a3,a3,0x8
     5c4:	01870a33          	add	s4,a4,s8
     5c8:	414b8bb3          	sub	s7,s7,s4
     5cc:	41db8733          	sub	a4,s7,t4
     5d0:	00e40bb3          	add	s7,s0,a4
     5d4:	027788b3          	mul	a7,a5,t2
     5d8:	1d412c03          	lw	s8,468(sp)
     5dc:	d63a                	sw	a4,44(sp)
     5de:	018b9713          	slli	a4,s7,0x18
     5e2:	8ed9                	or	a3,a3,a4
     5e4:	408bd713          	srai	a4,s7,0x8
     5e8:	9762                	add	a4,a4,s8
     5ea:	01885c13          	srli	s8,a6,0x18
     5ee:	0822                	slli	a6,a6,0x8
     5f0:	c4c2                	sw	a6,72(sp)
     5f2:	0277b7b3          	mulhu	a5,a5,t2
     5f6:	01855813          	srli	a6,a0,0x18
     5fa:	00861393          	slli	t2,a2,0x8
     5fe:	1d012403          	lw	s0,464(sp)
     602:	cc62                	sw	s8,24(sp)
     604:	d042                	sw	a6,32(sp)
     606:	01865c13          	srli	s8,a2,0x18
     60a:	d462                	sw	s8,40(sp)
     60c:	c69e                	sw	t2,76(sp)
     60e:	0186d393          	srli	t2,a3,0x18
     612:	d81e                	sw	t2,48(sp)
     614:	53d2                	lw	t2,52(sp)
     616:	9436                	add	s0,s0,a3
     618:	00d43eb3          	sltu	t4,s0,a3
     61c:	411408b3          	sub	a7,s0,a7
     620:	9eba                	add	t4,t4,a4
     622:	979e                	add	a5,a5,t2
     624:	01143833          	sltu	a6,s0,a7
     628:	08088713          	addi	a4,a7,128
     62c:	40fe87b3          	sub	a5,t4,a5
     630:	01173533          	sltu	a0,a4,a7
     634:	410787b3          	sub	a5,a5,a6
     638:	00f50633          	add	a2,a0,a5
     63c:	da3e                	sw	a5,52(sp)
     63e:	1d812503          	lw	a0,472(sp)
     642:	01861793          	slli	a5,a2,0x18
     646:	8321                	srli	a4,a4,0x8
     648:	8f5d                	or	a4,a4,a5
     64a:	1dc12783          	lw	a5,476(sp)
     64e:	953a                	add	a0,a0,a4
     650:	40865e93          	srai	t4,a2,0x8
     654:	00e53833          	sltu	a6,a0,a4
     658:	97f6                	add	a5,a5,t4
     65a:	983e                	add	a6,a6,a5
     65c:	41b50eb3          	sub	t4,a0,s11
     660:	080e8793          	addi	a5,t4,128
     664:	01d53533          	sltu	a0,a0,t4
     668:	41480833          	sub	a6,a6,s4
     66c:	40a80833          	sub	a6,a6,a0
     670:	01d7b3b3          	sltu	t2,a5,t4
     674:	93c2                	add	t2,t2,a6
     676:	01839513          	slli	a0,t2,0x18
     67a:	83a1                	srli	a5,a5,0x8
     67c:	8fc9                	or	a5,a5,a0
     67e:	1e012503          	lw	a0,480(sp)
     682:	1e412a03          	lw	s4,484(sp)
     686:	dc42                	sw	a6,56(sp)
     688:	953e                	add	a0,a0,a5
     68a:	4083d813          	srai	a6,t2,0x8
     68e:	f00af413          	andi	s0,s5,-256
     692:	9a42                	add	s4,s4,a6
     694:	00f53ab3          	sltu	s5,a0,a5
     698:	41650833          	sub	a6,a0,s6
     69c:	9a56                	add	s4,s4,s5
     69e:	01053533          	sltu	a0,a0,a6
     6a2:	08080a93          	addi	s5,a6,128
     6a6:	40ba0a33          	sub	s4,s4,a1
     6aa:	40aa0b33          	sub	s6,s4,a0
     6ae:	010ab533          	sltu	a0,s5,a6
     6b2:	955a                	add	a0,a0,s6
     6b4:	01851593          	slli	a1,a0,0x18
     6b8:	008add93          	srli	s11,s5,0x8
     6bc:	01b5edb3          	or	s11,a1,s11
     6c0:	f003f393          	andi	t2,t2,-256
     6c4:	0187d593          	srli	a1,a5,0x18
     6c8:	0075e3b3          	or	t2,a1,t2
     6cc:	4586                	lw	a1,64(sp)
     6ce:	4a96                	lw	s5,68(sp)
     6d0:	de5a                	sw	s6,60(sp)
     6d2:	41a28b33          	sub	s6,t0,s10
     6d6:	4d12                	lw	s10,4(sp)
     6d8:	00bcbcb3          	sltu	s9,s9,a1
     6dc:	45a2                	lw	a1,8(sp)
     6de:	415e0c33          	sub	s8,t3,s5
     6e2:	4aa6                	lw	s5,72(sp)
     6e4:	01ed6f33          	or	t5,s10,t5
     6e8:	4d42                	lw	s10,16(sp)
     6ea:	41e585b3          	sub	a1,a1,t5
     6ee:	4f32                	lw	t5,12(sp)
     6f0:	41530ab3          	sub	s5,t1,s5
     6f4:	1b512823          	sw	s5,432(sp)
     6f8:	013d69b3          	or	s3,s10,s3
     6fc:	413f09b3          	sub	s3,t5,s3
     700:	1b012f03          	lw	t5,432(sp)
     704:	4d62                	lw	s10,24(sp)
     706:	06a2                	slli	a3,a3,0x8
     708:	01e33333          	sltu	t1,t1,t5
     70c:	4f52                	lw	t5,20(sp)
     70e:	012d6933          	or	s2,s10,s2
     712:	5d02                	lw	s10,32(sp)
     714:	412f0933          	sub	s2,t5,s2
     718:	4f72                	lw	t5,28(sp)
     71a:	009d64b3          	or	s1,s10,s1
     71e:	5d22                	lw	s10,40(sp)
     720:	409f04b3          	sub	s1,t5,s1
     724:	5f12                	lw	t5,36(sp)
     726:	40d086b3          	sub	a3,ra,a3
     72a:	008d6433          	or	s0,s10,s0
     72e:	5d42                	lw	s10,48(sp)
     730:	408f0433          	sub	s0,t5,s0
     734:	00d0bf33          	sltu	t5,ra,a3
     738:	50b2                	lw	ra,44(sp)
     73a:	f00bfb93          	andi	s7,s7,-256
     73e:	017d6bb3          	or	s7,s10,s7
     742:	417080b3          	sub	ra,ra,s7
     746:	5bd2                	lw	s7,52(sp)
     748:	01875a13          	srli	s4,a4,0x18
     74c:	f0067613          	andi	a2,a2,-256
     750:	00ca6633          	or	a2,s4,a2
     754:	4ab6                	lw	s5,76(sp)
     756:	40cb8633          	sub	a2,s7,a2
     75a:	5be2                	lw	s7,56(sp)
     75c:	07a2                	slli	a5,a5,0x8
     75e:	40fe87b3          	sub	a5,t4,a5
     762:	415f8ab3          	sub	s5,t6,s5
     766:	407b83b3          	sub	t2,s7,t2
     76a:	00febeb3          	sltu	t4,t4,a5
     76e:	419585b3          	sub	a1,a1,s9
     772:	41d38eb3          	sub	t4,t2,t4
     776:	015fbfb3          	sltu	t6,t6,s5
     77a:	1ab12223          	sw	a1,420(sp)
     77e:	41f40fb3          	sub	t6,s0,t6
     782:	0722                	slli	a4,a4,0x8
     784:	5472                	lw	s0,60(sp)
     786:	1b812423          	sw	s8,424(sp)
     78a:	1dd12e23          	sw	t4,476(sp)
     78e:	1e812e83          	lw	t4,488(sp)
     792:	40e88733          	sub	a4,a7,a4
     796:	1cd12423          	sw	a3,456(sp)
     79a:	1ec12683          	lw	a3,492(sp)
     79e:	00e8b8b3          	sltu	a7,a7,a4
     7a2:	f0057d13          	andi	s10,a0,-256
     7a6:	018ddb93          	srli	s7,s11,0x18
     7aa:	008d9a13          	slli	s4,s11,0x8
     7ae:	9eee                	add	t4,t4,s11
     7b0:	41480a33          	sub	s4,a6,s4
     7b4:	41160633          	sub	a2,a2,a7
     7b8:	01abed33          	or	s10,s7,s10
     7bc:	1ce12823          	sw	a4,464(sp)
     7c0:	40855713          	srai	a4,a0,0x8
     7c4:	9736                	add	a4,a4,a3
     7c6:	01483833          	sltu	a6,a6,s4
     7ca:	41a40d33          	sub	s10,s0,s10
     7ce:	1cc12a23          	sw	a2,468(sp)
     7d2:	1cf12c23          	sw	a5,472(sp)
     7d6:	080e8613          	addi	a2,t4,128
     7da:	01beb7b3          	sltu	a5,t4,s11
     7de:	97ba                	add	a5,a5,a4
     7e0:	1df12223          	sw	t6,452(sp)
     7e4:	410d0833          	sub	a6,s10,a6
     7e8:	01d63fb3          	sltu	t6,a2,t4
     7ec:	9fbe                	add	t6,t6,a5
     7ee:	1f012223          	sw	a6,484(sp)
     7f2:	1f012803          	lw	a6,496(sp)
     7f6:	1f412403          	lw	s0,500(sp)
     7fa:	018f9713          	slli	a4,t6,0x18
     7fe:	8221                	srli	a2,a2,0x8
     800:	8e59                	or	a2,a2,a4
     802:	018e3e33          	sltu	t3,t3,s8
     806:	9832                	add	a6,a6,a2
     808:	41c98e33          	sub	t3,s3,t3
     80c:	408fd713          	srai	a4,t6,0x8
     810:	08080693          	addi	a3,a6,128
     814:	1bc12623          	sw	t3,428(sp)
     818:	9722                	add	a4,a4,s0
     81a:	00c83e33          	sltu	t3,a6,a2
     81e:	00ee0433          	add	s0,t3,a4
     822:	0106be33          	sltu	t3,a3,a6
     826:	1f812503          	lw	a0,504(sp)
     82a:	9e22                	add	t3,t3,s0
     82c:	1fc12383          	lw	t2,508(sp)
     830:	018e1713          	slli	a4,t3,0x18
     834:	82a1                	srli	a3,a3,0x8
     836:	8ed9                	or	a3,a3,a4
     838:	9536                	add	a0,a0,a3
     83a:	40690333          	sub	t1,s2,t1
     83e:	408e5593          	srai	a1,t3,0x8
     842:	08050713          	addi	a4,a0,128
     846:	1a612a23          	sw	t1,436(sp)
     84a:	959e                	add	a1,a1,t2
     84c:	00d53333          	sltu	t1,a0,a3
     850:	00b303b3          	add	t2,t1,a1
     854:	00a73333          	sltu	t1,a4,a0
     858:	931e                	add	t1,t1,t2
     85a:	01831593          	slli	a1,t1,0x18
     85e:	8321                	srli	a4,a4,0x8
     860:	8f4d                	or	a4,a4,a1
     862:	20012583          	lw	a1,512(sp)
     866:	41e08f33          	sub	t5,ra,t5
     86a:	20412083          	lw	ra,516(sp)
     86e:	0162b2b3          	sltu	t0,t0,s6
     872:	95ba                	add	a1,a1,a4
     874:	405482b3          	sub	t0,s1,t0
     878:	40835893          	srai	a7,t1,0x8
     87c:	1a512e23          	sw	t0,444(sp)
     880:	1de12623          	sw	t5,460(sp)
     884:	00e5b2b3          	sltu	t0,a1,a4
     888:	08058f13          	addi	t5,a1,128
     88c:	9886                	add	a7,a7,ra
     88e:	9896                	add	a7,a7,t0
     890:	00bf3933          	sltu	s2,t5,a1
     894:	9946                	add	s2,s2,a7
     896:	01891293          	slli	t0,s2,0x18
     89a:	008f5f13          	srli	t5,t5,0x8
     89e:	01e2ef33          	or	t5,t0,t5
     8a2:	1b612c23          	sw	s6,440(sp)
     8a6:	f00fff93          	andi	t6,t6,-256
     8aa:	01865b13          	srli	s6,a2,0x18
     8ae:	0622                	slli	a2,a2,0x8
     8b0:	20812083          	lw	ra,520(sp)
     8b4:	018f5993          	srli	s3,t5,0x18
     8b8:	40ce8633          	sub	a2,t4,a2
     8bc:	01fb6fb3          	or	t6,s6,t6
     8c0:	f0097493          	andi	s1,s2,-256
     8c4:	1d512023          	sw	s5,448(sp)
     8c8:	1f412023          	sw	s4,480(sp)
     8cc:	0186da93          	srli	s5,a3,0x18
     8d0:	01875a13          	srli	s4,a4,0x18
     8d4:	008f1293          	slli	t0,t5,0x8
     8d8:	0099e4b3          	or	s1,s3,s1
     8dc:	f00e7e13          	andi	t3,t3,-256
     8e0:	00ceb9b3          	sltu	s3,t4,a2
     8e4:	06a2                	slli	a3,a3,0x8
     8e6:	41f78eb3          	sub	t4,a5,t6
     8ea:	f0037313          	andi	t1,t1,-256
     8ee:	20c12f83          	lw	t6,524(sp)
     8f2:	0722                	slli	a4,a4,0x8
     8f4:	40e50733          	sub	a4,a0,a4
     8f8:	40d806b3          	sub	a3,a6,a3
     8fc:	405582b3          	sub	t0,a1,t0
     900:	01caee33          	or	t3,s5,t3
     904:	006a6333          	or	t1,s4,t1
     908:	9f06                	add	t5,t5,ra
     90a:	00e53533          	sltu	a0,a0,a4
     90e:	40895913          	srai	s2,s2,0x8
     912:	00d83833          	sltu	a6,a6,a3
     916:	41c40e33          	sub	t3,s0,t3
     91a:	40638333          	sub	t1,t2,t1
     91e:	0055b5b3          	sltu	a1,a1,t0
     922:	409888b3          	sub	a7,a7,s1
     926:	001f37b3          	sltu	a5,t5,ra
     92a:	410e0833          	sub	a6,t3,a6
     92e:	997e                	add	s2,s2,t6
     930:	413e8eb3          	sub	t4,t4,s3
     934:	40a30533          	sub	a0,t1,a0
     938:	40b885b3          	sub	a1,a7,a1
     93c:	97ca                	add	a5,a5,s2
     93e:	1f012a23          	sw	a6,500(sp)
     942:	1ee12c23          	sw	a4,504(sp)
     946:	1ec12423          	sw	a2,488(sp)
     94a:	1fd12623          	sw	t4,492(sp)
     94e:	1ed12823          	sw	a3,496(sp)
     952:	1ea12e23          	sw	a0,508(sp)
     956:	20512023          	sw	t0,512(sp)
     95a:	20b12223          	sw	a1,516(sp)
     95e:	21e12423          	sw	t5,520(sp)
     962:	20f12623          	sw	a5,524(sp)
     966:	4781                	li	a5,0
     968:	4801                	li	a6,0
     96a:	26f12423          	sw	a5,616(sp)
     96e:	07010093          	addi	ra,sp,112
     972:	000007b7          	lui	a5,0x0
     976:	00000bb7          	lui	s7,0x0
     97a:	27012623          	sw	a6,620(sp)
     97e:	14b8                	addi	a4,sp,616
     980:	17010b13          	addi	s6,sp,368
     984:	00078c13          	mv	s8,a5
     988:	080b8b93          	addi	s7,s7,128 # 80 <.L52+0x40>
     98c:	c206                	sw	ra,4(sp)

0000098e <.L54>:
     98e:	84e2                	mv	s1,s8
     990:	883a                	mv	a6,a4
     992:	88e2                	mv	a7,s8
     994:	4681                	li	a3,0
     996:	4581                	li	a1,0

00000998 <.L53>:
     998:	ef882603          	lw	a2,-264(a6)
     99c:	efc82f03          	lw	t5,-260(a6)
     9a0:	ff872e03          	lw	t3,-8(a4)
     9a4:	0008a783          	lw	a5,0(a7)
     9a8:	ffc72303          	lw	t1,-4(a4)
     9ac:	0048a503          	lw	a0,4(a7)
     9b0:	9636                	add	a2,a2,a3
     9b2:	00d636b3          	sltu	a3,a2,a3
     9b6:	95fa                	add	a1,a1,t5
     9b8:	03c50533          	mul	a0,a0,t3
     9bc:	95b6                	add	a1,a1,a3
     9be:	0821                	addi	a6,a6,8
     9c0:	08a1                	addi	a7,a7,8
     9c2:	02f306b3          	mul	a3,t1,a5
     9c6:	03c7beb3          	mulhu	t4,a5,t3
     9ca:	9536                	add	a0,a0,a3
     9cc:	03c787b3          	mul	a5,a5,t3
     9d0:	9576                	add	a0,a0,t4
     9d2:	0512                	slli	a0,a0,0x4
     9d4:	01c7d693          	srli	a3,a5,0x1c
     9d8:	0792                	slli	a5,a5,0x4
     9da:	40f607b3          	sub	a5,a2,a5
     9de:	8d55                	or	a0,a0,a3
     9e0:	8d89                	sub	a1,a1,a0
     9e2:	08078693          	addi	a3,a5,128 # 80 <.L52+0x40>
     9e6:	00f63633          	sltu	a2,a2,a5
     9ea:	40c58633          	sub	a2,a1,a2
     9ee:	00f6b5b3          	sltu	a1,a3,a5
     9f2:	95b2                	add	a1,a1,a2
     9f4:	01859513          	slli	a0,a1,0x18
     9f8:	82a1                	srli	a3,a3,0x8
     9fa:	8ec9                	or	a3,a3,a0
     9fc:	f005f313          	andi	t1,a1,-256
     a00:	0186de13          	srli	t3,a3,0x18
     a04:	00869513          	slli	a0,a3,0x8
     a08:	40a78533          	sub	a0,a5,a0
     a0c:	006e6333          	or	t1,t3,t1
     a10:	00a7b7b3          	sltu	a5,a5,a0
     a14:	40660633          	sub	a2,a2,t1
     a18:	40f607b3          	sub	a5,a2,a5
     a1c:	eea82823          	sw	a0,-272(a6)
     a20:	eef82a23          	sw	a5,-268(a6)
     a24:	85a1                	srai	a1,a1,0x8
     a26:	f71b99e3          	bne	s7,a7,998 <.L53>
     a2a:	f7872f83          	lw	t6,-136(a4)
     a2e:	f7c72783          	lw	a5,-132(a4)
     a32:	f8072f03          	lw	t5,-128(a4)
     a36:	9fb6                	add	t6,t6,a3
     a38:	080f8613          	addi	a2,t6,128
     a3c:	00dfb6b3          	sltu	a3,t6,a3
     a40:	95be                	add	a1,a1,a5
     a42:	00b687b3          	add	a5,a3,a1
     a46:	01f638b3          	sltu	a7,a2,t6
     a4a:	98be                	add	a7,a7,a5
     a4c:	f8472803          	lw	a6,-124(a4)
     a50:	01889693          	slli	a3,a7,0x18
     a54:	00865593          	srli	a1,a2,0x8
     a58:	8dd5                	or	a1,a1,a3
     a5a:	9f2e                	add	t5,t5,a1
     a5c:	4088d693          	srai	a3,a7,0x8
     a60:	080f0613          	addi	a2,t5,128
     a64:	00bf39b3          	sltu	s3,t5,a1
     a68:	96c2                	add	a3,a3,a6
     a6a:	99b6                	add	s3,s3,a3
     a6c:	01e63833          	sltu	a6,a2,t5
     a70:	f8872e83          	lw	t4,-120(a4)
     a74:	984e                	add	a6,a6,s3
     a76:	f8c72303          	lw	t1,-116(a4)
     a7a:	01881693          	slli	a3,a6,0x18
     a7e:	8221                	srli	a2,a2,0x8
     a80:	8e55                	or	a2,a2,a3
     a82:	9eb2                	add	t4,t4,a2
     a84:	40885513          	srai	a0,a6,0x8
     a88:	080e8693          	addi	a3,t4,128
     a8c:	00ceb933          	sltu	s2,t4,a2
     a90:	951a                	add	a0,a0,t1
     a92:	992a                	add	s2,s2,a0
     a94:	01d6b533          	sltu	a0,a3,t4
     a98:	f9072e03          	lw	t3,-112(a4)
     a9c:	954a                	add	a0,a0,s2
     a9e:	f9472083          	lw	ra,-108(a4)
     aa2:	01851313          	slli	t1,a0,0x18
     aa6:	82a1                	srli	a3,a3,0x8
     aa8:	00d366b3          	or	a3,t1,a3
     aac:	9e36                	add	t3,t3,a3
     aae:	40855293          	srai	t0,a0,0x8
     ab2:	00de33b3          	sltu	t2,t3,a3
     ab6:	080e0313          	addi	t1,t3,128
     aba:	9286                	add	t0,t0,ra
     abc:	929e                	add	t0,t0,t2
     abe:	01c333b3          	sltu	t2,t1,t3
     ac2:	9396                	add	t2,t2,t0
     ac4:	0185dd93          	srli	s11,a1,0x18
     ac8:	f008f893          	andi	a7,a7,-256
     acc:	f9872083          	lw	ra,-104(a4)
     ad0:	01839413          	slli	s0,t2,0x18
     ad4:	011de8b3          	or	a7,s11,a7
     ad8:	00835313          	srli	t1,t1,0x8
     adc:	00646333          	or	t1,s0,t1
     ae0:	411787b3          	sub	a5,a5,a7
     ae4:	01865d13          	srli	s10,a2,0x18
     ae8:	f9c72883          	lw	a7,-100(a4)
     aec:	f0087813          	andi	a6,a6,-256
     af0:	0622                	slli	a2,a2,0x8
     af2:	0186dc93          	srli	s9,a3,0x18
     af6:	01835a93          	srli	s5,t1,0x18
     afa:	f003fa13          	andi	s4,t2,-256
     afe:	00831413          	slli	s0,t1,0x8
     b02:	40cf0633          	sub	a2,t5,a2
     b06:	05a2                	slli	a1,a1,0x8
     b08:	f0057513          	andi	a0,a0,-256
     b0c:	06a2                	slli	a3,a3,0x8
     b0e:	010d6833          	or	a6,s10,a6
     b12:	40bf85b3          	sub	a1,t6,a1
     b16:	40de86b3          	sub	a3,t4,a3
     b1a:	408e0433          	sub	s0,t3,s0
     b1e:	9306                	add	t1,t1,ra
     b20:	00ace533          	or	a0,s9,a0
     b24:	4083d393          	srai	t2,t2,0x8
     b28:	014aea33          	or	s4,s5,s4
     b2c:	00cf3f33          	sltu	t5,t5,a2
     b30:	41098833          	sub	a6,s3,a6
     b34:	41e80833          	sub	a6,a6,t5
     b38:	00bfbfb3          	sltu	t6,t6,a1
     b3c:	00debeb3          	sltu	t4,t4,a3
     b40:	40a90533          	sub	a0,s2,a0
     b44:	008e3e33          	sltu	t3,t3,s0
     b48:	414282b3          	sub	t0,t0,s4
     b4c:	001330b3          	sltu	ra,t1,ra
     b50:	93c6                	add	t2,t2,a7
     b52:	41f78fb3          	sub	t6,a5,t6
     b56:	f9072223          	sw	a6,-124(a4)
     b5a:	41d50533          	sub	a0,a0,t4
     b5e:	41c282b3          	sub	t0,t0,t3
     b62:	909e                	add	ra,ra,t2
     b64:	4781                	li	a5,0
     b66:	4801                	li	a6,0
     b68:	f6b72c23          	sw	a1,-136(a4)
     b6c:	f7f72e23          	sw	t6,-132(a4)
     b70:	f8c72023          	sw	a2,-128(a4)
     b74:	f8d72423          	sw	a3,-120(a4)
     b78:	f8a72623          	sw	a0,-116(a4)
     b7c:	f8872823          	sw	s0,-112(a4)
     b80:	f8572a23          	sw	t0,-108(a4)
     b84:	f8672c23          	sw	t1,-104(a4)
     b88:	f8172e23          	sw	ra,-100(a4)
     b8c:	fef72c23          	sw	a5,-8(a4)
     b90:	ff072e23          	sw	a6,-4(a4)
     b94:	1761                	addi	a4,a4,-8
     b96:	df671ce3          	bne	a4,s6,98e <.L54>
     b9a:	4092                	lw	ra,4(sp)
     b9c:	4681                	li	a3,0
     b9e:	8362                	mv	t1,s8
     ba0:	1888                	addi	a0,sp,112
     ba2:	88b6                	mv	a7,a3

00000ba4 <.L55>:
     ba4:	16c12603          	lw	a2,364(sp)
     ba8:	16812583          	lw	a1,360(sp)
     bac:	00032803          	lw	a6,0(t1)
     bb0:	00432e03          	lw	t3,4(t1)
     bb4:	01c61713          	slli	a4,a2,0x1c
     bb8:	8191                	srli	a1,a1,0x4
     bba:	8dd9                	or	a1,a1,a4
     bbc:	8611                	srai	a2,a2,0x4
     bbe:	02be0e33          	mul	t3,t3,a1
     bc2:	4114                	lw	a3,0(a0)
     bc4:	00452e83          	lw	t4,4(a0)
     bc8:	00052223          	sw	zero,4(a0)
     bcc:	0521                	addi	a0,a0,8
     bce:	0321                	addi	t1,t1,8
     bd0:	02c80633          	mul	a2,a6,a2
     bd4:	02b80733          	mul	a4,a6,a1
     bd8:	9672                	add	a2,a2,t3
     bda:	02b835b3          	mulhu	a1,a6,a1
     bde:	40e88733          	sub	a4,a7,a4
     be2:	00e8b833          	sltu	a6,a7,a4
     be6:	96ba                	add	a3,a3,a4
     be8:	00e6b733          	sltu	a4,a3,a4
     bec:	0ff6fe13          	andi	t3,a3,255
     bf0:	0086d893          	srli	a7,a3,0x8
     bf4:	ffc52c23          	sw	t3,-8(a0)
     bf8:	962e                	add	a2,a2,a1
     bfa:	40c78633          	sub	a2,a5,a2
     bfe:	41060633          	sub	a2,a2,a6
     c02:	9676                	add	a2,a2,t4
     c04:	9732                	add	a4,a4,a2
     c06:	01871793          	slli	a5,a4,0x18
     c0a:	0117e8b3          	or	a7,a5,a7
     c0e:	40875793          	srai	a5,a4,0x8
     c12:	f8ab19e3          	bne	s6,a0,ba4 <.L55>
     c16:	86c6                	mv	a3,a7

00000c18 <.L56>:
     c18:	408c                	lw	a1,0(s1)
     c1a:	0044a883          	lw	a7,4(s1)
     c1e:	0000a503          	lw	a0,0(ra)
     c22:	02f58633          	mul	a2,a1,a5
     c26:	0040a703          	lw	a4,4(ra)
     c2a:	00a1                	addi	ra,ra,8
     c2c:	04a1                	addi	s1,s1,8
     c2e:	02d888b3          	mul	a7,a7,a3
     c32:	02d58833          	mul	a6,a1,a3
     c36:	9646                	add	a2,a2,a7
     c38:	02d5b5b3          	mulhu	a1,a1,a3
     c3c:	41050833          	sub	a6,a0,a6
     c40:	01053533          	sltu	a0,a0,a6
     c44:	ff00ac23          	sw	a6,-8(ra)
     c48:	962e                	add	a2,a2,a1
     c4a:	8f11                	sub	a4,a4,a2
     c4c:	8f09                	sub	a4,a4,a0
     c4e:	fee0ae23          	sw	a4,-4(ra)
     c52:	fc1b13e3          	bne	s6,ra,c18 <.L56>
     c56:	5d46                	lw	s10,112(sp)
     c58:	5756                	lw	a4,116(sp)
     c5a:	5be6                	lw	s7,120(sp)
     c5c:	008d5793          	srli	a5,s10,0x8
     c60:	01871693          	slli	a3,a4,0x18
     c64:	8fd5                	or	a5,a5,a3
     c66:	56f6                	lw	a3,124(sp)
     c68:	9bbe                	add	s7,s7,a5
     c6a:	8721                	srai	a4,a4,0x8
     c6c:	00fbb7b3          	sltu	a5,s7,a5
     c70:	9736                	add	a4,a4,a3
     c72:	973e                	add	a4,a4,a5
     c74:	408a                	lw	ra,128(sp)
     c76:	01871693          	slli	a3,a4,0x18
     c7a:	008bd793          	srli	a5,s7,0x8
     c7e:	8fd5                	or	a5,a5,a3
     c80:	469a                	lw	a3,132(sp)
     c82:	90be                	add	ra,ra,a5
     c84:	8721                	srai	a4,a4,0x8
     c86:	00f0b7b3          	sltu	a5,ra,a5
     c8a:	9736                	add	a4,a4,a3
     c8c:	973e                	add	a4,a4,a5
     c8e:	4caa                	lw	s9,136(sp)
     c90:	01871693          	slli	a3,a4,0x18
     c94:	0080d793          	srli	a5,ra,0x8
     c98:	8fd5                	or	a5,a5,a3
     c9a:	46ba                	lw	a3,140(sp)
     c9c:	9cbe                	add	s9,s9,a5
     c9e:	8721                	srai	a4,a4,0x8
     ca0:	00fcb7b3          	sltu	a5,s9,a5
     ca4:	9736                	add	a4,a4,a3
     ca6:	973e                	add	a4,a4,a5
     ca8:	484a                	lw	a6,144(sp)
     caa:	01871693          	slli	a3,a4,0x18
     cae:	008cd793          	srli	a5,s9,0x8
     cb2:	8fd5                	or	a5,a5,a3
     cb4:	46da                	lw	a3,148(sp)
     cb6:	983e                	add	a6,a6,a5
     cb8:	8721                	srai	a4,a4,0x8
     cba:	00f837b3          	sltu	a5,a6,a5
     cbe:	9736                	add	a4,a4,a3
     cc0:	973e                	add	a4,a4,a5
     cc2:	4b6a                	lw	s6,152(sp)
     cc4:	01871693          	slli	a3,a4,0x18
     cc8:	00885793          	srli	a5,a6,0x8
     ccc:	8fd5                	or	a5,a5,a3
     cce:	46fa                	lw	a3,156(sp)
     cd0:	9b3e                	add	s6,s6,a5
     cd2:	8721                	srai	a4,a4,0x8
     cd4:	00fb37b3          	sltu	a5,s6,a5
     cd8:	9736                	add	a4,a4,a3
     cda:	973e                	add	a4,a4,a5
     cdc:	538a                	lw	t2,160(sp)
     cde:	01871693          	slli	a3,a4,0x18
     ce2:	008b5793          	srli	a5,s6,0x8
     ce6:	8fd5                	or	a5,a5,a3
     ce8:	569a                	lw	a3,164(sp)
     cea:	93be                	add	t2,t2,a5
     cec:	8721                	srai	a4,a4,0x8
     cee:	00f3b7b3          	sltu	a5,t2,a5
     cf2:	9736                	add	a4,a4,a3
     cf4:	973e                	add	a4,a4,a5
     cf6:	01871693          	slli	a3,a4,0x18
     cfa:	0083d793          	srli	a5,t2,0x8
     cfe:	8fd5                	or	a5,a5,a3
     d00:	56aa                	lw	a3,168(sp)
     d02:	8721                	srai	a4,a4,0x8
     d04:	554a                	lw	a0,176(sp)
     d06:	00d78633          	add	a2,a5,a3
     d0a:	56ba                	lw	a3,172(sp)
     d0c:	00f637b3          	sltu	a5,a2,a5
     d10:	5a6a                	lw	s4,184(sp)
     d12:	9736                	add	a4,a4,a3
     d14:	973e                	add	a4,a4,a5
     d16:	01871693          	slli	a3,a4,0x18
     d1a:	00865793          	srli	a5,a2,0x8
     d1e:	8fd5                	or	a5,a5,a3
     d20:	56da                	lw	a3,180(sp)
     d22:	953e                	add	a0,a0,a5
     d24:	8721                	srai	a4,a4,0x8
     d26:	00f537b3          	sltu	a5,a0,a5
     d2a:	9736                	add	a4,a4,a3
     d2c:	973e                	add	a4,a4,a5
     d2e:	01871693          	slli	a3,a4,0x18
     d32:	00855793          	srli	a5,a0,0x8
     d36:	8fd5                	or	a5,a5,a3
     d38:	56fa                	lw	a3,188(sp)
     d3a:	9a3e                	add	s4,s4,a5
     d3c:	8721                	srai	a4,a4,0x8
     d3e:	00fa37b3          	sltu	a5,s4,a5
     d42:	9736                	add	a4,a4,a3
     d44:	973e                	add	a4,a4,a5
     d46:	428e                	lw	t0,192(sp)
     d48:	01871693          	slli	a3,a4,0x18
     d4c:	008a5793          	srli	a5,s4,0x8
     d50:	8fd5                	or	a5,a5,a3
     d52:	469e                	lw	a3,196(sp)
     d54:	92be                	add	t0,t0,a5
     d56:	8721                	srai	a4,a4,0x8
     d58:	00f2b7b3          	sltu	a5,t0,a5
     d5c:	9736                	add	a4,a4,a3
     d5e:	973e                	add	a4,a4,a5
     d60:	01871693          	slli	a3,a4,0x18
     d64:	0082d793          	srli	a5,t0,0x8
     d68:	8fd5                	or	a5,a5,a3
     d6a:	46ae                	lw	a3,200(sp)
     d6c:	8721                	srai	a4,a4,0x8
     d6e:	49ee                	lw	s3,216(sp)
     d70:	00d785b3          	add	a1,a5,a3
     d74:	46be                	lw	a3,204(sp)
     d76:	00f5b7b3          	sltu	a5,a1,a5
     d7a:	c42e                	sw	a1,8(sp)
     d7c:	9736                	add	a4,a4,a3
     d7e:	973e                	add	a4,a4,a5
     d80:	01871693          	slli	a3,a4,0x18
     d84:	0085d793          	srli	a5,a1,0x8
     d88:	45ce                	lw	a1,208(sp)
     d8a:	8fd5                	or	a5,a5,a3
     d8c:	46de                	lw	a3,212(sp)
     d8e:	95be                	add	a1,a1,a5
     d90:	8721                	srai	a4,a4,0x8
     d92:	00f5b7b3          	sltu	a5,a1,a5
     d96:	9736                	add	a4,a4,a3
     d98:	973e                	add	a4,a4,a5
     d9a:	01871693          	slli	a3,a4,0x18
     d9e:	0085d793          	srli	a5,a1,0x8
     da2:	8fd5                	or	a5,a5,a3
     da4:	46fe                	lw	a3,220(sp)
     da6:	99be                	add	s3,s3,a5
     da8:	8721                	srai	a4,a4,0x8
     daa:	00f9b7b3          	sltu	a5,s3,a5
     dae:	9736                	add	a4,a4,a3
     db0:	973e                	add	a4,a4,a5
     db2:	5f8e                	lw	t6,224(sp)
     db4:	01871693          	slli	a3,a4,0x18
     db8:	0089d793          	srli	a5,s3,0x8
     dbc:	8fd5                	or	a5,a5,a3
     dbe:	569e                	lw	a3,228(sp)
     dc0:	9fbe                	add	t6,t6,a5
     dc2:	8721                	srai	a4,a4,0x8
     dc4:	00ffb7b3          	sltu	a5,t6,a5
     dc8:	9736                	add	a4,a4,a3
     dca:	973e                	add	a4,a4,a5
     dcc:	01871693          	slli	a3,a4,0x18
     dd0:	008fd793          	srli	a5,t6,0x8
     dd4:	c232                	sw	a2,4(sp)
     dd6:	8fd5                	or	a5,a5,a3
     dd8:	56ae                	lw	a3,232(sp)
     dda:	8721                	srai	a4,a4,0x8
     ddc:	564e                	lw	a2,240(sp)
     dde:	00d78433          	add	s0,a5,a3
     de2:	56be                	lw	a3,236(sp)
     de4:	00f437b3          	sltu	a5,s0,a5
     de8:	596e                	lw	s2,248(sp)
     dea:	9736                	add	a4,a4,a3
     dec:	973e                	add	a4,a4,a5
     dee:	01871693          	slli	a3,a4,0x18
     df2:	00845793          	srli	a5,s0,0x8
     df6:	8fd5                	or	a5,a5,a3
     df8:	56de                	lw	a3,244(sp)
     dfa:	963e                	add	a2,a2,a5
     dfc:	8721                	srai	a4,a4,0x8
     dfe:	00f637b3          	sltu	a5,a2,a5
     e02:	9736                	add	a4,a4,a3
     e04:	973e                	add	a4,a4,a5
     e06:	01871693          	slli	a3,a4,0x18
     e0a:	00865793          	srli	a5,a2,0x8
     e0e:	8fd5                	or	a5,a5,a3
     e10:	56fe                	lw	a3,252(sp)
     e12:	993e                	add	s2,s2,a5
     e14:	8721                	srai	a4,a4,0x8
     e16:	00f937b3          	sltu	a5,s2,a5
     e1a:	9736                	add	a4,a4,a3
     e1c:	973e                	add	a4,a4,a5
     e1e:	10012f03          	lw	t5,256(sp)
     e22:	01871693          	slli	a3,a4,0x18
     e26:	00895793          	srli	a5,s2,0x8
     e2a:	8fd5                	or	a5,a5,a3
     e2c:	10412683          	lw	a3,260(sp)
     e30:	9f3e                	add	t5,t5,a5
     e32:	8721                	srai	a4,a4,0x8
     e34:	00ff37b3          	sltu	a5,t5,a5
     e38:	9736                	add	a4,a4,a3
     e3a:	973e                	add	a4,a4,a5
     e3c:	01871693          	slli	a3,a4,0x18
     e40:	008f5793          	srli	a5,t5,0x8
     e44:	8fd5                	or	a5,a5,a3
     e46:	10812683          	lw	a3,264(sp)
     e4a:	8721                	srai	a4,a4,0x8
     e4c:	11412883          	lw	a7,276(sp)
     e50:	00d784b3          	add	s1,a5,a3
     e54:	10c12683          	lw	a3,268(sp)
     e58:	00f4b7b3          	sltu	a5,s1,a5
     e5c:	c826                	sw	s1,16(sp)
     e5e:	9736                	add	a4,a4,a3
     e60:	973e                	add	a4,a4,a5
     e62:	01871693          	slli	a3,a4,0x18
     e66:	0084d793          	srli	a5,s1,0x8
     e6a:	8fd5                	or	a5,a5,a3
     e6c:	11012683          	lw	a3,272(sp)
     e70:	8721                	srai	a4,a4,0x8
     e72:	9746                	add	a4,a4,a7
     e74:	96be                	add	a3,a3,a5
     e76:	00f6b7b3          	sltu	a5,a3,a5
     e7a:	973e                	add	a4,a4,a5
     e7c:	11812483          	lw	s1,280(sp)
     e80:	01871893          	slli	a7,a4,0x18
     e84:	0086d793          	srli	a5,a3,0x8
     e88:	00f8e7b3          	or	a5,a7,a5
     e8c:	11c12883          	lw	a7,284(sp)
     e90:	94be                	add	s1,s1,a5
     e92:	8721                	srai	a4,a4,0x8
     e94:	9746                	add	a4,a4,a7
     e96:	00f4b7b3          	sltu	a5,s1,a5
     e9a:	97ba                	add	a5,a5,a4
     e9c:	12012e83          	lw	t4,288(sp)
     ea0:	01879893          	slli	a7,a5,0x18
     ea4:	0084d713          	srli	a4,s1,0x8
     ea8:	00e8e733          	or	a4,a7,a4
     eac:	12412883          	lw	a7,292(sp)
     eb0:	9eba                	add	t4,t4,a4
     eb2:	87a1                	srai	a5,a5,0x8
     eb4:	00eeb733          	sltu	a4,t4,a4
     eb8:	97c6                	add	a5,a5,a7
     eba:	97ba                	add	a5,a5,a4
     ebc:	01879713          	slli	a4,a5,0x18
     ec0:	008ed893          	srli	a7,t4,0x8
     ec4:	011768b3          	or	a7,a4,a7
     ec8:	12812703          	lw	a4,296(sp)
     ecc:	87a1                	srai	a5,a5,0x8
     ece:	c622                	sw	s0,12(sp)
     ed0:	00e88333          	add	t1,a7,a4
     ed4:	12c12703          	lw	a4,300(sp)
     ed8:	011338b3          	sltu	a7,t1,a7
     edc:	ca1a                	sw	t1,20(sp)
     ede:	97ba                	add	a5,a5,a4
     ee0:	97c6                	add	a5,a5,a7
     ee2:	01879713          	slli	a4,a5,0x18
     ee6:	00835313          	srli	t1,t1,0x8
     eea:	00676333          	or	t1,a4,t1
     eee:	13012703          	lw	a4,304(sp)
     ef2:	87a1                	srai	a5,a5,0x8
     ef4:	13812403          	lw	s0,312(sp)
     ef8:	971a                	add	a4,a4,t1
     efa:	006738b3          	sltu	a7,a4,t1
     efe:	13412303          	lw	t1,308(sp)
     f02:	14012e03          	lw	t3,320(sp)
     f06:	14812c03          	lw	s8,328(sp)
     f0a:	979a                	add	a5,a5,t1
     f0c:	97c6                	add	a5,a5,a7
     f0e:	01879313          	slli	t1,a5,0x18
     f12:	00875893          	srli	a7,a4,0x8
     f16:	011368b3          	or	a7,t1,a7
     f1a:	13c12303          	lw	t1,316(sp)
     f1e:	9446                	add	s0,s0,a7
     f20:	87a1                	srai	a5,a5,0x8
     f22:	011438b3          	sltu	a7,s0,a7
     f26:	979a                	add	a5,a5,t1
     f28:	97c6                	add	a5,a5,a7
     f2a:	01879313          	slli	t1,a5,0x18
     f2e:	00845893          	srli	a7,s0,0x8
     f32:	011368b3          	or	a7,t1,a7
     f36:	14412303          	lw	t1,324(sp)
     f3a:	9e46                	add	t3,t3,a7
     f3c:	87a1                	srai	a5,a5,0x8
     f3e:	011e38b3          	sltu	a7,t3,a7
     f42:	979a                	add	a5,a5,t1
     f44:	97c6                	add	a5,a5,a7
     f46:	01879313          	slli	t1,a5,0x18
     f4a:	008e5893          	srli	a7,t3,0x8
     f4e:	011368b3          	or	a7,t1,a7
     f52:	14c12303          	lw	t1,332(sp)
     f56:	9c46                	add	s8,s8,a7
     f58:	87a1                	srai	a5,a5,0x8
     f5a:	979a                	add	a5,a5,t1
     f5c:	011c38b3          	sltu	a7,s8,a7
     f60:	98be                	add	a7,a7,a5
     f62:	01889793          	slli	a5,a7,0x18
     f66:	008c5313          	srli	t1,s8,0x8
     f6a:	0067e333          	or	t1,a5,t1
     f6e:	15012783          	lw	a5,336(sp)
     f72:	15412a83          	lw	s5,340(sp)
     f76:	4088d893          	srai	a7,a7,0x8
     f7a:	979a                	add	a5,a5,t1
     f7c:	0067b333          	sltu	t1,a5,t1
     f80:	98d6                	add	a7,a7,s5
     f82:	989a                	add	a7,a7,t1
     f84:	01889a93          	slli	s5,a7,0x18
     f88:	0087d313          	srli	t1,a5,0x8
     f8c:	006ae333          	or	t1,s5,t1
     f90:	15812a83          	lw	s5,344(sp)
     f94:	15c12d83          	lw	s11,348(sp)
     f98:	4088d893          	srai	a7,a7,0x8
     f9c:	9a9a                	add	s5,s5,t1
     f9e:	006ab333          	sltu	t1,s5,t1
     fa2:	98ee                	add	a7,a7,s11
     fa4:	989a                	add	a7,a7,t1
     fa6:	08e2                	slli	a7,a7,0x18
     fa8:	008add93          	srli	s11,s5,0x8
     fac:	01b8edb3          	or	s11,a7,s11
     fb0:	0ffd7893          	andi	a7,s10,255
     fb4:	16012d03          	lw	s10,352(sp)
     fb8:	0ffafa93          	andi	s5,s5,255
     fbc:	0aa2                	slli	s5,s5,0x8
     fbe:	9d6e                	add	s10,s10,s11
     fc0:	0ffbfb93          	andi	s7,s7,255
     fc4:	0ffb7b13          	andi	s6,s6,255
     fc8:	0ffa7a13          	andi	s4,s4,255
     fcc:	0ff9f993          	andi	s3,s3,255
     fd0:	0ff97913          	andi	s2,s2,255
     fd4:	0ff4f493          	andi	s1,s1,255
     fd8:	0ff47413          	andi	s0,s0,255
     fdc:	ff010337          	lui	t1,0xff010
     fe0:	0ff7f793          	andi	a5,a5,255
     fe4:	137d                	addi	t1,t1,-1
     fe6:	0ba2                	slli	s7,s7,0x8
     fe8:	0b22                	slli	s6,s6,0x8
     fea:	0a22                	slli	s4,s4,0x8
     fec:	09a2                	slli	s3,s3,0x8
     fee:	0922                	slli	s2,s2,0x8
     ff0:	04a2                	slli	s1,s1,0x8
     ff2:	0422                	slli	s0,s0,0x8
     ff4:	0157e7b3          	or	a5,a5,s5
     ff8:	0ff87813          	andi	a6,a6,255
     ffc:	0ffd7a93          	andi	s5,s10,255
    1000:	0ff57513          	andi	a0,a0,255
    1004:	0ff5f593          	andi	a1,a1,255
    1008:	0ff67613          	andi	a2,a2,255
    100c:	0ff6f693          	andi	a3,a3,255
    1010:	0ff77713          	andi	a4,a4,255
    1014:	0178e8b3          	or	a7,a7,s7
    1018:	01686833          	or	a6,a6,s6
    101c:	01456533          	or	a0,a0,s4
    1020:	0135e5b3          	or	a1,a1,s3
    1024:	01266633          	or	a2,a2,s2
    1028:	8ec5                	or	a3,a3,s1
    102a:	8f41                	or	a4,a4,s0
    102c:	0ac2                	slli	s5,s5,0x10
    102e:	0067f7b3          	and	a5,a5,t1
    1032:	0066f4b3          	and	s1,a3,t1
    1036:	00667633          	and	a2,a2,t1
    103a:	00677733          	and	a4,a4,t1
    103e:	0068f8b3          	and	a7,a7,t1
    1042:	00687833          	and	a6,a6,t1
    1046:	00657533          	and	a0,a0,t1
    104a:	0065f5b3          	and	a1,a1,t1
    104e:	0157e333          	or	t1,a5,s5
    1052:	16812783          	lw	a5,360(sp)
    1056:	008d5d13          	srli	s10,s10,0x8
    105a:	0ff0f093          	andi	ra,ra,255
    105e:	9d3e                	add	s10,s10,a5
    1060:	4792                	lw	a5,4(sp)
    1062:	0ffe7e13          	andi	t3,t3,255
    1066:	00c2                	slli	ra,ra,0x10
    1068:	0e42                	slli	t3,t3,0x10
    106a:	0018e8b3          	or	a7,a7,ra
    106e:	01879093          	slli	ra,a5,0x18
    1072:	01c767b3          	or	a5,a4,t3
    1076:	4722                	lw	a4,8(sp)
    1078:	01000437          	lui	s0,0x1000
    107c:	147d                	addi	s0,s0,-1
    107e:	00837e33          	and	t3,t1,s0
    1082:	0ff2f293          	andi	t0,t0,255
    1086:	01871313          	slli	t1,a4,0x18
    108a:	4732                	lw	a4,12(sp)
    108c:	02c2                	slli	t0,t0,0x10
    108e:	0088f8b3          	and	a7,a7,s0
    1092:	00556533          	or	a0,a0,t0
    1096:	0ff3f393          	andi	t2,t2,255
    109a:	0ce2                	slli	s9,s9,0x18
    109c:	0198ecb3          	or	s9,a7,s9
    10a0:	03c2                	slli	t2,t2,0x10
    10a2:	008578b3          	and	a7,a0,s0
    10a6:	0fffff93          	andi	t6,t6,255
    10aa:	01871513          	slli	a0,a4,0x18
    10ae:	0fff7f13          	andi	t5,t5,255
    10b2:	4752                	lw	a4,20(sp)
    10b4:	0ffefe93          	andi	t4,t4,255
    10b8:	00786833          	or	a6,a6,t2
    10bc:	0fc2                	slli	t6,t6,0x10
    10be:	0f42                	slli	t5,t5,0x10
    10c0:	0ec2                	slli	t4,t4,0x10
    10c2:	00887833          	and	a6,a6,s0
    10c6:	01f5e5b3          	or	a1,a1,t6
    10ca:	01e666b3          	or	a3,a2,t5
    10ce:	01d4eeb3          	or	t4,s1,t4
    10d2:	44c2                	lw	s1,16(sp)
    10d4:	001860b3          	or	ra,a6,ra
    10d8:	01871613          	slli	a2,a4,0x18
    10dc:	0085f833          	and	a6,a1,s0
    10e0:	008ef733          	and	a4,t4,s0
    10e4:	8ee1                	and	a3,a3,s0
    10e6:	8fe1                	and	a5,a5,s0
    10e8:	4402                	lw	s0,0(sp)
    10ea:	01849593          	slli	a1,s1,0x18
    10ee:	0d62                	slli	s10,s10,0x18
    10f0:	0c62                	slli	s8,s8,0x18
    10f2:	01ae6e33          	or	t3,t3,s10
    10f6:	00a86833          	or	a6,a6,a0
    10fa:	8ecd                	or	a3,a3,a1
    10fc:	8f51                	or	a4,a4,a2
    10fe:	0187e7b3          	or	a5,a5,s8
    1102:	0068e8b3          	or	a7,a7,t1
    1106:	088c                	addi	a1,sp,80
    1108:	8522                	mv	a0,s0
    110a:	02000613          	li	a2,32
    110e:	c8e6                	sw	s9,80(sp)
    1110:	ca86                	sw	ra,84(sp)
    1112:	ccc6                	sw	a7,88(sp)
    1114:	cec2                	sw	a6,92(sp)
    1116:	d0b6                	sw	a3,96(sp)
    1118:	d2ba                	sw	a4,100(sp)
    111a:	d4be                	sw	a5,104(sp)
    111c:	d6f2                	sw	t3,108(sp)
    111e:	00000097          	auipc	ra,0x0
    1122:	000080e7          	jalr	ra # 111e <.L56+0x506>
    1126:	2ac12083          	lw	ra,684(sp)
    112a:	8522                	mv	a0,s0
    112c:	2a812403          	lw	s0,680(sp)
    1130:	2a412483          	lw	s1,676(sp)
    1134:	2a012903          	lw	s2,672(sp)
    1138:	29c12983          	lw	s3,668(sp)
    113c:	29812a03          	lw	s4,664(sp)
    1140:	29412a83          	lw	s5,660(sp)
    1144:	29012b03          	lw	s6,656(sp)
    1148:	28c12b83          	lw	s7,652(sp)
    114c:	28812c03          	lw	s8,648(sp)
    1150:	28412c83          	lw	s9,644(sp)
    1154:	28012d03          	lw	s10,640(sp)
    1158:	27c12d83          	lw	s11,636(sp)
    115c:	2b010113          	addi	sp,sp,688
    1160:	8082                	ret

Disassembly of section .text.sparknacl__sign__signing_pkIP:

00000000 <sparknacl__sign__signing_pkIP>:
   0:	8082                	ret

Disassembly of section .text.sparknacl__sign__signing_skIP:

00000000 <sparknacl__sign__signing_skIP>:
   0:	8082                	ret

Disassembly of section .text.sparknacl__sign__Tgf_vector_4BIP:

00000000 <sparknacl__sign__Tgf_vector_4BIP>:
   0:	8082                	ret

Disassembly of section .text.sparknacl__sign__Tl_tableBIP:

00000000 <sparknacl__sign__Tl_tableBIP>:
   0:	8082                	ret

Disassembly of section .text.sparknacl__sign__serialize:

00000000 <sparknacl__sign__serialize>:
   0:	1141                	addi	sp,sp,-16
   2:	04000613          	li	a2,64
   6:	c422                	sw	s0,8(sp)
   8:	c606                	sw	ra,12(sp)
   a:	842a                	mv	s0,a0
   c:	00000097          	auipc	ra,0x0
  10:	000080e7          	jalr	ra # c <sparknacl__sign__serialize+0xc>
  14:	40b2                	lw	ra,12(sp)
  16:	8522                	mv	a0,s0
  18:	4422                	lw	s0,8(sp)
  1a:	0141                	addi	sp,sp,16
  1c:	8082                	ret

Disassembly of section .text.sparknacl__sign__serialize__2:

00000000 <sparknacl__sign__serialize__2>:
   0:	1141                	addi	sp,sp,-16
   2:	02000613          	li	a2,32
   6:	c422                	sw	s0,8(sp)
   8:	c606                	sw	ra,12(sp)
   a:	842a                	mv	s0,a0
   c:	00000097          	auipc	ra,0x0
  10:	000080e7          	jalr	ra # c <sparknacl__sign__serialize__2+0xc>
  14:	40b2                	lw	ra,12(sp)
  16:	8522                	mv	a0,s0
  18:	4422                	lw	s0,8(sp)
  1a:	0141                	addi	sp,sp,16
  1c:	8082                	ret

Disassembly of section .text.sparknacl__sign__sanitize:

00000000 <sparknacl__sign__sanitize>:
   0:	000005b7          	lui	a1,0x0
   4:	00058593          	mv	a1,a1
   8:	00000317          	auipc	t1,0x0
   c:	00030067          	jr	t1 # 8 <sparknacl__sign__sanitize+0x8>

Disassembly of section .text.sparknacl__sign__sanitize__2:

00000000 <sparknacl__sign__sanitize__2>:
   0:	000005b7          	lui	a1,0x0
   4:	00058593          	mv	a1,a1
   8:	00000317          	auipc	t1,0x0
   c:	00030067          	jr	t1 # 8 <sparknacl__sign__sanitize__2+0x8>

Disassembly of section .text.sparknacl__sign__keypair_from_bytes:

00000000 <sparknacl__sign__keypair_from_bytes>:
   0:	d6010113          	addi	sp,sp,-672
   4:	29312623          	sw	s3,652(sp)
   8:	000009b7          	lui	s3,0x0
   c:	28812c23          	sw	s0,664(sp)
  10:	28912a23          	sw	s1,660(sp)
  14:	29212823          	sw	s2,656(sp)
  18:	842a                	mv	s0,a0
  1a:	892e                	mv	s2,a1
  1c:	84b2                	mv	s1,a2
  1e:	85aa                	mv	a1,a0
  20:	00098613          	mv	a2,s3
  24:	0088                	addi	a0,sp,64
  26:	28112e23          	sw	ra,668(sp)
  2a:	00000097          	auipc	ra,0x0
  2e:	000080e7          	jalr	ra # 2a <sparknacl__sign__keypair_from_bytes+0x2a>
  32:	05f14783          	lbu	a5,95(sp)
  36:	04014703          	lbu	a4,64(sp)
  3a:	000005b7          	lui	a1,0x0
  3e:	03f7f793          	andi	a5,a5,63
  42:	9b61                	andi	a4,a4,-8
  44:	0407e793          	ori	a5,a5,64
  48:	0090                	addi	a2,sp,64
  4a:	0108                	addi	a0,sp,128
  4c:	00058593          	mv	a1,a1
  50:	04e10023          	sb	a4,64(sp)
  54:	04f10fa3          	sb	a5,95(sp)
  58:	00000097          	auipc	ra,0x0
  5c:	000080e7          	jalr	ra # 58 <sparknacl__sign__keypair_from_bytes+0x58>
  60:	010c                	addi	a1,sp,128
  62:	850a                	mv	a0,sp
  64:	00000097          	auipc	ra,0x0
  68:	000080e7          	jalr	ra # 64 <sparknacl__sign__keypair_from_bytes+0x64>
  6c:	858a                	mv	a1,sp
  6e:	02000613          	li	a2,32
  72:	1008                	addi	a0,sp,32
  74:	00000097          	auipc	ra,0x0
  78:	000080e7          	jalr	ra # 74 <sparknacl__sign__keypair_from_bytes+0x74>
  7c:	100c                	addi	a1,sp,32
  7e:	02000613          	li	a2,32
  82:	854a                	mv	a0,s2
  84:	00000097          	auipc	ra,0x0
  88:	000080e7          	jalr	ra # 84 <sparknacl__sign__keypair_from_bytes+0x84>
  8c:	85a2                	mv	a1,s0
  8e:	02000613          	li	a2,32
  92:	0108                	addi	a0,sp,128
  94:	00000097          	auipc	ra,0x0
  98:	000080e7          	jalr	ra # 94 <sparknacl__sign__keypair_from_bytes+0x94>
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
  c8:	000080e7          	jalr	ra # c4 <sparknacl__sign__keypair_from_bytes+0xc4>
  cc:	000005b7          	lui	a1,0x0
  d0:	0088                	addi	a0,sp,64
  d2:	00058593          	mv	a1,a1
  d6:	00000097          	auipc	ra,0x0
  da:	000080e7          	jalr	ra # d6 <sparknacl__sign__keypair_from_bytes+0xd6>
  de:	1008                	addi	a0,sp,32
  e0:	00098593          	mv	a1,s3
  e4:	00000097          	auipc	ra,0x0
  e8:	000080e7          	jalr	ra # e4 <sparknacl__sign__keypair_from_bytes+0xe4>
  ec:	29c12083          	lw	ra,668(sp)
  f0:	29812403          	lw	s0,664(sp)
  f4:	29412483          	lw	s1,660(sp)
  f8:	29012903          	lw	s2,656(sp)
  fc:	28c12983          	lw	s3,652(sp)
 100:	2a010113          	addi	sp,sp,672
 104:	8082                	ret

Disassembly of section .text.sparknacl__sign__keypair:

00000000 <sparknacl__sign__keypair>:
   0:	715d                	addi	sp,sp,-80
   2:	c4a2                	sw	s0,72(sp)
   4:	842a                	mv	s0,a0
   6:	850a                	mv	a0,sp
   8:	c686                	sw	ra,76(sp)
   a:	c2a6                	sw	s1,68(sp)
   c:	84ae                	mv	s1,a1
   e:	00000097          	auipc	ra,0x0
  12:	000080e7          	jalr	ra # e <sparknacl__sign__keypair+0xe>
  16:	858a                	mv	a1,sp
  18:	02000613          	li	a2,32
  1c:	1008                	addi	a0,sp,32
  1e:	00000097          	auipc	ra,0x0
  22:	000080e7          	jalr	ra # 1e <sparknacl__sign__keypair+0x1e>
  26:	8626                	mv	a2,s1
  28:	85a2                	mv	a1,s0
  2a:	1008                	addi	a0,sp,32
  2c:	00000097          	auipc	ra,0x0
  30:	000080e7          	jalr	ra # 2c <sparknacl__sign__keypair+0x2c>
  34:	000005b7          	lui	a1,0x0
  38:	1008                	addi	a0,sp,32
  3a:	00058593          	mv	a1,a1
  3e:	00000097          	auipc	ra,0x0
  42:	000080e7          	jalr	ra # 3e <sparknacl__sign__keypair+0x3e>
  46:	40b6                	lw	ra,76(sp)
  48:	4426                	lw	s0,72(sp)
  4a:	4496                	lw	s1,68(sp)
  4c:	6161                	addi	sp,sp,80
  4e:	8082                	ret

Disassembly of section .text.sparknacl__sign__pk_from_bytes:

00000000 <sparknacl__sign__pk_from_bytes>:
   0:	87ae                	mv	a5,a1
   2:	1141                	addi	sp,sp,-16
   4:	85aa                	mv	a1,a0
   6:	02000613          	li	a2,32
   a:	853e                	mv	a0,a5
   c:	c606                	sw	ra,12(sp)
   e:	00000097          	auipc	ra,0x0
  12:	000080e7          	jalr	ra # e <sparknacl__sign__pk_from_bytes+0xe>
  16:	40b2                	lw	ra,12(sp)
  18:	0141                	addi	sp,sp,16
  1a:	8082                	ret

Disassembly of section .text.sparknacl__sign__sign:

00000000 <sparknacl__sign__sign>:
   0:	a8010113          	addi	sp,sp,-1408
   4:	56812c23          	sw	s0,1400(sp)
   8:	57412423          	sw	s4,1384(sp)
   c:	842a                	mv	s0,a0
   e:	8a2e                	mv	s4,a1
  10:	55712e23          	sw	s7,1372(sp)
  14:	85ba                	mv	a1,a4
  16:	8bb2                	mv	s7,a2
  18:	0e88                	addi	a0,sp,848
  1a:	04000613          	li	a2,64
  1e:	56112e23          	sw	ra,1404(sp)
  22:	56912a23          	sw	s1,1396(sp)
  26:	57212823          	sw	s2,1392(sp)
  2a:	57312623          	sw	s3,1388(sp)
  2e:	57512223          	sw	s5,1380(sp)
  32:	57612023          	sw	s6,1376(sp)
  36:	000a2903          	lw	s2,0(s4)
  3a:	8b3a                	mv	s6,a4
  3c:	000004b7          	lui	s1,0x0
  40:	00000097          	auipc	ra,0x0
  44:	000080e7          	jalr	ra # 40 <sparknacl__sign__sign+0x40>
  48:	0e8c                	addi	a1,sp,848
  4a:	00048613          	mv	a2,s1
  4e:	0a08                	addi	a0,sp,272
  50:	00000097          	auipc	ra,0x0
  54:	000080e7          	jalr	ra # 50 <sparknacl__sign__sign+0x50>
  58:	12f14783          	lbu	a5,303(sp)
  5c:	11014703          	lbu	a4,272(sp)
  60:	000a2a83          	lw	s5,0(s4)
  64:	03f7f793          	andi	a5,a5,63
  68:	000005b7          	lui	a1,0x0
  6c:	0407e793          	ori	a5,a5,64
  70:	9b61                	andi	a4,a4,-8
  72:	02000613          	li	a2,32
  76:	00058593          	mv	a1,a1
  7a:	41540533          	sub	a0,s0,s5
  7e:	12f107a3          	sb	a5,303(sp)
  82:	10e10823          	sb	a4,272(sp)
  86:	00000097          	auipc	ra,0x0
  8a:	000080e7          	jalr	ra # 86 <sparknacl__sign__sign+0x86>
  8e:	13010993          	addi	s3,sp,304
  92:	41540533          	sub	a0,s0,s5
  96:	02000613          	li	a2,32
  9a:	85ce                	mv	a1,s3
  9c:	02050513          	addi	a0,a0,32
  a0:	00000097          	auipc	ra,0x0
  a4:	000080e7          	jalr	ra # a0 <sparknacl__sign__sign+0xa0>
  a8:	004a2603          	lw	a2,4(s4)
  ac:	03f00793          	li	a5,63
  b0:	00f65463          	bge	a2,a5,b8 <.L80>
  b4:	03f00613          	li	a2,63

000000b8 <.L80>:
  b8:	41540533          	sub	a0,s0,s5
  bc:	fc160613          	addi	a2,a2,-63 # ffffffc1 <.L115+0xfffff245>
  c0:	85de                	mv	a1,s7
  c2:	04050513          	addi	a0,a0,64
  c6:	00000097          	auipc	ra,0x0
  ca:	000080e7          	jalr	ra # c6 <.L80+0xe>
  ce:	02000793          	li	a5,32
  d2:	004a2703          	lw	a4,4(s4)
  d6:	41278ab3          	sub	s5,a5,s2
  da:	9aa2                	add	s5,s5,s0
  dc:	85d6                	mv	a1,s5
  de:	1030                	addi	a2,sp,40
  e0:	0a88                	addi	a0,sp,336
  e2:	d43e                	sw	a5,40(sp)
  e4:	d63a                	sw	a4,44(sp)
  e6:	00000097          	auipc	ra,0x0
  ea:	000080e7          	jalr	ra # e6 <.L80+0x2e>
  ee:	20000613          	li	a2,512
  f2:	4581                	li	a1,0
  f4:	0e88                	addi	a0,sp,848
  f6:	00000097          	auipc	ra,0x0
  fa:	000080e7          	jalr	ra # f6 <.L80+0x3e>
  fe:	0a98                	addi	a4,sp,336
 100:	0e9c                	addi	a5,sp,848
 102:	55010613          	addi	a2,sp,1360

00000106 <.L81>:
 106:	00074683          	lbu	a3,0(a4)
 10a:	0007a223          	sw	zero,4(a5)
 10e:	07a1                	addi	a5,a5,8
 110:	fed7ac23          	sw	a3,-8(a5)
 114:	0705                	addi	a4,a4,1
 116:	fec798e3          	bne	a5,a2,106 <.L81>
 11a:	0e8c                	addi	a1,sp,848
 11c:	0988                	addi	a0,sp,208
 11e:	00000097          	auipc	ra,0x0
 122:	000080e7          	jalr	ra # 11e <.L81+0x18>
 126:	47ce                	lw	a5,208(sp)
 128:	000005b7          	lui	a1,0x0
 12c:	0890                	addi	a2,sp,80
 12e:	c8be                	sw	a5,80(sp)
 130:	47de                	lw	a5,212(sp)
 132:	00058593          	mv	a1,a1
 136:	0e88                	addi	a0,sp,848
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
 152:	00000097          	auipc	ra,0x0
 156:	000080e7          	jalr	ra # 152 <.L81+0x4c>
 15a:	0e9c                	addi	a5,sp,848
 15c:	0a98                	addi	a4,sp,336

0000015e <.L82>:
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
 176:	fed794e3          	bne	a5,a3,15e <.L82>
 17a:	0a8c                	addi	a1,sp,336
 17c:	850a                	mv	a0,sp
 17e:	00000097          	auipc	ra,0x0
 182:	000080e7          	jalr	ra # 17e <.L82+0x20>
 186:	02000613          	li	a2,32
 18a:	858a                	mv	a1,sp
 18c:	41240533          	sub	a0,s0,s2
 190:	00000097          	auipc	ra,0x0
 194:	000080e7          	jalr	ra # 190 <.L82+0x32>
 198:	04000613          	li	a2,64
 19c:	85da                	mv	a1,s6
 19e:	0908                	addi	a0,sp,144
 1a0:	00000097          	auipc	ra,0x0
 1a4:	000080e7          	jalr	ra # 1a0 <.L82+0x42>
 1a8:	02000613          	li	a2,32
 1ac:	190c                	addi	a1,sp,176
 1ae:	8556                	mv	a0,s5
 1b0:	00000097          	auipc	ra,0x0
 1b4:	000080e7          	jalr	ra # 1b0 <.L82+0x52>
 1b8:	85a2                	mv	a1,s0
 1ba:	8652                	mv	a2,s4
 1bc:	0988                	addi	a0,sp,208
 1be:	00000097          	auipc	ra,0x0
 1c2:	000080e7          	jalr	ra # 1be <.L82+0x60>
 1c6:	20000613          	li	a2,512
 1ca:	4581                	li	a1,0
 1cc:	0e88                	addi	a0,sp,848
 1ce:	00000097          	auipc	ra,0x0
 1d2:	000080e7          	jalr	ra # 1ce <.L82+0x70>
 1d6:	0998                	addi	a4,sp,208
 1d8:	0e9c                	addi	a5,sp,848
 1da:	55010613          	addi	a2,sp,1360

000001de <.L83>:
 1de:	00074683          	lbu	a3,0(a4)
 1e2:	0007a223          	sw	zero,4(a5)
 1e6:	07a1                	addi	a5,a5,8
 1e8:	fed7ac23          	sw	a3,-8(a5)
 1ec:	0705                	addi	a4,a4,1
 1ee:	fef618e3          	bne	a2,a5,1de <.L83>
 1f2:	0e8c                	addi	a1,sp,848
 1f4:	1888                	addi	a0,sp,112
 1f6:	00000097          	auipc	ra,0x0
 1fa:	000080e7          	jalr	ra # 1f6 <.L83+0x18>
 1fe:	57c6                	lw	a5,112(sp)
 200:	20000613          	li	a2,512
 204:	4581                	li	a1,0
 206:	d83e                	sw	a5,48(sp)
 208:	57d6                	lw	a5,116(sp)
 20a:	0e88                	addi	a0,sp,848
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
 226:	00000097          	auipc	ra,0x0
 22a:	000080e7          	jalr	ra # 226 <.L83+0x48>
 22e:	35010313          	addi	t1,sp,848
 232:	0898                	addi	a4,sp,80
 234:	45010613          	addi	a2,sp,1104
 238:	879a                	mv	a5,t1

0000023a <.L84>:
 23a:	00074683          	lbu	a3,0(a4)
 23e:	0007a223          	sw	zero,4(a5)
 242:	07a1                	addi	a5,a5,8
 244:	fed7ac23          	sw	a3,-8(a5)
 248:	0705                	addi	a4,a4,1
 24a:	fec798e3          	bne	a5,a2,23a <.L84>
 24e:	03010893          	addi	a7,sp,48
 252:	587d                	li	a6,-1
 254:	4e7d                	li	t3,31

00000256 <.L86>:
 256:	0008c503          	lbu	a0,0(a7)
 25a:	0805                	addi	a6,a6,1
 25c:	0a10                	addi	a2,sp,272
 25e:	869a                	mv	a3,t1

00000260 <.L85>:
 260:	00064703          	lbu	a4,0(a2)
 264:	429c                	lw	a5,0(a3)
 266:	42cc                	lw	a1,4(a3)
 268:	02a70733          	mul	a4,a4,a0
 26c:	06a1                	addi	a3,a3,8
 26e:	0605                	addi	a2,a2,1
 270:	973e                	add	a4,a4,a5
 272:	00f737b3          	sltu	a5,a4,a5
 276:	97ae                	add	a5,a5,a1
 278:	fee6ac23          	sw	a4,-8(a3)
 27c:	fef6ae23          	sw	a5,-4(a3)
 280:	fec990e3          	bne	s3,a2,260 <.L85>
 284:	0885                	addi	a7,a7,1
 286:	0321                	addi	t1,t1,8
 288:	fdc817e3          	bne	a6,t3,256 <.L86>
 28c:	0e8c                	addi	a1,sp,848
 28e:	0988                	addi	a0,sp,208
 290:	00000097          	auipc	ra,0x0
 294:	000080e7          	jalr	ra # 290 <.L85+0x30>
 298:	41240533          	sub	a0,s0,s2
 29c:	02000613          	li	a2,32
 2a0:	098c                	addi	a1,sp,208
 2a2:	02050513          	addi	a0,a0,32
 2a6:	00000097          	auipc	ra,0x0
 2aa:	000080e7          	jalr	ra # 2a6 <.L85+0x46>
 2ae:	000005b7          	lui	a1,0x0
 2b2:	0a08                	addi	a0,sp,272
 2b4:	00058593          	mv	a1,a1
 2b8:	00000097          	auipc	ra,0x0
 2bc:	000080e7          	jalr	ra # 2b8 <.L85+0x58>
 2c0:	1808                	addi	a0,sp,48
 2c2:	00048593          	mv	a1,s1
 2c6:	00000097          	auipc	ra,0x0
 2ca:	000080e7          	jalr	ra # 2c6 <.L85+0x66>
 2ce:	0888                	addi	a0,sp,80
 2d0:	00048593          	mv	a1,s1
 2d4:	00000097          	auipc	ra,0x0
 2d8:	000080e7          	jalr	ra # 2d4 <.L85+0x74>
 2dc:	000005b7          	lui	a1,0x0
 2e0:	0e88                	addi	a0,sp,848
 2e2:	00058593          	mv	a1,a1
 2e6:	00000097          	auipc	ra,0x0
 2ea:	000080e7          	jalr	ra # 2e6 <.L85+0x86>
 2ee:	57c12083          	lw	ra,1404(sp)
 2f2:	57812403          	lw	s0,1400(sp)
 2f6:	57412483          	lw	s1,1396(sp)
 2fa:	57012903          	lw	s2,1392(sp)
 2fe:	56c12983          	lw	s3,1388(sp)
 302:	56812a03          	lw	s4,1384(sp)
 306:	56412a83          	lw	s5,1380(sp)
 30a:	56012b03          	lw	s6,1376(sp)
 30e:	55c12b83          	lw	s7,1372(sp)
 312:	58010113          	addi	sp,sp,1408
 316:	8082                	ret

Disassembly of section .text.sparknacl__sign__open:

00000000 <sparknacl__sign__open>:
   0:	81010113          	addi	sp,sp,-2032
   4:	7d312e23          	sw	s3,2012(sp)
   8:	0006a983          	lw	s3,0(a3)
   c:	0046a883          	lw	a7,4(a3)
  10:	7e812423          	sw	s0,2024(sp)
  14:	03e98813          	addi	a6,s3,62 # 3e <sparknacl__sign__open+0x3e>
  18:	7e912223          	sw	s1,2020(sp)
  1c:	7f212023          	sw	s2,2016(sp)
  20:	7d612823          	sw	s6,2000(sp)
  24:	7d912223          	sw	s9,1988(sp)
  28:	7e112623          	sw	ra,2028(sp)
  2c:	7d412c23          	sw	s4,2008(sp)
  30:	7d512a23          	sw	s5,2004(sp)
  34:	7d712623          	sw	s7,1996(sp)
  38:	7d812423          	sw	s8,1992(sp)
  3c:	7da12023          	sw	s10,1984(sp)
  40:	7bb12e23          	sw	s11,1980(sp)
  44:	41f9d313          	srai	t1,s3,0x1f
  48:	96010113          	addi	sp,sp,-1696
  4c:	013837b3          	sltu	a5,a6,s3
  50:	8436                	mv	s0,a3
  52:	979a                	add	a5,a5,t1
  54:	41f8d693          	srai	a3,a7,0x1f
  58:	c432                	sw	a2,8(sp)
  5a:	0005ac83          	lw	s9,0(a1) # 0 <sparknacl__sign__open>
  5e:	84ae                	mv	s1,a1
  60:	892a                	mv	s2,a0
  62:	8b3a                	mv	s6,a4
  64:	06d7c763          	blt	a5,a3,d2 <.L95>
  68:	06f68363          	beq	a3,a5,ce <.L149>

0000006c <.L132>:
  6c:	40dc                	lw	a5,4(s1)
  6e:	4601                	li	a2,0
  70:	0597db63          	bge	a5,s9,c6 <.L150>

00000074 <.L97>:
  74:	4581                	li	a1,0
  76:	854a                	mv	a0,s2
  78:	00000097          	auipc	ra,0x0
  7c:	000080e7          	jalr	ra # 78 <.L97+0x4>
  80:	547d                	li	s0,-1
  82:	4781                	li	a5,0

00000084 <.L98>:
  84:	6a010113          	addi	sp,sp,1696
  88:	7ec12083          	lw	ra,2028(sp)
  8c:	85a2                	mv	a1,s0
  8e:	7e412483          	lw	s1,2020(sp)
  92:	7e812403          	lw	s0,2024(sp)
  96:	7e012903          	lw	s2,2016(sp)
  9a:	7dc12983          	lw	s3,2012(sp)
  9e:	7d812a03          	lw	s4,2008(sp)
  a2:	7d412a83          	lw	s5,2004(sp)
  a6:	7d012b03          	lw	s6,2000(sp)
  aa:	7cc12b83          	lw	s7,1996(sp)
  ae:	7c812c03          	lw	s8,1992(sp)
  b2:	7c412c83          	lw	s9,1988(sp)
  b6:	7c012d03          	lw	s10,1984(sp)
  ba:	7bc12d83          	lw	s11,1980(sp)
  be:	853e                	mv	a0,a5
  c0:	7f010113          	addi	sp,sp,2032
  c4:	8082                	ret

000000c6 <.L150>:
  c6:	0785                	addi	a5,a5,1
  c8:	41978633          	sub	a2,a5,s9
  cc:	b765                	j	74 <.L97>

000000ce <.L149>:
  ce:	f9187fe3          	bgeu	a6,a7,6c <.L132>

000000d2 <.L95>:
  d2:	02000613          	li	a2,32
  d6:	85da                	mv	a1,s6
  d8:	1d08                	addi	a0,sp,688
  da:	6a05                	lui	s4,0x1
  dc:	00000097          	auipc	ra,0x0
  e0:	000080e7          	jalr	ra # dc <.L95+0xa>
  e4:	7bfd                	lui	s7,0xfffff
  e6:	0818                	addi	a4,sp,16
  e8:	e40a0793          	addi	a5,s4,-448 # e40 <.L115+0xc4>
  ec:	97ba                	add	a5,a5,a4
  ee:	460b8593          	addi	a1,s7,1120 # fffff460 <.L115+0xffffe6e4>
  f2:	95be                	add	a1,a1,a5
  f4:	0d88                	addi	a0,sp,720
  f6:	00000097          	auipc	ra,0x0
  fa:	000080e7          	jalr	ra # f6 <.L95+0x24>
  fe:	0818                	addi	a4,sp,16
 100:	e40a0793          	addi	a5,s4,-448
 104:	97ba                	add	a5,a5,a4
 106:	480b8613          	addi	a2,s7,1152
 10a:	963e                	add	a2,a2,a5
 10c:	85b2                	mv	a1,a2
 10e:	0e88                	addi	a0,sp,848
 110:	00000097          	auipc	ra,0x0
 114:	000080e7          	jalr	ra # 110 <.L95+0x3e>
 118:	0818                	addi	a4,sp,16
 11a:	e40a0793          	addi	a5,s4,-448
 11e:	97ba                	add	a5,a5,a4
 120:	500b8a93          	addi	s5,s7,1280
 124:	9abe                	add	s5,s5,a5
 126:	00000c37          	lui	s8,0x0
 12a:	000c0613          	mv	a2,s8
 12e:	85d6                	mv	a1,s5
 130:	0f88                	addi	a0,sp,976
 132:	00000097          	auipc	ra,0x0
 136:	000080e7          	jalr	ra # 132 <.L95+0x60>
 13a:	00000637          	lui	a2,0x0
 13e:	85d6                	mv	a1,s5
 140:	7d010513          	addi	a0,sp,2000
 144:	00060613          	mv	a2,a2
 148:	00000097          	auipc	ra,0x0
 14c:	000080e7          	jalr	ra # 148 <.L95+0x76>
 150:	000c0593          	mv	a1,s8
 154:	7d010613          	addi	a2,sp,2000
 158:	45010513          	addi	a0,sp,1104
 15c:	00000097          	auipc	ra,0x0
 160:	000080e7          	jalr	ra # 15c <.L95+0x8a>
 164:	0818                	addi	a4,sp,16
 166:	e40a0793          	addi	a5,s4,-448
 16a:	97ba                	add	a5,a5,a4
 16c:	600b8d13          	addi	s10,s7,1536
 170:	9d3e                	add	s10,s10,a5
 172:	866a                	mv	a2,s10
 174:	85ea                	mv	a1,s10
 176:	4d010513          	addi	a0,sp,1232
 17a:	00000097          	auipc	ra,0x0
 17e:	000080e7          	jalr	ra # 17a <.L95+0xa8>
 182:	0818                	addi	a4,sp,16
 184:	e40a0793          	addi	a5,s4,-448
 188:	97ba                	add	a5,a5,a4
 18a:	680b8a93          	addi	s5,s7,1664
 18e:	9abe                	add	s5,s5,a5
 190:	8656                	mv	a2,s5
 192:	85d6                	mv	a1,s5
 194:	55010513          	addi	a0,sp,1360
 198:	00000097          	auipc	ra,0x0
 19c:	000080e7          	jalr	ra # 198 <.L95+0xc6>
 1a0:	0818                	addi	a4,sp,16
 1a2:	e40a0793          	addi	a5,s4,-448
 1a6:	97ba                	add	a5,a5,a4
 1a8:	75010c13          	addi	s8,sp,1872
 1ac:	580b8593          	addi	a1,s7,1408
 1b0:	95be                	add	a1,a1,a5
 1b2:	8562                	mv	a0,s8
 1b4:	866a                	mv	a2,s10
 1b6:	00000097          	auipc	ra,0x0
 1ba:	000080e7          	jalr	ra # 1b6 <.L95+0xe4>
 1be:	8656                	mv	a2,s5
 1c0:	85e2                	mv	a1,s8
 1c2:	5d010513          	addi	a0,sp,1488
 1c6:	00000097          	auipc	ra,0x0
 1ca:	000080e7          	jalr	ra # 1c6 <.L95+0xf4>
 1ce:	0818                	addi	a4,sp,16
 1d0:	e40a0793          	addi	a5,s4,-448
 1d4:	97ba                	add	a5,a5,a4
 1d6:	780b8613          	addi	a2,s7,1920
 1da:	963e                	add	a2,a2,a5
 1dc:	e40a0793          	addi	a5,s4,-448
 1e0:	97ba                	add	a5,a5,a4
 1e2:	6d010a93          	addi	s5,sp,1744
 1e6:	700b8593          	addi	a1,s7,1792
 1ea:	95be                	add	a1,a1,a5
 1ec:	8556                	mv	a0,s5
 1ee:	00000097          	auipc	ra,0x0
 1f2:	000080e7          	jalr	ra # 1ee <.L95+0x11c>
 1f6:	840a0713          	addi	a4,s4,-1984
 1fa:	0814                	addi	a3,sp,16
 1fc:	87d6                	mv	a5,s5
 1fe:	9736                	add	a4,a4,a3

00000200 <.L99>:
 200:	4388                	lw	a0,0(a5)
 202:	43cc                	lw	a1,4(a5)
 204:	4790                	lw	a2,8(a5)
 206:	47d4                	lw	a3,12(a5)
 208:	c308                	sw	a0,0(a4)
 20a:	c34c                	sw	a1,4(a4)
 20c:	c710                	sw	a2,8(a4)
 20e:	c754                	sw	a3,12(a4)
 210:	07c1                	addi	a5,a5,16
 212:	0741                	addi	a4,a4,16
 214:	fefc16e3          	bne	s8,a5,200 <.L99>
 218:	6785                	lui	a5,0x1
 21a:	0814                	addi	a3,sp,16
 21c:	e4078713          	addi	a4,a5,-448 # e40 <.L115+0xc4>
 220:	7bfd                	lui	s7,0xfffff
 222:	9736                	add	a4,a4,a3
 224:	3e0b8d13          	addi	s10,s7,992 # fffff3e0 <.L115+0xffffe664>
 228:	9bba                	add	s7,s7,a4
 22a:	ac078713          	addi	a4,a5,-1344
 22e:	e4078793          	addi	a5,a5,-448
 232:	97b6                	add	a5,a5,a3
 234:	9d3e                	add	s10,s10,a5
 236:	460b8793          	addi	a5,s7,1120
 23a:	0fb00a13          	li	s4,251
 23e:	00e68db3          	add	s11,a3,a4
 242:	c63e                	sw	a5,12(sp)

00000244 <.L100>:
 244:	6705                	lui	a4,0x1
 246:	081c                	addi	a5,sp,16
 248:	84070613          	addi	a2,a4,-1984 # 840 <.L114+0x26>
 24c:	963e                	add	a2,a2,a5
 24e:	c4070513          	addi	a0,a4,-960
 252:	953e                	add	a0,a0,a5
 254:	85b2                	mv	a1,a2
 256:	00000097          	auipc	ra,0x0
 25a:	000080e7          	jalr	ra # 256 <.L100+0x12>
 25e:	6705                	lui	a4,0x1
 260:	c4070793          	addi	a5,a4,-960 # c40 <.L152+0x2a>
 264:	0814                	addi	a3,sp,16
 266:	a4070713          	addi	a4,a4,-1472
 26a:	1a7d                	addi	s4,s4,-1
 26c:	97b6                	add	a5,a5,a3
 26e:	9736                	add	a4,a4,a3

00000270 <.L101>:
 270:	47d0                	lw	a2,12(a5)
 272:	0007a803          	lw	a6,0(a5)
 276:	43c8                	lw	a0,4(a5)
 278:	478c                	lw	a1,8(a5)
 27a:	6685                	lui	a3,0x1
 27c:	c750                	sw	a2,12(a4)
 27e:	cc068693          	addi	a3,a3,-832 # cc0 <.L126+0x2c>
 282:	0810                	addi	a2,sp,16
 284:	01072023          	sw	a6,0(a4)
 288:	c348                	sw	a0,4(a4)
 28a:	c70c                	sw	a1,8(a4)
 28c:	07c1                	addi	a5,a5,16
 28e:	96b2                	add	a3,a3,a2
 290:	0741                	addi	a4,a4,16
 292:	fcd79fe3          	bne	a5,a3,270 <.L101>
 296:	4785                	li	a5,1
 298:	52fa0063          	beq	s4,a5,7b8 <.L151>
 29c:	6785                	lui	a5,0x1
 29e:	a4078593          	addi	a1,a5,-1472 # a40 <.L121+0x32>
 2a2:	081c                	addi	a5,sp,16
 2a4:	95be                	add	a1,a1,a5
 2a6:	8656                	mv	a2,s5
 2a8:	856a                	mv	a0,s10
 2aa:	00000097          	auipc	ra,0x0
 2ae:	000080e7          	jalr	ra # 2aa <.L101+0x3a>
 2b2:	6705                	lui	a4,0x1
 2b4:	84070713          	addi	a4,a4,-1984 # 840 <.L114+0x26>
 2b8:	0814                	addi	a3,sp,16
 2ba:	3e0b8793          	addi	a5,s7,992
 2be:	9736                	add	a4,a4,a3

000002c0 <.L105>:
 2c0:	0007a803          	lw	a6,0(a5)
 2c4:	43c8                	lw	a0,4(a5)
 2c6:	478c                	lw	a1,8(a5)
 2c8:	47d0                	lw	a2,12(a5)
 2ca:	46b2                	lw	a3,12(sp)
 2cc:	01072023          	sw	a6,0(a4)
 2d0:	c348                	sw	a0,4(a4)
 2d2:	c70c                	sw	a1,8(a4)
 2d4:	c750                	sw	a2,12(a4)
 2d6:	07c1                	addi	a5,a5,16
 2d8:	0741                	addi	a4,a4,16
 2da:	fed793e3          	bne	a5,a3,2c0 <.L105>
 2de:	f60a13e3          	bnez	s4,244 <.L100>
 2e2:	6685                	lui	a3,0x1
 2e4:	84068793          	addi	a5,a3,-1984 # 840 <.L114+0x26>
 2e8:	0818                	addi	a4,sp,16
 2ea:	0810                	addi	a2,sp,16
 2ec:	97ba                	add	a5,a5,a4
 2ee:	c4068713          	addi	a4,a3,-960
 2f2:	8c068693          	addi	a3,a3,-1856
 2f6:	9732                	add	a4,a4,a2
 2f8:	00d60d33          	add	s10,a2,a3

000002fc <.L106>:
 2fc:	4388                	lw	a0,0(a5)
 2fe:	43cc                	lw	a1,4(a5)
 300:	4790                	lw	a2,8(a5)
 302:	47d4                	lw	a3,12(a5)
 304:	c308                	sw	a0,0(a4)
 306:	c34c                	sw	a1,4(a4)
 308:	c710                	sw	a2,8(a4)
 30a:	c754                	sw	a3,12(a4)
 30c:	07c1                	addi	a5,a5,16
 30e:	0741                	addi	a4,a4,16
 310:	fefd16e3          	bne	s10,a5,2fc <.L106>
 314:	6a05                	lui	s4,0x1
 316:	0818                	addi	a4,sp,16
 318:	7bfd                	lui	s7,0xfffff
 31a:	e40a0793          	addi	a5,s4,-448 # e40 <.L115+0xc4>
 31e:	97ba                	add	a5,a5,a4
 320:	780b8613          	addi	a2,s7,1920 # fffff780 <.L115+0xffffea04>
 324:	c40a0593          	addi	a1,s4,-960
 328:	95ba                	add	a1,a1,a4
 32a:	963e                	add	a2,a2,a5
 32c:	65010513          	addi	a0,sp,1616
 330:	00000097          	auipc	ra,0x0
 334:	000080e7          	jalr	ra # 330 <.L106+0x34>
 338:	65010613          	addi	a2,sp,1616
 33c:	081c                	addi	a5,sp,16
 33e:	a40a0513          	addi	a0,s4,-1472
 342:	85b2                	mv	a1,a2
 344:	953e                	add	a0,a0,a5
 346:	00000097          	auipc	ra,0x0
 34a:	000080e7          	jalr	ra # 346 <.L106+0x4a>
 34e:	0818                	addi	a4,sp,16
 350:	e40a0793          	addi	a5,s4,-448
 354:	97ba                	add	a5,a5,a4
 356:	600b8613          	addi	a2,s7,1536
 35a:	963e                	add	a2,a2,a5
 35c:	e40a0793          	addi	a5,s4,-448
 360:	97ba                	add	a5,a5,a4
 362:	3e0b8513          	addi	a0,s7,992
 366:	a40a0593          	addi	a1,s4,-1472
 36a:	95ba                	add	a1,a1,a4
 36c:	953e                	add	a0,a0,a5
 36e:	00000097          	auipc	ra,0x0
 372:	000080e7          	jalr	ra # 36e <.L106+0x72>
 376:	0818                	addi	a4,sp,16
 378:	e40a0793          	addi	a5,s4,-448
 37c:	97ba                	add	a5,a5,a4
 37e:	97de                	add	a5,a5,s7
 380:	c63e                	sw	a5,12(sp)
 382:	46b2                	lw	a3,12(sp)
 384:	3e078793          	addi	a5,a5,992
 388:	8756                	mv	a4,s5
 38a:	46068693          	addi	a3,a3,1120

0000038e <.L107>:
 38e:	0007a803          	lw	a6,0(a5)
 392:	43c8                	lw	a0,4(a5)
 394:	478c                	lw	a1,8(a5)
 396:	47d0                	lw	a2,12(a5)
 398:	01072023          	sw	a6,0(a4)
 39c:	c348                	sw	a0,4(a4)
 39e:	c70c                	sw	a1,8(a4)
 3a0:	c750                	sw	a2,12(a4)
 3a2:	07c1                	addi	a5,a5,16
 3a4:	0741                	addi	a4,a4,16
 3a6:	fed794e3          	bne	a5,a3,38e <.L107>
 3aa:	6a05                	lui	s4,0x1
 3ac:	081c                	addi	a5,sp,16
 3ae:	a40a0513          	addi	a0,s4,-1472 # a40 <.L121+0x32>
 3b2:	953e                	add	a0,a0,a5
 3b4:	85d6                	mv	a1,s5
 3b6:	00000097          	auipc	ra,0x0
 3ba:	000080e7          	jalr	ra # 3b6 <.L107+0x28>
 3be:	77fd                	lui	a5,0xfffff
 3c0:	0818                	addi	a4,sp,16
 3c2:	58078593          	addi	a1,a5,1408 # fffff580 <.L115+0xffffe804>
 3c6:	e40a0793          	addi	a5,s4,-448
 3ca:	97ba                	add	a5,a5,a4
 3cc:	840a0513          	addi	a0,s4,-1984
 3d0:	95be                	add	a1,a1,a5
 3d2:	953a                	add	a0,a0,a4
 3d4:	00000097          	auipc	ra,0x0
 3d8:	000080e7          	jalr	ra # 3d4 <.L107+0x46>
 3dc:	081c                	addi	a5,sp,16
 3de:	00000bb7          	lui	s7,0x0
 3e2:	840a0613          	addi	a2,s4,-1984
 3e6:	a40a0513          	addi	a0,s4,-1472
 3ea:	963e                	add	a2,a2,a5
 3ec:	000b8693          	mv	a3,s7
 3f0:	953e                	add	a0,a0,a5
 3f2:	000b8593          	mv	a1,s7
 3f6:	00000097          	auipc	ra,0x0
 3fa:	000080e7          	jalr	ra # 3f6 <.L107+0x68>
 3fe:	00050ce3          	beqz	a0,c16 <.L152>

00000402 <.L108>:
 402:	6a05                	lui	s4,0x1
 404:	65010613          	addi	a2,sp,1616
 408:	081c                	addi	a5,sp,16
 40a:	a40a0513          	addi	a0,s4,-1472 # a40 <.L121+0x32>
 40e:	85b2                	mv	a1,a2
 410:	953e                	add	a0,a0,a5
 412:	00000097          	auipc	ra,0x0
 416:	000080e7          	jalr	ra # 412 <.L108+0x10>
 41a:	77fd                	lui	a5,0xfffff
 41c:	0818                	addi	a4,sp,16
 41e:	3e078513          	addi	a0,a5,992 # fffff3e0 <.L115+0xffffe664>
 422:	60078613          	addi	a2,a5,1536
 426:	e40a0793          	addi	a5,s4,-448
 42a:	97ba                	add	a5,a5,a4
 42c:	963e                	add	a2,a2,a5
 42e:	e40a0793          	addi	a5,s4,-448
 432:	97ba                	add	a5,a5,a4
 434:	a40a0593          	addi	a1,s4,-1472
 438:	95ba                	add	a1,a1,a4
 43a:	953e                	add	a0,a0,a5
 43c:	00000097          	auipc	ra,0x0
 440:	000080e7          	jalr	ra # 43c <.L108+0x3a>
 444:	081c                	addi	a5,sp,16
 446:	e40a0713          	addi	a4,s4,-448
 44a:	973e                	add	a4,a4,a5
 44c:	77fd                	lui	a5,0xfffff
 44e:	97ba                	add	a5,a5,a4
 450:	c63e                	sw	a5,12(sp)
 452:	46b2                	lw	a3,12(sp)
 454:	3e078793          	addi	a5,a5,992 # fffff3e0 <.L115+0xffffe664>
 458:	8756                	mv	a4,s5
 45a:	46068693          	addi	a3,a3,1120

0000045e <.L110>:
 45e:	0007a803          	lw	a6,0(a5)
 462:	43c8                	lw	a0,4(a5)
 464:	478c                	lw	a1,8(a5)
 466:	47d0                	lw	a2,12(a5)
 468:	01072023          	sw	a6,0(a4)
 46c:	c348                	sw	a0,4(a4)
 46e:	c70c                	sw	a1,8(a4)
 470:	c750                	sw	a2,12(a4)
 472:	07c1                	addi	a5,a5,16
 474:	0741                	addi	a4,a4,16
 476:	fed794e3          	bne	a5,a3,45e <.L110>
 47a:	6a05                	lui	s4,0x1
 47c:	081c                	addi	a5,sp,16
 47e:	a40a0513          	addi	a0,s4,-1472 # a40 <.L121+0x32>
 482:	953e                	add	a0,a0,a5
 484:	85d6                	mv	a1,s5
 486:	00000097          	auipc	ra,0x0
 48a:	000080e7          	jalr	ra # 486 <.L110+0x28>
 48e:	77fd                	lui	a5,0xfffff
 490:	0818                	addi	a4,sp,16
 492:	58078593          	addi	a1,a5,1408 # fffff580 <.L115+0xffffe804>
 496:	e40a0793          	addi	a5,s4,-448
 49a:	97ba                	add	a5,a5,a4
 49c:	840a0513          	addi	a0,s4,-1984
 4a0:	95be                	add	a1,a1,a5
 4a2:	953a                	add	a0,a0,a4
 4a4:	00000097          	auipc	ra,0x0
 4a8:	000080e7          	jalr	ra # 4a4 <.L110+0x46>
 4ac:	081c                	addi	a5,sp,16
 4ae:	840a0613          	addi	a2,s4,-1984
 4b2:	a40a0513          	addi	a0,s4,-1472
 4b6:	963e                	add	a2,a2,a5
 4b8:	953e                	add	a0,a0,a5
 4ba:	000b8693          	mv	a3,s7
 4be:	000b8593          	mv	a1,s7
 4c2:	00000097          	auipc	ra,0x0
 4c6:	000080e7          	jalr	ra # 4c2 <.L110+0x64>
 4ca:	87aa                	mv	a5,a0
 4cc:	32051063          	bnez	a0,7ec <.L111>
 4d0:	0814                	addi	a3,sp,16
 4d2:	a40a0713          	addi	a4,s4,-1472
 4d6:	4601                	li	a2,0
 4d8:	9736                	add	a4,a4,a3
 4da:	4681                	li	a3,0
 4dc:	0808                	addi	a0,sp,16
 4de:	c310                	sw	a2,0(a4)
 4e0:	c354                	sw	a3,4(a4)
 4e2:	a48a0713          	addi	a4,s4,-1464
 4e6:	972a                	add	a4,a4,a0
 4e8:	c310                	sw	a2,0(a4)
 4ea:	c354                	sw	a3,4(a4)
 4ec:	a50a0713          	addi	a4,s4,-1456
 4f0:	972a                	add	a4,a4,a0
 4f2:	c310                	sw	a2,0(a4)
 4f4:	c354                	sw	a3,4(a4)
 4f6:	a58a0713          	addi	a4,s4,-1448
 4fa:	972a                	add	a4,a4,a0
 4fc:	c310                	sw	a2,0(a4)
 4fe:	c354                	sw	a3,4(a4)
 500:	a60a0713          	addi	a4,s4,-1440
 504:	972a                	add	a4,a4,a0
 506:	c310                	sw	a2,0(a4)
 508:	c354                	sw	a3,4(a4)
 50a:	a68a0713          	addi	a4,s4,-1432
 50e:	972a                	add	a4,a4,a0
 510:	c310                	sw	a2,0(a4)
 512:	c354                	sw	a3,4(a4)
 514:	a70a0713          	addi	a4,s4,-1424
 518:	972a                	add	a4,a4,a0
 51a:	c310                	sw	a2,0(a4)
 51c:	c354                	sw	a3,4(a4)
 51e:	a78a0713          	addi	a4,s4,-1416
 522:	972a                	add	a4,a4,a0
 524:	c310                	sw	a2,0(a4)
 526:	c354                	sw	a3,4(a4)
 528:	a80a0713          	addi	a4,s4,-1408
 52c:	972a                	add	a4,a4,a0
 52e:	c310                	sw	a2,0(a4)
 530:	c354                	sw	a3,4(a4)
 532:	a88a0713          	addi	a4,s4,-1400
 536:	972a                	add	a4,a4,a0
 538:	c310                	sw	a2,0(a4)
 53a:	c354                	sw	a3,4(a4)
 53c:	a90a0713          	addi	a4,s4,-1392
 540:	972a                	add	a4,a4,a0
 542:	c310                	sw	a2,0(a4)
 544:	c354                	sw	a3,4(a4)
 546:	a98a0713          	addi	a4,s4,-1384
 54a:	972a                	add	a4,a4,a0
 54c:	c310                	sw	a2,0(a4)
 54e:	c354                	sw	a3,4(a4)
 550:	aa0a0713          	addi	a4,s4,-1376
 554:	972a                	add	a4,a4,a0
 556:	c310                	sw	a2,0(a4)
 558:	c354                	sw	a3,4(a4)
 55a:	aa8a0713          	addi	a4,s4,-1368
 55e:	972a                	add	a4,a4,a0
 560:	c310                	sw	a2,0(a4)
 562:	c354                	sw	a3,4(a4)
 564:	ab0a0713          	addi	a4,s4,-1360
 568:	972a                	add	a4,a4,a0
 56a:	c310                	sw	a2,0(a4)
 56c:	c354                	sw	a3,4(a4)
 56e:	ab8a0713          	addi	a4,s4,-1352
 572:	972a                	add	a4,a4,a0
 574:	c310                	sw	a2,0(a4)
 576:	c354                	sw	a3,4(a4)
 578:	ac0a0713          	addi	a4,s4,-1344
 57c:	972a                	add	a4,a4,a0
 57e:	c310                	sw	a2,0(a4)
 580:	c354                	sw	a3,4(a4)
 582:	ac8a0713          	addi	a4,s4,-1336
 586:	972a                	add	a4,a4,a0
 588:	c310                	sw	a2,0(a4)
 58a:	c354                	sw	a3,4(a4)
 58c:	ad0a0713          	addi	a4,s4,-1328
 590:	972a                	add	a4,a4,a0
 592:	c310                	sw	a2,0(a4)
 594:	c354                	sw	a3,4(a4)
 596:	ad8a0713          	addi	a4,s4,-1320
 59a:	972a                	add	a4,a4,a0
 59c:	c310                	sw	a2,0(a4)
 59e:	c354                	sw	a3,4(a4)
 5a0:	ae0a0713          	addi	a4,s4,-1312
 5a4:	972a                	add	a4,a4,a0
 5a6:	c310                	sw	a2,0(a4)
 5a8:	c354                	sw	a3,4(a4)
 5aa:	ae8a0713          	addi	a4,s4,-1304
 5ae:	972a                	add	a4,a4,a0
 5b0:	c310                	sw	a2,0(a4)
 5b2:	c354                	sw	a3,4(a4)
 5b4:	af0a0713          	addi	a4,s4,-1296
 5b8:	972a                	add	a4,a4,a0
 5ba:	c310                	sw	a2,0(a4)
 5bc:	c354                	sw	a3,4(a4)
 5be:	af8a0713          	addi	a4,s4,-1288
 5c2:	972a                	add	a4,a4,a0
 5c4:	c310                	sw	a2,0(a4)
 5c6:	c354                	sw	a3,4(a4)
 5c8:	b00a0713          	addi	a4,s4,-1280
 5cc:	972a                	add	a4,a4,a0
 5ce:	c310                	sw	a2,0(a4)
 5d0:	c354                	sw	a3,4(a4)
 5d2:	b08a0713          	addi	a4,s4,-1272
 5d6:	972a                	add	a4,a4,a0
 5d8:	c310                	sw	a2,0(a4)
 5da:	c354                	sw	a3,4(a4)
 5dc:	b10a0713          	addi	a4,s4,-1264
 5e0:	972a                	add	a4,a4,a0
 5e2:	c310                	sw	a2,0(a4)
 5e4:	c354                	sw	a3,4(a4)
 5e6:	b18a0713          	addi	a4,s4,-1256
 5ea:	972a                	add	a4,a4,a0
 5ec:	c310                	sw	a2,0(a4)
 5ee:	c354                	sw	a3,4(a4)
 5f0:	b20a0713          	addi	a4,s4,-1248
 5f4:	972a                	add	a4,a4,a0
 5f6:	c310                	sw	a2,0(a4)
 5f8:	c354                	sw	a3,4(a4)
 5fa:	b28a0713          	addi	a4,s4,-1240
 5fe:	972a                	add	a4,a4,a0
 600:	c310                	sw	a2,0(a4)
 602:	c354                	sw	a3,4(a4)
 604:	b30a0713          	addi	a4,s4,-1232
 608:	972a                	add	a4,a4,a0
 60a:	c310                	sw	a2,0(a4)
 60c:	c354                	sw	a3,4(a4)
 60e:	b38a0713          	addi	a4,s4,-1224
 612:	972a                	add	a4,a4,a0
 614:	c310                	sw	a2,0(a4)
 616:	c354                	sw	a3,4(a4)
 618:	b40a0713          	addi	a4,s4,-1216
 61c:	0800                	addi	s0,sp,16
 61e:	972a                	add	a4,a4,a0
 620:	b48a0513          	addi	a0,s4,-1208
 624:	c310                	sw	a2,0(a4)
 626:	9522                	add	a0,a0,s0
 628:	c354                	sw	a3,4(a4)
 62a:	c110                	sw	a2,0(a0)
 62c:	c154                	sw	a3,4(a0)
 62e:	b50a0513          	addi	a0,s4,-1200
 632:	9522                	add	a0,a0,s0
 634:	c110                	sw	a2,0(a0)
 636:	c154                	sw	a3,4(a0)
 638:	b58a0513          	addi	a0,s4,-1192
 63c:	9522                	add	a0,a0,s0
 63e:	c110                	sw	a2,0(a0)
 640:	c154                	sw	a3,4(a0)
 642:	b60a0513          	addi	a0,s4,-1184
 646:	9522                	add	a0,a0,s0
 648:	c110                	sw	a2,0(a0)
 64a:	c154                	sw	a3,4(a0)
 64c:	b68a0513          	addi	a0,s4,-1176
 650:	9522                	add	a0,a0,s0
 652:	c110                	sw	a2,0(a0)
 654:	c154                	sw	a3,4(a0)
 656:	b70a0513          	addi	a0,s4,-1168
 65a:	9522                	add	a0,a0,s0
 65c:	c110                	sw	a2,0(a0)
 65e:	c154                	sw	a3,4(a0)
 660:	b78a0513          	addi	a0,s4,-1160
 664:	9522                	add	a0,a0,s0
 666:	c110                	sw	a2,0(a0)
 668:	c154                	sw	a3,4(a0)
 66a:	b80a0513          	addi	a0,s4,-1152
 66e:	9522                	add	a0,a0,s0
 670:	c110                	sw	a2,0(a0)
 672:	c154                	sw	a3,4(a0)
 674:	b88a0513          	addi	a0,s4,-1144
 678:	9522                	add	a0,a0,s0
 67a:	c110                	sw	a2,0(a0)
 67c:	c154                	sw	a3,4(a0)
 67e:	b90a0513          	addi	a0,s4,-1136
 682:	9522                	add	a0,a0,s0
 684:	c110                	sw	a2,0(a0)
 686:	c154                	sw	a3,4(a0)
 688:	b98a0513          	addi	a0,s4,-1128
 68c:	9522                	add	a0,a0,s0
 68e:	c110                	sw	a2,0(a0)
 690:	c154                	sw	a3,4(a0)
 692:	ba0a0513          	addi	a0,s4,-1120
 696:	9522                	add	a0,a0,s0
 698:	c110                	sw	a2,0(a0)
 69a:	c154                	sw	a3,4(a0)
 69c:	ba8a0513          	addi	a0,s4,-1112
 6a0:	9522                	add	a0,a0,s0
 6a2:	c110                	sw	a2,0(a0)
 6a4:	c154                	sw	a3,4(a0)
 6a6:	bb0a0513          	addi	a0,s4,-1104
 6aa:	9522                	add	a0,a0,s0
 6ac:	c110                	sw	a2,0(a0)
 6ae:	c154                	sw	a3,4(a0)
 6b0:	bb8a0513          	addi	a0,s4,-1096
 6b4:	9522                	add	a0,a0,s0
 6b6:	c110                	sw	a2,0(a0)
 6b8:	c154                	sw	a3,4(a0)
 6ba:	bc0a0513          	addi	a0,s4,-1088
 6be:	9522                	add	a0,a0,s0
 6c0:	c110                	sw	a2,0(a0)
 6c2:	40d8                	lw	a4,4(s1)
 6c4:	c154                	sw	a3,4(a0)
 6c6:	bc8a0513          	addi	a0,s4,-1080
 6ca:	9522                	add	a0,a0,s0
 6cc:	c110                	sw	a2,0(a0)
 6ce:	c154                	sw	a3,4(a0)
 6d0:	bd0a0513          	addi	a0,s4,-1072
 6d4:	9522                	add	a0,a0,s0
 6d6:	c110                	sw	a2,0(a0)
 6d8:	c154                	sw	a3,4(a0)
 6da:	bd8a0513          	addi	a0,s4,-1064
 6de:	9522                	add	a0,a0,s0
 6e0:	c110                	sw	a2,0(a0)
 6e2:	c154                	sw	a3,4(a0)
 6e4:	be0a0513          	addi	a0,s4,-1056
 6e8:	9522                	add	a0,a0,s0
 6ea:	c110                	sw	a2,0(a0)
 6ec:	c154                	sw	a3,4(a0)
 6ee:	be8a0513          	addi	a0,s4,-1048
 6f2:	9522                	add	a0,a0,s0
 6f4:	c110                	sw	a2,0(a0)
 6f6:	c154                	sw	a3,4(a0)
 6f8:	bf0a0513          	addi	a0,s4,-1040
 6fc:	9522                	add	a0,a0,s0
 6fe:	c110                	sw	a2,0(a0)
 700:	c154                	sw	a3,4(a0)
 702:	bf8a0513          	addi	a0,s4,-1032
 706:	9522                	add	a0,a0,s0
 708:	c110                	sw	a2,0(a0)
 70a:	c154                	sw	a3,4(a0)
 70c:	c00a0513          	addi	a0,s4,-1024
 710:	9522                	add	a0,a0,s0
 712:	c110                	sw	a2,0(a0)
 714:	c154                	sw	a3,4(a0)
 716:	c08a0513          	addi	a0,s4,-1016
 71a:	9522                	add	a0,a0,s0
 71c:	c110                	sw	a2,0(a0)
 71e:	c154                	sw	a3,4(a0)
 720:	c10a0513          	addi	a0,s4,-1008
 724:	9522                	add	a0,a0,s0
 726:	c110                	sw	a2,0(a0)
 728:	c154                	sw	a3,4(a0)
 72a:	c18a0513          	addi	a0,s4,-1000
 72e:	9522                	add	a0,a0,s0
 730:	c110                	sw	a2,0(a0)
 732:	c154                	sw	a3,4(a0)
 734:	c20a0513          	addi	a0,s4,-992
 738:	9522                	add	a0,a0,s0
 73a:	c110                	sw	a2,0(a0)
 73c:	c154                	sw	a3,4(a0)
 73e:	c28a0513          	addi	a0,s4,-984
 742:	9522                	add	a0,a0,s0
 744:	c110                	sw	a2,0(a0)
 746:	c154                	sw	a3,4(a0)
 748:	c38a0593          	addi	a1,s4,-968
 74c:	c30a0513          	addi	a0,s4,-976
 750:	9522                	add	a0,a0,s0
 752:	95a2                	add	a1,a1,s0
 754:	c110                	sw	a2,0(a0)
 756:	c190                	sw	a2,0(a1)
 758:	4090                	lw	a2,0(s1)
 75a:	c154                	sw	a3,4(a0)
 75c:	c1d4                	sw	a3,4(a1)
 75e:	08c75363          	bge	a4,a2,7e4 <.L112>
 762:	4601                	li	a2,0

00000764 <.L113>:
 764:	4581                	li	a1,0
 766:	854a                	mv	a0,s2
 768:	6405                	lui	s0,0x1
 76a:	c43e                	sw	a5,8(sp)
 76c:	00000097          	auipc	ra,0x0
 770:	000080e7          	jalr	ra # 76c <.L113+0x8>
 774:	081c                	addi	a5,sp,16
 776:	a4040513          	addi	a0,s0,-1472 # a40 <.L121+0x32>
 77a:	953e                	add	a0,a0,a5
 77c:	00000097          	auipc	ra,0x0
 780:	000080e7          	jalr	ra # 77c <.L113+0x18>
 784:	856e                	mv	a0,s11
 786:	00000097          	auipc	ra,0x0
 78a:	000080e7          	jalr	ra # 786 <.L113+0x22>
 78e:	b4040793          	addi	a5,s0,-1216
 792:	0818                	addi	a4,sp,16
 794:	00f70533          	add	a0,a4,a5
 798:	00000097          	auipc	ra,0x0
 79c:	000080e7          	jalr	ra # 798 <.L113+0x34>
 7a0:	bc040793          	addi	a5,s0,-1088
 7a4:	0818                	addi	a4,sp,16
 7a6:	00f70533          	add	a0,a4,a5
 7aa:	00000097          	auipc	ra,0x0
 7ae:	000080e7          	jalr	ra # 7aa <.L113+0x46>
 7b2:	47a2                	lw	a5,8(sp)
 7b4:	547d                	li	s0,-1
 7b6:	b0f9                	j	84 <.L98>

000007b8 <.L151>:
 7b8:	6705                	lui	a4,0x1
 7ba:	a4070793          	addi	a5,a4,-1472 # a40 <.L121+0x32>
 7be:	84070713          	addi	a4,a4,-1984
 7c2:	97b2                	add	a5,a5,a2
 7c4:	9732                	add	a4,a4,a2

000007c6 <.L103>:
 7c6:	0007a803          	lw	a6,0(a5)
 7ca:	43c8                	lw	a0,4(a5)
 7cc:	478c                	lw	a1,8(a5)
 7ce:	47d0                	lw	a2,12(a5)
 7d0:	01072023          	sw	a6,0(a4)
 7d4:	c348                	sw	a0,4(a4)
 7d6:	c70c                	sw	a1,8(a4)
 7d8:	c750                	sw	a2,12(a4)
 7da:	07c1                	addi	a5,a5,16
 7dc:	0741                	addi	a4,a4,16
 7de:	fefd94e3          	bne	s11,a5,7c6 <.L103>
 7e2:	b48d                	j	244 <.L100>

000007e4 <.L112>:
 7e4:	0705                	addi	a4,a4,1
 7e6:	40c70633          	sub	a2,a4,a2
 7ea:	bfad                	j	764 <.L113>

000007ec <.L111>:
 7ec:	6a05                	lui	s4,0x1
 7ee:	081c                	addi	a5,sp,16
 7f0:	a40a0513          	addi	a0,s4,-1472 # a40 <.L121+0x32>
 7f4:	953e                	add	a0,a0,a5
 7f6:	65010593          	addi	a1,sp,1616
 7fa:	00000097          	auipc	ra,0x0
 7fe:	000080e7          	jalr	ra # 7fa <.L111+0xe>
 802:	0818                	addi	a4,sp,16
 804:	a40a0793          	addi	a5,s4,-1472
 808:	97ba                	add	a5,a5,a4
 80a:	0007c703          	lbu	a4,0(a5)
 80e:	2cf14783          	lbu	a5,719(sp)
 812:	8b05                	andi	a4,a4,1
 814:	839d                	srli	a5,a5,0x7
 816:	52f70c63          	beq	a4,a5,d4e <.L153>

0000081a <.L114>:
 81a:	6a05                	lui	s4,0x1
 81c:	0818                	addi	a4,sp,16
 81e:	767d                	lui	a2,0xfffff
 820:	e40a0793          	addi	a5,s4,-448 # e40 <.L115+0xc4>
 824:	97ba                	add	a5,a5,a4
 826:	48060613          	addi	a2,a2,1152 # fffff480 <.L115+0xffffe704>
 82a:	840a0513          	addi	a0,s4,-1984
 82e:	963e                	add	a2,a2,a5
 830:	953a                	add	a0,a0,a4
 832:	65010593          	addi	a1,sp,1616
 836:	00000097          	auipc	ra,0x0
 83a:	000080e7          	jalr	ra # 836 <.L114+0x1c>
 83e:	a40a0713          	addi	a4,s4,-1472
 842:	0814                	addi	a3,sp,16
 844:	65010793          	addi	a5,sp,1616
 848:	9736                	add	a4,a4,a3

0000084a <.L116>:
 84a:	4388                	lw	a0,0(a5)
 84c:	43cc                	lw	a1,4(a5)
 84e:	4790                	lw	a2,8(a5)
 850:	47d4                	lw	a3,12(a5)
 852:	c308                	sw	a0,0(a4)
 854:	c34c                	sw	a1,4(a4)
 856:	c710                	sw	a2,8(a4)
 858:	c754                	sw	a3,12(a4)
 85a:	07c1                	addi	a5,a5,16
 85c:	0741                	addi	a4,a4,16
 85e:	ff5796e3          	bne	a5,s5,84a <.L116>
 862:	6705                	lui	a4,0x1
 864:	0814                	addi	a3,sp,16
 866:	e4070713          	addi	a4,a4,-448 # e40 <.L115+0xc4>
 86a:	9736                	add	a4,a4,a3
 86c:	77fd                	lui	a5,0xfffff
 86e:	97ba                	add	a5,a5,a4
 870:	c63e                	sw	a5,12(sp)
 872:	46b2                	lw	a3,12(sp)
 874:	48078793          	addi	a5,a5,1152 # fffff480 <.L115+0xffffe704>
 878:	876e                	mv	a4,s11
 87a:	50068693          	addi	a3,a3,1280

0000087e <.L117>:
 87e:	0007a803          	lw	a6,0(a5)
 882:	43c8                	lw	a0,4(a5)
 884:	478c                	lw	a1,8(a5)
 886:	47d0                	lw	a2,12(a5)
 888:	01072023          	sw	a6,0(a4)
 88c:	c348                	sw	a0,4(a4)
 88e:	c70c                	sw	a1,8(a4)
 890:	c750                	sw	a2,12(a4)
 892:	07c1                	addi	a5,a5,16
 894:	0741                	addi	a4,a4,16
 896:	fed794e3          	bne	a5,a3,87e <.L117>
 89a:	6685                	lui	a3,0x1
 89c:	080c                	addi	a1,sp,16
 89e:	b4068613          	addi	a2,a3,-1216 # b40 <.L123+0x76>
 8a2:	4705                	li	a4,1
 8a4:	962e                	add	a2,a2,a1
 8a6:	4781                	li	a5,0
 8a8:	c218                	sw	a4,0(a2)
 8aa:	8736                	mv	a4,a3
 8ac:	b4868693          	addi	a3,a3,-1208
 8b0:	4801                	li	a6,0
 8b2:	96ae                	add	a3,a3,a1
 8b4:	c25c                	sw	a5,4(a2)
 8b6:	4781                	li	a5,0
 8b8:	c29c                	sw	a5,0(a3)
 8ba:	0106a223          	sw	a6,4(a3)
 8be:	b5070693          	addi	a3,a4,-1200
 8c2:	96ae                	add	a3,a3,a1
 8c4:	c29c                	sw	a5,0(a3)
 8c6:	0106a223          	sw	a6,4(a3)
 8ca:	b5870693          	addi	a3,a4,-1192
 8ce:	96ae                	add	a3,a3,a1
 8d0:	c29c                	sw	a5,0(a3)
 8d2:	0106a223          	sw	a6,4(a3)
 8d6:	b6070693          	addi	a3,a4,-1184
 8da:	96ae                	add	a3,a3,a1
 8dc:	c29c                	sw	a5,0(a3)
 8de:	0106a223          	sw	a6,4(a3)
 8e2:	b6870693          	addi	a3,a4,-1176
 8e6:	96ae                	add	a3,a3,a1
 8e8:	c29c                	sw	a5,0(a3)
 8ea:	0106a223          	sw	a6,4(a3)
 8ee:	b7070693          	addi	a3,a4,-1168
 8f2:	96ae                	add	a3,a3,a1
 8f4:	c29c                	sw	a5,0(a3)
 8f6:	0106a223          	sw	a6,4(a3)
 8fa:	b7870693          	addi	a3,a4,-1160
 8fe:	96ae                	add	a3,a3,a1
 900:	c29c                	sw	a5,0(a3)
 902:	0106a223          	sw	a6,4(a3)
 906:	b8070693          	addi	a3,a4,-1152
 90a:	96ae                	add	a3,a3,a1
 90c:	c29c                	sw	a5,0(a3)
 90e:	0106a223          	sw	a6,4(a3)
 912:	b8870693          	addi	a3,a4,-1144
 916:	96ae                	add	a3,a3,a1
 918:	c29c                	sw	a5,0(a3)
 91a:	0106a223          	sw	a6,4(a3)
 91e:	b9070693          	addi	a3,a4,-1136
 922:	96ae                	add	a3,a3,a1
 924:	c29c                	sw	a5,0(a3)
 926:	0106a223          	sw	a6,4(a3)
 92a:	b9870693          	addi	a3,a4,-1128
 92e:	96ae                	add	a3,a3,a1
 930:	c29c                	sw	a5,0(a3)
 932:	0106a223          	sw	a6,4(a3)
 936:	ba070693          	addi	a3,a4,-1120
 93a:	96ae                	add	a3,a3,a1
 93c:	c29c                	sw	a5,0(a3)
 93e:	0106a223          	sw	a6,4(a3)
 942:	ba870693          	addi	a3,a4,-1112
 946:	96ae                	add	a3,a3,a1
 948:	c29c                	sw	a5,0(a3)
 94a:	0106a223          	sw	a6,4(a3)
 94e:	bb070693          	addi	a3,a4,-1104
 952:	96ae                	add	a3,a3,a1
 954:	c29c                	sw	a5,0(a3)
 956:	0106a223          	sw	a6,4(a3)
 95a:	bb870693          	addi	a3,a4,-1096
 95e:	96ae                	add	a3,a3,a1
 960:	c29c                	sw	a5,0(a3)
 962:	84070793          	addi	a5,a4,-1984
 966:	bc070713          	addi	a4,a4,-1088
 96a:	0106a223          	sw	a6,4(a3)
 96e:	97ae                	add	a5,a5,a1
 970:	972e                	add	a4,a4,a1

00000972 <.L118>:
 972:	4388                	lw	a0,0(a5)
 974:	43cc                	lw	a1,4(a5)
 976:	4790                	lw	a2,8(a5)
 978:	47d4                	lw	a3,12(a5)
 97a:	c308                	sw	a0,0(a4)
 97c:	c34c                	sw	a1,4(a4)
 97e:	c710                	sw	a2,8(a4)
 980:	c754                	sw	a3,12(a4)
 982:	07c1                	addi	a5,a5,16
 984:	0741                	addi	a4,a4,16
 986:	fefd16e3          	bne	s10,a5,972 <.L118>
 98a:	405c                	lw	a5,4(s0)
 98c:	4010                	lw	a2,0(s0)
 98e:	3ac7d363          	bge	a5,a2,d34 <.L119>
 992:	4601                	li	a2,0

00000994 <.L120>:
 994:	45a2                	lw	a1,8(sp)
 996:	854a                	mv	a0,s2
 998:	6a05                	lui	s4,0x1
 99a:	00000097          	auipc	ra,0x0
 99e:	000080e7          	jalr	ra # 99a <.L120+0x6>
 9a2:	02000613          	li	a2,32
 9a6:	85da                	mv	a1,s6
 9a8:	7d010513          	addi	a0,sp,2000
 9ac:	00000097          	auipc	ra,0x0
 9b0:	000080e7          	jalr	ra # 9ac <.L120+0x18>
 9b4:	41990533          	sub	a0,s2,s9
 9b8:	02000613          	li	a2,32
 9bc:	7d010593          	addi	a1,sp,2000
 9c0:	02050513          	addi	a0,a0,32
 9c4:	00000097          	auipc	ra,0x0
 9c8:	000080e7          	jalr	ra # 9c4 <.L120+0x30>
 9cc:	081c                	addi	a5,sp,16
 9ce:	840a0513          	addi	a0,s4,-1984 # 840 <.L114+0x26>
 9d2:	953e                	add	a0,a0,a5
 9d4:	85ca                	mv	a1,s2
 9d6:	8626                	mv	a2,s1
 9d8:	00000097          	auipc	ra,0x0
 9dc:	000080e7          	jalr	ra # 9d8 <.L120+0x44>
 9e0:	081c                	addi	a5,sp,16
 9e2:	c40a0513          	addi	a0,s4,-960
 9e6:	20000613          	li	a2,512
 9ea:	953e                	add	a0,a0,a5
 9ec:	4581                	li	a1,0
 9ee:	00000097          	auipc	ra,0x0
 9f2:	000080e7          	jalr	ra # 9ee <.L120+0x5a>
 9f6:	081c                	addi	a5,sp,16
 9f8:	840a0713          	addi	a4,s4,-1984
 9fc:	0810                	addi	a2,sp,16
 9fe:	973e                	add	a4,a4,a5
 a00:	c40a0793          	addi	a5,s4,-960
 a04:	97b2                	add	a5,a5,a2
 a06:	0814                	addi	a3,sp,16
 a08:	e40a0613          	addi	a2,s4,-448
 a0c:	9636                	add	a2,a2,a3

00000a0e <.L121>:
 a0e:	00074683          	lbu	a3,0(a4)
 a12:	0007a223          	sw	zero,4(a5)
 a16:	07a1                	addi	a5,a5,8
 a18:	fed7ac23          	sw	a3,-8(a5)
 a1c:	0705                	addi	a4,a4,1
 a1e:	fef618e3          	bne	a2,a5,a0e <.L121>
 a22:	6a05                	lui	s4,0x1
 a24:	081c                	addi	a5,sp,16
 a26:	c40a0593          	addi	a1,s4,-960 # c40 <.L152+0x2a>
 a2a:	95be                	add	a1,a1,a5
 a2c:	8562                	mv	a0,s8
 a2e:	00000097          	auipc	ra,0x0
 a32:	000080e7          	jalr	ra # a2e <.L121+0x20>
 a36:	081c                	addi	a5,sp,16
 a38:	a40a0593          	addi	a1,s4,-1472
 a3c:	0818                	addi	a4,sp,16
 a3e:	7afd                	lui	s5,0xfffff
 a40:	95be                	add	a1,a1,a5
 a42:	e40a0793          	addi	a5,s4,-448
 a46:	97ba                	add	a5,a5,a4
 a48:	1e0a8513          	addi	a0,s5,480 # fffff1e0 <.L115+0xffffe464>
 a4c:	953e                	add	a0,a0,a5
 a4e:	8662                	mv	a2,s8
 a50:	00000097          	auipc	ra,0x0
 a54:	000080e7          	jalr	ra # a50 <.L121+0x42>
 a58:	0814                	addi	a3,sp,16
 a5a:	e40a0793          	addi	a5,s4,-448
 a5e:	97b6                	add	a5,a5,a3
 a60:	97d6                	add	a5,a5,s5
 a62:	c63e                	sw	a5,12(sp)
 a64:	840a0713          	addi	a4,s4,-1984
 a68:	9736                	add	a4,a4,a3
 a6a:	46b2                	lw	a3,12(sp)
 a6c:	1e078793          	addi	a5,a5,480
 a70:	3e068693          	addi	a3,a3,992

00000a74 <.L122>:
 a74:	0007a803          	lw	a6,0(a5)
 a78:	43c8                	lw	a0,4(a5)
 a7a:	478c                	lw	a1,8(a5)
 a7c:	47d0                	lw	a2,12(a5)
 a7e:	01072023          	sw	a6,0(a4)
 a82:	c348                	sw	a0,4(a4)
 a84:	c70c                	sw	a1,8(a4)
 a86:	c750                	sw	a2,12(a4)
 a88:	07c1                	addi	a5,a5,16
 a8a:	0741                	addi	a4,a4,16
 a8c:	fed794e3          	bne	a5,a3,a74 <.L122>
 a90:	47a2                	lw	a5,8(sp)
 a92:	6a05                	lui	s4,0x1
 a94:	000005b7          	lui	a1,0x0
 a98:	41378633          	sub	a2,a5,s3
 a9c:	c40a0513          	addi	a0,s4,-960 # c40 <.L152+0x2a>
 aa0:	081c                	addi	a5,sp,16
 aa2:	02060613          	addi	a2,a2,32
 aa6:	953e                	add	a0,a0,a5
 aa8:	00058593          	mv	a1,a1
 aac:	00000097          	auipc	ra,0x0
 ab0:	000080e7          	jalr	ra # aac <.L122+0x38>
 ab4:	0818                	addi	a4,sp,16
 ab6:	c40a0793          	addi	a5,s4,-960
 aba:	0810                	addi	a2,sp,16
 abc:	97ba                	add	a5,a5,a4
 abe:	e40a0813          	addi	a6,s4,-448
 ac2:	a40a0713          	addi	a4,s4,-1472
 ac6:	9732                	add	a4,a4,a2
 ac8:	9832                	add	a6,a6,a2

00000aca <.L123>:
 aca:	4388                	lw	a0,0(a5)
 acc:	43cc                	lw	a1,4(a5)
 ace:	4790                	lw	a2,8(a5)
 ad0:	47d4                	lw	a3,12(a5)
 ad2:	c308                	sw	a0,0(a4)
 ad4:	c34c                	sw	a1,4(a4)
 ad6:	c710                	sw	a2,8(a4)
 ad8:	c754                	sw	a3,12(a4)
 ada:	07c1                	addi	a5,a5,16
 adc:	0741                	addi	a4,a4,16
 ade:	ff0796e3          	bne	a5,a6,aca <.L123>
 ae2:	6a05                	lui	s4,0x1
 ae4:	081c                	addi	a5,sp,16
 ae6:	a40a0593          	addi	a1,s4,-1472 # a40 <.L121+0x32>
 aea:	840a0513          	addi	a0,s4,-1984
 aee:	95be                	add	a1,a1,a5
 af0:	953e                	add	a0,a0,a5
 af2:	00000097          	auipc	ra,0x0
 af6:	000080e7          	jalr	ra # af2 <.L123+0x28>
 afa:	081c                	addi	a5,sp,16
 afc:	840a0593          	addi	a1,s4,-1984
 b00:	95be                	add	a1,a1,a5
 b02:	0818                	addi	a4,sp,16
 b04:	7afd                	lui	s5,0xfffff
 b06:	e40a0793          	addi	a5,s4,-448
 b0a:	97ba                	add	a5,a5,a4
 b0c:	1c0a8513          	addi	a0,s5,448 # fffff1c0 <.L115+0xffffe444>
 b10:	953e                	add	a0,a0,a5
 b12:	00000097          	auipc	ra,0x0
 b16:	000080e7          	jalr	ra # b12 <.L123+0x48>
 b1a:	0814                	addi	a3,sp,16
 b1c:	e40a0713          	addi	a4,s4,-448
 b20:	9736                	add	a4,a4,a3
 b22:	9756                	add	a4,a4,s5
 b24:	c40a0513          	addi	a0,s4,-960
 b28:	1c070593          	addi	a1,a4,448
 b2c:	02000613          	li	a2,32
 b30:	9536                	add	a0,a0,a3
 b32:	c63a                	sw	a4,12(sp)
 b34:	00000097          	auipc	ra,0x0
 b38:	000080e7          	jalr	ra # b34 <.L123+0x6a>
 b3c:	081c                	addi	a5,sp,16
 b3e:	c40a0613          	addi	a2,s4,-960
 b42:	963e                	add	a2,a2,a5
 b44:	47a2                	lw	a5,8(sp)
 b46:	000b8693          	mv	a3,s7
 b4a:	000b8593          	mv	a1,s7
 b4e:	41378533          	sub	a0,a5,s3
 b52:	00000097          	auipc	ra,0x0
 b56:	000080e7          	jalr	ra # b52 <.L123+0x88>
 b5a:	87aa                	mv	a5,a0
 b5c:	10051e63          	bnez	a0,c78 <.L124>
 b60:	40d8                	lw	a4,4(s1)
 b62:	4094                	lw	a3,0(s1)
 b64:	4601                	li	a2,0
 b66:	00d74563          	blt	a4,a3,b70 <.L125>
 b6a:	0705                	addi	a4,a4,1
 b6c:	40d70633          	sub	a2,a4,a3

00000b70 <.L125>:
 b70:	4581                	li	a1,0
 b72:	854a                	mv	a0,s2
 b74:	6405                	lui	s0,0x1
 b76:	c43e                	sw	a5,8(sp)
 b78:	00000097          	auipc	ra,0x0
 b7c:	000080e7          	jalr	ra # b78 <.L125+0x8>
 b80:	081c                	addi	a5,sp,16
 b82:	c4040513          	addi	a0,s0,-960 # c40 <.L152+0x2a>
 b86:	000b8593          	mv	a1,s7
 b8a:	953e                	add	a0,a0,a5
 b8c:	00000097          	auipc	ra,0x0
 b90:	000080e7          	jalr	ra # b8c <.L125+0x1c>
 b94:	081c                	addi	a5,sp,16
 b96:	84040513          	addi	a0,s0,-1984
 b9a:	953e                	add	a0,a0,a5
 b9c:	00000097          	auipc	ra,0x0
 ba0:	000080e7          	jalr	ra # b9c <.L125+0x2c>
 ba4:	856a                	mv	a0,s10
 ba6:	00000097          	auipc	ra,0x0
 baa:	000080e7          	jalr	ra # ba6 <.L125+0x36>
 bae:	94040793          	addi	a5,s0,-1728
 bb2:	0818                	addi	a4,sp,16
 bb4:	00f70533          	add	a0,a4,a5
 bb8:	00000097          	auipc	ra,0x0
 bbc:	000080e7          	jalr	ra # bb8 <.L125+0x48>
 bc0:	0818                	addi	a4,sp,16
 bc2:	9c040793          	addi	a5,s0,-1600
 bc6:	00f70533          	add	a0,a4,a5
 bca:	00000097          	auipc	ra,0x0
 bce:	000080e7          	jalr	ra # bca <.L125+0x5a>
 bd2:	081c                	addi	a5,sp,16
 bd4:	a4040513          	addi	a0,s0,-1472
 bd8:	953e                	add	a0,a0,a5
 bda:	00000097          	auipc	ra,0x0
 bde:	000080e7          	jalr	ra # bda <.L125+0x6a>
 be2:	856e                	mv	a0,s11
 be4:	00000097          	auipc	ra,0x0
 be8:	000080e7          	jalr	ra # be4 <.L125+0x74>
 bec:	b4040793          	addi	a5,s0,-1216
 bf0:	0818                	addi	a4,sp,16
 bf2:	00f70533          	add	a0,a4,a5
 bf6:	00000097          	auipc	ra,0x0
 bfa:	000080e7          	jalr	ra # bf6 <.L125+0x86>
 bfe:	081c                	addi	a5,sp,16
 c00:	bc040513          	addi	a0,s0,-1088
 c04:	953e                	add	a0,a0,a5
 c06:	00000097          	auipc	ra,0x0
 c0a:	000080e7          	jalr	ra # c06 <.L125+0x96>
 c0e:	47a2                	lw	a5,8(sp)
 c10:	547d                	li	s0,-1
 c12:	c72ff06f          	j	84 <.L98>

00000c16 <.L152>:
 c16:	6785                	lui	a5,0x1
 c18:	0818                	addi	a4,sp,16
 c1a:	7a7d                	lui	s4,0xfffff
 c1c:	e4078793          	addi	a5,a5,-448 # e40 <.L115+0xc4>
 c20:	97ba                	add	a5,a5,a4
 c22:	3e0a0513          	addi	a0,s4,992 # fffff3e0 <.L115+0xffffe664>
 c26:	00000637          	lui	a2,0x0
 c2a:	953e                	add	a0,a0,a5
 c2c:	00060613          	mv	a2,a2
 c30:	65010593          	addi	a1,sp,1616
 c34:	00000097          	auipc	ra,0x0
 c38:	000080e7          	jalr	ra # c34 <.L152+0x1e>
 c3c:	6785                	lui	a5,0x1
 c3e:	0818                	addi	a4,sp,16
 c40:	e4078793          	addi	a5,a5,-448 # e40 <.L115+0xc4>
 c44:	97ba                	add	a5,a5,a4
 c46:	97d2                	add	a5,a5,s4
 c48:	c63e                	sw	a5,12(sp)
 c4a:	46b2                	lw	a3,12(sp)
 c4c:	3e078793          	addi	a5,a5,992
 c50:	65010713          	addi	a4,sp,1616
 c54:	46068693          	addi	a3,a3,1120

00000c58 <.L109>:
 c58:	0007a803          	lw	a6,0(a5)
 c5c:	43c8                	lw	a0,4(a5)
 c5e:	478c                	lw	a1,8(a5)
 c60:	47d0                	lw	a2,12(a5)
 c62:	01072023          	sw	a6,0(a4)
 c66:	c348                	sw	a0,4(a4)
 c68:	c70c                	sw	a1,8(a4)
 c6a:	c750                	sw	a2,12(a4)
 c6c:	07c1                	addi	a5,a5,16
 c6e:	0741                	addi	a4,a4,16
 c70:	fed794e3          	bne	a5,a3,c58 <.L109>
 c74:	f8eff06f          	j	402 <.L108>

00000c78 <.L124>:
 c78:	46a2                	lw	a3,8(sp)
 c7a:	4058                	lw	a4,4(s0)
 c7c:	4000                	lw	s0,0(s0)
 c7e:	413689b3          	sub	s3,a3,s3
 c82:	41990533          	sub	a0,s2,s9
 c86:	04098593          	addi	a1,s3,64
 c8a:	0a875963          	bge	a4,s0,d3c <.L154>
 c8e:	4601                	li	a2,0
 c90:	fc000413          	li	s0,-64

00000c94 <.L126>:
 c94:	6485                	lui	s1,0x1
 c96:	c43e                	sw	a5,8(sp)
 c98:	00000097          	auipc	ra,0x0
 c9c:	000080e7          	jalr	ra # c98 <.L126+0x4>
 ca0:	081c                	addi	a5,sp,16
 ca2:	c4048513          	addi	a0,s1,-960 # c40 <.L152+0x2a>
 ca6:	000b8593          	mv	a1,s7
 caa:	953e                	add	a0,a0,a5
 cac:	00000097          	auipc	ra,0x0
 cb0:	000080e7          	jalr	ra # cac <.L126+0x18>
 cb4:	081c                	addi	a5,sp,16
 cb6:	84048513          	addi	a0,s1,-1984
 cba:	953e                	add	a0,a0,a5
 cbc:	00000097          	auipc	ra,0x0
 cc0:	000080e7          	jalr	ra # cbc <.L126+0x28>
 cc4:	856a                	mv	a0,s10
 cc6:	00000097          	auipc	ra,0x0
 cca:	000080e7          	jalr	ra # cc6 <.L126+0x32>
 cce:	94048793          	addi	a5,s1,-1728
 cd2:	0818                	addi	a4,sp,16
 cd4:	00f70533          	add	a0,a4,a5
 cd8:	00000097          	auipc	ra,0x0
 cdc:	000080e7          	jalr	ra # cd8 <.L126+0x44>
 ce0:	0818                	addi	a4,sp,16
 ce2:	9c048793          	addi	a5,s1,-1600
 ce6:	00f70533          	add	a0,a4,a5
 cea:	00000097          	auipc	ra,0x0
 cee:	000080e7          	jalr	ra # cea <.L126+0x56>
 cf2:	081c                	addi	a5,sp,16
 cf4:	a4048513          	addi	a0,s1,-1472
 cf8:	953e                	add	a0,a0,a5
 cfa:	00000097          	auipc	ra,0x0
 cfe:	000080e7          	jalr	ra # cfa <.L126+0x66>
 d02:	856e                	mv	a0,s11
 d04:	00000097          	auipc	ra,0x0
 d08:	000080e7          	jalr	ra # d04 <.L126+0x70>
 d0c:	b4048793          	addi	a5,s1,-1216
 d10:	0818                	addi	a4,sp,16
 d12:	00f70533          	add	a0,a4,a5
 d16:	00000097          	auipc	ra,0x0
 d1a:	000080e7          	jalr	ra # d16 <.L126+0x82>
 d1e:	081c                	addi	a5,sp,16
 d20:	bc048513          	addi	a0,s1,-1088
 d24:	953e                	add	a0,a0,a5
 d26:	00000097          	auipc	ra,0x0
 d2a:	000080e7          	jalr	ra # d26 <.L126+0x92>
 d2e:	47a2                	lw	a5,8(sp)
 d30:	b54ff06f          	j	84 <.L98>

00000d34 <.L119>:
 d34:	0785                	addi	a5,a5,1
 d36:	40c78633          	sub	a2,a5,a2
 d3a:	b9a9                	j	994 <.L120>

00000d3c <.L154>:
 d3c:	fc170713          	addi	a4,a4,-63
 d40:	40870433          	sub	s0,a4,s0
 d44:	fff44613          	not	a2,s0
 d48:	867d                	srai	a2,a2,0x1f
 d4a:	8e61                	and	a2,a2,s0
 d4c:	b7a1                	j	c94 <.L126>

00000d4e <.L153>:
 d4e:	77fd                	lui	a5,0xfffff
 d50:	3e078513          	addi	a0,a5,992 # fffff3e0 <.L115+0xffffe664>
 d54:	6785                	lui	a5,0x1
 d56:	0818                	addi	a4,sp,16
 d58:	e4078793          	addi	a5,a5,-448 # e40 <.L115+0xc4>
 d5c:	97ba                	add	a5,a5,a4
 d5e:	000005b7          	lui	a1,0x0
 d62:	953e                	add	a0,a0,a5
 d64:	65010613          	addi	a2,sp,1616
 d68:	00058593          	mv	a1,a1
 d6c:	00000097          	auipc	ra,0x0
 d70:	000080e7          	jalr	ra # d6c <.L153+0x1e>
 d74:	1c1c                	addi	a5,sp,560
 d76:	65010713          	addi	a4,sp,1616
 d7a:	1d14                	addi	a3,sp,688

00000d7c <.L115>:
 d7c:	0007a803          	lw	a6,0(a5)
 d80:	43c8                	lw	a0,4(a5)
 d82:	478c                	lw	a1,8(a5)
 d84:	47d0                	lw	a2,12(a5)
 d86:	01072023          	sw	a6,0(a4)
 d8a:	c348                	sw	a0,4(a4)
 d8c:	c70c                	sw	a1,8(a4)
 d8e:	c750                	sw	a2,12(a4)
 d90:	07c1                	addi	a5,a5,16
 d92:	0741                	addi	a4,a4,16
 d94:	fed794e3          	bne	a5,a3,d7c <.L115>
 d98:	b449                	j	81a <.L114>
