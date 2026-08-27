            ;-- section..text:
            ; DATA XREF from entry0 @ 0x1978(r)
/ 2199: int main (int argc, char **argv, char **envp);
| afv: vars(16:sp[0x8..0x120])
|           0x000010c0      4881ec2801..   sub rsp, 0x128              ; [12] -r-x section size 2457 named .text
|           0x000010c7      488b3d922f..   mov rdi, qword [obj.stdout] ; [0x4060:8]=0 ; FILE*stream
|           0x000010ce      ba02000000     mov edx, 2                  ; int mode
|           0x000010d3      31f6           xor esi, esi                ; char *buf
|           0x000010d5      48899c24f8..   mov qword [var_f8h], rbx
|           0x000010dd      488d1d9c2f..   lea rbx, [0x00004080]
|           0x000010e4      4889ac2400..   mov qword [var_100h], rbp
|           0x000010ec      4c89a42408..   mov qword [var_108h], r12
|           0x000010f4      4c89ac2410..   mov qword [var_110h], r13
|           0x000010fc      4c89b42418..   mov qword [var_118h], r14
|           0x00001104      64488b0c25..   mov rcx, qword fs:[0x28]
|           0x0000110d      48898c24e8..   mov qword [var_e8h], rcx
|           0x00001115      31c9           xor ecx, ecx                ; size_t size
|           0x00001117      e864ffffff     call sym.imp.setvbuf        ; int setvbuf(FILE*stream, char *buf, int mode, size_t size)
|           0x0000111c      31d2           xor edx, edx
|           0x0000111e      b8a50de191     mov eax, 0x91e10da5
|           0x00001123      0f1f800000..   nop dword [rax]
|           0x0000112a      66662e0f1f..   nop word cs:[rax + rax]
|           0x00001135      66662e0f1f..   nop word cs:[rax + rax]
|           ; CODE XREF from main @ 0x116f(x)
|       .-> 0x00001140      8d8c103b9f..   lea ecx, [rax + rdx + 0x45d9f3b]
|       :   0x00001147      89c8           mov eax, ecx
|       :   0x00001149      c1e00d         shl eax, 0xd
|       :   0x0000114c      31c8           xor eax, ecx
|       :   0x0000114e      89c1           mov ecx, eax
|       :   0x00001150      c1e911         shr ecx, 0x11
|       :   0x00001153      31c8           xor eax, ecx
|       :   0x00001155      89c1           mov ecx, eax
|       :   0x00001157      c1e105         shl ecx, 5
|       :   0x0000115a      31c8           xor eax, ecx
|       :   0x0000115c      89c1           mov ecx, eax
|       :   0x0000115e      c1e90b         shr ecx, 0xb
|       :   0x00001161      880c13         mov byte [rbx + rdx], cl
|       :   0x00001164      4883c201       add rdx, 1
|       :   0x00001168      4881fa0008..   cmp rdx, 0x800
|       `=< 0x0000116f      75cf           jne 0x1140
|           0x00001171      b8957d0000     mov eax, 0x7d95
|           0x00001176      baf7160000     mov edx, 0x16f7
|           0x0000117b      b9bb9effff     mov ecx, 0xffff9ebb
|           0x00001180      bebc9dffff     mov esi, 0xffff9dbc
|           0x00001185      bf4f140000     mov edi, 0x144f             ; 'O\x14'
|           0x0000118a      6689050f2f..   mov word [0x000040a0], ax   ; [0x40a0:2]=0
|           0x00001191      41b825c6ffff   mov r8d, 0xffffc625
|           0x00001197      41b952d2ffff   mov r9d, 0xffffd252
|           0x0000119d      41ba80d5ffff   mov r10d, 0xffffd580
|           0x000011a3      bdb96c0000     mov ebp, 0x6cb9
|           0x000011a8      41bb85c8ffff   mov r11d, 0xffffc885
|           0x000011ae      41bcdef4ffff   mov r12d, 0xfffff4de        ; 4294964446
|           0x000011b4      41bd5c730000   mov r13d, 0x735c            ; '\\s'
|           0x000011ba      b8a1170000     mov eax, 0x17a1
|           0x000011bf      41be6ea3ffff   mov r14d, 0xffffa36e
|           0x000011c5      6689155830..   mov word [0x00004224], dx   ; [0x4224:2]=0
|           0x000011cc      66890d5830..   mov word [0x0000422b], cx   ; [0x422b:2]=0
|           0x000011d3      bacce1ffff     mov edx, 0xffffe1cc
|           0x000011d8      b9ae98ffff     mov ecx, 0xffff98ae
|           0x000011dd      6689358e31..   mov word [0x00004372], si   ; [0x4372:2]=0
|           0x000011e4      be0a630000     mov esi, 0x630a             ; '\nc'
|           0x000011e9      66893d8731..   mov word [0x00004377], di   ; [0x4377:2]=0
|           0x000011f0      bfdb180000     mov edi, 0x18db
|           0x000011f5      664489050d..   mov word [0x0000410a], r8w  ; [0x410a:2]=0
|           0x000011fd      41b8d9d4ffff   mov r8d, 0xffffd4d9
|           0x00001203      6644890dbf..   mov word [0x000041ca], r9w  ; [0x41ca:2]=0
|           0x0000120b      41b97fddffff   mov r9d, 0xffffdd7f
|           0x00001211      6644891584..   mov word [0x0000429d], r10w ; [0x429d:2]=0
|           0x00001219      41bab8bfffff   mov r10d, 0xffffbfb8
|           0x0000121f      6644891d7d..   mov word [0x000042a4], r11w ; [0x42a4:2]=0
|           0x00001227      41bb5bb9ffff   mov r11d, 0xffffb95b
|           0x0000122d      66892df632..   mov word [0x0000452a], bp   ; [0x452a:2]=0
|           0x00001234      bdc32d0000     mov ebp, 0x2dc3
|           0x00001239      66448925ee..   mov word [0x0000452f], r12w ; [0x452f:2]=0
|           0x00001241      6644892dcd..   mov word [0x00004116], r13w ; [0x4116:2]=0
|           0x00001249      4c8d6c2438     lea r13, [var_38h]
|           0x0000124e      c605d12f00..   mov byte [0x00004226], 0x5b ; '['
|                                                                      ; [0x4226:1]=0
|           0x00001255      c605d12f00..   mov byte [0x0000422d], 0x54 ; 'T'
|                                                                      ; [0x422d:1]=0
|           0x0000125c      c6050d3100..   mov byte [0x00004370], 0x9c ; [0x4370:1]=0
|           0x00001263      c6050f3100..   mov byte [0x00004379], 0xaa ; [0x4379:1]=0
|           0x0000126a      c605522f00..   mov byte [0x000041c3], 0xe9 ; [0x41c3:1]=0
|           0x00001271      c6054f2f00..   mov byte [0x000041c7], 6    ; [0x41c7:1]=0
|           0x00001278      c6054d2f00..   mov byte [0x000041cc], 9    ; [0x41cc:1]=0
|           0x0000127f      c605663100..   mov byte [0x000043ec], 0xad ; [0x43ec:1]=0
|           0x00001286      c705613100..   mov dword [0x000043f1], 0xb85b2fde ; [0x43f1:4]=0
|           0x00001290      c6055e3100..   mov byte [0x000043f5], 0x8a ; [0x43f5:1]=0
|           0x00001297      c605013000..   mov byte [0x0000429f], 0x5c ; '\\'
|                                                                      ; [0x429f:1]=0
|           0x0000129e      c605013000..   mov byte [0x000042a6], 0x80 ; [0x42a6:1]=0
|           0x000012a5      c6057c3200..   mov byte [0x00004528], 0x57 ; 'W'
|                                                                      ; [0x4528:1]=0
|           0x000012ac      c6057e3200..   mov byte [0x00004531], 0x4c ; 'L'
|                                                                      ; [0x4531:1]=0
|           0x000012b3      c605bc2e00..   mov byte [0x00004176], 0xdf ; [0x4176:1]=0
|           0x000012ba      c605b92e00..   mov byte [0x0000417a], 0x3d ; '='
|                                                                      ; [0x417a:1]=0
|           0x000012c1      66448935b4..   mov word [0x0000417d], r14w ; [0x417d:2]=0
|           0x000012c9      c605af2e00..   mov byte [0x0000417f], 0x57 ; 'W'
|                                                                      ; [0x417f:1]=0
|           0x000012d0      c605043300..   mov byte [0x000045db], 0x6b ; 'k'
|                                                                      ; [0x45db:1]=0
|           0x000012d7      c705ff3200..   mov dword [0x000045e0], 0x45027e74 ; [0x45e0:4]=0
|           0x000012e1      c605fc3200..   mov byte [0x000045e4], 0xb8 ; [0x45e4:1]=0
|           0x000012e8      668905a830..   mov word [0x00004397], ax   ; [0x4397:2]=0
|           0x000012ef      b8028bffff     mov eax, 0xffff8b02
|           0x000012f4      668905a330..   mov word [0x0000439e], ax   ; [0x439e:2]=0
|           0x000012fb      b8b70c0000     mov eax, 0xcb7              ; 3255
|           0x00001300      6689050734..   mov word [0x0000470e], ax   ; [0x470e:2]=0
|           0x00001307      b85db0ffff     mov eax, 0xffffb05d
|           0x0000130c      6689050034..   mov word [0x00004713], ax   ; [0x4713:2]=0
|           0x00001313      b8c0e4ffff     mov eax, 0xffffe4c0
|           0x00001318      66893d0f2e..   mov word [0x0000412e], di   ; [0x412e:2]=0
|           0x0000131f      488d3de20c..   lea rdi, str._n__________________________________________________n__________________________________________________n_________________B_D_S_e_c___C_T_F___2_0_2_6_____n____________________________________________________n___________________________________________________n___________________BORROWED_MEMORY_________________n___________________________________________________n____________0x________0x________0x_________________n___________________________________________________n ; 0x2008 ; "\n        _________________________________________\n       /                                         \\\n      /          B D S e c   C T F   2 0 2 6    \\\n     /_____________________________________________\\\n     |                                             |\n     |              BORROWED MEMORY                |\n     |                                             |\n     |       0x???? -> 0x???? -> 0x????            |\n     |_____________________________________________|\n" ; const char *s
|           0x00001326      668915b42f..   mov word [0x000042e1], dx   ; [0x42e1:2]=0
|           0x0000132d      66890d072e..   mov word [0x0000413b], cx   ; [0x413b:2]=0
|           0x00001334      668935052e..   mov word [0x00004140], si   ; [0x4140:2]=0
|           0x0000133b      6644890556..   mov word [0x00004699], r8w  ; [0x4699:2]=0
|           0x00001343      6644890d16..   mov word [0x00004661], r9w  ; [0x4661:2]=0
|           0x0000134b      6644891515..   mov word [0x00004668], r10w ; [0x4668:2]=0
|           0x00001353      668905c82d..   mov word [0x00004122], ax   ; [0x4122:2]=0
|           0x0000135a      c605383000..   mov byte [0x00004399], 0x61 ; 'a'
|                                                                      ; [0x4399:1]=0
|           0x00001361      c605383000..   mov byte [0x000043a0], 0x3c ; '<'
|                                                                      ; [0x43a0:1]=0
|           0x00001368      c6059d3300..   mov byte [0x0000470c], 0x13 ; [0x470c:1]=0
|           0x0000136f      c6059f3300..   mov byte [0x00004715], 0x6d ; 'm'
|                                                                      ; [0x4715:1]=0
|           0x00001376      c6055d2f00..   mov byte [0x000042da], 0x8a ; [0x42da:1]=0
|           0x0000137d      c6055a2f00..   mov byte [0x000042de], 0xed ; [0x42de:1]=0
|           0x00001384      c605582f00..   mov byte [0x000042e3], 0xb7 ; [0x42e3:1]=0
|           0x0000138b      c6052b3400..   mov byte [0x000047bd], 0x27 ; '\''
|                                                                      ; [0x47bd:1]=0
|           0x00001392      c705263400..   mov dword [0x000047c2], 0x38190000 ; [0x47c2:4]=0
|           0x0000139c      c605233400..   mov byte [0x000047c6], 0x85 ; [0x47c6:1]=0
|           0x000013a3      c6058f2d00..   mov byte [0x00004139], 0xd5 ; [0x4139:1]=0
|           0x000013aa      c605912d00..   mov byte [0x00004142], 0x45 ; 'E'
|                                                                      ; [0x4142:1]=0
|           0x000013b1      c605da3200..   mov byte [0x00004692], 3    ; [0x4692:1]=0
|           0x000013b8      c605d73200..   mov byte [0x00004696], 0x62 ; 'b'
|                                                                      ; [0x4696:1]=0
|           0x000013bf      c605d53200..   mov byte [0x0000469b], 0x89 ; [0x469b:1]=0
|           0x000013c6      c605233100..   mov byte [0x000044f0], 0x4e ; 'N'
|                                                                      ; [0x44f0:1]=0
|           0x000013cd      c7051e3100..   mov dword [0x000044f5], 0xb877dfe8 ; [0x44f5:4]=0
|           0x000013d7      c6051b3100..   mov byte [0x000044f9], 0x66 ; 'f'
|                                                                      ; [0x44f9:1]=0
|           0x000013de      c6057e3200..   mov byte [0x00004663], 0x89 ; [0x4663:1]=0
|           0x000013e5      c6057e3200..   mov byte [0x0000466a], 0x68 ; 'h'
|                                                                      ; [0x466a:1]=0
|           0x000013ec      c6051d2e00..   mov byte [0x00004210], 0xf0 ; [0x4210:1]=0
|           0x000013f3      6644891d17..   mov word [0x00004212], r11w ; [0x4212:2]=0
|           0x000013fb      66892d152e..   mov word [0x00004217], bp   ; [0x4217:2]=0
|           0x00001402      488d6c2420     lea rbp, [c]
|           0x00001407      c6050b2e00..   mov byte [0x00004219], 0xd9 ; [0x4219:1]=0
|           0x0000140e      4989ec         mov r12, rbp
|           0x00001411      e81afcffff     call sym.imp.puts           ; int puts(const char *s)
|           0x00001416      488d3dc20d..   lea rdi, str.Return_what_was_borrowed. ; 0x21df ; "Return what was borrowed." ; const char *s
|           0x0000141d      e80efcffff     call sym.imp.puts           ; int puts(const char *s)
|           0x00001422      0f1f00         nop dword [rax]
|           0x00001425      66662e0f1f..   nop word cs:[rax + rax]
|           ; CODE XREF from main @ 0x159d(x)
|       .-> 0x00001430      488b0d292c..   mov rcx, qword [obj.stdout] ; [0x4060:8]=0 ; FILE *stream
|       :   0x00001437      ba02000000     mov edx, 2                  ; size_t nitems
|       :   0x0000143c      be01000000     mov esi, 1                  ; size_t size
|       :   0x00001441      488d3db10d..   lea rdi, [0x000021f9]       ; "> " ; const void *ptr
|       :   0x00001448      e853fcffff     call sym.imp.fwrite         ; size_t fwrite(const void *ptr, size_t size, size_t nitems, FILE *stream)
|       :   0x0000144d      488b151c2c..   mov rdx, qword [obj.stdin]  ; [0x4070:8]=0 ; FILE *stream
|       :   0x00001454      be60000000     mov esi, 0x60               ; '`' ; int size
|       :   0x00001459      488dbc2480..   lea rdi, [s1]               ; char *s
|       :   0x00001461      e8fafbffff     call sym.imp.fgets          ; char *fgets(char *s, int size, FILE *stream)
|       :   0x00001466      4885c0         test rax, rax
|      ,==< 0x00001469      7477           je 0x14e2
|      |:   0x0000146b      488dbc2480..   lea rdi, [s1]               ; const char *s1
|      |:   0x00001473      488d35820d..   lea rsi, [0x000021fc]       ; "\r\n" ; const char *s2
|      |:   0x0000147a      e8d1fbffff     call sym.imp.strcspn        ; size_t strcspn(const char *s1, const char *s2)
|      |:   0x0000147f      c684048000..   mov byte [rsp + rax + 0x80], 0
|      |:   0x00001487      e824fcffff     call sym.imp.__ctype_b_loc
|      |:   0x0000148c      0fb6942480..   movzx edx, byte [s1]
|      |:   0x00001494      488dbc2480..   lea rdi, [s1]
|      |:   0x0000149c      488b08         mov rcx, qword [rax]
|      |:   0x0000149f      4989c6         mov r14, rax
|      |:   0x000014a2      4889d0         mov rax, rdx
|      |:   0x000014a5      f644510120     test byte [rcx + rdx*2 + 1], 0x20
|     ,===< 0x000014aa      7426           je 0x14d2
|     ||:   0x000014ac      660f1f8400..   nop word [rax + rax]
|     ||:   0x000014b5      66662e0f1f..   nop word cs:[rax + rax]
|     ||:   ; CODE XREF from main @ 0x14d0(x)
|    .----> 0x000014c0      0fb65701       movzx edx, byte [rdi + 1]
|    :||:   0x000014c4      4883c701       add rdi, 1
|    :||:   0x000014c8      4889d0         mov rax, rdx
|    :||:   0x000014cb      f644510120     test byte [rcx + rdx*2 + 1], 0x20
|    `====< 0x000014d0      75ee           jne 0x14c0
|     ||:   ; CODE XREF from main @ 0x14aa(x)
|     `---> 0x000014d2      84c0           test al, al
|     ,===< 0x000014d4      755a           jne 0x1530
|     ||:   ; CODE XREFS from main @ 0x1578(x), 0x158b(x), 0x17b8(x)
|  ...----> 0x000014d6      488d3d220d..   lea rdi, str.rejected       ; 0x21ff ; "rejected" ; const char *s
|  :::||:   0x000014dd      e84efbffff     call sym.imp.puts           ; int puts(const char *s)
|  :::||:   ; CODE XREF from main @ 0x1469(x)
|  :::|`--> 0x000014e2      b801000000     mov eax, 1
|  :::| :   ; CODE XREF from main @ 0x1947(x)
|  :::|.--> 0x000014e7      488b9424e8..   mov rdx, qword [var_e8h]
|  :::|::   0x000014ef      64482b1425..   sub rdx, qword fs:[0x28]
| ,=======< 0x000014f8      0f854e040000   jne 0x194c
| |:::|::   0x000014fe      488b9c24f8..   mov rbx, qword [var_f8h]
| |:::|::   0x00001506      488bac2400..   mov rbp, qword [var_100h]
| |:::|::   0x0000150e      4c8ba42408..   mov r12, qword [var_108h]
| |:::|::   0x00001516      4c8bac2410..   mov r13, qword [var_110h]
| |:::|::   0x0000151e      4c8bb42418..   mov r14, qword [var_118h]
| |:::|::   0x00001526      4881c42801..   add rsp, 0x128
| |:::|::   0x0000152d      c3             ret
..
| |:::|::   ; CODE XREF from main @ 0x14d4(x)
| |:::`---> 0x00001530      488d742418     lea rsi, [endptr]           ; char * *endptr
| |::: ::   0x00001535      31d2           xor edx, edx                ; int base
| |::: ::   0x00001537      e854fbffff     call sym.imp.strtoul        ; long strtoul(const char *str, char * *endptr, int base)
| |::: ::   0x0000153c      498b36         mov rsi, qword [r14]
| |::: ::   0x0000153f      4889c7         mov rdi, rax
| |::: ::   0x00001542      488b442418     mov rax, qword [endptr]
| |::: ::   0x00001547      0fb608         movzx ecx, byte [rax]
| |::: ::   0x0000154a      4889ca         mov rdx, rcx
| |::: ::   0x0000154d      f6444e0120     test byte [rsi + rcx*2 + 1], 0x20
| |:::,===< 0x00001552      7422           je 0x1576
| |:::|::   0x00001554      90             nop
| |:::|::   0x00001555      66662e0f1f..   nop word cs:[rax + rax]
| |:::|::   ; CODE XREF from main @ 0x1574(x)
| --------> 0x00001560      4883c001       add rax, 1
| |:::|::   0x00001564      4889442418     mov qword [endptr], rax
| |:::|::   0x00001569      0fb608         movzx ecx, byte [rax]
| |:::|::   0x0000156c      4889ca         mov rdx, rcx
| |:::|::   0x0000156f      f6444e0120     test byte [rsi + rcx*2 + 1], 0x20
| ========< 0x00001574      75ea           jne 0x1560
| |:::|::   ; CODE XREF from main @ 0x1552(x)
| |:::`---> 0x00001576      84d2           test dl, dl
| |`======< 0x00001578      0f8558ffffff   jne 0x14d6
| | :: ::   0x0000157e      488d8700c0..   lea rax, reloc.puts
| | :: ::   0x00001585      483dff070000   cmp rax, 0x7ff
| | `=====< 0x0000158b      0f8745ffffff   ja 0x14d6
| |  : ::   0x00001591      6641893c24     mov word [r12], di
| |  : ::   0x00001596      4983c402       add r12, 2
| |  : ::   0x0000159a      4d39e5         cmp r13, r12
| |  : :`=< 0x0000159d      0f858dfeffff   jne 0x1430
| |  : :    0x000015a3      488d442474     lea rax, [var_74h]
| |  : :    0x000015a8      0fb735f12a..   movzx esi, word [0x000040a0] ; [0x40a0:2]=0
| |  : :    0x000015af      4c89bc2420..   mov qword [var_120h], r15
| |  : :    0x000015b7      4c8d6c2440     lea r13, [var_40h]
| |  : :    0x000015bc      48890424       mov qword [rsp], rax
| |  : :    0x000015c0      41bbefbeffff   mov r11d, 0xffffbeef
| |  : :    0x000015c6      41bcb979379e   mov r12d, 0x9e3779b9
| |  : :    0x000015cc      41b903000000   mov r9d, 3
| |  : :    0x000015d2      66c7442408..   mov word [var_8h], 0x5a5a   ; 'ZZ'
| |  : :                                                               ; [0x5a5a:2]=0xffff
| |  : :    0x000015d9      6681f6317c     xor si, 0x7c31
| |  : :    0x000015de      41be67e6096a   mov r14d, 0x6a09e667
| |  : :    0x000015e4      66c744240a..   mov word [var_ah], 0
| |  : :    0x000015eb      0f1f440000     nop dword [rax + rax]
| |  : :    ; CODE XREF from main @ 0x1796(x)
| |  : :.-> 0x000015f0      440fb74500     movzx r8d, word [rbp]
| |  : ::   0x000015f5      8d8600400000   lea eax, [rsi + reloc.puts] ; 0x4000 ; "6\x10"
| |  : ::   0x000015fb      664139c0       cmp r8w, ax
| |  :,===< 0x000015ff      0f85ab010000   jne 0x17b0
| |  :|::   0x00001605      6681fef607     cmp si, 0x7f6
| | ,=====< 0x0000160a      0f87a0010000   ja 0x17b0
| | |:|::   0x00001610      0fb7c6         movzx eax, si
| | |:|::   0x00001613      89f1           mov ecx, esi
| | |:|::   0x00001615      0fb7fe         movzx edi, si
| | |:|::   0x00001618      66c1e903       shr cx, 3
| | |:|::   0x0000161c      320c03         xor cl, byte [rbx + rax]
| | |:|::   0x0000161f      897c240c       mov dword [var_ch], edi
| | |:|::   0x00001623      89ca           mov edx, ecx
| | |:|::   0x00001625      83f2c3         xor edx, 0xffffffc3         ; 4294967235
| | |:|::   0x00001628      80fa03         cmp dl, 3
| |,======< 0x0000162b      0f877f010000   ja 0x17b0
| |||:|::   0x00001631      8d4707         lea eax, [rdi + 7]
| |||:|::   0x00001634      bf4c000000     mov edi, 0x4c               ; 'L'
| |||:|::   0x00001639      4429df         sub edi, r11d
| |||:|::   0x0000163c      40323c03       xor dil, byte [rbx + rax]
| |||:|::   0x00001640      488b0424       mov rax, qword [rsp]
| |||:|::   0x00001644      31f7           xor edi, esi
| |||:|::   0x00001646      408838         mov byte [rax], dil
| |||:|::   0x00001649      0fb6442408     movzx eax, byte [var_8h]
| |||:|::   0x0000164e      448d50a6       lea r10d, [rax - 0x5a]
| |||:|::   0x00001652      b825000000     mov eax, 0x25               ; '%'
| |||:|::   0x00001657      41f6e2         mul r10b
| |||:|::   0x0000165a      4589d7         mov r15d, r10d
| |||:|::   0x0000165d      66c1e808       shr ax, 8
| |||:|::   0x00001661      4129c7         sub r15d, eax
| |||:|::   0x00001664      41d0ef         shr r15b, 1
| |||:|::   0x00001667      4401f8         add eax, r15d
| |||:|::   0x0000166a      c0e802         shr al, 2
| |||:|::   0x0000166d      448d3cc500..   lea r15d, [rax*8]
| |||:|::   0x00001675      4129c7         sub r15d, eax
| |||:|::   0x00001678      4529fa         sub r10d, r15d
| |||:|::   0x0000167b      458d7a01       lea r15d, [r10 + 1]
| |||:|::   0x0000167f      80f9c1         cmp cl, 0xc1
| ========< 0x00001682      0f8458010000   je 0x17e0
| |||:|::   0x00001688      80f9c0         cmp cl, 0xc0
| ========< 0x0000168b      0f849d010000   je 0x182e
| |||:|::   0x00001691      8d4602         lea eax, [rsi + 2]
| |||:|::   0x00001694      0fb7c0         movzx eax, ax
| |||:|::   0x00001697      80f9c2         cmp cl, 0xc2
| ========< 0x0000169a      0f851d010000   jne 0x17bd
| |||:|::   0x000016a0      440fb61403     movzx r10d, byte [rbx + rax]
| |||:|::   0x000016a5      8d4603         lea eax, [rsi + 3]
| |||:|::   0x000016a8      0fb7c0         movzx eax, ax
| |||:|::   0x000016ab      0fb60403       movzx eax, byte [rbx + rax]
| |||:|::   0x000016af      41c1e208       shl r10d, 8
| |||:|::   0x000016b3      4109c2         or r10d, eax
| |||:|::   0x000016b6      4531da         xor r10d, r11d
| |||:|::   ; CODE XREFS from main @ 0x17db(x), 0x1829(x), 0x1853(x)
| --------> 0x000016b9      0fb6ca         movzx ecx, dl
| |||:|::   0x000016bc      89f8           mov eax, edi
| |||:|::   0x000016be      6669c91111     imul cx, cx, 0x1111
| |||:|::   0x000016c3      c1e008         shl eax, 8
| |||:|::   0x000016c6      31c8           xor eax, ecx
| |||:|::   0x000016c8      0fb74c240a     movzx ecx, word [var_ah]
| |||:|::   0x000016cd      31f1           xor ecx, esi
| |||:|::   0x000016cf      4431d1         xor ecx, r10d
| |||:|::   0x000016d2      31c8           xor eax, ecx
| |||:|::   0x000016d4      4489f9         mov ecx, r15d
| |||:|::   0x000016d7      66354f6b       xor ax, 0x6b4f
| |||:|::   0x000016db      66d3c0         rol ax, cl
| |||:|::   0x000016de      4189c7         mov r15d, eax
| |||:|::   0x000016e1      6641c1ef07     shr r15w, 7
| |||:|::   0x000016e6      4489f9         mov ecx, r15d
| |||:|::   0x000016e9      31c1           xor ecx, eax
| |||:|::   0x000016eb      8d4609         lea eax, [rsi + 9]
| |||:|::   0x000016ee      83c608         add esi, 8
| |||:|::   0x000016f1      0fb7c0         movzx eax, ax
| |||:|::   0x000016f4      0fb7f6         movzx esi, si
| |||:|::   ; DATA XREF from main @ 0x1176(r)
| |||:|::   0x000016f7      0fb60403       movzx eax, byte [rbx + rax]
| |||:|::   0x000016fb      0fb63433       movzx esi, byte [rbx + rsi]
| |||:|::   0x000016ff      c1e008         shl eax, 8
| |||:|::   0x00001702      09f0           or eax, esi
| |||:|::   0x00001704      6639c1         cmp cx, ax
| ========< 0x00001707      0f85a3000000   jne 0x17b0
| |||:|::   0x0000170d      0fb6f2         movzx esi, dl
| |||:|::   0x00001710      400fb6ff       movzx edi, dil
| |||:|::   0x00001714      4883042401     add qword [rsp], 1
| |||:|::   0x00001719      4883c502       add rbp, 2
| |||:|::   0x0000171d      69f601010101   imul esi, esi, 0x1010101
| |||:|::   0x00001723      c1e710         shl edi, 0x10
| |||:|::   0x00001726      48b8114208..   movabs rax, 0x842108421084211
| |||:|::   0x00001730      664181eb1101   sub r11w, 0x111
| |||:|::   0x00001736      49f7e1         mul r9
| |||:|::   0x00001739      4c89c8         mov rax, r9
| |||:|::   0x0000173c      668144240a..   add word [var_ah], 0x23d    ; [0x23d:2]=0
| |||:|::   0x00001743      4983c504       add r13, 4
| |||:|::   0x00001747      6681442408..   add word [var_8h], 0x101    ; [0x101:2]=16
| |||:|::   0x0000174e      4431c6         xor esi, r8d
| |||:|::   0x00001751      4829d0         sub rax, rdx
| |||:|::   0x00001754      31fe           xor esi, edi
| |||:|::   0x00001756      4c89cf         mov rdi, r9
| |||:|::   0x00001759      4983c105       add r9, 5
| |||:|::   0x0000175d      48d1e8         shr rax, 1
| |||:|::   0x00001760      4431f6         xor esi, r14d
| |||:|::   0x00001763      4801c2         add rdx, rax
| |||:|::   0x00001766      48c1ea04       shr rdx, 4
| |||:|::   0x0000176a      4889d0         mov rax, rdx
| |||:|::   0x0000176d      48c1e005       shl rax, 5
| |||:|::   0x00001771      4829d0         sub rax, rdx
| |||:|::   0x00001774      4829c7         sub rdi, rax
| |||:|::   0x00001777      8d4f01         lea ecx, [rdi + 1]
| |||:|::   0x0000177a      d3c6           rol esi, cl
| |||:|::   0x0000177c      468d3426       lea r14d, [rsi + r12]
| |||:|::   0x00001780      4181c43b9f..   add r12d, 0x45d9f3b
| |||:|::   0x00001787      458975fc       mov dword [r13 - 4], r14d
| |||:|::   0x0000178b      664181fb23b2   cmp r11w, 0xb223
| ========< 0x00001791      7408           je 0x179b
| |||:|::   0x00001793      4489d6         mov esi, r10d
| |||:|:`=< 0x00001796      e955feffff     jmp 0x15f0
| |||:|:    ; CODE XREF from main @ 0x1791(x)
| --------> 0x0000179b      664183c201     add r10w, 1
| |||:|:,=< 0x000017a0      0f84b2000000   je 0x1858
| |||:|:|   0x000017a6      662e0f1f84..   nop word cs:[rax + rax]
| |||:|:|   ; CODE XREFS from main @ 0x15ff(x), 0x160a(x), 0x162b(x), 0x1707(x)
| -``-`---> 0x000017b0      4c8bbc2420..   mov r15, qword [var_120h]
| |  `====< 0x000017b8      e919fdffff     jmp 0x14d6
| |    :|   ; CODE XREF from main @ 0x169a(x)
| --------> 0x000017bd      8d4e01         lea ecx, [rsi + 1]
| |    :|   0x000017c0      0fb60403       movzx eax, byte [rbx + rax]
| |    :|   0x000017c4      0fb7c9         movzx ecx, cx
| |    :|   0x000017c7      0fb60c0b       movzx ecx, byte [rbx + rcx]
| |    :|   0x000017cb      c1e008         shl eax, 8
| |    :|   0x000017ce      09c8           or eax, ecx
| |    :|   0x000017d0      4189c2         mov r10d, eax
| |    :|   0x000017d3      4433542408     xor r10d, dword [var_8h]
| |    :|   0x000017d8      4101f2         add r10d, esi
| ========< 0x000017db      e9d9feffff     jmp 0x16b9
| |    :|   ; CODE XREF from main @ 0x1682(x)
| --------> 0x000017e0      8b44240c       mov eax, dword [var_ch]
| |    :|   0x000017e4      83c004         add eax, 4
| |    :|   0x000017e7      0fb60c03       movzx ecx, byte [rbx + rax]
| |    :|   0x000017eb      31f9           xor ecx, edi
| |    :|   0x000017ed      89c8           mov eax, ecx
| |    :|   0x000017ef      83f06d         xor eax, 0x6d
| |    :|   0x000017f2      0fb6c0         movzx eax, al
| |    :|   0x000017f5      8d8c008000..   lea ecx, [rax + rax + 0x80]
| |    :|   0x000017fc      6669c03713     imul ax, ax, 0x1337
| |    :|   0x00001801      448d5101       lea r10d, [rcx + 1]
| |    :|   0x00001805      0fb7c9         movzx ecx, cx
| |    :|   0x00001808      4181e2ff07..   and r10d, 0x7ff
| |    :|   0x0000180f      0fb60c0b       movzx ecx, byte [rbx + rcx]
| |    :|   0x00001813      460fb61413     movzx r10d, byte [rbx + r10]
| |    :|   0x00001818      41c1e208       shl r10d, 8
| |    :|   0x0000181c      4409d1         or ecx, r10d
| |    :|   0x0000181f      31c1           xor ecx, eax
| |    :|   0x00001821      6681f15aa5     xor cx, 0xa55a
| |    :|   0x00001826      4189ca         mov r10d, ecx
| ========< 0x00001829      e98bfeffff     jmp 0x16b9
| |    :|   ; CODE XREF from main @ 0x168b(x)
| --------> 0x0000182e      8d4606         lea eax, [rsi + 6]
| |    :|   0x00001831      8d4e05         lea ecx, [rsi + 5]
| |    :|   0x00001834      0fb7c0         movzx eax, ax
| |    :|   0x00001837      0fb7c9         movzx ecx, cx
| |    :|   0x0000183a      0fb60403       movzx eax, byte [rbx + rax]
| |    :|   0x0000183e      440fb6140b     movzx r10d, byte [rbx + rcx]
| |    :|   0x00001843      4489f9         mov ecx, r15d
| |    :|   0x00001846      c1e008         shl eax, 8
| |    :|   0x00001849      4109c2         or r10d, eax
| |    :|   0x0000184c      6641d3c2       rol r10w, cl
| |    :|   0x00001850      41f7d2         not r10d
| ========< 0x00001853      e961feffff     jmp 0x16b9
| |    :|   ; CODE XREF from main @ 0x17a0(x)
| |    :`-> 0x00001858      488b0d0128..   mov rcx, qword [obj.stdout] ; [0x4060:8]=0 ; FILE *stream
| |    :    0x0000185f      ba04000000     mov edx, 4                  ; size_t nitems
| |    :    0x00001864      be01000000     mov esi, 1                  ; size_t size
| |    :    0x00001869      31ed           xor ebp, ebp
| |    :    0x0000186b      488d3d9609..   lea rdi, str.__             ; 0x2208 ; "[+]" ; const void *ptr
| |    :    0x00001872      488d1da709..   lea rbx, [0x00002220]
| |    :    0x00001879      49bcabaaaa..   movabs r12, 0xaaaaaaaaaaaaaaab
| |    :    0x00001883      e818f8ffff     call sym.imp.fwrite         ; size_t fwrite(const void *ptr, size_t size, size_t nitems, FILE *stream)
| |    :    0x00001888      0f1f840000..   nop dword [rax + rax]
| |    :    ; CODE XREF from main @ 0x1926(x)
| |    :.-> 0x00001890      488d4cad01     lea rcx, [rbp + rbp*4 + 1]
| |    ::   0x00001895      0fb63c2b       movzx edi, byte [rbx + rbp]
| |    ::   0x00001899      488b35c027..   mov rsi, qword [obj.stdout] ; [0x4060:8]=0 ; FILE *stream
| |    ::   0x000018a0      4889c8         mov rax, rcx
| |    ::   0x000018a3      49f7e4         mul r12
| |    ::   0x000018a6      48c1ea03       shr rdx, 3
| |    ::   0x000018aa      488d0452       lea rax, [rdx + rdx*2]
| |    ::   0x000018ae      48c1e002       shl rax, 2
| |    ::   0x000018b2      4829c1         sub rcx, rax
| |    ::   0x000018b5      b81d000000     mov eax, 0x1d
| |    ::   0x000018ba      0fafc5         imul eax, ebp
| |    ::   0x000018bd      31c7           xor edi, eax
| |    ::   0x000018bf      4889e8         mov rax, rbp
| |    ::   0x000018c2      40327c0c74     xor dil, byte [rsp + rcx + 0x74]
| |    ::   0x000018c7      89e9           mov ecx, ebp
| |    ::   0x000018c9      49f7e4         mul r12
| |    ::   0x000018cc      83e103         and ecx, 3
| |    ::   0x000018cf      c1e103         shl ecx, 3
| |    ::   0x000018d2      48c1ea03       shr rdx, 3
| |    ::   0x000018d6      488d0452       lea rax, [rdx + rdx*2]
| |    ::   0x000018da      4889ea         mov rdx, rbp
| |    ::   0x000018dd      48c1e002       shl rax, 2
| |    ::   0x000018e1      4829c2         sub rdx, rax
| |    ::   0x000018e4      8b449440       mov eax, dword [rsp + rdx*4 + 0x40]
| |    ::   0x000018e8      d3e8           shr eax, cl
| |    ::   0x000018ea      488d0ced00..   lea rcx, [rbp*8]
| |    ::   0x000018f2      4829e9         sub rcx, rbp
| |    ::   0x000018f5      31c7           xor edi, eax
| |    ::   0x000018f7      4883c501       add rbp, 1
| |    ::   0x000018fb      4883c103       add rcx, 3
| |    ::   0x000018ff      4889c8         mov rax, rcx
| |    ::   0x00001902      49f7e4         mul r12
| |    ::   0x00001905      48c1ea03       shr rdx, 3
| |    ::   0x00001909      488d0452       lea rax, [rdx + rdx*2]
| |    ::   0x0000190d      48c1e002       shl rax, 2
| |    ::   0x00001911      4829c1         sub rcx, rax
| |    ::   0x00001914      40327c4c20     xor dil, byte [rsp + rcx*2 + 0x20]
| |    ::   0x00001919      400fb6ff       movzx edi, dil              ; int c
| |    ::   0x0000191d      e84ef7ffff     call sym.imp.putc           ; int putc(int c, FILE *stream)
| |    ::   0x00001922      4883fd28       cmp rbp, 0x28               ; '('
| |    :`=< 0x00001926      0f8564ffffff   jne 0x1890
| |    :    0x0000192c      488b352d27..   mov rsi, qword [obj.stdout] ; [0x4060:8]=0 ; FILE *stream
| |    :    0x00001933      bf0a000000     mov edi, 0xa                ; int c
| |    :    0x00001938      e833f7ffff     call sym.imp.putc           ; int putc(int c, FILE *stream)
| |    :    0x0000193d      4c8bbc2420..   mov r15, qword [var_120h]
| |    :    0x00001945      31c0           xor eax, eax
| |    `==< 0x00001947      e99bfbffff     jmp 0x14e7
| |         ; CODE XREF from main @ 0x14f8(x)
| `-------> 0x0000194c      4c89bc2420..   mov qword [var_120h], r15
\           0x00001954      e8e7f6ffff     call sym.imp.__stack_chk_fail ; void stack_chk_fail(void)
