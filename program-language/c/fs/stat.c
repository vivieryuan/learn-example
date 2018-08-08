#include<sys/stat.h>
#include<stdlib.h>
#include<stdio.h>
#include<linux/fs.h>

int main(int argc, char *argv[])
{
    struct stat sb;
    char major, minor;

    if (stat("/dev/console", &sb))
    {
        perror("stat device error");
        exit(-1);
    }

    //major = MAJOR(sb.st_rdev);
    //minor = MINOR(sb.st_rdev);
    printf("%d, %d\n", major, minor);
    exit(0);
}
