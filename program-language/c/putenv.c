#include<stdlib.h>
#include<stdio.h>

int main(void)
{
    char *p;
    if ((p = getenv("FUCK")) != NULL)
    {
        printf("%s\n", p);
    }
    else
    {
        putenv("FUCK='you you'");
        printf("%s\n", getenv("FUCK"));
    }
    return 0;
}
