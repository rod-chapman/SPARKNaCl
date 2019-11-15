all: testdiff

testdiff: new_test_results
	diff expected_test_results new_test_results

new_test_results: testall
	./testall >new_test_results

testall: *.adb ../src/*.adb ../src/*.ads
	gprbuild

clean:
	gprclean -r
	rm -f new_test_results
