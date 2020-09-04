all: main.hex

main: main.adb io.adb io.ads tweetnacl_api.ads tweetnacl.c
	gprbuild -Pperf
	@grep "^.data" main.map
	@grep "^.bss" main.map
	@grep "__stack_start =" main.map
	@grep "__stack_end =" main.map
	@grep "__bss_start =" main.map
	@grep "__bss_end =" main.map

main.hex: main
	riscv32-elf-objcopy -O ihex main main.hex

stack: main
	gnatstack -Pperf

run: main.hex
	cp main.hex /media/rchapman/HiFive

clean:
	rm -f main.hex
	rm -f main.map
	rm -f d.ci
	rm -f devurandom.ci
	rm -f graph.vcg
	rm -f tweetnacl.ci
	rm -f undefined.ciu
	gprclean -Pperf
