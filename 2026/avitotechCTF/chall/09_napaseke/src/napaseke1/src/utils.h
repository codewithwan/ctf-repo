#ifndef UTILS_H
#define UTILS_H

#include <stddef.h>
#include "common.h"

int hex_encode(const unsigned char *in, size_t inlen, char *out, size_t outlen);
int hex_decode(const char *in, size_t inlen, unsigned char *out, size_t outlen);

int write_all(int sockfd, const char *str);
int read_line(int sockfd, char *buffer, size_t size);
void format_wall(char *out, size_t outlen, const char *username, const char *post, unsigned char is_vip);
void print_banner_and_menu(int sockfd, Session *session);

#endif // UTILS_H
