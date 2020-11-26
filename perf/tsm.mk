all: tsm.hex tsm.asm

tsm: tsm.adb io.adb io.ads tweetnacl_api.ads tweetnacl.c
	gprbuild -Ptsm -v -XSPARKNACL_RUNTIME_MODE=zfp -XSPARKNACL_RUNTIME_CHECKS=disabled -XSPARKNACL_CONTRACTS=disabled
	@mv main.map tsm.map
	@grep "^.data" tsm.map
	@grep "^.bss" tsm.map
	@grep "__stack_start =" tsm.map
	@grep "__stack_end =" tsm.map
	@grep "__bss_start =" tsm.map
	@grep "__bss_end =" tsm.map

tsm.hex: tsm
	riscv32-elf-objcopy -O ihex tsm tsm.hex

tsm.asm: tsm
	riscv32-elf-objdump -S tsm >tsm.asm

stack: tsm
	gnatstack -Ptsm

run: tsm.hex
	cp tsm.hex /media/rchapman/HiFive

clean:
	rm -f tsm.hex
	rm -f tsm.map
	rm -f d.ci
	rm -f devurandom.ci
	rm -f graph.vcg
	rm -f tweetnacl.ci
	rm -f undefined.ciu
	gprclean -Ptsm
