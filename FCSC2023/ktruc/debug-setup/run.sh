#!/bin/sh
readonly LINUX=kinetic-server-cloudimg-amd64

#removed timeout, added -s for debug, changed initrd, disabled kaslr
exec qemu-system-x86_64                  \
	-cpu qemu64,+smep,+smap                                 \
	-m 512                                                  \
	-kernel $LINUX-vmlinuz-generic                          \
	-initrd initramfs.cpio.zst                              \
	-serial stdio                                           \
	-append 'console=ttyS0 boot=ctf quiet=y nokaslr'        \
	-nographic                                              \
	-monitor none                                           \
	-drive file=flag.txt,if=virtio,format=raw,readonly=true \
	-s                                                      \
	"$@"
