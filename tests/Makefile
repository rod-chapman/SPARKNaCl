all: fntr sntr ftestdiff stestdiff

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
	gprbuild -Ptestall -Xbuild=fast
	mv testall ftestall

stestall: *.adb ../src/*.adb ../src/*.ads
	gprclean -r -Ptestall
	rm -f sntr
	rm -f stestall
	gprbuild -Ptestall -Xbuild=debug
	mv testall stestall

clean:
	gprclean -r -Ptestall
	rm -f ftestall
	rm -f stestall
	rm -f fntr
	rm -f sntr
