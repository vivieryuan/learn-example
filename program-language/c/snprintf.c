#include<stdio.h>

int main(void)
{
    char buff[4096] = {0};
    int len = 0, ret;
    int i = 0;

    const char *s = "yuanwei";
    while ( i != 10 )
    {
        ret = snprintf(buff + len, sizeof(buff) - len, "%s\n", s);
        printf("ret = %d, buff=%s\n", ret, buff);
        len += ret;
        i++;
    }

    return 0;
}
