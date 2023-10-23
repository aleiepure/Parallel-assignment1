# Introduction to Parallel Computing (A.Y. 2023-2024) - Assignment 1

This repo contains the solution of the [first assignment](homework1.pdf) of the course  "Introduction to Parallel Computing - prof. Vella" from the University of Trento.

## Build and run
> [!NOTE]
> Requires `gcc`, install/load it before running (default version). A Linux environment is assumed.

### Easy way (preferred)
Execute the `run.sh` script. The result of each binary is available in the `results/` folder (created by the script) as `CSV` files. 

### Manual way
Compile the codes using the following commands:
- Sequential: `gcc /path/to/file.c`
- Parallelised: `gcc -O2 -ftree-vectorize -funroll-loops -fprefetch-loop-arrays -march=native /path/to/file.c`.
> [!IMPORTANT]
> If the version of `gcc` used is too old (<=4.3), add the flag `-std=c99`. 

Required arguments for execution:
- Array (Ex. 1): array size (e.g., `./a.out 2048`)
- Matrix (Ex. 2): b size (e.g., `./a.out 32`)

Both programs output to `stdout` in the format `size,required_time` to be compatible with `CSV` files.

## Results
The report analyzing the results is available [here](report/build/report.pdf).
