# Root-Me CTF20k

Root-Me made a CTF on May 10th-11th 2025 to celebrate the fact that we reached 20k members on our [Discord server](https://discord.com/invite/rootme).
This was an individual CTF, with 211 participants.
I created a few challenges for this CTF, which turned out to be more difficult than I expected (but not as difficult as those from [nikost](https://blog.nikost.dev/) :-P).
This was my first experience creating challenges for a CTF, and I really enjoyed seeing players struggle and solve them.

I made challenges in three categories: Intro, Misc, and Pwn.

## Intro

- [Counter Strike](./Intro/CounterStrike/) (crypto): AES CTR mode but I messed up and gave the key instead of the IV
- [Shouting Contest](./Intro/ShoutingContest/) (pwn): Stack Buffer Owverflow 101, but I treied to make it a bit interesting
- Preprocessin Park (misc): see next section

## Misc

"Preprocessin Park" was actually the first in a [series of three independent challenges](./MiscPark/), with a very similar structure: a server running a GCC command on the input, and giving back the output. As their names suggest:
- Preprocessin Park: runs the C-preprocesssor on the input
- Compilin Park: compiles the input
- Linkin Park: links the input

## Pwn

I developed two rather difficult pwn challenges with the amazing [Lukas](https://github.com/hertelukas). We actually did not create these challenges for this CTF, but for two awesome courses we had at the [Technical University of Munich](https://www.tum.de): [Binary Exploitation (BX)](https://www.sec.in.tum.de/i20/teaching/ws2022/binary-exploitation) and [Advanced Binary Exploitation (ABX)](https://www.sec.in.tum.de/i20/teaching/ws-2023/advanced-binary-exploitation).

- [GRaaS](./Pwn/GRaaS/): the challenge we created for BX, where a service takes a GIF as input, rotates it and gives you the result back. There is a stack based buffer overflow in the GIF handling, but you don't have direct interaction with the program. For BX we made it a RISC-V challenge, for Root-Me I decided to make it X86-64 but with a seccomp profile to force the player to make a funny ROPchain
- [Age of Pwn](./Pwn/AgeOfPwn/): created for ABX, a parody of one of my childhoods games. You get a client for a multiplayer game and have to exploit the server with the Blind ROP technique