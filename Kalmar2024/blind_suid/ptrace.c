//Stole code from https://github.com/TRIKKSS/trikkssdbg/blob/main/src/main.c
//and here: https://github.com/kccqzy/no-aslr/blob/master/no-aslr.c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/ptrace.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/user.h>
#include <stdint.h>
#include <string.h>
#include <fcntl.h>
#include <errno.h>

char buf[0x1000];
uint64_t elf_base;

int main(int argc, char const *argv[])
{
    pid_t child;
    struct user_regs_struct registers, saved_registers;
    if(argc != 2)
	{
        puts("usage");
		return 1;
	}
    child = fork();
    if (child < 0) {
        fprintf(stderr, "fork() failed.\n");
        exit(EXIT_FAILURE);
    }
    else if (child == 0) {
        if(ptrace(PTRACE_TRACEME, 0, 0, 0) < 0)
		{
			printf("PTRACE ERROR\n");
			return 1;
		}
		if(execl(argv[1], argv[1], NULL) < 0)
		{
			exit(1);
		};
    }
    else {
        waitpid(child, NULL, 0);
        registers.rip = 0;
        while ((registers.rip >> 40) != 0x55 && (registers.rip >> 40) != 0x56) {
            ptrace(PTRACE_SINGLESTEP, child, NULL, NULL);
            waitpid(child, NULL, 0);
            ptrace(PTRACE_GETREGS, child, NULL, &registers);
        }
        elf_base = (registers.rip & ~0xfffUL) - 0x1000;
        ptrace(PTRACE_SYSCALL, child, NULL, NULL);
        waitpid(child, NULL, 0);
        ptrace(PTRACE_GETREGS, child, NULL, &registers);
        memcpy(&saved_registers, &registers, sizeof(saved_registers));
        registers.rdi = 2;
        registers.orig_rax = 1;
        registers.rsi = elf_base;
        registers.rdx = 0x5000;
        ptrace(PTRACE_SETREGS, child, NULL, &registers);
        ptrace(PTRACE_SYSCALL, child, NULL, NULL);
        waitpid(child, NULL, 0);
        saved_registers.rip -= 2;
        saved_registers.rax = saved_registers.orig_rax;
        ptrace(PTRACE_SETREGS, child, NULL, &saved_registers);
        ptrace(PTRACE_CONT, child, NULL, NULL);
        waitpid(child, NULL, 0);
    }
    return 0;
}
