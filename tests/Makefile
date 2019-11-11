all: testdiff

testdiff: new
	diff ref new

new: testall
	./testall >new

testall: *.adb ../src/*.adb ../src/*.ads
	gprbuild

clean:
	gprclean -r
	rm -f new
