# SPARKNaCl

SPARK 2014 re-implementation of the [TweetNaCl](https://tweetnacl.cr.yp.to) crypto library.

Copyright (c) 2020,2021 [Protean Code Limited](http://www.proteancode.com/).

Licence: this work is released under the "New" or "Revised" 3-clause BSD licence. See
[here](https://github.com/rod-chapman/SPARKNaCl/blob/master/LICENCE.md) for details.

This library is a compact reference implementation of the NaCl crypto library. It was originally inspired by the TweetNaCl implementation, but offers a completely automated static proof of type-safety (and some correctness properties), reasonable performance, and (unlike TweetNaCl) is readable owing to the large number of explanatory comments and contracts in the code.

[![Alire](https://img.shields.io/endpoint?url=https://alire.ada.dev/badges/sparknacl.json)](https://alire.ada.dev/crates/sparknacl.html)

## Contents

[Latest news](https://github.com/rod-chapman/SPARKNaCl#latest-news)

[Why Bother?](https://github.com/rod-chapman/SPARKNaCl#why-bother)

[Goals](https://github.com/rod-chapman/SPARKNaCl#goals)

[Challenges](https://github.com/rod-chapman/SPARKNaCl#challenges)

[Current state of the release](https://github.com/rod-chapman/SPARKNaCl#current-state-of-the-release)

[Tools](https://github.com/rod-chapman/SPARKNaCl#tools)

[Reproducing results](https://github.com/rod-chapman/SPARKNaCl#reproducing-results)

[Known weaknesses and TBD items](https://github.com/rod-chapman/SPARKNaCl#known-weaknesses-and-tbd-items)

[Acknowledgements](https://github.com/rod-chapman/SPARKNaCl#acknowledgements)

## Latest news

### 25th June 2021

* Work on porting, proof and performance analysis with GNAT and SPARK Community 2021 is written up [here](https://blog.adacore.com/sparknacl-with-gnat-and-spark-community-2021-port-proof-and-performance). This post also covers some more performance improvement, where I managed to save another 60 Million CPU cycles for a "Sign" operation at -O0.

### 29th May 2021

* I have started work to evaluate the library with the Community 2021 releases of GNAT and SPARK. Both proof robustness and performance will be considered. GNAT CE 2021 is based on GCC 10.3.1, so we'll see if the new compiler can squeeze a bit more performance out of the code. Results soon.

### 11th March 2021

* The PRNG package ("random") has been removed from the core library. Provision of a cryptographically secure RNG is inherently target-dependent, so was hindering portability of the library. It is now up to clients to supply their own PRNG or TRNG as appropriate. This also entails a small change to the API for the "Keypair" procedures.
* As a result of removing the RNG package, the entire SPARKNaCl library is now "Pure", as defined by Ada RM 10.2.1. This simplifies packaging and integration, especially for mixed-language projects, where calling (for example) from C might be required.

### 4th March 2021

* More performance tuning reported [here](https://blog.adacore.com/doubling-the-performance-of-sparknacl-again). This blog also reports code size and worst-case stack usage for all popular optimization levels.

### 9th February 2021

* Results of performance analysis and tuning now written up [here](https://blog.adacore.com/performance-analysis-and-tuning-of-sparknacl).

* There's more to come...in the final stages of writing that blog entry, I realized how I could save a few more million CPU cycles. I'll be writing this one up separately, since it illustrates another interesting topic: proof-based refactoring.

* A new release incorporating those performance improvements will be published in ALIRE.

### 3rd December 2020

* SPARKNaCl is now available through the [ALIRE](https://alire.ada.dev/) package manager. Click on the ALIRE badge above to be taken to its entry in the ALIRE index.

* Performance analysis and tuning has been going well. A full write-up of the results will be coming soon.

### 4th September 2020

* We have completed worst-case stack usage analysis using GNATStack. This pointed out that there was a dynamic object being allocated on the stack in SPARKNaCl.Sign.Sign (owing to the use of the "&" operator to initialize the "out" parameter SM of procedure Sign.) This need for a dynamic object has been removed by refactoring the code slightly and using the new "Relaxed_Initialization" aspect that is supported in the 2020 SPARK language and toolset.  See the new procedure SPARKNaCl.Sign.Sign.Initialize_SM for details.

* GNATStack now reports a worst-case stack usage of 5648 bytes for a call to SPARKNaCl.Sign.Sign, when compiled for 32-bit RISC-V. Stack usage results for the other main API calls will follow.

* The sources have been updated to yield 100% automated proof using the SPARK Community 2020 release of the toolset. To achieve this, we re-enable Alt-Ergo and increase the Steps limit for all provers.

* A new sub-directory "perf" has been added, containing the beginnings of a performance testing framework and main program. The target for performance testing is a SiFive HiFive1 Revision B DevBoard. This contains a 32-bit RISC-V SoC. Performance results and tuning are in progress.

### 1st April 2020

* Yannick Moy from AdaCore pointed out that there had been a [soundness issue](https://github.com/OCamlPro/alt-ergo/issues/248) with alt-ergo 2.3.0 (the version that shipped with GNAT Community 2019), so I decided to put a bit more work in and refactor the proofs to remove the need for alt-ergo. All the proofs now discharge OK with only CVC4 and Z3, and the project settings file has been updated to reflect that.

* All proofs have been reproduced OK on both MacOS and Linux using GNAT Community 2019.

* The project file has been updated to set a "steps limit" for CVC4 and Z3 and to disable memory limits and timeouts in both provers. This should give consistent results on all platforms.

* A longer blog entry has been written aboout the Utils.Pack_25519 function and how it works and verifies in SPARK. This appeared on [blog.adacore.com](https://blog.adacore.com/proving-constant-time-crypto-code-in-sparknacl) on 2nd April 2020.

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
* The proof requires use of two of the main proof engines supplied with SPARK (CVC4, Z3). No one of these is capable of discharging all the VCs on its own.
* The code contains no undefined behaviour, and does not depend on any unspecified behaviour. Additionally, there is no "erroneous behaviour" and no "bounded erors", such as reading uninitialized data.
* The NaCl test suite has been re-implemented and passes.
* Performance analysis of Curve25519, SHA512, and the top-level "Sign" operation has been done.

Still on the "to be done" list:

* While GNAT Community Edition 2019 is based on GCC 8.3.1, it would also be interesting to repeat all tests and performance analysis using the recently-released GNAT/LLVM integration.
* Performance analysis and optimization of Salsa20, and the SecretBox and CryptoBox primitives.

## Tools

All development work has been done with the [Community 2020 and 2021 Editions of GNAT and SPARK](https://www.adacore.com/community), which are freely available. Most development work has been done on MacOS, although test results have been successfully reproduced on 64-bit Linux and Windows 10. Performance testing additionally requires the GNAT 32-bit RISC-V cross compiler from the same source.

The GNATStack tool runs on Linux and uses the output of the RISC-V cross compiler to drive its analysis.  GNATStack was built from source, but this is not available in the Community release of GNAT. To obtain the GNATStack sources, you will need a GNAT Pro subscription from AdaCore.

## Reproducing results

Assuming you have cloned this repository and have the GNAT and SPARK tools installed, then:

### Proofs

```
gnatprove -Psparknacl
```

To see a summary of the proof results, see the resulting `obj/gnatprove/gnatprove.out` file.

To see *only* failed proofs (of which there should be none), do

```
gnatprove -Psparknacl --report=fail
```

**NOTE**: the project file sets a "steps limit" of 14000 for CVC4 and Z3, and no timeout or memory limit on the provers. THis should give the same results on all machines.

### Tests

The test cases from NaCl (from the "tests" directory in the NaCl distribution) have been re-implemented in Ada in the "tests" subdirectory here. A top-level driver program `testall.adb` runs them all.

Expected results are in `expected_test_results` the same directory.

A simple `Makefile` is also supplied that builds and runs two variants of `testall.adb` and compares the results:

* A "debug" build with optimization at -O0. This also compiles *all* contracts (pre-conditions, assertions etc.) and type-safety checks into the code, so they are checked at run-time. This build is very slow.
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

* Performance test and optimization. (Done - See 4th March 2021 News above)
* Code size comparison with TweetNaCl. (Done - See 4th March 2021 News above)
* Structural coverage analysis of the tests against the sources has not yet been performed. I don't expect the results will be very interesting, though. Some support for this does exist in the main project file in the "cover" build target.
* Repeat performance analysis using [GNAT-LLVM](https://github.com/AdaCore/gnat-llvm).
* API/wrapper for calling SPARKNaCl from C.

## Acknowledgements

Many thanks to:
1. Yannick Moy and Claire Dross of [AdaCore](http://www.adacore.com/) who helped with SPARK language and toolset issues.
2. [Benoit Viguier](https://benoit.viguier.nl), who kindly offered advice and help with explaining the GF "Carry" operation.
3. [Jason Donenfeld](https://www.zx2c4.com) for providing pointers to his revised "Carry" algorithm that is used in WireGuard.
