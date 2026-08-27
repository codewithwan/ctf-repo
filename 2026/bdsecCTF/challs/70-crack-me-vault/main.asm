            ;-- section..text:
            ; DATA XREF from entry0 @ 0x1448(r)
/ 872: int main (int argc, char **argv, char **envp);
| afv: vars(11:sp[0x8..0xf8])
|           0x000010c0      4881ec0801..   sub rsp, 0x108              ; [12] -r-x section size 1129 named .text
|           0x000010c7      64488b3c25..   mov rdi, qword fs:[0x28]
|           0x000010d0      4889bc24c8..   mov qword [var_c8h], rdi
|           0x000010d8      488d3d290f..   lea rdi, str._n______________.________._n_______________.______.__n_________________________n_______________________n________________________n_________.____________._n_________.________________._n______________.____.______n_________.__..____..__._n_________._____VM_____._n____________..____..____n_________.____.____.____._n_n_______n_____________BDSec_CTF_2026_n__________THE_BYTECODE_VAULT_n_______n_n ; 0x2008 ; "\n              .--------.\n             / .------. \\\n            / /        \\ \\\n            | |        | |\n           _| |________| |_\n         .' |_|        |_| '.\n         '._____ ____ _____.'\n         |     .'____'.     |\n         '.__.'.'    '.'.__.'\n         '.__  | VM |  __.'\n         |   '.'.____.'.'   |\n         '.____'.____.'____.'\n\n      ====================================\n             BDSec CTF 2026\n          THE BYTECODE VAULT\n      ====================================\n\n" ; const char *s
|           0x000010df      e84cffffff     call sym.imp.puts           ; int puts(const char *s)
|           0x000010e4      ba10000000     mov edx, 0x10               ; size_t nitems
|           0x000010e9      488b0d502f..   mov rcx, qword [obj.stdout] ; [0x4040:8]=0 ; FILE *stream
|           0x000010f0      be01000000     mov esi, 1                  ; size_t size
|           0x000010f5      488d3d4b11..   lea rdi, str.Enter_the_flag: ; 0x2247 ; "Enter the flag:" ; const void *ptr
|           0x000010fc      e87fffffff     call sym.imp.fwrite         ; size_t fwrite(const void *ptr, size_t size, size_t nitems, FILE *stream)
|           0x00001101      488b3d382f..   mov rdi, qword [obj.stdout] ; [0x4040:8]=0 ; FILE *stream
|           0x00001108      e863ffffff     call sym.imp.fflush         ; int fflush(FILE *stream)
|           0x0000110d      be80000000     mov esi, 0x80               ; int size
|           0x00001112      488d7c2440     lea rdi, [s1]               ; char *s
|           0x00001117      488b15322f..   mov rdx, qword [obj.stdin]  ; [0x4050:8]=0 ; FILE *stream
|           0x0000111e      e83dffffff     call sym.imp.fgets          ; char *fgets(char *s, int size, FILE *stream)
|           0x00001123      4885c0         test rax, rax
|       ,=< 0x00001126      0f84b6020000   je 0x13e2
|       |   0x0000112c      488d353711..   lea rsi, [0x0000226a]       ; "\r\n" ; const char *s2
|       |   0x00001133      488d7c2440     lea rdi, [s1]               ; const char *s1
|       |   0x00001138      48899c24d8..   mov qword [var_d8h], rbx
|       |   0x00001140      e80bffffff     call sym.imp.strcspn        ; size_t strcspn(const char *s1, const char *s2)
|       |   0x00001145      4889c3         mov rbx, rax
|       |   0x00001148      807c044000     cmp byte [rsp + rax + 0x40], 0
|      ,==< 0x0000114d      750a           jne 0x1159
|      ||   0x0000114f      4883f87f       cmp rax, 0x7f               ; '\x7f'
|     ,===< 0x00001153      0f8470020000   je 0x13c9
|     |||   ; CODE XREF from main @ 0x114d(x)
|     |`--> 0x00001159      31c0           xor eax, eax
|     | |   0x0000115b      c6441c4000     mov byte [rsp + rbx + 0x40], 0
|     | |   0x00001160      660fefc0       pxor xmm0, xmm0
|     | |   0x00001164      4c8d1d8711..   lea r11, [0x000022f2]
|     | |   0x0000116b      0f290424       movaps xmmword [rsp], xmm0
|     | |   0x0000116f      41baa5ffffff   mov r10d, 0xffffffa5        ; 4294967205
|     | |   0x00001175      41b901000000   mov r9d, 1
|     | |   0x0000117b      6689442430     mov word [var_30h], ax
|     | |   0x00001180      0f29442410     movaps xmmword [var_10h], xmm0
|     | |   0x00001185      0f29442420     movaps xmmword [var_20h], xmm0
|     | |   ; CODE XREF from main @ 0x12c5(x)
|     |.--> 0x0000118a      410fb603       movzx eax, byte [r11]
|     |:|   0x0000118e      4431d0         xor eax, r10d
|     |:|   0x00001191      3c6b           cmp al, 0x6b                ; 'k'
|    ,====< 0x00001193      0f84a3010000   je 0x133c
|   ,=====< 0x00001199      0f8770010000   ja 0x130f
|   |||:|   0x0000119f      3c11           cmp al, 0x11
|  ,======< 0x000011a1      0f8406010000   je 0x12ad
|  ||||:|   0x000011a7      3c37           cmp al, 0x37                ; '7'
| ,=======< 0x000011a9      0f851c010000   jne 0x12cb
| |||||:|   0x000011af      4883fb32       cmp rbx, 0x32               ; '2'
| ========< 0x000011b3      0f8512010000   jne 0x12cb
| |||||:|   0x000011b9      4c89bc2400..   mov qword [var_100h], r15
| |||||:|   0x000011c1      31ff           xor edi, edi
| |||||:|   0x000011c3      41b841000000   mov r8d, 0x41               ; 'A'
| |||||:|   0x000011c9      31f6           xor esi, esi
| |||||:|   0x000011cb      4889ac24e0..   mov qword [var_e0h], rbp
| |||||:|   0x000011d3      31ed           xor ebp, ebp
| |||||:|   0x000011d5      4c89a424e8..   mov qword [var_e8h], r12
| |||||:|   0x000011dd      4c8d642440     lea r12, [s1]
| |||||:|   0x000011e2      4c89ac24f0..   mov qword [var_f0h], r13
| |||||:|   0x000011ea      49bd0bd7a3..   movabs r13, 0xa3d70a3d70a3d70b
| |||||:|   0x000011f4      4c89b424f8..   mov qword [canary], r14
| |||||:|   0x000011fc      49be254992..   movabs r14, 0x4924924924924925
| |||||:|   0x00001206      662e0f1f84..   nop word cs:[rax + rax]
| |||||:|   ; CODE XREF from main @ 0x1281(x)
| --------> 0x00001210      4889f0         mov rax, rsi
| |||||:|   0x00001213      4889f1         mov rcx, rsi
| |||||:|   0x00001216      450fb63c24     movzx r15d, byte [r12]
| |||||:|   0x0000121b      4983c401       add r12, 1
| |||||:|   0x0000121f      49f7ee         imul r14
| |||||:|   0x00001222      4889f0         mov rax, rsi
| |||||:|   0x00001225      4883c601       add rsi, 1
| |||||:|   0x00001229      48c1f83f       sar rax, 0x3f
| |||||:|   0x0000122d      4531c7         xor r15d, r8d
| |||||:|   0x00001230      4183c01d       add r8d, 0x1d
| |||||:|   0x00001234      48d1fa         sar rdx, 1
| |||||:|   0x00001237      4829c2         sub rdx, rax
| |||||:|   0x0000123a      488d04d500..   lea rax, [rdx*8]
| |||||:|   0x00001242      4829d0         sub rax, rdx
| |||||:|   0x00001245      4889fa         mov rdx, rdi
| |||||:|   0x00001248      48d1ea         shr rdx, 1
| |||||:|   0x0000124b      4829c1         sub rcx, rax
| |||||:|   0x0000124e      4889d0         mov rax, rdx
| |||||:|   0x00001251      83c101         add ecx, 1
| |||||:|   0x00001254      49f7e5         mul r13
| |||||:|   0x00001257      41d2c7         rol r15b, cl
| |||||:|   0x0000125a      89e8           mov eax, ebp
| |||||:|   0x0000125c      83c50b         add ebp, 0xb
| |||||:|   0x0000125f      4489f9         mov ecx, r15d
| |||||:|   0x00001262      83f017         xor eax, 0x17
| |||||:|   0x00001265      4989ff         mov r15, rdi
| |||||:|   0x00001268      4883c711       add rdi, 0x11
| |||||:|   0x0000126c      01c8           add eax, ecx
| |||||:|   0x0000126e      48c1ea04       shr rdx, 4
| |||||:|   0x00001272      486bd232       imul rdx, rdx, 0x32
| |||||:|   0x00001276      4929d7         sub r15, rdx
| |||||:|   0x00001279      4288043c       mov byte [rsp + r15], al
| |||||:|   0x0000127d      4883fe32       cmp rsi, 0x32               ; '2'
| ========< 0x00001281      758d           jne 0x1210
| |||||:|   0x00001283      488bac24e0..   mov rbp, qword [var_e0h]
| |||||:|   0x0000128b      4c8ba424e8..   mov r12, qword [var_e8h]
| |||||:|   0x00001293      4c8bac24f0..   mov r13, qword [var_f0h]
| |||||:|   0x0000129b      4c8bb424f8..   mov r14, qword [canary]
| |||||:|   0x000012a3      4c8bbc2400..   mov r15, qword [var_100h]
| ========< 0x000012ab      eb0c           jmp 0x12b9
| |||||:|   ; CODE XREF from main @ 0x11a1(x)
| |`------> 0x000012ad      31c0           xor eax, eax
| | |||:|   0x000012af      4883fb32       cmp rbx, 0x32               ; '2'
| | |||:|   0x000012b3      0f94c0         sete al
| | |||:|   0x000012b6      4121c1         and r9d, eax
| | |||:|   ; CODE XREFS from main @ 0x12ab(x), 0x13c4(x)
| -.------> 0x000012b9      4183c211       add r10d, 0x11
| |:|||:|   0x000012bd      4983c301       add r11, 1
| |:|||:|   0x000012c1      4180fae9       cmp r10b, 0xe9
| |:|||`==< 0x000012c5      0f85bffeffff   jne 0x118a
| |:||| |   ; CODE XREFS from main @ 0x11a9(x), 0x11b3(x), 0x1311(x), 0x1316(x)
| `----.--> 0x000012cb      488d3dc50f..   lea rdi, str._n____Access_denied. ; 0x2297 ; "\n[-] Access denied." ; const char *s
|  :|||:|   0x000012d2      e859fdffff     call sym.imp.puts           ; int puts(const char *s)
|  :|||:|   0x000012d7      488d3d420f..   lea rdi, str.____The_bytecode_vault_remains_sealed. ; 0x2220 ; "[-] The bytecode vault remains sealed." ; const char *s
|  :|||:|   0x000012de      e84dfdffff     call sym.imp.puts           ; int puts(const char *s)
|  :|||:|   0x000012e3      488b9c24d8..   mov rbx, qword [var_d8h]
|  :|||:|   ; CODE XREFS from main @ 0x13dd(x), 0x13ee(x)
| .-------> 0x000012eb      b801000000     mov eax, 1
| ::|||:|   ; CODE XREF from main @ 0x133a(x)
| --------> 0x000012f0      488b9424c8..   mov rdx, qword [var_c8h]
| ::|||:|   0x000012f8      64482b1425..   sub rdx, qword fs:[0x28]
| ========< 0x00001301      0f85ec000000   jne 0x13f3
| ::|||:|   0x00001307      4881c40801..   add rsp, 0x108
| ::|||:|   0x0000130e      c3             ret
| ::|||:|   ; CODE XREF from main @ 0x1199(x)
| ::`-----> 0x0000130f      3ce0           cmp al, 0xe0
| ========< 0x00001311      75b8           jne 0x12cb
| :: ||:|   0x00001313      4585c9         test r9d, r9d
| :: ||`==< 0x00001316      74b3           je 0x12cb
| :: || |   0x00001318      488d3d630f..   lea rdi, str._n___Access_granted. ; 0x2282 ; "\n[+] Access granted." ; const char *s
| :: || |   0x0000131f      e80cfdffff     call sym.imp.puts           ; int puts(const char *s)
| :: || |   0x00001324      488d3dc50e..   lea rdi, str.___Submit_the_flag_to_receive_your_points. ; 0x21f0 ; "[+] Submit the flag to receive your points." ; const char *s
| :: || |   0x0000132b      e800fdffff     call sym.imp.puts           ; int puts(const char *s)
| :: || |   0x00001330      488b9c24d8..   mov rbx, qword [var_d8h]
| :: || |   0x00001338      31c0           xor eax, eax
| ========< 0x0000133a      ebb4           jmp 0x12f0
| :: || |   ; CODE XREF from main @ 0x1193(x)
| :: `----> 0x0000133c      4889ac24e0..   mov qword [var_e0h], rbp
| ::  | |   0x00001344      488d3d750f..   lea rdi, [0x000022c0]
| ::  | |   0x0000134b      31f6           xor esi, esi
| ::  | |   0x0000134d      b944000000     mov ecx, 0x44               ; 'D'
| ::  | |   0x00001352      49b80bd7a3..   movabs r8, 0xa3d70a3d70a3d70b
| ::  | |   0x0000135c      0f1f00         nop dword [rax]
| ::  | |   0x0000135f      66662e0f1f..   nop word cs:[rax + rax]
| ::  | |   0x0000136a      66662e0f1f..   nop word cs:[rax + rax]
| ::  | |   0x00001375      66662e0f1f..   nop word cs:[rax + rax]
| ::  | |   ; CODE XREF from main @ 0x13ba(x)
| ::  |.--> 0x00001380      4889f2         mov rdx, rsi
| ::  |:|   0x00001383      0fb62f         movzx ebp, byte [rdi]
| ::  |:|   0x00001386      48d1ea         shr rdx, 1
| ::  |:|   0x00001389      4889d0         mov rax, rdx
| ::  |:|   0x0000138c      31cd           xor ebp, ecx
| ::  |:|   0x0000138e      49f7e0         mul r8
| ::  |:|   0x00001391      4889f0         mov rax, rsi
| ::  |:|   0x00001394      48c1ea04       shr rdx, 4
| ::  |:|   0x00001398      486bd232       imul rdx, rdx, 0x32
| ::  |:|   0x0000139c      4829d0         sub rax, rdx
| ::  |:|   0x0000139f      403a2c04       cmp bpl, byte [rsp + rax]
| ::  |:|   0x000013a3      0f94c0         sete al
| ::  |:|   0x000013a6      83c10d         add ecx, 0xd
| ::  |:|   0x000013a9      4883c701       add rdi, 1
| ::  |:|   0x000013ad      4883c611       add rsi, 0x11
| ::  |:|   0x000013b1      0fb6c0         movzx eax, al
| ::  |:|   0x000013b4      4121c1         and r9d, eax
| ::  |:|   0x000013b7      80f9ce         cmp cl, 0xce
| ::  |`==< 0x000013ba      75c4           jne 0x1380
| ::  | |   0x000013bc      488bac24e0..   mov rbp, qword [var_e0h]
| :`======< 0x000013c4      e9f0feffff     jmp 0x12b9
| :   | |   ; CODE XREF from main @ 0x1153(x)
| :   `---> 0x000013c9      488d3d9d0e..   lea rdi, str._n____Input_too_long. ; 0x226d ; "\n[-] Input too long." ; const char *s
| :     |   0x000013d0      e85bfcffff     call sym.imp.puts           ; int puts(const char *s)
| :     |   0x000013d5      488b9c24d8..   mov rbx, qword [var_d8h]
| ========< 0x000013dd      e909ffffff     jmp 0x12eb
| :     |   ; CODE XREF from main @ 0x1126(x)
| :     `-> 0x000013e2      488d3d6f0e..   lea rdi, str._n____Input_error. ; 0x2258 ; "\n[-] Input error." ; const char *s
| :         0x000013e9      e842fcffff     call sym.imp.puts           ; int puts(const char *s)
| `=======< 0x000013ee      e9f8feffff     jmp 0x12eb
|           ; CODE XREF from main @ 0x1301(x)
| --------> 0x000013f3      48899c24d8..   mov qword [var_d8h], rbx
|           0x000013fb      4889ac24e0..   mov qword [var_e0h], rbp
|           0x00001403      4c89a424e8..   mov qword [var_e8h], r12
|           0x0000140b      4c89ac24f0..   mov qword [var_f0h], r13
|           0x00001413      4c89b424f8..   mov qword [canary], r14
|           0x0000141b      4c89bc2400..   mov qword [var_100h], r15
\           0x00001423      e818fcffff     call sym.imp.__stack_chk_fail ; void stack_chk_fail(void)
