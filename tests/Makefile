all: fntr sntr ftestdiff stestdiff

fall: fntr ftestdiff

ftestdiff: fntr
	diff expected_test_results fntr

stestdiff: sntr
	diff expected_test_results sntr

fntr: ftestall
	./ftestall >fntr

sntr: stestall
	./stestall >sntr

ftestall: *.adb ../src/*.adb ../src/*.ads
	gprclean -r -Ptestall
	rm -f fntr
	rm -f ftestall
	gprbuild -Ptestall -XSPARKNACL_RUNTIME_CHECKS=disabled -XSPARKNACL_CONTRACTS=disabled -XSPARKNACL_BUILD_MODE=O3
	mv testall ftestall

stestall: *.adb ../src/*.adb ../src/*.ads
	gprclean -r -Ptestall
	rm -f sntr
	rm -f stestall
	gprbuild -Ptestall -XSPARKNACL_RUNTIME_CHECKS=enabled -XSPARKNACL_CONTRACTS=enabled -XSPARKNACL_BUILD_MODE=debug
	mv testall stestall

clean:
	gprclean -r -Ptestall
	rm -f ftestall
	rm -f stestall
	rm -f fntr
	rm -f sntr
