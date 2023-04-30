#!/bin/sh
readonly LINUX=kinetic-server-cloudimg-amd64

exec timeout -k 301 300 qemu-system-x86_64                  \
	-cpu qemu64,+smep,+smap                                 \
	-m 512                                                  \
	-kernel $LINUX-vmlinuz-generic                          \
	-initrd initrd                                          \
	-serial stdio                                           \
	-append 'console=ttyS0 boot=ctf quiet=y'                \
	-nographic                                              \
	-monitor none                                           \
	-drive file=flag.txt,if=virtio,format=raw,readonly=true \
	"$@"
