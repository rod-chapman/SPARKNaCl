all: tcore.hex tcore.asm

tcore: tcore.adb io.adb io.ads tweetnacl_api.ads tweetnacl.c
	gprbuild -Ptcore -v -XSPARKNACL_RUNTIME_MODE=zfp -XSPARKNACL_RUNTIME_CHECKS=disabled -XSPARKNACL_CONTRACTS=disabled
	@mv main.map tcore.map
	@grep "^.data" tcore.map
	@grep "^.bss" tcore.map
	@grep "__stack_start =" tcore.map
	@grep "__stack_end =" tcore.map
	@grep "__bss_start =" tcore.map
	@grep "__bss_end =" tcore.map

tcore.hex: tcore
	riscv32-elf-objcopy -O ihex tcore tcore.hex

tcore.asm: tcore
	riscv32-elf-objdump -S tcore >tcore.asm

stack: tcore
	gnatstack -Ptcore

run: tcore.hex
	cp tcore.hex /media/rchapman/HiFive

clean:
	rm -f tcore.hex
	rm -f tcore.map
	rm -f d.ci
	rm -f devurandom.ci
	rm -f graph.vcg
	rm -f tweetnacl.ci
	rm -f undefined.ciu
	gprclean -Ptcore
