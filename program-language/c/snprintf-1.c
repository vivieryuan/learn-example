#include <stdio.h>
int main()
{
    char str[5];
    int ret = snprintf(str, 3, "%s\n", "abcdefg");
    printf("%d\n",ret);
    printf("%s\n",str);
    return 0;
}
