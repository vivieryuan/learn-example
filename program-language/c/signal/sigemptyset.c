#include<stdio.h>
#include<signal.h>

static void print_sigset(sigset_t *set)
{
    int i = 0;
    for (; i < NSIG; ++i)
    {
        if (sigismember(set, i))
        {
            printf("%02d: 1 ", i);
        }
        else
        {
            printf("%02d: 0 ", i);
        }
    }
    printf("\n");
}
int main(void)
{
    sigset_t myset;
    sigemptyset(&myset);
    sigaddset(&myset, SIGINT);
    sigaddset(&myset, SIGQUIT);
    sigaddset(&myset, SIGUSR1);
    print_sigset(&myset);
    return 0;
}
