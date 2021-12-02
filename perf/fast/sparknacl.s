
sparknacl.o:     file format elf32-littleriscv


Disassembly of section .text.sparknacl__byte_seqIP:

00000000 <sparknacl__byte_seqIP>:
   0:	8082                	ret

Disassembly of section .text.sparknacl__TgfBIP:

00000000 <sparknacl__TgfBIP>:
   0:	8082                	ret

Disassembly of section .text.sparknacl__normal_gfPredicate:

00000000 <sparknacl__normal_gfPredicate>:
   0:	415c                	lw	a5,4(a0)
   2:	ebc5                	bnez	a5,b2 <.L23>
   4:	4118                	lw	a4,0(a0)
   6:	67c1                	lui	a5,0x10
   8:	0af77563          	bgeu	a4,a5,b2 <.L23>
   c:	4558                	lw	a4,12(a0)
   e:	e355                	bnez	a4,b2 <.L23>
  10:	4518                	lw	a4,8(a0)
  12:	0af77063          	bgeu	a4,a5,b2 <.L23>
  16:	4958                	lw	a4,20(a0)
  18:	ef49                	bnez	a4,b2 <.L23>
  1a:	4918                	lw	a4,16(a0)
  1c:	08f77b63          	bgeu	a4,a5,b2 <.L23>
  20:	4d58                	lw	a4,28(a0)
  22:	eb41                	bnez	a4,b2 <.L23>
  24:	4d18                	lw	a4,24(a0)
  26:	08f77663          	bgeu	a4,a5,b2 <.L23>
  2a:	5158                	lw	a4,36(a0)
  2c:	e359                	bnez	a4,b2 <.L23>
  2e:	5118                	lw	a4,32(a0)
  30:	08f77163          	bgeu	a4,a5,b2 <.L23>
  34:	555c                	lw	a5,44(a0)
  36:	efb5                	bnez	a5,b2 <.L23>
  38:	5518                	lw	a4,40(a0)
  3a:	67c1                	lui	a5,0x10
  3c:	06f77b63          	bgeu	a4,a5,b2 <.L23>
  40:	5958                	lw	a4,52(a0)
  42:	eb25                	bnez	a4,b2 <.L23>
  44:	5918                	lw	a4,48(a0)
  46:	06f77663          	bgeu	a4,a5,b2 <.L23>
  4a:	5d58                	lw	a4,60(a0)
  4c:	e33d                	bnez	a4,b2 <.L23>
  4e:	5d18                	lw	a4,56(a0)
  50:	06f77163          	bgeu	a4,a5,b2 <.L23>
  54:	4178                	lw	a4,68(a0)
  56:	ef31                	bnez	a4,b2 <.L23>
  58:	4138                	lw	a4,64(a0)
  5a:	04f77c63          	bgeu	a4,a5,b2 <.L23>
  5e:	4578                	lw	a4,76(a0)
  60:	eb29                	bnez	a4,b2 <.L23>
  62:	4538                	lw	a4,72(a0)
  64:	04f77763          	bgeu	a4,a5,b2 <.L23>
  68:	497c                	lw	a5,84(a0)
  6a:	e7a1                	bnez	a5,b2 <.L23>
  6c:	4938                	lw	a4,80(a0)
  6e:	67c1                	lui	a5,0x10
  70:	04f77163          	bgeu	a4,a5,b2 <.L23>
  74:	4d78                	lw	a4,92(a0)
  76:	ef15                	bnez	a4,b2 <.L23>
  78:	4d38                	lw	a4,88(a0)
  7a:	02f77c63          	bgeu	a4,a5,b2 <.L23>
  7e:	5178                	lw	a4,100(a0)
  80:	eb0d                	bnez	a4,b2 <.L23>
  82:	5138                	lw	a4,96(a0)
  84:	02f77763          	bgeu	a4,a5,b2 <.L23>
  88:	5578                	lw	a4,108(a0)
  8a:	e705                	bnez	a4,b2 <.L23>
  8c:	5538                	lw	a4,104(a0)
  8e:	02f77263          	bgeu	a4,a5,b2 <.L23>
  92:	5978                	lw	a4,116(a0)
  94:	ef19                	bnez	a4,b2 <.L23>
  96:	5938                	lw	a4,112(a0)
  98:	00f77d63          	bgeu	a4,a5,b2 <.L23>
  9c:	5d78                	lw	a4,124(a0)
  9e:	4785                	li	a5,1
  a0:	e709                	bnez	a4,aa <.L22>
  a2:	5d34                	lw	a3,120(a0)
  a4:	6741                	lui	a4,0x10
  a6:	00e6e363          	bltu	a3,a4,ac <.L21>

000000aa <.L22>:
  aa:	4781                	li	a5,0

000000ac <.L21>:
  ac:	0ff7f513          	andi	a0,a5,255
  b0:	8082                	ret

000000b2 <.L23>:
  b2:	4501                	li	a0,0
  b4:	8082                	ret

Disassembly of section .text.sparknacl__i64_byte_seqIP:

00000000 <sparknacl__i64_byte_seqIP>:
   0:	8082                	ret

Disassembly of section .text.sparknacl__i64_seqIP:

00000000 <sparknacl__i64_seqIP>:
   0:	8082                	ret

Disassembly of section .text.sparknacl__u32_seqIP:

00000000 <sparknacl__u32_seqIP>:
   0:	8082                	ret

Disassembly of section .text.sparknacl__u64_seqIP:

00000000 <sparknacl__u64_seqIP>:
   0:	8082                	ret

Disassembly of section .text.sparknacl__Tgf_paBIP:

00000000 <sparknacl__Tgf_paBIP>:
   0:	8082                	ret

Disassembly of section .text.sparknacl__sum_gfPredicate:

00000000 <sparknacl__sum_gfPredicate>:
   0:	415c                	lw	a5,4(a0)
   2:	e3e1                	bnez	a5,c2 <.L63>
   4:	4118                	lw	a4,0(a0)
   6:	000207b7          	lui	a5,0x20
   a:	17f9                	addi	a5,a5,-2
   c:	0ae7eb63          	bltu	a5,a4,c2 <.L63>
  10:	4558                	lw	a4,12(a0)
  12:	eb45                	bnez	a4,c2 <.L63>
  14:	4518                	lw	a4,8(a0)
  16:	0ae7e663          	bltu	a5,a4,c2 <.L63>
  1a:	4958                	lw	a4,20(a0)
  1c:	e35d                	bnez	a4,c2 <.L63>
  1e:	4918                	lw	a4,16(a0)
  20:	0ae7e163          	bltu	a5,a4,c2 <.L63>
  24:	4d58                	lw	a4,28(a0)
  26:	ef51                	bnez	a4,c2 <.L63>
  28:	4d18                	lw	a4,24(a0)
  2a:	08e7ec63          	bltu	a5,a4,c2 <.L63>
  2e:	5158                	lw	a4,36(a0)
  30:	eb49                	bnez	a4,c2 <.L63>
  32:	5118                	lw	a4,32(a0)
  34:	08e7e763          	bltu	a5,a4,c2 <.L63>
  38:	555c                	lw	a5,44(a0)
  3a:	e7c1                	bnez	a5,c2 <.L63>
  3c:	5518                	lw	a4,40(a0)
  3e:	000207b7          	lui	a5,0x20
  42:	17f9                	addi	a5,a5,-2
  44:	06e7ef63          	bltu	a5,a4,c2 <.L63>
  48:	5958                	lw	a4,52(a0)
  4a:	ef25                	bnez	a4,c2 <.L63>
  4c:	5918                	lw	a4,48(a0)
  4e:	06e7ea63          	bltu	a5,a4,c2 <.L63>
  52:	5d58                	lw	a4,60(a0)
  54:	e73d                	bnez	a4,c2 <.L63>
  56:	5d18                	lw	a4,56(a0)
  58:	06e7e563          	bltu	a5,a4,c2 <.L63>
  5c:	4178                	lw	a4,68(a0)
  5e:	e335                	bnez	a4,c2 <.L63>
  60:	4138                	lw	a4,64(a0)
  62:	06e7e063          	bltu	a5,a4,c2 <.L63>
  66:	4578                	lw	a4,76(a0)
  68:	ef29                	bnez	a4,c2 <.L63>
  6a:	4538                	lw	a4,72(a0)
  6c:	04e7eb63          	bltu	a5,a4,c2 <.L63>
  70:	497c                	lw	a5,84(a0)
  72:	eba1                	bnez	a5,c2 <.L63>
  74:	4938                	lw	a4,80(a0)
  76:	000207b7          	lui	a5,0x20
  7a:	17f9                	addi	a5,a5,-2
  7c:	04e7e363          	bltu	a5,a4,c2 <.L63>
  80:	4d78                	lw	a4,92(a0)
  82:	e321                	bnez	a4,c2 <.L63>
  84:	4d38                	lw	a4,88(a0)
  86:	02e7ee63          	bltu	a5,a4,c2 <.L63>
  8a:	5178                	lw	a4,100(a0)
  8c:	eb1d                	bnez	a4,c2 <.L63>
  8e:	5138                	lw	a4,96(a0)
  90:	02e7e963          	bltu	a5,a4,c2 <.L63>
  94:	5578                	lw	a4,108(a0)
  96:	e715                	bnez	a4,c2 <.L63>
  98:	5538                	lw	a4,104(a0)
  9a:	02e7e463          	bltu	a5,a4,c2 <.L63>
  9e:	5978                	lw	a4,116(a0)
  a0:	e30d                	bnez	a4,c2 <.L63>
  a2:	5938                	lw	a4,112(a0)
  a4:	00e7ef63          	bltu	a5,a4,c2 <.L63>
  a8:	5d78                	lw	a4,124(a0)
  aa:	4785                	li	a5,1
  ac:	e719                	bnez	a4,ba <.L62>
  ae:	5d34                	lw	a3,120(a0)
  b0:	00020737          	lui	a4,0x20
  b4:	1779                	addi	a4,a4,-2
  b6:	00d77363          	bgeu	a4,a3,bc <.L61>

000000ba <.L62>:
  ba:	4781                	li	a5,0

000000bc <.L61>:
  bc:	0ff7f513          	andi	a0,a5,255
  c0:	8082                	ret

000000c2 <.L63>:
  c2:	4501                	li	a0,0
  c4:	8082                	ret

Disassembly of section .text.sparknacl__difference_gfPredicate:

00000000 <sparknacl__difference_gfPredicate>:
   0:	4558                	lw	a4,12(a0)
   2:	4114                	lw	a3,0(a0)
   4:	4150                	lw	a2,4(a0)
   6:	ef5d                	bnez	a4,c4 <.L99>
   8:	4518                	lw	a4,8(a0)
   a:	000207b7          	lui	a5,0x20
   e:	17f9                	addi	a5,a5,-2
  10:	0ae7ea63          	bltu	a5,a4,c4 <.L99>
  14:	4958                	lw	a4,20(a0)
  16:	e75d                	bnez	a4,c4 <.L99>
  18:	4918                	lw	a4,16(a0)
  1a:	0ae7e563          	bltu	a5,a4,c4 <.L99>
  1e:	4d58                	lw	a4,28(a0)
  20:	e355                	bnez	a4,c4 <.L99>
  22:	4d18                	lw	a4,24(a0)
  24:	0ae7e063          	bltu	a5,a4,c4 <.L99>
  28:	5158                	lw	a4,36(a0)
  2a:	ef49                	bnez	a4,c4 <.L99>
  2c:	5118                	lw	a4,32(a0)
  2e:	08e7eb63          	bltu	a5,a4,c4 <.L99>
  32:	5558                	lw	a4,44(a0)
  34:	eb41                	bnez	a4,c4 <.L99>
  36:	5518                	lw	a4,40(a0)
  38:	08e7e663          	bltu	a5,a4,c4 <.L99>
  3c:	595c                	lw	a5,52(a0)
  3e:	e3d9                	bnez	a5,c4 <.L99>
  40:	5918                	lw	a4,48(a0)
  42:	000207b7          	lui	a5,0x20
  46:	17f9                	addi	a5,a5,-2
  48:	06e7ee63          	bltu	a5,a4,c4 <.L99>
  4c:	5d58                	lw	a4,60(a0)
  4e:	eb3d                	bnez	a4,c4 <.L99>
  50:	5d18                	lw	a4,56(a0)
  52:	06e7e963          	bltu	a5,a4,c4 <.L99>
  56:	4178                	lw	a4,68(a0)
  58:	e735                	bnez	a4,c4 <.L99>
  5a:	4138                	lw	a4,64(a0)
  5c:	06e7e463          	bltu	a5,a4,c4 <.L99>
  60:	4578                	lw	a4,76(a0)
  62:	e32d                	bnez	a4,c4 <.L99>
  64:	4538                	lw	a4,72(a0)
  66:	04e7ef63          	bltu	a5,a4,c4 <.L99>
  6a:	4978                	lw	a4,84(a0)
  6c:	ef21                	bnez	a4,c4 <.L99>
  6e:	4938                	lw	a4,80(a0)
  70:	04e7ea63          	bltu	a5,a4,c4 <.L99>
  74:	4d7c                	lw	a5,92(a0)
  76:	e7b9                	bnez	a5,c4 <.L99>
  78:	4d3c                	lw	a5,88(a0)
  7a:	00020737          	lui	a4,0x20
  7e:	1779                	addi	a4,a4,-2
  80:	04f76263          	bltu	a4,a5,c4 <.L99>
  84:	517c                	lw	a5,100(a0)
  86:	ef9d                	bnez	a5,c4 <.L99>
  88:	513c                	lw	a5,96(a0)
  8a:	02f76d63          	bltu	a4,a5,c4 <.L99>
  8e:	557c                	lw	a5,108(a0)
  90:	eb95                	bnez	a5,c4 <.L99>
  92:	553c                	lw	a5,104(a0)
  94:	02f76863          	bltu	a4,a5,c4 <.L99>
  98:	597c                	lw	a5,116(a0)
  9a:	e78d                	bnez	a5,c4 <.L99>
  9c:	593c                	lw	a5,112(a0)
  9e:	02f76363          	bltu	a4,a5,c4 <.L99>
  a2:	5d7c                	lw	a5,124(a0)
  a4:	e385                	bnez	a5,c4 <.L99>
  a6:	5d3c                	lw	a5,120(a0)
  a8:	00f76e63          	bltu	a4,a5,c4 <.L99>
  ac:	02568713          	addi	a4,a3,37
  b0:	00d737b3          	sltu	a5,a4,a3
  b4:	97b2                	add	a5,a5,a2
  b6:	4505                	li	a0,1
  b8:	e791                	bnez	a5,c4 <.L99>
  ba:	000207b7          	lui	a5,0x20
  be:	17f9                	addi	a5,a5,-2
  c0:	00e7f363          	bgeu	a5,a4,c6 <.L80>

000000c4 <.L99>:
  c4:	4501                	li	a0,0

000000c6 <.L80>:
  c6:	8082                	ret

Disassembly of section .text.sparknacl__product_gfPredicate:

00000000 <sparknacl__product_gfPredicate>:
   0:	4158                	lw	a4,4(a0)
   2:	23a00793          	li	a5,570
   6:	10e7e163          	bltu	a5,a4,108 <.L134>
   a:	0ef70863          	beq	a4,a5,fa <.L150>

0000000e <.L135>:
   e:	4558                	lw	a4,12(a0)
  10:	21500793          	li	a5,533
  14:	0ee7ea63          	bltu	a5,a4,108 <.L134>
  18:	10f70263          	beq	a4,a5,11c <.L151>

0000001c <.L136>:
  1c:	4958                	lw	a4,20(a0)
  1e:	1f000793          	li	a5,496
  22:	0ee7e363          	bltu	a5,a4,108 <.L134>
  26:	10f70363          	beq	a4,a5,12c <.L152>

0000002a <.L137>:
  2a:	4d58                	lw	a4,28(a0)
  2c:	1cb00793          	li	a5,459
  30:	0ce7ec63          	bltu	a5,a4,108 <.L134>
  34:	10f70463          	beq	a4,a5,13c <.L153>

00000038 <.L138>:
  38:	5158                	lw	a4,36(a0)
  3a:	1a600793          	li	a5,422
  3e:	0ce7e563          	bltu	a5,a4,108 <.L134>
  42:	10f70563          	beq	a4,a5,14c <.L154>

00000046 <.L139>:
  46:	5558                	lw	a4,44(a0)
  48:	18100793          	li	a5,385
  4c:	0ae7ee63          	bltu	a5,a4,108 <.L134>
  50:	10f70663          	beq	a4,a5,15c <.L155>

00000054 <.L140>:
  54:	5958                	lw	a4,52(a0)
  56:	15c00793          	li	a5,348
  5a:	0ae7e763          	bltu	a5,a4,108 <.L134>
  5e:	10f70763          	beq	a4,a5,16c <.L156>

00000062 <.L141>:
  62:	5d58                	lw	a4,60(a0)
  64:	13700793          	li	a5,311
  68:	0ae7e063          	bltu	a5,a4,108 <.L134>
  6c:	10f70863          	beq	a4,a5,17c <.L157>

00000070 <.L142>:
  70:	4178                	lw	a4,68(a0)
  72:	11200793          	li	a5,274
  76:	08e7e963          	bltu	a5,a4,108 <.L134>
  7a:	10f70963          	beq	a4,a5,18c <.L158>

0000007e <.L143>:
  7e:	4578                	lw	a4,76(a0)
  80:	0ed00793          	li	a5,237
  84:	08e7e263          	bltu	a5,a4,108 <.L134>
  88:	10f70a63          	beq	a4,a5,19c <.L159>

0000008c <.L144>:
  8c:	4978                	lw	a4,84(a0)
  8e:	0c800793          	li	a5,200
  92:	06e7eb63          	bltu	a5,a4,108 <.L134>
  96:	10f70b63          	beq	a4,a5,1ac <.L160>

0000009a <.L145>:
  9a:	4d78                	lw	a4,92(a0)
  9c:	0a300793          	li	a5,163
  a0:	06e7e463          	bltu	a5,a4,108 <.L134>
  a4:	06f70463          	beq	a4,a5,10c <.L161>

000000a8 <.L146>:
  a8:	5178                	lw	a4,100(a0)
  aa:	07e00793          	li	a5,126
  ae:	04e7ed63          	bltu	a5,a4,108 <.L134>
  b2:	10f70563          	beq	a4,a5,1bc <.L162>

000000b6 <.L147>:
  b6:	5578                	lw	a4,108(a0)
  b8:	05900793          	li	a5,89
  bc:	04e7e663          	bltu	a5,a4,108 <.L134>
  c0:	10f70663          	beq	a4,a5,1cc <.L163>

000000c4 <.L148>:
  c4:	5978                	lw	a4,116(a0)
  c6:	03400793          	li	a5,52
  ca:	02e7ef63          	bltu	a5,a4,108 <.L134>
  ce:	10f70763          	beq	a4,a5,1dc <.L164>

000000d2 <.L149>:
  d2:	5d74                	lw	a3,124(a0)
  d4:	473d                	li	a4,15
  d6:	4785                	li	a5,1
  d8:	00d76d63          	bltu	a4,a3,f2 <.L133>
  dc:	00e68563          	beq	a3,a4,e6 <.L165>

000000e0 <.L132>:
  e0:	0ff7f513          	andi	a0,a5,255
  e4:	8082                	ret

000000e6 <.L165>:
  e6:	5d34                	lw	a3,120(a0)
  e8:	ffe00737          	lui	a4,0xffe00
  ec:	0741                	addi	a4,a4,16
  ee:	fed779e3          	bgeu	a4,a3,e0 <.L132>

000000f2 <.L133>:
  f2:	4781                	li	a5,0
  f4:	0ff7f513          	andi	a0,a5,255
  f8:	8082                	ret

000000fa <.L150>:
  fa:	4118                	lw	a4,0(a0)
  fc:	fb8a07b7          	lui	a5,0xfb8a0
 100:	23b78793          	addi	a5,a5,571 # fb8a023b <.LFE21+0xfb89fa2b>
 104:	f0e7f5e3          	bgeu	a5,a4,e <.L135>

00000108 <.L134>:
 108:	4501                	li	a0,0
 10a:	8082                	ret

0000010c <.L161>:
 10c:	4d38                	lw	a4,88(a0)
 10e:	feb807b7          	lui	a5,0xfeb80
 112:	0a478793          	addi	a5,a5,164 # feb800a4 <.LFE21+0xfeb7f894>
 116:	f8e7f9e3          	bgeu	a5,a4,a8 <.L146>
 11a:	b7fd                	j	108 <.L134>

0000011c <.L151>:
 11c:	4518                	lw	a4,8(a0)
 11e:	fbd407b7          	lui	a5,0xfbd40
 122:	21678793          	addi	a5,a5,534 # fbd40216 <.LFE21+0xfbd3fa06>
 126:	eee7fbe3          	bgeu	a5,a4,1c <.L136>
 12a:	bff9                	j	108 <.L134>

0000012c <.L152>:
 12c:	4918                	lw	a4,16(a0)
 12e:	fc1e07b7          	lui	a5,0xfc1e0
 132:	1f178793          	addi	a5,a5,497 # fc1e01f1 <.LFE21+0xfc1df9e1>
 136:	eee7fae3          	bgeu	a5,a4,2a <.L137>
 13a:	b7f9                	j	108 <.L134>

0000013c <.L153>:
 13c:	4d18                	lw	a4,24(a0)
 13e:	fc6807b7          	lui	a5,0xfc680
 142:	1cc78793          	addi	a5,a5,460 # fc6801cc <.LFE21+0xfc67f9bc>
 146:	eee7f9e3          	bgeu	a5,a4,38 <.L138>
 14a:	bf7d                	j	108 <.L134>

0000014c <.L154>:
 14c:	5118                	lw	a4,32(a0)
 14e:	fcb207b7          	lui	a5,0xfcb20
 152:	1a778793          	addi	a5,a5,423 # fcb201a7 <.LFE21+0xfcb1f997>
 156:	eee7f8e3          	bgeu	a5,a4,46 <.L139>
 15a:	b77d                	j	108 <.L134>

0000015c <.L155>:
 15c:	5518                	lw	a4,40(a0)
 15e:	fcfc07b7          	lui	a5,0xfcfc0
 162:	18278793          	addi	a5,a5,386 # fcfc0182 <.LFE21+0xfcfbf972>
 166:	eee7f7e3          	bgeu	a5,a4,54 <.L140>
 16a:	bf79                	j	108 <.L134>

0000016c <.L156>:
 16c:	5918                	lw	a4,48(a0)
 16e:	fd4607b7          	lui	a5,0xfd460
 172:	15d78793          	addi	a5,a5,349 # fd46015d <.LFE21+0xfd45f94d>
 176:	eee7f6e3          	bgeu	a5,a4,62 <.L141>
 17a:	b779                	j	108 <.L134>

0000017c <.L157>:
 17c:	5d18                	lw	a4,56(a0)
 17e:	fd9007b7          	lui	a5,0xfd900
 182:	13878793          	addi	a5,a5,312 # fd900138 <.LFE21+0xfd8ff928>
 186:	eee7f5e3          	bgeu	a5,a4,70 <.L142>
 18a:	bfbd                	j	108 <.L134>

0000018c <.L158>:
 18c:	4138                	lw	a4,64(a0)
 18e:	fdda07b7          	lui	a5,0xfdda0
 192:	11378793          	addi	a5,a5,275 # fdda0113 <.LFE21+0xfdd9f903>
 196:	eee7f4e3          	bgeu	a5,a4,7e <.L143>
 19a:	b7bd                	j	108 <.L134>

0000019c <.L159>:
 19c:	4538                	lw	a4,72(a0)
 19e:	fe2407b7          	lui	a5,0xfe240
 1a2:	0ee78793          	addi	a5,a5,238 # fe2400ee <.LFE21+0xfe23f8de>
 1a6:	eee7f3e3          	bgeu	a5,a4,8c <.L144>
 1aa:	bfb9                	j	108 <.L134>

000001ac <.L160>:
 1ac:	4938                	lw	a4,80(a0)
 1ae:	fe6e07b7          	lui	a5,0xfe6e0
 1b2:	0c978793          	addi	a5,a5,201 # fe6e00c9 <.LFE21+0xfe6df8b9>
 1b6:	eee7f2e3          	bgeu	a5,a4,9a <.L145>
 1ba:	b7b9                	j	108 <.L134>

000001bc <.L162>:
 1bc:	5138                	lw	a4,96(a0)
 1be:	ff0207b7          	lui	a5,0xff020
 1c2:	07f78793          	addi	a5,a5,127 # ff02007f <.LFE21+0xff01f86f>
 1c6:	eee7f8e3          	bgeu	a5,a4,b6 <.L147>
 1ca:	bf3d                	j	108 <.L134>

000001cc <.L163>:
 1cc:	5538                	lw	a4,104(a0)
 1ce:	ff4c07b7          	lui	a5,0xff4c0
 1d2:	05a78793          	addi	a5,a5,90 # ff4c005a <.LFE21+0xff4bf84a>
 1d6:	eee7f7e3          	bgeu	a5,a4,c4 <.L148>
 1da:	b73d                	j	108 <.L134>

000001dc <.L164>:
 1dc:	5938                	lw	a4,112(a0)
 1de:	ff9607b7          	lui	a5,0xff960
 1e2:	03578793          	addi	a5,a5,53 # ff960035 <.LFE21+0xff95f825>
 1e6:	eee7f6e3          	bgeu	a5,a4,d2 <.L149>
 1ea:	bf39                	j	108 <.L134>

Disassembly of section .text.sparknacl__seminormal_gfPredicate:

00000000 <sparknacl__seminormal_gfPredicate>:
   0:	455c                	lw	a5,12(a0)
   2:	4110                	lw	a2,0(a0)
   4:	4154                	lw	a3,4(a0)
   6:	e7cd                	bnez	a5,b0 <.L186>
   8:	4518                	lw	a4,8(a0)
   a:	67c1                	lui	a5,0x10
   c:	0af77263          	bgeu	a4,a5,b0 <.L186>
  10:	4958                	lw	a4,20(a0)
  12:	ef59                	bnez	a4,b0 <.L186>
  14:	4918                	lw	a4,16(a0)
  16:	08f77d63          	bgeu	a4,a5,b0 <.L186>
  1a:	4d58                	lw	a4,28(a0)
  1c:	eb51                	bnez	a4,b0 <.L186>
  1e:	4d18                	lw	a4,24(a0)
  20:	08f77863          	bgeu	a4,a5,b0 <.L186>
  24:	5158                	lw	a4,36(a0)
  26:	e749                	bnez	a4,b0 <.L186>
  28:	5118                	lw	a4,32(a0)
  2a:	08f77363          	bgeu	a4,a5,b0 <.L186>
  2e:	5558                	lw	a4,44(a0)
  30:	e341                	bnez	a4,b0 <.L186>
  32:	5518                	lw	a4,40(a0)
  34:	06f77e63          	bgeu	a4,a5,b0 <.L186>
  38:	595c                	lw	a5,52(a0)
  3a:	ebbd                	bnez	a5,b0 <.L186>
  3c:	5918                	lw	a4,48(a0)
  3e:	67c1                	lui	a5,0x10
  40:	06f77863          	bgeu	a4,a5,b0 <.L186>
  44:	5d58                	lw	a4,60(a0)
  46:	e72d                	bnez	a4,b0 <.L186>
  48:	5d18                	lw	a4,56(a0)
  4a:	06f77363          	bgeu	a4,a5,b0 <.L186>
  4e:	4178                	lw	a4,68(a0)
  50:	e325                	bnez	a4,b0 <.L186>
  52:	4138                	lw	a4,64(a0)
  54:	04f77e63          	bgeu	a4,a5,b0 <.L186>
  58:	4578                	lw	a4,76(a0)
  5a:	eb39                	bnez	a4,b0 <.L186>
  5c:	4538                	lw	a4,72(a0)
  5e:	04f77963          	bgeu	a4,a5,b0 <.L186>
  62:	4978                	lw	a4,84(a0)
  64:	e731                	bnez	a4,b0 <.L186>
  66:	4938                	lw	a4,80(a0)
  68:	04f77463          	bgeu	a4,a5,b0 <.L186>
  6c:	4d7c                	lw	a5,92(a0)
  6e:	e3a9                	bnez	a5,b0 <.L186>
  70:	4d38                	lw	a4,88(a0)
  72:	67c1                	lui	a5,0x10
  74:	02f77e63          	bgeu	a4,a5,b0 <.L186>
  78:	5178                	lw	a4,100(a0)
  7a:	eb1d                	bnez	a4,b0 <.L186>
  7c:	5138                	lw	a4,96(a0)
  7e:	02f77963          	bgeu	a4,a5,b0 <.L186>
  82:	5578                	lw	a4,108(a0)
  84:	e715                	bnez	a4,b0 <.L186>
  86:	5538                	lw	a4,104(a0)
  88:	02f77463          	bgeu	a4,a5,b0 <.L186>
  8c:	5978                	lw	a4,116(a0)
  8e:	e30d                	bnez	a4,b0 <.L186>
  90:	5938                	lw	a4,112(a0)
  92:	00f77f63          	bgeu	a4,a5,b0 <.L186>
  96:	5d78                	lw	a4,124(a0)
  98:	ef01                	bnez	a4,b0 <.L186>
  9a:	5d38                	lw	a4,120(a0)
  9c:	00f77a63          	bgeu	a4,a5,b0 <.L186>
  a0:	4505                	li	a0,1
  a2:	e699                	bnez	a3,b0 <.L186>
  a4:	07def7b7          	lui	a5,0x7def
  a8:	04378793          	addi	a5,a5,67 # 7def043 <.LFE21+0x7dee833>
  ac:	00c7f363          	bgeu	a5,a2,b2 <.L167>

000000b0 <.L186>:
  b0:	4501                	li	a0,0

000000b2 <.L167>:
  b2:	8082                	ret

Disassembly of section .text.sparknacl__nearlynormal_gfPredicate:

00000000 <sparknacl__nearlynormal_gfPredicate>:
   0:	4558                	lw	a4,12(a0)
   2:	4114                	lw	a3,0(a0)
   4:	4150                	lw	a2,4(a0)
   6:	eb45                	bnez	a4,b6 <.L222>
   8:	4518                	lw	a4,8(a0)
   a:	67c1                	lui	a5,0x10
   c:	0af77563          	bgeu	a4,a5,b6 <.L222>
  10:	4958                	lw	a4,20(a0)
  12:	e355                	bnez	a4,b6 <.L222>
  14:	4918                	lw	a4,16(a0)
  16:	0af77063          	bgeu	a4,a5,b6 <.L222>
  1a:	4d58                	lw	a4,28(a0)
  1c:	ef49                	bnez	a4,b6 <.L222>
  1e:	4d18                	lw	a4,24(a0)
  20:	08f77b63          	bgeu	a4,a5,b6 <.L222>
  24:	5158                	lw	a4,36(a0)
  26:	eb41                	bnez	a4,b6 <.L222>
  28:	5118                	lw	a4,32(a0)
  2a:	08f77663          	bgeu	a4,a5,b6 <.L222>
  2e:	5558                	lw	a4,44(a0)
  30:	e359                	bnez	a4,b6 <.L222>
  32:	5518                	lw	a4,40(a0)
  34:	08f77163          	bgeu	a4,a5,b6 <.L222>
  38:	595c                	lw	a5,52(a0)
  3a:	efb5                	bnez	a5,b6 <.L222>
  3c:	591c                	lw	a5,48(a0)
  3e:	6741                	lui	a4,0x10
  40:	06e7fb63          	bgeu	a5,a4,b6 <.L222>
  44:	5d5c                	lw	a5,60(a0)
  46:	eba5                	bnez	a5,b6 <.L222>
  48:	5d1c                	lw	a5,56(a0)
  4a:	06e7f663          	bgeu	a5,a4,b6 <.L222>
  4e:	417c                	lw	a5,68(a0)
  50:	e3bd                	bnez	a5,b6 <.L222>
  52:	413c                	lw	a5,64(a0)
  54:	06e7f163          	bgeu	a5,a4,b6 <.L222>
  58:	457c                	lw	a5,76(a0)
  5a:	efb1                	bnez	a5,b6 <.L222>
  5c:	453c                	lw	a5,72(a0)
  5e:	04e7fc63          	bgeu	a5,a4,b6 <.L222>
  62:	497c                	lw	a5,84(a0)
  64:	eba9                	bnez	a5,b6 <.L222>
  66:	493c                	lw	a5,80(a0)
  68:	04e7f763          	bgeu	a5,a4,b6 <.L222>
  6c:	4d7c                	lw	a5,92(a0)
  6e:	e7a1                	bnez	a5,b6 <.L222>
  70:	4d3c                	lw	a5,88(a0)
  72:	04e7f263          	bgeu	a5,a4,b6 <.L222>
  76:	517c                	lw	a5,100(a0)
  78:	ef9d                	bnez	a5,b6 <.L222>
  7a:	513c                	lw	a5,96(a0)
  7c:	02e7fd63          	bgeu	a5,a4,b6 <.L222>
  80:	557c                	lw	a5,108(a0)
  82:	eb95                	bnez	a5,b6 <.L222>
  84:	553c                	lw	a5,104(a0)
  86:	02e7f863          	bgeu	a5,a4,b6 <.L222>
  8a:	597c                	lw	a5,116(a0)
  8c:	e78d                	bnez	a5,b6 <.L222>
  8e:	593c                	lw	a5,112(a0)
  90:	02e7f363          	bgeu	a5,a4,b6 <.L222>
  94:	5d7c                	lw	a5,124(a0)
  96:	e385                	bnez	a5,b6 <.L222>
  98:	5d3c                	lw	a5,120(a0)
  9a:	00e7fe63          	bgeu	a5,a4,b6 <.L222>
  9e:	02668713          	addi	a4,a3,38
  a2:	00d737b3          	sltu	a5,a4,a3
  a6:	97b2                	add	a5,a5,a2
  a8:	4505                	li	a0,1
  aa:	e791                	bnez	a5,b6 <.L222>
  ac:	67c1                	lui	a5,0x10
  ae:	04b78793          	addi	a5,a5,75 # 1004b <.LFE21+0xf83b>
  b2:	00e7f363          	bgeu	a5,a4,b8 <.L203>

000000b6 <.L222>:
  b6:	4501                	li	a0,0

000000b8 <.L203>:
  b8:	8082                	ret

Disassembly of section .text.sparknacl__asr_16:

00000000 <sparknacl__asr_16>:

   --  returns equivalent of X >> 16 in C, doing an arithmetic
   --  shift right when X is negative, assuming 2's complement
   --  representation
   function ASR_16 (X : in I64) return I64
   is (To_I64 (Shift_Right_Arithmetic (To_U64 (X), 16)))
   0:	01059793          	slli	a5,a1,0x10
   4:	8141                	srli	a0,a0,0x10

00000006 <.LVL1>:
   function ASR_16 (X : in I64) return I64
   6:	8d5d                	or	a0,a0,a5
   8:	85c1                	srai	a1,a1,0x10
   a:	8082                	ret

Disassembly of section .text.sparknacl__asr_8:

00000000 <sparknacl__asr_8>:

   --  returns equivalent of X >> 8 in C, doing an arithmetic
   --  shift right when X is negative, assuming 2's complement
   --  representation
   function ASR_8 (X : in I64) return I64
   is (To_I64 (Shift_Right_Arithmetic (To_U64 (X), 8)))
   0:	01859793          	slli	a5,a1,0x18
   4:	8121                	srli	a0,a0,0x8

00000006 <.LVL3>:
   function ASR_8 (X : in I64) return I64
   6:	8d5d                	or	a0,a0,a5
   8:	85a1                	srai	a1,a1,0x8
   a:	8082                	ret

Disassembly of section .text.sparknacl__asr_4:

00000000 <sparknacl__asr_4>:

   --  returns equivalent of X >> 4 in C, doing an arithmetic
   --  shift right when X is negative, assuming 2's complement
   --  representation
   function ASR_4 (X : in I64) return I64
   is (To_I64 (Shift_Right_Arithmetic (To_U64 (X), 4)))
   0:	01c59793          	slli	a5,a1,0x1c
   4:	8111                	srli	a0,a0,0x4

00000006 <.LVL5>:
   function ASR_4 (X : in I64) return I64
   6:	8d5d                	or	a0,a0,a5
   8:	8591                	srai	a1,a1,0x4
   a:	8082                	ret

Disassembly of section .text.sparknacl__square:

00000000 <sparknacl__square>:
     with Global => null;

   function "*" (Left, Right : in Normal_GF) return Normal_GF
     with Global => null;

   function Square (A : in Normal_GF) return Normal_GF
   0:	1141                	addi	sp,sp,-16
   2:	862e                	mv	a2,a1
   4:	c422                	sw	s0,8(sp)
   6:	c606                	sw	ra,12(sp)
   8:	842a                	mv	s0,a0
     is (A * A)
   a:	00000097          	auipc	ra,0x0
   e:	000080e7          	jalr	ra # a <sparknacl__square+0xa>

00000012 <.LVL7>:
   function Square (A : in Normal_GF) return Normal_GF
  12:	40b2                	lw	ra,12(sp)
  14:	8522                	mv	a0,s0
  16:	4422                	lw	s0,8(sp)
  18:	0141                	addi	sp,sp,16
  1a:	8082                	ret

Disassembly of section .text.sparknacl__Oadd:

00000000 <sparknacl__Oadd>:
is
   --===============================
   --  Exported subprogram bodies
   --===============================

   function "+" (Left, Right : in Normal_GF) return Normal_GF
   0:	7169                	addi	sp,sp,-304

00000002 <.LBB19>:
   is
      R : GF with Relaxed_Initialization;
   begin
      for I in Index_16 loop
         R (I) := Left (I) + Right (I);
   2:	4994                	lw	a3,16(a1)
   4:	4d98                	lw	a4,24(a1)
   6:	01062383          	lw	t2,16(a2)
   a:	01862283          	lw	t0,24(a2)

0000000e <.LBE19>:
   function "+" (Left, Right : in Normal_GF) return Normal_GF
   e:	12112623          	sw	ra,300(sp)
  12:	12812423          	sw	s0,296(sp)
  16:	12912223          	sw	s1,292(sp)
  1a:	11312e23          	sw	s3,284(sp)
  1e:	11412c23          	sw	s4,280(sp)

00000022 <.LBB20>:
         R (I) := Left (I) + Right (I);
  22:	4204                	lw	s1,0(a2)
  24:	0085af03          	lw	t5,8(a1)
  28:	519c                	lw	a5,32(a1)
  2a:	01462a03          	lw	s4,20(a2)
  2e:	4180                	lw	s0,0(a1)
  30:	00862083          	lw	ra,8(a2)
  34:	02062f83          	lw	t6,32(a2)
  38:	0145ae83          	lw	t4,20(a1)
  3c:	01c5ae03          	lw	t3,28(a1)
  40:	01c62983          	lw	s3,28(a2)

00000044 <.LBE20>:
   function "+" (Left, Right : in Normal_GF) return Normal_GF
  44:	13212023          	sw	s2,288(sp)
  48:	11512a23          	sw	s5,276(sp)
  4c:	11612823          	sw	s6,272(sp)

00000050 <.LBB21>:
         R (I) := Left (I) + Right (I);
  50:	00c62a83          	lw	s5,12(a2)
  54:	00462b03          	lw	s6,4(a2)
  58:	02462903          	lw	s2,36(a2)
  5c:	0045a883          	lw	a7,4(a1)
  60:	00c5a803          	lw	a6,12(a1)
  64:	0245a303          	lw	t1,36(a1)
  68:	93b6                	add	t2,t2,a3
  6a:	92ba                	add	t0,t0,a4
  6c:	9426                	add	s0,s0,s1
  6e:	90fa                	add	ra,ra,t5
  70:	9fbe                	add	t6,t6,a5
  72:	9ed2                	add	t4,t4,s4
  74:	9e4e                	add	t3,t3,s3
  76:	00d3b6b3          	sltu	a3,t2,a3
  7a:	00e2b733          	sltu	a4,t0,a4
  7e:	009434b3          	sltu	s1,s0,s1
  82:	01e0bf33          	sltu	t5,ra,t5
  86:	934a                	add	t1,t1,s2
  88:	96f6                	add	a3,a3,t4
  8a:	9772                	add	a4,a4,t3
  8c:	98da                	add	a7,a7,s6
  8e:	9856                	add	a6,a6,s5
  90:	00ffb7b3          	sltu	a5,t6,a5

00000094 <.LBE21>:
   function "+" (Left, Right : in Normal_GF) return Normal_GF
  94:	11712623          	sw	s7,268(sp)
  98:	11812423          	sw	s8,264(sp)
  9c:	11912223          	sw	s9,260(sp)

000000a0 <.LBB22>:
         R (I) := Left (I) + Right (I);
  a0:	98a6                	add	a7,a7,s1
  a2:	987a                	add	a6,a6,t5
  a4:	979a                	add	a5,a5,t1
  a6:	0285a303          	lw	t1,40(a1)
  aa:	02c5a983          	lw	s3,44(a1)
  ae:	0385af03          	lw	t5,56(a1)
  b2:	5604                	lw	s1,40(a2)
  b4:	c022                	sw	s0,0(sp)
  b6:	c406                	sw	ra,8(sp)
  b8:	5a00                	lw	s0,48(a2)
  ba:	03862083          	lw	ra,56(a2)
  be:	c81e                	sw	t2,16(sp)
  c0:	ca36                	sw	a3,20(sp)
  c2:	04062383          	lw	t2,64(a2)
  c6:	41b4                	lw	a3,64(a1)
  c8:	cc16                	sw	t0,24(sp)
  ca:	ce3a                	sw	a4,28(sp)
  cc:	04862283          	lw	t0,72(a2)
  d0:	45b8                	lw	a4,72(a1)
  d2:	d07e                	sw	t6,32(sp)
  d4:	0305af83          	lw	t6,48(a1)
  d8:	02c62c03          	lw	s8,44(a2)
  dc:	0345ab83          	lw	s7,52(a1)
  e0:	03c62b03          	lw	s6,60(a2)
  e4:	04462a83          	lw	s5,68(a2)
  e8:	04c62a03          	lw	s4,76(a2)
  ec:	0445ae83          	lw	t4,68(a1)
  f0:	04c5ae03          	lw	t3,76(a1)
  f4:	c246                	sw	a7,4(sp)

000000f6 <.LVL10>:
  f6:	c642                	sw	a6,12(sp)

000000f8 <.LVL11>:
  f8:	03462883          	lw	a7,52(a2)
  fc:	03c5a803          	lw	a6,60(a1)
 100:	949a                	add	s1,s1,t1
 102:	947e                	add	s0,s0,t6
 104:	90fa                	add	ra,ra,t5
 106:	93b6                	add	t2,t2,a3
 108:	92ba                	add	t0,t0,a4
 10a:	99e2                	add	s3,s3,s8
 10c:	01f43fb3          	sltu	t6,s0,t6
 110:	01e0bf33          	sltu	t5,ra,t5
 114:	9ed6                	add	t4,t4,s5
 116:	9e52                	add	t3,t3,s4
 118:	0064b333          	sltu	t1,s1,t1
 11c:	98de                	add	a7,a7,s7
 11e:	985a                	add	a6,a6,s6
 120:	00d3b6b3          	sltu	a3,t2,a3
 124:	00e2b733          	sltu	a4,t0,a4
 128:	0505a903          	lw	s2,80(a1)
 12c:	d23e                	sw	a5,36(sp)

0000012e <.LVL12>:
 12e:	934e                	add	t1,t1,s3
 130:	4a3c                	lw	a5,80(a2)
 132:	98fe                	add	a7,a7,t6
 134:	987a                	add	a6,a6,t5
 136:	96f6                	add	a3,a3,t4
 138:	9772                	add	a4,a4,t3
 13a:	d426                	sw	s1,40(sp)
 13c:	d61a                	sw	t1,44(sp)

0000013e <.LVL13>:
 13e:	0545ac03          	lw	s8,84(a1)
 142:	0585a303          	lw	t1,88(a1)
 146:	4a64                	lw	s1,84(a2)
 148:	05862f83          	lw	t6,88(a2)
 14c:	06062f03          	lw	t5,96(a2)
 150:	06862e83          	lw	t4,104(a2)
 154:	07062e03          	lw	t3,112(a2)
 158:	07862c83          	lw	s9,120(a2)
 15c:	da46                	sw	a7,52(sp)

0000015e <.LVL14>:
 15e:	de42                	sw	a6,60(sp)

00000160 <.LVL15>:
 160:	0605a883          	lw	a7,96(a1)
 164:	0685a803          	lw	a6,104(a1)
 168:	c2b6                	sw	a3,68(sp)

0000016a <.LVL16>:
 16a:	c6ba                	sw	a4,76(sp)

0000016c <.LVL17>:
 16c:	59b4                	lw	a3,112(a1)
 16e:	5db8                	lw	a4,120(a1)
 170:	05c5ab83          	lw	s7,92(a1)
 174:	06c62a83          	lw	s5,108(a2)
 178:	07462a03          	lw	s4,116(a2)
 17c:	07c62983          	lw	s3,124(a2)
 180:	0645ab03          	lw	s6,100(a1)
 184:	d822                	sw	s0,48(sp)
 186:	dc06                	sw	ra,56(sp)
 188:	5260                	lw	s0,100(a2)
 18a:	05c62083          	lw	ra,92(a2)
 18e:	c09e                	sw	t2,64(sp)
 190:	c496                	sw	t0,72(sp)
 192:	06c5a383          	lw	t2,108(a1)
 196:	0745a283          	lw	t0,116(a1)
 19a:	5dec                	lw	a1,124(a1)

0000019c <.LVL18>:
 19c:	97ca                	add	a5,a5,s2
 19e:	01970633          	add	a2,a4,s9

000001a2 <.LVL19>:
 1a2:	9f9a                	add	t6,t6,t1
 1a4:	9f46                	add	t5,t5,a7
 1a6:	9ec2                	add	t4,t4,a6
 1a8:	9e36                	add	t3,t3,a3
 1aa:	c8be                	sw	a5,80(sp)
 1ac:	94e2                	add	s1,s1,s8
 1ae:	0127b7b3          	sltu	a5,a5,s2
 1b2:	90de                	add	ra,ra,s7
 1b4:	93d6                	add	t2,t2,s5
 1b6:	92d2                	add	t0,t0,s4
 1b8:	97a6                	add	a5,a5,s1
 1ba:	006fb333          	sltu	t1,t6,t1
 1be:	011f38b3          	sltu	a7,t5,a7
 1c2:	9b22                	add	s6,s6,s0
 1c4:	010eb833          	sltu	a6,t4,a6
 1c8:	00de36b3          	sltu	a3,t3,a3
 1cc:	00e63733          	sltu	a4,a2,a4
 1d0:	95ce                	add	a1,a1,s3

000001d2 <.LBE22>:
   function "+" (Left, Right : in Normal_GF) return Normal_GF
 1d2:	842a                	mv	s0,a0

000001d4 <.LBB23>:
         R (I) := Left (I) + Right (I);
 1d4:	9306                	add	t1,t1,ra
 1d6:	98da                	add	a7,a7,s6
 1d8:	972e                	add	a4,a4,a1
 1da:	cabe                	sw	a5,84(sp)

000001dc <.LVL20>:
 1dc:	981e                	add	a6,a6,t2
 1de:	9696                	add	a3,a3,t0

000001e0 <.LBE23>:
      --
      --  In future, it might be possible to remove normalization here
      --  if the functions in SPARKNaCl.Car can be proven to handle the
      --  larger range of limbs that result.  TBD.
      return Car.Nearlynormal_To_Normal
        (Car.Sum_To_Nearlynormal (R));
 1e0:	858a                	mv	a1,sp
 1e2:	0108                	addi	a0,sp,128

000001e4 <.LBB24>:
         R (I) := Left (I) + Right (I);
 1e4:	ccfe                	sw	t6,88(sp)
 1e6:	ce9a                	sw	t1,92(sp)

000001e8 <.LVL22>:
 1e8:	d0fa                	sw	t5,96(sp)
 1ea:	d2c6                	sw	a7,100(sp)

000001ec <.LVL23>:
 1ec:	d4f6                	sw	t4,104(sp)
 1ee:	d6c2                	sw	a6,108(sp)

000001f0 <.LVL24>:
 1f0:	d8f2                	sw	t3,112(sp)
 1f2:	dab6                	sw	a3,116(sp)

000001f4 <.LVL25>:
 1f4:	dcb2                	sw	a2,120(sp)
 1f6:	deba                	sw	a4,124(sp)

000001f8 <.LBE24>:
        (Car.Sum_To_Nearlynormal (R));
 1f8:	00000097          	auipc	ra,0x0
 1fc:	000080e7          	jalr	ra # 1f8 <.LBE24>

00000200 <.LVL26>:
      return Car.Nearlynormal_To_Normal
 200:	8522                	mv	a0,s0
 202:	010c                	addi	a1,sp,128
 204:	00000097          	auipc	ra,0x0
 208:	000080e7          	jalr	ra # 204 <.LVL26+0x4>

0000020c <.LVL27>:
   end "+";
 20c:	12c12083          	lw	ra,300(sp)
 210:	8522                	mv	a0,s0
 212:	12812403          	lw	s0,296(sp)
 216:	12412483          	lw	s1,292(sp)
 21a:	12012903          	lw	s2,288(sp)
 21e:	11c12983          	lw	s3,284(sp)
 222:	11812a03          	lw	s4,280(sp)
 226:	11412a83          	lw	s5,276(sp)
 22a:	11012b03          	lw	s6,272(sp)
 22e:	10c12b83          	lw	s7,268(sp)
 232:	10812c03          	lw	s8,264(sp)
 236:	10412c83          	lw	s9,260(sp)
 23a:	6155                	addi	sp,sp,304
 23c:	8082                	ret

Disassembly of section .text.sparknacl__Osubtract:

00000000 <sparknacl__Osubtract>:

   function "-" (Left, Right : in Normal_GF) return Normal_GF
   0:	710d                	addi	sp,sp,-352
   2:	14912a23          	sw	s1,340(sp)
   6:	15512223          	sw	s5,324(sp)

0000000a <.LBB25>:

      for I in Index_16 range 1 .. 15 loop
         --  Having added LM to the previous limb, we also add LM to
         --  each new limb, but subtract 1 to account for the extra LM from
         --  the earlier limb
         R (I) := (Left (I) - Right (I)) + LMM1;
   a:	4604                	lw	s1,8(a2)
   c:	0085aa83          	lw	s5,8(a1)

00000010 <.LBE25>:
   function "-" (Left, Right : in Normal_GF) return Normal_GF
  10:	15212823          	sw	s2,336(sp)

00000014 <.LBB26>:
         R (I) := (Left (I) - Right (I)) + LMM1;
  14:	0185ae03          	lw	t3,24(a1)
  18:	00c62903          	lw	s2,12(a2)
  1c:	4e14                	lw	a3,24(a2)
  1e:	00c5a883          	lw	a7,12(a1)

00000022 <.LBE26>:
   function "-" (Left, Right : in Normal_GF) return Normal_GF
  22:	13712e23          	sw	s7,316(sp)

00000026 <.LBB27>:
         R (I) := (Left (I) - Right (I)) + LMM1;
  26:	01c62e83          	lw	t4,28(a2)
  2a:	01c5ab83          	lw	s7,28(a1)
  2e:	67c1                	lui	a5,0x10
  30:	17fd                	addi	a5,a5,-1
  32:	409a84b3          	sub	s1,s5,s1

00000036 <.LBE27>:
   function "-" (Left, Right : in Normal_GF) return Normal_GF
  36:	14112e23          	sw	ra,348(sp)

0000003a <.LBB28>:
         R (I) := (Left (I) - Right (I)) + LMM1;
  3a:	40de06b3          	sub	a3,t3,a3
  3e:	00f480b3          	add	ra,s1,a5
  42:	009abab3          	sltu	s5,s5,s1
  46:	412888b3          	sub	a7,a7,s2

0000004a <.LBE28>:
   function "-" (Left, Right : in Normal_GF) return Normal_GF
  4a:	15312623          	sw	s3,332(sp)

0000004e <.LBB29>:
         R (I) := (Left (I) - Right (I)) + LMM1;
  4e:	00f682b3          	add	t0,a3,a5
  52:	0205a983          	lw	s3,32(a1)
  56:	41588933          	sub	s2,a7,s5
  5a:	5218                	lw	a4,32(a2)
  5c:	00de3e33          	sltu	t3,t3,a3
  60:	0090b8b3          	sltu	a7,ra,s1
  64:	41db8eb3          	sub	t4,s7,t4

00000068 <.LBE29>:
   function "-" (Left, Right : in Normal_GF) return Normal_GF
  68:	14812c23          	sw	s0,344(sp)
  6c:	15412423          	sw	s4,328(sp)
  70:	15612023          	sw	s6,320(sp)
  74:	13812c23          	sw	s8,312(sp)
  78:	13912a23          	sw	s9,308(sp)
  7c:	13a12823          	sw	s10,304(sp)
  80:	13b12623          	sw	s11,300(sp)

00000084 <.LBB30>:
         R (I) := (Left (I) - Right (I)) + LMM1;
  84:	0245ab03          	lw	s6,36(a1)
  88:	02462303          	lw	t1,36(a2)
  8c:	41ce8eb3          	sub	t4,t4,t3
  90:	98ca                	add	a7,a7,s2
  92:	d406                	sw	ra,40(sp)
  94:	00d2b6b3          	sltu	a3,t0,a3
  98:	0105aa03          	lw	s4,16(a1)
  9c:	0145ac03          	lw	s8,20(a1)
  a0:	0285ad83          	lw	s11,40(a1)
  a4:	01062803          	lw	a6,16(a2)
  a8:	01462f03          	lw	t5,20(a2)
  ac:	5600                	lw	s0,40(a2)
  ae:	96f6                	add	a3,a3,t4
  b0:	d646                	sw	a7,44(sp)
  b2:	05462e83          	lw	t4,84(a2)
  b6:	40e98733          	sub	a4,s3,a4
  ba:	00f70fb3          	add	t6,a4,a5
  be:	00e9b9b3          	sltu	s3,s3,a4
  c2:	406b0333          	sub	t1,s6,t1
  c6:	02c5a083          	lw	ra,44(a1)
  ca:	41330333          	sub	t1,t1,s3
  ce:	8e76                	mv	t3,t4
  d0:	00efb733          	sltu	a4,t6,a4
  d4:	02c62e83          	lw	t4,44(a2)
  d8:	410a0833          	sub	a6,s4,a6
  dc:	971a                	add	a4,a4,t1
  de:	00f803b3          	add	t2,a6,a5
  e2:	c2ba                	sw	a4,68(sp)

000000e4 <.LBE30>:
      R (0) := (Left (0) - Right (0)) + LM;
  e4:	4218                	lw	a4,0(a2)
  e6:	0045a903          	lw	s2,4(a1)

000000ea <.LBB31>:
         R (I) := (Left (I) - Right (I)) + LMM1;
  ea:	010a3a33          	sltu	s4,s4,a6
  ee:	d81e                	sw	t2,48(sp)
  f0:	de36                	sw	a3,60(sp)
  f2:	41ec0f33          	sub	t5,s8,t5

000000f6 <.LBE31>:
      R (0) := (Left (0) - Right (0)) + LM;
  f6:	4254                	lw	a3,4(a2)

000000f8 <.LBB32>:
         R (I) := (Left (I) - Right (I)) + LMM1;
  f8:	0103b833          	sltu	a6,t2,a6
  fc:	41d080b3          	sub	ra,ra,t4
 100:	0345a383          	lw	t2,52(a1)
 104:	03462e83          	lw	t4,52(a2)
 108:	408d8433          	sub	s0,s11,s0
 10c:	414f0f33          	sub	t5,t5,s4
 110:	987a                	add	a6,a6,t5

00000112 <.LBE32>:
      R (0) := (Left (0) - Right (0)) + LM;
 112:	c83a                	sw	a4,16(sp)

00000114 <.LBB33>:
         R (I) := (Left (I) - Right (I)) + LMM1;
 114:	00f40733          	add	a4,s0,a5

00000118 <.LBE33>:
      R (0) := (Left (0) - Right (0)) + LM;
 118:	0005ab83          	lw	s7,0(a1)

0000011c <.LBB34>:
         R (I) := (Left (I) - Right (I)) + LMM1;
 11c:	0305aa83          	lw	s5,48(a1)
 120:	0385aa03          	lw	s4,56(a1)
 124:	0405a983          	lw	s3,64(a1)
 128:	49a4                	lw	s1,80(a1)
 12a:	03062303          	lw	t1,48(a2)
 12e:	03862883          	lw	a7,56(a2)
 132:	04c62f03          	lw	t5,76(a2)
 136:	da42                	sw	a6,52(sp)
 138:	dc16                	sw	t0,56(sp)
 13a:	04062803          	lw	a6,64(a2)
 13e:	03c5a283          	lw	t0,60(a1)
 142:	c0fe                	sw	t6,64(sp)

00000144 <.LBE34>:
      R (0) := (Left (0) - Right (0)) + LM;
 144:	c64a                	sw	s2,12(sp)

00000146 <.LBB35>:
         R (I) := (Left (I) - Right (I)) + LMM1;
 146:	04462f83          	lw	t6,68(a2)
 14a:	0485a903          	lw	s2,72(a1)

0000014e <.LBE35>:
      R (0) := (Left (0) - Right (0)) + LM;
 14e:	ca36                	sw	a3,20(sp)

00000150 <.LBB36>:
         R (I) := (Left (I) - Right (I)) + LMM1;
 150:	c4ba                	sw	a4,72(sp)
 152:	4634                	lw	a3,72(a2)
 154:	4a38                	lw	a4,80(a2)
 156:	41d383b3          	sub	t2,t2,t4
 15a:	03c62e83          	lw	t4,60(a2)
 15e:	411a08b3          	sub	a7,s4,a7
 162:	00f88cb3          	add	s9,a7,a5
 166:	41d282b3          	sub	t0,t0,t4
 16a:	0445ae83          	lw	t4,68(a1)
 16e:	406a8333          	sub	t1,s5,t1
 172:	41098833          	sub	a6,s3,a6
 176:	41fe8fb3          	sub	t6,t4,t6
 17a:	04c5ae83          	lw	t4,76(a1)
 17e:	40d906b3          	sub	a3,s2,a3
 182:	40e48733          	sub	a4,s1,a4
 186:	41ee8f33          	sub	t5,t4,t5
 18a:	0545ae83          	lw	t4,84(a1)
 18e:	011a3a33          	sltu	s4,s4,a7
 192:	00f30d33          	add	s10,t1,a5
 196:	41ce8eb3          	sub	t4,t4,t3
 19a:	00f40e33          	add	t3,s0,a5
 19e:	00f80c33          	add	s8,a6,a5
 1a2:	00f70b33          	add	s6,a4,a5
 1a6:	008dbdb3          	sltu	s11,s11,s0
 1aa:	006abab3          	sltu	s5,s5,t1
 1ae:	0109b9b3          	sltu	s3,s3,a6
 1b2:	00d93933          	sltu	s2,s2,a3
 1b6:	00e4b4b3          	sltu	s1,s1,a4
 1ba:	008e3e33          	sltu	t3,t3,s0
 1be:	011cb8b3          	sltu	a7,s9,a7
 1c2:	00f68433          	add	s0,a3,a5
 1c6:	414282b3          	sub	t0,t0,s4
 1ca:	006d3333          	sltu	t1,s10,t1
 1ce:	010c3833          	sltu	a6,s8,a6
 1d2:	00d436b3          	sltu	a3,s0,a3
 1d6:	00eb3733          	sltu	a4,s6,a4
 1da:	92c6                	add	t0,t0,a7
 1dc:	41b080b3          	sub	ra,ra,s11
 1e0:	0745a883          	lw	a7,116(a1)
 1e4:	415383b3          	sub	t2,t2,s5
 1e8:	413f8fb3          	sub	t6,t6,s3
 1ec:	412f0f33          	sub	t5,t5,s2
 1f0:	409e8eb3          	sub	t4,t4,s1
 1f4:	90f2                	add	ra,ra,t3
 1f6:	939a                	add	t2,t2,t1
 1f8:	9fc2                	add	t6,t6,a6
 1fa:	9f36                	add	t5,t5,a3
 1fc:	9eba                	add	t4,t4,a4
 1fe:	c686                	sw	ra,76(sp)
 200:	c8ea                	sw	s10,80(sp)
 202:	ca9e                	sw	t2,84(sp)
 204:	cce6                	sw	s9,88(sp)
 206:	ce96                	sw	t0,92(sp)
 208:	d0e2                	sw	s8,96(sp)
 20a:	d2fe                	sw	t6,100(sp)
 20c:	d4a2                	sw	s0,104(sp)
 20e:	d6fa                	sw	t5,108(sp)
 210:	d8da                	sw	s6,112(sp)
 212:	daf6                	sw	t4,116(sp)
 214:	4da4                	lw	s1,88(a1)
 216:	05c5ad83          	lw	s11,92(a1)
 21a:	51a0                	lw	s0,96(a1)
 21c:	0685a083          	lw	ra,104(a1)
 220:	0705a383          	lw	t2,112(a1)
 224:	0785a283          	lw	t0,120(a1)
 228:	06062903          	lw	s2,96(a2)
 22c:	06862f83          	lw	t6,104(a2)
 230:	0645ad03          	lw	s10,100(a1)
 234:	06c5ac83          	lw	s9,108(a1)
 238:	05862803          	lw	a6,88(a2)
 23c:	5a34                	lw	a3,112(a2)
 23e:	5e38                	lw	a4,120(a2)
 240:	05c62f03          	lw	t5,92(a2)
 244:	06462e83          	lw	t4,100(a2)
 248:	06c62e03          	lw	t3,108(a2)
 24c:	cc46                	sw	a7,24(sp)
 24e:	07462303          	lw	t1,116(a2)
 252:	5dec                	lw	a1,124(a1)

00000254 <.LVL30>:
 254:	07c62c03          	lw	s8,124(a2)

00000258 <.LBE36>:
      R (0) := (Left (0) - Right (0)) + LM;
 258:	4642                	lw	a2,16(sp)

0000025a <.LBB37>:
         R (I) := (Left (I) - Right (I)) + LMM1;
 25a:	ce2e                	sw	a1,28(sp)
 25c:	41048833          	sub	a6,s1,a6

00000260 <.LBE37>:
      R (0) := (Left (0) - Right (0)) + LM;
 260:	40cb88b3          	sub	a7,s7,a2

00000264 <.LBB38>:
         R (I) := (Left (I) - Right (I)) + LMM1;
 264:	412405b3          	sub	a1,s0,s2
 268:	41f08633          	sub	a2,ra,t6
 26c:	40d386b3          	sub	a3,t2,a3
 270:	40e28733          	sub	a4,t0,a4
 274:	00f80b33          	add	s6,a6,a5
 278:	00f58ab3          	add	s5,a1,a5
 27c:	00f60a33          	add	s4,a2,a5
 280:	00f689b3          	add	s3,a3,a5
 284:	97ba                	add	a5,a5,a4
 286:	cd3e                	sw	a5,152(sp)

00000288 <.LBE38>:
      R (0) := (Left (0) - Right (0)) + LM;
 288:	4932                	lw	s2,12(sp)
 28a:	47d2                	lw	a5,20(sp)

      --  We now need to carry -1 into limb R (16), but that doesn't
      --  exist, so we carry 2**256 * -1 into limb R (0). As before,
      --  we know that (2**256) mod (2**255 - 19) = R2256, so we add
      --  R2256 * -1 to R (0)
      R (0) := R (0) - R2256;
 28c:	6fc1                	lui	t6,0x10
 28e:	fdaf8f93          	addi	t6,t6,-38 # ffda <.LFE21+0xf7ca>
      R (0) := (Left (0) - Right (0)) + LM;
 292:	40f90933          	sub	s2,s2,a5

00000296 <.LBB39>:
         R (I) := (Left (I) - Right (I)) + LMM1;
 296:	47e2                	lw	a5,24(sp)

00000298 <.LBE39>:
      R (0) := R (0) - R2256;
 298:	9fc6                	add	t6,t6,a7

0000029a <.LBB40>:
         R (I) := (Left (I) - Right (I)) + LMM1;
 29a:	41ed8f33          	sub	t5,s11,t5
 29e:	40678333          	sub	t1,a5,t1
 2a2:	47f2                	lw	a5,28(sp)
 2a4:	41dd0eb3          	sub	t4,s10,t4
 2a8:	41cc8e33          	sub	t3,s9,t3
 2ac:	41878c33          	sub	s8,a5,s8
 2b0:	47ea                	lw	a5,152(sp)
 2b2:	00d3b3b3          	sltu	t2,t2,a3

000002b6 <.LBE40>:
      R (0) := (Left (0) - Right (0)) + LM;
 2b6:	011bbbb3          	sltu	s7,s7,a7

000002ba <.LBB41>:
         R (I) := (Left (I) - Right (I)) + LMM1;
 2ba:	0104b4b3          	sltu	s1,s1,a6
 2be:	00b43433          	sltu	s0,s0,a1
 2c2:	00c0b0b3          	sltu	ra,ra,a2
 2c6:	00e2b2b3          	sltu	t0,t0,a4
 2ca:	010b3833          	sltu	a6,s6,a6
 2ce:	00ca3633          	sltu	a2,s4,a2
 2d2:	405c02b3          	sub	t0,s8,t0
 2d6:	409f04b3          	sub	s1,t5,s1
 2da:	408e8433          	sub	s0,t4,s0
 2de:	00bab5b3          	sltu	a1,s5,a1
 2e2:	401e00b3          	sub	ra,t3,ra
 2e6:	40730333          	sub	t1,t1,t2
 2ea:	00e7b733          	sltu	a4,a5,a4

000002ee <.LBE41>:
      R (0) := R (0) - R2256;
 2ee:	011fb8b3          	sltu	a7,t6,a7
      R (0) := (Left (0) - Right (0)) + LM;
 2f2:	41790933          	sub	s2,s2,s7

000002f6 <.LBB42>:
         R (I) := (Left (I) - Right (I)) + LMM1;
 2f6:	00d9b6b3          	sltu	a3,s3,a3

000002fa <.LBE42>:
   function "-" (Left, Right : in Normal_GF) return Normal_GF
 2fa:	8c2a                	mv	s8,a0

000002fc <.LBB43>:
         R (I) := (Left (I) - Right (I)) + LMM1;
 2fc:	94c2                	add	s1,s1,a6
 2fe:	90b2                	add	ra,ra,a2

00000300 <.LBE43>:
      R (0) := R (0) - R2256;
 300:	9946                	add	s2,s2,a7

00000302 <.LBB44>:
         R (I) := (Left (I) - Right (I)) + LMM1;
 302:	942e                	add	s0,s0,a1
 304:	969a                	add	a3,a3,t1
 306:	9716                	add	a4,a4,t0

00000308 <.LBE44>:
      --
      --  In future, it might be possible to remove normalization here
      --  if the functions in SPARKNaCl.Car can be proven to handle the
      --  larger range of limbs that result.  TBD.
      return Car.Nearlynormal_To_Normal
        (Car.Difference_To_Nearlynormal (R));
 308:	100c                	addi	a1,sp,32
 30a:	1108                	addi	a0,sp,160

0000030c <.LBB45>:
         R (I) := (Left (I) - Right (I)) + LMM1;
 30c:	c706                	sw	ra,140(sp)
 30e:	dcda                	sw	s6,120(sp)
 310:	dea6                	sw	s1,124(sp)

00000312 <.LVL34>:
 312:	c156                	sw	s5,128(sp)
 314:	c322                	sw	s0,132(sp)

00000316 <.LVL35>:
 316:	c552                	sw	s4,136(sp)
 318:	c94e                	sw	s3,144(sp)
 31a:	cb36                	sw	a3,148(sp)

0000031c <.LVL36>:
 31c:	cf3a                	sw	a4,156(sp)

0000031e <.LBE45>:
      R (0) := R (0) - R2256;
 31e:	d07e                	sw	t6,32(sp)
 320:	d24a                	sw	s2,36(sp)
        (Car.Difference_To_Nearlynormal (R));
 322:	00000097          	auipc	ra,0x0
 326:	000080e7          	jalr	ra # 322 <.LBE45+0x4>

0000032a <.LVL37>:
      return Car.Nearlynormal_To_Normal
 32a:	8562                	mv	a0,s8
 32c:	110c                	addi	a1,sp,160
 32e:	00000097          	auipc	ra,0x0
 332:	000080e7          	jalr	ra # 32e <.LVL37+0x4>

00000336 <.LVL38>:
   end "-";
 336:	15c12083          	lw	ra,348(sp)
 33a:	15812403          	lw	s0,344(sp)
 33e:	15412483          	lw	s1,340(sp)
 342:	15012903          	lw	s2,336(sp)
 346:	14c12983          	lw	s3,332(sp)
 34a:	14812a03          	lw	s4,328(sp)
 34e:	14412a83          	lw	s5,324(sp)
 352:	14012b03          	lw	s6,320(sp)
 356:	13c12b83          	lw	s7,316(sp)
 35a:	13412c83          	lw	s9,308(sp)
 35e:	13012d03          	lw	s10,304(sp)
 362:	12c12d83          	lw	s11,300(sp)
 366:	8562                	mv	a0,s8
 368:	13812c03          	lw	s8,312(sp)
 36c:	6135                	addi	sp,sp,352
 36e:	8082                	ret

Disassembly of section .text.sparknacl__equal:

00000000 <sparknacl__equal>:

   --------------------------------------------------------
   --  Constant time equality test
   --------------------------------------------------------

   function Equal (X, Y : in Byte_Seq) return Boolean
   0:	0005a803          	lw	a6,0(a1)
   4:	0045a883          	lw	a7,4(a1)

00000008 <.LVL41>:
   is
      D : Boolean := True;
   begin
      for I in N32 range X'Range loop
   8:	0308ca63          	blt	a7,a6,3c <.L250>
   c:	429c                	lw	a5,0(a3)
   e:	00150593          	addi	a1,a0,1

00000012 <.LVL42>:
  12:	95c6                	add	a1,a1,a7
  14:	40f807b3          	sub	a5,a6,a5
  18:	872a                	mv	a4,a0
  1a:	963e                	add	a2,a2,a5

0000001c <.LVL43>:
  1c:	410585b3          	sub	a1,a1,a6
      D : Boolean := True;
  20:	4505                	li	a0,1

00000022 <.L249>:
         D := D and (X (I) = Y (I));
  22:	00074783          	lbu	a5,0(a4) # 10000 <.LFE21+0xf7f0>
  26:	00064683          	lbu	a3,0(a2)
      for I in N32 range X'Range loop
  2a:	0705                	addi	a4,a4,1
  2c:	0605                	addi	a2,a2,1
         D := D and (X (I) = Y (I));
  2e:	8f95                	sub	a5,a5,a3
  30:	0017b793          	seqz	a5,a5
  34:	8d7d                	and	a0,a0,a5
      for I in N32 range X'Range loop
  36:	feb716e3          	bne	a4,a1,22 <.L249>
  3a:	8082                	ret

0000003c <.L250>:
      D : Boolean := True;
  3c:	4505                	li	a0,1

0000003e <.LVL47>:
         pragma Loop_Invariant
           (D = (for all J in N32 range X'First .. I => X (J) = Y (J)));
      end loop;

      return D;
   end Equal;
  3e:	8082                	ret

Disassembly of section .text.sparknacl__random_bytes:

00000000 <sparknacl__random_bytes>:

   --------------------------------------------------------
   --  RNG
   --------------------------------------------------------

   procedure Random_Bytes (R : out Byte_Seq)
   0:	419c                	lw	a5,0(a1)
   2:	41d8                	lw	a4,4(a1)

00000004 <.LVL49>:
   is
   begin
      for I in R'Range loop
   4:	02f74963          	blt	a4,a5,36 <.L258>
   procedure Random_Bytes (R : out Byte_Seq)
   8:	1141                	addi	sp,sp,-16
   a:	c226                	sw	s1,4(sp)
   c:	00150493          	addi	s1,a0,1

00000010 <.LVL50>:
  10:	94ba                	add	s1,s1,a4
  12:	c422                	sw	s0,8(sp)
  14:	c606                	sw	ra,12(sp)

00000016 <.LVL51>:
  16:	842a                	mv	s0,a0
  18:	8c9d                	sub	s1,s1,a5

0000001a <.L254>:
         R (I) := Random.Random_Byte;
  1a:	00000097          	auipc	ra,0x0
  1e:	000080e7          	jalr	ra # 1a <.L254>

00000022 <.LVL53>:
  22:	00a40023          	sb	a0,0(s0)
      for I in R'Range loop
  26:	0405                	addi	s0,s0,1
  28:	fe9419e3          	bne	s0,s1,1a <.L254>

0000002c <.LBE47>:
      end loop;
   end Random_Bytes;
  2c:	40b2                	lw	ra,12(sp)
  2e:	4422                	lw	s0,8(sp)
  30:	4492                	lw	s1,4(sp)
  32:	0141                	addi	sp,sp,16
  34:	8082                	ret

00000036 <.L258>:
  36:	8082                	ret

Disassembly of section .text.sparknacl__sanitize:

00000000 <sparknacl__sanitize>:
separate (SPARKNaCl)
procedure Sanitize (R : out Byte_Seq) is
   0:	4198                	lw	a4,0(a1)
   2:	41dc                	lw	a5,4(a1)
   4:	1141                	addi	sp,sp,-16
   6:	c422                	sw	s0,8(sp)
   8:	c606                	sw	ra,12(sp)
   a:	842a                	mv	s0,a0

0000000c <.LVL56>:
   c:	4601                	li	a2,0
begin
   R := (others => 0);
   e:	00e7c563          	blt	a5,a4,18 <.L262>
  12:	0785                	addi	a5,a5,1
  14:	40e78633          	sub	a2,a5,a4

00000018 <.L262>:
  18:	4581                	li	a1,0

0000001a <.LVL59>:
  1a:	8522                	mv	a0,s0
  1c:	00000097          	auipc	ra,0x0
  20:	000080e7          	jalr	ra # 1c <.LVL59+0x2>

00000024 <.LVL60>:

   --  Add target-dependent code here to
   --  1. flush and invalidate data cache,
   --  2. wait until writes have committed (e.g. a memory-fence instruction)
   --  3. whatever else is required.
end Sanitize;
  24:	40b2                	lw	ra,12(sp)
  26:	4422                	lw	s0,8(sp)
  28:	0141                	addi	sp,sp,16
  2a:	8082                	ret

Disassembly of section .text.sparknacl__sanitize_u64:

00000000 <sparknacl__sanitize_u64>:
separate (SPARKNaCl)
procedure Sanitize_U64 (R : out U64) is
   0:	1141                	addi	sp,sp,-16
begin
   R := 0;
   2:	4781                	li	a5,0
   4:	4801                	li	a6,0
   6:	c43e                	sw	a5,8(sp)
   8:	c642                	sw	a6,12(sp)

   --  Add target-dependent code here to
   --  1. flush and invalidate data cache,
   --  2. wait until writes have committed (e.g. a memory-fence instruction)
   --  3. whatever else is required.
end Sanitize_U64;
   a:	4501                	li	a0,0
   c:	4581                	li	a1,0
   e:	0141                	addi	sp,sp,16
  10:	8082                	ret

Disassembly of section .text.sparknacl__sanitize_gf:

00000000 <sparknacl__sanitize_gf>:
separate (SPARKNaCl)
procedure Sanitize_GF (R : out GF) is
begin
   R := GF'(others => 0);
   0:	4781                	li	a5,0
   2:	4801                	li	a6,0
   4:	c11c                	sw	a5,0(a0)
   6:	01052223          	sw	a6,4(a0)
   a:	c51c                	sw	a5,8(a0)
   c:	01052623          	sw	a6,12(a0)
  10:	c91c                	sw	a5,16(a0)
  12:	01052a23          	sw	a6,20(a0)
  16:	cd1c                	sw	a5,24(a0)
  18:	01052e23          	sw	a6,28(a0)
  1c:	d11c                	sw	a5,32(a0)
  1e:	03052223          	sw	a6,36(a0)
  22:	d51c                	sw	a5,40(a0)
  24:	03052623          	sw	a6,44(a0)
  28:	d91c                	sw	a5,48(a0)
  2a:	03052a23          	sw	a6,52(a0)
  2e:	dd1c                	sw	a5,56(a0)
  30:	03052e23          	sw	a6,60(a0)
  34:	c13c                	sw	a5,64(a0)
  36:	05052223          	sw	a6,68(a0)
  3a:	c53c                	sw	a5,72(a0)
  3c:	05052623          	sw	a6,76(a0)
  40:	c93c                	sw	a5,80(a0)
  42:	05052a23          	sw	a6,84(a0)
  46:	cd3c                	sw	a5,88(a0)
  48:	05052e23          	sw	a6,92(a0)
  4c:	d13c                	sw	a5,96(a0)
  4e:	07052223          	sw	a6,100(a0)
  52:	d53c                	sw	a5,104(a0)
  54:	07052623          	sw	a6,108(a0)
  58:	d93c                	sw	a5,112(a0)
  5a:	07052a23          	sw	a6,116(a0)
  5e:	dd3c                	sw	a5,120(a0)
  60:	07052e23          	sw	a6,124(a0)

   --  Add target-dependent code here to
   --  1. flush and invalidate data cache,
   --  2. wait until writes have committed (e.g. a memory-fence instruction)
   --  3. whatever else is required.
end Sanitize_GF;
  64:	8082                	ret

Disassembly of section .text.sparknacl__sanitize_gf_pa:

00000000 <sparknacl__sanitize_gf_pa>:
separate (SPARKNaCl)
procedure Sanitize_GF_PA (R : out GF_PA) is
   0:	1141                	addi	sp,sp,-16
begin
   R := GF_PA'(others => 0);
   2:	0f800613          	li	a2,248
   6:	4581                	li	a1,0
procedure Sanitize_GF_PA (R : out GF_PA) is
   8:	c422                	sw	s0,8(sp)
   a:	c606                	sw	ra,12(sp)
   c:	842a                	mv	s0,a0
   R := GF_PA'(others => 0);
   e:	00000097          	auipc	ra,0x0
  12:	000080e7          	jalr	ra # e <sparknacl__sanitize_gf_pa+0xe>

00000016 <.LVL63>:

   --  Add target-dependent code here to
   --  1. flush and invalidate data cache,
   --  2. wait until writes have committed (e.g. a memory-fence instruction)
   --  3. whatever else is required.
end Sanitize_GF_PA;
  16:	40b2                	lw	ra,12(sp)
  18:	4422                	lw	s0,8(sp)

0000001a <.LVL64>:
  1a:	0141                	addi	sp,sp,16
  1c:	8082                	ret

Disassembly of section .text.sparknacl__Omultiply:

00000000 <sparknacl__Omultiply>:
   function "*" (Left, Right : in Normal_GF) return Normal_GF
   0:	c2010113          	addi	sp,sp,-992
   4:	87aa                	mv	a5,a0
   6:	3c812c23          	sw	s0,984(sp)
   a:	3c912a23          	sw	s1,980(sp)
   e:	8432                	mv	s0,a2
  10:	84ae                	mv	s1,a1
      T := (others => 0);
  12:	0f800613          	li	a2,248

00000016 <.LVL66>:
  16:	4581                	li	a1,0

00000018 <.LVL67>:
  18:	1528                	addi	a0,sp,680
   function "*" (Left, Right : in Normal_GF) return Normal_GF
  1a:	10f12e23          	sw	a5,284(sp)
  1e:	3c112e23          	sw	ra,988(sp)
  22:	3d212823          	sw	s2,976(sp)
  26:	3d312623          	sw	s3,972(sp)
  2a:	3d412423          	sw	s4,968(sp)
  2e:	3d512223          	sw	s5,964(sp)
  32:	3d612023          	sw	s6,960(sp)
  36:	3b712e23          	sw	s7,956(sp)
  3a:	3b812c23          	sw	s8,952(sp)
  3e:	3b912a23          	sw	s9,948(sp)
  42:	3ba12823          	sw	s10,944(sp)
  46:	3bb12623          	sw	s11,940(sp)
      T := (others => 0);
  4a:	00000097          	auipc	ra,0x0
  4e:	000080e7          	jalr	ra # 4a <.LVL67+0x32>

00000052 <.LVL69>:
  52:	401c                	lw	a5,0(s0)
  54:	4681                	li	a3,0
  56:	c43e                	sw	a5,8(sp)
  58:	405c                	lw	a5,4(s0)
  5a:	cdbe                	sw	a5,216(sp)
  5c:	441c                	lw	a5,8(s0)
  5e:	c63e                	sw	a5,12(sp)
  60:	445c                	lw	a5,12(s0)
  62:	cfbe                	sw	a5,220(sp)
  64:	481c                	lw	a5,16(s0)
  66:	c83e                	sw	a5,16(sp)
  68:	485c                	lw	a5,20(s0)
  6a:	d1be                	sw	a5,224(sp)
  6c:	4c1c                	lw	a5,24(s0)
  6e:	ca3e                	sw	a5,20(sp)
  70:	4c5c                	lw	a5,28(s0)
  72:	d3be                	sw	a5,228(sp)
  74:	501c                	lw	a5,32(s0)
  76:	cc3e                	sw	a5,24(sp)
  78:	505c                	lw	a5,36(s0)
  7a:	d5be                	sw	a5,232(sp)
  7c:	541c                	lw	a5,40(s0)
  7e:	ce3e                	sw	a5,28(sp)
  80:	545c                	lw	a5,44(s0)
  82:	d7be                	sw	a5,236(sp)
  84:	581c                	lw	a5,48(s0)
  86:	d03e                	sw	a5,32(sp)
  88:	585c                	lw	a5,52(s0)
  8a:	d9be                	sw	a5,240(sp)
  8c:	5c1c                	lw	a5,56(s0)
  8e:	d23e                	sw	a5,36(sp)
  90:	5c5c                	lw	a5,60(s0)
  92:	dbbe                	sw	a5,244(sp)
  94:	403c                	lw	a5,64(s0)
  96:	d43e                	sw	a5,40(sp)
  98:	407c                	lw	a5,68(s0)
  9a:	ddbe                	sw	a5,248(sp)
  9c:	443c                	lw	a5,72(s0)
  9e:	d63e                	sw	a5,44(sp)
  a0:	447c                	lw	a5,76(s0)
  a2:	dfbe                	sw	a5,252(sp)
  a4:	483c                	lw	a5,80(s0)
  a6:	d83e                	sw	a5,48(sp)
  a8:	487c                	lw	a5,84(s0)
  aa:	10f12023          	sw	a5,256(sp)
  ae:	4c3c                	lw	a5,88(s0)
  b0:	da3e                	sw	a5,52(sp)
  b2:	4c7c                	lw	a5,92(s0)
  b4:	10f12223          	sw	a5,260(sp)
  b8:	503c                	lw	a5,96(s0)
  ba:	dc3e                	sw	a5,56(sp)
  bc:	507c                	lw	a5,100(s0)
  be:	10f12423          	sw	a5,264(sp)
  c2:	543c                	lw	a5,104(s0)
  c4:	de3e                	sw	a5,60(sp)
  c6:	547c                	lw	a5,108(s0)
  c8:	10f12623          	sw	a5,268(sp)
  cc:	583c                	lw	a5,112(s0)
  ce:	c0be                	sw	a5,64(sp)
  d0:	587c                	lw	a5,116(s0)
  d2:	10f12823          	sw	a5,272(sp)
  d6:	5c3c                	lw	a5,120(s0)
  d8:	10f12a23          	sw	a5,276(sp)
  dc:	5c7c                	lw	a5,124(s0)
  de:	10f12c23          	sw	a5,280(sp)
  e2:	dd02                	sw	zero,184(sp)
  e4:	c2a6                	sw	s1,68(sp)
  e6:	d902                	sw	zero,176(sp)
  e8:	db02                	sw	zero,180(sp)
  ea:	d502                	sw	zero,168(sp)
  ec:	d702                	sw	zero,172(sp)
  ee:	d102                	sw	zero,160(sp)
  f0:	d302                	sw	zero,164(sp)
  f2:	cd02                	sw	zero,152(sp)
  f4:	cf02                	sw	zero,156(sp)
  f6:	c902                	sw	zero,144(sp)
  f8:	cb02                	sw	zero,148(sp)
  fa:	c502                	sw	zero,136(sp)
  fc:	c702                	sw	zero,140(sp)
  fe:	c102                	sw	zero,128(sp)
 100:	c302                	sw	zero,132(sp)
 102:	dc82                	sw	zero,120(sp)
 104:	de82                	sw	zero,124(sp)
 106:	d882                	sw	zero,112(sp)
 108:	da82                	sw	zero,116(sp)
 10a:	d482                	sw	zero,104(sp)
 10c:	d682                	sw	zero,108(sp)
 10e:	d082                	sw	zero,96(sp)
 110:	d282                	sw	zero,100(sp)
 112:	cc82                	sw	zero,88(sp)
 114:	ce82                	sw	zero,92(sp)
 116:	c882                	sw	zero,80(sp)
 118:	ca82                	sw	zero,84(sp)
 11a:	c482                	sw	zero,72(sp)
 11c:	c682                	sw	zero,76(sp)
 11e:	1524                	addi	s1,sp,680

00000120 <.L272>:
         LT := Left (I);
 120:	4616                	lw	a2,68(sp)
         T (I)      := T (I)      + (LT * Right (0));
 122:	4422                	lw	s0,8(sp)
 124:	45ee                	lw	a1,216(sp)
         LT := Left (I);
 126:	421c                	lw	a5,0(a2)
 128:	4258                	lw	a4,4(a2)

0000012a <.LVL71>:
      for I in Index_16 loop
 12a:	0621                	addi	a2,a2,8
         T (I)      := T (I)      + (LT * Right (0));
 12c:	02f58eb3          	mul	t4,a1,a5
      for I in Index_16 loop
 130:	c2b2                	sw	a2,68(sp)
         T (I + 1)  := T (I + 1)  + (LT * Right (1));
 132:	43b2                	lw	t2,12(sp)
 134:	45fe                	lw	a1,220(sp)
         T (I + 2)  := T (I + 2)  + (LT * Right (2));
 136:	40c2                	lw	ra,16(sp)
         T (I + 3)  := T (I + 3)  + (LT * Right (3));
 138:	4952                	lw	s2,20(sp)
         T (I + 4)  := T (I + 4)  + (LT * Right (4));
 13a:	49e2                	lw	s3,24(sp)
         T (I + 5)  := T (I + 5)  + (LT * Right (5));
 13c:	4a72                	lw	s4,28(sp)
         T (I + 6)  := T (I + 6)  + (LT * Right (6));
 13e:	5a82                	lw	s5,32(sp)
         T (I + 7)  := T (I + 7)  + (LT * Right (7));
 140:	5f5e                	lw	t5,244(sp)
         T (I)      := T (I)      + (LT * Right (0));
 142:	02870633          	mul	a2,a4,s0
         T (I + 8)  := T (I + 8)  + (LT * Right (8));
 146:	52ee                	lw	t0,248(sp)
         T (I + 9)  := T (I + 9)  + (LT * Right (9));
 148:	5b7e                	lw	s6,252(sp)
         T (I + 10) := T (I + 10) + (LT * Right (10));
 14a:	10012b83          	lw	s7,256(sp)
         T (I + 11) := T (I + 11) + (LT * Right (11));
 14e:	10412c03          	lw	s8,260(sp)
         T (I + 12) := T (I + 12) + (LT * Right (12));
 152:	10812c83          	lw	s9,264(sp)
      for I in Index_16 loop
 156:	04a1                	addi	s1,s1,8
         T (I + 1)  := T (I + 1)  + (LT * Right (1));
 158:	02f58e33          	mul	t3,a1,a5
         T (I)      := T (I)      + (LT * Right (0));
 15c:	9eb2                	add	t4,t4,a2
         T (I + 2)  := T (I + 2)  + (LT * Right (2));
 15e:	558e                	lw	a1,224(sp)
         T (I + 1)  := T (I + 1)  + (LT * Right (1));
 160:	02770633          	mul	a2,a4,t2
         T (I + 2)  := T (I + 2)  + (LT * Right (2));
 164:	02f58333          	mul	t1,a1,a5
         T (I + 1)  := T (I + 1)  + (LT * Right (1));
 168:	9e32                	add	t3,t3,a2
         T (I + 3)  := T (I + 3)  + (LT * Right (3));
 16a:	559e                	lw	a1,228(sp)
         T (I + 2)  := T (I + 2)  + (LT * Right (2));
 16c:	02170633          	mul	a2,a4,ra
         T (I + 3)  := T (I + 3)  + (LT * Right (3));
 170:	02f588b3          	mul	a7,a1,a5
         T (I + 2)  := T (I + 2)  + (LT * Right (2));
 174:	9332                	add	t1,t1,a2
         T (I + 4)  := T (I + 4)  + (LT * Right (4));
 176:	55ae                	lw	a1,232(sp)
         T (I + 3)  := T (I + 3)  + (LT * Right (3));
 178:	03270633          	mul	a2,a4,s2
         T (I + 4)  := T (I + 4)  + (LT * Right (4));
 17c:	02f58833          	mul	a6,a1,a5
         T (I + 3)  := T (I + 3)  + (LT * Right (3));
 180:	98b2                	add	a7,a7,a2
         T (I + 5)  := T (I + 5)  + (LT * Right (5));
 182:	55be                	lw	a1,236(sp)
         T (I + 4)  := T (I + 4)  + (LT * Right (4));
 184:	03370633          	mul	a2,a4,s3
         T (I + 5)  := T (I + 5)  + (LT * Right (5));
 188:	02f58533          	mul	a0,a1,a5
         T (I + 4)  := T (I + 4)  + (LT * Right (4));
 18c:	9832                	add	a6,a6,a2
         T (I + 6)  := T (I + 6)  + (LT * Right (6));
 18e:	55ce                	lw	a1,240(sp)
         T (I + 5)  := T (I + 5)  + (LT * Right (5));
 190:	03470633          	mul	a2,a4,s4
         T (I + 6)  := T (I + 6)  + (LT * Right (6));
 194:	02f585b3          	mul	a1,a1,a5
         T (I + 5)  := T (I + 5)  + (LT * Right (5));
 198:	9532                	add	a0,a0,a2
         T (I + 6)  := T (I + 6)  + (LT * Right (6));
 19a:	03570633          	mul	a2,a4,s5
 19e:	95b2                	add	a1,a1,a2
         T (I + 7)  := T (I + 7)  + (LT * Right (7));
 1a0:	5612                	lw	a2,36(sp)
 1a2:	02ff0f33          	mul	t5,t5,a5
 1a6:	02c70633          	mul	a2,a4,a2
 1aa:	967a                	add	a2,a2,t5
         T (I + 8)  := T (I + 8)  + (LT * Right (8));
 1ac:	5f22                	lw	t5,40(sp)
 1ae:	02f282b3          	mul	t0,t0,a5
 1b2:	03e70f33          	mul	t5,a4,t5
         T (I + 9)  := T (I + 9)  + (LT * Right (9));
 1b6:	02fb0fb3          	mul	t6,s6,a5
         T (I + 8)  := T (I + 8)  + (LT * Right (8));
 1ba:	01e28b33          	add	s6,t0,t5
 1be:	df5a                	sw	s6,188(sp)
         T (I + 9)  := T (I + 9)  + (LT * Right (9));
 1c0:	5b32                	lw	s6,44(sp)
 1c2:	03670f33          	mul	t5,a4,s6
         T (I + 10) := T (I + 10) + (LT * Right (10));
 1c6:	02fb82b3          	mul	t0,s7,a5
         T (I + 9)  := T (I + 9)  + (LT * Right (9));
 1ca:	01ef8bb3          	add	s7,t6,t5
 1ce:	c1de                	sw	s7,192(sp)
         T (I + 10) := T (I + 10) + (LT * Right (10));
 1d0:	5bc2                	lw	s7,48(sp)
 1d2:	03770f33          	mul	t5,a4,s7
         T (I + 11) := T (I + 11) + (LT * Right (11));
 1d6:	02fc0fb3          	mul	t6,s8,a5
         T (I + 10) := T (I + 10) + (LT * Right (10));
 1da:	01e28c33          	add	s8,t0,t5
 1de:	c3e2                	sw	s8,196(sp)
         T (I + 11) := T (I + 11) + (LT * Right (11));
 1e0:	5c52                	lw	s8,52(sp)
 1e2:	03870f33          	mul	t5,a4,s8
         T (I + 12) := T (I + 12) + (LT * Right (12));
 1e6:	02fc82b3          	mul	t0,s9,a5
         T (I + 11) := T (I + 11) + (LT * Right (11));
 1ea:	01ef8cb3          	add	s9,t6,t5
 1ee:	c5e6                	sw	s9,200(sp)
         T (I + 12) := T (I + 12) + (LT * Right (12));
 1f0:	5ce2                	lw	s9,56(sp)
         T (I + 13) := T (I + 13) + (LT * Right (13));
 1f2:	10c12d03          	lw	s10,268(sp)
         T (I + 14) := T (I + 14) + (LT * Right (14));
 1f6:	11012d83          	lw	s11,272(sp)
 1fa:	4c06                	lw	s8,64(sp)
         T (I + 12) := T (I + 12) + (LT * Right (12));
 1fc:	03970f33          	mul	t5,a4,s9
         T (I + 13) := T (I + 13) + (LT * Right (13));
 200:	02fd0fb3          	mul	t6,s10,a5
         T (I + 12) := T (I + 12) + (LT * Right (12));
 204:	01e28d33          	add	s10,t0,t5
 208:	c7ea                	sw	s10,204(sp)
         T (I + 13) := T (I + 13) + (LT * Right (13));
 20a:	5d72                	lw	s10,60(sp)
 20c:	03a70f33          	mul	t5,a4,s10
         T (I + 14) := T (I + 14) + (LT * Right (14));
 210:	02fd82b3          	mul	t0,s11,a5
         T (I + 13) := T (I + 13) + (LT * Right (13));
 214:	01ef8db3          	add	s11,t6,t5
 218:	c9ee                	sw	s11,208(sp)
         T (I)      := T (I)      + (LT * Right (0));
 21a:	02f40f33          	mul	t5,s0,a5
 21e:	4426                	lw	s0,72(sp)
         T (I + 1)  := T (I + 1)  + (LT * Right (1));
 220:	02f38d33          	mul	s10,t2,a5
         T (I)      := T (I)      + (LT * Right (0));
 224:	008f0db3          	add	s11,t5,s0
         T (I + 1)  := T (I + 1)  + (LT * Right (1));
 228:	4446                	lw	s0,80(sp)
         T (I)      := T (I)      + (LT * Right (0));
 22a:	01edbf33          	sltu	t5,s11,t5
 22e:	ffb4ac23          	sw	s11,-8(s1)
         T (I + 2)  := T (I + 2)  + (LT * Right (2));
 232:	02f08cb3          	mul	s9,ra,a5
         T (I + 1)  := T (I + 1)  + (LT * Right (1));
 236:	008d0db3          	add	s11,s10,s0
         T (I + 2)  := T (I + 2)  + (LT * Right (2));
 23a:	4466                	lw	s0,88(sp)
         T (I + 1)  := T (I + 1)  + (LT * Right (1));
 23c:	01adbd33          	sltu	s10,s11,s10
 240:	c4ee                	sw	s11,72(sp)
 242:	01b4a023          	sw	s11,0(s1)
         T (I + 14) := T (I + 14) + (LT * Right (14));
 246:	03870fb3          	mul	t6,a4,s8
         T (I + 2)  := T (I + 2)  + (LT * Right (2));
 24a:	008c8db3          	add	s11,s9,s0
         T (I + 3)  := T (I + 3)  + (LT * Right (3));
 24e:	5406                	lw	s0,96(sp)
         T (I + 2)  := T (I + 2)  + (LT * Right (2));
 250:	019dbcb3          	sltu	s9,s11,s9
 254:	c8ee                	sw	s11,80(sp)
 256:	01b4a423          	sw	s11,8(s1)
         T (I + 3)  := T (I + 3)  + (LT * Right (3));
 25a:	02f90c33          	mul	s8,s2,a5
         T (I + 14) := T (I + 14) + (LT * Right (14));
 25e:	92fe                	add	t0,t0,t6
         T (I + 7)  := T (I + 7)  + (LT * Right (7));
 260:	5f92                	lw	t6,36(sp)
         T (I + 14) := T (I + 14) + (LT * Right (14));
 262:	cb96                	sw	t0,212(sp)
         T (I + 8)  := T (I + 8)  + (LT * Right (8));
 264:	52a2                	lw	t0,40(sp)
         T (I + 4)  := T (I + 4)  + (LT * Right (4));
 266:	02f98bb3          	mul	s7,s3,a5
         T (I + 3)  := T (I + 3)  + (LT * Right (3));
 26a:	008c0db3          	add	s11,s8,s0
         T (I + 4)  := T (I + 4)  + (LT * Right (4));
 26e:	5426                	lw	s0,104(sp)
         T (I + 3)  := T (I + 3)  + (LT * Right (3));
 270:	018dbc33          	sltu	s8,s11,s8
 274:	ccee                	sw	s11,88(sp)
 276:	01b4a823          	sw	s11,16(s1)
         T (I + 5)  := T (I + 5)  + (LT * Right (5));
 27a:	02fa0b33          	mul	s6,s4,a5
         T (I + 4)  := T (I + 4)  + (LT * Right (4));
 27e:	008b8db3          	add	s11,s7,s0
         T (I + 5)  := T (I + 5)  + (LT * Right (5));
 282:	5446                	lw	s0,112(sp)
         T (I + 4)  := T (I + 4)  + (LT * Right (4));
 284:	017dbbb3          	sltu	s7,s11,s7
 288:	d0ee                	sw	s11,96(sp)
 28a:	01b4ac23          	sw	s11,24(s1)
         T (I + 6)  := T (I + 6)  + (LT * Right (6));
 28e:	02fa8ab3          	mul	s5,s5,a5
         T (I + 5)  := T (I + 5)  + (LT * Right (5));
 292:	008b0db3          	add	s11,s6,s0
         T (I + 6)  := T (I + 6)  + (LT * Right (6));
 296:	5466                	lw	s0,120(sp)
         T (I + 5)  := T (I + 5)  + (LT * Right (5));
 298:	016dbb33          	sltu	s6,s11,s6
 29c:	d4ee                	sw	s11,104(sp)
 29e:	03b4a023          	sw	s11,32(s1)
         T (I + 7)  := T (I + 7)  + (LT * Right (7));
 2a2:	02ff8a33          	mul	s4,t6,a5
         T (I + 6)  := T (I + 6)  + (LT * Right (6));
 2a6:	008a8db3          	add	s11,s5,s0
         T (I + 7)  := T (I + 7)  + (LT * Right (7));
 2aa:	440a                	lw	s0,128(sp)
         T (I + 6)  := T (I + 6)  + (LT * Right (6));
 2ac:	015dbab3          	sltu	s5,s11,s5
 2b0:	d8ee                	sw	s11,112(sp)
 2b2:	03b4a423          	sw	s11,40(s1)
         T (I + 7)  := T (I + 7)  + (LT * Right (7));
 2b6:	008a0db3          	add	s11,s4,s0
 2ba:	dcee                	sw	s11,120(sp)
 2bc:	03b4a823          	sw	s11,48(s1)
         T (I + 8)  := T (I + 8)  + (LT * Right (8));
 2c0:	02f289b3          	mul	s3,t0,a5
         T (I + 9)  := T (I + 9)  + (LT * Right (9));
 2c4:	5fb2                	lw	t6,44(sp)
         T (I + 8)  := T (I + 8)  + (LT * Right (8));
 2c6:	442a                	lw	s0,136(sp)
         T (I + 10) := T (I + 10) + (LT * Right (10));
 2c8:	52c2                	lw	t0,48(sp)
         T (I + 9)  := T (I + 9)  + (LT * Right (9));
 2ca:	43ca                	lw	t2,144(sp)
         T (I + 7)  := T (I + 7)  + (LT * Right (7));
 2cc:	014dba33          	sltu	s4,s11,s4
         T (I + 9)  := T (I + 9)  + (LT * Right (9));
 2d0:	02ff8933          	mul	s2,t6,a5
         T (I + 8)  := T (I + 8)  + (LT * Right (8));
 2d4:	00898db3          	add	s11,s3,s0
 2d8:	013db9b3          	sltu	s3,s11,s3
 2dc:	c16e                	sw	s11,128(sp)
 2de:	03b4ac23          	sw	s11,56(s1)
         T (I + 12) := T (I + 12) + (LT * Right (12));
 2e2:	5fe2                	lw	t6,56(sp)
         T (I + 10) := T (I + 10) + (LT * Right (10));
 2e4:	02f28433          	mul	s0,t0,a5
         T (I + 9)  := T (I + 9)  + (LT * Right (9));
 2e8:	00790db3          	add	s11,s2,t2
 2ec:	012db933          	sltu	s2,s11,s2
 2f0:	c56e                	sw	s11,136(sp)
 2f2:	05b4a023          	sw	s11,64(s1)
         T (I + 11) := T (I + 11) + (LT * Right (11));
 2f6:	5dd2                	lw	s11,52(sp)
         T (I + 10) := T (I + 10) + (LT * Right (10));
 2f8:	43ea                	lw	t2,152(sp)
         T (I + 13) := T (I + 13) + (LT * Right (13));
 2fa:	52f2                	lw	t0,60(sp)
         T (I + 11) := T (I + 11) + (LT * Right (11));
 2fc:	02fd80b3          	mul	ra,s11,a5
         T (I + 10) := T (I + 10) + (LT * Right (10));
 300:	00740db3          	add	s11,s0,t2
 304:	008db433          	sltu	s0,s11,s0
 308:	c96e                	sw	s11,144(sp)
 30a:	05b4a423          	sw	s11,72(s1)
         T (I + 12) := T (I + 12) + (LT * Right (12));
 30e:	02ff83b3          	mul	t2,t6,a5
         T (I + 11) := T (I + 11) + (LT * Right (11));
 312:	5f8a                	lw	t6,160(sp)
 314:	01f08db3          	add	s11,ra,t6
         T (I + 12) := T (I + 12) + (LT * Right (12));
 318:	5faa                	lw	t6,168(sp)
         T (I + 11) := T (I + 11) + (LT * Right (11));
 31a:	001db0b3          	sltu	ra,s11,ra
 31e:	cd6e                	sw	s11,152(sp)
 320:	05b4a823          	sw	s11,80(s1)
         T (I + 13) := T (I + 13) + (LT * Right (13));
 324:	02f282b3          	mul	t0,t0,a5
         T (I + 12) := T (I + 12) + (LT * Right (12));
 328:	01f38db3          	add	s11,t2,t6
 32c:	007db3b3          	sltu	t2,s11,t2
         T (I + 14) := T (I + 14) + (LT * Right (14));
 330:	4f86                	lw	t6,64(sp)
         T (I + 12) := T (I + 12) + (LT * Right (12));
 332:	d16e                	sw	s11,160(sp)
 334:	05b4ac23          	sw	s11,88(s1)
         T (I + 13) := T (I + 13) + (LT * Right (13));
 338:	5dca                	lw	s11,176(sp)
         T (I + 14) := T (I + 14) + (LT * Right (14));
 33a:	02ff8fb3          	mul	t6,t6,a5
         T (I + 13) := T (I + 13) + (LT * Right (13));
 33e:	9d96                	add	s11,s11,t0
 340:	005db2b3          	sltu	t0,s11,t0
 344:	d56e                	sw	s11,168(sp)
 346:	07b4a023          	sw	s11,96(s1)
         T (I)      := T (I)      + (LT * Right (0));
 34a:	4da2                	lw	s11,8(sp)
 34c:	02fdbdb3          	mulhu	s11,s11,a5
         T (I + 14) := T (I + 14) + (LT * Right (14));
 350:	96fe                	add	a3,a3,t6
 352:	01f6bfb3          	sltu	t6,a3,t6
 356:	d936                	sw	a3,176(sp)
 358:	d4b4                	sw	a3,104(s1)
         T (I + 1)  := T (I + 1)  + (LT * Right (1));
 35a:	46b2                	lw	a3,12(sp)
         T (I)      := T (I)      + (LT * Right (0));
 35c:	9eee                	add	t4,t4,s11
         T (I + 1)  := T (I + 1)  + (LT * Right (1));
 35e:	02f6b6b3          	mulhu	a3,a3,a5
         T (I)      := T (I)      + (LT * Right (0));
 362:	4db6                	lw	s11,76(sp)
 364:	9eee                	add	t4,t4,s11
 366:	9efa                	add	t4,t4,t5
 368:	ffd4ae23          	sw	t4,-4(s1)
         T (I + 2)  := T (I + 2)  + (LT * Right (2));
 36c:	4ec2                	lw	t4,16(sp)
 36e:	02febf33          	mulhu	t5,t4,a5
         T (I + 1)  := T (I + 1)  + (LT * Right (1));
 372:	4ed6                	lw	t4,84(sp)
 374:	9e36                	add	t3,t3,a3
 376:	9e76                	add	t3,t3,t4
 378:	9e6a                	add	t3,t3,s10
 37a:	c6f2                	sw	t3,76(sp)
         T (I + 3)  := T (I + 3)  + (LT * Right (3));
 37c:	46d2                	lw	a3,20(sp)
         T (I + 1)  := T (I + 1)  + (LT * Right (1));
 37e:	01c4a223          	sw	t3,4(s1)
         T (I + 2)  := T (I + 2)  + (LT * Right (2));
 382:	4e76                	lw	t3,92(sp)
         T (I + 3)  := T (I + 3)  + (LT * Right (3));
 384:	02f6b6b3          	mulhu	a3,a3,a5
         T (I + 2)  := T (I + 2)  + (LT * Right (2));
 388:	937a                	add	t1,t1,t5
 38a:	9372                	add	t1,t1,t3
 38c:	006c8e33          	add	t3,s9,t1
         T (I + 4)  := T (I + 4)  + (LT * Right (4));
 390:	4362                	lw	t1,24(sp)
         T (I + 2)  := T (I + 2)  + (LT * Right (2));
 392:	caf2                	sw	t3,84(sp)
 394:	01c4a623          	sw	t3,12(s1)
         T (I + 8)  := T (I + 8)  + (LT * Right (8));
 398:	5f22                	lw	t5,40(sp)
         T (I + 4)  := T (I + 4)  + (LT * Right (4));
 39a:	02f33e33          	mulhu	t3,t1,a5
         T (I + 3)  := T (I + 3)  + (LT * Right (3));
 39e:	98b6                	add	a7,a7,a3
         T (I + 5)  := T (I + 5)  + (LT * Right (5));
 3a0:	46f2                	lw	a3,28(sp)
         T (I + 3)  := T (I + 3)  + (LT * Right (3));
 3a2:	5316                	lw	t1,100(sp)
 3a4:	989a                	add	a7,a7,t1
 3a6:	98e2                	add	a7,a7,s8
 3a8:	cec6                	sw	a7,92(sp)
 3aa:	0114aa23          	sw	a7,20(s1)
         T (I + 5)  := T (I + 5)  + (LT * Right (5));
 3ae:	02f6b6b3          	mulhu	a3,a3,a5
         T (I + 4)  := T (I + 4)  + (LT * Right (4));
 3b2:	58b6                	lw	a7,108(sp)
 3b4:	9872                	add	a6,a6,t3
 3b6:	9846                	add	a6,a6,a7
 3b8:	010b88b3          	add	a7,s7,a6
         T (I + 6)  := T (I + 6)  + (LT * Right (6));
 3bc:	5802                	lw	a6,32(sp)
         T (I + 4)  := T (I + 4)  + (LT * Right (4));
 3be:	d2c6                	sw	a7,100(sp)
 3c0:	0114ae23          	sw	a7,28(s1)
         T (I + 10) := T (I + 10) + (LT * Right (10));
 3c4:	5bc2                	lw	s7,48(sp)
         T (I + 6)  := T (I + 6)  + (LT * Right (6));
 3c6:	02f838b3          	mulhu	a7,a6,a5
         T (I + 5)  := T (I + 5)  + (LT * Right (5));
 3ca:	9536                	add	a0,a0,a3
         T (I + 7)  := T (I + 7)  + (LT * Right (7));
 3cc:	5692                	lw	a3,36(sp)
         T (I + 5)  := T (I + 5)  + (LT * Right (5));
 3ce:	5856                	lw	a6,116(sp)
 3d0:	9542                	add	a0,a0,a6
 3d2:	955a                	add	a0,a0,s6
 3d4:	d6aa                	sw	a0,108(sp)
 3d6:	d0c8                	sw	a0,36(s1)
         T (I + 7)  := T (I + 7)  + (LT * Right (7));
 3d8:	02f6b6b3          	mulhu	a3,a3,a5
         T (I + 6)  := T (I + 6)  + (LT * Right (6));
 3dc:	5576                	lw	a0,124(sp)
 3de:	95c6                	add	a1,a1,a7
         T (I + 9)  := T (I + 9)  + (LT * Right (9));
 3e0:	5b32                	lw	s6,44(sp)
         T (I + 6)  := T (I + 6)  + (LT * Right (6));
 3e2:	95aa                	add	a1,a1,a0
 3e4:	95d6                	add	a1,a1,s5
 3e6:	daae                	sw	a1,116(sp)
 3e8:	d4cc                	sw	a1,44(s1)
         T (I + 8)  := T (I + 8)  + (LT * Right (8));
 3ea:	45ba                	lw	a1,140(sp)
 3ec:	02ff3533          	mulhu	a0,t5,a5
         T (I + 7)  := T (I + 7)  + (LT * Right (7));
 3f0:	9636                	add	a2,a2,a3
 3f2:	469a                	lw	a3,132(sp)
 3f4:	9636                	add	a2,a2,a3
 3f6:	00ca06b3          	add	a3,s4,a2
 3fa:	deb6                	sw	a3,124(sp)
 3fc:	d8d4                	sw	a3,52(s1)
         T (I + 9)  := T (I + 9)  + (LT * Right (9));
 3fe:	02fb36b3          	mulhu	a3,s6,a5
         T (I + 8)  := T (I + 8)  + (LT * Right (8));
 402:	5b7a                	lw	s6,188(sp)
 404:	955a                	add	a0,a0,s6
 406:	952e                	add	a0,a0,a1
 408:	00a98633          	add	a2,s3,a0
 40c:	c332                	sw	a2,132(sp)
 40e:	dcd0                	sw	a2,60(s1)
         T (I + 10) := T (I + 10) + (LT * Right (10));
 410:	02fbb5b3          	mulhu	a1,s7,a5
         T (I + 9)  := T (I + 9)  + (LT * Right (9));
 414:	4b8e                	lw	s7,192(sp)
 416:	455a                	lw	a0,148(sp)
         T (I + 11) := T (I + 11) + (LT * Right (11));
 418:	5dd2                	lw	s11,52(sp)
         T (I + 10) := T (I + 10) + (LT * Right (10));
 41a:	461e                	lw	a2,196(sp)
         T (I + 9)  := T (I + 9)  + (LT * Right (9));
 41c:	96de                	add	a3,a3,s7
 41e:	96aa                	add	a3,a3,a0
 420:	96ca                	add	a3,a3,s2
 422:	c736                	sw	a3,140(sp)
 424:	c0f4                	sw	a3,68(s1)
         T (I + 10) := T (I + 10) + (LT * Right (10));
 426:	95b2                	add	a1,a1,a2
         T (I + 11) := T (I + 11) + (LT * Right (11));
 428:	02fdb6b3          	mulhu	a3,s11,a5
         T (I + 10) := T (I + 10) + (LT * Right (10));
 42c:	467a                	lw	a2,156(sp)
         T (I + 12) := T (I + 12) + (LT * Right (12));
 42e:	5ce2                	lw	s9,56(sp)
         T (I + 13) := T (I + 13) + (LT * Right (13));
 430:	5d72                	lw	s10,60(sp)
         T (I + 10) := T (I + 10) + (LT * Right (10));
 432:	95b2                	add	a1,a1,a2
 434:	00b40633          	add	a2,s0,a1
 438:	cb32                	sw	a2,148(sp)
 43a:	c4f0                	sw	a2,76(s1)
         T (I + 11) := T (I + 11) + (LT * Right (11));
 43c:	559a                	lw	a1,164(sp)
         T (I + 14) := T (I + 14) + (LT * Right (14));
 43e:	4c06                	lw	s8,64(sp)
         T (I + 12) := T (I + 12) + (LT * Right (12));
 440:	02fcb633          	mulhu	a2,s9,a5
         T (I + 11) := T (I + 11) + (LT * Right (11));
 444:	4cae                	lw	s9,200(sp)
         T (I + 13) := T (I + 13) + (LT * Right (13));
 446:	4dce                	lw	s11,208(sp)
         T (I + 15) := T (I + 15) + (LT * Right (15));
 448:	11412403          	lw	s0,276(sp)
         T (I + 11) := T (I + 11) + (LT * Right (11));
 44c:	96e6                	add	a3,a3,s9
 44e:	96ae                	add	a3,a3,a1
 450:	9686                	add	a3,a3,ra
 452:	cf36                	sw	a3,156(sp)
 454:	c8f4                	sw	a3,84(s1)
         T (I + 12) := T (I + 12) + (LT * Right (12));
 456:	56ba                	lw	a3,172(sp)
         T (I + 13) := T (I + 13) + (LT * Right (13));
 458:	02fd3f33          	mulhu	t5,s10,a5
         T (I + 12) := T (I + 12) + (LT * Right (12));
 45c:	4d3e                	lw	s10,204(sp)
         T (I + 14) := T (I + 14) + (LT * Right (14));
 45e:	55ea                	lw	a1,184(sp)
         T (I + 15) := T (I + 15) + (LT * Right (15));
 460:	58e8                	lw	a0,116(s1)
         T (I + 12) := T (I + 12) + (LT * Right (12));
 462:	966a                	add	a2,a2,s10
 464:	9636                	add	a2,a2,a3
 466:	00c386b3          	add	a3,t2,a2
 46a:	d336                	sw	a3,164(sp)
 46c:	ccf4                	sw	a3,92(s1)
         T (I + 13) := T (I + 13) + (LT * Right (13));
 46e:	565a                	lw	a2,180(sp)
         T (I + 14) := T (I + 14) + (LT * Right (14));
 470:	02fc36b3          	mulhu	a3,s8,a5
         T (I + 13) := T (I + 13) + (LT * Right (13));
 474:	9f6e                	add	t5,t5,s11
 476:	9f32                	add	t5,t5,a2
 478:	01e28633          	add	a2,t0,t5
 47c:	d732                	sw	a2,172(sp)
         T (I + 14) := T (I + 14) + (LT * Right (14));
 47e:	42de                	lw	t0,212(sp)
         T (I + 13) := T (I + 13) + (LT * Right (13));
 480:	d0f0                	sw	a2,100(s1)
         T (I + 15) := T (I + 15) + (LT * Right (15));
 482:	11812603          	lw	a2,280(sp)
 486:	02870733          	mul	a4,a4,s0

0000048a <.LVL72>:
         T (I + 14) := T (I + 14) + (LT * Right (14));
 48a:	9696                	add	a3,a3,t0
 48c:	96ae                	add	a3,a3,a1
 48e:	96fe                	add	a3,a3,t6
 490:	db36                	sw	a3,180(sp)
 492:	d4f4                	sw	a3,108(s1)
         T (I + 15) := T (I + 15) + (LT * Right (15));
 494:	58b4                	lw	a3,112(s1)
 496:	02f60633          	mul	a2,a2,a5
 49a:	02f405b3          	mul	a1,s0,a5
 49e:	963a                	add	a2,a2,a4
 4a0:	02f437b3          	mulhu	a5,s0,a5

000004a4 <.LVL73>:
 4a4:	96ae                	add	a3,a3,a1
 4a6:	00b6b5b3          	sltu	a1,a3,a1
 4aa:	d8b4                	sw	a3,112(s1)
 4ac:	963e                	add	a2,a2,a5
 4ae:	962a                	add	a2,a2,a0
 4b0:	00c587b3          	add	a5,a1,a2
 4b4:	dd3e                	sw	a5,184(sp)
 4b6:	d8fc                	sw	a5,116(s1)
      for I in Index_16 loop
 4b8:	163c                	addi	a5,sp,808
 4ba:	c69793e3          	bne	a5,s1,120 <.L272>

000004be <.LBB49>:
         TF (I) := T (I) + R2256 * T (I + 16);
 4be:	32812483          	lw	s1,808(sp)
 4c2:	02600793          	li	a5,38
 4c6:	34012383          	lw	t2,832(sp)
 4ca:	02978fb3          	mul	t6,a5,s1
 4ce:	33012403          	lw	s0,816(sp)
 4d2:	33812083          	lw	ra,824(sp)
 4d6:	2a812703          	lw	a4,680(sp)
 4da:	32c12803          	lw	a6,812(sp)
 4de:	34812283          	lw	t0,840(sp)
 4e2:	2c012603          	lw	a2,704(sp)
 4e6:	33412583          	lw	a1,820(sp)
 4ea:	2c812683          	lw	a3,712(sp)
 4ee:	35012e03          	lw	t3,848(sp)
 4f2:	02778333          	mul	t1,a5,t2
 4f6:	977e                	add	a4,a4,t6
 4f8:	01f73fb3          	sltu	t6,a4,t6
 4fc:	12e12423          	sw	a4,296(sp)
 500:	2b012703          	lw	a4,688(sp)

00000504 <.LBE49>:
      Sanitize_GF_PA (T);
 504:	1528                	addi	a0,sp,680

00000506 <.LBB50>:
         TF (I) := T (I) + R2256 * T (I + 16);
 506:	02878f33          	mul	t5,a5,s0
 50a:	961a                	add	a2,a2,t1
 50c:	00663333          	sltu	t1,a2,t1
 510:	14c12023          	sw	a2,320(sp)
 514:	33c12603          	lw	a2,828(sp)
 518:	02178eb3          	mul	t4,a5,ra
 51c:	977a                	add	a4,a4,t5
 51e:	01e73f33          	sltu	t5,a4,t5
 522:	12e12823          	sw	a4,304(sp)
 526:	2b812703          	lw	a4,696(sp)
 52a:	0297b4b3          	mulhu	s1,a5,s1
 52e:	9776                	add	a4,a4,t4
 530:	01d73eb3          	sltu	t4,a4,t4
 534:	12e12c23          	sw	a4,312(sp)
 538:	2ac12703          	lw	a4,684(sp)
 53c:	03078833          	mul	a6,a5,a6
 540:	025788b3          	mul	a7,a5,t0
 544:	9826                	add	a6,a6,s1
 546:	983a                	add	a6,a6,a4
 548:	2b412703          	lw	a4,692(sp)
 54c:	35812483          	lw	s1,856(sp)
 550:	987e                	add	a6,a6,t6
 552:	13012623          	sw	a6,300(sp)

00000556 <.LVL75>:
 556:	0287b433          	mulhu	s0,a5,s0
 55a:	96c6                	add	a3,a3,a7
 55c:	0116b8b3          	sltu	a7,a3,a7
 560:	14d12423          	sw	a3,328(sp)
 564:	34412683          	lw	a3,836(sp)
 568:	02b785b3          	mul	a1,a5,a1
 56c:	0217b0b3          	mulhu	ra,a5,ra
 570:	95a2                	add	a1,a1,s0
 572:	95ba                	add	a1,a1,a4
 574:	2bc12703          	lw	a4,700(sp)
 578:	95fa                	add	a1,a1,t5
 57a:	12b12a23          	sw	a1,308(sp)

0000057e <.LVL76>:
 57e:	02c78633          	mul	a2,a5,a2
 582:	0277b3b3          	mulhu	t2,a5,t2
 586:	9606                	add	a2,a2,ra
 588:	963a                	add	a2,a2,a4
 58a:	34c12703          	lw	a4,844(sp)
 58e:	9676                	add	a2,a2,t4
 590:	12c12e23          	sw	a2,316(sp)

00000594 <.LVL77>:
 594:	2c412603          	lw	a2,708(sp)
 598:	02d786b3          	mul	a3,a5,a3
 59c:	0257b2b3          	mulhu	t0,a5,t0
 5a0:	969e                	add	a3,a3,t2
 5a2:	96b2                	add	a3,a3,a2
 5a4:	969a                	add	a3,a3,t1
 5a6:	14d12223          	sw	a3,324(sp)

000005aa <.LVL78>:
 5aa:	2cc12683          	lw	a3,716(sp)
 5ae:	02e78733          	mul	a4,a5,a4
 5b2:	03c783b3          	mul	t2,a5,t3
 5b6:	9716                	add	a4,a4,t0
 5b8:	9736                	add	a4,a4,a3
 5ba:	9746                	add	a4,a4,a7
 5bc:	14e12623          	sw	a4,332(sp)

000005c0 <.LVL79>:
 5c0:	36012403          	lw	s0,864(sp)
 5c4:	36812083          	lw	ra,872(sp)
 5c8:	37012283          	lw	t0,880(sp)
 5cc:	2d012703          	lw	a4,720(sp)
 5d0:	35412883          	lw	a7,852(sp)
 5d4:	02978fb3          	mul	t6,a5,s1
 5d8:	971e                	add	a4,a4,t2
 5da:	35c12803          	lw	a6,860(sp)
 5de:	007733b3          	sltu	t2,a4,t2
 5e2:	14e12823          	sw	a4,336(sp)
 5e6:	2d812703          	lw	a4,728(sp)
 5ea:	2e812603          	lw	a2,744(sp)
 5ee:	2e012683          	lw	a3,736(sp)
 5f2:	37812303          	lw	t1,888(sp)
 5f6:	02178eb3          	mul	t4,a5,ra
 5fa:	977e                	add	a4,a4,t6
 5fc:	01f73fb3          	sltu	t6,a4,t6
 600:	14e12c23          	sw	a4,344(sp)
 604:	2f012703          	lw	a4,752(sp)
 608:	025785b3          	mul	a1,a5,t0
 60c:	9676                	add	a2,a2,t4
 60e:	01d63eb3          	sltu	t4,a2,t4
 612:	16c12423          	sw	a2,360(sp)
 616:	36412603          	lw	a2,868(sp)
 61a:	03c7be33          	mulhu	t3,a5,t3
 61e:	972e                	add	a4,a4,a1
 620:	00b735b3          	sltu	a1,a4,a1
 624:	16e12823          	sw	a4,368(sp)
 628:	2d412703          	lw	a4,724(sp)
 62c:	031788b3          	mul	a7,a5,a7
 630:	0297b4b3          	mulhu	s1,a5,s1
 634:	98f2                	add	a7,a7,t3
 636:	98ba                	add	a7,a7,a4
 638:	2dc12703          	lw	a4,732(sp)
 63c:	989e                	add	a7,a7,t2
 63e:	15112a23          	sw	a7,340(sp)

00000642 <.LVL80>:
 642:	38012383          	lw	t2,896(sp)
 646:	03078833          	mul	a6,a5,a6
 64a:	02878f33          	mul	t5,a5,s0
 64e:	9826                	add	a6,a6,s1
 650:	983a                	add	a6,a6,a4
 652:	36c12703          	lw	a4,876(sp)
 656:	987e                	add	a6,a6,t6
 658:	15012e23          	sw	a6,348(sp)

0000065c <.LVL81>:
 65c:	0287b433          	mulhu	s0,a5,s0
 660:	96fa                	add	a3,a3,t5
 662:	01e6bf33          	sltu	t5,a3,t5
 666:	16d12023          	sw	a3,352(sp)
 66a:	2e412683          	lw	a3,740(sp)
 66e:	02c78633          	mul	a2,a5,a2
 672:	0217b0b3          	mulhu	ra,a5,ra
 676:	9622                	add	a2,a2,s0
 678:	9636                	add	a2,a2,a3
 67a:	37412683          	lw	a3,884(sp)
 67e:	967a                	add	a2,a2,t5
 680:	16c12223          	sw	a2,356(sp)

00000684 <.LVL82>:
 684:	2ec12603          	lw	a2,748(sp)
 688:	02e78733          	mul	a4,a5,a4
 68c:	0257b2b3          	mulhu	t0,a5,t0
 690:	9706                	add	a4,a4,ra
 692:	9732                	add	a4,a4,a2
 694:	9776                	add	a4,a4,t4
 696:	16e12623          	sw	a4,364(sp)

0000069a <.LVL83>:
 69a:	2f412703          	lw	a4,756(sp)
 69e:	02d786b3          	mul	a3,a5,a3
 6a2:	02678633          	mul	a2,a5,t1
 6a6:	9696                	add	a3,a3,t0
 6a8:	96ba                	add	a3,a3,a4
 6aa:	2f812703          	lw	a4,760(sp)
 6ae:	96ae                	add	a3,a3,a1
 6b0:	16d12a23          	sw	a3,372(sp)

000006b4 <.LVL84>:
 6b4:	9732                	add	a4,a4,a2
 6b6:	16e12c23          	sw	a4,376(sp)
 6ba:	38812283          	lw	t0,904(sp)
 6be:	02778f33          	mul	t5,a5,t2
 6c2:	39812e83          	lw	t4,920(sp)
 6c6:	39012f83          	lw	t6,912(sp)

000006ca <.LBE50>:
      TF (15) := T (15);
 6ca:	32012803          	lw	a6,800(sp)
 6ce:	32412883          	lw	a7,804(sp)

000006d2 <.LBB51>:
         TF (I) := T (I) + R2256 * T (I + 16);
 6d2:	37c12583          	lw	a1,892(sp)

000006d6 <.LBE51>:
      TF (15) := T (15);
 6d6:	1b012023          	sw	a6,416(sp)
 6da:	1b112223          	sw	a7,420(sp)

000006de <.LBB52>:
         TF (I) := T (I) + R2256 * T (I + 16);
 6de:	30012683          	lw	a3,768(sp)
 6e2:	00c73733          	sltu	a4,a4,a2
 6e6:	02578e33          	mul	t3,a5,t0
 6ea:	30812603          	lw	a2,776(sp)
 6ee:	96fa                	add	a3,a3,t5
 6f0:	01e6bf33          	sltu	t5,a3,t5
 6f4:	18d12023          	sw	a3,384(sp)
 6f8:	31812683          	lw	a3,792(sp)
 6fc:	03d78833          	mul	a6,a5,t4
 700:	9672                	add	a2,a2,t3
 702:	01c63e33          	sltu	t3,a2,t3
 706:	18c12423          	sw	a2,392(sp)
 70a:	31012603          	lw	a2,784(sp)
 70e:	03f788b3          	mul	a7,a5,t6
 712:	96c2                	add	a3,a3,a6
 714:	0106b833          	sltu	a6,a3,a6
 718:	18d12c23          	sw	a3,408(sp)
 71c:	2fc12683          	lw	a3,764(sp)
 720:	0267b333          	mulhu	t1,a5,t1
 724:	9646                	add	a2,a2,a7
 726:	011638b3          	sltu	a7,a2,a7
 72a:	18c12823          	sw	a2,400(sp)
 72e:	38412603          	lw	a2,900(sp)
 732:	02b785b3          	mul	a1,a5,a1
 736:	959a                	add	a1,a1,t1
 738:	0277b3b3          	mulhu	t2,a5,t2
 73c:	95b6                	add	a1,a1,a3
 73e:	972e                	add	a4,a4,a1
 740:	16e12e23          	sw	a4,380(sp)

00000744 <.LVL85>:
 744:	38c12703          	lw	a4,908(sp)
 748:	30412683          	lw	a3,772(sp)
 74c:	02c78633          	mul	a2,a5,a2
 750:	0257b2b3          	mulhu	t0,a5,t0
 754:	961e                	add	a2,a2,t2
 756:	9636                	add	a2,a2,a3
 758:	967a                	add	a2,a2,t5
 75a:	18c12223          	sw	a2,388(sp)

0000075e <.LVL86>:
 75e:	30c12603          	lw	a2,780(sp)
 762:	39412683          	lw	a3,916(sp)
 766:	02e78733          	mul	a4,a5,a4
 76a:	9716                	add	a4,a4,t0
 76c:	9732                	add	a4,a4,a2
 76e:	9772                	add	a4,a4,t3
 770:	18e12623          	sw	a4,396(sp)

00000774 <.LVL87>:
 774:	39c12703          	lw	a4,924(sp)
 778:	03f7bfb3          	mulhu	t6,a5,t6
 77c:	31412603          	lw	a2,788(sp)
 780:	02e78733          	mul	a4,a5,a4
 784:	02d786b3          	mul	a3,a5,a3
 788:	03d7b7b3          	mulhu	a5,a5,t4
 78c:	96fe                	add	a3,a3,t6
 78e:	96b2                	add	a3,a3,a2
 790:	96c6                	add	a3,a3,a7
 792:	18d12a23          	sw	a3,404(sp)

00000796 <.LVL88>:
 796:	97ba                	add	a5,a5,a4
 798:	31c12703          	lw	a4,796(sp)
 79c:	97ba                	add	a5,a5,a4
 79e:	97c2                	add	a5,a5,a6
 7a0:	18f12e23          	sw	a5,412(sp)

000007a4 <.LBE52>:
      Sanitize_GF_PA (T);
 7a4:	00000097          	auipc	ra,0x0
 7a8:	000080e7          	jalr	ra # 7a4 <.LBE52>

000007ac <.LVL89>:
                 (Car.Product_To_Seminormal (TF)));
 7ac:	122c                	addi	a1,sp,296
 7ae:	1428                	addi	a0,sp,552
 7b0:	00000097          	auipc	ra,0x0
 7b4:	000080e7          	jalr	ra # 7b0 <.LVL89+0x4>

000007b8 <.LVL90>:
               (Car.Seminormal_To_Nearlynormal
 7b8:	142c                	addi	a1,sp,552
 7ba:	1328                	addi	a0,sp,424
 7bc:	00000097          	auipc	ra,0x0
 7c0:	000080e7          	jalr	ra # 7bc <.LVL90+0x4>

000007c4 <.LVL91>:
      return Car.Nearlynormal_To_Normal
 7c4:	11c12403          	lw	s0,284(sp)
 7c8:	132c                	addi	a1,sp,424
 7ca:	8522                	mv	a0,s0
 7cc:	00000097          	auipc	ra,0x0
 7d0:	000080e7          	jalr	ra # 7cc <.LVL91+0x8>

000007d4 <.LVL92>:
   end "*";
 7d4:	3dc12083          	lw	ra,988(sp)
 7d8:	8522                	mv	a0,s0
 7da:	3d812403          	lw	s0,984(sp)
 7de:	3d412483          	lw	s1,980(sp)
 7e2:	3d012903          	lw	s2,976(sp)
 7e6:	3cc12983          	lw	s3,972(sp)
 7ea:	3c812a03          	lw	s4,968(sp)
 7ee:	3c412a83          	lw	s5,964(sp)
 7f2:	3c012b03          	lw	s6,960(sp)
 7f6:	3bc12b83          	lw	s7,956(sp)
 7fa:	3b812c03          	lw	s8,952(sp)
 7fe:	3b412c83          	lw	s9,948(sp)
 802:	3b012d03          	lw	s10,944(sp)
 806:	3ac12d83          	lw	s11,940(sp)
 80a:	3e010113          	addi	sp,sp,992
 80e:	8082                	ret

Disassembly of section .text.sparknacl__sanitize_i64_seq:

00000000 <sparknacl__sanitize_i64_seq>:
separate (SPARKNaCl)
procedure Sanitize_I64_Seq (R : out I64_Seq) is
   0:	4198                	lw	a4,0(a1)
   2:	41dc                	lw	a5,4(a1)
   4:	1141                	addi	sp,sp,-16
   6:	c422                	sw	s0,8(sp)
   8:	c606                	sw	ra,12(sp)
   a:	842a                	mv	s0,a0

0000000c <.LVL95>:
   c:	4601                	li	a2,0
begin
   R := (others => 0);
   e:	00e7c663          	blt	a5,a4,1a <.L276>
  12:	0785                	addi	a5,a5,1
  14:	40e78633          	sub	a2,a5,a4
  18:	060e                	slli	a2,a2,0x3

0000001a <.L276>:
  1a:	4581                	li	a1,0

0000001c <.LVL98>:
  1c:	8522                	mv	a0,s0
  1e:	00000097          	auipc	ra,0x0
  22:	000080e7          	jalr	ra # 1e <.LVL98+0x2>

00000026 <.LVL99>:

   --  Add target-dependent code here to
   --  1. flush and invalidate data cache,
   --  2. wait until writes have committed (e.g. a memory-fence instruction)
   --  3. whatever else is required.
end Sanitize_I64_Seq;
  26:	40b2                	lw	ra,12(sp)
  28:	4422                	lw	s0,8(sp)
  2a:	0141                	addi	sp,sp,16
  2c:	8082                	ret

Disassembly of section .text.sparknacl__sanitize_boolean:

00000000 <sparknacl__sanitize_boolean>:

   --  Add target-dependent code here to
   --  1. flush and invalidate data cache,
   --  2. wait until writes have committed (e.g. a memory-fence instruction)
   --  3. whatever else is required.
end Sanitize_Boolean;
   0:	4501                	li	a0,0
   2:	8082                	ret
