CC = gcc
CFLAGS = -Wall -Wextra -O2 -pthread
LDFLAGS = -lpthread -lssl -lcrypto -lsqlite3
XMSS_SRCS = xmss-md5/hash_address.c \
            xmss-md5/hash.c \
            xmss-md5/params.c \
            xmss-md5/randombytes.c \
            xmss-md5/utils.c \
            xmss-md5/wots.c \
            xmss-md5/xmss_commons.c \
            xmss-md5/xmss_core_fast.c

XMSS_OBJS = $(XMSS_SRCS:.c=.o)
SERVER_SRCS = server.c utils.c database.c auth.c commands.c xmss_keys.c
SERVER_OBJS = $(SERVER_SRCS:.c=.o)
SERVER_BIN = napaseke

INCLUDES = -I./xmss-md5

all: $(SERVER_BIN)

$(SERVER_BIN): $(SERVER_OBJS) $(XMSS_OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
	@echo "Build successful: $(SERVER_BIN)"

%.o: %.c
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

$(XMSS_OBJS): %.o: %.c
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

clean:
	rm -f $(SERVER_OBJS) $(XMSS_OBJS) $(SERVER_BIN)
	rm -rf data/

run: $(SERVER_BIN)
	./$(SERVER_BIN)

# Debug build
debug: CFLAGS += -g -DENABLE_DEBUG
debug: clean all

.PHONY: all clean run debug
