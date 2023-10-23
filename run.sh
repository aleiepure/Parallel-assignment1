#! /bin/bash
######################################################################
#
# Introduction to Parallel Computing (A.Y. 2023/2024)
# Homework 1: Implicit parallelism techniques and performance models
#
# Run script
#
# Alessandro Iepure
#
######################################################################

######################################################################
#
# Array addition and vectorization
#
######################################################################

# Sequential
sequential_array() {
  gcc -std=c99 \
      -o bin/array-seq.out \
      src/array.c
  printf "Compiled sequential array\n"

  for j in $(seq 1 3);
  do
    touch array-sequential-$j.csv
    printf "DIM,Run%d\n" $j > array-sequential-$j.csv

    printf "Running sequential array"
    for i in $(seq 4 22);
    do
      ./bin/array-seq.out $((2**$i)) >> array-sequential-$j.csv
      printf '.'
    done
    printf "\n"
  done
  paste -d ',' array-sequential-{1,2,3}.csv > tmp.csv
  cut -d, -f3,5 --complement tmp.csv > results/array-sequential.csv
  rm -rf array-sequential-{1,2,3}.csv tmp.csv
  printf 'Created CSV file %s\n' "`pwd`/results/array-sequential.csv"
}

# Parallel
parallel_array() {
  gcc -std=c99 \
      -O2 \
      -ftree-vectorize \
      -funroll-loops \
      -fprefetch-loop-arrays \
      -march=native \
      -o bin/array-par.out \
      src/array.c
  printf "\nCompiled parallel array\n"

  for j in $(seq 1 3);
  do
    touch array-parallel-$j.csv
    printf "DIM,Run%d\n" $j > array-parallel-$j.csv

    printf "Running parallel array"
    for i in $(seq 4 22);
    do
      ./bin/array-par.out $((2**$i)) >> array-parallel-$j.csv
      printf '.'
    done
    printf "\n"
  done
  paste -d ',' array-parallel-{1,2,3}.csv > tmp.csv
  cut -d, -f3,5 --complement tmp.csv > results/array-parallel.csv
  rm -rf array-parallel-{1,2,3}.csv tmp.csv
  printf 'Created CSV file %s\n' "`pwd`/results/array-parallel.csv"
}

######################################################################
#
# Matrix copy via block reverse ordering
#
######################################################################

# Sequential
sequential_matrix() {
  gcc -std=c99 \
      -o bin/matrix-seq.out \
      src/matrix.c
  printf "\nCompiled sequential matrix\n"

  for j in $(seq 1 3);
  do
    touch matrix-sequential-$j.csv
    printf "DIM,Run%d\n" $j > matrix-sequential-$j.csv

    printf "Running sequential matrix"
    for i in $(seq 2 8);
    do
      ./bin/matrix-seq.out $((2**$i)) >> matrix-sequential-$j.csv
      printf '.'
    done
    printf "\n"
  done
  paste -d ',' matrix-sequential-{1,2,3}.csv > tmp.csv
  cut -d, -f3,5 --complement tmp.csv > results/matrix-sequential.csv
  rm -rf matrix-sequential-{1,2,3}.csv tmp.csv
  printf 'Created CSV file %s\n' "`pwd`/results/matrix-sequential.csv"
}

# Parallel
parallel_matrix() {
  gcc -std=c99 \
      -O2 \
      -ftree-vectorize \
      -funroll-loops \
      -fprefetch-loop-arrays \
      -march=native \
      -o bin/matrix-par.out \
      src/matrix.c
  printf "\nCompiled parallel matrix\n"

  for j in $(seq 1 3);
  do
    touch matrix-parallel-$j.csv
    printf "DIM,Run%d\n" $j > matrix-parallel-$j.csv

    printf "Running parallel matrix"
    for i in $(seq 2 8);
    do
      ./bin/matrix-par.out $((2**$i)) >> matrix-parallel-$j.csv
      printf '.'
    done
    printf "\n"
  done
  paste -d ',' matrix-parallel-{1,2,3}.csv > tmp.csv
  cut -d, -f3,5 --complement tmp.csv > results/matrix-parallel.csv
  rm -rf matrix-parallel-{1,2,3}.csv tmp.csv
  printf 'Created CSV file %s\n' "`pwd`/results/matrix-parallel.csv"
}

mkdir -p results;
mkdir -p bin;
sequential_array
parallel_array
sequential_matrix
parallel_matrix
