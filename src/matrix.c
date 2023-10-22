/**
 * Introduction to Parallel Computing (A.A. 2023/2024)
 * Homework 1: Implicit parallelism techniques and performance models
 *
 * Matrix copy via block reverse ordering
 *
 * Alessandro Iepure
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

# define RND_MAX 100
# define N 4096 // 2^12

float random_float() {
    return (rand() % (RND_MAX * 1000 + 1)) / (float) 1000;
}

float **allocateMatrix(int size) {
    float **matrix = (float **) malloc(size * sizeof(float *));
    for (int i = 0; i < size; i++) {
        matrix[i] = (float *) malloc(size * sizeof(float));
    }
    return matrix;
}

void fill_matrix(float **m, int dim) {
    for (int i = 0; i < dim; i++) {
        for (int j = 0; j < dim; j++) {
            m[i][j] = random_float();
        }
    }
}

void deallocateMatrix(float **matrix, int size) {
    for (int i = 0; i < size; i++) {
        free(matrix[i]);
    }
    free(matrix);
}

float **routine1(float **m, int dim, int b, float **o) {
    clock_t t0, t1;

    t0 = clock();
    for (int i = 0; i < dim / 2; i += b) {
        for (int j = 0; j < dim; j += b) {
            for (int k = 0; k < b; k++) {
                for (int l = 0; l < b; l++) {
                    o[i + k][j + l] = m[dim - i - (b - k)][dim - j - (b - l)];
                    o[dim - i - (b - k)][dim - j - (b - l)] = m[i + k][j + l];
                }
            }
        }
    }
    t1 = clock();

    printf("%i,%12.4f\n", b, (t1 - t0) / 1000000.0);
    return (float **) o;
}

int main(int argc, char *argv[]) {
    int B; //[2^2, 2^8]
    float **M = allocateMatrix(N);
    float **O = allocateMatrix(N);

    if (sscanf(argv[1], "%i", &B) != 1) {
        fprintf(stderr, "error - not an integer");
        return -1;
    }

    fill_matrix(M, N);

    routine1(M, N, B, O);

    deallocateMatrix(M, N);
    deallocateMatrix(O, N);
    return 0;
}
