# Benchmarks for SWPP Team Project

This repository contains C programs, IR programs that are compiled from them, and input/outputs
for the team project of [SWPP](https://github.com/snu-sf-class/swpp202201).

Note that in the final competition TAs can add more test cases or programs.

### Authors

Sung-Hwan Lee, Juneyoung Lee

### How to build .ll file from your own C program?

1. Build `irgen`. Insert your `clang` directory in <>.

```
./build-irgen.sh </opt/llvm-swpp/bin/>
```

2. Convert .c to .ll using c-to-ll.sh.
  
```
./c-to-ll.sh <.c file> </opt/llvm-swpp/bin>
```

