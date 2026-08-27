#include "database.h"
#include "common.h"
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>

sqlite3 *db = NULL;

void ensure_data_dir() {
    mkdir(DATA_DIR, 0700);
}

int init_db() {
    if (db) {
        return 1;
    }

    ensure_data_dir();

    char db_path[256];
    snprintf(db_path, sizeof(db_path), "%s/users.db", DATA_DIR);

    if (sqlite3_open(db_path, &db) != SQLITE_OK) {
        debug_printf("init_db: failed to open database: %s\n", sqlite3_errmsg(db));
        return 0;
    }

    const char *create_sql =
        "CREATE TABLE IF NOT EXISTS users ("
        "    username TEXT PRIMARY KEY,"
        "    is_vip INTEGER,"
        "    message TEXT,"
        "    created_at INTEGER"
        ");";

    char *errmsg = NULL;
    if (sqlite3_exec(db, create_sql, NULL, NULL, &errmsg) != SQLITE_OK) {
        debug_printf("init_db: failed to create table: %s\n", errmsg ? errmsg : "unknown");
        sqlite3_free(errmsg);
        sqlite3_close(db);
        db = NULL;
        return 0;
    }

    return 1;
}

void close_db() {
    if (db) {
        sqlite3_close(db);
        db = NULL;
    }
}

int save_user_data(const UserData *user) {
    if (!db && !init_db()) {
        return 0;
    }

    const char *sql =
        "INSERT INTO users (username, is_vip, message, created_at) "
        "VALUES (?1, ?2, ?3, ?4) "
        "ON CONFLICT(username) DO UPDATE SET "
        "is_vip=excluded.is_vip, "
        "message=excluded.message, "
        "created_at=excluded.created_at;";

    sqlite3_stmt *stmt = NULL;
    if (sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) != SQLITE_OK) {
        debug_printf("save_user_data: failed to prepare save statement: %s\n", sqlite3_errmsg(db));
        return 0;
    }

    sqlite3_bind_text(stmt, 1, user->username, -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(stmt, 2, user->is_vip);
    sqlite3_bind_text(stmt, 3, user->message, -1, SQLITE_TRANSIENT);
    sqlite3_bind_int64(stmt, 4, (sqlite3_int64)user->created_at);

    int ok = 1;
    if (sqlite3_step(stmt) != SQLITE_DONE) {
        debug_printf("save_user_data: failed to save user %s: %s\n", user->username, sqlite3_errmsg(db));
        ok = 0;
    }

    sqlite3_finalize(stmt);
    return ok;
}

int load_user_data(const char *username, UserData *user) {
    if (!db && !init_db()) {
        return 0;
    }

    const char *sql =
        "SELECT username, is_vip, IFNULL(message, ''), created_at "
        "FROM users WHERE username = ?1 LIMIT 1;";

    sqlite3_stmt *stmt = NULL;
    if (sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) != SQLITE_OK) {
        debug_printf("load_user_data: failed to prepare load statement: %s\n", sqlite3_errmsg(db));
        return 0;
    }

    sqlite3_bind_text(stmt, 1, username, -1, SQLITE_TRANSIENT);

    int rc = sqlite3_step(stmt);
    if (rc == SQLITE_ROW) {
        memset(user, 0, sizeof(UserData));
        const unsigned char *u = sqlite3_column_text(stmt, 0);
        int is_vip = sqlite3_column_int(stmt, 1);
        const unsigned char *msg = sqlite3_column_text(stmt, 2);
        sqlite3_int64 created = sqlite3_column_int64(stmt, 3);

        if (u) strncpy(user->username, (const char *)u, MAX_USERNAME_LEN);
        user->is_vip = (unsigned char)is_vip;
        if (msg) strncpy(user->message, (const char *)msg, MAX_MESSAGE_LEN);
        user->created_at = (time_t)created;

        sqlite3_finalize(stmt);
        return 1;
    }

    sqlite3_finalize(stmt);
    return 0;
}

void get_recent_users(unsigned char is_vip, char *output, size_t outlen) {
    const char *group_name = is_vip ? "beekeeping experts" : "simple hivers";

    if (!db && !init_db()) {
        snprintf(output, outlen, "Recent %s:\nDatabase error\n", group_name);
        return;
    }

    const char *sql =
        "SELECT username, created_at FROM users "
        "WHERE is_vip = ?1 ORDER BY created_at DESC LIMIT ?2;";

    sqlite3_stmt *stmt = NULL;
    if (sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) != SQLITE_OK) {
        snprintf(output, outlen, "Recent %s:\nDatabase error\n", group_name);
        return;
    }

    sqlite3_bind_int(stmt, 1, is_vip);
    sqlite3_bind_int(stmt, 2, RECENT_USERS_LIMIT);

    snprintf(output, outlen, "Recent %s:\n", group_name);

    int idx = 0;
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        const unsigned char *u = sqlite3_column_text(stmt, 0);
        sqlite3_int64 created = sqlite3_column_int64(stmt, 1);

        time_t created_at = (time_t)created;
        char time_buf[32];
        struct tm *tm_info = localtime(&created_at);
        if (tm_info) {
            strftime(time_buf, sizeof(time_buf), "%Y-%m-%d %H:%M:%S", tm_info);
        } else {
            snprintf(time_buf, sizeof(time_buf), "?");
        }

        char line[160];
        snprintf(line, sizeof(line), "%2d. %s (%s)\n", idx + 1, u ? (const char *)u : "?", time_buf);
        strncat(output, line, outlen - strlen(output) - 1);

        idx++;
    }

    if (idx == 0) {
        strncat(output, "No profiles yet\n", outlen - strlen(output) - 1);
    }

    sqlite3_finalize(stmt);
}

int seed_default_vip_users(void) {
    static const struct {
        const char *username;
        const char *message;
    } vip_users[] = {
        {
            "vipuser",
            "Flag is here: avito{XXXXXXXXXXXXXX}"  // ✂️ Redacted ✂️󠅗󠅟󠅟󠅔󠄐󠅚󠅟󠅒󠄜󠄐󠅤󠅑󠅛󠅕󠄐󠅩󠅟󠅥󠅢󠄐󠅘󠅙󠅔󠅔󠅕󠅞󠄐󠅖󠅜󠅑󠅗󠄪󠄐󠅘󠅤󠅤󠅠󠅣󠄪󠄟󠄟󠅪󠅑󠅜󠅕󠅤󠅑󠅩󠄝󠅖󠅛󠅢󠄥󠅛󠅢󠄣󠅝󠄞󠅑󠅦󠅙󠅤󠅟󠅓󠅤󠅖󠄞󠅢󠅥󠄟
        }
    };

    if (!init_db()) {
        return 0;
    }

    time_t now = time(NULL);
    size_t count = sizeof(vip_users) / sizeof(vip_users[0]);

    for (size_t i = 0; i < count; i++) {
        UserData user;
        memset(&user, 0, sizeof(user));

        if (load_user_data(vip_users[i].username, &user) && user.created_at == 0) {
            user.created_at = now;
        }

        strncpy(user.username, vip_users[i].username, MAX_USERNAME_LEN);
        user.username[MAX_USERNAME_LEN] = '\0';
        user.is_vip = 1;
        strncpy(user.message, vip_users[i].message, MAX_MESSAGE_LEN);
        user.message[MAX_MESSAGE_LEN] = '\0';
        if (user.created_at == 0) {
            user.created_at = now - (time_t)i;
        }

        if (!save_user_data(&user)) {
            return 0;
        }
    }

    return 1;
}
