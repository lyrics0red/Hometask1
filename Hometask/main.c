#include <stdio.h>

static int A[1000000], B[1000000];

int main(int argc, char** argv) {
    int n, i, count = 0;

    scanf("%d", &n);
    for (i = 0; i < n; ++i) {
        scanf("%d", &A[i]);
    }

    for (i = 0; i < n; ++i) {
        if (A[i] > 0) {
            B[count] = A[i];
            ++count;
        }
    }

    for (i = 0; i < count; ++i) {
        printf("%d ", B[i]);
    }
    

    return 0;
}
