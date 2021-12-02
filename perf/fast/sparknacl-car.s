
sparknacl-car.o:     file format elf32-littleriscv


Disassembly of section .text.sparknacl__car__product_to_seminormal:

00000000 <sparknacl__car__product_to_seminormal>:
   is
      subtype Carry_Adjustment is I64 range 0 .. (MGFLC * MGFLP) / LM;
      Carry : Carry_Adjustment;
      R     : GF with Relaxed_Initialization;
   begin
      Carry := ASR_16 (X (0));
   0:	0005a803          	lw	a6,0(a1)
   4:	41d8                	lw	a4,4(a1)
      R (0) := X (0) mod LM;
      R (1) := X (1) + Carry;
   6:	0085af03          	lw	t5,8(a1)
   a:	45d4                	lw	a3,12(a1)

0000000c <.LBB30>:

   --  returns equivalent of X >> 16 in C, doing an arithmetic
   --  shift right when X is negative, assuming 2's complement
   --  representation
   function ASR_16 (X : in I64) return I64
   is (To_I64 (Shift_Right_Arithmetic (To_U64 (X), 16)))
   c:	01071613          	slli	a2,a4,0x10
  10:	01085793          	srli	a5,a6,0x10
  14:	8fd1                	or	a5,a5,a2

00000016 <.LBE30>:
  16:	9f3e                	add	t5,t5,a5

00000018 <.LBB33>:
  18:	8741                	srai	a4,a4,0x10

0000001a <.LBE33>:
  1a:	00ff37b3          	sltu	a5,t5,a5
  1e:	9736                	add	a4,a4,a3

00000020 <.LBB34>:
           (X (I + 1) <= (MGFLC - 37 * GF_Any_Limb (I + 1)) * MGFLP);
         pragma Assert
           (X (I) <= (MGFLC - 37 * GF_Any_Limb (I)) * MGFLP);

         R (I) := R (I) mod LM;
         R (I + 1) := X (I + 1) + Carry;
  20:	0105ae83          	lw	t4,16(a1)

00000024 <.LBE34>:
      R (1) := X (1) + Carry;
  24:	973e                	add	a4,a4,a5

00000026 <.LBB99>:
         R (I + 1) := X (I + 1) + Carry;
  26:	49d4                	lw	a3,20(a1)

00000028 <.LBB35>:
  28:	01071613          	slli	a2,a4,0x10
  2c:	010f5793          	srli	a5,t5,0x10
  30:	8fd1                	or	a5,a5,a2

00000032 <.LBE35>:
  32:	9ebe                	add	t4,t4,a5

00000034 <.LBB68>:
  34:	8741                	srai	a4,a4,0x10

00000036 <.LBE68>:
  36:	00feb7b3          	sltu	a5,t4,a5
  3a:	9736                	add	a4,a4,a3
  3c:	0185ae03          	lw	t3,24(a1)
  40:	973e                	add	a4,a4,a5

00000042 <.LVL5>:
  42:	4dd4                	lw	a3,28(a1)

00000044 <.LBB69>:
  44:	01071613          	slli	a2,a4,0x10
  48:	010ed793          	srli	a5,t4,0x10
  4c:	8fd1                	or	a5,a5,a2

0000004e <.LBE69>:
  4e:	9e3e                	add	t3,t3,a5

00000050 <.LBB70>:
  50:	8741                	srai	a4,a4,0x10

00000052 <.LBE70>:
  52:	00fe37b3          	sltu	a5,t3,a5
  56:	9736                	add	a4,a4,a3
  58:	0205a303          	lw	t1,32(a1)
  5c:	973e                	add	a4,a4,a5

0000005e <.LVL7>:
  5e:	51d4                	lw	a3,36(a1)

00000060 <.LBB71>:
  60:	01071613          	slli	a2,a4,0x10
  64:	010e5793          	srli	a5,t3,0x10
  68:	8fd1                	or	a5,a5,a2

0000006a <.LBE71>:
  6a:	933e                	add	t1,t1,a5

0000006c <.LBB72>:
  6c:	8741                	srai	a4,a4,0x10

0000006e <.LBE72>:
  6e:	00f337b3          	sltu	a5,t1,a5
  72:	9736                	add	a4,a4,a3
  74:	0285af83          	lw	t6,40(a1)
  78:	973e                	add	a4,a4,a5

0000007a <.LVL9>:
  7a:	55d4                	lw	a3,44(a1)

0000007c <.LBB73>:
  7c:	01071613          	slli	a2,a4,0x10
  80:	01035793          	srli	a5,t1,0x10
  84:	8fd1                	or	a5,a5,a2

00000086 <.LBE73>:
  86:	9fbe                	add	t6,t6,a5

00000088 <.LBB74>:
  88:	8741                	srai	a4,a4,0x10

0000008a <.LBE74>:
  8a:	00ffb7b3          	sltu	a5,t6,a5
  8e:	9736                	add	a4,a4,a3
  90:	0305a383          	lw	t2,48(a1)
  94:	973e                	add	a4,a4,a5

00000096 <.LVL11>:
  96:	59d4                	lw	a3,52(a1)

00000098 <.LBB75>:
  98:	01071613          	slli	a2,a4,0x10
  9c:	010fd793          	srli	a5,t6,0x10
  a0:	8fd1                	or	a5,a5,a2

000000a2 <.LBE75>:
  a2:	93be                	add	t2,t2,a5

000000a4 <.LBB76>:
  a4:	8741                	srai	a4,a4,0x10

000000a6 <.LBE76>:
  a6:	00f3b7b3          	sltu	a5,t2,a5
  aa:	9736                	add	a4,a4,a3
  ac:	973e                	add	a4,a4,a5

000000ae <.LVL13>:
  ae:	0385a283          	lw	t0,56(a1)
  b2:	5dd4                	lw	a3,60(a1)

000000b4 <.LBB77>:
  b4:	01071613          	slli	a2,a4,0x10
  b8:	0103d793          	srli	a5,t2,0x10
  bc:	8fd1                	or	a5,a5,a2

000000be <.LBE77>:
  be:	92be                	add	t0,t0,a5

000000c0 <.LBB78>:
  c0:	41075893          	srai	a7,a4,0x10

000000c4 <.LBE78>:
  c4:	00f2b7b3          	sltu	a5,t0,a5
  c8:	98b6                	add	a7,a7,a3

000000ca <.LBE99>:
   function Product_To_Seminormal
  ca:	1141                	addi	sp,sp,-16

000000cc <.LBB100>:
         R (I + 1) := X (I + 1) + Carry;
  cc:	41b8                	lw	a4,64(a1)
  ce:	98be                	add	a7,a7,a5

000000d0 <.LBE100>:
   function Product_To_Seminormal
  d0:	c622                	sw	s0,12(sp)

000000d2 <.LBB101>:
  d2:	01089793          	slli	a5,a7,0x10

000000d6 <.LBE79>:
         R (I + 1) := X (I + 1) + Carry;
  d6:	41e0                	lw	s0,68(a1)

000000d8 <.LBB80>:
  d8:	0102d613          	srli	a2,t0,0x10

000000dc <.LBE80>:
         R (I) := R (I) mod LM;
  dc:	66c1                	lui	a3,0x10
  de:	16fd                	addi	a3,a3,-1

000000e0 <.LBB81>:
  e0:	8e5d                	or	a2,a2,a5

000000e2 <.LBE81>:
         R (I + 1) := X (I + 1) + Carry;
  e2:	9732                	add	a4,a4,a2
         R (I) := R (I) mod LM;
  e4:	00df7f33          	and	t5,t5,a3
  e8:	00defeb3          	and	t4,t4,a3
  ec:	00de7e33          	and	t3,t3,a3
  f0:	00d37333          	and	t1,t1,a3
  f4:	00dfffb3          	and	t6,t6,a3
  f8:	00d3f3b3          	and	t2,t2,a3
  fc:	00d2f2b3          	and	t0,t0,a3

00000100 <.LBB82>:
 100:	4108d893          	srai	a7,a7,0x10

00000104 <.LBE82>:
         R (I + 1) := X (I + 1) + Carry;
 104:	98a2                	add	a7,a7,s0
         R (I) := R (I) mod LM;
 106:	01e52423          	sw	t5,8(a0)
 10a:	01d52823          	sw	t4,16(a0)
 10e:	01c52c23          	sw	t3,24(a0)
 112:	02652023          	sw	t1,32(a0)
 116:	03f52423          	sw	t6,40(a0)
 11a:	02752823          	sw	t2,48(a0)
 11e:	02552c23          	sw	t0,56(a0)
         R (I + 1) := X (I + 1) + Carry;
 122:	00c73633          	sltu	a2,a4,a2
         R (I) := R (I) mod LM;
 126:	00052623          	sw	zero,12(a0)
 12a:	00052a23          	sw	zero,20(a0)
 12e:	00052e23          	sw	zero,28(a0)
 132:	02052223          	sw	zero,36(a0)
 136:	02052623          	sw	zero,44(a0)
 13a:	02052a23          	sw	zero,52(a0)
 13e:	02052e23          	sw	zero,60(a0)
 142:	00d77333          	and	t1,a4,a3
         R (I + 1) := X (I + 1) + Carry;
 146:	9646                	add	a2,a2,a7

00000148 <.LVL17>:
 148:	0485a883          	lw	a7,72(a1)

0000014c <.LBB83>:
 14c:	01061e13          	slli	t3,a2,0x10

00000150 <.LBE83>:
         R (I) := R (I) mod LM;
 150:	04652023          	sw	t1,64(a0)

00000154 <.LBB84>:
 154:	8341                	srli	a4,a4,0x10

00000156 <.LBE84>:
         R (I + 1) := X (I + 1) + Carry;
 156:	04c5a303          	lw	t1,76(a1)

0000015a <.LBB85>:
 15a:	00ee6733          	or	a4,t3,a4

0000015e <.LBE85>:
 15e:	98ba                	add	a7,a7,a4

00000160 <.LBB86>:
 160:	8641                	srai	a2,a2,0x10

00000162 <.LBE86>:
 162:	961a                	add	a2,a2,t1
 164:	00e8b733          	sltu	a4,a7,a4
 168:	0505a303          	lw	t1,80(a1)
 16c:	9732                	add	a4,a4,a2

0000016e <.LVL19>:
 16e:	0545ae03          	lw	t3,84(a1)

00000172 <.LBB87>:
 172:	01071e93          	slli	t4,a4,0x10
 176:	0108d613          	srli	a2,a7,0x10
 17a:	00cee633          	or	a2,t4,a2

0000017e <.LBE87>:
 17e:	9332                	add	t1,t1,a2

00000180 <.LBB88>:
 180:	8741                	srai	a4,a4,0x10

00000182 <.LBE88>:
 182:	00c33633          	sltu	a2,t1,a2
 186:	9772                	add	a4,a4,t3
 188:	0585ae83          	lw	t4,88(a1)
 18c:	9732                	add	a4,a4,a2

0000018e <.LVL21>:
 18e:	05c5ae03          	lw	t3,92(a1)

00000192 <.LBB89>:
 192:	01071f13          	slli	t5,a4,0x10
 196:	01035613          	srli	a2,t1,0x10
 19a:	00cf6633          	or	a2,t5,a2

0000019e <.LBE89>:
 19e:	9eb2                	add	t4,t4,a2

000001a0 <.LBB90>:
 1a0:	8741                	srai	a4,a4,0x10

000001a2 <.LBE90>:
 1a2:	9772                	add	a4,a4,t3
 1a4:	00ceb633          	sltu	a2,t4,a2
 1a8:	0605ae03          	lw	t3,96(a1)
 1ac:	963a                	add	a2,a2,a4

000001ae <.LVL23>:
 1ae:	0645af03          	lw	t5,100(a1)

000001b2 <.LBB91>:
 1b2:	01061f93          	slli	t6,a2,0x10
 1b6:	010ed713          	srli	a4,t4,0x10
 1ba:	00efe733          	or	a4,t6,a4

000001be <.LBE91>:
 1be:	9e3a                	add	t3,t3,a4

000001c0 <.LBB92>:
 1c0:	8641                	srai	a2,a2,0x10

000001c2 <.LBE92>:
 1c2:	00ee3733          	sltu	a4,t3,a4
 1c6:	967a                	add	a2,a2,t5
 1c8:	963a                	add	a2,a2,a4

000001ca <.LVL25>:
 1ca:	0685af03          	lw	t5,104(a1)
 1ce:	06c5af83          	lw	t6,108(a1)

000001d2 <.LBB93>:
 1d2:	01061293          	slli	t0,a2,0x10
 1d6:	010e5713          	srli	a4,t3,0x10
 1da:	00e2e733          	or	a4,t0,a4

000001de <.LBE93>:
 1de:	9f3a                	add	t5,t5,a4

000001e0 <.LBB94>:
 1e0:	8641                	srai	a2,a2,0x10

000001e2 <.LBE94>:
 1e2:	00ef3733          	sltu	a4,t5,a4
 1e6:	967e                	add	a2,a2,t6
 1e8:	963a                	add	a2,a2,a4

000001ea <.LVL27>:
 1ea:	0705af83          	lw	t6,112(a1)
 1ee:	0745a283          	lw	t0,116(a1)

000001f2 <.LBB95>:
 1f2:	01061393          	slli	t2,a2,0x10
 1f6:	010f5713          	srli	a4,t5,0x10
 1fa:	00e3e733          	or	a4,t2,a4

000001fe <.LBE95>:
 1fe:	9fba                	add	t6,t6,a4

00000200 <.LBB96>:
 200:	8641                	srai	a2,a2,0x10

00000202 <.LBE96>:
 202:	00efb733          	sltu	a4,t6,a4
 206:	9616                	add	a2,a2,t0
 208:	0785a383          	lw	t2,120(a1)
 20c:	963a                	add	a2,a2,a4

0000020e <.LVL29>:
 20e:	07c5a283          	lw	t0,124(a1)

00000212 <.LBB97>:
 212:	010fd713          	srli	a4,t6,0x10
 216:	01061593          	slli	a1,a2,0x10

0000021a <.LVL30>:
 21a:	8f4d                	or	a4,a4,a1

0000021c <.LBE97>:
 21c:	007705b3          	add	a1,a4,t2

00000220 <.LBB98>:
 220:	8641                	srai	a2,a2,0x10

00000222 <.LBE98>:
 222:	9616                	add	a2,a2,t0
 224:	00e5b733          	sltu	a4,a1,a4
 228:	9732                	add	a4,a4,a2

0000022a <.LBB102>:
 22a:	01071613          	slli	a2,a4,0x10
 22e:	0105d413          	srli	s0,a1,0x10

00000232 <.LBE102>:

      Carry := ASR_16 (R (15));

      pragma Assert (Carry <= ((53 * MGFLP) / LM));

      R (0) := R (0) + R2256 * Carry;
 232:	02600393          	li	t2,38

00000236 <.LBB106>:
 236:	8c51                	or	s0,s0,a2

00000238 <.LBE106>:
 238:	02838633          	mul	a2,t2,s0

0000023c <.LBB107>:
 23c:	8741                	srai	a4,a4,0x10

0000023e <.LBB108>:
         R (I) := R (I) mod LM;
 23e:	00d8f2b3          	and	t0,a7,a3

00000242 <.LBE108>:
      R (0) := X (0) mod LM;
 242:	00d87833          	and	a6,a6,a3

00000246 <.LBB109>:
         R (I) := R (I) mod LM;
 246:	00d37333          	and	t1,t1,a3
 24a:	00defeb3          	and	t4,t4,a3
 24e:	00de7e33          	and	t3,t3,a3
 252:	00df7f33          	and	t5,t5,a3
 256:	00dfffb3          	and	t6,t6,a3

0000025a <.LBE109>:

      pragma Assert (R (0) in Seminormal_GF_LSL);

      R (15) := R (15) mod LM;
 25a:	8eed                	and	a3,a3,a1
      R (0) := R (0) + R2256 * Carry;
 25c:	0283b8b3          	mulhu	a7,t2,s0
 260:	9832                	add	a6,a6,a2
 262:	00c83633          	sltu	a2,a6,a2

00000266 <.LBB110>:
         R (I) := R (I) mod LM;
 266:	04052223          	sw	zero,68(a0)
 26a:	04552423          	sw	t0,72(a0)
 26e:	04052623          	sw	zero,76(a0)
 272:	04652823          	sw	t1,80(a0)
 276:	04052a23          	sw	zero,84(a0)
 27a:	05d52c23          	sw	t4,88(a0)
 27e:	04052e23          	sw	zero,92(a0)

00000282 <.LBE110>:
      R (0) := R (0) + R2256 * Carry;
 282:	02e38733          	mul	a4,t2,a4

00000286 <.LBB111>:
         R (I) := R (I) mod LM;
 286:	07c52023          	sw	t3,96(a0)
 28a:	06052223          	sw	zero,100(a0)
 28e:	07e52423          	sw	t5,104(a0)
 292:	06052623          	sw	zero,108(a0)
 296:	07f52823          	sw	t6,112(a0)
 29a:	06052a23          	sw	zero,116(a0)

0000029e <.LBE111>:
      R (0) := R (0) + R2256 * Carry;
 29e:	01052023          	sw	a6,0(a0)
      R (15) := R (15) mod LM;
 2a2:	dd34                	sw	a3,120(a0)
 2a4:	06052e23          	sw	zero,124(a0)
      R (0) := R (0) + R2256 * Carry;
 2a8:	9746                	add	a4,a4,a7
 2aa:	9732                	add	a4,a4,a2
 2ac:	c158                	sw	a4,4(a0)

      return Seminormal_GF (R);
   end Product_To_Seminormal;
 2ae:	4432                	lw	s0,12(sp)
 2b0:	0141                	addi	sp,sp,16
 2b2:	8082                	ret

Disassembly of section .text.sparknacl__car__seminormal_to_nearlynormal:

00000000 <sparknacl__car__seminormal_to_nearlynormal>:
      First_Carry : First_Carry_T;

      Carry : I64_Bit;
      R     : GF with Relaxed_Initialization;
   begin
      First_Carry := ASR_16 (X (0));
   0:	0005a803          	lw	a6,0(a1)
   4:	41d8                	lw	a4,4(a1)
      R (0) := X (0) mod LM;
      R (1) := X (1) + First_Carry;
   6:	0085af03          	lw	t5,8(a1)
   a:	45d4                	lw	a3,12(a1)

0000000c <.LBB112>:
   c:	01071613          	slli	a2,a4,0x10
  10:	01085793          	srli	a5,a6,0x10
  14:	8fd1                	or	a5,a5,a2

00000016 <.LBE112>:
  16:	9f3e                	add	t5,t5,a5

00000018 <.LBB115>:
  18:	8741                	srai	a4,a4,0x10

0000001a <.LBE115>:
  1a:	00ff37b3          	sltu	a5,t5,a5
  1e:	9736                	add	a4,a4,a3

00000020 <.LBB116>:
      pragma Assert (R (1) in 0 .. GF_Normal_Limb'Last + First_Carry_T'Last);

      for I in Index_16 range 1 .. 14 loop
         Carry := ASR_16 (R (I));
         R (I) := R (I) mod LM;
         R (I + 1) := X (I + 1) + Carry;
  20:	0105ae83          	lw	t4,16(a1)

00000024 <.LBE116>:
      R (1) := X (1) + First_Carry;
  24:	973e                	add	a4,a4,a5

00000026 <.LBB181>:
         R (I + 1) := X (I + 1) + Carry;
  26:	49d4                	lw	a3,20(a1)

00000028 <.LBB117>:
  28:	01071613          	slli	a2,a4,0x10
  2c:	010f5793          	srli	a5,t5,0x10
  30:	8fd1                	or	a5,a5,a2

00000032 <.LBE117>:
  32:	9ebe                	add	t4,t4,a5

00000034 <.LBB150>:
  34:	8741                	srai	a4,a4,0x10

00000036 <.LBE150>:
  36:	00feb7b3          	sltu	a5,t4,a5
  3a:	9736                	add	a4,a4,a3
  3c:	0185ae03          	lw	t3,24(a1)
  40:	973e                	add	a4,a4,a5

00000042 <.LVL39>:
  42:	4dd4                	lw	a3,28(a1)

00000044 <.LBB151>:
  44:	01071613          	slli	a2,a4,0x10
  48:	010ed793          	srli	a5,t4,0x10
  4c:	8fd1                	or	a5,a5,a2

0000004e <.LBE151>:
  4e:	9e3e                	add	t3,t3,a5

00000050 <.LBB152>:
  50:	8741                	srai	a4,a4,0x10

00000052 <.LBE152>:
  52:	00fe37b3          	sltu	a5,t3,a5
  56:	9736                	add	a4,a4,a3
  58:	0205a303          	lw	t1,32(a1)
  5c:	973e                	add	a4,a4,a5

0000005e <.LVL41>:
  5e:	51d4                	lw	a3,36(a1)

00000060 <.LBB153>:
  60:	01071613          	slli	a2,a4,0x10
  64:	010e5793          	srli	a5,t3,0x10
  68:	8fd1                	or	a5,a5,a2

0000006a <.LBE153>:
  6a:	933e                	add	t1,t1,a5

0000006c <.LBB154>:
  6c:	8741                	srai	a4,a4,0x10

0000006e <.LBE154>:
  6e:	00f337b3          	sltu	a5,t1,a5
  72:	9736                	add	a4,a4,a3
  74:	0285af83          	lw	t6,40(a1)
  78:	973e                	add	a4,a4,a5

0000007a <.LVL43>:
  7a:	55d4                	lw	a3,44(a1)

0000007c <.LBB155>:
  7c:	01071613          	slli	a2,a4,0x10
  80:	01035793          	srli	a5,t1,0x10
  84:	8fd1                	or	a5,a5,a2

00000086 <.LBE155>:
  86:	9fbe                	add	t6,t6,a5

00000088 <.LBB156>:
  88:	8741                	srai	a4,a4,0x10

0000008a <.LBE156>:
  8a:	00ffb7b3          	sltu	a5,t6,a5
  8e:	9736                	add	a4,a4,a3
  90:	0305a383          	lw	t2,48(a1)
  94:	973e                	add	a4,a4,a5

00000096 <.LVL45>:
  96:	59d4                	lw	a3,52(a1)

00000098 <.LBB157>:
  98:	01071613          	slli	a2,a4,0x10
  9c:	010fd793          	srli	a5,t6,0x10
  a0:	8fd1                	or	a5,a5,a2

000000a2 <.LBE157>:
  a2:	93be                	add	t2,t2,a5

000000a4 <.LBB158>:
  a4:	8741                	srai	a4,a4,0x10

000000a6 <.LBE158>:
  a6:	00f3b7b3          	sltu	a5,t2,a5
  aa:	9736                	add	a4,a4,a3
  ac:	973e                	add	a4,a4,a5

000000ae <.LVL47>:
  ae:	0385a283          	lw	t0,56(a1)
  b2:	5dd4                	lw	a3,60(a1)

000000b4 <.LBB159>:
  b4:	01071613          	slli	a2,a4,0x10
  b8:	0103d793          	srli	a5,t2,0x10
  bc:	8fd1                	or	a5,a5,a2

000000be <.LBE159>:
  be:	92be                	add	t0,t0,a5

000000c0 <.LBB160>:
  c0:	41075893          	srai	a7,a4,0x10

000000c4 <.LBE160>:
  c4:	00f2b7b3          	sltu	a5,t0,a5
  c8:	98b6                	add	a7,a7,a3

000000ca <.LBE181>:
   function Seminormal_To_Nearlynormal
  ca:	1141                	addi	sp,sp,-16

000000cc <.LBB182>:
         R (I + 1) := X (I + 1) + Carry;
  cc:	41b8                	lw	a4,64(a1)
  ce:	98be                	add	a7,a7,a5

000000d0 <.LBE182>:
   function Seminormal_To_Nearlynormal
  d0:	c622                	sw	s0,12(sp)

000000d2 <.LBB161>:
  d2:	01089793          	slli	a5,a7,0x10

000000d6 <.LBE161>:
         R (I + 1) := X (I + 1) + Carry;
  d6:	41e0                	lw	s0,68(a1)

000000d8 <.LBB162>:
  d8:	0102d613          	srli	a2,t0,0x10

000000dc <.LBE162>:
         R (I) := R (I) mod LM;
  dc:	66c1                	lui	a3,0x10
  de:	16fd                	addi	a3,a3,-1

000000e0 <.LBB163>:
  e0:	8e5d                	or	a2,a2,a5

000000e2 <.LBE163>:
         R (I + 1) := X (I + 1) + Carry;
  e2:	9732                	add	a4,a4,a2
         R (I) := R (I) mod LM;
  e4:	00df7f33          	and	t5,t5,a3
  e8:	00defeb3          	and	t4,t4,a3
  ec:	00de7e33          	and	t3,t3,a3
  f0:	00d37333          	and	t1,t1,a3
  f4:	00dfffb3          	and	t6,t6,a3
  f8:	00d3f3b3          	and	t2,t2,a3
  fc:	00d2f2b3          	and	t0,t0,a3

00000100 <.LBB164>:
 100:	4108d893          	srai	a7,a7,0x10

00000104 <.LBE164>:
         R (I + 1) := X (I + 1) + Carry;
 104:	98a2                	add	a7,a7,s0
         R (I) := R (I) mod LM;
 106:	01e52423          	sw	t5,8(a0)
 10a:	01d52823          	sw	t4,16(a0)
 10e:	01c52c23          	sw	t3,24(a0)
 112:	02652023          	sw	t1,32(a0)
 116:	03f52423          	sw	t6,40(a0)
 11a:	02752823          	sw	t2,48(a0)
 11e:	02552c23          	sw	t0,56(a0)
         R (I + 1) := X (I + 1) + Carry;
 122:	00c73633          	sltu	a2,a4,a2
         R (I) := R (I) mod LM;
 126:	00052623          	sw	zero,12(a0)
 12a:	00052a23          	sw	zero,20(a0)
 12e:	00052e23          	sw	zero,28(a0)
 132:	02052223          	sw	zero,36(a0)
 136:	02052623          	sw	zero,44(a0)
 13a:	02052a23          	sw	zero,52(a0)
 13e:	02052e23          	sw	zero,60(a0)
 142:	00d77333          	and	t1,a4,a3
         R (I + 1) := X (I + 1) + Carry;
 146:	9646                	add	a2,a2,a7

00000148 <.LVL51>:
 148:	0485a883          	lw	a7,72(a1)

0000014c <.LBB165>:
 14c:	01061e13          	slli	t3,a2,0x10

00000150 <.LBE165>:
         R (I) := R (I) mod LM;
 150:	04652023          	sw	t1,64(a0)

00000154 <.LBB166>:
 154:	8341                	srli	a4,a4,0x10

00000156 <.LBE166>:
         R (I + 1) := X (I + 1) + Carry;
 156:	04c5a303          	lw	t1,76(a1)

0000015a <.LBB167>:
 15a:	00ee6733          	or	a4,t3,a4

0000015e <.LBE167>:
 15e:	98ba                	add	a7,a7,a4

00000160 <.LBB168>:
 160:	8641                	srai	a2,a2,0x10

00000162 <.LBE168>:
 162:	961a                	add	a2,a2,t1
 164:	00e8b733          	sltu	a4,a7,a4
 168:	0505a303          	lw	t1,80(a1)
 16c:	9732                	add	a4,a4,a2

0000016e <.LVL53>:
 16e:	0545ae03          	lw	t3,84(a1)

00000172 <.LBB169>:
 172:	01071e93          	slli	t4,a4,0x10
 176:	0108d613          	srli	a2,a7,0x10
 17a:	00cee633          	or	a2,t4,a2

0000017e <.LBE169>:
 17e:	9332                	add	t1,t1,a2

00000180 <.LBB170>:
 180:	8741                	srai	a4,a4,0x10

00000182 <.LBE170>:
 182:	00c33633          	sltu	a2,t1,a2
 186:	9772                	add	a4,a4,t3
 188:	0585ae83          	lw	t4,88(a1)
 18c:	9732                	add	a4,a4,a2

0000018e <.LVL55>:
 18e:	05c5ae03          	lw	t3,92(a1)

00000192 <.LBB171>:
 192:	01071f13          	slli	t5,a4,0x10
 196:	01035613          	srli	a2,t1,0x10
 19a:	00cf6633          	or	a2,t5,a2

0000019e <.LBE171>:
 19e:	9eb2                	add	t4,t4,a2

000001a0 <.LBB172>:
 1a0:	8741                	srai	a4,a4,0x10

000001a2 <.LBE172>:
 1a2:	9772                	add	a4,a4,t3
 1a4:	00ceb633          	sltu	a2,t4,a2
 1a8:	0605ae03          	lw	t3,96(a1)
 1ac:	963a                	add	a2,a2,a4

000001ae <.LVL57>:
 1ae:	0645af03          	lw	t5,100(a1)

000001b2 <.LBB173>:
 1b2:	01061f93          	slli	t6,a2,0x10
 1b6:	010ed713          	srli	a4,t4,0x10
 1ba:	00efe733          	or	a4,t6,a4

000001be <.LBE173>:
 1be:	9e3a                	add	t3,t3,a4

000001c0 <.LBB174>:
 1c0:	8641                	srai	a2,a2,0x10

000001c2 <.LBE174>:
 1c2:	00ee3733          	sltu	a4,t3,a4
 1c6:	967a                	add	a2,a2,t5
 1c8:	963a                	add	a2,a2,a4

000001ca <.LVL59>:
 1ca:	0685af03          	lw	t5,104(a1)
 1ce:	06c5af83          	lw	t6,108(a1)

000001d2 <.LBB175>:
 1d2:	01061293          	slli	t0,a2,0x10
 1d6:	010e5713          	srli	a4,t3,0x10
 1da:	00e2e733          	or	a4,t0,a4

000001de <.LBE175>:
 1de:	9f3a                	add	t5,t5,a4

000001e0 <.LBB176>:
 1e0:	8641                	srai	a2,a2,0x10

000001e2 <.LBE176>:
 1e2:	00ef3733          	sltu	a4,t5,a4
 1e6:	967e                	add	a2,a2,t6
 1e8:	963a                	add	a2,a2,a4

000001ea <.LVL61>:
 1ea:	0705af83          	lw	t6,112(a1)
 1ee:	0745a283          	lw	t0,116(a1)

000001f2 <.LBB177>:
 1f2:	01061393          	slli	t2,a2,0x10
 1f6:	010f5713          	srli	a4,t5,0x10
 1fa:	00e3e733          	or	a4,t2,a4

000001fe <.LBE177>:
 1fe:	9fba                	add	t6,t6,a4

00000200 <.LBB178>:
 200:	8641                	srai	a2,a2,0x10

00000202 <.LBE178>:
 202:	00efb733          	sltu	a4,t6,a4
 206:	9616                	add	a2,a2,t0
 208:	0785a383          	lw	t2,120(a1)
 20c:	963a                	add	a2,a2,a4

0000020e <.LVL63>:
 20e:	07c5a283          	lw	t0,124(a1)

00000212 <.LBB179>:
 212:	010fd713          	srli	a4,t6,0x10
 216:	01061593          	slli	a1,a2,0x10

0000021a <.LVL64>:
 21a:	8f4d                	or	a4,a4,a1

0000021c <.LBE179>:
 21c:	007705b3          	add	a1,a4,t2

00000220 <.LBB180>:
 220:	8641                	srai	a2,a2,0x10

00000222 <.LBE180>:
 222:	9616                	add	a2,a2,t0
 224:	00e5b733          	sltu	a4,a1,a4
 228:	9732                	add	a4,a4,a2

0000022a <.LBB184>:
 22a:	01071613          	slli	a2,a4,0x10
 22e:	0105d413          	srli	s0,a1,0x10

00000232 <.LBE184>:
        (for all K in Index_16 range 0 .. 14 => (R (K) in GF_Normal_Limb));
      pragma Assert (R (15) in 0 .. LM);

      Carry := ASR_16 (R (15));

      R (0) := R (0) + R2256 * Carry;
 232:	02600393          	li	t2,38

00000236 <.LBB188>:
 236:	8c51                	or	s0,s0,a2

00000238 <.LBE188>:
 238:	02838633          	mul	a2,t2,s0

0000023c <.LBB189>:
 23c:	8741                	srai	a4,a4,0x10

0000023e <.LBB190>:
         R (I) := R (I) mod LM;
 23e:	00d8f2b3          	and	t0,a7,a3

00000242 <.LBE190>:
      R (0) := X (0) mod LM;
 242:	00d87833          	and	a6,a6,a3

00000246 <.LBB191>:
         R (I) := R (I) mod LM;
 246:	00d37333          	and	t1,t1,a3
 24a:	00defeb3          	and	t4,t4,a3
 24e:	00de7e33          	and	t3,t3,a3
 252:	00df7f33          	and	t5,t5,a3
 256:	00dfffb3          	and	t6,t6,a3

0000025a <.LBE191>:
      R (15) := R (15) mod LM;
 25a:	8eed                	and	a3,a3,a1
      R (0) := R (0) + R2256 * Carry;
 25c:	0283b8b3          	mulhu	a7,t2,s0
 260:	9832                	add	a6,a6,a2
 262:	00c83633          	sltu	a2,a6,a2

00000266 <.LBB192>:
         R (I) := R (I) mod LM;
 266:	04052223          	sw	zero,68(a0)
 26a:	04552423          	sw	t0,72(a0)
 26e:	04052623          	sw	zero,76(a0)
 272:	04652823          	sw	t1,80(a0)
 276:	04052a23          	sw	zero,84(a0)
 27a:	05d52c23          	sw	t4,88(a0)
 27e:	04052e23          	sw	zero,92(a0)

00000282 <.LBE192>:
      R (0) := R (0) + R2256 * Carry;
 282:	02e38733          	mul	a4,t2,a4

00000286 <.LBB193>:
         R (I) := R (I) mod LM;
 286:	07c52023          	sw	t3,96(a0)
 28a:	06052223          	sw	zero,100(a0)
 28e:	07e52423          	sw	t5,104(a0)
 292:	06052623          	sw	zero,108(a0)
 296:	07f52823          	sw	t6,112(a0)
 29a:	06052a23          	sw	zero,116(a0)

0000029e <.LBE193>:
      R (0) := R (0) + R2256 * Carry;
 29e:	01052023          	sw	a6,0(a0)
      R (15) := R (15) mod LM;
 2a2:	dd34                	sw	a3,120(a0)
 2a4:	06052e23          	sw	zero,124(a0)
      R (0) := R (0) + R2256 * Carry;
 2a8:	9746                	add	a4,a4,a7
 2aa:	9732                	add	a4,a4,a2
 2ac:	c158                	sw	a4,4(a0)

      return Nearlynormal_GF (R);
   end Seminormal_To_Nearlynormal;
 2ae:	4432                	lw	s0,12(sp)
 2b0:	0141                	addi	sp,sp,16
 2b2:	8082                	ret

Disassembly of section .text.sparknacl__car__sum_to_nearlynormal:

00000000 <sparknacl__car__sum_to_nearlynormal>:
       return Nearlynormal_GF
   is
      Carry : Boolean;
      R     : GF with Relaxed_Initialization;
   begin
      Carry := X (0) >= LM;
   0:	41d8                	lw	a4,4(a1)
   2:	4194                	lw	a3,0(a1)
   4:	4785                	li	a5,1
   6:	2ce05163          	blez	a4,2c8 <.L40>

0000000a <.L7>:
      R (0) := X (0) mod LM;
      R (1) := X (1) + Boolean'Pos (Carry);
   a:	4590                	lw	a2,8(a1)
   c:	45d8                	lw	a4,12(a1)

0000000e <.LBB194>:
      pragma Assert
        (R (1)'Initialized and then R (1) in 0 .. GF_Sum_Limb'Last + 1);

      for I in Index_16 range 1 .. 14 loop
         Carry := R (I) >= LM;
         R (I) := R (I) mod LM;
   e:	00052623          	sw	zero,12(a0)

00000012 <.LBE194>:
      R (1) := X (1) + Boolean'Pos (Carry);
  12:	963e                	add	a2,a2,a5

00000014 <.LBB195>:
         R (I) := R (I) mod LM;
  14:	01061813          	slli	a6,a2,0x10

00000018 <.LBE195>:
      R (1) := X (1) + Boolean'Pos (Carry);
  18:	00f637b3          	sltu	a5,a2,a5

0000001c <.LBB196>:
         R (I) := R (I) mod LM;
  1c:	01085813          	srli	a6,a6,0x10

00000020 <.LBE196>:
      R (1) := X (1) + Boolean'Pos (Carry);
  20:	973e                	add	a4,a4,a5

00000022 <.LBB197>:
         R (I) := R (I) mod LM;
  22:	01052423          	sw	a6,8(a0)
         Carry := R (I) >= LM;
  26:	4785                	li	a5,1
         R (I) := R (I) mod LM;
  28:	6841                	lui	a6,0x10
         Carry := R (I) >= LM;
  2a:	28e05a63          	blez	a4,2be <.L41>

0000002e <.L9>:
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  2e:	4990                	lw	a2,16(a1)
  30:	49d8                	lw	a4,20(a1)
         R (I) := R (I) mod LM;
  32:	00052a23          	sw	zero,20(a0)
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  36:	963e                	add	a2,a2,a5
         R (I) := R (I) mod LM;
  38:	01061813          	slli	a6,a2,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  3c:	00f637b3          	sltu	a5,a2,a5
         R (I) := R (I) mod LM;
  40:	01085813          	srli	a6,a6,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  44:	973e                	add	a4,a4,a5

00000046 <.LVL74>:
         R (I) := R (I) mod LM;
  46:	01052823          	sw	a6,16(a0)
         Carry := R (I) >= LM;
  4a:	4785                	li	a5,1
         R (I) := R (I) mod LM;
  4c:	6841                	lui	a6,0x10
         Carry := R (I) >= LM;
  4e:	26e05363          	blez	a4,2b4 <.L42>

00000052 <.L11>:
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  52:	4d90                	lw	a2,24(a1)
  54:	4dd8                	lw	a4,28(a1)
         R (I) := R (I) mod LM;
  56:	00052e23          	sw	zero,28(a0)
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  5a:	963e                	add	a2,a2,a5
         R (I) := R (I) mod LM;
  5c:	01061813          	slli	a6,a2,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  60:	00f637b3          	sltu	a5,a2,a5
         R (I) := R (I) mod LM;
  64:	01085813          	srli	a6,a6,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  68:	973e                	add	a4,a4,a5

0000006a <.LVL76>:
         R (I) := R (I) mod LM;
  6a:	01052c23          	sw	a6,24(a0)
         Carry := R (I) >= LM;
  6e:	4785                	li	a5,1
         R (I) := R (I) mod LM;
  70:	6841                	lui	a6,0x10
         Carry := R (I) >= LM;
  72:	22e05c63          	blez	a4,2aa <.L43>

00000076 <.L13>:
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  76:	5190                	lw	a2,32(a1)
  78:	51d8                	lw	a4,36(a1)
         R (I) := R (I) mod LM;
  7a:	02052223          	sw	zero,36(a0)
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  7e:	963e                	add	a2,a2,a5
         R (I) := R (I) mod LM;
  80:	01061813          	slli	a6,a2,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  84:	00f637b3          	sltu	a5,a2,a5
         R (I) := R (I) mod LM;
  88:	01085813          	srli	a6,a6,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  8c:	973e                	add	a4,a4,a5

0000008e <.LVL78>:
         R (I) := R (I) mod LM;
  8e:	03052023          	sw	a6,32(a0)
         Carry := R (I) >= LM;
  92:	4785                	li	a5,1
         R (I) := R (I) mod LM;
  94:	6841                	lui	a6,0x10
         Carry := R (I) >= LM;
  96:	20e05563          	blez	a4,2a0 <.L44>

0000009a <.L15>:
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  9a:	5590                	lw	a2,40(a1)
  9c:	55d8                	lw	a4,44(a1)
         R (I) := R (I) mod LM;
  9e:	02052623          	sw	zero,44(a0)
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  a2:	963e                	add	a2,a2,a5
         R (I) := R (I) mod LM;
  a4:	01061813          	slli	a6,a2,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  a8:	00f637b3          	sltu	a5,a2,a5
         R (I) := R (I) mod LM;
  ac:	01085813          	srli	a6,a6,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  b0:	973e                	add	a4,a4,a5

000000b2 <.LVL80>:
         R (I) := R (I) mod LM;
  b2:	03052423          	sw	a6,40(a0)
         Carry := R (I) >= LM;
  b6:	4785                	li	a5,1
         R (I) := R (I) mod LM;
  b8:	6841                	lui	a6,0x10
         Carry := R (I) >= LM;
  ba:	1ce05e63          	blez	a4,296 <.L45>

000000be <.L17>:
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  be:	5990                	lw	a2,48(a1)
  c0:	59d8                	lw	a4,52(a1)
         R (I) := R (I) mod LM;
  c2:	02052a23          	sw	zero,52(a0)
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  c6:	963e                	add	a2,a2,a5
         R (I) := R (I) mod LM;
  c8:	01061813          	slli	a6,a2,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  cc:	00f637b3          	sltu	a5,a2,a5
         R (I) := R (I) mod LM;
  d0:	01085813          	srli	a6,a6,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  d4:	973e                	add	a4,a4,a5

000000d6 <.LVL82>:
         R (I) := R (I) mod LM;
  d6:	03052823          	sw	a6,48(a0)
         Carry := R (I) >= LM;
  da:	4785                	li	a5,1
         R (I) := R (I) mod LM;
  dc:	6841                	lui	a6,0x10
         Carry := R (I) >= LM;
  de:	1ae05763          	blez	a4,28c <.L46>

000000e2 <.L19>:
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  e2:	5d90                	lw	a2,56(a1)
  e4:	5dd8                	lw	a4,60(a1)
         R (I) := R (I) mod LM;
  e6:	02052e23          	sw	zero,60(a0)
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  ea:	963e                	add	a2,a2,a5
         R (I) := R (I) mod LM;
  ec:	01061813          	slli	a6,a2,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  f0:	00f637b3          	sltu	a5,a2,a5
         R (I) := R (I) mod LM;
  f4:	01085813          	srli	a6,a6,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
  f8:	973e                	add	a4,a4,a5

000000fa <.LVL84>:
         R (I) := R (I) mod LM;
  fa:	03052c23          	sw	a6,56(a0)
         Carry := R (I) >= LM;
  fe:	4785                	li	a5,1
         R (I) := R (I) mod LM;
 100:	6841                	lui	a6,0x10
         Carry := R (I) >= LM;
 102:	18e05063          	blez	a4,282 <.L47>

00000106 <.L21>:
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 106:	41b0                	lw	a2,64(a1)
 108:	41f8                	lw	a4,68(a1)
         R (I) := R (I) mod LM;
 10a:	04052223          	sw	zero,68(a0)
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 10e:	963e                	add	a2,a2,a5
         R (I) := R (I) mod LM;
 110:	01061813          	slli	a6,a2,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 114:	00f637b3          	sltu	a5,a2,a5
         R (I) := R (I) mod LM;
 118:	01085813          	srli	a6,a6,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 11c:	973e                	add	a4,a4,a5

0000011e <.LVL86>:
         R (I) := R (I) mod LM;
 11e:	05052023          	sw	a6,64(a0)
         Carry := R (I) >= LM;
 122:	4785                	li	a5,1
         R (I) := R (I) mod LM;
 124:	6841                	lui	a6,0x10
         Carry := R (I) >= LM;
 126:	14e05963          	blez	a4,278 <.L48>

0000012a <.L23>:
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 12a:	45b0                	lw	a2,72(a1)
 12c:	45f8                	lw	a4,76(a1)
         R (I) := R (I) mod LM;
 12e:	04052623          	sw	zero,76(a0)
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 132:	963e                	add	a2,a2,a5
         R (I) := R (I) mod LM;
 134:	01061813          	slli	a6,a2,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 138:	00f637b3          	sltu	a5,a2,a5
         R (I) := R (I) mod LM;
 13c:	01085813          	srli	a6,a6,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 140:	973e                	add	a4,a4,a5

00000142 <.LVL88>:
         R (I) := R (I) mod LM;
 142:	05052423          	sw	a6,72(a0)
         Carry := R (I) >= LM;
 146:	4785                	li	a5,1
         R (I) := R (I) mod LM;
 148:	6841                	lui	a6,0x10
         Carry := R (I) >= LM;
 14a:	12e05263          	blez	a4,26e <.L49>

0000014e <.L25>:
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 14e:	49b0                	lw	a2,80(a1)
 150:	49f8                	lw	a4,84(a1)
         R (I) := R (I) mod LM;
 152:	04052a23          	sw	zero,84(a0)
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 156:	963e                	add	a2,a2,a5
         R (I) := R (I) mod LM;
 158:	01061813          	slli	a6,a2,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 15c:	00f637b3          	sltu	a5,a2,a5
         R (I) := R (I) mod LM;
 160:	01085813          	srli	a6,a6,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 164:	973e                	add	a4,a4,a5

00000166 <.LVL90>:
         R (I) := R (I) mod LM;
 166:	05052823          	sw	a6,80(a0)
         Carry := R (I) >= LM;
 16a:	4785                	li	a5,1
         R (I) := R (I) mod LM;
 16c:	6841                	lui	a6,0x10
         Carry := R (I) >= LM;
 16e:	0ee05b63          	blez	a4,264 <.L50>

00000172 <.L27>:
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 172:	4db0                	lw	a2,88(a1)
 174:	4df8                	lw	a4,92(a1)
         R (I) := R (I) mod LM;
 176:	04052e23          	sw	zero,92(a0)
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 17a:	963e                	add	a2,a2,a5
         R (I) := R (I) mod LM;
 17c:	01061813          	slli	a6,a2,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 180:	00f637b3          	sltu	a5,a2,a5
         R (I) := R (I) mod LM;
 184:	01085813          	srli	a6,a6,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 188:	973e                	add	a4,a4,a5

0000018a <.LVL92>:
         R (I) := R (I) mod LM;
 18a:	05052c23          	sw	a6,88(a0)
         Carry := R (I) >= LM;
 18e:	4785                	li	a5,1
         R (I) := R (I) mod LM;
 190:	6841                	lui	a6,0x10
         Carry := R (I) >= LM;
 192:	0ce05463          	blez	a4,25a <.L51>

00000196 <.L29>:
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 196:	51b0                	lw	a2,96(a1)
 198:	51f8                	lw	a4,100(a1)
         R (I) := R (I) mod LM;
 19a:	06052223          	sw	zero,100(a0)
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 19e:	963e                	add	a2,a2,a5
         R (I) := R (I) mod LM;
 1a0:	01061813          	slli	a6,a2,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 1a4:	00f637b3          	sltu	a5,a2,a5
         R (I) := R (I) mod LM;
 1a8:	01085813          	srli	a6,a6,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 1ac:	973e                	add	a4,a4,a5

000001ae <.LVL94>:
         R (I) := R (I) mod LM;
 1ae:	07052023          	sw	a6,96(a0)
         Carry := R (I) >= LM;
 1b2:	4785                	li	a5,1
         R (I) := R (I) mod LM;
 1b4:	6841                	lui	a6,0x10
         Carry := R (I) >= LM;
 1b6:	08e05d63          	blez	a4,250 <.L52>

000001ba <.L31>:
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 1ba:	55b0                	lw	a2,104(a1)
 1bc:	55f8                	lw	a4,108(a1)
         R (I) := R (I) mod LM;
 1be:	06052623          	sw	zero,108(a0)
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 1c2:	963e                	add	a2,a2,a5
         R (I) := R (I) mod LM;
 1c4:	01061813          	slli	a6,a2,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 1c8:	00f637b3          	sltu	a5,a2,a5
         R (I) := R (I) mod LM;
 1cc:	01085813          	srli	a6,a6,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 1d0:	973e                	add	a4,a4,a5

000001d2 <.LVL96>:
         R (I) := R (I) mod LM;
 1d2:	07052423          	sw	a6,104(a0)
         Carry := R (I) >= LM;
 1d6:	4785                	li	a5,1
         R (I) := R (I) mod LM;
 1d8:	6841                	lui	a6,0x10
         Carry := R (I) >= LM;
 1da:	06e05663          	blez	a4,246 <.L53>

000001de <.L33>:
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 1de:	59b0                	lw	a2,112(a1)
 1e0:	59f8                	lw	a4,116(a1)
         R (I) := R (I) mod LM;
 1e2:	06052a23          	sw	zero,116(a0)
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 1e6:	963e                	add	a2,a2,a5
         R (I) := R (I) mod LM;
 1e8:	01061813          	slli	a6,a2,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 1ec:	00f637b3          	sltu	a5,a2,a5
         R (I) := R (I) mod LM;
 1f0:	01085813          	srli	a6,a6,0x10
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 1f4:	973e                	add	a4,a4,a5

000001f6 <.LVL98>:
         R (I) := R (I) mod LM;
 1f6:	07052823          	sw	a6,112(a0)
         Carry := R (I) >= LM;
 1fa:	4785                	li	a5,1
         R (I) := R (I) mod LM;
 1fc:	6841                	lui	a6,0x10
         Carry := R (I) >= LM;
 1fe:	02e05f63          	blez	a4,23c <.L54>

00000202 <.L35>:
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 202:	5db8                	lw	a4,120(a1)
 204:	5df0                	lw	a2,124(a1)

00000206 <.LBE197>:
      R (0) := X (0) mod LM;
 206:	06c2                	slli	a3,a3,0x10

00000208 <.LBB198>:
         R (I + 1) := X (I + 1) + Boolean'Pos (Carry);
 208:	973e                	add	a4,a4,a5
 20a:	00f737b3          	sltu	a5,a4,a5
 20e:	97b2                	add	a5,a5,a2

00000210 <.LBE198>:
      R (0) := X (0) mod LM;
 210:	65c1                	lui	a1,0x10

00000212 <.LVL101>:
 212:	82c1                	srli	a3,a3,0x10
        (for all K in Index_16 range 0 .. 14 => (R (K) in GF_Normal_Limb));
      pragma Assert (R (15) in 0 .. GF_Sum_Limb'Last + 1);

      Carry := R (15) >= LM;

      R (0) := R (0) + R2256 * Boolean'Pos (Carry);
 214:	00f05f63          	blez	a5,232 <.L55>

00000218 <.L39>:
 218:	02600793          	li	a5,38

0000021c <.L38>:
 21c:	97b6                	add	a5,a5,a3
      R (15) := R (15) mod LM;
 21e:	0742                	slli	a4,a4,0x10
      R (0) := R (0) + R2256 * Boolean'Pos (Carry);
 220:	00d7b6b3          	sltu	a3,a5,a3
      R (15) := R (15) mod LM;
 224:	8341                	srli	a4,a4,0x10
      R (0) := R (0) + R2256 * Boolean'Pos (Carry);
 226:	c11c                	sw	a5,0(a0)
 228:	c154                	sw	a3,4(a0)
      R (15) := R (15) mod LM;
 22a:	dd38                	sw	a4,120(a0)
 22c:	06052e23          	sw	zero,124(a0)

      return Nearlynormal_GF (R);
   end Sum_To_Nearlynormal;
 230:	8082                	ret

00000232 <.L55>:
      R (0) := R (0) + R2256 * Boolean'Pos (Carry);
 232:	e399                	bnez	a5,238 <.L37>
 234:	feb772e3          	bgeu	a4,a1,218 <.L39>

00000238 <.L37>:
 238:	4781                	li	a5,0
 23a:	b7cd                	j	21c <.L38>

0000023c <.L54>:
         Carry := R (I) >= LM;
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
      Carry := X (0) >= LM;
 2c8:	e701                	bnez	a4,2d0 <.L8>
 2ca:	6741                	lui	a4,0x10
 2cc:	d2e6ffe3          	bgeu	a3,a4,a <.L7>

000002d0 <.L8>:
 2d0:	4781                	li	a5,0
 2d2:	bb25                	j	a <.L7>

Disassembly of section .text.sparknacl__car__difference_to_nearlynormal:

00000000 <sparknacl__car__difference_to_nearlynormal>:
      --  Note that Carry can be negative in this case
      subtype Carry_T is I64 range -1 .. 1;
      Carry : Carry_T;
      R     : GF with Relaxed_Initialization;
   begin
      Carry := ASR_16 (X (0));
   0:	0005a803          	lw	a6,0(a1) # 10000 <.LASF22+0xfa61>
   4:	41d8                	lw	a4,4(a1)
      R (0) := X (0) mod LM;
      R (1) := X (1) + Carry;
   6:	0085af03          	lw	t5,8(a1)
   a:	45d4                	lw	a3,12(a1)

0000000c <.LBB200>:
   c:	01071613          	slli	a2,a4,0x10
  10:	01085793          	srli	a5,a6,0x10
  14:	8fd1                	or	a5,a5,a2

00000016 <.LBE200>:
  16:	9f3e                	add	t5,t5,a5

00000018 <.LBB203>:
  18:	8741                	srai	a4,a4,0x10

0000001a <.LBE203>:
  1a:	00ff37b3          	sltu	a5,t5,a5
  1e:	9736                	add	a4,a4,a3

00000020 <.LBB204>:
      pragma Assert (R (1)'Initialized);

      for I in Index_16 range 1 .. 14 loop
         Carry := ASR_16 (R (I));
         R (I) := R (I) mod LM;
         R (I + 1) := X (I + 1) + Carry;
  20:	0105ae83          	lw	t4,16(a1)

00000024 <.LBE204>:
      R (1) := X (1) + Carry;
  24:	973e                	add	a4,a4,a5

00000026 <.LBB269>:
         R (I + 1) := X (I + 1) + Carry;
  26:	49d4                	lw	a3,20(a1)

00000028 <.LBB205>:
  28:	01071613          	slli	a2,a4,0x10
  2c:	010f5793          	srli	a5,t5,0x10
  30:	8fd1                	or	a5,a5,a2

00000032 <.LBE205>:
  32:	9ebe                	add	t4,t4,a5

00000034 <.LBB238>:
  34:	8741                	srai	a4,a4,0x10

00000036 <.LBE238>:
  36:	00feb7b3          	sltu	a5,t4,a5
  3a:	9736                	add	a4,a4,a3
  3c:	0185ae03          	lw	t3,24(a1)
  40:	973e                	add	a4,a4,a5

00000042 <.LVL126>:
  42:	4dd4                	lw	a3,28(a1)

00000044 <.LBB239>:
  44:	01071613          	slli	a2,a4,0x10
  48:	010ed793          	srli	a5,t4,0x10
  4c:	8fd1                	or	a5,a5,a2

0000004e <.LBE239>:
  4e:	9e3e                	add	t3,t3,a5

00000050 <.LBB240>:
  50:	8741                	srai	a4,a4,0x10

00000052 <.LBE240>:
  52:	00fe37b3          	sltu	a5,t3,a5
  56:	9736                	add	a4,a4,a3
  58:	0205a303          	lw	t1,32(a1)
  5c:	973e                	add	a4,a4,a5

0000005e <.LVL128>:
  5e:	51d4                	lw	a3,36(a1)

00000060 <.LBB241>:
  60:	01071613          	slli	a2,a4,0x10
  64:	010e5793          	srli	a5,t3,0x10
  68:	8fd1                	or	a5,a5,a2

0000006a <.LBE241>:
  6a:	933e                	add	t1,t1,a5

0000006c <.LBB242>:
  6c:	8741                	srai	a4,a4,0x10

0000006e <.LBE242>:
  6e:	00f337b3          	sltu	a5,t1,a5
  72:	9736                	add	a4,a4,a3
  74:	0285af83          	lw	t6,40(a1)
  78:	973e                	add	a4,a4,a5

0000007a <.LVL130>:
  7a:	55d4                	lw	a3,44(a1)

0000007c <.LBB243>:
  7c:	01071613          	slli	a2,a4,0x10
  80:	01035793          	srli	a5,t1,0x10
  84:	8fd1                	or	a5,a5,a2

00000086 <.LBE243>:
  86:	9fbe                	add	t6,t6,a5

00000088 <.LBB244>:
  88:	8741                	srai	a4,a4,0x10

0000008a <.LBE244>:
  8a:	00ffb7b3          	sltu	a5,t6,a5
  8e:	9736                	add	a4,a4,a3
  90:	0305a383          	lw	t2,48(a1)
  94:	973e                	add	a4,a4,a5

00000096 <.LVL132>:
  96:	59d4                	lw	a3,52(a1)

00000098 <.LBB245>:
  98:	01071613          	slli	a2,a4,0x10
  9c:	010fd793          	srli	a5,t6,0x10
  a0:	8fd1                	or	a5,a5,a2

000000a2 <.LBE245>:
  a2:	93be                	add	t2,t2,a5

000000a4 <.LBB246>:
  a4:	8741                	srai	a4,a4,0x10

000000a6 <.LBE246>:
  a6:	00f3b7b3          	sltu	a5,t2,a5
  aa:	9736                	add	a4,a4,a3
  ac:	973e                	add	a4,a4,a5

000000ae <.LVL134>:
  ae:	0385a283          	lw	t0,56(a1)
  b2:	5dd4                	lw	a3,60(a1)

000000b4 <.LBB247>:
  b4:	01071613          	slli	a2,a4,0x10
  b8:	0103d793          	srli	a5,t2,0x10
  bc:	8fd1                	or	a5,a5,a2

000000be <.LBE247>:
  be:	92be                	add	t0,t0,a5

000000c0 <.LBB248>:
  c0:	41075893          	srai	a7,a4,0x10

000000c4 <.LBE248>:
  c4:	00f2b7b3          	sltu	a5,t0,a5
  c8:	98b6                	add	a7,a7,a3

000000ca <.LBE269>:
   function Difference_To_Nearlynormal
  ca:	1141                	addi	sp,sp,-16

000000cc <.LBB270>:
         R (I + 1) := X (I + 1) + Carry;
  cc:	41b8                	lw	a4,64(a1)
  ce:	98be                	add	a7,a7,a5

000000d0 <.LBE270>:
   function Difference_To_Nearlynormal
  d0:	c622                	sw	s0,12(sp)

000000d2 <.LBB249>:
  d2:	01089793          	slli	a5,a7,0x10

000000d6 <.LBE249>:
         R (I + 1) := X (I + 1) + Carry;
  d6:	41e0                	lw	s0,68(a1)

000000d8 <.LBB250>:
  d8:	0102d613          	srli	a2,t0,0x10

000000dc <.LBE250>:
         R (I) := R (I) mod LM;
  dc:	66c1                	lui	a3,0x10
  de:	16fd                	addi	a3,a3,-1

000000e0 <.LBB251>:
  e0:	8e5d                	or	a2,a2,a5

000000e2 <.LBE251>:
         R (I + 1) := X (I + 1) + Carry;
  e2:	9732                	add	a4,a4,a2
         R (I) := R (I) mod LM;
  e4:	00df7f33          	and	t5,t5,a3
  e8:	00defeb3          	and	t4,t4,a3
  ec:	00de7e33          	and	t3,t3,a3
  f0:	00d37333          	and	t1,t1,a3
  f4:	00dfffb3          	and	t6,t6,a3
  f8:	00d3f3b3          	and	t2,t2,a3
  fc:	00d2f2b3          	and	t0,t0,a3

00000100 <.LBB252>:
 100:	4108d893          	srai	a7,a7,0x10

00000104 <.LBE252>:
         R (I + 1) := X (I + 1) + Carry;
 104:	98a2                	add	a7,a7,s0
         R (I) := R (I) mod LM;
 106:	01e52423          	sw	t5,8(a0)
 10a:	01d52823          	sw	t4,16(a0)
 10e:	01c52c23          	sw	t3,24(a0)
 112:	02652023          	sw	t1,32(a0)
 116:	03f52423          	sw	t6,40(a0)
 11a:	02752823          	sw	t2,48(a0)
 11e:	02552c23          	sw	t0,56(a0)
         R (I + 1) := X (I + 1) + Carry;
 122:	00c73633          	sltu	a2,a4,a2
         R (I) := R (I) mod LM;
 126:	00052623          	sw	zero,12(a0)
 12a:	00052a23          	sw	zero,20(a0)
 12e:	00052e23          	sw	zero,28(a0)
 132:	02052223          	sw	zero,36(a0)
 136:	02052623          	sw	zero,44(a0)
 13a:	02052a23          	sw	zero,52(a0)
 13e:	02052e23          	sw	zero,60(a0)
 142:	00d77333          	and	t1,a4,a3
         R (I + 1) := X (I + 1) + Carry;
 146:	9646                	add	a2,a2,a7

00000148 <.LVL138>:
 148:	0485a883          	lw	a7,72(a1)

0000014c <.LBB253>:
 14c:	01061e13          	slli	t3,a2,0x10

00000150 <.LBE253>:
         R (I) := R (I) mod LM;
 150:	04652023          	sw	t1,64(a0)

00000154 <.LBB254>:
 154:	8341                	srli	a4,a4,0x10

00000156 <.LBE254>:
         R (I + 1) := X (I + 1) + Carry;
 156:	04c5a303          	lw	t1,76(a1)

0000015a <.LBB255>:
 15a:	00ee6733          	or	a4,t3,a4

0000015e <.LBE255>:
 15e:	98ba                	add	a7,a7,a4

00000160 <.LBB256>:
 160:	8641                	srai	a2,a2,0x10

00000162 <.LBE256>:
 162:	961a                	add	a2,a2,t1
 164:	00e8b733          	sltu	a4,a7,a4
 168:	0505a303          	lw	t1,80(a1)
 16c:	9732                	add	a4,a4,a2

0000016e <.LVL140>:
 16e:	0545ae03          	lw	t3,84(a1)

00000172 <.LBB257>:
 172:	01071e93          	slli	t4,a4,0x10
 176:	0108d613          	srli	a2,a7,0x10
 17a:	00cee633          	or	a2,t4,a2

0000017e <.LBE257>:
 17e:	9332                	add	t1,t1,a2

00000180 <.LBB258>:
 180:	8741                	srai	a4,a4,0x10

00000182 <.LBE258>:
 182:	00c33633          	sltu	a2,t1,a2
 186:	9772                	add	a4,a4,t3
 188:	0585ae83          	lw	t4,88(a1)
 18c:	9732                	add	a4,a4,a2

0000018e <.LVL142>:
 18e:	05c5ae03          	lw	t3,92(a1)

00000192 <.LBB259>:
 192:	01071f13          	slli	t5,a4,0x10
 196:	01035613          	srli	a2,t1,0x10
 19a:	00cf6633          	or	a2,t5,a2

0000019e <.LBE259>:
 19e:	9eb2                	add	t4,t4,a2

000001a0 <.LBB260>:
 1a0:	8741                	srai	a4,a4,0x10

000001a2 <.LBE260>:
 1a2:	9772                	add	a4,a4,t3
 1a4:	00ceb633          	sltu	a2,t4,a2
 1a8:	0605ae03          	lw	t3,96(a1)
 1ac:	963a                	add	a2,a2,a4

000001ae <.LVL144>:
 1ae:	0645af03          	lw	t5,100(a1)

000001b2 <.LBB261>:
 1b2:	01061f93          	slli	t6,a2,0x10
 1b6:	010ed713          	srli	a4,t4,0x10
 1ba:	00efe733          	or	a4,t6,a4

000001be <.LBE261>:
 1be:	9e3a                	add	t3,t3,a4

000001c0 <.LBB262>:
 1c0:	8641                	srai	a2,a2,0x10

000001c2 <.LBE262>:
 1c2:	00ee3733          	sltu	a4,t3,a4
 1c6:	967a                	add	a2,a2,t5
 1c8:	963a                	add	a2,a2,a4

000001ca <.LVL146>:
 1ca:	0685af03          	lw	t5,104(a1)
 1ce:	06c5af83          	lw	t6,108(a1)

000001d2 <.LBB263>:
 1d2:	01061293          	slli	t0,a2,0x10
 1d6:	010e5713          	srli	a4,t3,0x10
 1da:	00e2e733          	or	a4,t0,a4

000001de <.LBE263>:
 1de:	9f3a                	add	t5,t5,a4

000001e0 <.LBB264>:
 1e0:	8641                	srai	a2,a2,0x10

000001e2 <.LBE264>:
 1e2:	00ef3733          	sltu	a4,t5,a4
 1e6:	967e                	add	a2,a2,t6
 1e8:	963a                	add	a2,a2,a4

000001ea <.LVL148>:
 1ea:	0705af83          	lw	t6,112(a1)
 1ee:	0745a283          	lw	t0,116(a1)

000001f2 <.LBB265>:
 1f2:	01061393          	slli	t2,a2,0x10
 1f6:	010f5713          	srli	a4,t5,0x10
 1fa:	00e3e733          	or	a4,t2,a4

000001fe <.LBE265>:
 1fe:	9fba                	add	t6,t6,a4

00000200 <.LBB266>:
 200:	8641                	srai	a2,a2,0x10

00000202 <.LBE266>:
 202:	00efb733          	sltu	a4,t6,a4
 206:	9616                	add	a2,a2,t0
 208:	0785a383          	lw	t2,120(a1)
 20c:	963a                	add	a2,a2,a4

0000020e <.LVL150>:
 20e:	07c5a283          	lw	t0,124(a1)

00000212 <.LBB267>:
 212:	010fd713          	srli	a4,t6,0x10
 216:	01061593          	slli	a1,a2,0x10

0000021a <.LVL151>:
 21a:	8f4d                	or	a4,a4,a1

0000021c <.LBE267>:
 21c:	007705b3          	add	a1,a4,t2

00000220 <.LBB268>:
 220:	8641                	srai	a2,a2,0x10

00000222 <.LBE268>:
 222:	9616                	add	a2,a2,t0
 224:	00e5b733          	sltu	a4,a1,a4
 228:	9732                	add	a4,a4,a2

0000022a <.LBB272>:
 22a:	01071613          	slli	a2,a4,0x10
 22e:	0105d413          	srli	s0,a1,0x10

00000232 <.LBE272>:
        (for all K in Index_16 range 0 .. 14 => (R (K) in GF_Normal_Limb));
      pragma Assert (R (15) in -1 .. 131071);

      Carry := ASR_16 (R (15));

      R (0) := R (0) + R2256 * Carry;
 232:	02600393          	li	t2,38

00000236 <.LBB276>:
 236:	8c51                	or	s0,s0,a2

00000238 <.LBE276>:
 238:	02838633          	mul	a2,t2,s0

0000023c <.LBB277>:
 23c:	8741                	srai	a4,a4,0x10

0000023e <.LBB278>:
         R (I) := R (I) mod LM;
 23e:	00d8f2b3          	and	t0,a7,a3

00000242 <.LBE278>:
      R (0) := X (0) mod LM;
 242:	00d87833          	and	a6,a6,a3

00000246 <.LBB279>:
         R (I) := R (I) mod LM;
 246:	00d37333          	and	t1,t1,a3
 24a:	00defeb3          	and	t4,t4,a3
 24e:	00de7e33          	and	t3,t3,a3
 252:	00df7f33          	and	t5,t5,a3
 256:	00dfffb3          	and	t6,t6,a3

0000025a <.LBE279>:
      R (15) := R (15) mod LM;
 25a:	8eed                	and	a3,a3,a1
      R (0) := R (0) + R2256 * Carry;
 25c:	0283b8b3          	mulhu	a7,t2,s0
 260:	9832                	add	a6,a6,a2
 262:	00c83633          	sltu	a2,a6,a2

00000266 <.LBB280>:
         R (I) := R (I) mod LM;
 266:	04052223          	sw	zero,68(a0)
 26a:	04552423          	sw	t0,72(a0)
 26e:	04052623          	sw	zero,76(a0)
 272:	04652823          	sw	t1,80(a0)
 276:	04052a23          	sw	zero,84(a0)
 27a:	05d52c23          	sw	t4,88(a0)
 27e:	04052e23          	sw	zero,92(a0)

00000282 <.LBE280>:
      R (0) := R (0) + R2256 * Carry;
 282:	02e38733          	mul	a4,t2,a4

00000286 <.LBB281>:
         R (I) := R (I) mod LM;
 286:	07c52023          	sw	t3,96(a0)
 28a:	06052223          	sw	zero,100(a0)
 28e:	07e52423          	sw	t5,104(a0)
 292:	06052623          	sw	zero,108(a0)
 296:	07f52823          	sw	t6,112(a0)
 29a:	06052a23          	sw	zero,116(a0)

0000029e <.LBE281>:
      R (0) := R (0) + R2256 * Carry;
 29e:	01052023          	sw	a6,0(a0)
      R (15) := R (15) mod LM;
 2a2:	dd34                	sw	a3,120(a0)
 2a4:	06052e23          	sw	zero,124(a0)
      R (0) := R (0) + R2256 * Carry;
 2a8:	9746                	add	a4,a4,a7
 2aa:	9732                	add	a4,a4,a2
 2ac:	c158                	sw	a4,4(a0)

      pragma Assert (R in Nearlynormal_GF);

      return Nearlynormal_GF (R);
   end Difference_To_Nearlynormal;
 2ae:	4432                	lw	s0,12(sp)
 2b0:	0141                	addi	sp,sp,16
 2b2:	8082                	ret

Disassembly of section .text.sparknacl__car__nearlynormal_to_normal:

00000000 <sparknacl__car__nearlynormal_to_normal>:
        ((X (0) in -R2256 .. LMM1 + R2256) and
           (for all K in Index_16 range 1 .. 15 =>
              (X (K) in GF_Normal_Limb)));

      --  Carry and normalize limb 0
      Carry := ASR_16 (X (0));
   0:	0005a803          	lw	a6,0(a1)
   4:	41d8                	lw	a4,4(a1)
      R (0) := X (0) mod LM;
      R (1) := X (1) + Carry;
   6:	0085af03          	lw	t5,8(a1)
   a:	45d4                	lw	a3,12(a1)

0000000c <.LBB282>:
   c:	01071613          	slli	a2,a4,0x10
  10:	01085793          	srli	a5,a6,0x10
  14:	8fd1                	or	a5,a5,a2

00000016 <.LBE282>:
  16:	9f3e                	add	t5,t5,a5

00000018 <.LBB285>:
  18:	8741                	srai	a4,a4,0x10

0000001a <.LBE285>:
  1a:	00ff37b3          	sltu	a5,t5,a5
  1e:	9736                	add	a4,a4,a3

00000020 <.LBB286>:
        ((Carry = -1) = Carrying_Minus_One (R, X, 0));

      for I in Index_16 range 1 .. 14 loop
         Carry := ASR_16 (R (I));
         R (I) := R (I) mod LM;
         R (I + 1) := X (I + 1) + Carry;
  20:	0105ae83          	lw	t4,16(a1)

00000024 <.LBE286>:
      R (1) := X (1) + Carry;
  24:	973e                	add	a4,a4,a5

00000026 <.LBB351>:
         R (I + 1) := X (I + 1) + Carry;
  26:	49d4                	lw	a3,20(a1)

00000028 <.LBB287>:
  28:	01071613          	slli	a2,a4,0x10
  2c:	010f5793          	srli	a5,t5,0x10
  30:	8fd1                	or	a5,a5,a2

00000032 <.LBE287>:
  32:	9ebe                	add	t4,t4,a5

00000034 <.LBB320>:
  34:	8741                	srai	a4,a4,0x10

00000036 <.LBE320>:
  36:	00feb7b3          	sltu	a5,t4,a5
  3a:	9736                	add	a4,a4,a3
  3c:	0185ae03          	lw	t3,24(a1)
  40:	973e                	add	a4,a4,a5

00000042 <.LVL160>:
  42:	4dd4                	lw	a3,28(a1)

00000044 <.LBB321>:
  44:	01071613          	slli	a2,a4,0x10
  48:	010ed793          	srli	a5,t4,0x10
  4c:	8fd1                	or	a5,a5,a2

0000004e <.LBE321>:
  4e:	9e3e                	add	t3,t3,a5

00000050 <.LBB322>:
  50:	8741                	srai	a4,a4,0x10

00000052 <.LBE322>:
  52:	00fe37b3          	sltu	a5,t3,a5
  56:	9736                	add	a4,a4,a3
  58:	0205a303          	lw	t1,32(a1)
  5c:	973e                	add	a4,a4,a5

0000005e <.LVL162>:
  5e:	51d4                	lw	a3,36(a1)

00000060 <.LBB323>:
  60:	01071613          	slli	a2,a4,0x10
  64:	010e5793          	srli	a5,t3,0x10
  68:	8fd1                	or	a5,a5,a2

0000006a <.LBE323>:
  6a:	933e                	add	t1,t1,a5

0000006c <.LBB324>:
  6c:	8741                	srai	a4,a4,0x10

0000006e <.LBE324>:
  6e:	00f337b3          	sltu	a5,t1,a5
  72:	9736                	add	a4,a4,a3
  74:	0285af83          	lw	t6,40(a1)
  78:	973e                	add	a4,a4,a5

0000007a <.LVL164>:
  7a:	55d4                	lw	a3,44(a1)

0000007c <.LBB325>:
  7c:	01071613          	slli	a2,a4,0x10
  80:	01035793          	srli	a5,t1,0x10
  84:	8fd1                	or	a5,a5,a2

00000086 <.LBE325>:
  86:	9fbe                	add	t6,t6,a5

00000088 <.LBB326>:
  88:	8741                	srai	a4,a4,0x10

0000008a <.LBE326>:
  8a:	00ffb7b3          	sltu	a5,t6,a5
  8e:	9736                	add	a4,a4,a3
  90:	0305a383          	lw	t2,48(a1)
  94:	973e                	add	a4,a4,a5

00000096 <.LVL166>:
  96:	59d4                	lw	a3,52(a1)

00000098 <.LBB327>:
  98:	01071613          	slli	a2,a4,0x10
  9c:	010fd793          	srli	a5,t6,0x10
  a0:	8fd1                	or	a5,a5,a2

000000a2 <.LBE327>:
  a2:	93be                	add	t2,t2,a5

000000a4 <.LBB328>:
  a4:	8741                	srai	a4,a4,0x10

000000a6 <.LBE328>:
  a6:	00f3b7b3          	sltu	a5,t2,a5
  aa:	9736                	add	a4,a4,a3
  ac:	973e                	add	a4,a4,a5

000000ae <.LVL168>:
  ae:	0385a283          	lw	t0,56(a1)
  b2:	5dd4                	lw	a3,60(a1)

000000b4 <.LBB329>:
  b4:	01071613          	slli	a2,a4,0x10
  b8:	0103d793          	srli	a5,t2,0x10
  bc:	8fd1                	or	a5,a5,a2

000000be <.LBE329>:
  be:	92be                	add	t0,t0,a5

000000c0 <.LBB330>:
  c0:	41075893          	srai	a7,a4,0x10

000000c4 <.LBE330>:
  c4:	00f2b7b3          	sltu	a5,t0,a5
  c8:	98b6                	add	a7,a7,a3

000000ca <.LBE351>:
   function Nearlynormal_To_Normal
  ca:	1141                	addi	sp,sp,-16

000000cc <.LBB352>:
         R (I + 1) := X (I + 1) + Carry;
  cc:	41b8                	lw	a4,64(a1)
  ce:	98be                	add	a7,a7,a5

000000d0 <.LBE352>:
   function Nearlynormal_To_Normal
  d0:	c622                	sw	s0,12(sp)

000000d2 <.LBB331>:
  d2:	01089793          	slli	a5,a7,0x10

000000d6 <.LBE331>:
         R (I + 1) := X (I + 1) + Carry;
  d6:	41e0                	lw	s0,68(a1)

000000d8 <.LBB332>:
  d8:	0102d613          	srli	a2,t0,0x10

000000dc <.LBE332>:
         R (I) := R (I) mod LM;
  dc:	66c1                	lui	a3,0x10
  de:	16fd                	addi	a3,a3,-1

000000e0 <.LBB333>:
  e0:	8e5d                	or	a2,a2,a5

000000e2 <.LBE333>:
         R (I + 1) := X (I + 1) + Carry;
  e2:	9732                	add	a4,a4,a2
         R (I) := R (I) mod LM;
  e4:	00df7f33          	and	t5,t5,a3
  e8:	00defeb3          	and	t4,t4,a3
  ec:	00de7e33          	and	t3,t3,a3
  f0:	00d37333          	and	t1,t1,a3
  f4:	00dfffb3          	and	t6,t6,a3
  f8:	00d3f3b3          	and	t2,t2,a3
  fc:	00d2f2b3          	and	t0,t0,a3

00000100 <.LBB334>:
 100:	4108d893          	srai	a7,a7,0x10

00000104 <.LBE334>:
         R (I + 1) := X (I + 1) + Carry;
 104:	98a2                	add	a7,a7,s0
         R (I) := R (I) mod LM;
 106:	01e52423          	sw	t5,8(a0)
 10a:	01d52823          	sw	t4,16(a0)
 10e:	01c52c23          	sw	t3,24(a0)
 112:	02652023          	sw	t1,32(a0)
 116:	03f52423          	sw	t6,40(a0)
 11a:	02752823          	sw	t2,48(a0)
 11e:	02552c23          	sw	t0,56(a0)
         R (I + 1) := X (I + 1) + Carry;
 122:	00c73633          	sltu	a2,a4,a2
         R (I) := R (I) mod LM;
 126:	00052623          	sw	zero,12(a0)
 12a:	00052a23          	sw	zero,20(a0)
 12e:	00052e23          	sw	zero,28(a0)
 132:	02052223          	sw	zero,36(a0)
 136:	02052623          	sw	zero,44(a0)
 13a:	02052a23          	sw	zero,52(a0)
 13e:	02052e23          	sw	zero,60(a0)
 142:	00d77333          	and	t1,a4,a3
         R (I + 1) := X (I + 1) + Carry;
 146:	9646                	add	a2,a2,a7

00000148 <.LVL172>:
 148:	0485a883          	lw	a7,72(a1)

0000014c <.LBB335>:
 14c:	01061e13          	slli	t3,a2,0x10

00000150 <.LBE335>:
         R (I) := R (I) mod LM;
 150:	04652023          	sw	t1,64(a0)

00000154 <.LBB336>:
 154:	8341                	srli	a4,a4,0x10

00000156 <.LBE336>:
         R (I + 1) := X (I + 1) + Carry;
 156:	04c5a303          	lw	t1,76(a1)

0000015a <.LBB337>:
 15a:	00ee6733          	or	a4,t3,a4

0000015e <.LBE337>:
 15e:	98ba                	add	a7,a7,a4

00000160 <.LBB338>:
 160:	8641                	srai	a2,a2,0x10

00000162 <.LBE338>:
 162:	961a                	add	a2,a2,t1
 164:	00e8b733          	sltu	a4,a7,a4
 168:	0505a303          	lw	t1,80(a1)
 16c:	9732                	add	a4,a4,a2

0000016e <.LVL174>:
 16e:	0545ae03          	lw	t3,84(a1)

00000172 <.LBB339>:
 172:	01071e93          	slli	t4,a4,0x10
 176:	0108d613          	srli	a2,a7,0x10
 17a:	00cee633          	or	a2,t4,a2

0000017e <.LBE339>:
 17e:	9332                	add	t1,t1,a2

00000180 <.LBB340>:
 180:	8741                	srai	a4,a4,0x10

00000182 <.LBE340>:
 182:	00c33633          	sltu	a2,t1,a2
 186:	9772                	add	a4,a4,t3
 188:	0585ae83          	lw	t4,88(a1)
 18c:	9732                	add	a4,a4,a2

0000018e <.LVL176>:
 18e:	05c5ae03          	lw	t3,92(a1)

00000192 <.LBB341>:
 192:	01071f13          	slli	t5,a4,0x10
 196:	01035613          	srli	a2,t1,0x10
 19a:	00cf6633          	or	a2,t5,a2

0000019e <.LBE341>:
 19e:	9eb2                	add	t4,t4,a2

000001a0 <.LBB342>:
 1a0:	8741                	srai	a4,a4,0x10

000001a2 <.LBE342>:
 1a2:	9772                	add	a4,a4,t3
 1a4:	00ceb633          	sltu	a2,t4,a2
 1a8:	0605ae03          	lw	t3,96(a1)
 1ac:	963a                	add	a2,a2,a4

000001ae <.LVL178>:
 1ae:	0645af03          	lw	t5,100(a1)

000001b2 <.LBB343>:
 1b2:	01061f93          	slli	t6,a2,0x10
 1b6:	010ed713          	srli	a4,t4,0x10
 1ba:	00efe733          	or	a4,t6,a4

000001be <.LBE343>:
 1be:	9e3a                	add	t3,t3,a4

000001c0 <.LBB344>:
 1c0:	8641                	srai	a2,a2,0x10

000001c2 <.LBE344>:
 1c2:	00ee3733          	sltu	a4,t3,a4
 1c6:	967a                	add	a2,a2,t5
 1c8:	963a                	add	a2,a2,a4

000001ca <.LVL180>:
 1ca:	0685af03          	lw	t5,104(a1)
 1ce:	06c5af83          	lw	t6,108(a1)

000001d2 <.LBB345>:
 1d2:	01061293          	slli	t0,a2,0x10
 1d6:	010e5713          	srli	a4,t3,0x10
 1da:	00e2e733          	or	a4,t0,a4

000001de <.LBE345>:
 1de:	9f3a                	add	t5,t5,a4

000001e0 <.LBB346>:
 1e0:	8641                	srai	a2,a2,0x10

000001e2 <.LBE346>:
 1e2:	00ef3733          	sltu	a4,t5,a4
 1e6:	967e                	add	a2,a2,t6
 1e8:	963a                	add	a2,a2,a4

000001ea <.LVL182>:
 1ea:	0705af83          	lw	t6,112(a1)
 1ee:	0745a283          	lw	t0,116(a1)

000001f2 <.LBB347>:
 1f2:	01061393          	slli	t2,a2,0x10
 1f6:	010f5713          	srli	a4,t5,0x10
 1fa:	00e3e733          	or	a4,t2,a4

000001fe <.LBE347>:
 1fe:	9fba                	add	t6,t6,a4

00000200 <.LBB348>:
 200:	8641                	srai	a2,a2,0x10

00000202 <.LBE348>:
 202:	00efb733          	sltu	a4,t6,a4
 206:	9616                	add	a2,a2,t0
 208:	0785a383          	lw	t2,120(a1)
 20c:	963a                	add	a2,a2,a4

0000020e <.LVL184>:
 20e:	07c5a283          	lw	t0,124(a1)

00000212 <.LBB349>:
 212:	010fd713          	srli	a4,t6,0x10
 216:	01061593          	slli	a1,a2,0x10

0000021a <.LVL185>:
 21a:	8f4d                	or	a4,a4,a1

0000021c <.LBE349>:
 21c:	007705b3          	add	a1,a4,t2

00000220 <.LBB350>:
 220:	8641                	srai	a2,a2,0x10

00000222 <.LBE350>:
 222:	9616                	add	a2,a2,t0
 224:	00e5b733          	sltu	a4,a1,a4
 228:	9732                	add	a4,a4,a2

0000022a <.LBB354>:
 22a:	01071613          	slli	a2,a4,0x10
 22e:	0105d413          	srli	s0,a1,0x10

00000232 <.LBE354>:
      --    if Carry = +1, then R (0) in 0 .. 37
      --    if Carry = -1, then R (0) in 65498 .. 65535
      --    if Carry =  0, then it doesn't matter since R (0) in GF_Normal_Limb
      --  Therefore this multiplication and assignment will never overflow and
      --  R (0) remains in GF_Normal_Limb. Phew!
      R (0) := R (0) + R2256 * Carry;
 232:	02600393          	li	t2,38

00000236 <.LBB358>:
 236:	8c51                	or	s0,s0,a2

00000238 <.LBE358>:
 238:	02838633          	mul	a2,t2,s0

0000023c <.LBB359>:
 23c:	8741                	srai	a4,a4,0x10

0000023e <.LBB360>:
         R (I) := R (I) mod LM;
 23e:	00d8f2b3          	and	t0,a7,a3

00000242 <.LBE360>:
      R (0) := X (0) mod LM;
 242:	00d87833          	and	a6,a6,a3

00000246 <.LBB361>:
         R (I) := R (I) mod LM;
 246:	00d37333          	and	t1,t1,a3
 24a:	00defeb3          	and	t4,t4,a3
 24e:	00de7e33          	and	t3,t3,a3
 252:	00df7f33          	and	t5,t5,a3
 256:	00dfffb3          	and	t6,t6,a3

0000025a <.LBE361>:
      R (15) := R (15) mod LM;
 25a:	8eed                	and	a3,a3,a1
      R (0) := R (0) + R2256 * Carry;
 25c:	0283b8b3          	mulhu	a7,t2,s0
 260:	9832                	add	a6,a6,a2
 262:	00c83633          	sltu	a2,a6,a2

00000266 <.LBB362>:
         R (I) := R (I) mod LM;
 266:	04052223          	sw	zero,68(a0)
 26a:	04552423          	sw	t0,72(a0)
 26e:	04052623          	sw	zero,76(a0)
 272:	04652823          	sw	t1,80(a0)
 276:	04052a23          	sw	zero,84(a0)
 27a:	05d52c23          	sw	t4,88(a0)
 27e:	04052e23          	sw	zero,92(a0)

00000282 <.LBE362>:
      R (0) := R (0) + R2256 * Carry;
 282:	02e38733          	mul	a4,t2,a4

00000286 <.LBB363>:
         R (I) := R (I) mod LM;
 286:	07c52023          	sw	t3,96(a0)
 28a:	06052223          	sw	zero,100(a0)
 28e:	07e52423          	sw	t5,104(a0)
 292:	06052623          	sw	zero,108(a0)
 296:	07f52823          	sw	t6,112(a0)
 29a:	06052a23          	sw	zero,116(a0)

0000029e <.LBE363>:
      R (15) := R (15) mod LM;
 29e:	dd34                	sw	a3,120(a0)
 2a0:	06052e23          	sw	zero,124(a0)
      R (0) := R (0) + R2256 * Carry;
 2a4:	01052023          	sw	a6,0(a0)
 2a8:	9746                	add	a4,a4,a7
 2aa:	9732                	add	a4,a4,a2
 2ac:	c158                	sw	a4,4(a0)

      pragma Assert (R (0) in GF_Normal_Limb);
      return Normal_GF (R);
   end Nearlynormal_To_Normal;
 2ae:	4432                	lw	s0,12(sp)
 2b0:	0141                	addi	sp,sp,16
 2b2:	8082                	ret
