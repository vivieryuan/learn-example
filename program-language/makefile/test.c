#include<stdio.h>
#include "test.h"
#include<stdlib.h>

int main(void)
{
    struct test *p = (struct test*)malloc(sizeof(*p));
    printf("size=%d\n", sizeof(*p));
    return 0;
}
