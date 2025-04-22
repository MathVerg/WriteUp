CFLAGS += -Wall -Wextra -fPIC -pie -Wl,-z,relro,-z,now -fstack-protector-all
main: main.c lexer.c parser.c jit.c

.PHONY: clean
clean:
	rm -f main
