#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

int game() {
    char adversary_buf[100];
    char player_buf[100];
    char *end;
    unsigned long player_volume, adversary_volume;
    memset(adversary_buf, 0, sizeof(adversary_buf));
    memset(player_buf, 0, sizeof(player_buf));
    
    puts("Shout as hard as you can:");
    if (!fgets(player_buf, 100, stdin)) {
        puts("What's wrong with you?");
        return 1;
    }
    if (player_buf[0] != 'A') {
        puts("I said \"shout\", not \"talk gibberish\"");
        return 1;
    }
    puts("Not bad! My turn now:");
    strcpy(adversary_buf, player_buf);
    strncat(adversary_buf, player_buf, 0x100);
    puts(adversary_buf);

    adversary_volume = strlen(adversary_buf);
    if (adversary_buf[adversary_volume - 1] == '\n') {
        adversary_buf[--adversary_volume] = 0;
    }
    player_volume = strlen(player_buf);
    if (player_buf[player_volume - 1] == '\n') {
        player_buf[--player_volume] = 0;
    }
    printf("I did %lu dB and you did %lu dB\n", adversary_volume, player_volume);
    if (adversary_volume > player_volume) {
        puts("Haha, you loose, I am the best!");
    }
    else if (adversary_volume == player_volume) {
        puts("Draw! Finally a worthy opponent.");
    }
    else{
        puts("You win! How can you shoot so loud!!!???");
        puts("Here's your reward: ");
        puts(getenv("FLAG"));
    }

    return 0;
}

int main() {
    //usual set up: input and output are unbuffered, timeout of 2minutes
    setvbuf(stdout, NULL, _IONBF, 0);
    setvbuf(stdin, NULL, _IONBF, 0);
    alarm(120);

    puts("Welcome to Root-Me's official shouting contest!");
    if (game()) {
        puts("The game did not go as expected...");
        return 1;
    }
    return 0;
}