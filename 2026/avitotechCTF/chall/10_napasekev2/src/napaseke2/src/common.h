#ifndef COMMON_H
#define COMMON_H

#include <stdint.h>
#include <time.h>
#include "xmss_keys.h"

#define PORT 32012
#define DATA_DIR "data"
#define MAX_USERNAME_LEN 16
#define MAX_MESSAGE_LEN 256
#define RECENT_USERS_LIMIT 10
#define MAX_AUTH_TOKEN_HEX_LEN (2 * (XMSS_SIG_SIZE + MAX_USERNAME_LEN))

#ifdef ENABLE_DEBUG
#define debug_printf(...) printf(__VA_ARGS__)
#else
#define debug_printf(...)
#endif

typedef struct {
    char username[MAX_USERNAME_LEN + 1];
    unsigned char is_vip;
    char message[MAX_MESSAGE_LEN + 1];
    time_t created_at;
} UserData;

typedef struct {
    unsigned char signature[XMSS_SIG_SIZE+MAX_USERNAME_LEN];
    unsigned int sig_len;
} AuthToken;

typedef struct {
    int logged_in;
    UserData user;
} Session;

#endif // COMMON_H
