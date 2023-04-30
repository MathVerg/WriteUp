version := 5.19.0-35-generic
dir     := /lib/modules/$(version)/build

obj-m   += pwnme.o

all:
	make -C $(dir) M=$(PWD) modules

clean:
	make -C $(dir) M=$(PWD) clean
