CC := gcc
CFLAGS := -Wall -Wextra -Werror -static -no-pie

pwn:pwn.c
	$(CC) $(CFLAGS) -o pwn pwn.c
	cp ./pwn ./initramfs/pwn
	gzip -9 pwn.gz
	cd initramfs && find . -print0 | cpio --null -ov --format=newc | zstd -9 > initramfs.cpio.zst
	mv initramfs/initramfs.cpio.zst .

clean:
	rm pwn