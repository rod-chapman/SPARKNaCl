
sparknacl-car.o:     file format elf32-littleriscv


Disassembly of section .text.sparknacl__car__product_to_seminormal:

00000000 <sparknacl__car__product_to_seminormal>:
   0:	0005a803          	lw	a6,0(a1)
   4:	41d8                	lw	a4,4(a1)
   6:	0085af03          	lw	t5,8(a1)
   a:	45d4                	lw	a3,12(a1)
   c:	01071613          	slli	a2,a4,0x10
  10:	01085793          	srli	a5,a6,0x10
  14:	8fd1                	or	a5,a5,a2
  16:	9f3e                	add	t5,t5,a5
  18:	8741                	srai	a4,a4,0x10
  1a:	00ff37b3          	sltu	a5,t5,a5
  1e:	9736                	add	a4,a4,a3
  20:	0105ae83          	lw	t4,16(a1)
  24:	973e                	add	a4,a4,a5
  26:	49d4                	lw	a3,20(a1)
  28:	01071613          	slli	a2,a4,0x10
  2c:	010f5793          	srli	a5,t5,0x10
  30:	8fd1                	or	a5,a5,a2
  32:	9ebe                	add	t4,t4,a5
  34:	8741                	srai	a4,a4,0x10
  36:	00feb7b3          	sltu	a5,t4,a5
  3a:	9736                	add	a4,a4,a3
  3c:	0185ae03          	lw	t3,24(a1)
  40:	973e                	add	a4,a4,a5
  42:	4dd4                	lw	a3,28(a1)
  44:	01071613          	slli	a2,a4,0x10
  48:	010ed793          	srli	a5,t4,0x10
  4c:	8fd1                	or	a5,a5,a2
  4e:	9e3e                	add	t3,t3,a5
  50:	8741                	srai	a4,a4,0x10
  52:	00fe37b3          	sltu	a5,t3,a5
  56:	9736                	add	a4,a4,a3
  58:	0205a303          	lw	t1,32(a1)
  5c:	973e                	add	a4,a4,a5
  5e:	51d4                	lw	a3,36(a1)
  60:	01071613          	slli	a2,a4,0x10
  64:	010e5793          	srli	a5,t3,0x10
  68:	8fd1                	or	a5,a5,a2
  6a:	933e                	add	t1,t1,a5
  6c:	8741                	srai	a4,a4,0x10
  6e:	00f337b3          	sltu	a5,t1,a5
  72:	9736                	add	a4,a4,a3
  74:	0285af83          	lw	t6,40(a1)
  78:	973e                	add	a4,a4,a5
  7a:	55d4                	lw	a3,44(a1)
  7c:	01071613          	slli	a2,a4,0x10
  80:	01035793          	srli	a5,t1,0x10
  84:	8fd1                	or	a5,a5,a2
  86:	9fbe                	add	t6,t6,a5
  88:	8741                	srai	a4,a4,0x10
  8a:	00ffb7b3          	sltu	a5,t6,a5
  8e:	9736                	add	a4,a4,a3
  90:	0305a383          	lw	t2,48(a1)
  94:	973e                	add	a4,a4,a5
  96:	59d4                	lw	a3,52(a1)
  98:	01071613          	slli	a2,a4,0x10
  9c:	010fd793          	srli	a5,t6,0x10
  a0:	8fd1                	or	a5,a5,a2
  a2:	93be                	add	t2,t2,a5
  a4:	8741                	srai	a4,a4,0x10
  a6:	00f3b7b3          	sltu	a5,t2,a5
  aa:	9736                	add	a4,a4,a3
  ac:	973e                	add	a4,a4,a5
  ae:	0385a283          	lw	t0,56(a1)
  b2:	5dd4                	lw	a3,60(a1)
  b4:	01071613          	slli	a2,a4,0x10
  b8:	0103d793          	srli	a5,t2,0x10
  bc:	8fd1                	or	a5,a5,a2
  be:	92be                	add	t0,t0,a5
  c0:	41075893          	srai	a7,a4,0x10
  c4:	00f2b7b3          	sltu	a5,t0,a5
  c8:	98b6                	add	a7,a7,a3
  ca:	1141                	addi	sp,sp,-16
  cc:	41b8                	lw	a4,64(a1)
  ce:	98be                	add	a7,a7,a5
  d0:	c622                	sw	s0,12(sp)
  d2:	01089793          	slli	a5,a7,0x10
  d6:	41e0                	lw	s0,68(a1)
  d8:	0102d613          	srli	a2,t0,0x10
  dc:	66c1                	lui	a3,0x10
  de:	16fd                	addi	a3,a3,-1
  e0:	8e5d                	or	a2,a2,a5
  e2:	9732                	add	a4,a4,a2
  e4:	00df7f33          	and	t5,t5,a3
  e8:	00defeb3          	and	t4,t4,a3
  ec:	00de7e33          	and	t3,t3,a3
  f0:	00d37333          	and	t1,t1,a3
  f4:	00dfffb3          	and	t6,t6,a3
  f8:	00d3f3b3          	and	t2,t2,a3
  fc:	00d2f2b3          	and	t0,t0,a3
 100:	4108d893          	srai	a7,a7,0x10
 104:	98a2                	add	a7,a7,s0
 106:	01e52423          	sw	t5,8(a0)
 10a:	01d52823          	sw	t4,16(a0)
 10e:	01c52c23          	sw	t3,24(a0)
 112:	02652023          	sw	t1,32(a0)
 116:	03f52423          	sw	t6,40(a0)
 11a:	02752823          	sw	t2,48(a0)
 11e:	02552c23          	sw	t0,56(a0)
 122:	00c73633          	sltu	a2,a4,a2
 126:	00052623          	sw	zero,12(a0)
 12a:	00052a23          	sw	zero,20(a0)
 12e:	00052e23          	sw	zero,28(a0)
 132:	02052223          	sw	zero,36(a0)
 136:	02052623          	sw	zero,44(a0)
 13a:	02052a23          	sw	zero,52(a0)
 13e:	02052e23          	sw	zero,60(a0)
 142:	00d77333          	and	t1,a4,a3
 146:	9646                	add	a2,a2,a7
 148:	0485a883          	lw	a7,72(a1)
 14c:	01061e13          	slli	t3,a2,0x10
 150:	04652023          	sw	t1,64(a0)
 154:	8341                	srli	a4,a4,0x10
 156:	04c5a303          	lw	t1,76(a1)
 15a:	00ee6733          	or	a4,t3,a4
 15e:	98ba                	add	a7,a7,a4
 160:	8641                	srai	a2,a2,0x10
 162:	961a                	add	a2,a2,t1
 164:	00e8b733          	sltu	a4,a7,a4
 168:	0505a303          	lw	t1,80(a1)
 16c:	9732                	add	a4,a4,a2
 16e:	0545ae03          	lw	t3,84(a1)
 172:	01071e93          	slli	t4,a4,0x10
 176:	0108d613          	srli	a2,a7,0x10
 17a:	00cee633          	or	a2,t4,a2
 17e:	9332                	add	t1,t1,a2
 180:	8741                	srai	a4,a4,0x10
 182:	00c33633          	sltu	a2,t1,a2
 186:	9772                	add	a4,a4,t3
 188:	0585ae83          	lw	t4,88(a1)
 18c:	9732                	add	a4,a4,a2
 18e:	05c5ae03          	lw	t3,92(a1)
 192:	01071f13          	slli	t5,a4,0x10
 196:	01035613          	srli	a2,t1,0x10
 19a:	00cf6633          	or	a2,t5,a2
 19e:	9eb2                	add	t4,t4,a2
 1a0:	8741                	srai	a4,a4,0x10
 1a2:	9772                	add	a4,a4,t3
 1a4:	00ceb633          	sltu	a2,t4,a2
 1a8:	0605ae03          	lw	t3,96(a1)
 1ac:	963a                	add	a2,a2,a4
 1ae:	0645af03          	lw	t5,100(a1)
 1b2:	01061f93          	slli	t6,a2,0x10
 1b6:	010ed713          	srli	a4,t4,0x10
 1ba:	00efe733          	or	a4,t6,a4
 1be:	9e3a                	add	t3,t3,a4
 1c0:	8641                	srai	a2,a2,0x10
 1c2:	00ee3733          	sltu	a4,t3,a4
 1c6:	967a                	add	a2,a2,t5
 1c8:	963a                	add	a2,a2,a4
 1ca:	0685af03          	lw	t5,104(a1)
 1ce:	06c5af83          	lw	t6,108(a1)
 1d2:	01061293          	slli	t0,a2,0x10
 1d6:	010e5713          	srli	a4,t3,0x10
 1da:	00e2e733          	or	a4,t0,a4
 1de:	9f3a                	add	t5,t5,a4
 1e0:	8641                	srai	a2,a2,0x10
 1e2:	00ef3733          	sltu	a4,t5,a4
 1e6:	967e                	add	a2,a2,t6
 1e8:	963a                	add	a2,a2,a4
 1ea:	0705af83          	lw	t6,112(a1)
 1ee:	0745a283          	lw	t0,116(a1)
 1f2:	01061393          	slli	t2,a2,0x10
 1f6:	010f5713          	srli	a4,t5,0x10
 1fa:	00e3e733          	or	a4,t2,a4
 1fe:	9fba                	add	t6,t6,a4
 200:	8641                	srai	a2,a2,0x10
 202:	00efb733          	sltu	a4,t6,a4
 206:	9616                	add	a2,a2,t0
 208:	0785a383          	lw	t2,120(a1)
 20c:	963a                	add	a2,a2,a4
 20e:	07c5a283          	lw	t0,124(a1)
 212:	010fd713          	srli	a4,t6,0x10
 216:	01061593          	slli	a1,a2,0x10
 21a:	8f4d                	or	a4,a4,a1
 21c:	007705b3          	add	a1,a4,t2
 220:	8641                	srai	a2,a2,0x10
 222:	9616                	add	a2,a2,t0
 224:	00e5b733          	sltu	a4,a1,a4
 228:	9732                	add	a4,a4,a2
 22a:	01071613          	slli	a2,a4,0x10
 22e:	0105d413          	srli	s0,a1,0x10
 232:	02600393          	li	t2,38
 236:	8c51                	or	s0,s0,a2
 238:	02838633          	mul	a2,t2,s0
 23c:	8741                	srai	a4,a4,0x10
 23e:	00d8f2b3          	and	t0,a7,a3
 242:	00d87833          	and	a6,a6,a3
 246:	00d37333          	and	t1,t1,a3
 24a:	00defeb3          	and	t4,t4,a3
 24e:	00de7e33          	and	t3,t3,a3
 252:	00df7f33          	and	t5,t5,a3
 256:	00dfffb3          	and	t6,t6,a3
 25a:	8eed                	and	a3,a3,a1
 25c:	0283b8b3          	mulhu	a7,t2,s0
 260:	9832                	add	a6,a6,a2
 262:	00c83633          	sltu	a2,a6,a2
 266:	04052223          	sw	zero,68(a0)
 26a:	04552423          	sw	t0,72(a0)
 26e:	04052623          	sw	zero,76(a0)
 272:	04652823          	sw	t1,80(a0)
 276:	04052a23          	sw	zero,84(a0)
 27a:	05d52c23          	sw	t4,88(a0)
 27e:	04052e23          	sw	zero,92(a0)
 282:	02e38733          	mul	a4,t2,a4
 286:	07c52023          	sw	t3,96(a0)
 28a:	06052223          	sw	zero,100(a0)
 28e:	07e52423          	sw	t5,104(a0)
 292:	06052623          	sw	zero,108(a0)
 296:	07f52823          	sw	t6,112(a0)
 29a:	06052a23          	sw	zero,116(a0)
 29e:	01052023          	sw	a6,0(a0)
 2a2:	dd34                	sw	a3,120(a0)
 2a4:	06052e23          	sw	zero,124(a0)
 2a8:	9746                	add	a4,a4,a7
 2aa:	9732                	add	a4,a4,a2
 2ac:	c158                	sw	a4,4(a0)
 2ae:	4432                	lw	s0,12(sp)
 2b0:	0141                	addi	sp,sp,16
 2b2:	8082                	ret

Disassembly of section .text.sparknacl__car__seminormal_to_nearlynormal:

00000000 <sparknacl__car__seminormal_to_nearlynormal>:
   0:	0005a803          	lw	a6,0(a1)
   4:	41d8                	lw	a4,4(a1)
   6:	0085af03          	lw	t5,8(a1)
   a:	45d4                	lw	a3,12(a1)
   c:	01071613          	slli	a2,a4,0x10
  10:	01085793          	srli	a5,a6,0x10
  14:	8fd1                	or	a5,a5,a2
  16:	9f3e                	add	t5,t5,a5
  18:	8741                	srai	a4,a4,0x10
  1a:	00ff37b3          	sltu	a5,t5,a5
  1e:	9736                	add	a4,a4,a3
  20:	0105ae83          	lw	t4,16(a1)
  24:	973e                	add	a4,a4,a5
  26:	49d4                	lw	a3,20(a1)
  28:	01071613          	slli	a2,a4,0x10
  2c:	010f5793          	srli	a5,t5,0x10
  30:	8fd1                	or	a5,a5,a2
  32:	9ebe                	add	t4,t4,a5
  34:	8741                	srai	a4,a4,0x10
  36:	00feb7b3          	sltu	a5,t4,a5
  3a:	9736                	add	a4,a4,a3
  3c:	0185ae03          	lw	t3,24(a1)
  40:	973e                	add	a4,a4,a5
  42:	4dd4                	lw	a3,28(a1)
  44:	01071613          	slli	a2,a4,0x10
  48:	010ed793          	srli	a5,t4,0x10
  4c:	8fd1                	or	a5,a5,a2
  4e:	9e3e                	add	t3,t3,a5
  50:	8741                	srai	a4,a4,0x10
  52:	00fe37b3          	sltu	a5,t3,a5
  56:	9736                	add	a4,a4,a3
  58:	0205a303          	lw	t1,32(a1)
  5c:	973e                	add	a4,a4,a5
  5e:	51d4                	lw	a3,36(a1)
  60:	01071613          	slli	a2,a4,0x10
  64:	010e5793          	srli	a5,t3,0x10
  68:	8fd1                	or	a5,a5,a2
  6a:	933e                	add	t1,t1,a5
  6c:	8741                	srai	a4,a4,0x10
  6e:	00f337b3          	sltu	a5,t1,a5
  72:	9736                	add	a4,a4,a3
  74:	0285af83          	lw	t6,40(a1)
  78:	973e                	add	a4,a4,a5
  7a:	55d4                	lw	a3,44(a1)
  7c:	01071613          	slli	a2,a4,0x10
  80:	01035793          	srli	a5,t1,0x10
  84:	8fd1                	or	a5,a5,a2
  86:	9fbe                	add	t6,t6,a5
  88:	8741                	srai	a4,a4,0x10
  8a:	00ffb7b3          	sltu	a5,t6,a5
  8e:	9736                	add	a4,a4,a3
  90:	0305a383          	lw	t2,48(a1)
  94:	973e                	add	a4,a4,a5
  96:	59d4                	lw	a3,52(a1)
  98:	01071613          	slli	a2,a4,0x10
  9c:	010fd793          	srli	a5,t6,0x10
  a0:	8fd1                	or	a5,a5,a2
  a2:	93be                	add	t2,t2,a5
  a4:	8741                	srai	a4,a4,0x10
  a6:	00f3b7b3          	sltu	a5,t2,a5
  aa:	9736                	add	a4,a4,a3
  ac:	973e                	add	a4,a4,a5
  ae:	0385a283          	lw	t0,56(a1)
  b2:	5dd4                	lw	a3,60(a1)
  b4:	01071613          	slli	a2,a4,0x10
  b8:	0103d793          	srli	a5,t2,0x10
  bc:	8fd1                	or	a5,a5,a2
  be:	92be                	add	t0,t0,a5
  c0:	41075893          	srai	a7,a4,0x10
  c4:	00f2b7b3          	sltu	a5,t0,a5
  c8:	98b6                	add	a7,a7,a3
  ca:	1141                	addi	sp,sp,-16
  cc:	41b8                	lw	a4,64(a1)
  ce:	98be                	add	a7,a7,a5
  d0:	c622                	sw	s0,12(sp)
  d2:	01089793          	slli	a5,a7,0x10
  d6:	41e0                	lw	s0,68(a1)
  d8:	0102d613          	srli	a2,t0,0x10
  dc:	66c1                	lui	a3,0x10
  de:	16fd                	addi	a3,a3,-1
  e0:	8e5d                	or	a2,a2,a5
  e2:	9732                	add	a4,a4,a2
  e4:	00df7f33          	and	t5,t5,a3
  e8:	00defeb3          	and	t4,t4,a3
  ec:	00de7e33          	and	t3,t3,a3
  f0:	00d37333          	and	t1,t1,a3
  f4:	00dfffb3          	and	t6,t6,a3
  f8:	00d3f3b3          	and	t2,t2,a3
  fc:	00d2f2b3          	and	t0,t0,a3
 100:	4108d893          	srai	a7,a7,0x10
 104:	98a2                	add	a7,a7,s0
 106:	01e52423          	sw	t5,8(a0)
 10a:	01d52823          	sw	t4,16(a0)
 10e:	01c52c23          	sw	t3,24(a0)
 112:	02652023          	sw	t1,32(a0)
 116:	03f52423          	sw	t6,40(a0)
 11a:	02752823          	sw	t2,48(a0)
 11e:	02552c23          	sw	t0,56(a0)
 122:	00c73633          	sltu	a2,a4,a2
 126:	00052623          	sw	zero,12(a0)
 12a:	00052a23          	sw	zero,20(a0)
 12e:	00052e23          	sw	zero,28(a0)
 132:	02052223          	sw	zero,36(a0)
 136:	02052623          	sw	zero,44(a0)
 13a:	02052a23          	sw	zero,52(a0)
 13e:	02052e23          	sw	zero,60(a0)
 142:	00d77333          	and	t1,a4,a3
 146:	9646                	add	a2,a2,a7
 148:	0485a883          	lw	a7,72(a1)
 14c:	01061e13          	slli	t3,a2,0x10
 150:	04652023          	sw	t1,64(a0)
 154:	8341                	srli	a4,a4,0x10
 156:	04c5a303          	lw	t1,76(a1)
 15a:	00ee6733          	or	a4,t3,a4
 15e:	98ba                	add	a7,a7,a4
 160:	8641                	srai	a2,a2,0x10
 162:	961a                	add	a2,a2,t1
 164:	00e8b733          	sltu	a4,a7,a4
 168:	0505a303          	lw	t1,80(a1)
 16c:	9732                	add	a4,a4,a2
 16e:	0545ae03          	lw	t3,84(a1)
 172:	01071e93          	slli	t4,a4,0x10
 176:	0108d613          	srli	a2,a7,0x10
 17a:	00cee633          	or	a2,t4,a2
 17e:	9332                	add	t1,t1,a2
 180:	8741                	srai	a4,a4,0x10
 182:	00c33633          	sltu	a2,t1,a2
 186:	9772                	add	a4,a4,t3
 188:	0585ae83          	lw	t4,88(a1)
 18c:	9732                	add	a4,a4,a2
 18e:	05c5ae03          	lw	t3,92(a1)
 192:	01071f13          	slli	t5,a4,0x10
 196:	01035613          	srli	a2,t1,0x10
 19a:	00cf6633          	or	a2,t5,a2
 19e:	9eb2                	add	t4,t4,a2
 1a0:	8741                	srai	a4,a4,0x10
 1a2:	9772                	add	a4,a4,t3
 1a4:	00ceb633          	sltu	a2,t4,a2
 1a8:	0605ae03          	lw	t3,96(a1)
 1ac:	963a                	add	a2,a2,a4
 1ae:	0645af03          	lw	t5,100(a1)
 1b2:	01061f93          	slli	t6,a2,0x10
 1b6:	010ed713          	srli	a4,t4,0x10
 1ba:	00efe733          	or	a4,t6,a4
 1be:	9e3a                	add	t3,t3,a4
 1c0:	8641                	srai	a2,a2,0x10
 1c2:	00ee3733          	sltu	a4,t3,a4
 1c6:	967a                	add	a2,a2,t5
 1c8:	963a                	add	a2,a2,a4
 1ca:	0685af03          	lw	t5,104(a1)
 1ce:	06c5af83          	lw	t6,108(a1)
 1d2:	01061293          	slli	t0,a2,0x10
 1d6:	010e5713          	srli	a4,t3,0x10
 1da:	00e2e733          	or	a4,t0,a4
 1de:	9f3a                	add	t5,t5,a4
 1e0:	8641                	srai	a2,a2,0x10
 1e2:	00ef3733          	sltu	a4,t5,a4
 1e6:	967e                	add	a2,a2,t6
 1e8:	963a                	add	a2,a2,a4
 1ea:	0705af83          	lw	t6,112(a1)
 1ee:	0745a283          	lw	t0,116(a1)
 1f2:	01061393          	slli	t2,a2,0x10
 1f6:	010f5713          	srli	a4,t5,0x10
 1fa:	00e3e733          	or	a4,t2,a4
 1fe:	9fba                	add	t6,t6,a4
 200:	8641                	srai	a2,a2,0x10
 202:	00efb733          	sltu	a4,t6,a4
 206:	9616                	add	a2,a2,t0
 208:	0785a383          	lw	t2,120(a1)
 20c:	963a                	add	a2,a2,a4
 20e:	07c5a283          	lw	t0,124(a1)
 212:	010fd713          	srli	a4,t6,0x10
 216:	01061593          	slli	a1,a2,0x10
 21a:	8f4d                	or	a4,a4,a1
 21c:	007705b3          	add	a1,a4,t2
 220:	8641                	srai	a2,a2,0x10
 222:	9616                	add	a2,a2,t0
 224:	00e5b733          	sltu	a4,a1,a4
 228:	9732                	add	a4,a4,a2
 22a:	01071613          	slli	a2,a4,0x10
 22e:	0105d413          	srli	s0,a1,0x10
 232:	02600393          	li	t2,38
 236:	8c51                	or	s0,s0,a2
 238:	02838633          	mul	a2,t2,s0
 23c:	8741                	srai	a4,a4,0x10
 23e:	00d8f2b3          	and	t0,a7,a3
 242:	00d87833          	and	a6,a6,a3
 246:	00d37333          	and	t1,t1,a3
 24a:	00defeb3          	and	t4,t4,a3
 24e:	00de7e33          	and	t3,t3,a3
 252:	00df7f33          	and	t5,t5,a3
 256:	00dfffb3          	and	t6,t6,a3
 25a:	8eed                	and	a3,a3,a1
 25c:	0283b8b3          	mulhu	a7,t2,s0
 260:	9832                	add	a6,a6,a2
 262:	00c83633          	sltu	a2,a6,a2
 266:	04052223          	sw	zero,68(a0)
 26a:	04552423          	sw	t0,72(a0)
 26e:	04052623          	sw	zero,76(a0)
 272:	04652823          	sw	t1,80(a0)
 276:	04052a23          	sw	zero,84(a0)
 27a:	05d52c23          	sw	t4,88(a0)
 27e:	04052e23          	sw	zero,92(a0)
 282:	02e38733          	mul	a4,t2,a4
 286:	07c52023          	sw	t3,96(a0)
 28a:	06052223          	sw	zero,100(a0)
 28e:	07e52423          	sw	t5,104(a0)
 292:	06052623          	sw	zero,108(a0)
 296:	07f52823          	sw	t6,112(a0)
 29a:	06052a23          	sw	zero,116(a0)
 29e:	01052023          	sw	a6,0(a0)
 2a2:	dd34                	sw	a3,120(a0)
 2a4:	06052e23          	sw	zero,124(a0)
 2a8:	9746                	add	a4,a4,a7
 2aa:	9732                	add	a4,a4,a2
 2ac:	c158                	sw	a4,4(a0)
 2ae:	4432                	lw	s0,12(sp)
 2b0:	0141                	addi	sp,sp,16
 2b2:	8082                	ret

Disassembly of section .text.sparknacl__car__sum_to_nearlynormal:

00000000 <sparknacl__car__sum_to_nearlynormal>:
   0:	41d8                	lw	a4,4(a1)
   2:	4194                	lw	a3,0(a1)
   4:	4785                	li	a5,1
   6:	2ce05163          	blez	a4,2c8 <.L40>

0000000a <.L7>:
   a:	4590                	lw	a2,8(a1)
   c:	45d8                	lw	a4,12(a1)
   e:	00052623          	sw	zero,12(a0)
  12:	963e                	add	a2,a2,a5
  14:	01061813          	slli	a6,a2,0x10
  18:	00f637b3          	sltu	a5,a2,a5
  1c:	01085813          	srli	a6,a6,0x10
  20:	973e                	add	a4,a4,a5
  22:	01052423          	sw	a6,8(a0)
  26:	4785                	li	a5,1
  28:	6841                	lui	a6,0x10
  2a:	28e05a63          	blez	a4,2be <.L41>

0000002e <.L9>:
  2e:	4990                	lw	a2,16(a1)
  30:	49d8                	lw	a4,20(a1)
  32:	00052a23          	sw	zero,20(a0)
  36:	963e                	add	a2,a2,a5
  38:	01061813          	slli	a6,a2,0x10
  3c:	00f637b3          	sltu	a5,a2,a5
  40:	01085813          	srli	a6,a6,0x10
  44:	973e                	add	a4,a4,a5
  46:	01052823          	sw	a6,16(a0)
  4a:	4785                	li	a5,1
  4c:	6841                	lui	a6,0x10
  4e:	26e05363          	blez	a4,2b4 <.L42>

00000052 <.L11>:
  52:	4d90                	lw	a2,24(a1)
  54:	4dd8                	lw	a4,28(a1)
  56:	00052e23          	sw	zero,28(a0)
  5a:	963e                	add	a2,a2,a5
  5c:	01061813          	slli	a6,a2,0x10
  60:	00f637b3          	sltu	a5,a2,a5
  64:	01085813          	srli	a6,a6,0x10
  68:	973e                	add	a4,a4,a5
  6a:	01052c23          	sw	a6,24(a0)
  6e:	4785                	li	a5,1
  70:	6841                	lui	a6,0x10
  72:	22e05c63          	blez	a4,2aa <.L43>

00000076 <.L13>:
  76:	5190                	lw	a2,32(a1)
  78:	51d8                	lw	a4,36(a1)
  7a:	02052223          	sw	zero,36(a0)
  7e:	963e                	add	a2,a2,a5
  80:	01061813          	slli	a6,a2,0x10
  84:	00f637b3          	sltu	a5,a2,a5
  88:	01085813          	srli	a6,a6,0x10
  8c:	973e                	add	a4,a4,a5
  8e:	03052023          	sw	a6,32(a0)
  92:	4785                	li	a5,1
  94:	6841                	lui	a6,0x10
  96:	20e05563          	blez	a4,2a0 <.L44>

0000009a <.L15>:
  9a:	5590                	lw	a2,40(a1)
  9c:	55d8                	lw	a4,44(a1)
  9e:	02052623          	sw	zero,44(a0)
  a2:	963e                	add	a2,a2,a5
  a4:	01061813          	slli	a6,a2,0x10
  a8:	00f637b3          	sltu	a5,a2,a5
  ac:	01085813          	srli	a6,a6,0x10
  b0:	973e                	add	a4,a4,a5
  b2:	03052423          	sw	a6,40(a0)
  b6:	4785                	li	a5,1
  b8:	6841                	lui	a6,0x10
  ba:	1ce05e63          	blez	a4,296 <.L45>

000000be <.L17>:
  be:	5990                	lw	a2,48(a1)
  c0:	59d8                	lw	a4,52(a1)
  c2:	02052a23          	sw	zero,52(a0)
  c6:	963e                	add	a2,a2,a5
  c8:	01061813          	slli	a6,a2,0x10
  cc:	00f637b3          	sltu	a5,a2,a5
  d0:	01085813          	srli	a6,a6,0x10
  d4:	973e                	add	a4,a4,a5
  d6:	03052823          	sw	a6,48(a0)
  da:	4785                	li	a5,1
  dc:	6841                	lui	a6,0x10
  de:	1ae05763          	blez	a4,28c <.L46>

000000e2 <.L19>:
  e2:	5d90                	lw	a2,56(a1)
  e4:	5dd8                	lw	a4,60(a1)
  e6:	02052e23          	sw	zero,60(a0)
  ea:	963e                	add	a2,a2,a5
  ec:	01061813          	slli	a6,a2,0x10
  f0:	00f637b3          	sltu	a5,a2,a5
  f4:	01085813          	srli	a6,a6,0x10
  f8:	973e                	add	a4,a4,a5
  fa:	03052c23          	sw	a6,56(a0)
  fe:	4785                	li	a5,1
 100:	6841                	lui	a6,0x10
 102:	18e05063          	blez	a4,282 <.L47>

00000106 <.L21>:
 106:	41b0                	lw	a2,64(a1)
 108:	41f8                	lw	a4,68(a1)
 10a:	04052223          	sw	zero,68(a0)
 10e:	963e                	add	a2,a2,a5
 110:	01061813          	slli	a6,a2,0x10
 114:	00f637b3          	sltu	a5,a2,a5
 118:	01085813          	srli	a6,a6,0x10
 11c:	973e                	add	a4,a4,a5
 11e:	05052023          	sw	a6,64(a0)
 122:	4785                	li	a5,1
 124:	6841                	lui	a6,0x10
 126:	14e05963          	blez	a4,278 <.L48>

0000012a <.L23>:
 12a:	45b0                	lw	a2,72(a1)
 12c:	45f8                	lw	a4,76(a1)
 12e:	04052623          	sw	zero,76(a0)
 132:	963e                	add	a2,a2,a5
 134:	01061813          	slli	a6,a2,0x10
 138:	00f637b3          	sltu	a5,a2,a5
 13c:	01085813          	srli	a6,a6,0x10
 140:	973e                	add	a4,a4,a5
 142:	05052423          	sw	a6,72(a0)
 146:	4785                	li	a5,1
 148:	6841                	lui	a6,0x10
 14a:	12e05263          	blez	a4,26e <.L49>

0000014e <.L25>:
 14e:	49b0                	lw	a2,80(a1)
 150:	49f8                	lw	a4,84(a1)
 152:	04052a23          	sw	zero,84(a0)
 156:	963e                	add	a2,a2,a5
 158:	01061813          	slli	a6,a2,0x10
 15c:	00f637b3          	sltu	a5,a2,a5
 160:	01085813          	srli	a6,a6,0x10
 164:	973e                	add	a4,a4,a5
 166:	05052823          	sw	a6,80(a0)
 16a:	4785                	li	a5,1
 16c:	6841                	lui	a6,0x10
 16e:	0ee05b63          	blez	a4,264 <.L50>

00000172 <.L27>:
 172:	4db0                	lw	a2,88(a1)
 174:	4df8                	lw	a4,92(a1)
 176:	04052e23          	sw	zero,92(a0)
 17a:	963e                	add	a2,a2,a5
 17c:	01061813          	slli	a6,a2,0x10
 180:	00f637b3          	sltu	a5,a2,a5
 184:	01085813          	srli	a6,a6,0x10
 188:	973e                	add	a4,a4,a5
 18a:	05052c23          	sw	a6,88(a0)
 18e:	4785                	li	a5,1
 190:	6841                	lui	a6,0x10
 192:	0ce05463          	blez	a4,25a <.L51>

00000196 <.L29>:
 196:	51b0                	lw	a2,96(a1)
 198:	51f8                	lw	a4,100(a1)
 19a:	06052223          	sw	zero,100(a0)
 19e:	963e                	add	a2,a2,a5
 1a0:	01061813          	slli	a6,a2,0x10
 1a4:	00f637b3          	sltu	a5,a2,a5
 1a8:	01085813          	srli	a6,a6,0x10
 1ac:	973e                	add	a4,a4,a5
 1ae:	07052023          	sw	a6,96(a0)
 1b2:	4785                	li	a5,1
 1b4:	6841                	lui	a6,0x10
 1b6:	08e05d63          	blez	a4,250 <.L52>

000001ba <.L31>:
 1ba:	55b0                	lw	a2,104(a1)
 1bc:	55f8                	lw	a4,108(a1)
 1be:	06052623          	sw	zero,108(a0)
 1c2:	963e                	add	a2,a2,a5
 1c4:	01061813          	slli	a6,a2,0x10
 1c8:	00f637b3          	sltu	a5,a2,a5
 1cc:	01085813          	srli	a6,a6,0x10
 1d0:	973e                	add	a4,a4,a5
 1d2:	07052423          	sw	a6,104(a0)
 1d6:	4785                	li	a5,1
 1d8:	6841                	lui	a6,0x10
 1da:	06e05663          	blez	a4,246 <.L53>

000001de <.L33>:
 1de:	59b0                	lw	a2,112(a1)
 1e0:	59f8                	lw	a4,116(a1)
 1e2:	06052a23          	sw	zero,116(a0)
 1e6:	963e                	add	a2,a2,a5
 1e8:	01061813          	slli	a6,a2,0x10
 1ec:	00f637b3          	sltu	a5,a2,a5
 1f0:	01085813          	srli	a6,a6,0x10
 1f4:	973e                	add	a4,a4,a5
 1f6:	07052823          	sw	a6,112(a0)
 1fa:	4785                	li	a5,1
 1fc:	6841                	lui	a6,0x10
 1fe:	02e05f63          	blez	a4,23c <.L54>

00000202 <.L35>:
 202:	5db8                	lw	a4,120(a1)
 204:	5df0                	lw	a2,124(a1)
 206:	06c2                	slli	a3,a3,0x10
 208:	973e                	add	a4,a4,a5
 20a:	00f737b3          	sltu	a5,a4,a5
 20e:	97b2                	add	a5,a5,a2
 210:	65c1                	lui	a1,0x10
 212:	82c1                	srli	a3,a3,0x10
 214:	00f05f63          	blez	a5,232 <.L55>

00000218 <.L39>:
 218:	02600793          	li	a5,38

0000021c <.L38>:
 21c:	97b6                	add	a5,a5,a3
 21e:	0742                	slli	a4,a4,0x10
 220:	00d7b6b3          	sltu	a3,a5,a3
 224:	8341                	srli	a4,a4,0x10
 226:	c11c                	sw	a5,0(a0)
 228:	c154                	sw	a3,4(a0)
 22a:	dd38                	sw	a4,120(a0)
 22c:	06052e23          	sw	zero,124(a0)
 230:	8082                	ret

00000232 <.L55>:
 232:	e399                	bnez	a5,238 <.L37>
 234:	feb772e3          	bgeu	a4,a1,218 <.L39>

00000238 <.L37>:
 238:	4781                	li	a5,0
 23a:	b7cd                	j	21c <.L38>

0000023c <.L54>:
 23c:	e319                	bnez	a4,242 <.L36>
 23e:	fd0672e3          	bgeu	a2,a6,202 <.L35>

00000242 <.L36>:
 242:	4781                	li	a5,0
 244:	bf7d                	j	202 <.L35>

00000246 <.L53>:
 246:	e319                	bnez	a4,24c <.L34>
 248:	f9067be3          	bgeu	a2,a6,1de <.L33>

0000024c <.L34>:
 24c:	4781                	li	a5,0
 24e:	bf41                	j	1de <.L33>

00000250 <.L52>:
 250:	e319                	bnez	a4,256 <.L32>
 252:	f70674e3          	bgeu	a2,a6,1ba <.L31>

00000256 <.L32>:
 256:	4781                	li	a5,0
 258:	b78d                	j	1ba <.L31>

0000025a <.L51>:
 25a:	e319                	bnez	a4,260 <.L30>
 25c:	f3067de3          	bgeu	a2,a6,196 <.L29>

00000260 <.L30>:
 260:	4781                	li	a5,0
 262:	bf15                	j	196 <.L29>

00000264 <.L50>:
 264:	e319                	bnez	a4,26a <.L28>
 266:	f10676e3          	bgeu	a2,a6,172 <.L27>

0000026a <.L28>:
 26a:	4781                	li	a5,0
 26c:	b719                	j	172 <.L27>

0000026e <.L49>:
 26e:	e319                	bnez	a4,274 <.L26>
 270:	ed067fe3          	bgeu	a2,a6,14e <.L25>

00000274 <.L26>:
 274:	4781                	li	a5,0
 276:	bde1                	j	14e <.L25>

00000278 <.L48>:
 278:	e319                	bnez	a4,27e <.L24>
 27a:	eb0678e3          	bgeu	a2,a6,12a <.L23>

0000027e <.L24>:
 27e:	4781                	li	a5,0
 280:	b56d                	j	12a <.L23>

00000282 <.L47>:
 282:	e319                	bnez	a4,288 <.L22>
 284:	e90671e3          	bgeu	a2,a6,106 <.L21>

00000288 <.L22>:
 288:	4781                	li	a5,0
 28a:	bdb5                	j	106 <.L21>

0000028c <.L46>:
 28c:	e319                	bnez	a4,292 <.L20>
 28e:	e5067ae3          	bgeu	a2,a6,e2 <.L19>

00000292 <.L20>:
 292:	4781                	li	a5,0
 294:	b5b9                	j	e2 <.L19>

00000296 <.L45>:
 296:	e319                	bnez	a4,29c <.L18>
 298:	e30673e3          	bgeu	a2,a6,be <.L17>

0000029c <.L18>:
 29c:	4781                	li	a5,0
 29e:	b505                	j	be <.L17>

000002a0 <.L44>:
 2a0:	e319                	bnez	a4,2a6 <.L16>
 2a2:	df067ce3          	bgeu	a2,a6,9a <.L15>

000002a6 <.L16>:
 2a6:	4781                	li	a5,0
 2a8:	bbcd                	j	9a <.L15>

000002aa <.L43>:
 2aa:	e319                	bnez	a4,2b0 <.L14>
 2ac:	dd0675e3          	bgeu	a2,a6,76 <.L13>

000002b0 <.L14>:
 2b0:	4781                	li	a5,0
 2b2:	b3d1                	j	76 <.L13>

000002b4 <.L42>:
 2b4:	e319                	bnez	a4,2ba <.L12>
 2b6:	d9067ee3          	bgeu	a2,a6,52 <.L11>

000002ba <.L12>:
 2ba:	4781                	li	a5,0
 2bc:	bb59                	j	52 <.L11>

000002be <.L41>:
 2be:	e319                	bnez	a4,2c4 <.L10>
 2c0:	d70677e3          	bgeu	a2,a6,2e <.L9>

000002c4 <.L10>:
 2c4:	4781                	li	a5,0
 2c6:	b3a5                	j	2e <.L9>

000002c8 <.L40>:
 2c8:	e701                	bnez	a4,2d0 <.L8>
 2ca:	6741                	lui	a4,0x10
 2cc:	d2e6ffe3          	bgeu	a3,a4,a <.L7>

000002d0 <.L8>:
 2d0:	4781                	li	a5,0
 2d2:	bb25                	j	a <.L7>

Disassembly of section .text.sparknacl__car__difference_to_nearlynormal:

00000000 <sparknacl__car__difference_to_nearlynormal>:
   0:	0005a803          	lw	a6,0(a1) # 10000 <.L8+0xfd30>
   4:	41d8                	lw	a4,4(a1)
   6:	0085af03          	lw	t5,8(a1)
   a:	45d4                	lw	a3,12(a1)
   c:	01071613          	slli	a2,a4,0x10
  10:	01085793          	srli	a5,a6,0x10
  14:	8fd1                	or	a5,a5,a2
  16:	9f3e                	add	t5,t5,a5
  18:	8741                	srai	a4,a4,0x10
  1a:	00ff37b3          	sltu	a5,t5,a5
  1e:	9736                	add	a4,a4,a3
  20:	0105ae83          	lw	t4,16(a1)
  24:	973e                	add	a4,a4,a5
  26:	49d4                	lw	a3,20(a1)
  28:	01071613          	slli	a2,a4,0x10
  2c:	010f5793          	srli	a5,t5,0x10
  30:	8fd1                	or	a5,a5,a2
  32:	9ebe                	add	t4,t4,a5
  34:	8741                	srai	a4,a4,0x10
  36:	00feb7b3          	sltu	a5,t4,a5
  3a:	9736                	add	a4,a4,a3
  3c:	0185ae03          	lw	t3,24(a1)
  40:	973e                	add	a4,a4,a5
  42:	4dd4                	lw	a3,28(a1)
  44:	01071613          	slli	a2,a4,0x10
  48:	010ed793          	srli	a5,t4,0x10
  4c:	8fd1                	or	a5,a5,a2
  4e:	9e3e                	add	t3,t3,a5
  50:	8741                	srai	a4,a4,0x10
  52:	00fe37b3          	sltu	a5,t3,a5
  56:	9736                	add	a4,a4,a3
  58:	0205a303          	lw	t1,32(a1)
  5c:	973e                	add	a4,a4,a5
  5e:	51d4                	lw	a3,36(a1)
  60:	01071613          	slli	a2,a4,0x10
  64:	010e5793          	srli	a5,t3,0x10
  68:	8fd1                	or	a5,a5,a2
  6a:	933e                	add	t1,t1,a5
  6c:	8741                	srai	a4,a4,0x10
  6e:	00f337b3          	sltu	a5,t1,a5
  72:	9736                	add	a4,a4,a3
  74:	0285af83          	lw	t6,40(a1)
  78:	973e                	add	a4,a4,a5
  7a:	55d4                	lw	a3,44(a1)
  7c:	01071613          	slli	a2,a4,0x10
  80:	01035793          	srli	a5,t1,0x10
  84:	8fd1                	or	a5,a5,a2
  86:	9fbe                	add	t6,t6,a5
  88:	8741                	srai	a4,a4,0x10
  8a:	00ffb7b3          	sltu	a5,t6,a5
  8e:	9736                	add	a4,a4,a3
  90:	0305a383          	lw	t2,48(a1)
  94:	973e                	add	a4,a4,a5
  96:	59d4                	lw	a3,52(a1)
  98:	01071613          	slli	a2,a4,0x10
  9c:	010fd793          	srli	a5,t6,0x10
  a0:	8fd1                	or	a5,a5,a2
  a2:	93be                	add	t2,t2,a5
  a4:	8741                	srai	a4,a4,0x10
  a6:	00f3b7b3          	sltu	a5,t2,a5
  aa:	9736                	add	a4,a4,a3
  ac:	973e                	add	a4,a4,a5
  ae:	0385a283          	lw	t0,56(a1)
  b2:	5dd4                	lw	a3,60(a1)
  b4:	01071613          	slli	a2,a4,0x10
  b8:	0103d793          	srli	a5,t2,0x10
  bc:	8fd1                	or	a5,a5,a2
  be:	92be                	add	t0,t0,a5
  c0:	41075893          	srai	a7,a4,0x10
  c4:	00f2b7b3          	sltu	a5,t0,a5
  c8:	98b6                	add	a7,a7,a3
  ca:	1141                	addi	sp,sp,-16
  cc:	41b8                	lw	a4,64(a1)
  ce:	98be                	add	a7,a7,a5
  d0:	c622                	sw	s0,12(sp)
  d2:	01089793          	slli	a5,a7,0x10
  d6:	41e0                	lw	s0,68(a1)
  d8:	0102d613          	srli	a2,t0,0x10
  dc:	66c1                	lui	a3,0x10
  de:	16fd                	addi	a3,a3,-1
  e0:	8e5d                	or	a2,a2,a5
  e2:	9732                	add	a4,a4,a2
  e4:	00df7f33          	and	t5,t5,a3
  e8:	00defeb3          	and	t4,t4,a3
  ec:	00de7e33          	and	t3,t3,a3
  f0:	00d37333          	and	t1,t1,a3
  f4:	00dfffb3          	and	t6,t6,a3
  f8:	00d3f3b3          	and	t2,t2,a3
  fc:	00d2f2b3          	and	t0,t0,a3
 100:	4108d893          	srai	a7,a7,0x10
 104:	98a2                	add	a7,a7,s0
 106:	01e52423          	sw	t5,8(a0)
 10a:	01d52823          	sw	t4,16(a0)
 10e:	01c52c23          	sw	t3,24(a0)
 112:	02652023          	sw	t1,32(a0)
 116:	03f52423          	sw	t6,40(a0)
 11a:	02752823          	sw	t2,48(a0)
 11e:	02552c23          	sw	t0,56(a0)
 122:	00c73633          	sltu	a2,a4,a2
 126:	00052623          	sw	zero,12(a0)
 12a:	00052a23          	sw	zero,20(a0)
 12e:	00052e23          	sw	zero,28(a0)
 132:	02052223          	sw	zero,36(a0)
 136:	02052623          	sw	zero,44(a0)
 13a:	02052a23          	sw	zero,52(a0)
 13e:	02052e23          	sw	zero,60(a0)
 142:	00d77333          	and	t1,a4,a3
 146:	9646                	add	a2,a2,a7
 148:	0485a883          	lw	a7,72(a1)
 14c:	01061e13          	slli	t3,a2,0x10
 150:	04652023          	sw	t1,64(a0)
 154:	8341                	srli	a4,a4,0x10
 156:	04c5a303          	lw	t1,76(a1)
 15a:	00ee6733          	or	a4,t3,a4
 15e:	98ba                	add	a7,a7,a4
 160:	8641                	srai	a2,a2,0x10
 162:	961a                	add	a2,a2,t1
 164:	00e8b733          	sltu	a4,a7,a4
 168:	0505a303          	lw	t1,80(a1)
 16c:	9732                	add	a4,a4,a2
 16e:	0545ae03          	lw	t3,84(a1)
 172:	01071e93          	slli	t4,a4,0x10
 176:	0108d613          	srli	a2,a7,0x10
 17a:	00cee633          	or	a2,t4,a2
 17e:	9332                	add	t1,t1,a2
 180:	8741                	srai	a4,a4,0x10
 182:	00c33633          	sltu	a2,t1,a2
 186:	9772                	add	a4,a4,t3
 188:	0585ae83          	lw	t4,88(a1)
 18c:	9732                	add	a4,a4,a2
 18e:	05c5ae03          	lw	t3,92(a1)
 192:	01071f13          	slli	t5,a4,0x10
 196:	01035613          	srli	a2,t1,0x10
 19a:	00cf6633          	or	a2,t5,a2
 19e:	9eb2                	add	t4,t4,a2
 1a0:	8741                	srai	a4,a4,0x10
 1a2:	9772                	add	a4,a4,t3
 1a4:	00ceb633          	sltu	a2,t4,a2
 1a8:	0605ae03          	lw	t3,96(a1)
 1ac:	963a                	add	a2,a2,a4
 1ae:	0645af03          	lw	t5,100(a1)
 1b2:	01061f93          	slli	t6,a2,0x10
 1b6:	010ed713          	srli	a4,t4,0x10
 1ba:	00efe733          	or	a4,t6,a4
 1be:	9e3a                	add	t3,t3,a4
 1c0:	8641                	srai	a2,a2,0x10
 1c2:	00ee3733          	sltu	a4,t3,a4
 1c6:	967a                	add	a2,a2,t5
 1c8:	963a                	add	a2,a2,a4
 1ca:	0685af03          	lw	t5,104(a1)
 1ce:	06c5af83          	lw	t6,108(a1)
 1d2:	01061293          	slli	t0,a2,0x10
 1d6:	010e5713          	srli	a4,t3,0x10
 1da:	00e2e733          	or	a4,t0,a4
 1de:	9f3a                	add	t5,t5,a4
 1e0:	8641                	srai	a2,a2,0x10
 1e2:	00ef3733          	sltu	a4,t5,a4
 1e6:	967e                	add	a2,a2,t6
 1e8:	963a                	add	a2,a2,a4
 1ea:	0705af83          	lw	t6,112(a1)
 1ee:	0745a283          	lw	t0,116(a1)
 1f2:	01061393          	slli	t2,a2,0x10
 1f6:	010f5713          	srli	a4,t5,0x10
 1fa:	00e3e733          	or	a4,t2,a4
 1fe:	9fba                	add	t6,t6,a4
 200:	8641                	srai	a2,a2,0x10
 202:	00efb733          	sltu	a4,t6,a4
 206:	9616                	add	a2,a2,t0
 208:	0785a383          	lw	t2,120(a1)
 20c:	963a                	add	a2,a2,a4
 20e:	07c5a283          	lw	t0,124(a1)
 212:	010fd713          	srli	a4,t6,0x10
 216:	01061593          	slli	a1,a2,0x10
 21a:	8f4d                	or	a4,a4,a1
 21c:	007705b3          	add	a1,a4,t2
 220:	8641                	srai	a2,a2,0x10
 222:	9616                	add	a2,a2,t0
 224:	00e5b733          	sltu	a4,a1,a4
 228:	9732                	add	a4,a4,a2
 22a:	01071613          	slli	a2,a4,0x10
 22e:	0105d413          	srli	s0,a1,0x10
 232:	02600393          	li	t2,38
 236:	8c51                	or	s0,s0,a2
 238:	02838633          	mul	a2,t2,s0
 23c:	8741                	srai	a4,a4,0x10
 23e:	00d8f2b3          	and	t0,a7,a3
 242:	00d87833          	and	a6,a6,a3
 246:	00d37333          	and	t1,t1,a3
 24a:	00defeb3          	and	t4,t4,a3
 24e:	00de7e33          	and	t3,t3,a3
 252:	00df7f33          	and	t5,t5,a3
 256:	00dfffb3          	and	t6,t6,a3
 25a:	8eed                	and	a3,a3,a1
 25c:	0283b8b3          	mulhu	a7,t2,s0
 260:	9832                	add	a6,a6,a2
 262:	00c83633          	sltu	a2,a6,a2
 266:	04052223          	sw	zero,68(a0)
 26a:	04552423          	sw	t0,72(a0)
 26e:	04052623          	sw	zero,76(a0)
 272:	04652823          	sw	t1,80(a0)
 276:	04052a23          	sw	zero,84(a0)
 27a:	05d52c23          	sw	t4,88(a0)
 27e:	04052e23          	sw	zero,92(a0)
 282:	02e38733          	mul	a4,t2,a4
 286:	07c52023          	sw	t3,96(a0)
 28a:	06052223          	sw	zero,100(a0)
 28e:	07e52423          	sw	t5,104(a0)
 292:	06052623          	sw	zero,108(a0)
 296:	07f52823          	sw	t6,112(a0)
 29a:	06052a23          	sw	zero,116(a0)
 29e:	01052023          	sw	a6,0(a0)
 2a2:	dd34                	sw	a3,120(a0)
 2a4:	06052e23          	sw	zero,124(a0)
 2a8:	9746                	add	a4,a4,a7
 2aa:	9732                	add	a4,a4,a2
 2ac:	c158                	sw	a4,4(a0)
 2ae:	4432                	lw	s0,12(sp)
 2b0:	0141                	addi	sp,sp,16
 2b2:	8082                	ret

Disassembly of section .text.sparknacl__car__nearlynormal_to_normal:

00000000 <sparknacl__car__nearlynormal_to_normal>:
   0:	0005a803          	lw	a6,0(a1)
   4:	41d8                	lw	a4,4(a1)
   6:	0085af03          	lw	t5,8(a1)
   a:	45d4                	lw	a3,12(a1)
   c:	01071613          	slli	a2,a4,0x10
  10:	01085793          	srli	a5,a6,0x10
  14:	8fd1                	or	a5,a5,a2
  16:	9f3e                	add	t5,t5,a5
  18:	8741                	srai	a4,a4,0x10
  1a:	00ff37b3          	sltu	a5,t5,a5
  1e:	9736                	add	a4,a4,a3
  20:	0105ae83          	lw	t4,16(a1)
  24:	973e                	add	a4,a4,a5
  26:	49d4                	lw	a3,20(a1)
  28:	01071613          	slli	a2,a4,0x10
  2c:	010f5793          	srli	a5,t5,0x10
  30:	8fd1                	or	a5,a5,a2
  32:	9ebe                	add	t4,t4,a5
  34:	8741                	srai	a4,a4,0x10
  36:	00feb7b3          	sltu	a5,t4,a5
  3a:	9736                	add	a4,a4,a3
  3c:	0185ae03          	lw	t3,24(a1)
  40:	973e                	add	a4,a4,a5
  42:	4dd4                	lw	a3,28(a1)
  44:	01071613          	slli	a2,a4,0x10
  48:	010ed793          	srli	a5,t4,0x10
  4c:	8fd1                	or	a5,a5,a2
  4e:	9e3e                	add	t3,t3,a5
  50:	8741                	srai	a4,a4,0x10
  52:	00fe37b3          	sltu	a5,t3,a5
  56:	9736                	add	a4,a4,a3
  58:	0205a303          	lw	t1,32(a1)
  5c:	973e                	add	a4,a4,a5
  5e:	51d4                	lw	a3,36(a1)
  60:	01071613          	slli	a2,a4,0x10
  64:	010e5793          	srli	a5,t3,0x10
  68:	8fd1                	or	a5,a5,a2
  6a:	933e                	add	t1,t1,a5
  6c:	8741                	srai	a4,a4,0x10
  6e:	00f337b3          	sltu	a5,t1,a5
  72:	9736                	add	a4,a4,a3
  74:	0285af83          	lw	t6,40(a1)
  78:	973e                	add	a4,a4,a5
  7a:	55d4                	lw	a3,44(a1)
  7c:	01071613          	slli	a2,a4,0x10
  80:	01035793          	srli	a5,t1,0x10
  84:	8fd1                	or	a5,a5,a2
  86:	9fbe                	add	t6,t6,a5
  88:	8741                	srai	a4,a4,0x10
  8a:	00ffb7b3          	sltu	a5,t6,a5
  8e:	9736                	add	a4,a4,a3
  90:	0305a383          	lw	t2,48(a1)
  94:	973e                	add	a4,a4,a5
  96:	59d4                	lw	a3,52(a1)
  98:	01071613          	slli	a2,a4,0x10
  9c:	010fd793          	srli	a5,t6,0x10
  a0:	8fd1                	or	a5,a5,a2
  a2:	93be                	add	t2,t2,a5
  a4:	8741                	srai	a4,a4,0x10
  a6:	00f3b7b3          	sltu	a5,t2,a5
  aa:	9736                	add	a4,a4,a3
  ac:	973e                	add	a4,a4,a5
  ae:	0385a283          	lw	t0,56(a1)
  b2:	5dd4                	lw	a3,60(a1)
  b4:	01071613          	slli	a2,a4,0x10
  b8:	0103d793          	srli	a5,t2,0x10
  bc:	8fd1                	or	a5,a5,a2
  be:	92be                	add	t0,t0,a5
  c0:	41075893          	srai	a7,a4,0x10
  c4:	00f2b7b3          	sltu	a5,t0,a5
  c8:	98b6                	add	a7,a7,a3
  ca:	1141                	addi	sp,sp,-16
  cc:	41b8                	lw	a4,64(a1)
  ce:	98be                	add	a7,a7,a5
  d0:	c622                	sw	s0,12(sp)
  d2:	01089793          	slli	a5,a7,0x10
  d6:	41e0                	lw	s0,68(a1)
  d8:	0102d613          	srli	a2,t0,0x10
  dc:	66c1                	lui	a3,0x10
  de:	16fd                	addi	a3,a3,-1
  e0:	8e5d                	or	a2,a2,a5
  e2:	9732                	add	a4,a4,a2
  e4:	00df7f33          	and	t5,t5,a3
  e8:	00defeb3          	and	t4,t4,a3
  ec:	00de7e33          	and	t3,t3,a3
  f0:	00d37333          	and	t1,t1,a3
  f4:	00dfffb3          	and	t6,t6,a3
  f8:	00d3f3b3          	and	t2,t2,a3
  fc:	00d2f2b3          	and	t0,t0,a3
 100:	4108d893          	srai	a7,a7,0x10
 104:	98a2                	add	a7,a7,s0
 106:	01e52423          	sw	t5,8(a0)
 10a:	01d52823          	sw	t4,16(a0)
 10e:	01c52c23          	sw	t3,24(a0)
 112:	02652023          	sw	t1,32(a0)
 116:	03f52423          	sw	t6,40(a0)
 11a:	02752823          	sw	t2,48(a0)
 11e:	02552c23          	sw	t0,56(a0)
 122:	00c73633          	sltu	a2,a4,a2
 126:	00052623          	sw	zero,12(a0)
 12a:	00052a23          	sw	zero,20(a0)
 12e:	00052e23          	sw	zero,28(a0)
 132:	02052223          	sw	zero,36(a0)
 136:	02052623          	sw	zero,44(a0)
 13a:	02052a23          	sw	zero,52(a0)
 13e:	02052e23          	sw	zero,60(a0)
 142:	00d77333          	and	t1,a4,a3
 146:	9646                	add	a2,a2,a7
 148:	0485a883          	lw	a7,72(a1)
 14c:	01061e13          	slli	t3,a2,0x10
 150:	04652023          	sw	t1,64(a0)
 154:	8341                	srli	a4,a4,0x10
 156:	04c5a303          	lw	t1,76(a1)
 15a:	00ee6733          	or	a4,t3,a4
 15e:	98ba                	add	a7,a7,a4
 160:	8641                	srai	a2,a2,0x10
 162:	961a                	add	a2,a2,t1
 164:	00e8b733          	sltu	a4,a7,a4
 168:	0505a303          	lw	t1,80(a1)
 16c:	9732                	add	a4,a4,a2
 16e:	0545ae03          	lw	t3,84(a1)
 172:	01071e93          	slli	t4,a4,0x10
 176:	0108d613          	srli	a2,a7,0x10
 17a:	00cee633          	or	a2,t4,a2
 17e:	9332                	add	t1,t1,a2
 180:	8741                	srai	a4,a4,0x10
 182:	00c33633          	sltu	a2,t1,a2
 186:	9772                	add	a4,a4,t3
 188:	0585ae83          	lw	t4,88(a1)
 18c:	9732                	add	a4,a4,a2
 18e:	05c5ae03          	lw	t3,92(a1)
 192:	01071f13          	slli	t5,a4,0x10
 196:	01035613          	srli	a2,t1,0x10
 19a:	00cf6633          	or	a2,t5,a2
 19e:	9eb2                	add	t4,t4,a2
 1a0:	8741                	srai	a4,a4,0x10
 1a2:	9772                	add	a4,a4,t3
 1a4:	00ceb633          	sltu	a2,t4,a2
 1a8:	0605ae03          	lw	t3,96(a1)
 1ac:	963a                	add	a2,a2,a4
 1ae:	0645af03          	lw	t5,100(a1)
 1b2:	01061f93          	slli	t6,a2,0x10
 1b6:	010ed713          	srli	a4,t4,0x10
 1ba:	00efe733          	or	a4,t6,a4
 1be:	9e3a                	add	t3,t3,a4
 1c0:	8641                	srai	a2,a2,0x10
 1c2:	00ee3733          	sltu	a4,t3,a4
 1c6:	967a                	add	a2,a2,t5
 1c8:	963a                	add	a2,a2,a4
 1ca:	0685af03          	lw	t5,104(a1)
 1ce:	06c5af83          	lw	t6,108(a1)
 1d2:	01061293          	slli	t0,a2,0x10
 1d6:	010e5713          	srli	a4,t3,0x10
 1da:	00e2e733          	or	a4,t0,a4
 1de:	9f3a                	add	t5,t5,a4
 1e0:	8641                	srai	a2,a2,0x10
 1e2:	00ef3733          	sltu	a4,t5,a4
 1e6:	967e                	add	a2,a2,t6
 1e8:	963a                	add	a2,a2,a4
 1ea:	0705af83          	lw	t6,112(a1)
 1ee:	0745a283          	lw	t0,116(a1)
 1f2:	01061393          	slli	t2,a2,0x10
 1f6:	010f5713          	srli	a4,t5,0x10
 1fa:	00e3e733          	or	a4,t2,a4
 1fe:	9fba                	add	t6,t6,a4
 200:	8641                	srai	a2,a2,0x10
 202:	00efb733          	sltu	a4,t6,a4
 206:	9616                	add	a2,a2,t0
 208:	0785a383          	lw	t2,120(a1)
 20c:	963a                	add	a2,a2,a4
 20e:	07c5a283          	lw	t0,124(a1)
 212:	010fd713          	srli	a4,t6,0x10
 216:	01061593          	slli	a1,a2,0x10
 21a:	8f4d                	or	a4,a4,a1
 21c:	007705b3          	add	a1,a4,t2
 220:	8641                	srai	a2,a2,0x10
 222:	9616                	add	a2,a2,t0
 224:	00e5b733          	sltu	a4,a1,a4
 228:	9732                	add	a4,a4,a2
 22a:	01071613          	slli	a2,a4,0x10
 22e:	0105d413          	srli	s0,a1,0x10
 232:	02600393          	li	t2,38
 236:	8c51                	or	s0,s0,a2
 238:	02838633          	mul	a2,t2,s0
 23c:	8741                	srai	a4,a4,0x10
 23e:	00d8f2b3          	and	t0,a7,a3
 242:	00d87833          	and	a6,a6,a3
 246:	00d37333          	and	t1,t1,a3
 24a:	00defeb3          	and	t4,t4,a3
 24e:	00de7e33          	and	t3,t3,a3
 252:	00df7f33          	and	t5,t5,a3
 256:	00dfffb3          	and	t6,t6,a3
 25a:	8eed                	and	a3,a3,a1
 25c:	0283b8b3          	mulhu	a7,t2,s0
 260:	9832                	add	a6,a6,a2
 262:	00c83633          	sltu	a2,a6,a2
 266:	04052223          	sw	zero,68(a0)
 26a:	04552423          	sw	t0,72(a0)
 26e:	04052623          	sw	zero,76(a0)
 272:	04652823          	sw	t1,80(a0)
 276:	04052a23          	sw	zero,84(a0)
 27a:	05d52c23          	sw	t4,88(a0)
 27e:	04052e23          	sw	zero,92(a0)
 282:	02e38733          	mul	a4,t2,a4
 286:	07c52023          	sw	t3,96(a0)
 28a:	06052223          	sw	zero,100(a0)
 28e:	07e52423          	sw	t5,104(a0)
 292:	06052623          	sw	zero,108(a0)
 296:	07f52823          	sw	t6,112(a0)
 29a:	06052a23          	sw	zero,116(a0)
 29e:	dd34                	sw	a3,120(a0)
 2a0:	06052e23          	sw	zero,124(a0)
 2a4:	01052023          	sw	a6,0(a0)
 2a8:	9746                	add	a4,a4,a7
 2aa:	9732                	add	a4,a4,a2
 2ac:	c158                	sw	a4,4(a0)
 2ae:	4432                	lw	s0,12(sp)
 2b0:	0141                	addi	sp,sp,16
 2b2:	8082                	ret
