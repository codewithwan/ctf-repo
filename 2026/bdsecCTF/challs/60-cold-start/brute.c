#include <stdio.h>
#include <stdint.h>
#include "table.h"
static inline uint32_t rol(uint32_t x,uint32_t c){c&=31;return c? (x<<c)|(x>>(32-c)):x;}
int check(uint32_t ebp){
    uint32_t edi=rol(ebp*0x9e3779b1u,7)^0x1b873593u;
    uint32_t edx=(((ebp<<5)^(ebp>>3)))^0x811c9dc5u;
    uint32_t r8=ebp^0xa3c59ac3u;
    uint32_t r9=0,r10=0,r11=0;
    uint32_t arr[96];
    for(uint32_t i=0;i<0x60;i++){
        uint32_t A=edx^r8^r9^rol(edi,i);
        uint32_t al=A&0xff;
        uint32_t r15=al+i;
        uint32_t r14=T[al];
        A=(r10^ebp)+r8+r14;
        A=rol(A,(r14>>27)+1);
        uint32_t C=(edx+r11);   // edx here = old edx (before FNV)
        r8=A;                   // new r8
        edx=edx*0x1000193u;
        C=C+r8;
        uint32_t A2=((r14>>8)+r15)&0xff;
        edx=edx+i;              // FNV state
        C=C+T[A2];
        r14=r14+edx;
        uint32_t e=C^(C>>16); e*=0x7feb352du; e^=e>>15; e*=0x846ca68bu;
        edi=edi^e; edi=edi^(e>>16);
        uint32_t im=i%13;
        uint32_t Ae=rol(edi,im+1)^r8;
        r9+=0x45d9f3bu; r10+=0x27d4eb2du; r11-=0x61c88647u;
        edx=Ae+r14;             // new edx state
        arr[i]=rol(edi,11)^r8^edx;
    }
    // final combine
    uint32_t eax=arr[47];
    uint32_t ecx=arr[11]^arr[83];
    eax=rol(eax,9); ecx^=eax; ecx^=r8;
    eax=ecx^(ecx>>16); eax*=0x7feb352du; eax^=eax>>15; eax*=0x846ca68bu;
    uint32_t esi=eax>>16;
    uint32_t c2=arr[68]; c2=rol(c2,13); c2+=arr[23]; c2+=edi; c2+=edx;
    uint32_t edx2=c2^(c2>>16); edx2*=0x7feb352du; edx2^=edx2>>15; edx2*=0x846ca68bu;
    uint32_t r8_2=edx2>>16;
    uint32_t cc=arr[7]>>5; cc^=(arr[55]>>11); cc^=arr[91]; cc^=ebp;
    uint32_t chk_eax=eax^esi;
    uint32_t chk_edx=edx2^r8_2;
    return ((cc&0xffff)==0x9c8c) && (chk_eax==0x91e50c54u) && (chk_edx==0xc2e4f8bdu);
}
int main(){
    for(uint32_t s=0;s<=0xffffff;s++){
        if(check(s)){ printf("SEED=%06x (%u)\n",s,s); return 0; }
    }
    printf("not found\n"); return 1;
}
