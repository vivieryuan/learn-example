#include<stdio.h>
#include<string.h>
#include<sys/socket.h>
#include<sys/un.h>
#include<sys/types.h>
#include<unistd.h>

int main(int argc, char *argv[])
{
    char *mysockpath = argv[1];
    struct sockaddr_un namesock;
    int fd;
    namesock.sun_family = AF_UNIX;
    strncpy(namesock.sun_path, (char *)mysockpath, sizeof(namesock.sun_path));
    fd = socket(AF_UNIX, SOCK_DGRAM, 0);
    printf("sockpath: %s, fd:%d\n", namesock.sun_path, fd);
    bind(fd, (struct sockaddr *)&namesock, sizeof(struct sockaddr_un));
    system("sleep 10");
    close(fd);
    return 0;
}
