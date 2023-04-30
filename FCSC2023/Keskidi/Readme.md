# FCSC 2023: Keskidi

"Keskidi" is a pwn challenge not like the others, because I obtained a First Blood for it. Here is how I solved it.

## Reverse-engineering

For this challenge, we were given the binary, but not the source code. I started by reverse-engineering it with Ghidra.

### The `main` function

I gave some meaningful names and types to the different variable, and reconstructed the following `main` function:
```C
int main(void)

{
  int random_fd;
  int fun_retval;
  __pid_t child_pid;
  ssize_t len_rw;
  long in_FS_OFFSET;
  ulong i;
  char mkstemp_template [29] = "/tmp/fcsc2023-keskidi-XXXXXX";
  long random_buf [32];
  long Canary;
  
  Canary = *(long *)(in_FS_OFFSET + 0x28);
  signal(0xe,sigalarm_handler);
  alarm(60);
  random_fd = open("/dev/urandom",0);
  if (random_fd == -1) {
    perror("open");
    exit(1);
  }
  TEMP_FD = mkstemp(mkstemp_template);
  if (TEMP_FD == -1) {
    perror("mkstemp");
    exit(1);
  }
  fun_retval = fchmod(TEMP_FD,0666);
  if (fun_retval == -1) {
    perror("fchmod");
    exit(1);
  }
  fun_retval = unlink(mkstemp_template);
  if (fun_retval == -1) {
    perror("unlink");
    exit(1);
  }
  for (i = 0; i < 0x10; i = i + 1) {
    len_rw = read(random_fd,random_buf,0x100);
    fun_retval = (int)len_rw;
    if (fun_retval == -1) {
      perror("read");
      exit(1);
    }
    len_rw = write(TEMP_FD,random_buf,(long)fun_retval);
    if (len_rw != fun_retval) {
      perror("write");
      exit(1);
    }
    BIG_RANDOM_BUF[i * 0x20] = random_buf[0];
    BIG_RANDOM_BUF[i * 0x20 + 1] = random_buf[1];
    //[...]
    BIG_RANDOM_BUF[i * 0x20 + 0x1e] = random_buf[30];
    BIG_RANDOM_BUF[i * 0x20 + 0x1f] = random_buf[31];
  }
  random_fd = close(random_fd);
  if (random_fd == -1) {
    perror("close");
    exit(1);
  }
  child_pid = fork();
  if (child_pid == -1) {
    perror("fork");
    exit(1);
  }
  if (child_pid == 0) {
    child_work();
  }
  else {
    sleep(1);
    parent_work(child_pid);
  }
  if (Canary != *(long *)(in_FS_OFFSET + 0x28)) {
    __stack_chk_fail();
  }
  return 0;
}
```
This `main` function creates a temporary file, generate many random bytes and fills both a big buffer in the `.data` section and the temporary file with them, then forks. The parent and child process execute a different function, and the parent waits 1 second before starting. The program exits after 60 seconds because of the SIGALARM handler.

### The `parent_work` functions

Here is what I obtained for the `parent_work` function:
```C
void parent_work(__pid_t child_pid)

{
  int fun_retval;
  __pid_t ret_wait;
  ssize_t len_read;
  size_t flag_len;
  long in_FS_OFFSET;
  long i;
  void *cursor;
  char flag_buf [70];
  undefined uStack_52;
  undefined8 canary;
  
  canary = *(undefined8 *)(in_FS_OFFSET + 0x28);
  flag_fd = open("flag.txt",0);
  if (flag_fd == -1) {
    perror("open");
    exit(1);
  }
  len_read = read(flag_fd,flag_buf,0x80);
  if ((int)len_read < 1) {
    perror("read");
    exit(1);
  }
  if ((int)len_read != 0x46) {
    perror("read: the flag must be 70-char long.");
    exit(1);
  }
  fun_retval = close(flag_fd);
  if (fun_retval == -1) {
    perror("close");
    exit(1);
  }
  uStack_52 = 0;
  flag_len = strlen(flag_buf);
  for (i = 0; i < (int)flag_len; i = i + 1) {
    cursor = BIG_RANDOM_BUF;
    do {
      cursor = memchr(cursor,(int)flag_buf[i],0x1000 - ((long)cursor + -0x104060));
      if (cursor != (void *)0x0) {
        lseek(TEMP_FD,(long)cursor + -0x104060,0);
        write(TEMP_FD,&DAT_00102063,1);
        syncfs(TEMP_FD);
        cursor = (void *)((long)cursor + 1);
      }
    } while (cursor != (void *)0x0);
  }
  fun_retval = close(TEMP_FD);
  if (fun_retval == -1) {
    perror("close input");
    exit(1);
  }
  ret_wait = waitpid(child_pid,(int *)0x0,0);
  if (ret_wait == -1) {
    perror("wait");
    exit(1);
  }
  exit(0);
}
```
So, the parent process reads the flag, then for each character of the flag, replace every occurrence of this character in the temporary file by `0`, synchronizing the file with the filesystem every time. It finally closes the temporary file and waits for the child to finish.

### The `child_work` function

Yes, I could have chosen a better name. Anyway, here is the decompiled function:
```C
void child_work(void)

{
  __uid_t __suid;
  __uid_t __euid;
  __uid_t __ruid;
  int fun_retval;
  code *__buf;
  ssize_t len_read;
  
  __suid = getuid();
  __euid = getuid();
  __ruid = getuid();
  fun_retval = setresuid(__ruid,__euid,__suid);
  if (fun_retval == -1) {
    perror("setresuid");
    exit(1);
  }
  __buf = (code *)mmap((void *)0x0,0x100,3,0x22,-1,0);
  if (__buf == (code *)0xffffffffffffffff) {
    perror("mmap");
    exit(1);
  }
  len_read = read(0,__buf,0x100);
  if ((int)len_read == -1) {
    perror("read");
    exit(1);
  }
  fun_retval = mprotect(__buf,0x100,4);
  if (fun_retval == -1) {
    perror("mprotect");
    exit(1);
  }
  (*__buf)();
  exit(0);
}
```
This one is simple: it drops the process privileges, and then executes a shellcode given by the user. I first tried to simply write a `system("/bin/sh")` shellcode, but then of course, I saw that I did not have enough privileges to read the flag. We will somehow have to interact with the parent to get it.

## I wanna fork on the table

In the `fork` manpage, we can read the following:
> The child inherits copies of the parent's set of open file descriptors.  Each file descriptor in the child refers to the same open file description (see **open**(2)) as the corresponding file descriptor in the parent. This means that the two file descriptors share open file status flags, file offset, and signal-driven I/O attributes (see the description of **F_SETOWN** and **F_SETSIG** in **fcntl**(2)).

This is very interesting: in the child process, we still have access to the temporary file as it is being written by the parent. We could thus try for instance to continuously read the file and print its content, and try to observe which bytes are nullified. I tried it, in my first attempt I did not get any result, and I understood that it was due to the fact that the offset in the file was pointing to the end of the file, so I needed to first `lseek` to the start of the file. This idea is implemented in the `loop_printtmp` function in my [solution script](./attack.py). It was very inefficient, because it was loosing a lot of time in the race because of the printing, and because once a byte as been nullified, it wouldn't be affected anymore by further occurrences of this byte in the flag. So I had to find a better solution.

## Keskidi?

A much more efficient thing to do would be to dump the initial content of the temporary file (or the big buffer, they contain the same data) only once, and to only log the position of the cursor in the file, which we could then use to retrieve the byte being erased by the parent process. This position can be retrieved by calling `lseek(fd, 0, SEEK_CUR)`, which would move the cursor to the position `0` compared to its actual position, and return the new position, which is actually the same as the old one. In this situation, `lseek` behaves like `ftell`, which suddenly makes the name of the challenge meaningful ("Keskidi" = "Qu'est-ce qu'il dit ?" = "What is he saying?").

We tried two approaches :
- dumping the content of the random buffer, then going into an infinite loop of printing the cursor position (see `attack_buf_first`)
- printing the cursor position for a fixed amount of iterations, then dumping the content of the buffer (see `attack_bufend`)

The first approach seemed to work better on the server, probably because the branching in the loop of the second approach was slowing down the child process.

We can then interpret each logged position as the corresponding byte in the big buffer. If the same byte appears twice with a bigger offset the second time, we just consider that it is the same byte being erased at different positions, and we take it into account only once. The approach is not perfect though, we miss some characters.

## Reconstructing the flag

Using the previous approach, we obtain subsets of the flag characters, in the correct order:
```
C5caf51b474231c8e5a9c9043b73a7d46e37ed39e3a5d3fbce8}
13c8b5a29c9742b73ad462375d39e3b5dfc48}
d751ba424231c8b5a9c970423b73a7d462e3075ed39e3ab5d3fbc48}
5a7f1ba47242318b52c97043b73a7d42375d39c3ab53fb48}
df51ba7421c8b5a2997423737d462e307ed39c3a5d3bce8}
Ccda751ba47431c8eba9c97043b73ad46e375ed39c3ab5d3fbc4e8}
a751ba4724231c8eb529c70423b737d462e3075ed3e3ab53be8}
5472421c8eb5a29c97043b73a7d462e3075ed39ec3ab5dfc4e8}
...
```
By (manually) comparing these fragments, I was able to recombine them into the full flag: `FCSC{5cda7f51ba4724231c8eb5a29c970423b73a7d462e3075ed39ec3ab5d3fbc4e8}`. I added a verification function (`flag_match`) to my script in order to make sure that I made no mistake, and then submitted the flag, which was correct!

## Conclusion

The solution is quite dirty, but it worked... It was a bit like playing jigsaw puzzle, which is a recurring gag in the FCSC, so here is a conclusive meme :

![piece](./piece.png)