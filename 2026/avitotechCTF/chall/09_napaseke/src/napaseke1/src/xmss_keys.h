#ifndef XMSS_KEYS_H
#define XMSS_KEYS_H

#include <stddef.h>

#include "xmss-md5/params.h"
#include "xmss-md5/xmss_core.h"

#define XMSS_PK_SIZE 32
#define XMSS_SK_SIZE 4481
#define XMSS_SIG_SIZE 1684

int xmssmt_keys_init(void);
void xmssmt_get_pk_hex(char *output, size_t output_size);
int xmssmt_sign_message(const unsigned char *msg, unsigned long long mlen,
                      unsigned char *sig_out, size_t sig_out_size,
                      unsigned long long *sig_len, unsigned long long *signing_index);
int xmssmt_update_signing_key(unsigned long long *signing_index);
int xmssmt_verify_signature(const unsigned char *sig, unsigned long long siglen,
                          unsigned char *msg_out, size_t msg_out_size,
                          unsigned long long *mlen_out);

#endif // XMSS_KEYS_H
