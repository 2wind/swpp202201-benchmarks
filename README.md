# Benchmarks for SWPP Team Project

### 그런데 check.sh를 곁들인

- `irgen`을 미리 컴파일하였으나, 필요하면 새로 컴파일하면 됩니다.
- 이후 check.sh를 이용해 제대로 실행이 되는지, 점수는 어떤지 확인 가능합니다.

`check.sh <llvm path> <your swpp compiler path> <swpp interpreter path>`

- 정상적이라면 모든 실행을 마지막까지 마치게 됩니다.
- 문제가 있다면 에러가 있는 곳에서 중간에 중지합니다.

SWPP 조교님들께 깊은 감사를 표합니다.

(Original readme below)

This repository contains C programs, and input/outputs
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

