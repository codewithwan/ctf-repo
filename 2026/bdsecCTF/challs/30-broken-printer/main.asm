            ;-- section..text:
            ; DATA XREF from entry0 @ 0x1638(r)
/ 1296: int main (int argc, char **argv, char **envp);
| afv: vars(19:sp[0x8..0x494])
|           0x00001100      4881ec9804..   sub rsp, 0x498              ; [12] -r-x section size 1561 named .text
|           0x00001107      488b3d6a2f..   mov rdi, qword [obj.stdout] ; [0x4078:8]=0 ; FILE*stream
|           0x0000110e      31f6           xor esi, esi                ; char *buf
|           0x00001110      ba02000000     mov edx, 2                  ; int mode
|           0x00001115      64488b0c25..   mov rcx, qword fs:[0x28]
|           0x0000111e      48898c2458..   mov qword [var_458h], rcx   ; [0x458:8]=0
|           0x00001126      31c9           xor ecx, ecx                ; size_t size
|           0x00001128      e8b3ffffff     call sym.imp.setvbuf        ; int setvbuf(FILE*stream, char *buf, int mode, size_t size)
|           0x0000112d      488d35d00e..   lea rsi, [0x00002004]       ; "r" ; const char *mode
|           0x00001134      488d3dcb0e..   lea rdi, str.flag.txt       ; 0x2006 ; "flag.txt" ; const char *filename
|           0x0000113b      e8b0ffffff     call sym.imp.fopen          ; file*fopen(const char *filename, const char *mode)
|           0x00001140      4885c0         test rax, rax
|       ,=< 0x00001143      0f846f040000   je 0x15b8
|       |   0x00001149      4889c2         mov rdx, rax                ; FILE *stream
|       |   0x0000114c      be61000000     mov esi, 0x61               ; 'a' ; int size
|       |   0x00001151      488dbc24f0..   lea rdi, [s1]               ; 0x3f0
|       |                                                              ; section..dynsym
|       |                                                              [04] -r-- section size 480 named .dynsym ; char *s
|       |   0x00001159      48899c2468..   mov qword [var_468h], rbx   ; [0x468:8]=0x1200000045
|       |   0x00001161      4889c3         mov rbx, rax
|       |   0x00001164      e837ffffff     call sym.imp.fgets          ; char *fgets(char *s, int size, FILE *stream)
|       |   0x00001169      4885c0         test rax, rax
|      ,==< 0x0000116c      0f8465040000   je 0x15d7
|      ||   0x00001172      4889df         mov rdi, rbx                ; FILE *stream
|      ||   0x00001175      4889ac2470..   mov qword [var_470h], rbp   ; [0x470:8]=0
|      ||   0x0000117d      e8defeffff     call sym.imp.fclose         ; int fclose(FILE *stream)
|      ||   0x00001182      488d35860e..   lea rsi, [0x0000200f]       ; "\r\n" ; const char *s2
|      ||   0x00001189      488dbc24f0..   lea rdi, [s1]               ; 0x3f0
|      ||                                                              ; section..dynsym
|      ||                                                              [04] -r-- section size 480 named .dynsym ; const char *s1
|      ||   0x00001191      e8fafeffff     call sym.imp.strcspn        ; size_t strcspn(const char *s1, const char *s2)
|      ||   0x00001196      c68404f003..   mov byte [rsp + rax + section..dynsym], 0 ; [0x3f0:1]=0
|      ||   0x0000119e      4889c5         mov rbp, rax
|      ||   0x000011a1      488d40ff       lea rax, [rax - 1]
|      ||   0x000011a5      4883f85f       cmp rax, 0x5f               ; '_'
|     ,===< 0x000011a9      0f87f9030000   ja 0x15a8
|     |||   0x000011af      31ff           xor edi, edi
|     |||   0x000011b1      488d742410     lea rsi, [var_10h]
|     |||   0x000011b6      4c89a42478..   mov qword [var_478h], r12   ; [0x478:8]=0
|     |||   0x000011be      4c89ac2480..   mov qword [var_480h], r13   ; [0x480:8]=0x120000007c
|     |||   0x000011c6      4c89b42488..   mov qword [canary], r14     ; [0x488:8]=0
|     |||   0x000011ce      4c89bc2490..   mov qword [var_490h], r15   ; [0x490:8]=0
|     |||   0x000011d6      e865feffff     call sym.imp.clock_gettime
|     |||   0x000011db      85c0           test eax, eax
|    ,====< 0x000011dd      0f85ad030000   jne 0x1590
|    ||||   ; CODE XREF from main @ 0x15a3(x)
|   .-----> 0x000011e3      488b5c2418     mov rbx, qword [var_18h]
|   :||||   0x000011e8      335c2410       xor ebx, dword [var_10h]
|   :||||   0x000011ec      e85ffeffff     call sym.imp.getpid         ; int getpid(void)
|   :||||   0x000011f1      488d358812..   lea rsi, [0x00002480]
|   :||||   0x000011f8      69c0b979379e   imul eax, eax, 0x9e3779b9
|   :||||   0x000011fe      488d7e48       lea rdi, [rsi + 0x48]
|   :||||   0x00001202      31d8           xor eax, ebx
|   :||||   0x00001204      4189c0         mov r8d, eax
|   :||||   0x00001207      41c1e810       shr r8d, 0x10
|   :||||   0x0000120b      4131c0         xor r8d, eax
|   :||||   0x0000120e      4569c02d35..   imul r8d, r8d, 0x7feb352d
|   :||||   0x00001215      4489c0         mov eax, r8d
|   :||||   0x00001218      c1e80f         shr eax, 0xf
|   :||||   0x0000121b      4131c0         xor r8d, eax
|   :||||   0x0000121e      4569c08ba6..   imul r8d, r8d, 0x846ca68b
|   :||||   0x00001225      4489c0         mov eax, r8d
|   :||||   0x00001228      c1e810         shr eax, 0x10
|   :||||   0x0000122b      4131c0         xor r8d, eax
|   :||||   0x0000122e      4489442404     mov dword [var_4h], r8d
|   :||||   0x00001233      6690           nop
|   :||||   0x00001235      66662e0f1f..   nop word cs:[rax + rax]
|   :||||   ; CODE XREF from main @ 0x126d(x)
|  .------> 0x00001240      4c8b26         mov r12, qword [rsi]
|  ::||||   0x00001243      4889ea         mov rdx, rbp
|  ::||||   0x00001246      4c89e0         mov rax, r12
|  ::||||   0x00001249      0f1f800000..   nop dword [rax]
|  ::||||   ; CODE XREF from main @ 0x125e(x)
| .-------> 0x00001250      4889d1         mov rcx, rdx
| :::||||   0x00001253      31d2           xor edx, edx
| :::||||   0x00001255      48f7f1         div rcx
| :::||||   0x00001258      4889c8         mov rax, rcx
| :::||||   0x0000125b      4885d2         test rdx, rdx
| `=======< 0x0000125e      75f0           jne 0x1250
|  ::||||   0x00001260      4883f901       cmp rcx, 1
| ,=======< 0x00001264      740f           je 0x1275
| |::||||   0x00001266      4883c608       add rsi, 8
| |::||||   0x0000126a      4839f7         cmp rdi, rsi
| |`======< 0x0000126d      75d1           jne 0x1240
| | :||||   0x0000126f      41bc01000000   mov r12d, 1
| | :||||   ; CODE XREF from main @ 0x1264(x)
| `-------> 0x00001275      8b442404       mov eax, dword [var_4h]
|   :||||   0x00001279      31d2           xor edx, edx
|   :||||   0x0000127b      488d742420     lea rsi, [var_20h]
|   :||||   0x00001280      bf04000000     mov edi, 4
|   :||||   0x00001285      4c8dac24ec..   lea r13, [var_3ech]
|   :||||   0x0000128d      4c8d153712..   lea r10, [0x000024cb]       ; ".:+#"
|   :||||   0x00001294      41b8cdcccccc   mov r8d, 0xcccccccd
|   :||||   0x0000129a      c1e810         shr eax, 0x10
|   :||||   0x0000129d      4d89e9         mov r9, r13
|   :||||   0x000012a0      488d9c2400..   lea rbx, [var_200h]
|   :||||   0x000012a8      f7f5           div ebp
|   :||||   0x000012aa      488d4504       lea rax, [var_4h]
|   :||||   0x000012ae      4889442408     mov qword [var_8h], rax
|   :||||   0x000012b3      4989d3         mov r11, rdx
|   :||||   0x000012b6      662e0f1f84..   nop word cs:[rax + rax]
|   :||||   ; CODE XREF from main @ 0x13d7(x)
|  .------> 0x000012c0      410fb6543d00   movzx edx, byte [r13 + rdi]
|  ::||||   0x000012c6      488d47fc       lea rax, [rdi - 4]
|  ::||||   0x000012ca      89d1           mov ecx, edx
|  ::||||   0x000012cc      c0e906         shr cl, 6
|  ::||||   0x000012cf      83e103         and ecx, 3
|  ::||||   0x000012d2      410fb60c0a     movzx ecx, byte [r10 + rcx]
|  ::||||   0x000012d7      888c24e803..   mov byte [var_3e8h], cl
|  ::||||   0x000012de      89d1           mov ecx, edx
|  ::||||   0x000012e0      c0e904         shr cl, 4
|  ::||||   0x000012e3      83e103         and ecx, 3
|  ::||||   0x000012e6      410fb60c0a     movzx ecx, byte [r10 + rcx]
|  ::||||   0x000012eb      888c24e903..   mov byte [var_3e9h], cl     ; [0x3e9:1]=29
|  ::||||   0x000012f2      89d1           mov ecx, edx
|  ::||||   0x000012f4      83e203         and edx, 3
|  ::||||   0x000012f7      c0e902         shr cl, 2
|  ::||||   0x000012fa      410fb61412     movzx edx, byte [r10 + rdx]
|  ::||||   0x000012ff      83e103         and ecx, 3
|  ::||||   0x00001302      410fb60c0a     movzx ecx, byte [r10 + rcx]
|  ::||||   0x00001307      889424eb03..   mov byte [var_3ebh], dl     ; [0x3eb:1]=28
|  ::||||   0x0000130e      888c24ea03..   mov byte [var_3eah], cl     ; [0x3ea:1]=140
|  ::||||   ; CODE XREF from main @ 0x132e(x)
| .-------> 0x00001315      4889c2         mov rdx, rax
| :::||||   0x00001318      83e203         and edx, 3
| :::||||   0x0000131b      0fb69414e8..   movzx edx, byte [rsp + rdx + 0x3e8]
| :::||||   0x00001323      41881401       mov byte [r9 + rax], dl
| :::||||   0x00001327      4883c001       add rax, 1
| :::||||   0x0000132b      4839c7         cmp rdi, rax
| `=======< 0x0000132e      75e5           jne 0x1315
|  ::||||   0x00001330      8d47fc         lea eax, [rdi - 4]
|  ::||||   0x00001333      31c9           xor ecx, ecx
|  ::||||   0x00001335      69c03b9f5d04   imul eax, eax, 0x45d9f3b
|  ::||||   0x0000133b      33442404       xor eax, dword [var_4h]
|  ::||||   0x0000133f      89c2           mov edx, eax
|  ::||||   0x00001341      c1ea10         shr edx, 0x10
|  ::||||   0x00001344      31c2           xor edx, eax
|  ::||||   0x00001346      69d22d35eb7f   imul edx, edx, 0x7feb352d
|  ::||||   0x0000134c      89d0           mov eax, edx
|  ::||||   0x0000134e      c1e80f         shr eax, 0xf
|  ::||||   0x00001351      31c2           xor edx, eax
|  ::||||   0x00001353      69d28ba66c84   imul edx, edx, 0x846ca68b
|  ::||||   0x00001359      89d0           mov eax, edx
|  ::||||   0x0000135b      c1e810         shr eax, 0x10
|  ::||||   0x0000135e      31c2           xor edx, eax
|  ::||||   0x00001360      89d0           mov eax, edx
|  ::||||   0x00001362      4189d7         mov r15d, edx
|  ::||||   0x00001365      c1ea08         shr edx, 8
|  ::||||   0x00001368      490fafc0       imul rax, r8
|  ::||||   0x0000136c      83e203         and edx, 3
|  ::||||   0x0000136f      48c1e822       shr rax, 0x22
|  ::||||   0x00001373      8d0480         lea eax, [rax + rax*4]
|  ::||||   0x00001376      4129c7         sub r15d, eax
|  ::||||   0x00001379      31c0           xor eax, eax
|  ::||||   ; CODE XREF from main @ 0x139d(x)
| .-------> 0x0000137b      4939c7         cmp r15, rax
| ========< 0x0000137e      0f846c010000   je 0x14f0
| :::||||   0x00001384      440fb6b40c..   movzx r14d, byte [rsp + rcx + 0x3ec]
| :::||||   0x0000138d      4883c101       add rcx, 1
| :::||||   ; CODE XREF from main @ 0x14f5(x)
| --------> 0x00001391      44883406       mov byte [rsi + rax], r14b
| :::||||   0x00001395      4883c001       add rax, 1
| :::||||   0x00001399      4883f805       cmp rax, 5
| `=======< 0x0000139d      75dc           jne 0x137b
|  ::||||   0x0000139f      40f6c701       test dil, 1
| ,=======< 0x000013a3      0f8557010000   jne 0x1500
| |::||||   ; CODE XREF from main @ 0x151a(x)
| --------> 0x000013a9      4c89d8         mov rax, r11
| |::||||   0x000013ac      31d2           xor edx, edx
| |::||||   0x000013ae      4d01e3         add r11, r12
| |::||||   0x000013b1      4883c605       add rsi, 5
| |::||||   0x000013b5      48f7f5         div rbp
| |::||||   0x000013b8      4983e901       sub r9, 1
| |::||||   0x000013bc      4883c701       add rdi, 1
| |::||||   0x000013c0      488d0492       lea rax, [rdx + rdx*4]
| |::||||   0x000013c4      8b56fb         mov edx, dword [rsi - 5]
| |::||||   0x000013c7      891403         mov dword [rbx + rax], edx
| |::||||   0x000013ca      0fb656ff       movzx edx, byte [rsi - 1]
| |::||||   0x000013ce      88540304       mov byte [rbx + rax + 4], dl
| |::||||   0x000013d2      48397c2408     cmp qword [var_8h], rdi
| |`======< 0x000013d7      0f85e3feffff   jne 0x12c0
| | :||||   0x000013dd      31c0           xor eax, eax
| | :||||   0x000013df      b961000000     mov ecx, 0x61               ; 'a'
| | :||||   0x000013e4      4531e4         xor r12d, r12d
| | :||||   0x000013e7      4531ed         xor r13d, r13d
| | :||||   0x000013ea      488dbc24f0..   lea rdi, [s1]               ; 0x3f0
| | :||||                                                              ; section..dynsym
| | :||||                                                              [04] -r-- section size 480 named .dynsym
| | :||||   0x000013f2      4c8d3dcf10..   lea r15, str.__.:           ; 0x24c8 ; "|/~.:+#"
| | :||||   0x000013f9      f3aa           rep stosb byte [rdi], al
| | :||||   0x000013fb      488d3d7e0c..   lea rdi, str._n___________________________________________________n___________________________________________________n___________________B_D_S_e_c___C_T_F___2_0_2_6______n_____________________________________________________n____________________________________________________n_____________________BROKEN_PRINTER_________________n____________________________________________________n_______________.____________________________._______n_________________PAPER_JAM____DATA_LEAK__________n__________________________________________________n____________________________________________________n___________________________________________________n_______________________ERROR_42__________________n__________________________________________________n____________________________________________________n ; 0x2080 ; "\n            ______________________________________\n           /                                      \\\n          /        B D S e c   C T F   2 0 2 6     \\\n         /__________________________________________\\\n         |                                          |\n         |          [ BROKEN PRINTER ]              |\n         |                                          |\n         |      .----------------------------.      |\n         |      |  PAPER JAM // DATA LEAK   |      |\n         |      '----------------------------'      |\n         |             _____________                |\n         |            /____________/|               |\n         |            |  ERROR 42  | |              |\n         |            |___________|/                |\n         |__________________________________________|\n" ; const char *s
| | :||||   0x00001402      e829fcffff     call sym.imp.puts           ; int puts(const char *s)
| | :||||   0x00001407      488b3d6a2c..   mov rdi, qword [obj.stdout] ; [0x4078:8]=0 ; FILE *stream
| | :||||   0x0000140e      e8bdfcffff     call sym.imp.fflush         ; int fflush(FILE *stream)
| | :||||   0x00001413      8b742404       mov esi, dword [var_4h]
| | :||||   0x00001417      488d3d8a0f..   lea rdi, str._printer__job_id_______:__08X_n ; 0x23a8 ; "[printer] job id       : %08X\n" ; const char *format
| | :||||   0x0000141e      31c0           xor eax, eax
| | :||||   0x00001420      e85bfcffff     call sym.imp.printf         ; int printf(const char *format)
| | :||||   0x00001425      4889ee         mov rsi, rbp
| | :||||   0x00001428      488d3de30b..   lea rdi, str._printer__paper_width__:__zu_n ; 0x2012 ; "[printer] paper width  : %zu\n" ; const char *format
| | :||||   0x0000142f      31c0           xor eax, eax
| | :||||   0x00001431      e84afcffff     call sym.imp.printf         ; int printf(const char *format)
| | :||||   0x00001436      488d3d8b0f..   lea rdi, str._printer__status_______:_damaged_spool_recovered ; 0x23c8 ; "[printer] status       : damaged spool recovered" ; const char *s
| | :||||   0x0000143d      e8eefbffff     call sym.imp.puts           ; int puts(const char *s)
| | :||||   0x00001442      488d3de70b..   lea rdi, str._printer__output_follows:_n ; 0x2030 ; "[printer] output follows:\n" ; const char *s
| | :||||   0x00001449      e8e2fbffff     call sym.imp.puts           ; int puts(const char *s)
| | :||||   0x0000144e      488b3d232c..   mov rdi, qword [obj.stdout] ; [0x4078:8]=0 ; FILE *stream
| | :||||   0x00001455      e876fcffff     call sym.imp.fflush         ; int fflush(FILE *stream)
| | :||||   0x0000145a      660f1f440000   nop word [rax + rax]
| | :||||   ; CODE XREF from main @ 0x14e3(x)
| |.------> 0x00001460      4531f6         xor r14d, r14d
| |::||||   ; CODE XREF from main @ 0x147c(x)
| --------> 0x00001463      420fbe3c33     movsx edi, byte [rbx + r14] ; int c
| |::||||   0x00001468      488b35092c..   mov rsi, qword [obj.stdout] ; [0x4078:8]=0 ; FILE *stream
| |::||||   0x0000146f      4983c601       add r14, 1
| |::||||   0x00001473      e838fcffff     call sym.imp.putc           ; int putc(int c, FILE *stream)
| |::||||   0x00001478      4983fe05       cmp r14, 5
| ========< 0x0000147c      75e5           jne 0x1463
| |::||||   0x0000147e      4983c401       add r12, 1
| |::||||   0x00001482      4939ec         cmp r12, rbp
| ========< 0x00001485      0f8494000000   je 0x151f
| |::||||   0x0000148b      8b542404       mov edx, dword [var_4h]
| |::||||   0x0000148f      beabaaaaaa     mov esi, 0xaaaaaaab
| |::||||   0x00001494      4883c305       add rbx, 5
| |::||||   0x00001498      4431ea         xor edx, r13d
| |::||||   0x0000149b      4181c52deb..   add r13d, 0x27d4eb2d
| |::||||   0x000014a2      89d0           mov eax, edx
| |::||||   0x000014a4      c1e810         shr eax, 0x10
| |::||||   0x000014a7      31d0           xor eax, edx
| |::||||   0x000014a9      69c02d35eb7f   imul eax, eax, 0x7feb352d
| |::||||   0x000014af      89c2           mov edx, eax
| |::||||   0x000014b1      c1ea0f         shr edx, 0xf
| |::||||   0x000014b4      31d0           xor eax, edx
| |::||||   0x000014b6      69c08ba66c84   imul eax, eax, 0x846ca68b
| |::||||   0x000014bc      89c2           mov edx, eax
| |::||||   0x000014be      c1ea10         shr edx, 0x10
| |::||||   0x000014c1      31d0           xor eax, edx
| |::||||   0x000014c3      89c2           mov edx, eax
| |::||||   0x000014c5      480fafd6       imul rdx, rsi
| |::||||   0x000014c9      488b35a82b..   mov rsi, qword [obj.stdout] ; [0x4078:8]=0 ; FILE *stream
| |::||||   0x000014d0      48c1ea21       shr rdx, 0x21
| |::||||   0x000014d4      8d1452         lea edx, [rdx + rdx*2]
| |::||||   0x000014d7      29d0           sub eax, edx
| |::||||   0x000014d9      410fbe3c07     movsx edi, byte [r15 + rax] ; int c
| |::||||   0x000014de      e8cdfbffff     call sym.imp.putc           ; int putc(int c, FILE *stream)
| |`======< 0x000014e3      e978ffffff     jmp 0x1460
..
| | :||||   ; CODE XREF from main @ 0x137e(x)
| --------> 0x000014f0      450fb63412     movzx r14d, byte [r10 + rdx]
| ========< 0x000014f5      e997feffff     jmp 0x1391
..
| | :||||   ; CODE XREF from main @ 0x13a3(x)
| `-------> 0x00001500      0fb606         movzx eax, byte [rsi]
|   :||||   0x00001503      0fb65604       movzx edx, byte [rsi + 4]
|   :||||   0x00001507      884604         mov byte [rsi + 4], al
|   :||||   0x0000150a      0fb64601       movzx eax, byte [rsi + 1]
|   :||||   0x0000150e      8816           mov byte [rsi], dl
|   :||||   0x00001510      0fb65603       movzx edx, byte [rsi + 3]
|   :||||   0x00001514      884603         mov byte [rsi + 3], al
|   :||||   0x00001517      885601         mov byte [rsi + 1], dl
| ========< 0x0000151a      e98afeffff     jmp 0x13a9
|   :||||   ; CODE XREF from main @ 0x1485(x)
| --------> 0x0000151f      488d3dda0e..   lea rdi, str._n_n_printer__warning:_output_order_may_be_incorrect ; 0x2400 ; "\n\n[printer] warning: output order may be incorrect" ; const char *s
|   :||||   0x00001526      e805fbffff     call sym.imp.puts           ; int puts(const char *s)
|   :||||   0x0000152b      488d3d060f..   lea rdi, str._printer__warning:_foreign_ink_detected_in_every_block ; 0x2438 ; "[printer] warning: foreign ink detected in every block" ; const char *s
|   :||||   0x00001532      e8f9faffff     call sym.imp.puts           ; int puts(const char *s)
|   :||||   0x00001537      488b3d3a2b..   mov rdi, qword [obj.stdout] ; [0x4078:8]=0 ; FILE *stream
|   :||||   0x0000153e      e88dfbffff     call sym.imp.fflush         ; int fflush(FILE *stream)
|   :||||   0x00001543      488b9c2468..   mov rbx, qword [var_468h]
|   :||||   0x0000154b      31c0           xor eax, eax
|   :||||   0x0000154d      488bac2470..   mov rbp, qword [var_470h]
|   :||||   0x00001555      4c8ba42478..   mov r12, qword [var_478h]
|   :||||   0x0000155d      4c8bac2480..   mov r13, qword [var_480h]
|   :||||   0x00001565      4c8bb42488..   mov r14, qword [canary]
|   :||||   0x0000156d      4c8bbc2490..   mov r15, qword [var_490h]
|   :||||   ; CODE XREF from main @ 0x15d5(x)
|  .------> 0x00001575      488b942458..   mov rdx, qword [var_458h]
|  ::||||   0x0000157d      64482b1425..   sub rdx, qword fs:[0x28]
| ,=======< 0x00001586      7561           jne 0x15e9
| |::||||   0x00001588      4881c49804..   add rsp, 0x498
| |::||||   0x0000158f      c3             ret
| |::||||   ; CODE XREF from main @ 0x11dd(x)
| |::`----> 0x00001590      31ff           xor edi, edi                ; time_t *timer
| |:: |||   0x00001592      e829fbffff     call sym.imp.time           ; time_t time(time_t *timer)
| |:: |||   0x00001597      4889442410     mov qword [var_10h], rax
| |:: |||   0x0000159c      31c0           xor eax, eax
| |:: |||   0x0000159e      4889442418     mov qword [var_18h], rax
| |:`=====< 0x000015a3      e93bfcffff     jmp 0x11e3
| |:  |||   ; CODE XREF from main @ 0x11a9(x)
| |:  `---> 0x000015a8      488b9c2468..   mov rbx, qword [var_468h]
| |:   ||   0x000015b0      488bac2470..   mov rbp, qword [var_470h]
| |:   ||   ; CODE XREFS from main @ 0x1143(x), 0x15e7(x)
| |:  .-`-> 0x000015b8      488d3d910a..   lea rdi, str._printer__fatal:_unable_to_load_print_spool ; 0x2050 ; "[printer] fatal: unable to load print spool" ; const char *s
| |:  :|    0x000015bf      e86cfaffff     call sym.imp.puts           ; int puts(const char *s)
| |:  :|    0x000015c4      488b3dad2a..   mov rdi, qword [obj.stdout] ; [0x4078:8]=0 ; FILE *stream
| |:  :|    0x000015cb      e800fbffff     call sym.imp.fflush         ; int fflush(FILE *stream)
| |:  :|    0x000015d0      b801000000     mov eax, 1
| |`======< 0x000015d5      eb9e           jmp 0x1575
| |   :|    ; CODE XREF from main @ 0x116c(x)
| |   :`--> 0x000015d7      4889df         mov rdi, rbx                ; FILE *stream
| |   :     0x000015da      e881faffff     call sym.imp.fclose         ; int fclose(FILE *stream)
| |   :     0x000015df      488b9c2468..   mov rbx, qword [var_468h]
| |   `===< 0x000015e7      ebcf           jmp 0x15b8
| |         ; CODE XREF from main @ 0x1586(x)
| `-------> 0x000015e9      48899c2468..   mov qword [var_468h], rbx   ; [0x468:8]=0x1200000045
|           0x000015f1      4889ac2470..   mov qword [var_470h], rbp   ; [0x470:8]=0
|           0x000015f9      4c89a42478..   mov qword [var_478h], r12   ; [0x478:8]=0
|           0x00001601      4c89ac2480..   mov qword [var_480h], r13   ; [0x480:8]=0x120000007c
|           0x00001609      4c89b42488..   mov qword [canary], r14     ; [0x488:8]=0
|           0x00001611      4c89bc2490..   mov qword [var_490h], r15   ; [0x490:8]=0
\           0x00001619      e852faffff     call sym.imp.__stack_chk_fail ; void stack_chk_fail(void)
