/**
 * Introduction to Parallel Computing (A.A. 2023/2024)
 * Homework 1: Implicit parallelism techniques and performance models
 *
 * Array addition and vectorization
 *
 * Alessandro Iepure
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

# define RND_MAX 100

float random_float() {
    return (rand() % (RND_MAX * 1000 + 1)) / (float) 1000;
}

void fill_array(float *array, int dim) {
    for (int i = 0; i < dim; i++) {
        array[i] = random_float();
    }
}

float *routine1(const float *a, const float *b, float *c, int dim) {

    clock_t t0, t1;

    t0 = clock();
    for (int i = 0; i < dim; i++) {
        c[i] = a[i] + b[i];
    }
    t1 = clock();

    printf("%i,%12.4f\n", dim, (t1 - t0) / 1000000.0);
    return c;
}

int main(int argc, char *argv[]) {

    int DIM; //[2^4, 2^22]
    if (sscanf(argv[1], "%i", &DIM) != 1) {
        fprintf(stderr, "error - not an integer");
        return -1;
    }

    float *a = (float *) malloc(DIM * sizeof(float *));
    float *b = (float *) malloc(DIM * sizeof(float *));
    float *c = (float *) malloc(DIM * sizeof(float *));

    fill_array(a, DIM);
    fill_array(b, DIM);

    routine1(a, b, c, DIM);

    free(a);
    free(b);
    free(c);
    return 0;
}
