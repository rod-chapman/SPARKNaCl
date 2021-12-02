
sparknacl-utils.o:     file format elf32-littleriscv


Disassembly of section .text.sparknacl__utils__pack_25519__subtract_p.1605:

00000000 <sparknacl__utils__pack_25519__subtract_p.1605>:
         R     : GF;
      begin
         R := GF_0;

         --  Limb 0 - subtract LSL of P, which is 16#FFED#
         R (0) := T (0) - 16#FFED#;
   0:	00052383          	lw	t2,0(a0)
   4:	77c1                	lui	a5,0xffff0

00000006 <.LBB15>:

         --  Limbs 1 .. 14 - subtract FFFF with carry
         for I in Index_16 range 1 .. 14 loop
            Carry     := ASR_16 (R (I - 1)) mod 2;
            R (I)     := T (I) - 16#FFFF# - Carry;
   6:	00852283          	lw	t0,8(a0)

0000000a <.LBE15>:
         R (0) := T (0) - 16#FFED#;
   a:	01378713          	addi	a4,a5,19 # ffff0013 <.LFE4+0xfffef66b>
   e:	93ba                	add	t2,t2,a4

00000010 <.LBB16>:

   --  returns equivalent of X >> 16 in C, doing an arithmetic
   --  shift right when X is negative, assuming 2's complement
   --  representation
   function ASR_16 (X : in I64) return I64
   is (To_I64 (Shift_Right_Arithmetic (To_U64 (X), 16)))
  10:	0103d713          	srli	a4,t2,0x10

00000014 <.LBE16>:
            R (I)     := T (I) - 16#FFFF# - Carry;
  14:	0785                	addi	a5,a5,1
  16:	01052f83          	lw	t6,16(a0)
  1a:	9796                	add	a5,a5,t0
            Carry     := ASR_16 (R (I - 1)) mod 2;
  1c:	8b05                	andi	a4,a4,1
            R (I)     := T (I) - 16#FFFF# - Carry;
  1e:	40e782b3          	sub	t0,a5,a4
            R (I - 1) := R (I - 1) mod LM;
  22:	67c1                	lui	a5,0x10
  24:	17fd                	addi	a5,a5,-1

00000026 <.LBB31>:
  26:	0102d713          	srli	a4,t0,0x10

0000002a <.LBE31>:
            R (I)     := T (I) - 16#FFFF# - Carry;
  2a:	01852f03          	lw	t5,24(a0)
  2e:	40ff8fb3          	sub	t6,t6,a5
            Carry     := ASR_16 (R (I - 1)) mod 2;
  32:	8b05                	andi	a4,a4,1
            R (I)     := T (I) - 16#FFFF# - Carry;
  34:	40ef8fb3          	sub	t6,t6,a4

00000038 <.LBB32>:
  38:	010fd713          	srli	a4,t6,0x10

0000003c <.LBE32>:
  3c:	02052e83          	lw	t4,32(a0)
  40:	40ff0f33          	sub	t5,t5,a5
            Carry     := ASR_16 (R (I - 1)) mod 2;
  44:	8b05                	andi	a4,a4,1
            R (I)     := T (I) - 16#FFFF# - Carry;
  46:	40ef0f33          	sub	t5,t5,a4

0000004a <.LBB33>:
  4a:	010f5713          	srli	a4,t5,0x10

0000004e <.LBE33>:
  4e:	02852e03          	lw	t3,40(a0)
  52:	40fe8eb3          	sub	t4,t4,a5
            Carry     := ASR_16 (R (I - 1)) mod 2;
  56:	8b05                	andi	a4,a4,1
            R (I)     := T (I) - 16#FFFF# - Carry;
  58:	40ee8eb3          	sub	t4,t4,a4

0000005c <.LBB34>:
  5c:	010ed713          	srli	a4,t4,0x10

00000060 <.LBE34>:
  60:	03052883          	lw	a7,48(a0)
  64:	40fe0e33          	sub	t3,t3,a5
            Carry     := ASR_16 (R (I - 1)) mod 2;
  68:	8b05                	andi	a4,a4,1
            R (I)     := T (I) - 16#FFFF# - Carry;
  6a:	40ee0e33          	sub	t3,t3,a4

0000006e <.LBB35>:
  6e:	010e5713          	srli	a4,t3,0x10

00000072 <.LBE35>:
  72:	03852803          	lw	a6,56(a0)
  76:	40f888b3          	sub	a7,a7,a5
            Carry     := ASR_16 (R (I - 1)) mod 2;
  7a:	8b05                	andi	a4,a4,1
            R (I)     := T (I) - 16#FFFF# - Carry;
  7c:	40e888b3          	sub	a7,a7,a4

00000080 <.LBB36>:
  80:	0108d713          	srli	a4,a7,0x10

00000084 <.LBE36>:
  84:	4130                	lw	a2,64(a0)
  86:	40f80833          	sub	a6,a6,a5
            Carry     := ASR_16 (R (I - 1)) mod 2;
  8a:	8b05                	andi	a4,a4,1
            R (I)     := T (I) - 16#FFFF# - Carry;
  8c:	40e80833          	sub	a6,a6,a4

00000090 <.LBB37>:
  90:	01085713          	srli	a4,a6,0x10

00000094 <.LBE37>:
  94:	4534                	lw	a3,72(a0)
  96:	8e1d                	sub	a2,a2,a5
            Carry     := ASR_16 (R (I - 1)) mod 2;
  98:	8b05                	andi	a4,a4,1
            R (I)     := T (I) - 16#FFFF# - Carry;
  9a:	8e19                	sub	a2,a2,a4

0000009c <.LBB38>:
  9c:	01065313          	srli	t1,a2,0x10

000000a0 <.LBE38>:
  a0:	4938                	lw	a4,80(a0)
  a2:	8e9d                	sub	a3,a3,a5
            Carry     := ASR_16 (R (I - 1)) mod 2;
  a4:	00137313          	andi	t1,t1,1
            R (I)     := T (I) - 16#FFFF# - Carry;
  a8:	406686b3          	sub	a3,a3,t1

000000ac <.LBE14>:
      procedure Subtract_P (T         : in     Temp_GF;
  ac:	7175                	addi	sp,sp,-144

000000ae <.LBB39>:
  ae:	0106d313          	srli	t1,a3,0x10

000000b2 <.LBE39>:
            R (I - 1) := R (I - 1) mod LM;
  b2:	00fe7e33          	and	t3,t3,a5
  b6:	00f8f8b3          	and	a7,a7,a5
  ba:	00f87833          	and	a6,a6,a5
  be:	8e7d                	and	a2,a2,a5

000000c0 <.LBE45>:
      procedure Subtract_P (T         : in     Temp_GF;
  c0:	c522                	sw	s0,136(sp)

000000c2 <.LBB46>:
            R (I)     := T (I) - 16#FFFF# - Carry;
  c2:	8f1d                	sub	a4,a4,a5
  c4:	4d20                	lw	s0,88(a0)
            Carry     := ASR_16 (R (I - 1)) mod 2;
  c6:	00137313          	andi	t1,t1,1
            R (I - 1) := R (I - 1) mod LM;
  ca:	00f3f3b3          	and	t2,t2,a5
  ce:	00f2f2b3          	and	t0,t0,a5
  d2:	00ffffb3          	and	t6,t6,a5
  d6:	00ff7f33          	and	t5,t5,a5
  da:	00fefeb3          	and	t4,t4,a5
            R (I)     := T (I) - 16#FFFF# - Carry;
  de:	40670733          	sub	a4,a4,t1
            R (I - 1) := R (I - 1) mod LM;
  e2:	8efd                	and	a3,a3,a5
  e4:	d472                	sw	t3,40(sp)
  e6:	d846                	sw	a7,48(sp)
  e8:	dc42                	sw	a6,56(sp)
  ea:	c0b2                	sw	a2,64(sp)

000000ec <.LBE46>:
      procedure Subtract_P (T         : in     Temp_GF;
  ec:	c706                	sw	ra,140(sp)

000000ee <.LBB47>:
            R (I - 1) := R (I - 1) mod LM;
  ee:	c01e                	sw	t2,0(sp)
  f0:	c202                	sw	zero,4(sp)

000000f2 <.LVL1>:
  f2:	c416                	sw	t0,8(sp)
  f4:	c602                	sw	zero,12(sp)

000000f6 <.LVL2>:
  f6:	c87e                	sw	t6,16(sp)
  f8:	ca02                	sw	zero,20(sp)

000000fa <.LVL3>:
  fa:	cc7a                	sw	t5,24(sp)
  fc:	ce02                	sw	zero,28(sp)

000000fe <.LVL4>:
  fe:	d076                	sw	t4,32(sp)
 100:	d202                	sw	zero,36(sp)

00000102 <.LVL5>:
 102:	d602                	sw	zero,44(sp)

00000104 <.LVL6>:
 104:	da02                	sw	zero,52(sp)

00000106 <.LVL7>:
 106:	de02                	sw	zero,60(sp)

00000108 <.LVL8>:
 108:	c282                	sw	zero,68(sp)

0000010a <.LVL9>:
 10a:	c4b6                	sw	a3,72(sp)

0000010c <.LBB40>:
 10c:	01075693          	srli	a3,a4,0x10

00000110 <.LBE40>:
 110:	8f7d                	and	a4,a4,a5
            R (I)     := T (I) - 16#FFFF# - Carry;
 112:	40f40333          	sub	t1,s0,a5
 116:	06052883          	lw	a7,96(a0)
            R (I - 1) := R (I - 1) mod LM;
 11a:	c8ba                	sw	a4,80(sp)
            Carry     := ASR_16 (R (I - 1)) mod 2;
 11c:	0016f713          	andi	a4,a3,1
            R (I)     := T (I) - 16#FFFF# - Carry;
 120:	40e30333          	sub	t1,t1,a4

00000124 <.LBB41>:
 124:	01035713          	srli	a4,t1,0x10

00000128 <.LBE41>:
 128:	06852803          	lw	a6,104(a0)
 12c:	40f888b3          	sub	a7,a7,a5
            Carry     := ASR_16 (R (I - 1)) mod 2;
 130:	8b05                	andi	a4,a4,1
            R (I)     := T (I) - 16#FFFF# - Carry;
 132:	40e888b3          	sub	a7,a7,a4

00000136 <.LBB42>:
 136:	0108d713          	srli	a4,a7,0x10

0000013a <.LBE42>:
 13a:	5930                	lw	a2,112(a0)
 13c:	40f80833          	sub	a6,a6,a5
            Carry     := ASR_16 (R (I - 1)) mod 2;
 140:	8b05                	andi	a4,a4,1
            R (I)     := T (I) - 16#FFFF# - Carry;
 142:	40e80833          	sub	a6,a6,a4

00000146 <.LBB43>:
 146:	01085693          	srli	a3,a6,0x10

0000014a <.LBE43>:

         --  Limb 15 - Subtract MSL (Most Significant Limb)
         --  of P (16#7FFF#) with carry.
         --  Note that Limb 15 might become negative on underflow
         Carry  := ASR_16 (R (14)) mod 2;
         R (15) := (T (15) - 16#7FFF#) - Carry;
 14a:	5d38                	lw	a4,120(a0)

0000014c <.LBB48>:
            R (I)     := T (I) - 16#FFFF# - Carry;
 14c:	8e1d                	sub	a2,a2,a5
            Carry     := ASR_16 (R (I - 1)) mod 2;
 14e:	8a85                	andi	a3,a3,1
            R (I)     := T (I) - 16#FFFF# - Carry;
 150:	8e15                	sub	a2,a2,a3

00000152 <.LBE48>:
         R (15) := (T (15) - 16#7FFF#) - Carry;
 152:	07c52e03          	lw	t3,124(a0)
 156:	76e1                	lui	a3,0xffff8

00000158 <.LBB49>:
 158:	01065513          	srli	a0,a2,0x10

0000015c <.LBE49>:
 15c:	0685                	addi	a3,a3,1
 15e:	96ba                	add	a3,a3,a4
         Carry  := ASR_16 (R (14)) mod 2;
 160:	8905                	andi	a0,a0,1
         R (15) := (T (15) - 16#7FFF#) - Carry;
 162:	00e6b433          	sltu	s0,a3,a4
 166:	40a68533          	sub	a0,a3,a0
 16a:	fffe0713          	addi	a4,t3,-1
 16e:	943a                	add	s0,s0,a4
 170:	00a6b6b3          	sltu	a3,a3,a0

00000174 <.LBB51>:
            R (I - 1) := R (I - 1) mod LM;
 174:	00f87833          	and	a6,a6,a5
 178:	00f37333          	and	t1,t1,a5
 17c:	00f8f8b3          	and	a7,a7,a5

00000180 <.LBE51>:
         R (15) := (T (15) - 16#7FFF#) - Carry;
 180:	8c15                	sub	s0,s0,a3
         --   R (15) := R (15) mod LM;
         --  If this bug is re-introduced here, then SPARK _does_ report
         --  this as a type-safety error, since if R (15) is normalized
         --  but R (14) is not, then the prover is unable to show that
         --  R is a Temp_GF subtype in the assignment to Result below.
         R (14) := R (14) mod LM;
 182:	8ff1                	and	a5,a5,a2

00000184 <.LBB52>:
            R (I - 1) := R (I - 1) mod LM;
 184:	d4c2                	sw	a6,104(sp)

00000186 <.LBE52>:
         R (14) := R (14) mod LM;
 186:	d8be                	sw	a5,112(sp)

00000188 <.LBB53>:
            R (I - 1) := R (I - 1) mod LM;
 188:	c682                	sw	zero,76(sp)

0000018a <.LVL11>:
 18a:	ca82                	sw	zero,84(sp)

0000018c <.LVL12>:
 18c:	cc9a                	sw	t1,88(sp)
 18e:	ce82                	sw	zero,92(sp)

00000190 <.LVL13>:
 190:	d0c6                	sw	a7,96(sp)
 192:	d282                	sw	zero,100(sp)

00000194 <.LVL14>:
 194:	d682                	sw	zero,108(sp)

00000196 <.LBE53>:
         R (15) := (T (15) - 16#7FFF#) - Carry;
 196:	dcaa                	sw	a0,120(sp)
 198:	dea2                	sw	s0,124(sp)
         R (14) := R (14) mod LM;
 19a:	da82                	sw	zero,116(sp)

         --  Note that R (15) is not normalized here, so that the
         --  result of the first subtraction is numerically correct
         --  as the input to the second.
         Underflow := R (15) < 0;
         Result    := R;
 19c:	878a                	mv	a5,sp
 19e:	08010813          	addi	a6,sp,128

000001a2 <.L2>:
 1a2:	4388                	lw	a0,0(a5)
 1a4:	43d0                	lw	a2,4(a5)
 1a6:	4794                	lw	a3,8(a5)
 1a8:	47d8                	lw	a4,12(a5)
 1aa:	c188                	sw	a0,0(a1)
 1ac:	c1d0                	sw	a2,4(a1)
 1ae:	c594                	sw	a3,8(a1)
 1b0:	c5d8                	sw	a4,12(a1)
 1b2:	07c1                	addi	a5,a5,16
 1b4:	05c1                	addi	a1,a1,16
 1b6:	ff0796e3          	bne	a5,a6,1a2 <.L2>
         Sanitize_GF (R);
 1ba:	850a                	mv	a0,sp
 1bc:	00000097          	auipc	ra,0x0
 1c0:	000080e7          	jalr	ra # 1bc <.L2+0x1a>

000001c4 <.LBE56>:
         pragma Unreferenced (R);
      end Subtract_P;
 1c4:	40ba                	lw	ra,140(sp)
 1c6:	01f45513          	srli	a0,s0,0x1f
 1ca:	442a                	lw	s0,136(sp)
 1cc:	6149                	addi	sp,sp,144
 1ce:	8082                	ret

Disassembly of section .text.sparknacl__utils__Tbit_to_swapmask_tableBIP:

00000000 <sparknacl__utils__Tbit_to_swapmask_tableBIP>:
   0:	8082                	ret

Disassembly of section .text.sparknacl__utils__cswap:

00000000 <sparknacl__utils__cswap>:
      C : U64 := Bit_To_Swapmask (Swap);
   0:	000007b7          	lui	a5,0x0
   4:	00361713          	slli	a4,a2,0x3
   8:	00078793          	mv	a5,a5

0000000c <.LBB58>:
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
   c:	00052883          	lw	a7,0(a0)
  10:	00452803          	lw	a6,4(a0)
  14:	4190                	lw	a2,0(a1)

00000016 <.LVL19>:
  16:	41d4                	lw	a3,4(a1)

00000018 <.LBE58>:
      C : U64 := Bit_To_Swapmask (Swap);
  18:	97ba                	add	a5,a5,a4
  1a:	4398                	lw	a4,0(a5)
  1c:	43dc                	lw	a5,4(a5)

0000001e <.LBB59>:
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
  1e:	01164633          	xor	a2,a2,a7
  22:	0106c6b3          	xor	a3,a3,a6

00000026 <.LBE59>:
   procedure CSwap (P    : in out GF;
  26:	1141                	addi	sp,sp,-16

00000028 <.LBB60>:
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
  28:	8e79                	and	a2,a2,a4
  2a:	8efd                	and	a3,a3,a5

0000002c <.LBE60>:
   procedure CSwap (P    : in out GF;
  2c:	c606                	sw	ra,12(sp)

0000002e <.LBB61>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
  2e:	011648b3          	xor	a7,a2,a7
  32:	0106c833          	xor	a6,a3,a6
  36:	01152023          	sw	a7,0(a0)
  3a:	01052223          	sw	a6,4(a0)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
  3e:	0005a303          	lw	t1,0(a1)
  42:	0045a883          	lw	a7,4(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
  46:	0085a803          	lw	a6,8(a1)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
  4a:	00c34633          	xor	a2,t1,a2

0000004e <.LVL22>:
  4e:	00d8c6b3          	xor	a3,a7,a3
  52:	c1d4                	sw	a3,4(a1)

00000054 <.LVL23>:
  54:	c190                	sw	a2,0(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
  56:	00852883          	lw	a7,8(a0)
  5a:	4550                	lw	a2,12(a0)
  5c:	45d4                	lw	a3,12(a1)
  5e:	01184833          	xor	a6,a6,a7
  62:	00e87833          	and	a6,a6,a4
  66:	8eb1                	xor	a3,a3,a2
  68:	8efd                	and	a3,a3,a5

0000006a <.LVL24>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
  6a:	0108c8b3          	xor	a7,a7,a6
  6e:	8e35                	xor	a2,a2,a3
  70:	01152423          	sw	a7,8(a0)
  74:	c550                	sw	a2,12(a0)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
  76:	0085a303          	lw	t1,8(a1)
  7a:	00c5a883          	lw	a7,12(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
  7e:	4990                	lw	a2,16(a1)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
  80:	01034833          	xor	a6,t1,a6

00000084 <.LVL25>:
  84:	00d8c6b3          	xor	a3,a7,a3
  88:	c5d4                	sw	a3,12(a1)

0000008a <.LVL26>:
  8a:	0105a423          	sw	a6,8(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
  8e:	01052883          	lw	a7,16(a0)
  92:	01452803          	lw	a6,20(a0)
  96:	49d4                	lw	a3,20(a1)
  98:	01164633          	xor	a2,a2,a7
  9c:	8e79                	and	a2,a2,a4
  9e:	0106c6b3          	xor	a3,a3,a6
  a2:	8efd                	and	a3,a3,a5

000000a4 <.LVL27>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
  a4:	00c8c8b3          	xor	a7,a7,a2
  a8:	00d84833          	xor	a6,a6,a3
  ac:	01152823          	sw	a7,16(a0)
  b0:	01052a23          	sw	a6,20(a0)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
  b4:	0105a883          	lw	a7,16(a1)
  b8:	0145a803          	lw	a6,20(a1)
  bc:	00c8c633          	xor	a2,a7,a2

000000c0 <.LVL28>:
  c0:	00d846b3          	xor	a3,a6,a3
  c4:	c990                	sw	a2,16(a1)
  c6:	c9d4                	sw	a3,20(a1)

000000c8 <.LVL29>:
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
  c8:	01852883          	lw	a7,24(a0)
  cc:	01c52803          	lw	a6,28(a0)
  d0:	4d90                	lw	a2,24(a1)
  d2:	4dd4                	lw	a3,28(a1)
  d4:	01164633          	xor	a2,a2,a7
  d8:	0106c6b3          	xor	a3,a3,a6
  dc:	8e79                	and	a2,a2,a4
  de:	8efd                	and	a3,a3,a5

000000e0 <.LVL30>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
  e0:	00c8c8b3          	xor	a7,a7,a2
  e4:	00d84833          	xor	a6,a6,a3
  e8:	01152c23          	sw	a7,24(a0)
  ec:	01052e23          	sw	a6,28(a0)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
  f0:	0185a303          	lw	t1,24(a1)
  f4:	01c5a883          	lw	a7,28(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
  f8:	0205a803          	lw	a6,32(a1)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
  fc:	00c34633          	xor	a2,t1,a2

00000100 <.LVL31>:
 100:	00d8c6b3          	xor	a3,a7,a3
 104:	cdd4                	sw	a3,28(a1)

00000106 <.LVL32>:
 106:	cd90                	sw	a2,24(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 108:	02052883          	lw	a7,32(a0)
 10c:	5150                	lw	a2,36(a0)
 10e:	51d4                	lw	a3,36(a1)
 110:	01184833          	xor	a6,a6,a7
 114:	00e87833          	and	a6,a6,a4
 118:	8eb1                	xor	a3,a3,a2
 11a:	8efd                	and	a3,a3,a5

0000011c <.LVL33>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 11c:	0108c8b3          	xor	a7,a7,a6
 120:	8e35                	xor	a2,a2,a3
 122:	03152023          	sw	a7,32(a0)
 126:	d150                	sw	a2,36(a0)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 128:	0205a303          	lw	t1,32(a1)
 12c:	0245a883          	lw	a7,36(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 130:	5590                	lw	a2,40(a1)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 132:	01034833          	xor	a6,t1,a6

00000136 <.LVL34>:
 136:	00d8c6b3          	xor	a3,a7,a3
 13a:	d1d4                	sw	a3,36(a1)

0000013c <.LVL35>:
 13c:	0305a023          	sw	a6,32(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 140:	02852883          	lw	a7,40(a0)
 144:	02c52803          	lw	a6,44(a0)
 148:	55d4                	lw	a3,44(a1)
 14a:	01164633          	xor	a2,a2,a7
 14e:	8e79                	and	a2,a2,a4
 150:	0106c6b3          	xor	a3,a3,a6
 154:	8efd                	and	a3,a3,a5

00000156 <.LVL36>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 156:	00c8c8b3          	xor	a7,a7,a2
 15a:	00d84833          	xor	a6,a6,a3
 15e:	03152423          	sw	a7,40(a0)
 162:	03052623          	sw	a6,44(a0)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 166:	0285a883          	lw	a7,40(a1)
 16a:	02c5a803          	lw	a6,44(a1)
 16e:	00c8c633          	xor	a2,a7,a2

00000172 <.LVL37>:
 172:	00d846b3          	xor	a3,a6,a3
 176:	d5d4                	sw	a3,44(a1)

00000178 <.LVL38>:
 178:	d590                	sw	a2,40(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 17a:	03052883          	lw	a7,48(a0)
 17e:	03452803          	lw	a6,52(a0)
 182:	5990                	lw	a2,48(a1)
 184:	59d4                	lw	a3,52(a1)
 186:	01164633          	xor	a2,a2,a7
 18a:	0106c6b3          	xor	a3,a3,a6
 18e:	8e79                	and	a2,a2,a4
 190:	8efd                	and	a3,a3,a5

00000192 <.LVL39>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 192:	00c8c8b3          	xor	a7,a7,a2
 196:	00d84833          	xor	a6,a6,a3
 19a:	03152823          	sw	a7,48(a0)
 19e:	03052a23          	sw	a6,52(a0)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 1a2:	0305a303          	lw	t1,48(a1)
 1a6:	0345a883          	lw	a7,52(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 1aa:	0385a803          	lw	a6,56(a1)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 1ae:	00c34633          	xor	a2,t1,a2

000001b2 <.LVL40>:
 1b2:	00d8c6b3          	xor	a3,a7,a3
 1b6:	d9d4                	sw	a3,52(a1)

000001b8 <.LVL41>:
 1b8:	d990                	sw	a2,48(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 1ba:	03852883          	lw	a7,56(a0)
 1be:	5d50                	lw	a2,60(a0)
 1c0:	5dd4                	lw	a3,60(a1)
 1c2:	01184833          	xor	a6,a6,a7
 1c6:	00e87833          	and	a6,a6,a4
 1ca:	8eb1                	xor	a3,a3,a2
 1cc:	8efd                	and	a3,a3,a5

000001ce <.LVL42>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 1ce:	0108c8b3          	xor	a7,a7,a6
 1d2:	8e35                	xor	a2,a2,a3
 1d4:	03152c23          	sw	a7,56(a0)
 1d8:	dd50                	sw	a2,60(a0)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 1da:	0385a303          	lw	t1,56(a1)
 1de:	03c5a883          	lw	a7,60(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 1e2:	41b0                	lw	a2,64(a1)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 1e4:	01034833          	xor	a6,t1,a6

000001e8 <.LVL43>:
 1e8:	00d8c6b3          	xor	a3,a7,a3
 1ec:	ddd4                	sw	a3,60(a1)

000001ee <.LVL44>:
 1ee:	0305ac23          	sw	a6,56(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 1f2:	04052883          	lw	a7,64(a0)
 1f6:	04452803          	lw	a6,68(a0)
 1fa:	41f4                	lw	a3,68(a1)
 1fc:	01164633          	xor	a2,a2,a7
 200:	8e79                	and	a2,a2,a4
 202:	0106c6b3          	xor	a3,a3,a6
 206:	8efd                	and	a3,a3,a5

00000208 <.LVL45>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 208:	00c8c8b3          	xor	a7,a7,a2
 20c:	00d84833          	xor	a6,a6,a3
 210:	05152023          	sw	a7,64(a0)
 214:	05052223          	sw	a6,68(a0)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 218:	0405a303          	lw	t1,64(a1)
 21c:	0445a883          	lw	a7,68(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 220:	0485a803          	lw	a6,72(a1)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 224:	00c34633          	xor	a2,t1,a2

00000228 <.LVL46>:
 228:	00d8c6b3          	xor	a3,a7,a3
 22c:	c1f4                	sw	a3,68(a1)

0000022e <.LVL47>:
 22e:	c1b0                	sw	a2,64(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 230:	04852883          	lw	a7,72(a0)
 234:	4570                	lw	a2,76(a0)
 236:	45f4                	lw	a3,76(a1)
 238:	01184833          	xor	a6,a6,a7
 23c:	00e87833          	and	a6,a6,a4
 240:	8eb1                	xor	a3,a3,a2
 242:	8efd                	and	a3,a3,a5

00000244 <.LVL48>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 244:	0108c8b3          	xor	a7,a7,a6
 248:	8e35                	xor	a2,a2,a3
 24a:	05152423          	sw	a7,72(a0)
 24e:	c570                	sw	a2,76(a0)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 250:	0485a303          	lw	t1,72(a1)
 254:	04c5a883          	lw	a7,76(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 258:	49b0                	lw	a2,80(a1)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 25a:	01034833          	xor	a6,t1,a6

0000025e <.LVL49>:
 25e:	00d8c6b3          	xor	a3,a7,a3
 262:	c5f4                	sw	a3,76(a1)

00000264 <.LVL50>:
 264:	0505a423          	sw	a6,72(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 268:	49f4                	lw	a3,84(a1)
 26a:	05052883          	lw	a7,80(a0)
 26e:	05452803          	lw	a6,84(a0)
 272:	01164633          	xor	a2,a2,a7
 276:	0106c6b3          	xor	a3,a3,a6
 27a:	8e79                	and	a2,a2,a4
 27c:	8efd                	and	a3,a3,a5

0000027e <.LVL51>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 27e:	00c8c8b3          	xor	a7,a7,a2
 282:	00d84833          	xor	a6,a6,a3
 286:	05152823          	sw	a7,80(a0)
 28a:	05052a23          	sw	a6,84(a0)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 28e:	0505a303          	lw	t1,80(a1)
 292:	0545a883          	lw	a7,84(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 296:	0585a803          	lw	a6,88(a1)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 29a:	00c34633          	xor	a2,t1,a2

0000029e <.LVL52>:
 29e:	00d8c6b3          	xor	a3,a7,a3
 2a2:	c9b0                	sw	a2,80(a1)
 2a4:	c9f4                	sw	a3,84(a1)

000002a6 <.LVL53>:
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 2a6:	4df0                	lw	a2,92(a1)
 2a8:	05852883          	lw	a7,88(a0)
 2ac:	4d74                	lw	a3,92(a0)
 2ae:	01184833          	xor	a6,a6,a7
 2b2:	8e35                	xor	a2,a2,a3
 2b4:	00e87833          	and	a6,a6,a4
 2b8:	8e7d                	and	a2,a2,a5

000002ba <.LVL54>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 2ba:	0108c8b3          	xor	a7,a7,a6
 2be:	8eb1                	xor	a3,a3,a2
 2c0:	05152c23          	sw	a7,88(a0)
 2c4:	cd74                	sw	a3,92(a0)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 2c6:	0585a303          	lw	t1,88(a1)
 2ca:	05c5a883          	lw	a7,92(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 2ce:	51b4                	lw	a3,96(a1)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 2d0:	01034833          	xor	a6,t1,a6

000002d4 <.LVL55>:
 2d4:	00c8c633          	xor	a2,a7,a2
 2d8:	0505ac23          	sw	a6,88(a1)
 2dc:	cdf0                	sw	a2,92(a1)

000002de <.LVL56>:
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 2de:	06052883          	lw	a7,96(a0)
 2e2:	5170                	lw	a2,100(a0)
 2e4:	0645a803          	lw	a6,100(a1)
 2e8:	0116c6b3          	xor	a3,a3,a7
 2ec:	8ef9                	and	a3,a3,a4
 2ee:	00c84833          	xor	a6,a6,a2
 2f2:	00f87833          	and	a6,a6,a5

000002f6 <.LVL57>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 2f6:	00d8c8b3          	xor	a7,a7,a3
 2fa:	01064633          	xor	a2,a2,a6
 2fe:	07152023          	sw	a7,96(a0)
 302:	d170                	sw	a2,100(a0)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 304:	51b0                	lw	a2,96(a1)
 306:	8eb1                	xor	a3,a3,a2

00000308 <.LVL58>:
 308:	d1b4                	sw	a3,96(a1)
 30a:	0645a883          	lw	a7,100(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 30e:	55b0                	lw	a2,104(a1)
 310:	55f4                	lw	a3,108(a1)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 312:	0108c833          	xor	a6,a7,a6
 316:	0705a223          	sw	a6,100(a1)

0000031a <.LVL59>:
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 31a:	06852883          	lw	a7,104(a0)
 31e:	06c52803          	lw	a6,108(a0)
 322:	01164633          	xor	a2,a2,a7
 326:	0106c6b3          	xor	a3,a3,a6
 32a:	8e79                	and	a2,a2,a4
 32c:	8efd                	and	a3,a3,a5

0000032e <.LVL60>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 32e:	00c8c8b3          	xor	a7,a7,a2
 332:	00d84833          	xor	a6,a6,a3
 336:	07152423          	sw	a7,104(a0)
 33a:	07052623          	sw	a6,108(a0)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 33e:	0685a303          	lw	t1,104(a1)
 342:	06c5a883          	lw	a7,108(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 346:	0705a803          	lw	a6,112(a1)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 34a:	00c34633          	xor	a2,t1,a2

0000034e <.LVL61>:
 34e:	00d8c6b3          	xor	a3,a7,a3
 352:	d5f4                	sw	a3,108(a1)

00000354 <.LVL62>:
 354:	d5b0                	sw	a2,104(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 356:	07052883          	lw	a7,112(a0)
 35a:	5970                	lw	a2,116(a0)
 35c:	59f4                	lw	a3,116(a1)
 35e:	01184833          	xor	a6,a6,a7
 362:	00e87833          	and	a6,a6,a4
 366:	8eb1                	xor	a3,a3,a2
 368:	8efd                	and	a3,a3,a5

0000036a <.LVL63>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 36a:	0108c8b3          	xor	a7,a7,a6
 36e:	8e35                	xor	a2,a2,a3
 370:	07152823          	sw	a7,112(a0)
 374:	d970                	sw	a2,116(a0)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 376:	0745a883          	lw	a7,116(a1)
 37a:	0705a303          	lw	t1,112(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 37e:	5db0                	lw	a2,120(a1)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 380:	00d8c6b3          	xor	a3,a7,a3

00000384 <.LVL64>:
 384:	01034833          	xor	a6,t1,a6
 388:	d9f4                	sw	a3,116(a1)

0000038a <.LVL65>:
 38a:	0705a823          	sw	a6,112(a1)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 38e:	07852883          	lw	a7,120(a0)
 392:	07c52803          	lw	a6,124(a0)
 396:	5df4                	lw	a3,124(a1)
 398:	01164633          	xor	a2,a2,a7
 39c:	8f71                	and	a4,a4,a2

0000039e <.LVL66>:
 39e:	0106c6b3          	xor	a3,a3,a6
 3a2:	8ff5                	and	a5,a5,a3

000003a4 <.LVL67>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 3a4:	00e8c8b3          	xor	a7,a7,a4
 3a8:	00f84833          	xor	a6,a6,a5
 3ac:	07152c23          	sw	a7,120(a0)
 3b0:	07052e23          	sw	a6,124(a0)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 3b4:	5db0                	lw	a2,120(a1)
 3b6:	5df4                	lw	a3,124(a1)
 3b8:	8f31                	xor	a4,a4,a2

000003ba <.LVL68>:
 3ba:	8fb5                	xor	a5,a5,a3
 3bc:	ddb8                	sw	a4,120(a1)
 3be:	ddfc                	sw	a5,124(a1)

000003c0 <.LBE61>:
      Sanitize_U64 (T);
 3c0:	00000097          	auipc	ra,0x0
 3c4:	000080e7          	jalr	ra # 3c0 <.LBE61>

000003c8 <.LVL69>:
   end CSwap;
 3c8:	40b2                	lw	ra,12(sp)
 3ca:	0141                	addi	sp,sp,16
      Sanitize_U64 (C);
 3cc:	00000317          	auipc	t1,0x0
 3d0:	00030067          	jr	t1 # 3cc <.LVL69+0x4>

Disassembly of section .text.sparknacl__utils__pack_25519:

00000000 <sparknacl__utils__pack_25519>:
   function Pack_25519 (N : in Normal_GF) return Bytes_32
   0:	7145                	addi	sp,sp,-464
   2:	1c812423          	sw	s0,456(sp)
   6:	1c112623          	sw	ra,460(sp)
   a:	1c912223          	sw	s1,452(sp)
   e:	1d212023          	sw	s2,448(sp)
  12:	1b312e23          	sw	s3,444(sp)
  16:	1b412c23          	sw	s4,440(sp)
  1a:	1b512a23          	sw	s5,436(sp)
  1e:	1b612823          	sw	s6,432(sp)
  22:	1b712623          	sw	s7,428(sp)
  26:	1b812423          	sw	s8,424(sp)
  2a:	1b912223          	sw	s9,420(sp)
  2e:	1ba12023          	sw	s10,416(sp)
  32:	19b12e23          	sw	s11,412(sp)
  36:	842a                	mv	s0,a0
      First_Underflow  : Boolean;
      Second_Underflow : Boolean;
   begin
      --  Make a variable copy of N so can be passed to
      --  calls to CSwap below
      L := N;
  38:	081c                	addi	a5,sp,16
  3a:	08058813          	addi	a6,a1,128

0000003e <.L10>:
  3e:	4188                	lw	a0,0(a1)
  40:	41d0                	lw	a2,4(a1)
  42:	4594                	lw	a3,8(a1)
  44:	45d8                	lw	a4,12(a1)
  46:	c388                	sw	a0,0(a5)
  48:	c3d0                	sw	a2,4(a5)
  4a:	c794                	sw	a3,8(a5)
  4c:	c7d8                	sw	a4,12(a5)
  4e:	05c1                	addi	a1,a1,16
  50:	07c1                	addi	a5,a5,16
  52:	ff0596e3          	bne	a1,a6,3e <.L10>
      --        end if;
      --     end if;

      --  Constant-time version: always do both subtractions, then
      --  use CSwap to swap the right answer into R2
      Subtract_P (L,  R1, First_Underflow);
  56:	090c                	addi	a1,sp,144
  58:	0808                	addi	a0,sp,16
  5a:	00000097          	auipc	ra,0x0
  5e:	000080e7          	jalr	ra # 5a <.L10+0x1c>

00000062 <.LVL73>:
  62:	87aa                	mv	a5,a0
      Subtract_P (R1, R2, Second_Underflow);
  64:	0a0c                	addi	a1,sp,272
  66:	0908                	addi	a0,sp,144
      Subtract_P (L,  R1, First_Underflow);
  68:	c63e                	sw	a5,12(sp)

0000006a <.LBB71>:
      C : U64 := Bit_To_Swapmask (Swap);
  6a:	000004b7          	lui	s1,0x0

0000006e <.LBE71>:
      Subtract_P (R1, R2, Second_Underflow);
  6e:	00000097          	auipc	ra,0x0
  72:	000080e7          	jalr	ra # 6e <.LBE71>

00000076 <.LBB76>:
      C : U64 := Bit_To_Swapmask (Swap);
  76:	00048493          	mv	s1,s1
  7a:	00351793          	slli	a5,a0,0x3

0000007e <.LBB73>:
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
  7e:	11012d03          	lw	s10,272(sp)
  82:	11412c83          	lw	s9,276(sp)
  86:	11812c03          	lw	s8,280(sp)
  8a:	11c12b83          	lw	s7,284(sp)
  8e:	4a4a                	lw	s4,144(sp)
  90:	49da                	lw	s3,148(sp)
  92:	496a                	lw	s2,152(sp)
  94:	40fa                	lw	ra,156(sp)
  96:	538a                	lw	t2,160(sp)
  98:	529a                	lw	t0,164(sp)
  9a:	12012f83          	lw	t6,288(sp)
  9e:	12412f03          	lw	t5,292(sp)
  a2:	5eaa                	lw	t4,168(sp)
  a4:	5e3a                	lw	t3,172(sp)
  a6:	12812883          	lw	a7,296(sp)
  aa:	12c12803          	lw	a6,300(sp)

000000ae <.LBE73>:
      C : U64 := Bit_To_Swapmask (Swap);
  ae:	97a6                	add	a5,a5,s1
  b0:	4398                	lw	a4,0(a5)
  b2:	43dc                	lw	a5,4(a5)

000000b4 <.LBB74>:
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
  b4:	01aa4533          	xor	a0,s4,s10

000000b8 <.LVL77>:
  b8:	0199c5b3          	xor	a1,s3,s9
  bc:	01894633          	xor	a2,s2,s8
  c0:	0170c6b3          	xor	a3,ra,s7
  c4:	01f3cb33          	xor	s6,t2,t6
  c8:	01e2cab3          	xor	s5,t0,t5
  cc:	011ec333          	xor	t1,t4,a7
  d0:	010e4833          	xor	a6,t3,a6
  d4:	00eb7b33          	and	s6,s6,a4
  d8:	00fafab3          	and	s5,s5,a5
  dc:	00e37333          	and	t1,t1,a4
  e0:	8d79                	and	a0,a0,a4
  e2:	8dfd                	and	a1,a1,a5

000000e4 <.LVL78>:
  e4:	8e79                	and	a2,a2,a4
  e6:	8efd                	and	a3,a3,a5
  e8:	00f87833          	and	a6,a6,a5
         P (I) := To_I64 (To_U64 (P (I)) xor T);
  ec:	00aa4a33          	xor	s4,s4,a0
  f0:	00b9c9b3          	xor	s3,s3,a1
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
  f4:	00ad4533          	xor	a0,s10,a0

000000f8 <.LVL79>:
  f8:	00bcc5b3          	xor	a1,s9,a1
         P (I) := To_I64 (To_U64 (P (I)) xor T);
  fc:	00c94933          	xor	s2,s2,a2
 100:	00d0c0b3          	xor	ra,ra,a3
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 104:	00cc4633          	xor	a2,s8,a2
 108:	00dbc6b3          	xor	a3,s7,a3
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 10c:	0163c3b3          	xor	t2,t2,s6
 110:	0152c2b3          	xor	t0,t0,s5
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 114:	016fcfb3          	xor	t6,t6,s6
 118:	015f4f33          	xor	t5,t5,s5
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 11c:	006eceb3          	xor	t4,t4,t1
 120:	010e4e33          	xor	t3,t3,a6
 124:	c952                	sw	s4,144(sp)
 126:	cb4e                	sw	s3,148(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 128:	10a12823          	sw	a0,272(sp)
 12c:	10b12a23          	sw	a1,276(sp)

00000130 <.LVL82>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 130:	cd4a                	sw	s2,152(sp)
 132:	cf06                	sw	ra,156(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 134:	10c12c23          	sw	a2,280(sp)
 138:	10d12e23          	sw	a3,284(sp)

0000013c <.LVL84>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 13c:	d11e                	sw	t2,160(sp)
 13e:	d316                	sw	t0,164(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 140:	13f12023          	sw	t6,288(sp)
 144:	13e12223          	sw	t5,292(sp)

00000148 <.LVL85>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 148:	d576                	sw	t4,168(sp)
 14a:	d772                	sw	t3,172(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 14c:	0068c8b3          	xor	a7,a7,t1
 150:	13112423          	sw	a7,296(sp)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 154:	4eae                	lw	t4,200(sp)
 156:	14812883          	lw	a7,328(sp)
 15a:	13412d83          	lw	s11,308(sp)
 15e:	13812d03          	lw	s10,312(sp)
 162:	13c12c83          	lw	s9,316(sp)
 166:	14012c03          	lw	s8,320(sp)
 16a:	5a4a                	lw	s4,176(sp)
 16c:	59da                	lw	s3,180(sp)
 16e:	13012903          	lw	s2,304(sp)
 172:	50ea                	lw	ra,184(sp)
 174:	53fa                	lw	t2,188(sp)
 176:	428e                	lw	t0,192(sp)
 178:	4f9e                	lw	t6,196(sp)
 17a:	14412f03          	lw	t5,324(sp)
 17e:	4e3e                	lw	t3,204(sp)
 180:	011ecab3          	xor	s5,t4,a7
 184:	14c12883          	lw	a7,332(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 188:	12c12303          	lw	t1,300(sp)

0000018c <.LVL86>:
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 18c:	012a4bb3          	xor	s7,s4,s2
 190:	01b9c533          	xor	a0,s3,s11
 194:	01a0c5b3          	xor	a1,ra,s10
 198:	0193c633          	xor	a2,t2,s9
 19c:	0182c6b3          	xor	a3,t0,s8
 1a0:	01efcb33          	xor	s6,t6,t5
 1a4:	00ebfbb3          	and	s7,s7,a4
 1a8:	00fb7b33          	and	s6,s6,a5
 1ac:	00eafab3          	and	s5,s5,a4
 1b0:	8d7d                	and	a0,a0,a5
 1b2:	8df9                	and	a1,a1,a4
 1b4:	8e7d                	and	a2,a2,a5
 1b6:	8ef9                	and	a3,a3,a4
 1b8:	011e48b3          	xor	a7,t3,a7
 1bc:	00f8f8b3          	and	a7,a7,a5
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 1c0:	01034833          	xor	a6,t1,a6
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 1c4:	017a4a33          	xor	s4,s4,s7
 1c8:	00a9c9b3          	xor	s3,s3,a0
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 1cc:	01794933          	xor	s2,s2,s7
 1d0:	00adc533          	xor	a0,s11,a0
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 1d4:	00b0c0b3          	xor	ra,ra,a1
 1d8:	00c3c3b3          	xor	t2,t2,a2
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 1dc:	00bd45b3          	xor	a1,s10,a1
 1e0:	00ccc633          	xor	a2,s9,a2
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 1e4:	00d2c2b3          	xor	t0,t0,a3
 1e8:	016fcfb3          	xor	t6,t6,s6
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 1ec:	00dc46b3          	xor	a3,s8,a3
 1f0:	016f4f33          	xor	t5,t5,s6
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 1f4:	015eceb3          	xor	t4,t4,s5
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 1f8:	14812303          	lw	t1,328(sp)
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 1fc:	011e4e33          	xor	t3,t3,a7
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 200:	13012623          	sw	a6,300(sp)

00000204 <.LVL87>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 204:	d952                	sw	s4,176(sp)
 206:	db4e                	sw	s3,180(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 208:	13212823          	sw	s2,304(sp)
 20c:	12a12a23          	sw	a0,308(sp)

00000210 <.LVL89>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 210:	dd06                	sw	ra,184(sp)
 212:	df1e                	sw	t2,188(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 214:	12b12c23          	sw	a1,312(sp)
 218:	12c12e23          	sw	a2,316(sp)

0000021c <.LVL91>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 21c:	c196                	sw	t0,192(sp)
 21e:	c3fe                	sw	t6,196(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 220:	14d12023          	sw	a3,320(sp)
 224:	15e12223          	sw	t5,324(sp)

00000228 <.LVL93>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 228:	c5f6                	sw	t4,200(sp)
 22a:	c7f2                	sw	t3,204(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 22c:	14c12683          	lw	a3,332(sp)
 230:	01534333          	xor	t1,t1,s5
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 234:	15012d83          	lw	s11,336(sp)
 238:	15412d03          	lw	s10,340(sp)
 23c:	15812c83          	lw	s9,344(sp)
 240:	15c12c03          	lw	s8,348(sp)
 244:	16012b83          	lw	s7,352(sp)
 248:	49ce                	lw	s3,208(sp)
 24a:	495e                	lw	s2,212(sp)
 24c:	40ee                	lw	ra,216(sp)
 24e:	43fe                	lw	t2,220(sp)
 250:	528e                	lw	t0,224(sp)
 252:	5f9e                	lw	t6,228(sp)
 254:	16412f03          	lw	t5,356(sp)
 258:	5eae                	lw	t4,232(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 25a:	14612423          	sw	t1,328(sp)
 25e:	0116c8b3          	xor	a7,a3,a7

00000262 <.LVL94>:
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 262:	16812303          	lw	t1,360(sp)
 266:	5e3e                	lw	t3,236(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 268:	15112623          	sw	a7,332(sp)

0000026c <.LVL95>:
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 26c:	16c12883          	lw	a7,364(sp)
 270:	01b9c833          	xor	a6,s3,s11
 274:	01a94533          	xor	a0,s2,s10
 278:	0190c5b3          	xor	a1,ra,s9
 27c:	0183c633          	xor	a2,t2,s8
 280:	0172c6b3          	xor	a3,t0,s7
 284:	01efcb33          	xor	s6,t6,t5
 288:	006ecab3          	xor	s5,t4,t1
 28c:	00fb7b33          	and	s6,s6,a5
 290:	00eafab3          	and	s5,s5,a4
 294:	011e4a33          	xor	s4,t3,a7
 298:	00e87833          	and	a6,a6,a4
 29c:	8d7d                	and	a0,a0,a5

0000029e <.LVL96>:
 29e:	8df9                	and	a1,a1,a4
 2a0:	8e7d                	and	a2,a2,a5
 2a2:	8ef9                	and	a3,a3,a4
 2a4:	00fa7a33          	and	s4,s4,a5
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 2a8:	0109c9b3          	xor	s3,s3,a6
 2ac:	00a94933          	xor	s2,s2,a0
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 2b0:	010dc833          	xor	a6,s11,a6

000002b4 <.LVL97>:
 2b4:	00ad4533          	xor	a0,s10,a0
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 2b8:	00b0c0b3          	xor	ra,ra,a1
 2bc:	00c3c3b3          	xor	t2,t2,a2
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 2c0:	00bcc5b3          	xor	a1,s9,a1
 2c4:	00cc4633          	xor	a2,s8,a2
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 2c8:	00d2c2b3          	xor	t0,t0,a3
 2cc:	016fcfb3          	xor	t6,t6,s6
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 2d0:	00dbc6b3          	xor	a3,s7,a3
 2d4:	016f4f33          	xor	t5,t5,s6
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 2d8:	015eceb3          	xor	t4,t4,s5
 2dc:	014e4e33          	xor	t3,t3,s4
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 2e0:	01534333          	xor	t1,t1,s5
 2e4:	0148c8b3          	xor	a7,a7,s4
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 2e8:	c9ce                	sw	s3,208(sp)
 2ea:	cbca                	sw	s2,212(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 2ec:	15012823          	sw	a6,336(sp)
 2f0:	14a12a23          	sw	a0,340(sp)

000002f4 <.LVL100>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 2f4:	cd86                	sw	ra,216(sp)
 2f6:	cf9e                	sw	t2,220(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 2f8:	14b12c23          	sw	a1,344(sp)
 2fc:	14c12e23          	sw	a2,348(sp)

00000300 <.LVL102>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 300:	d196                	sw	t0,224(sp)
 302:	d3fe                	sw	t6,228(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 304:	16d12023          	sw	a3,352(sp)
 308:	17e12223          	sw	t5,356(sp)

0000030c <.LVL104>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 30c:	d5f6                	sw	t4,232(sp)
 30e:	d7f2                	sw	t3,236(sp)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 310:	17012d83          	lw	s11,368(sp)
 314:	17412d03          	lw	s10,372(sp)
 318:	17812c83          	lw	s9,376(sp)
 31c:	17c12c03          	lw	s8,380(sp)
 320:	59ce                	lw	s3,240(sp)
 322:	595e                	lw	s2,244(sp)
 324:	50ee                	lw	ra,248(sp)
 326:	53fe                	lw	t2,252(sp)
 328:	10012283          	lw	t0,256(sp)
 32c:	10412f83          	lw	t6,260(sp)
 330:	18012f03          	lw	t5,384(sp)
 334:	18412e83          	lw	t4,388(sp)
 338:	10812e03          	lw	t3,264(sp)
 33c:	18c12803          	lw	a6,396(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 340:	16612423          	sw	t1,360(sp)
 344:	17112623          	sw	a7,364(sp)

00000348 <.LVL105>:
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 348:	10c12303          	lw	t1,268(sp)
 34c:	18812883          	lw	a7,392(sp)
 350:	01b9c533          	xor	a0,s3,s11
 354:	01034a33          	xor	s4,t1,a6
 358:	011e4ab3          	xor	s5,t3,a7
 35c:	01a945b3          	xor	a1,s2,s10
 360:	0190c633          	xor	a2,ra,s9
 364:	0183c6b3          	xor	a3,t2,s8
 368:	01e2cbb3          	xor	s7,t0,t5
 36c:	01dfcb33          	xor	s6,t6,t4
 370:	00ebfbb3          	and	s7,s7,a4
 374:	00fb7b33          	and	s6,s6,a5
 378:	8d79                	and	a0,a0,a4
 37a:	8dfd                	and	a1,a1,a5

0000037c <.LVL106>:
 37c:	8e79                	and	a2,a2,a4
 37e:	8efd                	and	a3,a3,a5
 380:	00eaf733          	and	a4,s5,a4

00000384 <.LVL107>:
 384:	00fa77b3          	and	a5,s4,a5
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 388:	00c0c0b3          	xor	ra,ra,a2
 38c:	00d3c3b3          	xor	t2,t2,a3
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 390:	00ccc633          	xor	a2,s9,a2
 394:	00dc46b3          	xor	a3,s8,a3
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 398:	0172c2b3          	xor	t0,t0,s7
 39c:	016fcfb3          	xor	t6,t6,s6
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 3a0:	017f4f33          	xor	t5,t5,s7
 3a4:	016eceb3          	xor	t4,t4,s6
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 3a8:	00ee4e33          	xor	t3,t3,a4
 3ac:	00f34333          	xor	t1,t1,a5
 3b0:	00a9c9b3          	xor	s3,s3,a0
 3b4:	00b94933          	xor	s2,s2,a1
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 3b8:	00adc533          	xor	a0,s11,a0

000003bc <.LVL108>:
 3bc:	00bd45b3          	xor	a1,s10,a1
 3c0:	00e8c733          	xor	a4,a7,a4
 3c4:	00f84833          	xor	a6,a6,a5
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 3c8:	dd86                	sw	ra,248(sp)
 3ca:	df9e                	sw	t2,252(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 3cc:	16c12c23          	sw	a2,376(sp)
 3d0:	16d12e23          	sw	a3,380(sp)
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 3d4:	10512023          	sw	t0,256(sp)
 3d8:	11f12223          	sw	t6,260(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 3dc:	19e12023          	sw	t5,384(sp)
 3e0:	19d12223          	sw	t4,388(sp)
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 3e4:	11c12423          	sw	t3,264(sp)
 3e8:	10612623          	sw	t1,268(sp)
 3ec:	d9ce                	sw	s3,240(sp)
 3ee:	dbca                	sw	s2,244(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 3f0:	16a12823          	sw	a0,368(sp)
 3f4:	16b12a23          	sw	a1,372(sp)

000003f8 <.LVL109>:
 3f8:	18e12423          	sw	a4,392(sp)
 3fc:	19012623          	sw	a6,396(sp)

00000400 <.LBE74>:
      Sanitize_U64 (T);
 400:	00000097          	auipc	ra,0x0
 404:	000080e7          	jalr	ra # 400 <.LBE74>

00000408 <.LVL110>:
      Sanitize_U64 (C);
 408:	00000097          	auipc	ra,0x0
 40c:	000080e7          	jalr	ra # 408 <.LVL110>

00000410 <.LBB77>:
      C : U64 := Bit_To_Swapmask (Swap);
 410:	47b2                	lw	a5,12(sp)

00000412 <.LBB79>:
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 412:	11012c03          	lw	s8,272(sp)
 416:	11412b83          	lw	s7,276(sp)

0000041a <.LBE79>:
      C : U64 := Bit_To_Swapmask (Swap);
 41a:	078e                	slli	a5,a5,0x3

0000041c <.LBB80>:
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 41c:	11812b03          	lw	s6,280(sp)
 420:	11c12a83          	lw	s5,284(sp)
 424:	4a42                	lw	s4,16(sp)
 426:	49d2                	lw	s3,20(sp)
 428:	4962                	lw	s2,24(sp)
 42a:	40f2                	lw	ra,28(sp)
 42c:	5382                	lw	t2,32(sp)
 42e:	5292                	lw	t0,36(sp)
 430:	12012f83          	lw	t6,288(sp)
 434:	12412f03          	lw	t5,292(sp)
 438:	5ea2                	lw	t4,40(sp)
 43a:	12812883          	lw	a7,296(sp)

0000043e <.LBE80>:
      C : U64 := Bit_To_Swapmask (Swap);
 43e:	94be                	add	s1,s1,a5
 440:	4098                	lw	a4,0(s1)
 442:	40dc                	lw	a5,4(s1)

00000444 <.LBB81>:
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 444:	12c12d83          	lw	s11,300(sp)
 448:	5e32                	lw	t3,44(sp)
 44a:	018a4533          	xor	a0,s4,s8
 44e:	0179c5b3          	xor	a1,s3,s7
 452:	01694633          	xor	a2,s2,s6
 456:	0150c6b3          	xor	a3,ra,s5
 45a:	01f3ccb3          	xor	s9,t2,t6
 45e:	01e2c4b3          	xor	s1,t0,t5
 462:	011ec333          	xor	t1,t4,a7
 466:	00ecfcb3          	and	s9,s9,a4
 46a:	8cfd                	and	s1,s1,a5
 46c:	00e37333          	and	t1,t1,a4
 470:	01be4833          	xor	a6,t3,s11
 474:	8d79                	and	a0,a0,a4
 476:	8dfd                	and	a1,a1,a5

00000478 <.LVL113>:
 478:	8e79                	and	a2,a2,a4
 47a:	8efd                	and	a3,a3,a5
 47c:	00f87833          	and	a6,a6,a5
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 480:	00aa4a33          	xor	s4,s4,a0
 484:	00b9c9b3          	xor	s3,s3,a1
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 488:	00ac4533          	xor	a0,s8,a0

0000048c <.LVL114>:
 48c:	00bbc5b3          	xor	a1,s7,a1
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 490:	00c94933          	xor	s2,s2,a2
 494:	00d0c0b3          	xor	ra,ra,a3
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 498:	00cb4633          	xor	a2,s6,a2
 49c:	00dac6b3          	xor	a3,s5,a3
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 4a0:	0193c3b3          	xor	t2,t2,s9
 4a4:	0092c2b3          	xor	t0,t0,s1
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 4a8:	019fcfb3          	xor	t6,t6,s9
 4ac:	009f4f33          	xor	t5,t5,s1
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 4b0:	006eceb3          	xor	t4,t4,t1
 4b4:	010e4e33          	xor	t3,t3,a6
 4b8:	c852                	sw	s4,16(sp)
 4ba:	ca4e                	sw	s3,20(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 4bc:	10a12823          	sw	a0,272(sp)
 4c0:	10b12a23          	sw	a1,276(sp)

000004c4 <.LVL117>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 4c4:	cc4a                	sw	s2,24(sp)
 4c6:	ce06                	sw	ra,28(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 4c8:	10c12c23          	sw	a2,280(sp)
 4cc:	10d12e23          	sw	a3,284(sp)

000004d0 <.LVL119>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 4d0:	d01e                	sw	t2,32(sp)
 4d2:	d216                	sw	t0,36(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 4d4:	13f12023          	sw	t6,288(sp)
 4d8:	13e12223          	sw	t5,292(sp)

000004dc <.LVL120>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 4dc:	d476                	sw	t4,40(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 4de:	0068c8b3          	xor	a7,a7,t1
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 4e2:	d672                	sw	t3,44(sp)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 4e4:	13012d03          	lw	s10,304(sp)
 4e8:	13412c83          	lw	s9,308(sp)
 4ec:	13812c03          	lw	s8,312(sp)
 4f0:	13c12b83          	lw	s7,316(sp)
 4f4:	59c2                	lw	s3,48(sp)
 4f6:	5952                	lw	s2,52(sp)
 4f8:	54e2                	lw	s1,56(sp)
 4fa:	50f2                	lw	ra,60(sp)
 4fc:	4386                	lw	t2,64(sp)
 4fe:	4296                	lw	t0,68(sp)
 500:	14012f83          	lw	t6,320(sp)
 504:	14412f03          	lw	t5,324(sp)
 508:	4ea6                	lw	t4,72(sp)
 50a:	4e36                	lw	t3,76(sp)
 50c:	14812303          	lw	t1,328(sp)

00000510 <.LVL121>:
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 510:	13112423          	sw	a7,296(sp)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 514:	14c12883          	lw	a7,332(sp)
 518:	01a9c533          	xor	a0,s3,s10
 51c:	019945b3          	xor	a1,s2,s9
 520:	0184c633          	xor	a2,s1,s8
 524:	0170c6b3          	xor	a3,ra,s7
 528:	01f3cb33          	xor	s6,t2,t6
 52c:	01e2cab3          	xor	s5,t0,t5
 530:	006eca33          	xor	s4,t4,t1
 534:	011e48b3          	xor	a7,t3,a7
 538:	00eb7b33          	and	s6,s6,a4
 53c:	00fafab3          	and	s5,s5,a5
 540:	00ea7a33          	and	s4,s4,a4
 544:	8d79                	and	a0,a0,a4
 546:	8dfd                	and	a1,a1,a5
 548:	8e79                	and	a2,a2,a4
 54a:	8efd                	and	a3,a3,a5
 54c:	00f8f8b3          	and	a7,a7,a5
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 550:	010dc833          	xor	a6,s11,a6
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 554:	00a9c9b3          	xor	s3,s3,a0
 558:	00b94933          	xor	s2,s2,a1
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 55c:	00ad4533          	xor	a0,s10,a0
 560:	00bcc5b3          	xor	a1,s9,a1
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 564:	8cb1                	xor	s1,s1,a2
 566:	00d0c0b3          	xor	ra,ra,a3
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 56a:	00cc4633          	xor	a2,s8,a2
 56e:	00dbc6b3          	xor	a3,s7,a3
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 572:	0163c3b3          	xor	t2,t2,s6
 576:	0152c2b3          	xor	t0,t0,s5
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 57a:	016fcfb3          	xor	t6,t6,s6
 57e:	015f4f33          	xor	t5,t5,s5
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 582:	014eceb3          	xor	t4,t4,s4
 586:	011e4e33          	xor	t3,t3,a7
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 58a:	01434333          	xor	t1,t1,s4
 58e:	13012623          	sw	a6,300(sp)

00000592 <.LVL122>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 592:	d84e                	sw	s3,48(sp)
 594:	da4a                	sw	s2,52(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 596:	12a12823          	sw	a0,304(sp)
 59a:	12b12a23          	sw	a1,308(sp)

0000059e <.LVL124>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 59e:	dc26                	sw	s1,56(sp)
 5a0:	de06                	sw	ra,60(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 5a2:	12c12c23          	sw	a2,312(sp)
 5a6:	12d12e23          	sw	a3,316(sp)

000005aa <.LVL126>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 5aa:	c09e                	sw	t2,64(sp)
 5ac:	c296                	sw	t0,68(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 5ae:	15f12023          	sw	t6,320(sp)
 5b2:	15e12223          	sw	t5,324(sp)

000005b6 <.LVL127>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 5b6:	c4f6                	sw	t4,72(sp)
 5b8:	c6f2                	sw	t3,76(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 5ba:	14612423          	sw	t1,328(sp)
 5be:	14c12683          	lw	a3,332(sp)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 5c2:	15012d03          	lw	s10,336(sp)
 5c6:	15412c83          	lw	s9,340(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 5ca:	0116c8b3          	xor	a7,a3,a7

000005ce <.LVL128>:
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 5ce:	15812c03          	lw	s8,344(sp)
 5d2:	15c12b83          	lw	s7,348(sp)
 5d6:	4946                	lw	s2,80(sp)
 5d8:	44d6                	lw	s1,84(sp)
 5da:	42e6                	lw	t0,88(sp)
 5dc:	4ff6                	lw	t6,92(sp)
 5de:	5e06                	lw	t3,96(sp)
 5e0:	5316                	lw	t1,100(sp)
 5e2:	16412803          	lw	a6,356(sp)
 5e6:	5526                	lw	a0,104(sp)
 5e8:	55b6                	lw	a1,108(sp)
 5ea:	16812603          	lw	a2,360(sp)
 5ee:	16c12683          	lw	a3,364(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 5f2:	15112623          	sw	a7,332(sp)

000005f6 <.LVL129>:
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 5f6:	16012883          	lw	a7,352(sp)
 5fa:	01a940b3          	xor	ra,s2,s10
 5fe:	0194c3b3          	xor	t2,s1,s9
 602:	0182cf33          	xor	t5,t0,s8
 606:	017fceb3          	xor	t4,t6,s7
 60a:	011e4b33          	xor	s6,t3,a7
 60e:	01034ab3          	xor	s5,t1,a6
 612:	00c54a33          	xor	s4,a0,a2
 616:	00d5c9b3          	xor	s3,a1,a3
 61a:	00eb7b33          	and	s6,s6,a4
 61e:	00fafab3          	and	s5,s5,a5
 622:	00ea7a33          	and	s4,s4,a4
 626:	00f9f9b3          	and	s3,s3,a5
 62a:	00e0f0b3          	and	ra,ra,a4
 62e:	00f3f3b3          	and	t2,t2,a5

00000632 <.LVL130>:
 632:	00ef7f33          	and	t5,t5,a4
 636:	00fefeb3          	and	t4,t4,a5
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 63a:	00194933          	xor	s2,s2,ra
 63e:	0074c4b3          	xor	s1,s1,t2
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 642:	001d40b3          	xor	ra,s10,ra

00000646 <.LVL131>:
 646:	007cc3b3          	xor	t2,s9,t2
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 64a:	01e2c2b3          	xor	t0,t0,t5
 64e:	01dfcfb3          	xor	t6,t6,t4
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 652:	01ec4f33          	xor	t5,s8,t5
 656:	01dbceb3          	xor	t4,s7,t4
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 65a:	016e4e33          	xor	t3,t3,s6
 65e:	01534333          	xor	t1,t1,s5
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 662:	0168c8b3          	xor	a7,a7,s6
 666:	01584833          	xor	a6,a6,s5
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 66a:	01454533          	xor	a0,a0,s4
 66e:	0135c5b3          	xor	a1,a1,s3
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 672:	01464633          	xor	a2,a2,s4
 676:	0136c6b3          	xor	a3,a3,s3
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 67a:	c8ca                	sw	s2,80(sp)
 67c:	caa6                	sw	s1,84(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 67e:	14112823          	sw	ra,336(sp)
 682:	14712a23          	sw	t2,340(sp)

00000686 <.LVL134>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 686:	cc96                	sw	t0,88(sp)
 688:	cefe                	sw	t6,92(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 68a:	15e12c23          	sw	t5,344(sp)
 68e:	15d12e23          	sw	t4,348(sp)

00000692 <.LVL136>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 692:	d0f2                	sw	t3,96(sp)
 694:	d29a                	sw	t1,100(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 696:	17112023          	sw	a7,352(sp)
 69a:	17012223          	sw	a6,356(sp)

0000069e <.LVL137>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 69e:	d4aa                	sw	a0,104(sp)
 6a0:	d6ae                	sw	a1,108(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 6a2:	16c12423          	sw	a2,360(sp)
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 6a6:	17012c03          	lw	s8,368(sp)
 6aa:	17412b83          	lw	s7,372(sp)
 6ae:	17812b03          	lw	s6,376(sp)
 6b2:	17c12a83          	lw	s5,380(sp)
 6b6:	5946                	lw	s2,112(sp)
 6b8:	54d6                	lw	s1,116(sp)
 6ba:	52e6                	lw	t0,120(sp)
 6bc:	5ff6                	lw	t6,124(sp)
 6be:	4e0a                	lw	t3,128(sp)
 6c0:	431a                	lw	t1,132(sp)
 6c2:	18012883          	lw	a7,384(sp)
 6c6:	18412803          	lw	a6,388(sp)
 6ca:	452a                	lw	a0,136(sp)
 6cc:	45ba                	lw	a1,140(sp)
 6ce:	18812603          	lw	a2,392(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 6d2:	16d12623          	sw	a3,364(sp)

000006d6 <.LVL138>:
         T := C and (To_U64 (P (I)) xor To_U64 (Q (I)));
 6d6:	18c12683          	lw	a3,396(sp)
 6da:	00c54d33          	xor	s10,a0,a2
 6de:	018940b3          	xor	ra,s2,s8
 6e2:	00d5ccb3          	xor	s9,a1,a3
 6e6:	0174c3b3          	xor	t2,s1,s7
 6ea:	0162cf33          	xor	t5,t0,s6
 6ee:	015fceb3          	xor	t4,t6,s5
 6f2:	011e4a33          	xor	s4,t3,a7
 6f6:	010349b3          	xor	s3,t1,a6
 6fa:	00ea7a33          	and	s4,s4,a4
 6fe:	00f9f9b3          	and	s3,s3,a5
 702:	00e0f0b3          	and	ra,ra,a4
 706:	00f3f3b3          	and	t2,t2,a5

0000070a <.LVL139>:
 70a:	00ef7f33          	and	t5,t5,a4
 70e:	00fefeb3          	and	t4,t4,a5
 712:	00ed7733          	and	a4,s10,a4

00000716 <.LVL140>:
 716:	00fcf7b3          	and	a5,s9,a5

0000071a <.LVL141>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 71a:	01e2c2b3          	xor	t0,t0,t5
 71e:	01dfcfb3          	xor	t6,t6,t4
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 722:	01eb4f33          	xor	t5,s6,t5
 726:	01daceb3          	xor	t4,s5,t4
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 72a:	014e4e33          	xor	t3,t3,s4
 72e:	01334333          	xor	t1,t1,s3
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 732:	0148c8b3          	xor	a7,a7,s4
 736:	01384833          	xor	a6,a6,s3
 73a:	8e39                	xor	a2,a2,a4
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 73c:	8d39                	xor	a0,a0,a4
 73e:	8dbd                	xor	a1,a1,a5
 740:	00194933          	xor	s2,s2,ra
 744:	0074c4b3          	xor	s1,s1,t2
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 748:	001c40b3          	xor	ra,s8,ra

0000074c <.LVL142>:
 74c:	007bc3b3          	xor	t2,s7,t2
 750:	8ebd                	xor	a3,a3,a5
 752:	16112823          	sw	ra,368(sp)
 756:	16712a23          	sw	t2,372(sp)

0000075a <.LVL144>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 75a:	dc96                	sw	t0,120(sp)
 75c:	defe                	sw	t6,124(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 75e:	17e12c23          	sw	t5,376(sp)
 762:	17d12e23          	sw	t4,380(sp)

00000766 <.LVL146>:
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 766:	c172                	sw	t3,128(sp)
 768:	c31a                	sw	t1,132(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 76a:	19112023          	sw	a7,384(sp)
 76e:	19012223          	sw	a6,388(sp)

00000772 <.LVL147>:
 772:	18c12423          	sw	a2,392(sp)
         P (I) := To_I64 (To_U64 (P (I)) xor T);
 776:	d8ca                	sw	s2,112(sp)
 778:	daa6                	sw	s1,116(sp)
 77a:	c52a                	sw	a0,136(sp)
 77c:	c72e                	sw	a1,140(sp)
         Q (I) := To_I64 (To_U64 (Q (I)) xor T);
 77e:	18d12623          	sw	a3,396(sp)

00000782 <.LBE81>:
      Sanitize_U64 (T);
 782:	00000097          	auipc	ra,0x0
 786:	000080e7          	jalr	ra # 782 <.LBE81>

0000078a <.LVL148>:
      Sanitize_U64 (C);
 78a:	00000097          	auipc	ra,0x0
 78e:	000080e7          	jalr	ra # 78a <.LVL148>

00000792 <.LBE77>:
      CSwap (R1, R2, Second_Underflow);
      CSwap (L,  R2, First_Underflow);

      --  Sanitize local data as per the WireGuard sources
      Sanitize_GF (L);
 792:	0808                	addi	a0,sp,16
 794:	00000097          	auipc	ra,0x0
 798:	000080e7          	jalr	ra # 794 <.LBE77+0x2>

0000079c <.LVL150>:
      Sanitize_GF (R1);
 79c:	0908                	addi	a0,sp,144
 79e:	00000097          	auipc	ra,0x0
 7a2:	000080e7          	jalr	ra # 79e <.LVL150+0x2>

000007a6 <.LVL151>:
      Sanitize_Boolean (First_Underflow);
 7a6:	00000097          	auipc	ra,0x0
 7aa:	000080e7          	jalr	ra # 7a6 <.LVL151>

000007ae <.LVL152>:
      Sanitize_Boolean (Second_Underflow);
 7ae:	00000097          	auipc	ra,0x0
 7b2:	000080e7          	jalr	ra # 7ae <.LVL152>

000007b6 <.LBB82>:
            Result (2 * I + 1) := Byte (X (I) / 256);
 7b6:	11c12383          	lw	t2,284(sp)
 7ba:	11412483          	lw	s1,276(sp)
 7be:	12412283          	lw	t0,292(sp)
 7c2:	12c12f83          	lw	t6,300(sp)
 7c6:	13412603          	lw	a2,308(sp)
 7ca:	13c12683          	lw	a3,316(sp)
 7ce:	14412703          	lw	a4,324(sp)
 7d2:	14c12783          	lw	a5,332(sp)
            Result (2 * I)     := Byte (X (I) mod 256);
 7d6:	11812e83          	lw	t4,280(sp)
 7da:	12012e03          	lw	t3,288(sp)
 7de:	12812303          	lw	t1,296(sp)
 7e2:	13012883          	lw	a7,304(sp)
 7e6:	13812803          	lw	a6,312(sp)
 7ea:	14012503          	lw	a0,320(sp)
 7ee:	14812583          	lw	a1,328(sp)
 7f2:	11012f03          	lw	t5,272(sp)
            Result (2 * I + 1) := Byte (X (I) / 256);
 7f6:	84fd                	srai	s1,s1,0x1f
 7f8:	41f3d393          	srai	t2,t2,0x1f
 7fc:	41f2d293          	srai	t0,t0,0x1f
 800:	41ffdf93          	srai	t6,t6,0x1f
 804:	867d                	srai	a2,a2,0x1f
 806:	86fd                	srai	a3,a3,0x1f
 808:	877d                	srai	a4,a4,0x1f
 80a:	87fd                	srai	a5,a5,0x1f
 80c:	0ff4f493          	andi	s1,s1,255
 810:	0ff3f393          	andi	t2,t2,255
 814:	0ff2f293          	andi	t0,t0,255
 818:	0fffff93          	andi	t6,t6,255
 81c:	0ff67613          	andi	a2,a2,255
 820:	0ff6f693          	andi	a3,a3,255
 824:	0ff77713          	andi	a4,a4,255
 828:	0ff7f793          	andi	a5,a5,255
 82c:	94fa                	add	s1,s1,t5
 82e:	93f6                	add	t2,t2,t4
 830:	92f2                	add	t0,t0,t3
 832:	9f9a                	add	t6,t6,t1
 834:	9646                	add	a2,a2,a7
 836:	96c2                	add	a3,a3,a6
 838:	972a                	add	a4,a4,a0
 83a:	97ae                	add	a5,a5,a1
 83c:	80a1                	srli	s1,s1,0x8
 83e:	0083d393          	srli	t2,t2,0x8
 842:	0082d293          	srli	t0,t0,0x8
 846:	008fdf93          	srli	t6,t6,0x8
 84a:	8221                	srli	a2,a2,0x8
 84c:	82a1                	srli	a3,a3,0x8
 84e:	8321                	srli	a4,a4,0x8
 850:	83a1                	srli	a5,a5,0x8
 852:	009400a3          	sb	s1,1(s0)

00000856 <.LVL154>:
            Result (2 * I)     := Byte (X (I) mod 256);
 856:	01d40123          	sb	t4,2(s0)
            Result (2 * I + 1) := Byte (X (I) / 256);
 85a:	007401a3          	sb	t2,3(s0)

0000085e <.LVL155>:
            Result (2 * I)     := Byte (X (I) mod 256);
 85e:	01c40223          	sb	t3,4(s0)
            Result (2 * I + 1) := Byte (X (I) / 256);
 862:	005402a3          	sb	t0,5(s0)

00000866 <.LVL156>:
            Result (2 * I)     := Byte (X (I) mod 256);
 866:	00640323          	sb	t1,6(s0)
            Result (2 * I + 1) := Byte (X (I) / 256);
 86a:	01f403a3          	sb	t6,7(s0)

0000086e <.LVL157>:
            Result (2 * I)     := Byte (X (I) mod 256);
 86e:	01140423          	sb	a7,8(s0)
            Result (2 * I + 1) := Byte (X (I) / 256);
 872:	00c404a3          	sb	a2,9(s0)

00000876 <.LVL158>:
            Result (2 * I)     := Byte (X (I) mod 256);
 876:	01040523          	sb	a6,10(s0)
            Result (2 * I + 1) := Byte (X (I) / 256);
 87a:	00d405a3          	sb	a3,11(s0)

0000087e <.LVL159>:
            Result (2 * I)     := Byte (X (I) mod 256);
 87e:	00a40623          	sb	a0,12(s0)
            Result (2 * I + 1) := Byte (X (I) / 256);
 882:	00e406a3          	sb	a4,13(s0)

00000886 <.LVL160>:
            Result (2 * I)     := Byte (X (I) mod 256);
 886:	00b40723          	sb	a1,14(s0)
            Result (2 * I + 1) := Byte (X (I) / 256);
 88a:	00f407a3          	sb	a5,15(s0)

0000088e <.LVL161>:
            Result (2 * I)     := Byte (X (I) mod 256);
 88e:	01e40023          	sb	t5,0(s0)
 892:	15012f03          	lw	t5,336(sp)
            Result (2 * I + 1) := Byte (X (I) / 256);
 896:	15412483          	lw	s1,340(sp)
 89a:	15c12383          	lw	t2,348(sp)
 89e:	16412283          	lw	t0,356(sp)
 8a2:	16c12f83          	lw	t6,364(sp)
 8a6:	17412603          	lw	a2,372(sp)
 8aa:	17c12683          	lw	a3,380(sp)
 8ae:	18412703          	lw	a4,388(sp)
 8b2:	18c12783          	lw	a5,396(sp)
            Result (2 * I)     := Byte (X (I) mod 256);
 8b6:	18012503          	lw	a0,384(sp)
 8ba:	15812e83          	lw	t4,344(sp)
 8be:	16012e03          	lw	t3,352(sp)
 8c2:	16812303          	lw	t1,360(sp)
 8c6:	17012883          	lw	a7,368(sp)
 8ca:	17812803          	lw	a6,376(sp)
 8ce:	18812583          	lw	a1,392(sp)
            Result (2 * I + 1) := Byte (X (I) / 256);
 8d2:	84fd                	srai	s1,s1,0x1f
 8d4:	41f3d393          	srai	t2,t2,0x1f
 8d8:	41f2d293          	srai	t0,t0,0x1f
 8dc:	41ffdf93          	srai	t6,t6,0x1f
 8e0:	867d                	srai	a2,a2,0x1f
 8e2:	86fd                	srai	a3,a3,0x1f
 8e4:	877d                	srai	a4,a4,0x1f
 8e6:	87fd                	srai	a5,a5,0x1f
 8e8:	0ff4f493          	andi	s1,s1,255
 8ec:	0ff3f393          	andi	t2,t2,255
 8f0:	0ff2f293          	andi	t0,t0,255
 8f4:	0fffff93          	andi	t6,t6,255
 8f8:	0ff67613          	andi	a2,a2,255
 8fc:	0ff6f693          	andi	a3,a3,255
 900:	0ff77713          	andi	a4,a4,255
 904:	0ff7f793          	andi	a5,a5,255
 908:	972a                	add	a4,a4,a0
 90a:	94fa                	add	s1,s1,t5
 90c:	93f6                	add	t2,t2,t4
 90e:	92f2                	add	t0,t0,t3
 910:	9f9a                	add	t6,t6,t1
 912:	9646                	add	a2,a2,a7
 914:	96c2                	add	a3,a3,a6
 916:	97ae                	add	a5,a5,a1
 918:	80a1                	srli	s1,s1,0x8
 91a:	0083d393          	srli	t2,t2,0x8
 91e:	0082d293          	srli	t0,t0,0x8
 922:	008fdf93          	srli	t6,t6,0x8
 926:	8221                	srli	a2,a2,0x8
 928:	82a1                	srli	a3,a3,0x8
 92a:	8321                	srli	a4,a4,0x8
 92c:	83a1                	srli	a5,a5,0x8
 92e:	009408a3          	sb	s1,17(s0)

00000932 <.LVL162>:
            Result (2 * I)     := Byte (X (I) mod 256);
 932:	00a40e23          	sb	a0,28(s0)
 936:	01e40823          	sb	t5,16(s0)
 93a:	01d40923          	sb	t4,18(s0)
            Result (2 * I + 1) := Byte (X (I) / 256);
 93e:	007409a3          	sb	t2,19(s0)

00000942 <.LVL163>:
            Result (2 * I)     := Byte (X (I) mod 256);
 942:	01c40a23          	sb	t3,20(s0)
            Result (2 * I + 1) := Byte (X (I) / 256);
 946:	00540aa3          	sb	t0,21(s0)

0000094a <.LVL164>:
            Result (2 * I)     := Byte (X (I) mod 256);
 94a:	00640b23          	sb	t1,22(s0)
            Result (2 * I + 1) := Byte (X (I) / 256);
 94e:	01f40ba3          	sb	t6,23(s0)

00000952 <.LVL165>:
            Result (2 * I)     := Byte (X (I) mod 256);
 952:	01140c23          	sb	a7,24(s0)
            Result (2 * I + 1) := Byte (X (I) / 256);
 956:	00c40ca3          	sb	a2,25(s0)

0000095a <.LVL166>:
            Result (2 * I)     := Byte (X (I) mod 256);
 95a:	01040d23          	sb	a6,26(s0)
            Result (2 * I + 1) := Byte (X (I) / 256);
 95e:	00d40da3          	sb	a3,27(s0)

00000962 <.LVL167>:
 962:	00e40ea3          	sb	a4,29(s0)

00000966 <.LVL168>:
            Result (2 * I)     := Byte (X (I) mod 256);
 966:	00b40f23          	sb	a1,30(s0)
            Result (2 * I + 1) := Byte (X (I) / 256);
 96a:	00f40fa3          	sb	a5,31(s0)

0000096e <.LBE82>:

      pragma Unreferenced (R1);
      pragma Unreferenced (L);
      pragma Unreferenced (First_Underflow);
      pragma Unreferenced (Second_Underflow);
   end Pack_25519;
 96e:	8522                	mv	a0,s0
 970:	1cc12083          	lw	ra,460(sp)
 974:	1c812403          	lw	s0,456(sp)
 978:	1c412483          	lw	s1,452(sp)
 97c:	1c012903          	lw	s2,448(sp)
 980:	1bc12983          	lw	s3,444(sp)
 984:	1b812a03          	lw	s4,440(sp)
 988:	1b412a83          	lw	s5,436(sp)
 98c:	1b012b03          	lw	s6,432(sp)
 990:	1ac12b83          	lw	s7,428(sp)
 994:	1a812c03          	lw	s8,424(sp)
 998:	1a412c83          	lw	s9,420(sp)
 99c:	1a012d03          	lw	s10,416(sp)
 9a0:	19c12d83          	lw	s11,412(sp)
 9a4:	6179                	addi	sp,sp,464
 9a6:	8082                	ret

Disassembly of section .text.sparknacl__utils__unpack_25519:

00000000 <sparknacl__utils__unpack_25519>:

   function Unpack_25519 (N : in Bytes_32) return Normal_GF
   0:	1141                	addi	sp,sp,-16

00000002 <.LBB85>:
   is
      O : GF with Relaxed_Initialization;
   begin
      begin
         for I in Index_16 loop
            O (I) := I64 (N (2 * I)) + (I64 (N (2 * I + 1)) * 256);
   2:	0015ce83          	lbu	t4,1(a1)
   6:	0035ce03          	lbu	t3,3(a1)
   a:	0055c303          	lbu	t1,5(a1)
   e:	0075c883          	lbu	a7,7(a1)
  12:	0095c803          	lbu	a6,9(a1)
  16:	00b5c603          	lbu	a2,11(a1)

0000001a <.LBE85>:
   function Unpack_25519 (N : in Bytes_32) return Normal_GF
  1a:	c622                	sw	s0,12(sp)
  1c:	c426                	sw	s1,8(sp)
  1e:	c24a                	sw	s2,4(sp)
  20:	c04e                	sw	s3,0(sp)

00000022 <.LBB86>:
            O (I) := I64 (N (2 * I)) + (I64 (N (2 * I + 1)) * 256);
  22:	0025c903          	lbu	s2,2(a1)
  26:	0005c983          	lbu	s3,0(a1)
  2a:	0045c483          	lbu	s1,4(a1)
  2e:	0065c403          	lbu	s0,6(a1)
  32:	0085c383          	lbu	t2,8(a1)
  36:	00a5c283          	lbu	t0,10(a1)
  3a:	00d5c683          	lbu	a3,13(a1)
  3e:	00f5c703          	lbu	a4,15(a1)
  42:	00c5cf83          	lbu	t6,12(a1)
  46:	0ea2                	slli	t4,t4,0x8
  48:	0e22                	slli	t3,t3,0x8
  4a:	0322                	slli	t1,t1,0x8
  4c:	08a2                	slli	a7,a7,0x8
  4e:	0822                	slli	a6,a6,0x8
  50:	0622                	slli	a2,a2,0x8
  52:	00e5cf03          	lbu	t5,14(a1)
  56:	99f6                	add	s3,s3,t4
  58:	9972                	add	s2,s2,t3
  5a:	949a                	add	s1,s1,t1
  5c:	9446                	add	s0,s0,a7
  5e:	93c2                	add	t2,t2,a6
  60:	92b2                	add	t0,t0,a2
  62:	01d9beb3          	sltu	t4,s3,t4
  66:	01c93e33          	sltu	t3,s2,t3
  6a:	0064b333          	sltu	t1,s1,t1
  6e:	011438b3          	sltu	a7,s0,a7
  72:	0103b833          	sltu	a6,t2,a6
  76:	00c2b633          	sltu	a2,t0,a2
  7a:	06a2                	slli	a3,a3,0x8
  7c:	9fb6                	add	t6,t6,a3
  7e:	0722                	slli	a4,a4,0x8
  80:	01352023          	sw	s3,0(a0)
  84:	01d52223          	sw	t4,4(a0)

00000088 <.LVL172>:
  88:	01252423          	sw	s2,8(a0)
  8c:	01c52623          	sw	t3,12(a0)

00000090 <.LVL173>:
  90:	c904                	sw	s1,16(a0)
  92:	00652a23          	sw	t1,20(a0)

00000096 <.LVL174>:
  96:	cd00                	sw	s0,24(a0)
  98:	01152e23          	sw	a7,28(a0)

0000009c <.LVL175>:
  9c:	02752023          	sw	t2,32(a0)
  a0:	03052223          	sw	a6,36(a0)

000000a4 <.LVL176>:
  a4:	02552423          	sw	t0,40(a0)
  a8:	d550                	sw	a2,44(a0)

000000aa <.LVL177>:
  aa:	03f52823          	sw	t6,48(a0)
  ae:	9f3a                	add	t5,t5,a4
  b0:	0115ce03          	lbu	t3,17(a1)
  b4:	0135c303          	lbu	t1,19(a1)
  b8:	0155c883          	lbu	a7,21(a1)
  bc:	0175c803          	lbu	a6,23(a1)
  c0:	0195c983          	lbu	s3,25(a1)
  c4:	01b5c603          	lbu	a2,27(a1)
  c8:	00dfb6b3          	sltu	a3,t6,a3
  cc:	0105c483          	lbu	s1,16(a1)
  d0:	0125c403          	lbu	s0,18(a1)
  d4:	0145c383          	lbu	t2,20(a1)
  d8:	0165c283          	lbu	t0,22(a1)
  dc:	0185cf83          	lbu	t6,24(a1)
  e0:	00ef3733          	sltu	a4,t5,a4
  e4:	d954                	sw	a3,52(a0)

000000e6 <.LVL178>:
  e6:	03e52c23          	sw	t5,56(a0)
  ea:	01d5c683          	lbu	a3,29(a1)
  ee:	01a5cf03          	lbu	t5,26(a1)
  f2:	01c5ce83          	lbu	t4,28(a1)
  f6:	dd58                	sw	a4,60(a0)

000000f8 <.LVL179>:
  f8:	01f5c703          	lbu	a4,31(a1)
  fc:	01e5c903          	lbu	s2,30(a1)
 100:	0e22                	slli	t3,t3,0x8
 102:	00899593          	slli	a1,s3,0x8

00000106 <.LVL180>:
 106:	0322                	slli	t1,t1,0x8
 108:	08a2                	slli	a7,a7,0x8
 10a:	0822                	slli	a6,a6,0x8
 10c:	0622                	slli	a2,a2,0x8
 10e:	94f2                	add	s1,s1,t3
 110:	941a                	add	s0,s0,t1
 112:	06a2                	slli	a3,a3,0x8
 114:	93c6                	add	t2,t2,a7
 116:	92c2                	add	t0,t0,a6
 118:	9fae                	add	t6,t6,a1
 11a:	9f32                	add	t5,t5,a2
 11c:	9eb6                	add	t4,t4,a3
 11e:	01c4be33          	sltu	t3,s1,t3
 122:	00643333          	sltu	t1,s0,t1
 126:	0722                	slli	a4,a4,0x8
 128:	0113b8b3          	sltu	a7,t2,a7
 12c:	0102b833          	sltu	a6,t0,a6
 130:	00bfb5b3          	sltu	a1,t6,a1
 134:	00cf3633          	sltu	a2,t5,a2
 138:	974a                	add	a4,a4,s2
 13a:	c124                	sw	s1,64(a0)
 13c:	c520                	sw	s0,72(a0)
 13e:	00deb6b3          	sltu	a3,t4,a3
 142:	05c52223          	sw	t3,68(a0)

00000146 <.LVL181>:
 146:	04652623          	sw	t1,76(a0)

0000014a <.LVL182>:
 14a:	04752823          	sw	t2,80(a0)
 14e:	05152a23          	sw	a7,84(a0)

00000152 <.LVL183>:
 152:	04552c23          	sw	t0,88(a0)
 156:	05052e23          	sw	a6,92(a0)

0000015a <.LVL184>:
 15a:	07f52023          	sw	t6,96(a0)
 15e:	d16c                	sw	a1,100(a0)

00000160 <.LVL185>:
 160:	07e52423          	sw	t5,104(a0)
 164:	d570                	sw	a2,108(a0)

00000166 <.LVL186>:
 166:	07d52823          	sw	t4,112(a0)
 16a:	d974                	sw	a3,116(a0)

0000016c <.LBE86>:
            pragma Loop_Invariant
              (for all J in Index_16 range 0 .. I =>
                 O (J)'Initialized and then O (J) in GF_Normal_Limb);
         end loop;
         O (15) := O (15) mod 32768;
 16c:	0746                	slli	a4,a4,0x11
      end;
      return Normal_GF (O);
   end Unpack_25519;
 16e:	4432                	lw	s0,12(sp)
         O (15) := O (15) mod 32768;
 170:	8345                	srli	a4,a4,0x11
 172:	dd38                	sw	a4,120(a0)
 174:	06052e23          	sw	zero,124(a0)
   end Unpack_25519;
 178:	44a2                	lw	s1,8(sp)
 17a:	4912                	lw	s2,4(sp)
 17c:	4982                	lw	s3,0(sp)
 17e:	0141                	addi	sp,sp,16
 180:	8082                	ret

Disassembly of section .text.sparknacl__utils__inv_25519:

00000000 <sparknacl__utils__inv_25519>:

   function Inv_25519 (I : in Normal_GF) return Normal_GF
   0:	7125                	addi	sp,sp,-416
   2:	18812c23          	sw	s0,408(sp)
   is
      C : Normal_GF;
   begin
      C := I;
   6:	0100                	addi	s0,sp,128
   function Inv_25519 (I : in Normal_GF) return Normal_GF
   8:	19512223          	sw	s5,388(sp)
   c:	19612023          	sw	s6,384(sp)
  10:	18112e23          	sw	ra,412(sp)
  14:	18912a23          	sw	s1,404(sp)
  18:	19212823          	sw	s2,400(sp)
  1c:	19312623          	sw	s3,396(sp)
  20:	19412423          	sw	s4,392(sp)
  24:	8b2e                	mv	s6,a1
  26:	8aaa                	mv	s5,a0
      C := I;
  28:	87ae                	mv	a5,a1
  2a:	8722                	mv	a4,s0
  2c:	08058813          	addi	a6,a1,128

00000030 <.L16>:
  30:	4388                	lw	a0,0(a5)
  32:	43cc                	lw	a1,4(a5)
  34:	4790                	lw	a2,8(a5)
  36:	47d4                	lw	a3,12(a5)
  38:	c308                	sw	a0,0(a4)
  3a:	c34c                	sw	a1,4(a4)
  3c:	c710                	sw	a2,8(a4)
  3e:	c754                	sw	a3,12(a4)
  40:	07c1                	addi	a5,a5,16
  42:	0741                	addi	a4,a4,16
  44:	ff0796e3          	bne	a5,a6,30 <.L16>

00000048 <.LVL190>:
  48:	0fb00493          	li	s1,251
  4c:	10010913          	addi	s2,sp,256
  50:	18010a13          	addi	s4,sp,384
  54:	59f5                	li	s3,-3

00000056 <.L20>:

   function "*" (Left, Right : in Normal_GF) return Normal_GF
     with Global => null;

   function Square (A : in Normal_GF) return Normal_GF
     is (A * A)
  56:	8622                	mv	a2,s0
  58:	85a2                	mv	a1,s0
  5a:	854a                	mv	a0,s2
  5c:	00000097          	auipc	ra,0x0
  60:	000080e7          	jalr	ra # 5c <.L20+0x6>

00000064 <.LBE88>:

      for A in reverse 0 .. 253 loop
         C := Square (C);
  64:	87ca                	mv	a5,s2
  66:	8722                	mv	a4,s0

00000068 <.L17>:
  68:	4388                	lw	a0,0(a5)
  6a:	43cc                	lw	a1,4(a5)
  6c:	4790                	lw	a2,8(a5)
  6e:	47d4                	lw	a3,12(a5)
  70:	c308                	sw	a0,0(a4)
  72:	c34c                	sw	a1,4(a4)
  74:	c710                	sw	a2,8(a4)
  76:	c754                	sw	a3,12(a4)
  78:	07c1                	addi	a5,a5,16
  7a:	0741                	addi	a4,a4,16
  7c:	ff4796e3          	bne	a5,s4,68 <.L17>
         if (A /= 2 and A /= 4) then
  80:	ffd4f793          	andi	a5,s1,-3
  84:	e7a1                	bnez	a5,cc <.L31>

00000086 <.L18>:
      for A in reverse 0 .. 253 loop
  86:	14fd                	addi	s1,s1,-1
  88:	fd3497e3          	bne	s1,s3,56 <.L20>

0000008c <.LBE87>:
            C := C * I;
         end if;
      end loop;

      return C;
  8c:	87d6                	mv	a5,s5

0000008e <.L21>:
  8e:	400c                	lw	a1,0(s0)
  90:	4050                	lw	a2,4(s0)
  92:	4414                	lw	a3,8(s0)
  94:	4458                	lw	a4,12(s0)
  96:	c38c                	sw	a1,0(a5)
  98:	c3d0                	sw	a2,4(a5)
  9a:	c794                	sw	a3,8(a5)
  9c:	c7d8                	sw	a4,12(a5)
  9e:	0441                	addi	s0,s0,16
  a0:	07c1                	addi	a5,a5,16
  a2:	ff2416e3          	bne	s0,s2,8e <.L21>
   end Inv_25519;
  a6:	19c12083          	lw	ra,412(sp)
  aa:	19812403          	lw	s0,408(sp)
  ae:	19412483          	lw	s1,404(sp)
  b2:	19012903          	lw	s2,400(sp)
  b6:	18c12983          	lw	s3,396(sp)
  ba:	18812a03          	lw	s4,392(sp)
  be:	18012b03          	lw	s6,384(sp)

000000c2 <.LVL194>:
  c2:	8556                	mv	a0,s5
  c4:	18412a83          	lw	s5,388(sp)
  c8:	611d                	addi	sp,sp,416
  ca:	8082                	ret

000000cc <.L31>:
            C := C * I;
  cc:	865a                	mv	a2,s6
  ce:	85a2                	mv	a1,s0
  d0:	850a                	mv	a0,sp
  d2:	00000097          	auipc	ra,0x0
  d6:	000080e7          	jalr	ra # d2 <.L31+0x6>

000000da <.LVL197>:
  da:	878a                	mv	a5,sp
  dc:	8722                	mv	a4,s0

000000de <.L19>:
  de:	4388                	lw	a0,0(a5)
  e0:	43cc                	lw	a1,4(a5)
  e2:	4790                	lw	a2,8(a5)
  e4:	47d4                	lw	a3,12(a5)
  e6:	c308                	sw	a0,0(a4)
  e8:	c34c                	sw	a1,4(a4)
  ea:	c710                	sw	a2,8(a4)
  ec:	c754                	sw	a3,12(a4)
  ee:	07c1                	addi	a5,a5,16
  f0:	0741                	addi	a4,a4,16
  f2:	fe8796e3          	bne	a5,s0,de <.L19>
  f6:	bf41                	j	86 <.L18>

Disassembly of section .text.sparknacl__utils__random_bytes_32:

00000000 <sparknacl__utils__random_bytes_32>:

   function Random_Bytes_32 return Bytes_32
   0:	1141                	addi	sp,sp,-16
   2:	c422                	sw	s0,8(sp)
   4:	c226                	sw	s1,4(sp)
   6:	c04a                	sw	s2,0(sp)
   8:	c606                	sw	ra,12(sp)
   a:	892a                	mv	s2,a0
   c:	842a                	mv	s0,a0
   e:	02050493          	addi	s1,a0,32

00000012 <.L33>:
   is
      Result : Bytes_32;
   begin
      for I in Result'Range loop
         Result (I) := Random.Random_Byte;
  12:	00000097          	auipc	ra,0x0
  16:	000080e7          	jalr	ra # 12 <.L33>

0000001a <.LVL200>:
  1a:	00a40023          	sb	a0,0(s0)
      for I in Result'Range loop
  1e:	0405                	addi	s0,s0,1

00000020 <.LVL201>:
  20:	fe9419e3          	bne	s0,s1,12 <.L33>

00000024 <.LBE91>:
      end loop;
      return Result;
   end Random_Bytes_32;
  24:	40b2                	lw	ra,12(sp)
  26:	4422                	lw	s0,8(sp)

00000028 <.LVL202>:
  28:	4492                	lw	s1,4(sp)
  2a:	854a                	mv	a0,s2
  2c:	4902                	lw	s2,0(sp)

0000002e <.LVL203>:
  2e:	0141                	addi	sp,sp,16
  30:	8082                	ret
