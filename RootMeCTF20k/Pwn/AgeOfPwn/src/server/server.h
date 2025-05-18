#ifndef _SERVER_H
#define _SERVER_H

#include <stdint.h>
#include <time.h>
#define LOBBY_COUNT 0x100
#define LOBBY_BLANK -1
#define LOBBY_EVICTION_PERIOD 60

#define PING_INTERVAL 30

//needs to be adjusted
#define MAX_PACKET_SIZE 0x20

#define BASE_MAX_HEALTH 100
#define TICK_MONEY 500
#define INITIAL_MONEY 10000
#define UNIT_TYPE_COUNT 4
#define MAP_SIZE 15
#define TICK_DURATION 1
#define MAX_MONEY UINT32_MAX

#define TICK_UPDATE_MAX_SIZE 16 + 10*MAP_SIZE

typedef enum packet_type_t {
    ERROR                   = 0xff,

    BUY_UNIT                = 0x10,
    OPPO_BUY_UNIT           = 0x11,
    TICK_UPDATE             = 0x1f,

    VICTORY                 = 0x30,
    DEFEAT                  = 0x31,
    FORFEIT                 = 0x32,
    VICTORY_BY_FORFEIT      = 0x33,
    DEFEAT_BY_FORFEIT       = 0x34,
    DRAW                    = 0x35,
    GAME_START              = 0x3f,

    PING                    = 0x42,
} packet_type_t;

typedef enum game_status_t {
    RUNNING, P0_VICTORY, P1_VICTORY, P0_FORFEIT, P1_FORFEIT, STATUS_DRAW
} game_status_t;

typedef enum unit_type_t {
    NO_UNIT     = 0,
    SKULL       = 1,
    CAT         = 2,
    DOG         = 3,

} unit_type_t;

typedef struct lobby_entry_t
{
    int id;
    int client_fd;
    time_t created_at;
} lobby_entry_t;

typedef struct player_t
{
    uint32_t money;
    uint32_t health;
    int fd;
} player_t;

typedef struct unit_t
{
    uint32_t health;
    unit_type_t type;
    char canMove;
} unit_t;

uint32_t unitMaxHealth[UNIT_TYPE_COUNT]= {0, 30, 50, 80};
uint32_t unitPrice[UNIT_TYPE_COUNT] = {0, 1500, 10000, 50000};
uint32_t unitStrength[UNIT_TYPE_COUNT] = {0, 5, 10, 20};
uint32_t unitBounty[UNIT_TYPE_COUNT] = {0, 200, 3000, 20000};

#endif // _SERVER_H
