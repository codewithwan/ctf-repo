#ifndef COMMANDS_H
#define COMMANDS_H

#include "common.h"

void list_trial(int sockfd);
void list_vip(int sockfd);
void login(int sockfd, Session *session);
void logout(int sockfd, Session *session);
void register_user(int sockfd);
void peek(int sockfd, Session *session);
void update_message(int sockfd, Session *session);
void show_public_key(int sockfd);

#endif // COMMANDS_H
