#include <stdint.h>
__attribute__((used)) const char oracle_marker[] = "ORACLE_MASK_XOR_0x37";
__attribute__((used)) const unsigned char oracle_chunk[] = {89,86,67,94,65,82,26,81,69,86,80,90,82,89,67,13,13};
int oracle_gate(int x){return (x*31337)^0x5a17;}
