#include "auth.h"
#include "utils.h"
#include "common.h"
#include <string.h>
#include <stdio.h>

int create_auth_token(const unsigned char *signature, 
                       unsigned int sig_len, char *token_hex, size_t token_size) {
    return hex_encode(signature, sig_len, token_hex, token_size) > 0;
}

int parse_auth_token(const char *token_hex, AuthToken *token) {
    size_t hex_len = strlen(token_hex);

    if (hex_len < 2 * (XMSS_SIG_SIZE + 1) ||
        hex_len > 2 * (XMSS_SIG_SIZE + MAX_USERNAME_LEN) ||
        hex_len % 2 != 0) {
        debug_printf("parse_auth_token: bad token length\n");
        return 0;
    }
    
    int data_len = hex_decode(token_hex, hex_len, token->signature, sizeof(token->signature));
    
    if (data_len < XMSS_SIG_SIZE + 1 ||
        data_len > XMSS_SIG_SIZE + MAX_USERNAME_LEN) {
        debug_printf("parse_auth_token: hex_decode failed\n");
        return 0;
    }
    
    token->sig_len = data_len;
    return 1;
}
