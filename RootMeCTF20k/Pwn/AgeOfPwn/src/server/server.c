#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <stdint.h>
#include <pthread.h>
#include <sys/prctl.h>
#include <sys/wait.h>
#include <signal.h>

#include "server.h"

#ifndef DEBUG
#define DEBUG 0
#endif

lobby_entry_t lobbies[LOBBY_COUNT];

//on both map, spawn is at zero, and fight handled by symmetry
unit_t unit_map[2][MAP_SIZE];
player_t players[2];

time_t last_ping[2];

pthread_t threads[2];
pthread_mutex_t lock;

char tick_update_packet[TICK_UPDATE_MAX_SIZE];

game_status_t status = RUNNING;

//used for the LFSR
uint16_t randstate;

int randbit() {
    uint16_t bit;
    bit = (uint32_t)(((randstate >> 0) ^ (randstate >> 2) ^ (randstate >> 3) ^ (randstate >> 5)) & 1);
    randstate = (uint32_t)((randstate >> 1) | (bit << 15));
    return randstate & 1;
}

void print_state() {
    printf("p0: %uhp, %u$\tp1: %uhp, %u$\n", players[0].health, players[0].money, players[1].health, players[1].money);
    printf("|");
    for (int i = 0; i < MAP_SIZE; i++) {
        printf("%d%d|", unit_map[0][i].type, unit_map[1][MAP_SIZE - 1 -i].type);
    }
    puts("");
}

/**
 * This function is always called on packet of controlled size, so should be fine
*/
void send_packet(int fd, packet_type_t packet_type, void *data) {
    char buf[MAX_PACKET_SIZE];
    uint16_t size;
    switch (packet_type)
    {
    case OPPO_BUY_UNIT:
        size = 4;
        ((uint16_t *) buf)[2] = *(unit_type_t *)data;
        break;
    default: //packet with no data, just type
        size = 2;
        break;
    }
    *(uint32_t *)buf = (packet_type << 16) | size;
    write(fd, buf, size + 2);
}

/**
 * Here is the vuln function btw
*/
packet_type_t recv_packet(int fd, void *data) {
    char buf[MAX_PACKET_SIZE];
    uint16_t type;
    uint16_t size;
    if (read(fd, &size, sizeof(size)) != sizeof(size)) {
        return ERROR;
    }
    if (read(fd, buf, size) != size) {
        return ERROR;
    }
    type = *(uint16_t *)buf;
    if (type == BUY_UNIT) {
        *(unit_type_t *)data = ((uint16_t *) buf)[1];
    }
    return type;
}

void *threadFun(void *vargp) {
    int my_id = *(int *)vargp;
    int other_id = !my_id;
    int my_fd, other_fd;
    //should only receive a short afaik
    int packet_data;
    packet_type_t packet_type;
    my_fd = players[my_id].fd;
    other_fd = players[other_id].fd;
    char useless_buf[0x100]; //give some space to rop, because the thread stack is not big
    useless_buf[0] = 0;
    printf(useless_buf);
    while (1)
    {
        packet_type = recv_packet(my_fd, &packet_data);
        switch (packet_type)
        {
        case BUY_UNIT:
            unit_type_t unit_type = packet_data;
            if (unit_type >= UNIT_TYPE_COUNT || unit_type < 0 || unit_type == NO_UNIT) {
                break;
            }
            if (players[my_id].money >= unitPrice[unit_type]) {
                int unit_created = 0;
                pthread_mutex_lock(&lock);
                if (unit_map[my_id][0].type == NO_UNIT) {
                    unit_map[my_id][0].type = unit_type;
                    unit_map[my_id][0].canMove = 0;
                    unit_map[my_id][0].health = unitMaxHealth[unit_type];
                    players[my_id].money -= unitPrice[unit_type];
                    unit_created = 1;
                }
                pthread_mutex_unlock(&lock);
                //should this be in the mutex protected section?
                if (unit_created) {
                    send_packet(other_fd, OPPO_BUY_UNIT, &packet_data);
                }
            }
            break;
        case PING:
            pthread_mutex_lock(&lock);
            last_ping[my_id] = time(NULL);
            pthread_mutex_unlock(&lock);
            break;
        case FORFEIT:
            pthread_mutex_lock(&lock);
            if (!status) {
                if (my_id) {
                    status = P1_FORFEIT;
                }
                else {
                    status = P0_FORFEIT;
                }
            }
            pthread_mutex_unlock(&lock);
            break;
        default:
            break;
        }
    }
    return NULL;
}

int takeDamage(uint32_t *health, uint32_t strength) {
    if (strength >= *health) {
        *health = 0;
        return 1;
    }
    else {
        *health -= strength;
        return 0;
    }
}

void giveMoney(int p, uint32_t amount) {
    if (amount >= (MAX_MONEY - players[p].money)) {
        players[p].money = MAX_MONEY;
    }
    else {
        players[p].money += amount;
    }
}

void handleMovements() {
    int progress[2] = {MAP_SIZE - 2, MAP_SIZE - 2};
    int nmove;
    int moved;
    unit_t *cur, *next;
    while (progress[0] >= 0 || progress[1] >= 0) {
        nmove = randbit();
        if (progress[nmove] < 0) {
            continue;
        }
        moved = 0;
        while (!moved) {
            cur = &(unit_map[nmove][progress[nmove]]);
            next = &(unit_map[nmove][progress[nmove] + 1]);
            if (
            cur->type != NO_UNIT                      //there is a unit on this tile
            && cur->canMove                           //it can move
            && next->type == NO_UNIT                 //the next tile is free
            && unit_map[!nmove][MAP_SIZE - 1 - progress[nmove]].type == NO_UNIT   //there is no opponent on this tile
            ) {
                next->type = cur->type;
                cur->type = NO_UNIT;
                next->health = cur->health;
                next->canMove = 0;
                moved = 1;
            }
            if (--progress[nmove] < 0) {
                moved =1;
            }
        }

    }
}

void handleFights() {
    int progress[2] = {MAP_SIZE - 1, MAP_SIZE - 1};
    int nmove;
    int moved;
    unit_t *cur, *oppo;
    unit_type_t cur_type, oppo_type;
    while (progress[0] >= 0 || progress[1] >= 0) {
        nmove = randbit();
        if (progress[nmove] < 0) {
            continue;
        }
        moved = 0;
        while (!moved) {
            cur = &(unit_map[nmove][progress[nmove]]);
            oppo = &(unit_map[!nmove][MAP_SIZE - 1 - progress[nmove]]);
            cur_type = cur->type;
            oppo_type = oppo->type;
            if (
            cur_type != NO_UNIT                      //there is a unit on this tile
            && cur->canMove                           //it can move
            && oppo_type != NO_UNIT                 //there is an opponent on this tile
            ) {
                //both hit at the same time
                cur->canMove = 0;
                if (takeDamage(&(cur->health), unitStrength[oppo_type])) {
                    cur->type = NO_UNIT;
                    giveMoney(!nmove, unitBounty[cur_type]);
                }
                if (takeDamage(&(oppo->health), unitStrength[cur_type])) {
                    oppo->type = NO_UNIT;
                    giveMoney(nmove, unitBounty[oppo_type]);
                }
                moved = 1;
            }
            if (--progress[nmove] < 0) {
                moved =1;
            }
        }

    }
}

void hitBase(int p) {
    unit_t *front = &(unit_map[p][MAP_SIZE-1]);
    if (front->type != NO_UNIT && front->canMove) {
        front->canMove = 0;
        if (takeDamage(&(players[!p].health), unitStrength[front->type])) {
            if (!status) {
                if (p) {
                    status = P1_VICTORY;
                }
                else {
                    status = P0_VICTORY;
                }
            }
        }
    }
}

void restore(int p) {
    for (int i = 0; i < MAP_SIZE; i++) {
        unit_map[p][i].canMove = 1;
    }
}

void salary(int p) {
    giveMoney(p, TICK_MONEY);
}

void prepare_tick_update() {
    memset(tick_update_packet, 0, sizeof(tick_update_packet));
    char *cursor = tick_update_packet;
    cursor += 2;
    *((uint16_t *) cursor) = TICK_UPDATE;
    cursor += 2;
    unit_t *unit;
    for (int p = 0; p < 2; p++) {
        *((uint32_t *)cursor) = players[p].money;
        cursor += 4;
        *((uint32_t *)cursor) = players[p].health;
        cursor += 4;
    }
    for (int p = 0; p <2; p++) {
        for (int i =0; i < MAP_SIZE; i++) {
            unit = &(unit_map[p][i]);
            *cursor = unit->type;
            cursor++;
            if (unit->type != NO_UNIT ) {
                *((uint32_t *) cursor) = unit->health;
                cursor += 4;
            }
        }
    }
    *((uint16_t *) tick_update_packet) = cursor - tick_update_packet - 2;
}

void game(int fd0, int fd1) {
    int id0 = 0;
    int id1 = 1;
    time_t now;
    memset(players, 0, sizeof(players));
    memset(unit_map, 0, sizeof(unit_map));
    players[0].health = BASE_MAX_HEALTH;
    players[0].money = INITIAL_MONEY;
    players[0].fd = fd0;
    players[1].health = BASE_MAX_HEALTH;
    players[1].money = INITIAL_MONEY;
    players[1].fd = fd1;

    now  = time(NULL);
    last_ping[0] = last_ping[1] = now;

    pthread_create(threads, NULL, threadFun, &id0);
    pthread_create(threads + 1, NULL, threadFun, &id1);
    send_packet(fd0, GAME_START, NULL);
    send_packet(fd1, GAME_START, NULL);

    while (1) {
        //Probably a better way to that, maybe with time() and checking
        sleep(TICK_DURATION);
        now = time(NULL);
        pthread_mutex_lock(&lock);
        //check ping
        if (!status) {
            if (last_ping[0] == last_ping[1]) {
                if (last_ping[0] + PING_INTERVAL < now) {
                    status = STATUS_DRAW;
                }
            }
            else if (last_ping[0] < last_ping[1]) {
                if (last_ping[0] + PING_INTERVAL < now) {
                    status = P0_FORFEIT;
                }
            }
            else {
                if (last_ping[1] + PING_INTERVAL < now) {
                    status = P1_FORFEIT;
                }
            }
        }
        if (status) { //check for forfeit messages
            pthread_mutex_unlock(&lock);
            break;
        }
        handleMovements();
        handleFights();
        //order of these do not matter, because only one base can be attacked at a time
        hitBase(0);
        hitBase(1);
        if (status) { //check for win
            pthread_mutex_unlock(&lock);
            break;
        }
        restore(0);
        restore(1);
        salary(0);
        salary(1);
        if (DEBUG) {
            print_state();
        }
        prepare_tick_update();
        pthread_mutex_unlock(&lock);
        write(fd0, tick_update_packet, *((uint16_t *) tick_update_packet) + 2);
        write(fd1, tick_update_packet, *((uint16_t *) tick_update_packet) + 2);
    }
    //status should not be modified once we reached this point
    switch (status)
    {
    case P0_VICTORY:
        if (DEBUG) puts("p0 wins!");
        send_packet(fd0, VICTORY, NULL);
        send_packet(fd1, DEFEAT, NULL);
        break;
    case P1_VICTORY:
        if (DEBUG) puts("p1 wins!");
        send_packet(fd0, DEFEAT, NULL);
        send_packet(fd1, VICTORY, NULL);
        break;
    case P0_FORFEIT:
        if (DEBUG) puts("p0 forfeits, p1 wins!");
        send_packet(fd0, DEFEAT_BY_FORFEIT, NULL);
        send_packet(fd1, VICTORY_BY_FORFEIT, NULL);
        break;
    case P1_FORFEIT:
        if (DEBUG) puts("p1 forfeits, p0 wins!");
        send_packet(fd0, VICTORY_BY_FORFEIT, NULL);
        send_packet(fd1, DEFEAT_BY_FORFEIT, NULL);
        break;
    case STATUS_DRAW:
        if (DEBUG) puts("draw!");
        send_packet(fd0, DRAW, NULL);
        send_packet(fd1, DRAW, NULL);
        break;
    default:
        if (DEBUG) fprintf(stderr, "Unexpected game result: %d\n", status);
        break;
    }
    //exit is done in the calling function

}

int main(int argc, char const *argv[])
{
    int server_fd, client_fd, rand_fd;
    unsigned int seed;
    struct sockaddr_in address;
    socklen_t addrlen = sizeof(address);
    int opt = 1;
    unsigned long port;
    int lobby_id;
    int idx;
    int len_read;
    pid_t pid;
    time_t now;
    
    rand_fd = open("/dev/urandom", O_RDONLY);
    read(rand_fd, &seed, sizeof(seed));
    close(rand_fd);
    srand(seed);

    for (int i = 0; i < LOBBY_COUNT; i++) {
        lobbies[i].id = LOBBY_BLANK;
    }

    if (signal(SIGCHLD, SIG_IGN) == SIG_ERR) {
        perror("Error ignoring SIGCHLD");
        exit(EXIT_FAILURE);
    }
    //make sure child dies if parent is killed
    prctl(PR_SET_PDEATHSIG, SIGKILL);

    if (argc != 2) {
        fprintf(stderr, "Usage: %s <port>\n", argv[0]);
        exit(EXIT_FAILURE);
    }
    if (!strcmp(argv[1], "Rotterdam")) {
        perror("Not this kind of port");
        exit(EXIT_FAILURE);
    }
    port = strtoul(argv[1], NULL, 10);
    if (port > 0xffff) {
        fprintf(stderr, "Port number too high: %s\n", argv[1]);
        exit(EXIT_FAILURE);
    }

    //copied more or less from https://www.geeksforgeeks.org/socket-programming-cc/
     // Creating socket file descriptor
    if ((server_fd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
        perror("socket failed");
        exit(EXIT_FAILURE);
    }
 
    // setsockopt stuff
    if (setsockopt(server_fd, SOL_SOCKET,
                   SO_REUSEADDR, &opt,
                   sizeof(opt))) {
        perror("setsockopt failed");
        exit(EXIT_FAILURE);
    }
    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    address.sin_port = htons(port);
 
    // Forcefully attaching socket to the port
    if (bind(server_fd, (struct sockaddr*)&address,
             sizeof(address))
        < 0) {
        perror("bind failed");
        exit(EXIT_FAILURE);
    }
    if (listen(server_fd, 3) < 0) {
        perror("listen failed");
        exit(EXIT_FAILURE);
    }

    while (1) {
        client_fd = accept(server_fd, (struct sockaddr*)&address, &addrlen);
        if (client_fd < 0) {
            perror("accept failed");
            exit(EXIT_FAILURE);
        }

        len_read = read(client_fd, &lobby_id, sizeof(lobby_id));
        if (len_read != sizeof(lobby_id)) {
            close(client_fd);
            continue;
        }
        if (DEBUG) printf("Client with lobby id %d\n", lobby_id);
        idx = 0;
        while (idx != LOBBY_COUNT && lobbies[idx].id != lobby_id) {
            idx++;
        }
        
        if (idx == LOBBY_COUNT) {
            //requested new lobby, but none available
            if (lobby_id == LOBBY_BLANK) {
                now = time(NULL);
                idx = 0;
                //try to evict an old lobby
                for (int i = 0; i < LOBBY_COUNT; i++) {
                    if (lobbies[i].created_at + LOBBY_EVICTION_PERIOD < now) {
                        if (DEBUG) printf("Evicting lobby %d\n", lobbies[i].id);
                        lobbies[i].id = LOBBY_BLANK;
                        write(lobbies[i].client_fd, &lobby_id, sizeof(lobby_id));
                        close(lobbies[i].client_fd);
                        idx = i;
                        break;
                    }
                }
                if (idx == 0) {
                    if (DEBUG) puts("Requested lobby creation, but no spot available");
                    write(client_fd, &lobby_id, sizeof(lobby_id));
                    close(client_fd);
                    continue;
                }

            }
            //requested inexistent lobby
            else {
                if (DEBUG) printf("The requested lobby %d does not exist\n", lobby_id);
                lobby_id = LOBBY_BLANK;
                write(client_fd, &lobby_id, sizeof(lobby_id));
                close(client_fd);
                continue;
            }
        }

        //create new lobby
        if (lobby_id == LOBBY_BLANK) {
            while (lobby_id == LOBBY_BLANK) {
                lobby_id = rand();
            }
            lobbies[idx].id = lobby_id;
            lobbies[idx].client_fd = client_fd;
            lobbies[idx].created_at = time(NULL);
            write(client_fd, &lobby_id, sizeof(lobby_id));
        }
        //join a lobby, start the game
        else {
            lobbies[idx].id = LOBBY_BLANK;
            //seed the PRNG for turn moves
            randstate = lobby_id & 0xffff;
            //send both lobbies a confirmation
            write(client_fd, &lobby_id, sizeof(lobby_id));
            write(lobbies[idx].client_fd, &lobby_id, sizeof(lobby_id));
            pid = fork();
            //https://stackoverflow.com/questions/17015830/how-can-i-prevent-zombie-child-processes
            if (pid < 0) {
                perror("fork");
                exit(EXIT_FAILURE);
            }
            if (pid) {
                if (DEBUG) printf("Started game with pid %d\n", pid);
                //close the parent copy of the file descriptors
                close(lobbies[idx].client_fd);
                close(client_fd);
            }
            else {
                game(lobbies[idx].client_fd, client_fd);
                close(lobbies[idx].client_fd);
                close(client_fd);
                exit(EXIT_SUCCESS);
            }
            
        }

    }

    return 0;
}
