#include <stdint.h>
#include <string.h>

#include "params.h"
#include "xmss_core.h"

int xmss_xmssmt_initialize_params(xmss_params *params)
{
    params->bds_k = 2; 
    params->wots_w = 256;
    params->n = 16;
    params->padding_len = 4;
    params->full_height = 32;
    params->d = 4;
    params->tree_height = params->full_height  / params->d;
    params->wots_log_w = 8;
    params->wots_len1 = 8 * params->n / params->wots_log_w;
    params->wots_len2 = 2;

    params->wots_len = params->wots_len1 + params->wots_len2;
    params->wots_sig_bytes = params->wots_len * params->n;
    params->index_bytes = (params->full_height + 7) / 8;
    params->sig_bytes = (params->index_bytes + params->n
                         + params->d * params->wots_sig_bytes
                         + params->full_height * params->n);

    params->pk_bytes = 2 * params->n;
    params->sk_bytes = xmss_xmssmt_core_sk_bytes(params);

    return 0;
}
