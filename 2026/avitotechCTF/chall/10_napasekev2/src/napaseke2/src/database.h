#ifndef DATABASE_H
#define DATABASE_H

#include "common.h"
#include <sqlite3.h>

extern sqlite3 *db;

void ensure_data_dir();
int init_db();
void close_db();
int save_user_data(const UserData *user);
int load_user_data(const char *username, UserData *user);
void get_recent_users(unsigned char is_vip, char *output, size_t outlen);
int seed_default_vip_users(void);

#endif // DATABASE_H
