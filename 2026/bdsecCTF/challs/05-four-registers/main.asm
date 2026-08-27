            ;-- section..text:
            ; DATA XREF from entry0 @ 0x1958(r)
/ 2092: int main (int argc, char **argv, char **envp);
| afv: vars(18:sp[0x40..0x27c])
|           0x00001100      4157           push r15                    ; [12] -r-x section size 2451 named .text
|           0x00001102      31f6           xor esi, esi                ; char *buf
|           0x00001104      ba02000000     mov edx, 2                  ; int mode
|           0x00001109      4156           push r14
|           0x0000110b      4155           push r13
|           0x0000110d      4154           push r12
|           0x0000110f      4531e4         xor r12d, r12d
|           0x00001112      55             push rbp
|           0x00001113      53             push rbx
|           0x00001114      4881ec5802..   sub rsp, 0x258
|           0x0000111b      488b3d4e2f..   mov rdi, qword [obj.stdout] ; [0x4070:8]=0 ; FILE*stream
|           0x00001122      64488b0c25..   mov rcx, qword fs:[0x28]
|           0x0000112b      48898c2448..   mov qword [var_248h], rcx
|           0x00001133      31c9           xor ecx, ecx                ; size_t size
|           0x00001135      488d9c24c0..   lea rbx, [var_1c0h]
|           0x0000113d      e86effffff     call sym.imp.setvbuf        ; int setvbuf(FILE*stream, char *buf, int mode, size_t size)
|           0x00001142      660f6f05d6..   movdqa xmm0, xmmword [0x00002220] ; [0x2220:16]=-1
|           0x0000114a      31d2           xor edx, edx
|           0x0000114c      488d3db50e..   lea rdi, str._n__________________________________________________n__________________________________________________n_________________B_D_S_e_c___C_T_F___2_0_2_6_____n____________________________________________________n___________________________________________________n____________________FOUR_REGISTERS_________________n___________________________________________________n ; 0x2008 ; "\n        _________________________________________\n       /                                         \\\n      /          B D S e c   C T F   2 0 2 6    \\\n     /_____________________________________________\\\n     |                                             |\n     |               FOUR REGISTERS                |\n     |_____________________________________________|\n" ; const char *s
|           0x00001153      6689542430     mov word [var_30h], dx
|           0x00001158      0f29442420     movaps xmmword [var_20h], xmm0
|           0x0000115d      e8defeffff     call sym.imp.puts           ; int puts(const char *s)
|           0x00001162      488d3d0c10..   lea rdi, str.The_control_unit_is_waiting. ; 0x2175 ; "The control unit is waiting." ; const char *s
|           0x00001169      e8d2feffff     call sym.imp.puts           ; int puts(const char *s)
|           0x0000116e      6690           nop
|           ; CODE XREFS from main @ 0x11cc(x), 0x13ac(x), 0x169e(x)
|     ...-> 0x00001170      488b0df92e..   mov rcx, qword [obj.stdout] ; [0x4070:8]=0 ; FILE *stream
|     :::   0x00001177      ba02000000     mov edx, 2                  ; size_t nitems
|     :::   0x0000117c      be01000000     mov esi, 1                  ; size_t size
|     :::   0x00001181      488d3d0a10..   lea rdi, [0x00002192]       ; "> " ; const void *ptr
|     :::   0x00001188      e853ffffff     call sym.imp.fwrite         ; size_t fwrite(const void *ptr, size_t size, size_t nitems, FILE *stream)
|     :::   0x0000118d      488b15ec2e..   mov rdx, qword [obj.stdin]  ; [0x4080:8]=0 ; FILE *stream
|     :::   0x00001194      be80000000     mov esi, 0x80               ; int size
|     :::   0x00001199      4889df         mov rdi, rbx                ; char *s
|     :::   0x0000119c      e8dffeffff     call sym.imp.fgets          ; char *fgets(char *s, int size, FILE *stream)
|     :::   0x000011a1      4885c0         test rax, rax
|    ,====< 0x000011a4      0f8436030000   je 0x14e0
|    |:::   0x000011aa      488d35e40f..   lea rsi, [0x00002195]       ; "\r\n" ; const char *s2
|    |:::   0x000011b1      4889df         mov rdi, rbx                ; const char *s1
|    |:::   0x000011b4      e8b7feffff     call sym.imp.strcspn        ; size_t strcspn(const char *s1, const char *s2)
|    |:::   0x000011b9      c68404c001..   mov byte [rsp + rax + 0x1c0], 0
|    |:::   0x000011c1      0fb6ac24c0..   movzx ebp, byte [var_1c0h]
|    |:::   0x000011c9      4084ed         test bpl, bpl
|    |`===< 0x000011cc      74a2           je 0x1170
|    | ::   0x000011ce      e85dfeffff     call sym.imp.__ctype_toupper_loc
|    | ::   0x000011d3      488b08         mov rcx, qword [rax]
|    | ::   0x000011d6      4989c6         mov r14, rax
|    | ::   0x000011d9      4889d8         mov rax, rbx
|    | ::   0x000011dc      0f1f4000       nop dword [rax]
|    | ::   ; CODE XREF from main @ 0x11f0(x)
|    |.---> 0x000011e0      8b14a9         mov edx, dword [rcx + rbp*4]
|    |:::   0x000011e3      4883c001       add rax, 1
|    |:::   0x000011e7      8850ff         mov byte [rax - 1], dl
|    |:::   0x000011ea      0fb628         movzx ebp, byte [rax]
|    |:::   0x000011ed      4084ed         test bpl, bpl
|    |`===< 0x000011f0      75ee           jne 0x11e0
|    | ::   0x000011f2      813b52554e00   cmp dword [rbx], 0x4e5552   ; 'RUN'
|    |,===< 0x000011f8      0f84ba010000   je 0x13b8
|    ||::   0x000011fe      4983fc0d       cmp r12, 0xd
|   ,=====< 0x00001202      0f8798010000   ja 0x13a0
|   |||::   0x00001208      488d35930f..   lea rsi, [0x000021a2]       ; " \t" ; const char *s2
|   |||::   0x0000120f      4889df         mov rdi, rbx                ; char *s1
|   |||::   0x00001212      e8a9feffff     call sym.imp.strtok         ; char *strtok(char *s1, const char *s2)
|   |||::   0x00001217      31ff           xor edi, edi                ; char *s1
|   |||::   0x00001219      488d35820f..   lea rsi, [0x000021a2]       ; " \t" ; const char *s2
|   |||::   0x00001220      4889c5         mov rbp, rax
|   |||::   0x00001223      e898feffff     call sym.imp.strtok         ; char *strtok(char *s1, const char *s2)
|   |||::   0x00001228      31ff           xor edi, edi                ; char *s1
|   |||::   0x0000122a      488d35710f..   lea rsi, [0x000021a2]       ; " \t" ; const char *s2
|   |||::   0x00001231      4989c7         mov r15, rax
|   |||::   0x00001234      e887feffff     call sym.imp.strtok         ; char *strtok(char *s1, const char *s2)
|   |||::   0x00001239      31ff           xor edi, edi                ; char *s1
|   |||::   0x0000123b      488d35600f..   lea rsi, [0x000021a2]       ; " \t" ; const char *s2
|   |||::   0x00001242      4989c5         mov r13, rax
|   |||::   0x00001245      e876feffff     call sym.imp.strtok         ; char *strtok(char *s1, const char *s2)
|   |||::   0x0000124a      4885ed         test rbp, rbp
|  ,======< 0x0000124d      0f844d010000   je 0x13a0
|  ||||::   0x00001253      4d85ff         test r15, r15
| ,=======< 0x00001256      0f8444010000   je 0x13a0
| |||||::   0x0000125c      4d85ed         test r13, r13
| ========< 0x0000125f      0f843b010000   je 0x13a0
| |||||::   0x00001265      4885c0         test rax, rax
| ========< 0x00001268      0f8532010000   jne 0x13a0
| |||||::   0x0000126e      0fb64500       movzx eax, byte [rbp]
| |||||::   0x00001272      84c0           test al, al
| ========< 0x00001274      741e           je 0x1294
| |||||::   0x00001276      4889ea         mov rdx, rbp
| |||||::   0x00001279      0f1f800000..   nop dword [rax]
| |||||::   ; CODE XREF from main @ 0x1292(x)
| --------> 0x00001280      498b0e         mov rcx, qword [r14]
| |||||::   0x00001283      4883c201       add rdx, 1
| |||||::   0x00001287      8b0481         mov eax, dword [rcx + rax*4]
| |||||::   0x0000128a      8842ff         mov byte [rdx - 1], al
| |||||::   0x0000128d      0fb602         movzx eax, byte [rdx]
| |||||::   0x00001290      84c0           test al, al
| ========< 0x00001292      75ec           jne 0x1280
| |||||::   ; CODE XREF from main @ 0x1274(x)
| --------> 0x00001294      410fb607       movzx eax, byte [r15]
| |||||::   0x00001298      84c0           test al, al
| ========< 0x0000129a      7418           je 0x12b4
| |||||::   0x0000129c      4c89fa         mov rdx, r15
| |||||::   0x0000129f      90             nop
| |||||::   ; CODE XREF from main @ 0x12b2(x)
| --------> 0x000012a0      498b0e         mov rcx, qword [r14]
| |||||::   0x000012a3      4883c201       add rdx, 1
| |||||::   0x000012a7      8b0481         mov eax, dword [rcx + rax*4]
| |||||::   0x000012aa      8842ff         mov byte [rdx - 1], al
| |||||::   0x000012ad      0fb602         movzx eax, byte [rdx]
| |||||::   0x000012b0      84c0           test al, al
| ========< 0x000012b2      75ec           jne 0x12a0
| |||||::   ; CODE XREF from main @ 0x129a(x)
| --------> 0x000012b4      410fb64500     movzx eax, byte [r13]
| |||||::   0x000012b9      84c0           test al, al
| ========< 0x000012bb      7417           je 0x12d4
| |||||::   0x000012bd      4c89ea         mov rdx, r13
| |||||::   ; CODE XREF from main @ 0x12d2(x)
| --------> 0x000012c0      498b0e         mov rcx, qword [r14]
| |||||::   0x000012c3      4883c201       add rdx, 1
| |||||::   0x000012c7      8b0481         mov eax, dword [rcx + rax*4]
| |||||::   0x000012ca      8842ff         mov byte [rdx - 1], al
| |||||::   0x000012cd      0fb602         movzx eax, byte [rdx]
| |||||::   0x000012d0      84c0           test al, al
| ========< 0x000012d2      75ec           jne 0x12c0
| |||||::   ; CODE XREF from main @ 0x12bb(x)
| --------> 0x000012d4      488d742416     lea rsi, [var_16h]          ; int64_t arg2
| |||||::   0x000012d9      4c89ff         mov rdi, r15                ; int64_t arg1
| |||||::   0x000012dc      e85f070000     call fcn.00001a40
| |||||::   0x000012e1      85c0           test eax, eax
| ========< 0x000012e3      0f84b7000000   je 0x13a0
| |||||::   0x000012e9      488d35b50e..   lea rsi, str.MOVI           ; 0x21a5 ; "MOVI" ; const char *s2
| |||||::   0x000012f0      4889ef         mov rdi, rbp                ; const char *s1
| |||||::   0x000012f3      e898fdffff     call sym.imp.strcmp         ; int strcmp(const char *s1, const char *s2)
| |||||::   0x000012f8      85c0           test eax, eax
| ========< 0x000012fa      0f848a000000   je 0x138a
| |||||::   0x00001300      488d35a30e..   lea rsi, [0x000021aa]       ; "ADD" ; const char *s2
| |||||::   0x00001307      4889ef         mov rdi, rbp                ; const char *s1
| |||||::   0x0000130a      e881fdffff     call sym.imp.strcmp         ; int strcmp(const char *s1, const char *s2)
| |||||::   0x0000130f      85c0           test eax, eax
| ========< 0x00001311      0f84f8020000   je 0x160f
| |||||::   0x00001317      488d35900e..   lea rsi, [0x000021ae]       ; "XOR" ; const char *s2
| |||||::   0x0000131e      4889ef         mov rdi, rbp                ; const char *s1
| |||||::   0x00001321      e86afdffff     call sym.imp.strcmp         ; int strcmp(const char *s1, const char *s2)
| |||||::   0x00001326      85c0           test eax, eax
| ========< 0x00001328      0f84c5030000   je 0x16f3
| |||||::   0x0000132e      488d357d0e..   lea rsi, [0x000021b2]       ; "ROL" ; const char *s2
| |||||::   0x00001335      4889ef         mov rdi, rbp                ; const char *s1
| |||||::   0x00001338      e853fdffff     call sym.imp.strcmp         ; int strcmp(const char *s1, const char *s2)
| |||||::   0x0000133d      85c0           test eax, eax
| ========< 0x0000133f      0f846f030000   je 0x16b4
| |||||::   0x00001345      488d356a0e..   lea rsi, str.SWAP           ; 0x21b6 ; "SWAP" ; const char *s2
| |||||::   0x0000134c      4889ef         mov rdi, rbp                ; const char *s1
| |||||::   0x0000134f      e83cfdffff     call sym.imp.strcmp         ; int strcmp(const char *s1, const char *s2)
| |||||::   0x00001354      85c0           test eax, eax
| ========< 0x00001356      0f84d9030000   je 0x1735
| |||||::   0x0000135c      488d35580e..   lea rsi, [0x000021bb]       ; "MIX" ; const char *s2
| |||||::   0x00001363      4889ef         mov rdi, rbp                ; const char *s1
| |||||::   0x00001366      e825fdffff     call sym.imp.strcmp         ; int strcmp(const char *s1, const char *s2)
| |||||::   0x0000136b      85c0           test eax, eax
| ========< 0x0000136d      7531           jne 0x13a0
| |||||::   0x0000136f      488d742417     lea rsi, [var_17h]          ; int64_t arg2
| |||||::   0x00001374      4c89ef         mov rdi, r13                ; int64_t arg1
| |||||::   0x00001377      e8c4060000     call fcn.00001a40
| |||||::   0x0000137c      85c0           test eax, eax
| ========< 0x0000137e      7420           je 0x13a0
| |||||::   0x00001380      ba6f000000     mov edx, 0x6f               ; 'o'
| ========< 0x00001385      e9f6020000     jmp 0x1680
| |||||::   ; CODE XREF from main @ 0x12fa(x)
| --------> 0x0000138a      41807d0000     cmp byte [r13], 0
| ========< 0x0000138f      0f85b9020000   jne 0x164e
| |||||::   0x00001395      66662e0f1f..   nop word cs:[rax + rax]
| |||||::   ; XREFS: CODE 0x00001202  CODE 0x0000124d  CODE 0x00001256  
| |||||::   ; XREFS: CODE 0x0000125f  CODE 0x00001268  CODE 0x000012e3  
| |||||::   ; XREFS: CODE 0x0000136d  CODE 0x0000137e  CODE 0x00001614  
| |||||::   ; XREFS: CODE 0x00001631  CODE 0x0000163d  CODE 0x00001665  
| |||||::   ; XREFS: CODE 0x00001671  CODE 0x000016b9  CODE 0x000016d6  
| |||||::   ; XREFS: CODE 0x000016e2  CODE 0x000016f8  CODE 0x00001715  
| |||||::   ; XREFS: CODE 0x00001721  CODE 0x00001744  
| ```-----> 0x000013a0      488d3df50d..   lea rdi, str.fault          ; 0x219c ; "fault" ; const char *s
|    ||::   0x000013a7      e894fcffff     call sym.imp.puts           ; int puts(const char *s)
|    ||`==< 0x000013ac      e9bffdffff     jmp 0x1170
..
|    || :   ; CODE XREF from main @ 0x11f8(x)
|    |`---> 0x000013b8      4983fc0e       cmp r12, 0xe
|    | ,==< 0x000013bc      0f850c010000   jne 0x14ce
|    | |:   0x000013c2      4c8d7c2440     lea r15, [var_40h]
|    | |:   0x000013c7      4c8d6c2470     lea r13, [var_70h]
|    | |:   0x000013cc      440fb6642431   movzx r12d, byte [var_31h]
|    | |:   0x000013d2      31ed           xor ebp, ebp
|    | |:   0x000013d4      4c89ff         mov rdi, r15
|    | |:   0x000013d7      4c89ee         mov rsi, r13
|    | |:   0x000013da      bac59d1c81     mov edx, 0x811c9dc5
|    | |:   0x000013df      90             nop
|    | |:   ; CODE XREF from main @ 0x14a6(x)
|    |.---> 0x000013e0      440fb65702     movzx r10d, byte [rdi + 2]
|    |:|:   0x000013e5      0fb607         movzx eax, byte [rdi]
|    |:|:   0x000013e8      440fb64701     movzx r8d, byte [rdi + 1]
|    |:|:   0x000013ed      4c89d1         mov rcx, r10
|    |:|:   0x000013f0      3c4b           cmp al, 0x4b                ; 'K'
|   ,=====< 0x000013f2      0f84ee010000   je 0x15e6
|  ,======< 0x000013f8      0f8714010000   ja 0x1512
|  |||:|:   0x000013fe      3c27           cmp al, 0x27                ; '\''
| ,=======< 0x00001400      0f84ae010000   je 0x15b4
| ||||:|:   0x00001406      3c39           cmp al, 0x39                ; '9'
| ========< 0x00001408      7422           je 0x142c
| ||||:|:   0x0000140a      3c13           cmp al, 0x13
| ========< 0x0000140c      0f8591020000   jne 0x16a3
| ||||:|:   0x00001412      4180f803       cmp r8b, 3
| ========< 0x00001416      0f8787020000   ja 0x16a3
| ||||:|:   0x0000141c      4489c1         mov ecx, r8d
| ||||:|:   0x0000141f      4183cc01       or r12d, 1
| ||||:|:   0x00001423      31ed           xor ebp, ebp
| ||||:|:   0x00001425      4488548c20     mov byte [rsp + rcx*4 + 0x20], r10b
| ========< 0x0000142a      eb24           jmp 0x1450
| ||||:|:   ; CODE XREF from main @ 0x1408(x)
| --------> 0x0000142c      4180f803       cmp r8b, 3
| ========< 0x00001430      0f876d020000   ja 0x16a3
| ||||:|:   0x00001436      4489c1         mov ecx, r8d
| ||||:|:   0x00001439      4569da0101..   imul r11d, r10d, 0x1010101
| ||||:|:   0x00001440      4183cc04       or r12d, 4
| ||||:|:   0x00001444      44315c8c20     xor dword [rsp + rcx*4 + 0x20], r11d
| ||||:|:   0x00001449      0f1f800000..   nop dword [rax]
| ||||:|:   ; CODE XREFS from main @ 0x142a(x), 0x156a(x), 0x15af(x), 0x15e1(x), 0x160a(x)
| --------> 0x00001450      0fb6c8         movzx ecx, al
| ||||:|:   0x00001453      40886e14       mov byte [rsi + 0x14], bpl
| ||||:|:   0x00001457      4883c618       add rsi, 0x18
| ||||:|:   0x0000145b      4883c703       add rdi, 3
| ||||:|:   0x0000145f      31d1           xor ecx, edx
| ||||:|:   0x00001461      660f6f442420   movdqa xmm0, xmmword [var_20h]
| ||||:|:   0x00001467      69c993010001   imul ecx, ecx, 0x1000193
| ||||:|:   0x0000146d      0f1146e8       movups xmmword [rsi - 0x18], xmm0
| ||||:|:   0x00001471      c1c105         rol ecx, 5
| ||||:|:   0x00001474      4431c1         xor ecx, r8d
| ||||:|:   0x00001477      81f1a5a5a5a5   xor ecx, 0xa5a5a5a5
| ||||:|:   0x0000147d      69c993010001   imul ecx, ecx, 0x1000193
| ||||:|:   0x00001483      c1c105         rol ecx, 5
| ||||:|:   0x00001486      4431d1         xor ecx, r10d
| ||||:|:   0x00001489      89ca           mov edx, ecx
| ||||:|:   0x0000148b      81f2a5a5a5a5   xor edx, 0xa5a5a5a5
| ||||:|:   0x00001491      69d293010001   imul edx, edx, 0x1000193
| ||||:|:   0x00001497      c1c205         rol edx, 5
| ||||:|:   0x0000149a      81f2a5a5a5a5   xor edx, 0xa5a5a5a5
| ||||:|:   0x000014a0      8956f8         mov dword [rsi - 8], edx
| ||||:|:   0x000014a3      4839de         cmp rsi, rbx
| ||||`===< 0x000014a6      0f8534ffffff   jne 0x13e0
| |||| |:   0x000014ac      4488642431     mov byte [var_31h], r12b
| |||| |:   0x000014b1      40886c2430     mov byte [var_30h], bpl
| |||| |:   0x000014b6      817c2420a4..   cmp dword [var_20h], 0xd0f7f5a4
| ||||,===< 0x000014be      750e           jne 0x14ce
| ||||||:   0x000014c0      817c242482..   cmp dword [var_24h], 0x71d63782
| ========< 0x000014c8      0f8486020000   je 0x1754
| ||||||:   ; XREFS: CODE 0x000013bc  CODE 0x000014be  CODE 0x0000175c  
| ||||||:   ; XREFS: CODE 0x0000176a  CODE 0x00001777  CODE 0x00001783  
| ----``--> 0x000014ce      488d3dea0c..   lea rdi, str.rejected       ; 0x21bf ; "rejected" ; const char *s
| ||||  :   0x000014d5      e866fbffff     call sym.imp.puts           ; int puts(const char *s)
| ||||  :   0x000014da      660f1f440000   nop word [rax + rax]
| ||||  :   ; CODE XREFS from main @ 0x11a4(x), 0x16af(x)
| |||`-.--> 0x000014e0      41b901000000   mov r9d, 1
| |||  ::   ; CODE XREF from main @ 0x1929(x)
| ||| .---> 0x000014e6      488b842448..   mov rax, qword [var_248h]
| ||| :::   0x000014ee      64482b0425..   sub rax, qword fs:[0x28]
| |||,====< 0x000014f7      0f8531040000   jne 0x192e
| ||||:::   0x000014fd      4881c45802..   add rsp, 0x258
| ||||:::   0x00001504      4489c8         mov eax, r9d
| ||||:::   0x00001507      5b             pop rbx
| ||||:::   0x00001508      5d             pop rbp
| ||||:::   0x00001509      415c           pop r12
| ||||:::   0x0000150b      415d           pop r13
| ||||:::   0x0000150d      415e           pop r14
| ||||:::   0x0000150f      415f           pop r15
| ||||:::   0x00001511      c3             ret
| ||||:::   ; CODE XREF from main @ 0x13f8(x)
| |`------> 0x00001512      3c5d           cmp al, 0x5d                ; ']'
| |,======< 0x00001514      7459           je 0x156f
| ||||:::   0x00001516      3c6f           cmp al, 0x6f                ; 'o'
| ========< 0x00001518      0f8585010000   jne 0x16a3
| ||||:::   0x0000151e      4589c3         mov r11d, r8d
| ||||:::   0x00001521      4509d3         or r11d, r10d
| ||||:::   0x00001524      4180fb03       cmp r11b, 3
| ========< 0x00001528      0f8775010000   ja 0x16a3
| ||||:::   0x0000152e      4538d0         cmp r8b, r10b
| ========< 0x00001531      0f846c010000   je 0x16a3
| ||||:::   0x00001537      4589c6         mov r14d, r8d
| ||||:::   0x0000153a      4489d1         mov ecx, r10d
| ||||:::   0x0000153d      400fb6ed       movzx ebp, bpl
| ||||:::   0x00001541      4183cc20       or r12d, 0x20               ; "@"
| ||||:::   0x00001545      8b4c8c20       mov ecx, dword [rsp + rcx*4 + 0x20]
| ||||:::   0x00001549      468b5cb420     mov r11d, dword [rsp + r14*4 + 0x20]
| ||||:::   0x0000154e      4131cb         xor r11d, ecx
| ||||:::   0x00001551      83e107         and ecx, 7
| ||||:::   0x00001554      83c101         add ecx, 1
| ||||:::   0x00001557      41d3c3         rol r11d, cl
| ||||:::   0x0000155a      418dac2bb9..   lea ebp, [r11 + rbp - 0x61c88647]
| ||||:::   0x00001562      42896cb420     mov dword [rsp + r14*4 + 0x20], ebp
| ||||:::   0x00001567      c1ed1f         shr ebp, 0x1f
| ========< 0x0000156a      e9e1feffff     jmp 0x1450
| ||||:::   ; CODE XREF from main @ 0x1514(x)
| |`------> 0x0000156f      4589c3         mov r11d, r8d
| | ||:::   0x00001572      4509d3         or r11d, r10d
| | ||:::   0x00001575      4180fb03       cmp r11b, 3
| |,======< 0x00001579      0f8724010000   ja 0x16a3
| ||||:::   0x0000157f      4538d0         cmp r8b, r10b
| ========< 0x00001582      0f841b010000   je 0x16a3
| ||||:::   0x00001588      4589c3         mov r11d, r8d
| ||||:::   0x0000158b      4183cc10       or r12d, 0x10
| ||||:::   0x0000158f      428b4c9c20     mov ecx, dword [rsp + r11*4 + 0x20]
| ||||:::   0x00001594      894c240c       mov dword [var_ch], ecx
| ||||:::   0x00001598      4489d1         mov ecx, r10d
| ||||:::   0x0000159b      448b748c20     mov r14d, dword [rsp + rcx*4 + 0x20]
| ||||:::   0x000015a0      4689749c20     mov dword [rsp + r11*4 + 0x20], r14d
| ||||:::   0x000015a5      448b5c240c     mov r11d, dword [var_ch]
| ||||:::   0x000015aa      44895c8c20     mov dword [rsp + rcx*4 + 0x20], r11d
| ========< 0x000015af      e99cfeffff     jmp 0x1450
| ||||:::   ; CODE XREF from main @ 0x1400(x)
| `-------> 0x000015b4      4180f803       cmp r8b, 3
| ,=======< 0x000015b8      0f87e5000000   ja 0x16a3
| ||||:::   0x000015be      4589c3         mov r11d, r8d
| ||||:::   0x000015c1      400fb6ed       movzx ebp, bpl
| ||||:::   0x000015c5      468b749c20     mov r14d, dword [rsp + r11*4 + 0x20]
| ||||:::   0x000015ca      4801e9         add rcx, rbp
| ||||:::   0x000015cd      4c01f1         add rcx, r14
| ||||:::   0x000015d0      42894c9c20     mov dword [rsp + r11*4 + 0x20], ecx
| ||||:::   0x000015d5      48c1e920       shr rcx, 0x20
| ||||:::   0x000015d9      400f95c5       setne bpl
| ||||:::   0x000015dd      4183cc02       or r12d, 2
| ========< 0x000015e1      e96afeffff     jmp 0x1450
| ||||:::   ; CODE XREF from main @ 0x13f2(x)
| ||`-----> 0x000015e6      458d5aff       lea r11d, [r10 - 1]
| || |:::   0x000015ea      4180fb1e       cmp r11b, 0x1e
| ||,=====< 0x000015ee      0f87af000000   ja 0x16a3
| ||||:::   0x000015f4      4180f803       cmp r8b, 3
| ========< 0x000015f8      0f87a5000000   ja 0x16a3
| ||||:::   0x000015fe      4589c3         mov r11d, r8d
| ||||:::   0x00001601      4183cc08       or r12d, 8
| ||||:::   0x00001605      42d3449c20     rol dword [rsp + r11*4 + 0x20], cl
| ========< 0x0000160a      e941feffff     jmp 0x1450
| ||||:::   ; CODE XREF from main @ 0x1311(x)
| --------> 0x0000160f      41807d0000     cmp byte [r13], 0
| ========< 0x00001614      0f8486fdffff   je 0x13a0
| ||||:::   0x0000161a      31d2           xor edx, edx                ; int base
| ||||:::   0x0000161c      488d742418     lea rsi, [endptr]           ; char * *endptr
| ||||:::   0x00001621      4c89ef         mov rdi, r13                ; const char *str
| ||||:::   0x00001624      e8a7faffff     call sym.imp.strtoul        ; long strtoul(const char *str, char * *endptr, int base)
| ||||:::   0x00001629      488b542418     mov rdx, qword [endptr]
| ||||:::   0x0000162e      803a00         cmp byte [rdx], 0
| ========< 0x00001631      0f8569fdffff   jne 0x13a0
| ||||:::   0x00001637      483dff000000   cmp rax, 0xff
| ========< 0x0000163d      0f875dfdffff   ja 0x13a0
| ||||:::   0x00001643      88442417       mov byte [var_17h], al
| ||||:::   0x00001647      ba27000000     mov edx, 0x27               ; '\''
| ========< 0x0000164c      eb32           jmp 0x1680
| ||||:::   ; CODE XREF from main @ 0x138f(x)
| --------> 0x0000164e      31d2           xor edx, edx                ; int base
| ||||:::   0x00001650      488d742418     lea rsi, [endptr]           ; char * *endptr
| ||||:::   0x00001655      4c89ef         mov rdi, r13                ; const char *str
| ||||:::   0x00001658      e873faffff     call sym.imp.strtoul        ; long strtoul(const char *str, char * *endptr, int base)
| ||||:::   0x0000165d      488b542418     mov rdx, qword [endptr]
| ||||:::   0x00001662      803a00         cmp byte [rdx], 0
| ========< 0x00001665      0f8535fdffff   jne 0x13a0
| ||||:::   0x0000166b      483dff000000   cmp rax, 0xff
| ========< 0x00001671      0f8729fdffff   ja 0x13a0
| ||||:::   0x00001677      88442417       mov byte [var_17h], al
| ||||:::   0x0000167b      ba13000000     mov edx, 0x13
| ||||:::   ; CODE XREFS from main @ 0x1385(x), 0x164c(x), 0x16f1(x), 0x1730(x), 0x174f(x)
| --------> 0x00001680      4b8d0464       lea rax, [r12 + r12*2]
| ||||:::   0x00001684      4983c401       add r12, 1
| ||||:::   0x00001688      88540440       mov byte [rsp + rax + 0x40], dl
| ||||:::   0x0000168c      0fb6542416     movzx edx, byte [var_16h]
| ||||:::   0x00001691      88540441       mov byte [rsp + rax + 0x41], dl
| ||||:::   0x00001695      0fb6542417     movzx edx, byte [var_17h]
| ||||:::   0x0000169a      88540442       mov byte [rsp + rax + 0x42], dl
| ||||::`=< 0x0000169e      e9cdfaffff     jmp 0x1170
| ||||::    ; XREFS: CODE 0x0000140c  CODE 0x00001416  CODE 0x00001430  
| ||||::    ; XREFS: CODE 0x00001518  CODE 0x00001528  CODE 0x00001531  
| ||||::    ; XREFS: CODE 0x00001579  CODE 0x00001582  CODE 0x000015b8  
| ||||::    ; XREFS: CODE 0x000015ee  CODE 0x000015f8  
| ```-----> 0x000016a3      488d3df20a..   lea rdi, str.fault          ; 0x219c ; "fault" ; const char *s
|    |::    0x000016aa      e891f9ffff     call sym.imp.puts           ; int puts(const char *s)
|    |:`==< 0x000016af      e92cfeffff     jmp 0x14e0
|    |:     ; CODE XREF from main @ 0x133f(x)
| --------> 0x000016b4      41807d0000     cmp byte [r13], 0
| ========< 0x000016b9      0f84e1fcffff   je 0x13a0
|    |:     0x000016bf      31d2           xor edx, edx                ; int base
|    |:     0x000016c1      488d742418     lea rsi, [endptr]           ; char * *endptr
|    |:     0x000016c6      4c89ef         mov rdi, r13                ; const char *str
|    |:     0x000016c9      e802faffff     call sym.imp.strtoul        ; long strtoul(const char *str, char * *endptr, int base)
|    |:     0x000016ce      488b542418     mov rdx, qword [endptr]
|    |:     0x000016d3      803a00         cmp byte [rdx], 0
| ========< 0x000016d6      0f85c4fcffff   jne 0x13a0
|    |:     0x000016dc      483dff000000   cmp rax, 0xff
| ========< 0x000016e2      0f87b8fcffff   ja 0x13a0
|    |:     0x000016e8      88442417       mov byte [var_17h], al
|    |:     0x000016ec      ba4b000000     mov edx, 0x4b               ; 'K'
| ========< 0x000016f1      eb8d           jmp 0x1680
|    |:     ; CODE XREF from main @ 0x1328(x)
| --------> 0x000016f3      41807d0000     cmp byte [r13], 0
| ========< 0x000016f8      0f84a2fcffff   je 0x13a0
|    |:     0x000016fe      31d2           xor edx, edx                ; int base
|    |:     0x00001700      488d742418     lea rsi, [endptr]           ; char * *endptr
|    |:     0x00001705      4c89ef         mov rdi, r13                ; const char *str
|    |:     0x00001708      e8c3f9ffff     call sym.imp.strtoul        ; long strtoul(const char *str, char * *endptr, int base)
|    |:     0x0000170d      488b542418     mov rdx, qword [endptr]
|    |:     0x00001712      803a00         cmp byte [rdx], 0
| ========< 0x00001715      0f8585fcffff   jne 0x13a0
|    |:     0x0000171b      483dff000000   cmp rax, 0xff
| ========< 0x00001721      0f8779fcffff   ja 0x13a0
|    |:     0x00001727      88442417       mov byte [var_17h], al
|    |:     0x0000172b      ba39000000     mov edx, 0x39               ; '9'
| ========< 0x00001730      e94bffffff     jmp 0x1680
|    |:     ; CODE XREF from main @ 0x1356(x)
| --------> 0x00001735      488d742417     lea rsi, [var_17h]          ; int64_t arg2
|    |:     0x0000173a      4c89ef         mov rdi, r13                ; int64_t arg1
|    |:     0x0000173d      e8fe020000     call fcn.00001a40
|    |:     0x00001742      85c0           test eax, eax
| ========< 0x00001744      0f8456fcffff   je 0x13a0
|    |:     0x0000174a      ba5d000000     mov edx, 0x5d               ; ']'
| ========< 0x0000174f      e92cffffff     jmp 0x1680
|    |:     ; CODE XREF from main @ 0x14c8(x)
| --------> 0x00001754      817c2428ac..   cmp dword [var_28h], 0x2c458dac
| ========< 0x0000175c      0f856cfdffff   jne 0x14ce
|    |:     0x00001762      817c242c6c..   cmp dword [var_2ch], 0x8c64de6c
| ========< 0x0000176a      0f855efdffff   jne 0x14ce
|    |:     0x00001770      66817c2430..   cmp word [var_30h], 0x3f01
| ========< 0x00001777      0f8551fdffff   jne 0x14ce
|    |:     0x0000177d      81f9b32fd30d   cmp ecx, 0xdd32fb3
| ========< 0x00001783      0f8545fdffff   jne 0x14ce
|    |:     0x00001789      8b9c240401..   mov ebx, dword [var_104h]
|    |:     0x00001790      8b8424b001..   mov eax, dword [var_1b0h]
|    |:     0x00001797      31ed           xor ebp, ebp
|    |:     0x00001799      ba04000000     mov edx, 4                  ; size_t nitems
|    |:     0x0000179e      488b0dcb28..   mov rcx, qword [obj.stdout] ; [0x4070:8]=0 ; FILE *stream
|    |:     0x000017a5      be01000000     mov esi, 1                  ; size_t size
|    |:     0x000017aa      488d3d170a..   lea rdi, str.__             ; 0x21c8 ; "[+]" ; const void *ptr
|    |:     0x000017b1      4989ee         mov r14, rbp
|    |:     0x000017b4      c1c00d         rol eax, 0xd
|    |:     0x000017b7      c1c307         rol ebx, 7
|    |:     0x000017ba      bdb979379e     mov ebp, 0x9e3779b9
|    |:     0x000017bf      49bc254992..   movabs r12, 0x4924924924924925
|    |:     0x000017c9      31c3           xor ebx, eax
|    |:     0x000017cb      31c0           xor eax, eax
|    |:     0x000017cd      335c2470       xor ebx, dword [var_70h]
|    |:     0x000017d1      8944240c       mov dword [var_ch], eax
|    |:     0x000017d5      81f332711776   xor ebx, 0x76177132
|    |:     0x000017db      e800f9ffff     call sym.imp.fwrite         ; size_t fwrite(const void *ptr, size_t size, size_t nitems, FILE *stream)
|    |:     ; CODE XREF from main @ 0x190d(x)
|    |: .-> 0x000017e0      4b8d74b601     lea rsi, [r14 + r14*4 + 1]
|    |: :   0x000017e5      4889f2         mov rdx, rsi
|    |: :   0x000017e8      48d1ea         shr rdx, 1
|    |: :   0x000017eb      4889d0         mov rax, rdx
|    |: :   0x000017ee      49f7e4         mul r12
|    |: :   0x000017f1      4889d1         mov rcx, rdx
|    |: :   0x000017f4      48d1e9         shr rcx, 1
|    |: :   0x000017f7      486bc10e       imul rax, rcx, 0xe
|    |: :   0x000017fb      4c89f1         mov rcx, r14
|    |: :   0x000017fe      4829c6         sub rsi, rax
|    |: :   0x00001801      4c8d1476       lea r10, [rsi + rsi*2]
|    |: :   0x00001805      4b8d74f604     lea rsi, [r14 + r14*8 + 4]
|    |: :   0x0000180a      4889f2         mov rdx, rsi
|    |: :   0x0000180d      4f8d4cd500     lea r9, [r13 + r10*8]
|    |: :   0x00001812      48d1ea         shr rdx, 1
|    |: :   0x00001815      4889d0         mov rax, rdx
|    |: :   0x00001818      49f7e4         mul r12
|    |: :   0x0000181b      48d1ea         shr rdx, 1
|    |: :   0x0000181e      486bc20e       imul rax, rdx, 0xe
|    |: :   0x00001822      4829c6         sub rsi, rax
|    |: :   0x00001825      488d1476       lea rdx, [rsi + rsi*2]
|    |: :   0x00001829      498d3417       lea rsi, [r15 + rdx]
|    |: :   0x0000182d      498d7cd500     lea rdi, [r13 + rdx*8]
|    |: :   0x00001832      0fb64601       movzx eax, byte [rsi + 1]
|    |: :   0x00001836      4c01f0         add rax, r14
|    |: :   0x00001839      83e003         and eax, 3
|    |: :   0x0000183c      41331c81       xor ebx, dword [r9 + rax*4]
|    |: :   0x00001840      48b8c54eec..   movabs rax, 0x4ec4ec4ec4ec4ec5
|    |: :   0x0000184a      49f7e6         mul r14
|    |: :   0x0000184d      48c1ea02       shr rdx, 2
|    |: :   0x00001851      488d0452       lea rax, [rdx + rdx*2]
|    |: :   0x00001855      488d0482       lea rax, [rdx + rax*4]
|    |: :   0x00001859      0fb65602       movzx edx, byte [rsi + 2]
|    |: :   0x0000185d      0fb636         movzx esi, byte [rsi]
|    |: :   0x00001860      4829c1         sub rcx, rax
|    |: :   0x00001863      8b4710         mov eax, dword [rdi + 0x10]
|    |: :   0x00001866      0fb67f14       movzx edi, byte [rdi + 0x14]
|    |: :   0x0000186a      83c101         add ecx, 1
|    |: :   0x0000186d      d3c0           rol eax, cl
|    |: :   0x0000186f      4b8d0c17       lea rcx, [r15 + r10]
|    |: :   0x00001873      01d8           add eax, ebx
|    |: :   0x00001875      440fb65101     movzx r10d, byte [rcx + 1]
|    |: :   0x0000187a      0fb619         movzx ebx, byte [rcx]
|    |: :   0x0000187d      41c1e210       shl r10d, 0x10
|    |: :   0x00001881      c1e318         shl ebx, 0x18
|    |: :   0x00001884      4409d3         or ebx, r10d
|    |: :   0x00001887      09fb           or ebx, edi
|    |: :   0x00001889      0fb6fa         movzx edi, dl
|    |: :   0x0000188c      c1e708         shl edi, 8
|    |: :   0x0000188f      09fb           or ebx, edi
|    |: :   0x00001891      31c3           xor ebx, eax
|    |: :   0x00001893      89d8           mov eax, ebx
|    |: :   0x00001895      c1e00d         shl eax, 0xd
|    |: :   0x00001898      31c3           xor ebx, eax
|    |: :   0x0000189a      89d8           mov eax, ebx
|    |: :   0x0000189c      c1e811         shr eax, 0x11
|    |: :   0x0000189f      31c3           xor ebx, eax
|    |: :   0x000018a1      89d8           mov eax, ebx
|    |: :   0x000018a3      c1e005         shl eax, 5
|    |: :   0x000018a6      31c3           xor ebx, eax
|    |: :   0x000018a8      b81d000000     mov eax, 0x1d
|    |: :   0x000018ad      01eb           add ebx, ebp
|    |: :   0x000018af      f66102         mul byte [rcx + 2]
|    |: :   0x000018b2      4489f1         mov ecx, r14d
|    |: :   0x000018b5      d2c2           rol dl, cl
|    |: :   0x000018b7      410fb64914     movzx ecx, byte [r9 + 0x14]
|    |: :   0x000018bc      89df           mov edi, ebx
|    |: :   0x000018be      4189da         mov r10d, ebx
|    |: :   0x000018c1      41c1ea18       shr r10d, 0x18
|    |: :   0x000018c5      4189d3         mov r11d, edx
|    |: :   0x000018c8      c1ef10         shr edi, 0x10
|    |: :   0x000018cb      488d150e09..   lea rdx, [0x000021e0]
|    |: :   0x000018d2      f6d9           neg cl
|    |: :   0x000018d4      19c9           sbb ecx, ecx
|    |: :   0x000018d6      42323432       xor sil, byte [rdx + r14]
|    |: :   0x000018da      4983c601       add r14, 1
|    |: :   0x000018de      81c53b9f5d04   add ebp, 0x45d9f3b
|    |: :   0x000018e4      31c6           xor esi, eax
|    |: :   0x000018e6      83e1a7         and ecx, 0xffffffa7         ; 4294967207
|    |: :   0x000018e9      89f2           mov edx, esi
|    |: :   0x000018eb      488b357e27..   mov rsi, qword [obj.stdout] ; [0x4070:8]=0 ; FILE *stream
|    |: :   0x000018f2      4431da         xor edx, r11d
|    |: :   0x000018f5      31da           xor edx, ebx
|    |: :   0x000018f7      30fa           xor dl, bh
|    |: :   0x000018f9      31d7           xor edi, edx
|    |: :   0x000018fb      4431d7         xor edi, r10d
|    |: :   0x000018fe      31cf           xor edi, ecx
|    |: :   0x00001900      400fb6ff       movzx edi, dil              ; int c
|    |: :   0x00001904      e897f7ffff     call sym.imp.putc           ; int putc(int c, FILE *stream)
|    |: :   0x00001909      4983fe31       cmp r14, 0x31               ; '1'
|    |: `=< 0x0000190d      0f85cdfeffff   jne 0x17e0
|    |:     0x00001913      488b355627..   mov rsi, qword [obj.stdout] ; [0x4070:8]=0 ; FILE *stream
|    |:     0x0000191a      bf0a000000     mov edi, 0xa                ; int c
|    |:     0x0000191f      e87cf7ffff     call sym.imp.putc           ; int putc(int c, FILE *stream)
|    |:     0x00001924      448b4c240c     mov r9d, dword [var_ch]
|    |`===< 0x00001929      e9b8fbffff     jmp 0x14e6
|    |      ; CODE XREF from main @ 0x14f7(x)
\    `----> 0x0000192e      e82df7ffff     call sym.imp.__stack_chk_fail ; void stack_chk_fail(void)
