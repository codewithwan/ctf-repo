#include "utils.h"
#include "common.h"
#include "database.h"
#include <stdio.h>
#include <string.h>
#include <unistd.h>

static const char hex_chars[] = "0123456789abcdef";

int hex_encode(const unsigned char *in, size_t inlen, char *out, size_t outlen) {
    if (outlen < inlen * 2 + 1) {
        return 0;
    }
    
    for (size_t i = 0; i < inlen; i++) {
        out[i * 2] = hex_chars[(in[i] >> 4) & 0x0F];
        out[i * 2 + 1] = hex_chars[in[i] & 0x0F];
    }
    out[inlen * 2] = '\0';
    
    return (int)(inlen * 2);
}

int hex_decode(const char *in, size_t inlen, unsigned char *out, size_t outlen) {
    if (inlen == 0 || inlen % 2 != 0) return 0;
    
    size_t out_len = inlen / 2;
    if (outlen < out_len) {
        return 0;
    }
    
    for (size_t i = 0; i < out_len; i++) {
        unsigned char hi, lo;
        char c = in[i * 2];
        if (c >= '0' && c <= '9') hi = c - '0';
        else if (c >= 'a' && c <= 'f') hi = 10 + c - 'a';
        else if (c >= 'A' && c <= 'F') hi = 10 + c - 'A';
        else return 0;
        
        c = in[i * 2 + 1];
        if (c >= '0' && c <= '9') lo = c - '0';
        else if (c >= 'a' && c <= 'f') lo = 10 + c - 'a';
        else if (c >= 'A' && c <= 'F') lo = 10 + c - 'A';
        else return 0;
        
        out[i] = (hi << 4) | lo;
    }
    
    return (int)out_len;
}

int write_all(int sockfd, const char *str) {
    size_t size = strlen(str);
    size_t total_written = 0;
    while (total_written < size) {
        ssize_t written = write(sockfd, str + total_written, size - total_written);
        if (written <= 0) {
            return total_written;
        }
        total_written += written;
    }
    return total_written;
}

int read_line(int sockfd, char *buffer, size_t size) {
    if (!buffer || size == 0) {
        return -1;
    }

    size_t len = 0;
    int saw_newline = 0;

    while (len < size - 1) {
        char c;
        alarm(20);
        ssize_t n = read(sockfd, &c, 1);
        if (n <= 0) {
            if (len == 0) {
                return -1;
            }
            break;
        }
        buffer[len++] = c;
        if (c == '\n') {
            break;
        }
    }
    buffer[len] = '\0';

    while (len > 0 && (buffer[len - 1] == '\n' || buffer[len - 1] == '\r')) {
        saw_newline = 1;
        buffer[len - 1] = '\0';
        len--;
    }

    if (!saw_newline && len == size - 1) {
        char c;
        ssize_t n = read(sockfd, &c, 1);
        if (n <= 0 || c == '\n') {
            return len;
        }
        if (c == '\r') {
            n = read(sockfd, &c, 1);
            if (n <= 0 || c == '\n') {
                return len;
            }
        }
        while (n > 0 && c != '\n') {
            n = read(sockfd, &c, 1);
        }
        return -1;
    }

    return len;
}

void format_wall(char *out, size_t outlen, const char *username, const char *post, unsigned char is_vip) {
    const char *owner = (username && username[0]) ? username : "guest";
    const char *body = (post && post[0]) ? post : "No honey notes yet.";
    const char *badge = is_vip ? "beekeeping expert" : "simple hiver";
    const char *visibility = is_vip ? "expert notes" : "public notes";

    snprintf(out, outlen,
             "\n"
             "  .---------------------- NaPaseke ----------------------.\n"
             "  | @%-16s %-18s %-12s |\n"
             "  '------------------------------------------------------'\n"
             "  honey note: %s\n"
             "\n",
             owner, badge, visibility, body);
}

void print_banner_and_menu(int sockfd, Session *session) {
    char banner[4096];
    int pos = 0;

    pos += snprintf(banner + pos, sizeof(banner) - pos,
        "\n"
        "  .---------------------- NaPaseke ----------------------.\n"
        "  '------------------------------------------------------'\n");

    if (session && session->logged_in) {
        pos += snprintf(banner + pos, sizeof(banner) - pos,
            "Sweet day, %s.\n\n", session->user.username);
    } else {
        pos += snprintf(banner + pos, sizeof(banner) - pos,
            "Sweet day, guest.\n\n");
    }
    
    pos += snprintf(banner + pos, sizeof(banner) - pos,
        "Menu: T list users | V list beekeeping experts | ");
    
    if (session && session->logged_in) {
        pos += snprintf(banner + pos, sizeof(banner) - pos,
            "L logout\n");
    } else {
        pos += snprintf(banner + pos, sizeof(banner) - pos,
            "L login\n");
    }
    
    pos += snprintf(banner + pos, sizeof(banner) - pos,
        "      R register | P read | U write | K server pub key | Q quit\n"
        "\n"
        "Enter your choice: ");

    write_all(sockfd, banner);
}
