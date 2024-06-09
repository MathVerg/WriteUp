#!/usr/bin/env python

import os, sys
from subprocess import Popen, PIPE


def spawn_qemu(arch, debug, index, token):
    if debug:
        return spawn(
            [f"qemu-{arch}", "-g", str(11234 + index), f"./composer-{arch}"],
            13370 + index,
            token,
        )
    else:
        return spawn([f"qemu-{arch}", f"./composer-{arch}"], 13370 + index, token)


def main():
    archs = [
        ("s390x", False),
        ("aarch64", False),
        ("arm", False),
        ("riscv64", False),
        ("x86_64", False),
    ]
    toks = [gen_tok() for _ in archs]
    ps = [
        spawn_qemu(arch, debug, i, t)
        for i, ((arch, debug), t) in enumerate(zip(archs, toks))
    ]

    while True:
        read(ps, archs)
        line = sys.stdin.buffer.readline()
        if line == b"magic word\n":
            xprint("toks:")
            if toks == [sys.stdin.buffer.readline().strip() for _ in toks]:
                xprint("flag:")
                with open("flag.txt") as f:
                    xprint(f.read())
                    exit()
            else:
                xprint("wrong")
                exit()
        write(ps, line)


def gen_tok():
    return os.urandom(8).hex().encode()


def spawn(args, uid, tok):
    fd = os.memfd_create("token")
    os.write(fd, tok)
    os.lseek(fd, 0, os.SEEK_SET)
    os.dup2(fd, 42)
    new_env = os.environ.copy()
    new_env["MAKE"] = "M" * 0x400
    new_env["SOME"] = "S" * 0x400
    new_env["ROOM"] = "R" * 0x400
    return Popen(args, stdin=PIPE, stdout=PIPE, pass_fds=[42], user=uid, env=new_env)


def read(ps, archs):
    for p, (a, _) in zip(ps, archs):
        try:
            x = p.stdout.readline()
        except IOError:
            x = b""
        xprint(f"{a}: {x!r}")


def write(ps, line):
    for p in ps:
        try:
            p.stdin.write(line)
            p.stdin.flush()
        except IOError:
            pass


def xprint(x):
    print(x, flush=True)


if __name__ == "__main__":
    main()
