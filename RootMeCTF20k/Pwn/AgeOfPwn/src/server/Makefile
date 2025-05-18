
CFLAGS = -Wall -Wextra -O2
LDFLAGS = -lpthread -Wl,-z,relro,-z,now

all: server debug

server: server.c server.h
	gcc $(LDFLAGS) $(CFLAGS) -o server server.c

debug: server.c server.h
	gcc $(LDFLAGS) $(CFLAGS) -DDEBUG -g -o debug server.c

clean:
	rm server debug