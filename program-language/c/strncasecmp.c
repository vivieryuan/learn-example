#include<string.h>
#include<stdio.h>

int main(void)
{
    char const *s1 = "abcUdd";
    char const *s2 = "aBcDdd";
    if (strncasecmp(s1,s2,3) == 0)
    {
        printf("equal\n");
    }
    else
    {
        printf("not equal\n");
    }
    return 0;
}
