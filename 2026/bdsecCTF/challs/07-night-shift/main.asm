            ;-- section..text:
            ; DATA XREF from entry0 @ 0x15e8(r)
/ 1164: int main (int argc, char **argv, char **envp);
| afv: vars(24:sp[0x8..0x280])
|           0x00001130      4881ec8802..   sub rsp, 0x288              ; [12] -r-x section size 2196 named .text
|           0x00001137      660fefc0       pxor xmm0, xmm0
|           0x0000113b      4c89ac2470..   mov qword [var_270h], r13
|           0x00001143      4c8dac2490..   lea r13, [var_90h]
|           0x0000114b      48899c2458..   mov qword [var_258h], rbx
|           0x00001153      4889ac2460..   mov qword [var_260h], rbp
|           0x0000115b      4c89b42478..   mov qword [var_278h], r14
|           0x00001163      64488b0425..   mov rax, qword fs:[0x28]
|           0x0000116c      4889842448..   mov qword [var_248h], rax
|           0x00001174      31c0           xor eax, eax
|           ; CODE XREF from main @ 0x11a0(x)
|       .-> 0x00001176      89c2           mov edx, eax
|       :   0x00001178      83c040         add eax, 0x40               ; elf_phdr
|       :   0x0000117b      0f29841490..   movaps xmmword [rsp + rdx + 0x90], xmm0
|       :   0x00001183      0f298414a0..   movaps xmmword [rsp + rdx + 0xa0], xmm0
|       :   0x0000118b      0f298414b0..   movaps xmmword [rsp + rdx + 0xb0], xmm0
|       :   0x00001193      0f298414c0..   movaps xmmword [rsp + rdx + 0xc0], xmm0
|       :   0x0000119b      3d80000000     cmp eax, 0x80
|       `=< 0x000011a0      72d4           jb 0x1176
|           0x000011a2      410f29440500   movaps xmmword [r13 + rax], xmm0
|           0x000011a8      31d2           xor edx, edx
|           0x000011aa      31c9           xor ecx, ecx                ; size_t size
|           0x000011ac      31f6           xor esi, esi                ; char *buf
|           0x000011ae      488b3ddb2e..   mov rdi, qword [obj.stdout] ; [0x4090:8]=0 ; FILE*stream
|           0x000011b5      4989540520     mov qword [r13 + rax + 0x20], rdx
|           0x000011ba      ba02000000     mov edx, 2                  ; int mode
|           0x000011bf      410f29440510   movaps xmmword [r13 + rax + 0x10], xmm0
|           0x000011c5      660f6f05a3..   movdqa xmm0, xmmword [0x00002170] ; [0x2170:16]=-1
|           0x000011cd      c784241801..   mov dword [var_118h], 0x811c9dc5 ; [0x811c9dc5:4]=-1
|           0x000011d8      0f118424e8..   movups xmmword [var_e8h], xmm0
|           0x000011e0      e8dbfeffff     call sym.imp.setvbuf        ; int setvbuf(FILE*stream, char *buf, int mode, size_t size)
|           0x000011e5      488d3d7c0e..   lea rdi, [0x00002068]       ; "\n========================================" ; const char *s
|           0x000011ec      e84ffeffff     call sym.imp.puts           ; int puts(const char *s)
|           0x000011f1      488d3d160f..   lea rdi, str.______________NIGHT_SHIFT ; 0x210e ; "              NIGHT SHIFT" ; const char *s
|           0x000011f8      e843feffff     call sym.imp.puts           ; int puts(const char *s)
|           0x000011fd      488d3d940e..   lea rdi, str._n             ; 0x2098 ; "========================================\n" ; const char *s
|           0x00001204      e837feffff     call sym.imp.puts           ; int puts(const char *s)
|           0x00001209      488d3d180f..   lea rdi, str.The_building_is_closed. ; 0x2128 ; "The building is closed." ; const char *s
|           0x00001210      e82bfeffff     call sym.imp.puts           ; int puts(const char *s)
|           0x00001215      488d3d240f..   lea rdi, str.Eight_assignments_remain._n ; 0x2140 ; "Eight assignments remain.\n" ; const char *s
|           0x0000121c      e81ffeffff     call sym.imp.puts           ; int puts(const char *s)
|           0x00001221      ba0c000000     mov edx, 0xc                ; size_t nitems
|           0x00001226      488b0d632e..   mov rcx, qword [obj.stdout] ; [0x4090:8]=0 ; FILE *stream
|           0x0000122d      be01000000     mov esi, 1                  ; size_t size
|           0x00001232      488d3d220f..   lea rdi, str.shift_code_    ; 0x215b ; "shift code>" ; const void *ptr
|           0x00001239      e8c2feffff     call sym.imp.fwrite         ; size_t fwrite(const void *ptr, size_t size, size_t nitems, FILE *stream)
|           0x0000123e      488b155b2e..   mov rdx, qword [obj.stdin]  ; [0x40a0:8]=0 ; FILE *stream
|           0x00001245      31c9           xor ecx, ecx
|           0x00001247      be00010000     mov esi, 0x100              ; int size
|           0x0000124c      488dbc2440..   lea rdi, [s]                ; char *s
|           0x00001254      48890c24       mov qword [rsp], rcx
|           0x00001258      e833feffff     call sym.imp.fgets          ; char *fgets(char *s, int size, FILE *stream)
|           0x0000125d      4885c0         test rax, rax
|       ,=< 0x00001260      0f849a000000   je 0x1300
|       |   0x00001266      4889e2         mov rdx, rsp
|       |   0x00001269      488d35f80e..   lea rsi, str.__t_r_n        ; 0x2168 ; " \t\r\n"
|       |   0x00001270      488dbc2440..   lea rdi, [s]
|       |   0x00001278      e803feffff     call sym.imp.strtok_r
|       |   0x0000127d      4889c3         mov rbx, rax
|       |   0x00001280      4885c0         test rax, rax
|      ,==< 0x00001283      747b           je 0x1300
|      ||   0x00001285      31ed           xor ebp, ebp
|     ,===< 0x00001287      eb4f           jmp 0x12d8
..
|     |||   ; CODE XREF from main @ 0x12f6(x)
|    .----> 0x00001290      488b542408     mov rdx, qword [endptr]
|    :|||   0x00001295      803a00         cmp byte [rdx], 0
|   ,=====< 0x00001298      7566           jne 0x1300
|   |:|||   0x0000129a      4883f804       cmp rax, 4
|  ,======< 0x0000129e      7760           ja 0x1300
|  ||:|||   0x000012a0      4883c501       add rbp, 1
|  ||:|||   0x000012a4      4889e2         mov rdx, rsp
|  ||:|||   0x000012a7      488d35ba0e..   lea rsi, str.__t_r_n        ; 0x2168 ; " \t\r\n"
|  ||:|||   0x000012ae      31ff           xor edi, edi
|  ||:|||   0x000012b0      88842c1b01..   mov byte [rsp + rbp + 0x11b], al
|  ||:|||   0x000012b7      e8c4fdffff     call sym.imp.strtok_r
|  ||:|||   0x000012bc      4885c0         test rax, rax
|  ||:|||   0x000012bf      4889c3         mov rbx, rax
|  ||:|||   0x000012c2      0f95c2         setne dl
|  ||:|||   0x000012c5      4883fd08       cmp rbp, 8
|  ||:|||   0x000012c9      0f95c0         setne al
|  ||:|||   0x000012cc      84d2           test dl, dl
| ,=======< 0x000012ce      0f8480000000   je 0x1354
| |||:|||   0x000012d4      84c0           test al, al
| ========< 0x000012d6      7428           je 0x1300
| |||:|||   ; CODE XREF from main @ 0x1287(x)
| |||:`---> 0x000012d8      ba0a000000     mov edx, 0xa                ; int base
| |||: ||   0x000012dd      488d742408     lea rsi, [endptr]           ; char * *endptr
| |||: ||   0x000012e2      4889df         mov rdi, rbx                ; const char *str
| |||: ||   0x000012e5      48c7442408..   mov qword [endptr], 0
| |||: ||   0x000012ee      e8fdfdffff     call sym.imp.strtoul        ; long strtoul(const char *str, char * *endptr, int base)
| |||: ||   0x000012f3      803b00         cmp byte [rbx], 0
| |||`====< 0x000012f6      7598           jne 0x1290
| |||  ||   0x000012f8      0f1f840000..   nop dword [rax + rax]
| |||  ||   ; XREFS: CODE 0x00001260  CODE 0x00001283  CODE 0x00001298  
| |||  ||   ; XREFS: CODE 0x0000129e  CODE 0x000012d6  CODE 0x000013df  
| |||  ||   ; XREFS: CODE 0x00001454  
| -``..``-> 0x00001300      488d3dc10d..   lea rdi, str.The_shift_report_was_rejected. ; 0x20c8 ; "The shift report was rejected." ; const char *s
| |  ::     0x00001307      41be01000000   mov r14d, 1
| |  ::     0x0000130d      e82efdffff     call sym.imp.puts           ; int puts(const char *s)
| |  ::     ; CODE XREF from main @ 0x15a9(x)
| |  :: .-> 0x00001312      488b842448..   mov rax, qword [var_248h]
| |  :: :   0x0000131a      64482b0425..   sub rax, qword fs:[0x28]
| |  ::,==< 0x00001323      0f8585020000   jne 0x15ae
| |  ::|:   0x00001329      4489f0         mov eax, r14d
| |  ::|:   0x0000132c      488b9c2458..   mov rbx, qword [var_258h]
| |  ::|:   0x00001334      488bac2460..   mov rbp, qword [var_260h]
| |  ::|:   0x0000133c      4c8bac2470..   mov r13, qword [var_270h]
| |  ::|:   0x00001344      4c8bb42478..   mov r14, qword [var_278h]
| |  ::|:   0x0000134c      4881c48802..   add rsp, 0x288
| |  ::|:   0x00001353      c3             ret
| |  ::|:   ; CODE XREF from main @ 0x12ce(x)
| `-------> 0x00001354      4c89a42468..   mov qword [canary], r12
|    ::|:   0x0000135c      84c0           test al, al
|   ,=====< 0x0000135e      7577           jne 0x13d7
|   |::|:   0x00001360      488d6c2440     lea rbp, [var_40h]
|   |::|:   0x00001365      4531e4         xor r12d, r12d
|   |::|:   ; CODE XREF from main @ 0x13a3(x)
|  .------> 0x00001368      4c896d00       mov qword [rbp], r13
|  :|::|:   0x0000136c      31f6           xor esi, esi
|  :|::|:   0x0000136e      4889e9         mov rcx, rbp
|  :|::|:   0x00001371      488d155803..   lea rdx, [0x000016d0]
|  :|::|:   0x00001378      44886508       mov byte [rbp + 8], r12b
|  :|::|:   0x0000137c      4e8d34e500..   lea r14, [r12*8]
|  :|::|:   0x00001384      488d5c2410     lea rbx, [var_10h]
|  :|::|:   0x00001389      4a8d7c3410     lea rdi, [rsp + r14 + 0x10]
|  :|::|:   0x0000138e      e83dfdffff     call sym.imp.pthread_create
|  :|::|:   0x00001393      85c0           test eax, eax
| ,=======< 0x00001395      754d           jne 0x13e4
| |:|::|:   0x00001397      4983c401       add r12, 1
| |:|::|:   0x0000139b      4883c510       add rbp, 0x10
| |:|::|:   0x0000139f      4983fc05       cmp r12, 5
| |`======< 0x000013a3      75c3           jne 0x1368
| | |::|:   0x000013a5      41be28000000   mov r14d, 0x28              ; '('
| | |::|:   ; CODE XREF from main @ 0x1401(x)
| |.------> 0x000013ab      4a8d6c3410     lea rbp, [rsp + r14 + 0x10]
| |:|::|:   ; CODE XREF from main @ 0x13c1(x)
| --------> 0x000013b0      488b3b         mov rdi, qword [rbx]
| |:|::|:   0x000013b3      31f6           xor esi, esi
| |:|::|:   0x000013b5      4883c308       add rbx, 8
| |:|::|:   0x000013b9      e852fdffff     call sym.imp.pthread_join
| |:|::|:   0x000013be      4839eb         cmp rbx, rbp
| ========< 0x000013c1      75ed           jne 0x13b0
| |:|::|:   ; CODE XREF from main @ 0x13ff(x)
| --------> 0x000013c3      48b8dc978a..   movabs rax, 0x75a2cc729c8a97dc
| |:|::|:   0x000013cd      48398424e8..   cmp qword [var_e8h], rax
| ========< 0x000013d5      742c           je 0x1403
| |:|::|:   ; CODE XREFS from main @ 0x135e(x), 0x1415(x), 0x1422(x), 0x142d(x)
| --`-----> 0x000013d7      4c8ba42468..   mov r12, qword [canary]
| |: `====< 0x000013df      e91cffffff     jmp 0x1300
| |:  :|:   ; CODE XREF from main @ 0x1395(x)
| `-------> 0x000013e4      488dbc24b8..   lea rdi, [var_b8h]
|  :  :|:   0x000013ec      c784243001..   mov dword [var_130h], 1
|  :  :|:   0x000013f7      e834fcffff     call sym.imp.pthread_cond_broadcast
|  :  :|:   0x000013fc      4d85e4         test r12, r12
| ========< 0x000013ff      74c2           je 0x13c3
|  `======< 0x00001401      eba8           jmp 0x13ab
|     :|:   ; CODE XREF from main @ 0x13d5(x)
| --------> 0x00001403      48b80fef87..   movabs rax, 0x4969e73d1d87ef0f
|     :|:   0x0000140d      48398424f0..   cmp qword [var_f0h], rax
| ========< 0x00001415      75c0           jne 0x13d7
|     :|:   0x00001417      81bc241801..   cmp dword [var_118h], 0x4455cee8
| ========< 0x00001422      75b3           jne 0x13d7
|     :|:   0x00001424      4883bc2428..   cmp qword [var_128h], 8
| ========< 0x0000142d      75a8           jne 0x13d7
|     :|:   0x0000142f      448bb42430..   mov r14d, dword [var_130h]
|     :|:   0x00001437      4c89bc2480..   mov qword [var_280h], r15
|     :|:   0x0000143f      4585f6         test r14d, r14d
|    ,====< 0x00001442      7415           je 0x1459
|    |:|:   0x00001444      4c8ba42468..   mov r12, qword [canary]
|    |:|:   0x0000144c      4c8bbc2480..   mov r15, qword [var_280h]
|    |`===< 0x00001454      e9a7feffff     jmp 0x1300
|    | |:   ; CODE XREF from main @ 0x1442(x)
|    `----> 0x00001459      488d3d880c..   lea rdi, str.The_morning_report_has_been_approved. ; 0x20e8 ; "The morning report has been approved." ; const char *s
|      |:   0x00001460      4531ff         xor r15d, r15d
|      |:   0x00001463      4c8d25d60b..   lea r12, [0x00002040]
|      |:   0x0000146a      48bdf1f0f0..   movabs rbp, 0xf0f0f0f0f0f0f0f1
|      |:   0x00001474      e8c7fbffff     call sym.imp.puts           ; int puts(const char *s)
|      |:   0x00001479      48bbc54eec..   movabs rbx, 0x4ec4ec4ec4ec4ec5
|      |:   0x00001483      6690           nop
|      |:   0x00001485      66662e0f1f..   nop word cs:[rax + rax]
|      |:   ; CODE XREF from main @ 0x156d(x)
|     .---> 0x00001490      4169c7b979..   imul eax, r15d, 0x9e3779b9
|     :|:   0x00001497      4c89ff         mov rdi, r15
|     :|:   0x0000149a      4d89f8         mov r8, r15
|     :|:   0x0000149d      4c89f9         mov rcx, r15
|     :|:   0x000014a0      83e707         and edi, 7
|     :|:   0x000014a3      4183e003       and r8d, 3
|     :|:   0x000014a7      8bb4bcf800..   mov esi, dword [rsp + rdi*4 + 0xf8]
|     :|:   0x000014ae      33b4241801..   xor esi, dword [var_118h]
|     :|:   0x000014b5      31c6           xor esi, eax
|     :|:   0x000014b7      4c89f8         mov rax, r15
|     :|:   0x000014ba      48f7e5         mul rbp
|     :|:   0x000014bd      4889d0         mov rax, rdx
|     :|:   0x000014c0      4883e2f0       and rdx, 0xfffffffffffffff0
|     :|:   0x000014c4      48c1e804       shr rax, 4
|     :|:   0x000014c8      4801c2         add rdx, rax
|     :|:   0x000014cb      428b8484e8..   mov eax, dword [rsp + r8*4 + 0xe8]
|     :|:   0x000014d3      4829d1         sub rcx, rdx
|     :|:   0x000014d6      83c103         add ecx, 3
|     :|:   0x000014d9      d3c0           rol eax, cl
|     :|:   0x000014db      4c89f9         mov rcx, r15
|     :|:   0x000014de      31c6           xor esi, eax
|     :|:   0x000014e0      0fb6843c1c..   movzx eax, byte [rsp + rdi + 0x11c]
|     :|:   0x000014e8      4b8d7c7f01     lea rdi, [r15 + r15*2 + 1]
|     :|:   0x000014ed      83e707         and edi, 7
|     :|:   0x000014f0      69c03b9f5d04   imul eax, eax, 0x45d9f3b
|     :|:   0x000014f6      31c6           xor esi, eax
|     :|:   0x000014f8      4c89f8         mov rax, r15
|     :|:   0x000014fb      48f7e3         mul rbx
|     :|:   0x000014fe      48c1ea02       shr rdx, 2
|     :|:   0x00001502      488d0452       lea rax, [rdx + rdx*2]
|     :|:   0x00001506      488d0482       lea rax, [rdx + rax*4]
|     :|:   0x0000150a      8b94bcf800..   mov edx, dword [rsp + rdi*4 + 0xf8]
|     :|:   0x00001511      430fb63c3c     movzx edi, byte [r12 + r15]
|     :|:   0x00001516      4829c1         sub rcx, rax
|     :|:   0x00001519      83c101         add ecx, 1
|     :|:   0x0000151c      d3c2           rol edx, cl
|     :|:   0x0000151e      31f2           xor edx, esi
|     :|:   0x00001520      488b35692b..   mov rsi, qword [obj.stdout] ; [0x4090:8]=0 ; FILE *stream
|     :|:   0x00001527      89d0           mov eax, edx
|     :|:   0x00001529      c1e810         shr eax, 0x10
|     :|:   0x0000152c      31d0           xor eax, edx
|     :|:   0x0000152e      69c02d35eb7f   imul eax, eax, 0x7feb352d
|     :|:   0x00001534      89c2           mov edx, eax
|     :|:   0x00001536      c1ea0f         shr edx, 0xf
|     :|:   0x00001539      31d0           xor eax, edx
|     :|:   0x0000153b      69c08ba66c84   imul eax, eax, 0x846ca68b
|     :|:   0x00001541      89c2           mov edx, eax
|     :|:   0x00001543      c1ea10         shr edx, 0x10
|     :|:   0x00001546      31d0           xor eax, edx
|     :|:   0x00001548      31c7           xor edi, eax
|     :|:   0x0000154a      89c2           mov edx, eax
|     :|:   0x0000154c      89f9           mov ecx, edi
|     :|:   0x0000154e      30e1           xor cl, ah
|     :|:   0x00001550      c1ea10         shr edx, 0x10
|     :|:   0x00001553      4983c701       add r15, 1
|     :|:   0x00001557      89cf           mov edi, ecx
|     :|:   0x00001559      c1e818         shr eax, 0x18
|     :|:   0x0000155c      31d7           xor edi, edx
|     :|:   0x0000155e      31c7           xor edi, eax
|     :|:   0x00001560      400fb6ff       movzx edi, dil              ; int c
|     :|:   0x00001564      e837fbffff     call sym.imp.putc           ; int putc(int c, FILE *stream)
|     :|:   0x00001569      4983ff24       cmp r15, 0x24               ; '$'
|     `===< 0x0000156d      0f851dffffff   jne 0x1490
|      |:   0x00001573      488b35162b..   mov rsi, qword [obj.stdout] ; [0x4090:8]=0 ; FILE *stream
|      |:   0x0000157a      bf0a000000     mov edi, 0xa                ; int c
|      |:   0x0000157f      e81cfbffff     call sym.imp.putc           ; int putc(int c, FILE *stream)
|      |:   0x00001584      4c89ef         mov rdi, r13
|      |:   0x00001587      e8e4faffff     call sym.imp.pthread_mutex_destroy
|      |:   0x0000158c      488dbc24b8..   lea rdi, [var_b8h]
|      |:   0x00001594      e847fbffff     call sym.imp.pthread_cond_destroy
|      |:   0x00001599      4c8ba42468..   mov r12, qword [canary]
|      |:   0x000015a1      4c8bbc2480..   mov r15, qword [var_280h]
|      |`=< 0x000015a9      e964fdffff     jmp 0x1312
|      |    ; CODE XREF from main @ 0x1323(x)
|      `--> 0x000015ae      4c89a42468..   mov qword [canary], r12
|           0x000015b6      4c89bc2480..   mov qword [var_280h], r15
\           0x000015be      e89dfaffff     call sym.imp.__stack_chk_fail ; void stack_chk_fail(void)
