all: testdiff

testdiff: new
	diff ref new

new: testall
	./testall >new

testall: *.adb ../src/*.adb
	gprbuild

clean:
	gprclean -r
