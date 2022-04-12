#include <stdio.h>
#include <stdlib.h>

/*Problem: https://www.hackerrank.com/challenges/c-tutorial-pointer/problem*/

void update(int *a,int *b) {
    int x = *a + *b;
    int y;
    y = abs(*a-*b);
    *a = x;
    *b = y;
}

int main() {
    int a, b;
    int *pa = &a, *pb = &b;
    
    scanf("%d %d", &a, &b);
    update(pa, pb);
    printf("%d\n%d", a, b);

    return 0;
}
