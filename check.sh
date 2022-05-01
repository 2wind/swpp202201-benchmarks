#!/bin/bash
if [ "$#" -ne 3 ]; then
  echo "check.sh <clang dir> <compiler dir> <interpreter dir>"
  echo "(ex: check.sh /<llvm-dir>/bin/clang /swpp202201-compiler-team3/build/ swpp202201-interpreter/)"
  exit 1
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  ISYSROOT="-isysroot `xcrun --show-sdk-path`"
else
  ISYSROOT=
fi

CLANGDIR=$1
COMPILERDIR=$2
INTERPRETERDIR=$3

if [[ "$GITHUB_ACTIONS" == true ]]; then
  DIFFWIDTH=160
else
  DIFFWIDTH=80
fi

check() {
  set -e
  problem=$1
  echo "-- $problem --"
  ./c-to-ll.sh ${problem}/src/${problem}.c $CLANGDIR
  $COMPILERDIR/swpp-compiler ${problem}/src/${problem}.ll ${problem}/src/${problem}.s
  
  set +e
  n=`ls ${problem}/test/input* | wc -l`

  SCORE=0
  TOTAL=0

  for (( i=1; i<=$n; i++)) ; do
    echo "- input${i}.txt"

    $INTERPRETERDIR/sf-interpreter ${problem}/src/${problem}.s < ${problem}/test/input${i}.txt | tee tmp.txt 1>/dev/null
    diff tmp.txt ${problem}/test/output${i}.txt
    if [[ "$?" -eq 0 ]]; then
      echo "<OK>"
      SCORE=$((SCORE+10))
    else
      echo "<FAILED>"
      exit 1
    fi
    TOTAL=$((TOTAL+10))
  done

  echo "<<score: ${SCORE}/${TOTAL}>>"
  echo "<<Result>>"
  diff -y -W $DIFFWIDTH --left-column ${problem}/sf-interpreter.log sf-interpreter.log
  diff -y -W $DIFFWIDTH --left-column ${problem}/sf-interpreter-inst.log sf-interpreter-inst.log
  
  rm -f tmp.txt
  rm -f ${problem}/src/${problem}.ll
  rm -f ${problem}/src/${problem}.s
  rm -f sf-interpreter.log
  rm -f sf-interpreter-cost.log
  rm -f sf-interpreter-inst.log
}

check "anagram"
check "binary_tree"
check "bitcount1"
check "bitcount2"
check "bitcount3"
check "bubble_sort"
check "collatz"
check "floyd"
check "gcd"
check "matmul1"
check "matmul2"
check "matmul3"
check "merge_sort"
check "prime"
check "rmq1d_naive"
check "rmq1d_sparsetable"
