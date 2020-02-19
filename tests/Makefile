all: fntr sntr ftestdiff stestdiff

ftestdiff: fntr
	diff expected_test_results fntr

ctestdiff: cntr
	diff expected_test_results cntr

stestdiff: sntr
	diff expected_test_results sntr

fntr: ftestall
	./ftestall >fntr

sntr: stestall
	./stestall >sntr

cntr: ctestall
	./ctestall >cntr

ftestall: *.adb ../src/*.adb ../src/*.ads
	gprclean -r -Ptestall
	rm -f fntr
	rm -f ftestall
	gprbuild -Ptestall -Xbuild=fast
	mv testall ftestall

stestall: *.adb ../src/*.adb ../src/*.ads
	gprclean -r -Ptestall
	rm -f sntr
	rm -f stestall
	gprbuild -Ptestall -Xbuild=debug
	mv testall stestall

ctestall: *.adb ../src/*.adb ../src/*.ads
	gprclean -r -Ptestall
	rm -f cntr
	rm -f ctestall
	gprbuild -Ptestall -Xbuild=cover
	mv testall ctestall

clean:
	gprclean -r -Ptestall
	rm -f ftestall
	rm -f stestall
	rm -f ctestall
	rm -f fntr
	rm -f sntr
	rm -f cntr
