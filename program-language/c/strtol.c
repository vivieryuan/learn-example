#include<stdlib.h>
#include<stdio.h>

int main(void)
{
    char *s = "1234";
    char *pos = s;
    //long int i = strtol(s, &pos, 10);
    long int i = strtol(s, &pos, 16);
    //long int i = strtol(s, &pos, 8);
    if (pos == s )
        printf("convert faild!\n");
    else
        printf("success: %ld\n", i);
    return 0;
}
