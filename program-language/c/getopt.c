/*
 *getopt
 * **/
#include<stdio.h>
#include<unistd.h>

int main(int argc, char *argv[])
{
    int c = 0;
    int bflg = 0, aflg = 0, errflg = 0;
    char *ifile = NULL;
    char *ofile = NULL;
    //extern char *optarg;
    //extern int optind, optopt;

    while ((c = getopt(argc, argv, ":abf:o")) != -1)
    {
        switch (c)
        {
            case 'a':
                printf("a set\n");
                break;
            case 'b':
                printf("b set\n");
                break;
            case 'f':
                printf("f set\n");
                break;
            case 'o':
                printf("o set\n");
                break;
            case '?':
                printf("unknown %c\n", optopt);
                break;
            case ':':
                printf(": %c\n", optopt);
                break;
            default:
                printf("defualt %c\n", optopt);
                break;
        }

        printf("optopt:%c\n", optopt);
        printf("optarg:%s\n", optarg);
        printf("optind:%d\n", optind);
    }

    return 0;
}
