CFLAGS += -Wall -Wextra -fPIC -pie -Wl,-z,relro,-z,now -fstack-protector-all

patched: main
	cp main patched
	patchelf --set-rpath . ./patched
	patchelf --set-interpreter ./ld-2.41.so ./patched

main: main.c

.PHONY: clean
clean:
	rm -f main patched
