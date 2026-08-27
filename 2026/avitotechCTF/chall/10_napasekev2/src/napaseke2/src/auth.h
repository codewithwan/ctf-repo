#ifndef AUTH_H
#define AUTH_H

#include "common.h"

int create_auth_token(const unsigned char *signature, 
                       unsigned int sig_len, char *token_hex, size_t token_size);
int parse_auth_token(const char *token_hex, AuthToken *token);

#endif // AUTH_H
