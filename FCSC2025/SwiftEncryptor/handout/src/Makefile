CFLAGS=-Wall -Wextra
CC=gcc

all: main

main: thread interface decoder splitter encoder
	$(CC) $(CFLAGS) -o swift-encryptor main.c thread.o interface.o decoder.o splitter.o encryptor.o joiner.o encoder.o -lpthread

interface: thread
	$(CC) $(CFLAGS) -c interface.c

decoder: thread
	$(CC) $(CFLAGS) -c decoder.c

splitter: thread joiner encryptor
	$(CC) $(CFLAGS) -c splitter.c

encryptor: thread
	$(CC) $(CFLAGS) -c encryptor.c

joiner: thread
	$(CC) $(CFLAGS) -c joiner.c

encoder: thread
	$(CC) $(CFLAGS) -c encoder.c

thread:
	$(CC) $(CFLAGS) -c thread.c

clean:
	rm *.o swift-encryptor
