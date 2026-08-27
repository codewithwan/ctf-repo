#include "xmss_keys.h"
#include "utils.h"
#include "common.h"
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <stdint.h>
#include <unistd.h>

typedef struct {
    unsigned char xmss_pk[XMSS_PK_SIZE];
    unsigned char xmss_sk[XMSS_SK_SIZE];
    xmss_params xmss_params;
    pid_t process_group_id;
} xmss_shared_state;

static xmss_shared_state *g_xmss_state = NULL;

static unsigned long long signing_key_index(const xmss_params *params,
                                            const unsigned char *sk) {
    unsigned long long idx = 0;

    for (unsigned int i = 0; i < params->index_bytes; i++) {
        idx |= ((unsigned long long)sk[i])
               << (8 * (params->index_bytes - 1 - i));
    }

    return idx;
}

static void terminate_server_process_group() {

    kill(-g_xmss_state->process_group_id, SIGKILL);
    _exit(EXIT_FAILURE);
}

int xmssmt_keys_init(void) {

    xmss_shared_state *state = mmap(NULL, sizeof(*state),
                                PROT_READ | PROT_WRITE,
                                MAP_ANONYMOUS | MAP_SHARED,
                                -1, 0);
    if (state == MAP_FAILED) {
        return -1;
    }
    g_xmss_state = state;

    int result = 0;
    xmss_xmssmt_initialize_params(&g_xmss_state->xmss_params);

    g_xmss_state->process_group_id = getpgrp();

    result = xmssmt_core_keypair(&g_xmss_state->xmss_params,
                            g_xmss_state->xmss_pk,
                            g_xmss_state->xmss_sk);
    return result;
}

void xmssmt_get_pk_hex(char *output, size_t output_size) {
    hex_encode(g_xmss_state->xmss_pk, XMSS_PK_SIZE, output, output_size);
}

int xmssmt_sign_message(const unsigned char *msg, unsigned long long mlen,
                      unsigned char *sig_out, size_t sig_out_size,
                      unsigned long long *sig_len, unsigned long long *signing_index) {

    if (mlen > (unsigned long long)(SIZE_MAX - XMSS_SIG_SIZE)) {
        return -1;
    }

    size_t expected_smlen = XMSS_SIG_SIZE + (size_t)mlen;
    if (sig_out_size < expected_smlen) {
        return -1;
    }

    unsigned char *sm = malloc(expected_smlen);
    if (!sm) {
        return -1;
    }
    *signing_index = signing_key_index(&g_xmss_state->xmss_params, g_xmss_state->xmss_sk);
    unsigned long long smlen;

    int ret = xmssmt_core_sign(&g_xmss_state->xmss_params, g_xmss_state->xmss_sk, sm, &smlen, msg, mlen);
    if (ret != 0) {
        free(sm);
        return -1;
    }

    if (smlen != expected_smlen || smlen > sig_out_size) {
        free(sm);
        return -1;
    }

    memcpy(sig_out, sm, (size_t)smlen);
    *sig_len = smlen;

    free(sm);
    debug_printf("xmssmt_sign_message: prepared XMSS signature at index %llu\n",
                 *signing_index);
    return 0;
}

int xmssmt_update_signing_key(unsigned long long *signing_index) {
    unsigned long long current_index;
    unsigned long long next_index;
    int result = -1;

    current_index = signing_key_index(&g_xmss_state->xmss_params, g_xmss_state->xmss_sk);

    if (current_index == *signing_index) {
        if (xmssmt_update_sk(&g_xmss_state->xmss_params, g_xmss_state->xmss_sk) != 0) {
            return -1;
        }

        next_index = signing_key_index(&g_xmss_state->xmss_params, g_xmss_state->xmss_sk);
        if (next_index != current_index + 1) {
            debug_printf("xmssmt_update_signing_key: unexpected next index %llu, expected %llu\n",
                         next_index, current_index + 1);
            terminate_server_process_group();
        }
        result = 0;

        debug_printf("xmssmt_update_signing_key: updated XMSS index %llu -> %llu\n",
                     *signing_index, next_index);
    } else {
        debug_printf("xmssmt_update_signing_key: XMSS index conflict, saved %llu current %llu\n",
                     *signing_index, current_index);
        terminate_server_process_group();
    }

    return result;
}

int xmssmt_verify_signature(const unsigned char *sig, unsigned long long siglen,
                          unsigned char *msg_out, size_t msg_out_size,
                          unsigned long long *mlen_out) {

    if (msg_out_size < XMSS_SIG_SIZE ||
        siglen < XMSS_SIG_SIZE + 1 ||
        siglen > (unsigned long long)msg_out_size) {
        return -1;
    }

    int ret = xmssmt_core_sign_open(&g_xmss_state->xmss_params,
                                    msg_out, mlen_out,
                                    sig, siglen,
                                    g_xmss_state->xmss_pk);
    if (ret != 0) {
        return ret;
    }

    if (*mlen_out == 0 || *mlen_out > (unsigned long long)(msg_out_size - XMSS_SIG_SIZE)) {
        return -1;
    }

    return 0;
}
