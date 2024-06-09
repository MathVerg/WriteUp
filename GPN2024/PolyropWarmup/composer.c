#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void win() {
    char buf[0x11] = {0};
    read(42, buf, 0x10);
    write(1, buf, 0x10);
    printf("this printf solely exists to shift some stuff around in the binary...\n");
}

static int xgetchar(void) {
    int x = getchar();
    if (x == EOF)
        exit(1);
    return x;
}

static long get_byte(void) {
    long result = xgetchar() - '0';
    while (xgetchar() != '\n') {}
    return result;
}

static void add_composer(void) {
    char buf[0x20];
    puts("enter composer:");
    int i = 0, c;
    while ((c = xgetchar()) != '\n') {
        buf[i++] = c;
    }
    fputs("composer: ", stdout);
    puts(buf);
    // TODO: add composer to db
}

int main(void) {
    setbuf(stdout, NULL);
    puts("welcome to advanced composer manager 5000!!  menu:  1. add composer  2. exit");
    for (;;) {
        int choice = get_byte();
        if (choice == 1)
            add_composer();
        else if (choice == 2)
            return 0;
        else
            puts("invalid choice");
    }
}
