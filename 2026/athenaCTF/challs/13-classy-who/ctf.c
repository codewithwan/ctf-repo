#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <stdint.h>

#define MAX_NOTES 16

struct note {
    char *data;
    size_t size;
};

struct note *notes[MAX_NOTES];
size_t flag_len;

void load_flag(char *buf, size_t max_len) {
    FILE *fp = fopen("/opt/chal/flag.txt", "rb");
    if (!fp) {
        fp = fopen("flag.txt", "rb");
    }
    if (!fp) {
        strncpy(buf, "FLAG_NOT_LOADED", max_len - 1);
        buf[max_len - 1] = '\0';
        flag_len = strlen(buf);
        return;
    }

    size_t n = fread(buf, 1, max_len - 1, fp);
    fclose(fp);
    buf[n] = '\0';

    while (n > 0 && (buf[n - 1] == '\n' || buf[n - 1] == '\r')) {
        buf[n - 1] = '\0';
        n--;
    }
    flag_len = n;
    if (flag_len == 0) {
        strncpy(buf, "athena{empty_flag}", max_len - 1);
        buf[max_len - 1] = '\0';
        flag_len = strlen(buf);
    }
}

ssize_t readn(int fd, void *buf, size_t n) {
    size_t r = 0;
    while (r < n) {
        ssize_t s = read(fd, (char*)buf + r, n - r);
        if (s <= 0) return s;
        r += s;
    }
    return r;
}

void create_note(int idx, size_t size) {
    if (idx < 0 || idx >= MAX_NOTES) {
        puts("Invalid index");
        return;
    }
    if (size == 0 || size > 0x10000) {
        puts("Invalid size");
        return;
    }
    if (notes[idx] != NULL) {
        puts("Note already exists at that index");
        return;
    }
    notes[idx] = malloc(sizeof(struct note));
    if (!notes[idx]) {
        puts("Allocation failed");
        exit(1);
    }
    notes[idx]->data = malloc(size);
    if (!notes[idx]->data) {
        puts("Allocation failed");
        exit(1);
    }
    notes[idx]->size = size;
    puts("Created");
}

void write_note(int idx, size_t off, size_t len) {
    if (idx < 0 || idx >= MAX_NOTES) {
        puts("Invalid index");
        return;
    }
    if (notes[idx] == NULL) {
        puts("No note at that index");
        return;
    }
    if (len > 0x100000) { puts("Too big"); return; }
    char *buf = malloc(len+1);
    if (!buf) { puts("alloc fail"); return; }
    
    ssize_t r = readn(0, buf, len);
    if (r <= 0) { free(buf); puts("Read error"); return; }
    
    // Vulnerability: no bounds check on offset+len
    memcpy(notes[idx]->data + off, buf, len);
    free(buf);
    puts("Wrote");
}

void read_note(int idx) {
    if (idx < 0 || idx >= MAX_NOTES) {
        puts("Invalid index");
        return;
    }
    if (notes[idx] == NULL) {
        puts("No note at that index");
        return;
    }
    if (notes[idx]->data == NULL) {
        puts("No note data");
        return;
    }
    size_t to_print = notes[idx]->size;
    if (to_print > 1024) to_print = 1024;
    write(1, notes[idx]->data, to_print);
    write(1, "\n", 1);
}

void delete_note(int idx) {
    if (idx < 0 || idx >= MAX_NOTES) {
        puts("Invalid index");
        return;
    }
    if (notes[idx] == NULL) {
        puts("Already deleted");
        return;
    }
    free(notes[idx]->data);
    free(notes[idx]);
    // Vulnerability: Dangling pointer is NOT nullified.
    // notes[idx] remains pointing to the freed memory.
    puts("Deleted");
}

int main() {
    setvbuf(stdout, NULL, _IONBF, 0);
    setvbuf(stdin, NULL, _IONBF, 0);
    
    for (int i = 0; i < MAX_NOTES; i++) {
        notes[i] = NULL;
    }
    
    char local_flag[256];
    memset(local_flag, 0, sizeof(local_flag));
    load_flag(local_flag, sizeof(local_flag));
    
    char line[256];
    puts("RC's note service");
    while (1) {
        write(1, "Give me your command:\n", 22);
        if (!fgets(line, sizeof(line), stdin)) break;
        char cmd = 0; int idx = 0; size_t a = 0, b = 0;
        if (sscanf(line, " %c %d %zu %zu", &cmd, &idx, &a, &b) < 1) continue;
        if (cmd == 'C') {
            create_note(idx, a);
        } else if (cmd == 'W') {
            write_note(idx, a, b);
        } else if (cmd == 'R') {
            read_note(idx);
        } else if (cmd == 'D') {
            delete_note(idx);
        } else if (cmd == 'E') {
            puts("Bye");
            break;
        } else {
            puts("Unknown");
        }
    }
    return 0;
}
