all: tsign.hex tsign.asm

SIZE_OBJS := ../obj/sparknacl.o ../obj/sparknacl-car.o ../obj/sparknacl-core.o ../obj/sparknacl-cryptobox.o ../obj/sparknacl-hashing.o ../obj/sparknacl-mac.o ../obj/sparknacl-scalar.o ../obj/sparknacl-secretbox.o ../obj/sparknacl-sign.o ../obj/sparknacl-sign-utils.o ../obj/sparknacl-stream.o ../obj/sparknacl-utils.o

tsign: tsign.adb io.adb io.ads tweetnacl_api.ads tweetnacl.c
	gprbuild -Ptsign -v -XSPARKNACL_RUNTIME_MODE=zfp -XSPARKNACL_RUNTIME_CHECKS=disabled -XSPARKNACL_CONTRACTS=disabled  -XSPARKNACL_TARGET_ARCH=rv32imc_a4 -XSPARKNACL_BUILD_MODE=debug
	@mv main.map tsign.map
	@grep "^.data" tsign.map
	@grep "^.bss" tsign.map
	@grep "__stack_start =" tsign.map
	@grep "__stack_end =" tsign.map
	@grep "__bss_start =" tsign.map
	@grep "__bss_end =" tsign.map

tsign.hex: tsign
	riscv32-elf-objcopy -O ihex tsign tsign.hex

tsign.asm: tsign
	riscv32-elf-objdump -S tsign >tsign.asm

stack: tsign
	gnatstack -Ptsign -p -v -XSPARKNACL_RUNTIME_MODE=zfp -XSPARKNACL_RUNTIME_CHECKS=disabled -XSPARKNACL_CONTRACTS=disabled -XSPARKNACL_TARGET_ARCH=rv32im -XSPARKNACL_BUILD_MODE=debug -esparknacl.sign.sign

size:	tsign
	riscv32-elf-strip $(SIZE_OBJS)
	riscv32-elf-size -t $(SIZE_OBJS)

run: tsign.hex
	cp tsign.hex /media/rchapman/HiFive

clean:
	rm -f tsign.hex
	rm -f tsign.map
	rm -f d.ci
	rm -f devurandom.ci
	rm -f graph.vcg
	rm -f tweetnacl.ci
	rm -f undefined.ciu
	gprclean -Ptsign -r
