all: fntr sntr ftestdiff stestdiff

ftestdiff: expected_test_results fntr
	diff $^

stestdiff: expected_test_results sntr
	diff $^

fntr: ftestall
	./ftestall > $@

sntr: stestall
	./stestall > $@

ftestall: src/ada/*.adb ../src/*.adb ../src/*.ads
	$(MAKE) clean_build
	$(MAKE) clean_ftest
	gprbuild -Ptestall -j4 \
		      -XSPARKNACL_RUNTIME_CHECKS=disabled \
				-XSPARKNACL_CONTRACTS=disabled \
				-XSPARKNACL_BUILD_MODE=O3
	mv obj/testall $@

stestall: src/ada/*.adb ../src/*.adb ../src/*.ads
	$(MAKE) clean_build
	$(MAKE) clean_stest
	gprbuild -Ptestall -j4 \
		      -XSPARKNACL_RUNTIME_CHECKS=enabled \
				-XSPARKNACL_CONTRACTS=enabled \
				-XSPARKNACL_BUILD_MODE=debug
	mv obj/testall $@

scalarspeed: src/ada/scalarspeed.adb ../src/*.adb ../src/*.ads
	$(MAKE) clean_build
	$(MAKE) clean_scalar_build
	gprbuild -Pscalarspeed -j4 \
		      -XSPARKNACL_RUNTIME_CHECKS=disabled \
	         -XSPARKNACL_CONTRACTS=disabled \
				-XSPARKNACL_BUILD_MODE=O3
	mv obj/$@ $@

.PHONY: all clean_build clean_stest clean_ftest clean_scalarspeed clean
clean_build:
	gprclean -r -Ptestall
	gprclean -r -Pscalarspeed
clean_stest:
	rm -f sntr stestall
clean_ftest:
	rm -f fntr ftestall
clean_scalarspeed:
	rm -f scalarspeed
clean:
	$(MAKE) clean_build
	$(MAKE) clean_stest
	$(MAKE) clean_ftest
	$(MAKE) clean_scalarspeed
