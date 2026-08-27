            ;-- section..text:
            ; DATA XREF from entry0 @ 0x15c8(r)
/ 1237: int main (int argc, char **argv, char **envp);
| afv: vars(19:sp[0x8..0x220])
|           0x000010d0      4881ec2802..   sub rsp, 0x228              ; [12] -r-x section size 1497 named .text
|           0x000010d7      488b3d822f..   mov rdi, qword [obj.stdout] ; [0x4060:8]=0 ; FILE*stream
|           0x000010de      31f6           xor esi, esi                ; char *buf
|           0x000010e0      ba02000000     mov edx, 2                  ; int mode
|           0x000010e5      64488b0c25..   mov rcx, qword fs:[0x28]
|           0x000010ee      48898c24e8..   mov qword [var_1e8h], rcx
|           0x000010f6      31c9           xor ecx, ecx                ; size_t size
|           0x000010f8      e893ffffff     call sym.imp.setvbuf        ; int setvbuf(FILE*stream, char *buf, int mode, size_t size)
|           0x000010fd      488d3d040f..   lea rdi, str._n_n_______________COLD_START________________n_n_nThe_system_was_powered_down_unexpectedly._n ; 0x2008 ; "\n========================================\n               COLD START               \n========================================\n\nThe system was powered down unexpectedly.\n" ; const char *s
|           0x00001104      e827ffffff     call sym.imp.puts           ; int puts(const char *s)
|           0x00001109      ba11000000     mov edx, 0x11               ; size_t nitems
|           0x0000110e      488b0d4b2f..   mov rcx, qword [obj.stdout] ; [0x4060:8]=0 ; FILE *stream
|           0x00001115      be01000000     mov esi, 1                  ; size_t size
|           0x0000111a      488d3d8f0f..   lea rdi, str.activation_seed_ ; 0x20b0 ; "activation seed>" ; const void *ptr
|           0x00001121      e88affffff     call sym.imp.fwrite         ; size_t fwrite(const void *ptr, size_t size, size_t nitems, FILE *stream)
|           0x00001126      488b15432f..   mov rdx, qword [obj.stdin]  ; [0x4070:8]=0 ; FILE *stream
|           0x0000112d      be40000000     mov esi, segment.PHDR       ; elf_phdr
|                                                                      ; 0x40 ; int size
|           0x00001132      488dbc24a0..   lea rdi, [str]              ; char *s
|           0x0000113a      e831ffffff     call sym.imp.fgets          ; char *fgets(char *s, int size, FILE *stream)
|           0x0000113f      4885c0         test rax, rax
|       ,=< 0x00001142      0f84d1020000   je 0x1419
|       |   0x00001148      488dbc24a0..   lea rdi, [str]              ; const char *s1
|       |   0x00001150      488d356b0f..   lea rsi, [0x000020c2]       ; "\r\n" ; const char *s2
|       |   0x00001157      e804ffffff     call sym.imp.strcspn        ; size_t strcspn(const char *s1, const char *s2)
|       |   0x0000115c      488dbc24a0..   lea rdi, [str]              ; const char *s
|       |   0x00001164      c68404a001..   mov byte [rsp + rax + 0x1a0], 0
|       |   0x0000116c      e8cffeffff     call sym.imp.strlen         ; size_t strlen(const char *s)
|       |   0x00001171      4883f806       cmp rax, 6
|      ,==< 0x00001175      0f8592020000   jne 0x140d
|      ||   0x0000117b      e840ffffff     call sym.imp.__ctype_b_loc
|      ||   0x00001180      488db424a6..   lea rsi, [var_1a6h]
|      ||   0x00001188      488b08         mov rcx, qword [rax]
|      ||   0x0000118b      488d8424a0..   lea rax, [str]
|      ||   ; CODE XREF from main @ 0x11a8(x)
|     .---> 0x00001193      0fb610         movzx edx, byte [rax]
|     :||   0x00001196      f644510110     test byte [rcx + rdx*2 + 1], 0x10
|    ,====< 0x0000119b      0f846c020000   je 0x140d
|    |:||   0x000011a1      4883c001       add rax, 1
|    |:||   0x000011a5      4839c6         cmp rsi, rax
|    |`===< 0x000011a8      75e9           jne 0x1193
|    | ||   0x000011aa      488d742408     lea rsi, [endptr]           ; char * *endptr
|    | ||   0x000011af      ba10000000     mov edx, 0x10               ; int base
|    | ||   0x000011b4      488dbc24a0..   lea rdi, [str]              ; const char *str
|    | ||   0x000011bc      4889ac2400..   mov qword [var_200h], rbp
|    | ||   0x000011c4      e8d7feffff     call sym.imp.strtoul        ; long strtoul(const char *str, char * *endptr, int base)
|    | ||   0x000011c9      4889c5         mov rbp, rax
|    | ||   0x000011cc      488b442408     mov rax, qword [endptr]
|    | ||   0x000011d1      803800         cmp byte [rax], 0
|    |,===< 0x000011d4      0f8563020000   jne 0x143d
|    ||||   0x000011da      48899c24f8..   mov qword [var_1f8h], rbx
|    ||||   0x000011e2      4c89a42408..   mov qword [var_208h], r12
|    ||||   0x000011ea      4c89ac2410..   mov qword [var_210h], r13
|    ||||   0x000011f2      4c89b42418..   mov qword [canary], r14
|    ||||   0x000011fa      4c89bc2420..   mov qword [var_220h], r15
|    ||||   0x00001202      4881fdffff..   cmp rbp, 0xffffff
|   ,=====< 0x00001209      0f87ce010000   ja 0x13dd
|   |||||   0x0000120f      69fdb179379e   imul edi, ebp, 0x9e3779b1
|   |||||   0x00001215      89ea           mov edx, ebp
|   |||||   0x00001217      89e8           mov eax, ebp
|   |||||   0x00001219      4189e8         mov r8d, ebp
|   |||||   0x0000121c      c1e205         shl edx, 5
|   |||||   0x0000121f      c1e803         shr eax, 3
|   |||||   0x00001222      4181f0c39a..   xor r8d, 0xa3c59ac3
|   |||||   0x00001229      4531db         xor r11d, r11d
|   |||||   0x0000122c      31c2           xor edx, eax
|   |||||   0x0000122e      4531d2         xor r10d, r10d
|   |||||   0x00001231      4531c9         xor r9d, r9d
|   |||||   0x00001234      31f6           xor esi, esi
|   |||||   0x00001236      c1c707         rol edi, 7
|   |||||   0x00001239      81f2c59d1c81   xor edx, 0x811c9dc5
|   |||||   0x0000123f      4c8d6c2410     lea r13, [stream]
|   |||||   0x00001244      49bcc54eec..   movabs r12, 0x4ec4ec4ec4ec4ec5
|   |||||   0x0000124e      81f79335871b   xor edi, 0x1b873593
|   |||||   0x00001254      488d1de50e..   lea rbx, [0x00002140]
|   |||||   0x0000125b      0f1f440000     nop dword [rax + rax]
|   |||||   ; CODE XREF from main @ 0x132e(x)
|  .------> 0x00001260      89d0           mov eax, edx
|  :|||||   0x00001262      89f1           mov ecx, esi
|  :|||||   0x00001264      4189ff         mov r15d, edi
|  :|||||   0x00001267      4431c0         xor eax, r8d
|  :|||||   0x0000126a      41d3c7         rol r15d, cl
|  :|||||   0x0000126d      4431c8         xor eax, r9d
|  :|||||   0x00001270      4431f8         xor eax, r15d
|  :|||||   0x00001273      440fb6f8       movzx r15d, al
|  :|||||   0x00001277      0fb6c0         movzx eax, al
|  :|||||   0x0000127a      448b3483       mov r14d, dword [rbx + rax*4]
|  :|||||   0x0000127e      4489d0         mov eax, r10d
|  :|||||   0x00001281      4101f7         add r15d, esi
|  :|||||   0x00001284      31e8           xor eax, ebp
|  :|||||   0x00001286      4489f1         mov ecx, r14d
|  :|||||   0x00001289      4401c0         add eax, r8d
|  :|||||   0x0000128c      c1e91b         shr ecx, 0x1b
|  :|||||   0x0000128f      4401f0         add eax, r14d
|  :|||||   0x00001292      83c101         add ecx, 1
|  :|||||   0x00001295      d3c0           rol eax, cl
|  :|||||   0x00001297      428d0c1a       lea ecx, [rdx + r11]
|  :|||||   0x0000129b      4189c0         mov r8d, eax
|  :|||||   0x0000129e      69d293010001   imul edx, edx, 0x1000193
|  :|||||   0x000012a4      4489f0         mov eax, r14d
|  :|||||   0x000012a7      c1e808         shr eax, 8
|  :|||||   0x000012aa      4401c1         add ecx, r8d
|  :|||||   0x000012ad      4401f8         add eax, r15d
|  :|||||   0x000012b0      0fb6c0         movzx eax, al
|  :|||||   0x000012b3      01f2           add edx, esi
|  :|||||   0x000012b5      030c83         add ecx, dword [rbx + rax*4]
|  :|||||   0x000012b8      4101d6         add r14d, edx
|  :|||||   0x000012bb      89c8           mov eax, ecx
|  :|||||   0x000012bd      c1e810         shr eax, 0x10
|  :|||||   0x000012c0      31c8           xor eax, ecx
|  :|||||   0x000012c2      69c02d35eb7f   imul eax, eax, 0x7feb352d
|  :|||||   0x000012c8      89c1           mov ecx, eax
|  :|||||   0x000012ca      c1e90f         shr ecx, 0xf
|  :|||||   0x000012cd      31c8           xor eax, ecx
|  :|||||   0x000012cf      4889f1         mov rcx, rsi
|  :|||||   0x000012d2      69c08ba66c84   imul eax, eax, 0x846ca68b
|  :|||||   0x000012d8      31c7           xor edi, eax
|  :|||||   0x000012da      c1e810         shr eax, 0x10
|  :|||||   0x000012dd      31c7           xor edi, eax
|  :|||||   0x000012df      4889f0         mov rax, rsi
|  :|||||   0x000012e2      49f7e4         mul r12
|  :|||||   0x000012e5      48c1ea02       shr rdx, 2
|  :|||||   0x000012e9      488d0452       lea rax, [rdx + rdx*2]
|  :|||||   0x000012ed      488d0482       lea rax, [rdx + rax*4]
|  :|||||   0x000012f1      4829c1         sub rcx, rax
|  :|||||   0x000012f4      89f8           mov eax, edi
|  :|||||   0x000012f6      83c101         add ecx, 1
|  :|||||   0x000012f9      d3c0           rol eax, cl
|  :|||||   0x000012fb      4431c0         xor eax, r8d
|  :|||||   0x000012fe      4181c13b9f..   add r9d, 0x45d9f3b
|  :|||||   0x00001305      4181c22deb..   add r10d, 0x27d4eb2d
|  :|||||   0x0000130c      4181eb4786..   sub r11d, 0x61c88647
|  :|||||   0x00001313      428d1430       lea edx, [rax + r14]
|  :|||||   0x00001317      89f8           mov eax, edi
|  :|||||   0x00001319      c1c00b         rol eax, 0xb
|  :|||||   0x0000131c      4431c0         xor eax, r8d
|  :|||||   0x0000131f      31d0           xor eax, edx
|  :|||||   0x00001321      418944b500     mov dword [r13 + rsi*4], eax
|  :|||||   0x00001326      4883c601       add rsi, 1
|  :|||||   0x0000132a      4883fe60       cmp rsi, 0x60               ; '`'
|  `======< 0x0000132e      0f852cffffff   jne 0x1260
|   |||||   0x00001334      8b8424cc00..   mov eax, dword [var_cch]
|   |||||   0x0000133b      8b4c243c       mov ecx, dword [var_3ch]
|   |||||   0x0000133f      338c245c01..   xor ecx, dword [var_15ch]
|   |||||   0x00001346      c1c009         rol eax, 9
|   |||||   0x00001349      31c1           xor ecx, eax
|   |||||   0x0000134b      4431c1         xor ecx, r8d
|   |||||   0x0000134e      89c8           mov eax, ecx
|   |||||   0x00001350      c1e810         shr eax, 0x10
|   |||||   0x00001353      31c8           xor eax, ecx
|   |||||   0x00001355      69c02d35eb7f   imul eax, eax, 0x7feb352d
|   |||||   0x0000135b      89c1           mov ecx, eax
|   |||||   0x0000135d      c1e90f         shr ecx, 0xf
|   |||||   0x00001360      31c8           xor eax, ecx
|   |||||   0x00001362      8b8c242001..   mov ecx, dword [var_120h]
|   |||||   0x00001369      69c08ba66c84   imul eax, eax, 0x846ca68b
|   |||||   0x0000136f      c1c10d         rol ecx, 0xd
|   |||||   0x00001372      034c246c       add ecx, dword [var_6ch]
|   |||||   0x00001376      01f9           add ecx, edi
|   |||||   0x00001378      8bbc24ec00..   mov edi, dword [var_ech]
|   |||||   0x0000137f      01d1           add ecx, edx
|   |||||   0x00001381      89c6           mov esi, eax
|   |||||   0x00001383      c1ef0b         shr edi, 0xb
|   |||||   0x00001386      89ca           mov edx, ecx
|   |||||   0x00001388      c1ee10         shr esi, 0x10
|   |||||   0x0000138b      c1ea10         shr edx, 0x10
|   |||||   0x0000138e      31ca           xor edx, ecx
|   |||||   0x00001390      69d22d35eb7f   imul edx, edx, 0x7feb352d
|   |||||   0x00001396      89d1           mov ecx, edx
|   |||||   0x00001398      c1e90f         shr ecx, 0xf
|   |||||   0x0000139b      31ca           xor edx, ecx
|   |||||   0x0000139d      8b4c242c       mov ecx, dword [var_2ch]
|   |||||   0x000013a1      69d28ba66c84   imul edx, edx, 0x846ca68b
|   |||||   0x000013a7      c1e905         shr ecx, 5
|   |||||   0x000013aa      31f9           xor ecx, edi
|   |||||   0x000013ac      338c247c01..   xor ecx, dword [var_17ch]
|   |||||   0x000013b3      31e9           xor ecx, ebp
|   |||||   0x000013b5      4189d0         mov r8d, edx
|   |||||   0x000013b8      41c1e810       shr r8d, 0x10
|   |||||   0x000013bc      6681f98c9c     cmp cx, 0x9c8c
|   |||||   0x000013c1      0f95c1         setne cl
|   |||||   0x000013c4      31f0           xor eax, esi
|   |||||   0x000013c6      3d540ce591     cmp eax, 0x91e50c54
|   |||||   0x000013cb      0f95c0         setne al
|   |||||   0x000013ce      08c1           or cl, al
|  ,======< 0x000013d0      750b           jne 0x13dd
|  ||||||   0x000013d2      4431c2         xor edx, r8d
|  ||||||   0x000013d5      81fabdf8e4c2   cmp edx, 0xc2e4f8bd
| ,=======< 0x000013db      746a           je 0x1447
| |||||||   ; CODE XREFS from main @ 0x1209(x), 0x13d0(x)
| |``-----> 0x000013dd      488b9c24f8..   mov rbx, qword [var_1f8h]
| |  ||||   0x000013e5      488bac2400..   mov rbp, qword [var_200h]
| |  ||||   0x000013ed      4c8ba42408..   mov r12, qword [var_208h]
| |  ||||   0x000013f5      4c8bac2410..   mov r13, qword [var_210h]
| |  ||||   0x000013fd      4c8bb42418..   mov r14, qword [canary]
| |  ||||   0x00001405      4c8bbc2420..   mov r15, qword [var_220h]
| |  ||||   ; CODE XREFS from main @ 0x1175(x), 0x119b(x), 0x1445(x)
| | .`-`--> 0x0000140d      488d3dc20c..   lea rdi, str.Boot_sequence_rejected. ; 0x20d6 ; "Boot sequence rejected." ; const char *s
| | : | |   0x00001414      e817fcffff     call sym.imp.puts           ; int puts(const char *s)
| | : | |   ; CODE XREF from main @ 0x1142(x)
| | : | `-> 0x00001419      b801000000     mov eax, 1
| | : |     ; CODE XREF from main @ 0x156b(x)
| | : | .-> 0x0000141e      488b9424e8..   mov rdx, qword [var_1e8h]
| | : | :   0x00001426      64482b1425..   sub rdx, qword fs:[0x28]
| | : |,==< 0x0000142f      0f853b010000   jne 0x1570
| | : ||:   0x00001435      4881c42802..   add rsp, 0x228
| | : ||:   0x0000143c      c3             ret
| | : ||:   ; CODE XREF from main @ 0x11d4(x)
| | : `---> 0x0000143d      488bac2400..   mov rbp, qword [var_200h]
| | `=====< 0x00001445      ebc6           jmp 0x140d
| |    |:   ; CODE XREF from main @ 0x13db(x)
| `-------> 0x00001447      488d3d770c..   lea rdi, str.System_restored. ; 0x20c5 ; "System restored." ; const char *s
|      |:   0x0000144e      41be07000000   mov r14d, 7
|      |:   0x00001454      41bd0b000000   mov r13d, 0xb
|      |:   0x0000145a      31db           xor ebx, ebx
|      |:   0x0000145c      e8cffbffff     call sym.imp.puts           ; int puts(const char *s)
|      |:   0x00001461      41bc5a000000   mov r12d, 0x5a              ; 'Z'
|      |:   0x00001467      49bfabaaaa..   movabs r15, 0xaaaaaaaaaaaaaaab
|      |:   0x00001471      0f1f4000       nop dword [rax]
|      |:   0x00001475      66662e0f1f..   nop word cs:[rax + rax]
|      |:   ; CODE XREF from main @ 0x1522(x)
|     .---> 0x00001480      4c89e8         mov rax, r13
|     :|:   0x00001483      8d34db         lea esi, [rbx + rbx*8]
|     :|:   0x00001486      488d3d730c..   lea rdi, [0x00002100]
|     :|:   0x0000148d      49f7e7         mul r15
|     :|:   0x00001490      8d34b3         lea esi, [rbx + rsi*4]
|     :|:   0x00001493      4032341f       xor sil, byte [rdi + rbx]
|     :|:   0x00001497      48c1ea06       shr rdx, 6
|     :|:   0x0000149b      488d0452       lea rax, [rdx + rdx*2]
|     :|:   0x0000149f      4c89ea         mov rdx, r13
|     :|:   0x000014a2      4983c511       add r13, 0x11
|     :|:   0x000014a6      48c1e005       shl rax, 5
|     :|:   0x000014aa      4829c2         sub rdx, rax
|     :|:   0x000014ad      4c89f0         mov rax, r14
|     :|:   0x000014b0      8b4c9410       mov ecx, dword [rsp + rdx*4 + 0x10]
|     :|:   0x000014b4      49f7e7         mul r15
|     :|:   0x000014b7      31ce           xor esi, ecx
|     :|:   0x000014b9      48c1ea06       shr rdx, 6
|     :|:   0x000014bd      488d0452       lea rax, [rdx + rdx*2]
|     :|:   0x000014c1      4c89f2         mov rdx, r14
|     :|:   0x000014c4      4983c61d       add r14, 0x1d
|     :|:   0x000014c8      48c1e005       shl rax, 5
|     :|:   0x000014cc      4829c2         sub rdx, rax
|     :|:   0x000014cf      8b449410       mov eax, dword [rsp + rdx*4 + 0x10]
|     :|:   0x000014d3      89f2           mov edx, esi
|     :|:   0x000014d5      30ea           xor dl, ch
|     :|:   0x000014d7      4889d9         mov rcx, rbx
|     :|:   0x000014da      89d6           mov esi, edx
|     :|:   0x000014dc      89c2           mov edx, eax
|     :|:   0x000014de      c1e818         shr eax, 0x18
|     :|:   0x000014e1      c1ea10         shr edx, 0x10
|     :|:   0x000014e4      31d6           xor esi, edx
|     :|:   0x000014e6      31c6           xor esi, eax
|     :|:   0x000014e8      4889d8         mov rax, rbx
|     :|:   0x000014eb      4883c301       add rbx, 1
|     :|:   0x000014ef      49f7e7         mul r15
|     :|:   0x000014f2      4889d0         mov rax, rdx
|     :|:   0x000014f5      4883e2fe       and rdx, 0xfffffffffffffffe
|     :|:   0x000014f9      48d1e8         shr rax, 1
|     :|:   0x000014fc      4801c2         add rdx, rax
|     :|:   0x000014ff      89e8           mov eax, ebp
|     :|:   0x00001501      4829d1         sub rcx, rdx
|     :|:   0x00001504      c1e103         shl ecx, 3
|     :|:   0x00001507      d3e8           shr eax, cl
|     :|:   0x00001509      31c6           xor esi, eax
|     :|:   0x0000150b      4131f4         xor r12d, esi
|     :|:   0x0000150e      488b354b2b..   mov rsi, qword [obj.stdout] ; [0x4060:8]=0 ; FILE *stream
|     :|:   0x00001515      410fb6fc       movzx edi, r12b             ; int c
|     :|:   0x00001519      e862fbffff     call sym.imp.putc           ; int putc(int c, FILE *stream)
|     :|:   0x0000151e      4883fb2a       cmp rbx, 0x2a               ; '*'
|     `===< 0x00001522      0f8558ffffff   jne 0x1480
|      |:   0x00001528      488b35312b..   mov rsi, qword [obj.stdout] ; [0x4060:8]=0 ; FILE *stream
|      |:   0x0000152f      bf0a000000     mov edi, 0xa                ; int c
|      |:   0x00001534      e847fbffff     call sym.imp.putc           ; int putc(int c, FILE *stream)
|      |:   0x00001539      488b9c24f8..   mov rbx, qword [var_1f8h]
|      |:   0x00001541      31c0           xor eax, eax
|      |:   0x00001543      488bac2400..   mov rbp, qword [var_200h]
|      |:   0x0000154b      4c8ba42408..   mov r12, qword [var_208h]
|      |:   0x00001553      4c8bac2410..   mov r13, qword [var_210h]
|      |:   0x0000155b      4c8bb42418..   mov r14, qword [canary]
|      |:   0x00001563      4c8bbc2420..   mov r15, qword [var_220h]
|      |`=< 0x0000156b      e9aefeffff     jmp 0x141e
|      |    ; CODE XREF from main @ 0x142f(x)
|      `--> 0x00001570      48899c24f8..   mov qword [var_1f8h], rbx
|           0x00001578      4889ac2400..   mov qword [var_200h], rbp
|           0x00001580      4c89a42408..   mov qword [var_208h], r12
|           0x00001588      4c89ac2410..   mov qword [var_210h], r13
|           0x00001590      4c89b42418..   mov qword [canary], r14
|           0x00001598      4c89bc2420..   mov qword [var_220h], r15
\           0x000015a0      e8abfaffff     call sym.imp.__stack_chk_fail ; void stack_chk_fail(void)
