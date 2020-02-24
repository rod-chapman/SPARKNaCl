# SPARKNaCl

SPARK 2014 re-implementation of the [TweetNaCl](https://tweetnacl.cr.yp.to) crypto library.

This library is a compact reference implementation of the NaCl crypto library. It was originally inspired by the TweetNaCl implementation, but offers a completely automated static proof of type-safety (and some correctness properties), reasonable performance, and (unlike TweetNaCl) is readable owing to the large number of explanatory comments and contracts in the code.

## Contents

[Why Bother?](https://github.com/rod-chapman/SPARKNaCl#why-bother)

[Goals](https://github.com/rod-chapman/SPARKNaCl#goals)

[Challenges](https://github.com/rod-chapman/SPARKNaCl#challenges)

[Current state of the release](https://github.com/rod-chapman/SPARKNaCl#current-state-of-the-release)

[Tools](https://github.com/rod-chapman/SPARKNaCl#tools)

[Reproducing results](https://github.com/rod-chapman/SPARKNaCl#reproducing-results)

[Known weaknesses and TBD items](https://github.com/rod-chapman/SPARKNaCl#known-weaknesses-and-tbd-items)

[Acknowledgements](https://github.com/rod-chapman/SPARKNaCl#acknowledgements)

## Why Bother?

Given that there are several highly-respected implementations of NaCl out there, including the designers' own reference implementation, it is perhaps not entirely obvious that the world needs another one.

I first encountered TweetNaCl with some fascination - a fully-fledged modern crypto library in so little code! That got me wondering if SPARK 2014 could even manage to express such code, and how the SPARK verification tools would cope. TweetNaCl sets some serious challenges (see below), so it started out as a bit of fun to see if any or all of it could be re-implemented in SPARK.

## Goals

SPARKNaCl started out with the simple goal of seeing if a re-implementation of TweetNaCl was even possible in SPARK. We have some form in this area, though, having [re-implemented Skein in SPARK](http://www.skein-hash.info/SPARKSkein-release) some time ago, and (more recently) produced a high-assurance implementation of [RFC 4108](https://datatracker.ietf.org/doc/rfc4108/) for a commercial client.

As the project progressed, though, the goals became a little more ambitious:

* SPARKNaCl implements the same API and functionality as TweetNaCl.
* SPARKNaCl passes the NaCl test suite, producing identical results.
* SPARKNaCl retains "time-constant" algorithms throughout.
* The entire library has an "auto-active" proof of (at least) type safety. No external user-guided or interactive proof tools (such as Coq) are used. Everything needed to reproduce the proofs are in the code and the contracts.
* The code is compatible with the GNAT "Zero Footprint" runtime library. This means the code relies on *no* runtime library at all, so it will run on anything from tiny bare-metal targets up to server-class CPUs, on any operating system.
* Performance of the code should be competitive with the C implementation of TweetNaCl.
* Code size should be competitive with the C implementation of TweetNaCl.

## Challenges

A modern crypto library like TweetNaCl sets some serious challenges for verification tools and languages like SPARK. In particular:

* The TweetNaCl code (unsurprisingly) contains no comments at all, so merely understanding its behaviour is non-trivial.
* The code deploys various non-obvious mathematical tricks to improve performance.
* The code deploys "constant time" algorithms, where no conditional statements depend on sensitive data. This programming style renders the code somewhat difficult to understand, both for a human reader and formal verification tools.

## Current state of the release

This release of SPARKNaCl meets most of the goals above. In particular:

* The code retains the "constant time" algorithms from TweetNaCl, but (I would argue) are far more readable. See [SPARKNaCl.Utils.Pack_25519](https://github.com/rod-chapman/SPARKNaCl/blob/master/src/sparknacl-utils.adb) for example.

* The proof of type safety is "complete" in that the SPARK verification tools discharge all verification conditions for all the contracts and type-safety conditions in the code. In less formal terms, "type safety" means that the code definitely contains no buffer overflow, numeric overflows, division by zero, or anything else that would normally give rise to an exception at run-time in Ada.
* The proof requires use of all three main proof engines supplied with SPARK (CVC4, Z3 and Alt-Ergo). No one of these is capable of discharging all the VCs on its own.
* The code contains no undefined behaviour, and does not depend on any unspecified behaviour. Additionally, there is no "erroneous behaviour" and no "bounded erors", such as reading uninitialized data.
* The NaCl test suite has been re-implemented and passes.

Still on the "to be done" list:

* Performance has not yet been assessed or optimized. I have recently taken delivery of a small RISC-V development board that will serve fior performance testing.
* Code size has not yet been assessed against TweetNaCl.

## Tools

All development work has been done with the [Community 2019 Edition of GNAT and SPARK](https://www.adacore.com/community), which are freely available. Most development work has been done on MacOS, although test results have been successfully reproduced on 64-bit Linux and Windows 10.

## Reproducing results

Assuming you have cloned this repository and have the GNAT and SPARK tools installed, then:

### Proofs

```
cd src
gnatprove -Psparknacl
```

To see a summary of the proof results, see the resulting `gnatprove/gnatprove.out` file.

To see *only* failed proofs (of which there should be none), do

```
gnatprove -Psparknacl --report=fail
```

**NOTE**: the project file sets a fairly long timeout (60s) for the proof tools, which should suffice on most machines to discharge all the proofs. Slower machines might fail.

### Tests

The test cases from NaCl (from the "tests" directory in the NaCl distribution) have been re-implemented in Ada in the "tests" subdirectory here. A top-level driver program `testall.adb` runs them all.

Expected results are in `expected_test_results` the same directory.

A simple `Makefile` is also supplied that builds and runs two variants of `testall.adb` and compares the results:

* A "debug" build with optimization and -O0. This also compiles *all* contracts (pre-conditions, assertions etc.) into the code, so they are checked at run-time. This build is very slow.
* A "fast" build with no run-time checking and using -O3.

To reproduce:

```
cd tests
make
```

should suffice.

A second directory "stress" also contains additional boundary-value and stress-test cases for some of the NaCl functions. A single project file there `stressall.gpr` builds the test driver program - for example:

```
cd stress
gprbuild -Pstressall
./stressall
```


## Known weaknesses and TBD items

At this time, there are several items to-be-done:

* Performance test and optimization.  I expect the current code will be a bit slower than TweetNaCl, owing to two main issues:
  1. In SPARK, it is natural programming style to return composite objects (e.g. array types) by copy from functions. This is elegant in terms of readability and proof, but has a performance penalty.  For example, our "*", "+" and "-" operators for the GF type all return an array of 16 64-bit integers by copy.
  2. Currently, SPARKNaCl applies the GF "Carry" operation more aggressively than in TweetNaCl. For example, SPARKNaCl applies "Carry" after a "+" operation, and applies Carry *three* times after "*". These make proof easier, but come at some cost in performance. Relaxation of these rules remains TBD.

* Code size comparison with TweetNaCl.
* Structural coverage analysis of the tests against the sources has not yet been performed. I don't expect the results will be very interesting, though. Some support for this does exist in the main project file in the "cover" build target.

## Acknowledgements

Many thanks to:
1. Yannick Moy of [AdaCore](http://www.adacore.com/) who helped with SPARK language and toolset issues.
2. [Benoit Viguier](https://benoit.viguier.nl), who kindly offered advice and help with explaining the GF "Carry" operation.
3. [Jason Donenfeld](https://www.zx2c4.com) for providing pointers to his revised "Carry" algorithm that is used in WireGuard.
