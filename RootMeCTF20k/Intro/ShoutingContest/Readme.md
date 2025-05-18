# Shouting Contest

- Category: Intro/Pwn
- Difficulty: Easy
- Number of solves: 16

This is a pwn challenge, we are given the [source file](./src/shouting.c) and the [compiled binary](./src/shouting). The other files in the [src](./src/) folder are required for building and deploying the challenge but not for solving it, so they were not given to the players.

The program presents a "Shouting contest", where you have to "shout" louder as the opponent to get the flag. Unfortunately, the opponent duplicates your input, so it will always be longer than yours:
```
$ ./shouting
Welcome to Root-Me's official shouting contest!
Shout as hard as you can:
test
I said "shout", not "talk gibberish"
The game did not go as expected...
$ ./shouting
Welcome to Root-Me's official shouting contest!
Shout as hard as you can:
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
Not bad! My turn now:
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

I did 95 dB and you did 47 dB
Haha, you loose, I am the best!
```

Compiling the programs gives the vulnerability away:
```
$ gcc shouting.c
shouting.c: In function ‘game’:
shouting.c:25:5: warning: ‘strncat’ specified bound 256 exceeds destination size 100 [-Wstringop-overflow=]
   25 |     strncat(adversary_buf, player_buf, 0x100);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
shouting.c:7:10: note: destination object allocated here
    7 |     char adversary_buf[100];
      |          ^~~~~~~~~~~~~
```
So, we can write `0x100` (`= 256`) in a buffer of size `100`, that's a good old stack buffer overflow. Let's check the protections:
```
$ checksec --file=shouting
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      Symbols         FORTIFY Fortified       Fortifiable     FILE
Partial RELRO   No canary found   NX enabled    No PIE          No RPATH   No RUNPATH   36 Symbols        No    0               5               shouting
```
No canary, and no PIE, so the exploitation could be made simply by overwriting the return address with a "win" location. We will target the branch that says "You win..." then prints the flag. We can find the appropriate location using `objdump` or a disassembler: `0x40136e`.

Now, we only need to know how much we overwrite before reaching the return address. There is a little subtlety in this challenge however: since the input is deduplicated, each byte of input results in two bytes written on the stack, so we can only overwrite an even number of bytes. And since it is copied using string functions (`strcpy` and `strncat`), we can not use any null byte, and we thus need to do a partial overwrite on the return address. The return address has only three non-null bytes, so it seems complicated to properly overwrite it with an even number of bytes. Hopefully, we can notice that the final newline of the output is replaced by a null byte:
```c
adversary_volume = strlen(adversary_buf);
    if (adversary_buf[adversary_volume - 1] == '\n') {
        adversary_buf[--adversary_volume] = 0;
    }
```
So we can just put the three bytes of the win address at the end of our payload in little-endian and end our payload with a newline, and it should be properly overwritten.
Now we just need to calculate the right amount of padding before the return address, which can be done by trial and error in GDB, or just by bruteforce if you're lazy.

The resulting exploit can be found [here](exploit.py).
