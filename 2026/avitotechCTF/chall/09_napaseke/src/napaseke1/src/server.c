#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <signal.h>

#include "common.h"
#include "utils.h"
#include "database.h"
#include "commands.h"
#include "xmss_keys.h"

static volatile sig_atomic_t shutdown_requested = 0;
static int server_fd = -1;

static void handle_shutdown_signal(int sig) {
    (void)sig;
    shutdown_requested = 1;
    if (server_fd >= 0) {
        close(server_fd);
        server_fd = -1;
    }
}

static void configure_process_group(void) {
    if (setpgid(0, 0) != 0 && getpgrp() != getpid()) {
        perror("setpgid");
        exit(EXIT_FAILURE);
    }
}

void handle_client(int sockfd) {
    char invite_code[25];
    Session session;
    memset(&session, 0, sizeof(session));
    session.logged_in = 0;

    write_all(sockfd, "Invite code: ");
    int invite_len = read_line(sockfd, invite_code, sizeof(invite_code));
    const char *expected_invite_code = getenv("INVITE_CODE");
    if (invite_len < 0 || expected_invite_code == NULL ||
        strcmp(invite_code, expected_invite_code) != 0) {
        write_all(sockfd, "Invalid invite code\n");
        return;
    }

    if (!init_db()) {
        write_all(sockfd, "Server database error\n");
        return;
    }

    print_banner_and_menu(sockfd, &session);

    char line_buffer[1024];

    while (1) {
        int line_len = read_line(sockfd, line_buffer, sizeof(line_buffer));
        if (line_len < 0) {
            break;
        }

        if (strlen(line_buffer) == 0) {
            continue;
        }

        char command = line_buffer[0];
        if (command >= 'a' && command <= 'z') {
            command = command - 'a' + 'A';
        }

        switch (command) {
            case 'T':
                list_trial(sockfd);
                break;
            case 'V':
                list_vip(sockfd);
                break;
            case 'L':
                if (session.logged_in) {
                    logout(sockfd, &session);
                } else {
                    login(sockfd, &session);
                }
                break;
            case 'R':
                register_user(sockfd);
                break;
            case 'P':
                peek(sockfd, &session);
                break;
            case 'U':
                update_message(sockfd, &session);
                break;
            case 'K':
                show_public_key(sockfd);
                break;
            case 'Q':
                write_all(sockfd, "Goodbye!\n");
                goto cleanup;
            default:
                write_all(sockfd, "Invalid command\n");
                break;
        }

        if (command != 'Q') {
            print_banner_and_menu(sockfd, &session);
        }
    }

cleanup:
    close_db();
}

int main() {
    setvbuf(stdout, NULL, _IONBF, 0);
    setvbuf(stderr, NULL, _IONBF, 0);
    configure_process_group();

    int client_fd;
    struct sockaddr_in address;
    int addrlen = sizeof(address);
    
    ensure_data_dir();

    printf("Initializing XMSS keys...\n");
    if (xmssmt_keys_init() != 0) {
        fprintf(stderr, "Failed to initialize XMSS keys\n");
        exit(EXIT_FAILURE);
    }
    printf("XMSS keys ready\n");

    if (!seed_default_vip_users()) {
        fprintf(stderr, "Failed to seed default beekeeping experts\n");
        exit(EXIT_FAILURE);
    }
    close_db();

    if ((server_fd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
        perror("socket failed");
        exit(EXIT_FAILURE);
    }

    int opt = 1;
    if (setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt)) < 0) {
        perror("setsockopt");
        exit(EXIT_FAILURE);
    }

    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    address.sin_port = htons(PORT);

    if (bind(server_fd, (struct sockaddr *)&address, sizeof(address)) < 0) {
        perror("bind failed");
        exit(EXIT_FAILURE);
    }

    if (listen(server_fd, 3) < 0) {
        perror("listen");
        exit(EXIT_FAILURE);
    }

    printf("Server started on port %d\n", PORT);
    
    signal(SIGCHLD, SIG_IGN);
    signal(SIGTERM, handle_shutdown_signal);
    signal(SIGINT, handle_shutdown_signal);

    while (!shutdown_requested) {
        if ((client_fd = accept(server_fd, (struct sockaddr *)&address, (socklen_t*)&addrlen)) < 0) {
            if (shutdown_requested) {
                break;
            }
            perror("accept");
            continue;
        }

        debug_printf("main: accepted new connection from %s:%d\n", inet_ntoa(address.sin_addr), ntohs(address.sin_port));

        pid_t pid = fork();
        if (pid < 0) {
            perror("fork");
            close(client_fd);
            continue;
        }

        if (pid == 0) {
            close(server_fd);
            handle_client(client_fd);
            exit(0);
        } else {
            close(client_fd);
        }
    }

    if (server_fd >= 0) {
        close(server_fd);
    }

    return 0;
}
