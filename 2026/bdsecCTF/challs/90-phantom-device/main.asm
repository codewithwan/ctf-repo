     ::::   ; DATA XREF from entry0 @ 0x401b18(r)
/ 2361: int main (int argc, char **argv, char **envp);
| afv: vars(2:sp[0x40..0x188])
|    ::::   0x00401180      4157           push r15
|    ::::   0x00401182      31f6           xor esi, esi                ; char *buf
|    ::::   0x00401184      ba02000000     mov edx, 2                  ; int mode
|    ::::   0x00401189      4156           push r14
|    ::::   0x0040118b      4155           push r13
|    ::::   0x0040118d      4154           push r12
|    ::::   0x0040118f      55             push rbp
|    ::::   0x00401190      53             push rbx
|    ::::   0x00401191      4881ec1801..   sub rsp, 0x118
|    ::::   0x00401198      488b3d912e..   mov rdi, qword [obj.stdin]  ; [0x404030:8]=0 ; FILE*stream
|    ::::   0x0040119f      64488b0c25..   mov rcx, qword fs:[0x28]
|    ::::   0x004011a8      48898c2408..   mov qword [var_108h], rcx
|    ::::   0x004011b0      31c9           xor ecx, ecx                ; size_t size
|    ::::   0x004011b2      e849ffffff     call sym.imp.setvbuf        ; int setvbuf(FILE*stream, char *buf, int mode, size_t size)
|    ::::   0x004011b7      488b3d622e..   mov rdi, qword [obj.stdout] ; [0x404020:8]=0 ; FILE*stream
|    ::::   0x004011be      31c9           xor ecx, ecx                ; size_t size
|    ::::   0x004011c0      31f6           xor esi, esi                ; char *buf
|    ::::   0x004011c2      ba02000000     mov edx, 2                  ; int mode
|    ::::   0x004011c7      e834ffffff     call sym.imp.setvbuf        ; int setvbuf(FILE*stream, char *buf, int mode, size_t size)
|    ::::   0x004011cc      488b3d6d2e..   mov rdi, qword [obj.stderr] ; [0x404040:8]=0 ; FILE*stream
|    ::::   0x004011d3      31f6           xor esi, esi                ; char *buf
|    ::::   0x004011d5      31c9           xor ecx, ecx                ; size_t size
|    ::::   0x004011d7      ba02000000     mov edx, 2                  ; int mode
|    ::::   0x004011dc      e81fffffff     call sym.imp.setvbuf        ; int setvbuf(FILE*stream, char *buf, int mode, size_t size)
|    ::::   0x004011e1      31f6           xor esi, esi                ; int oflag
|    ::::   0x004011e3      31c0           xor eax, eax
|    ::::   0x004011e5      488d3d2d0e..   lea rdi, str._dev_urandom   ; 0x402019 ; "/dev/urandom" ; const char *path
|    ::::   0x004011ec      e81fffffff     call sym.imp.open           ; int open(const char *path, int oflag)
|    ::::   0x004011f1      85c0           test eax, eax
|   ,=====< 0x004011f3      0f89e3070000   jns 0x4019dc
|   |::::   ; CODE XREF from main @ 0x401a02(x)
|  .------> 0x004011f9      48833d5f2e..   cmp qword [0x00404060], 0   ; [0x404060:8]=0
| ,=======< 0x00401201      0f84b6080000   je 0x401abd
| |:|::::   ; CODE XREF from main @ 0x401a2f(x)
| --------> 0x00401207      488d3d5210..   lea rdi, str.               ; 0x402260 ; "========================================" ; const char *s
| |:|::::   0x0040120e      488d2da310..   lea rbp, [0x004022b8]
| |:|::::   0x00401215      e856feffff     call sym.imp.puts           ; int puts(const char *s)
| |:|::::   0x0040121a      488d3d6f10..   lea rdi, str.__________P_H_A_N_T_O_M__D_E_V_I_C_E ; 0x402290 ; "          P H A N T O M  D E V I C E" ; const char *s
| |:|::::   0x00401221      4c8d25582e..   lea r12, [0x00404080]
| |:|::::   0x00401228      e843feffff     call sym.imp.puts           ; int puts(const char *s)
| |:|::::   0x0040122d      488d3d2c10..   lea rdi, str.               ; 0x402260 ; "========================================" ; const char *s
| |:|::::   0x00401234      e837feffff     call sym.imp.puts           ; int puts(const char *s)
| |:|::::   0x00401239      488d3de60d..   lea rdi, str.Driver_interface_initialized. ; 0x402026 ; "Driver interface initialized." ; const char *s
| |:|::::   0x00401240      e82bfeffff     call sym.imp.puts           ; int puts(const char *s)
| |:|::::   0x00401245      66662e0f1f..   nop word cs:[rax + rax]
| |:|::::   ; XREFS: CODE 0x00401321  CODE 0x0040137c  CODE 0x0040148e  
| |:|::::   ; XREFS: CODE 0x00401574  CODE 0x00401623  CODE 0x004016c1  
| |:|::::   ; XREFS: CODE 0x0040181f  CODE 0x00401881  CODE 0x004018d8  
| |:|::::   ; XREFS: CODE 0x004018ec  CODE 0x004018fd  CODE 0x004019d7  
| |:|::::   ; XREFS: CODE 0x00401a40  CODE 0x00401a51  CODE 0x00401a98  
| |:|::::   ; XREFS: CODE 0x00401aac  CODE 0x00401ad5  
| --------> 0x00401250      488d3ded0d..   lea rdi, str._n1._Allocate_device ; 0x402044 ; "\n1. Allocate device" ; const char *s
| |:|::::   0x00401257      e814feffff     call sym.imp.puts           ; int puts(const char *s)
| |:|::::   0x0040125c      488d3df50d..   lea rdi, str.2._Duplicate_handle ; 0x402058 ; "2. Duplicate handle" ; const char *s
| |:|::::   0x00401263      e808feffff     call sym.imp.puts           ; int puts(const char *s)
| |:|::::   0x00401268      488d3dfd0d..   lea rdi, str.3._Read_device ; 0x40206c ; "3. Read device" ; const char *s
| |:|::::   0x0040126f      e8fcfdffff     call sym.imp.puts           ; int puts(const char *s)
| |:|::::   0x00401274      488d3d000e..   lea rdi, str.4._Write_device ; 0x40207b ; "4. Write device" ; const char *s
| |:|::::   0x0040127b      e8f0fdffff     call sym.imp.puts           ; int puts(const char *s)
| |:|::::   0x00401280      488d3d040e..   lea rdi, str.5._Release_handle ; 0x40208b ; "5. Release handle" ; const char *s
| |:|::::   0x00401287      e8e4fdffff     call sym.imp.puts           ; int puts(const char *s)
| |:|::::   0x0040128c      488d3d0a0e..   lea rdi, str.6._Create_session ; 0x40209d ; "6. Create session" ; const char *s
| |:|::::   0x00401293      e8d8fdffff     call sym.imp.puts           ; int puts(const char *s)
| |:|::::   0x00401298      488d3d100e..   lea rdi, str.7._Inspect_session ; 0x4020af ; "7. Inspect session" ; const char *s
| |:|::::   0x0040129f      e8ccfdffff     call sym.imp.puts           ; int puts(const char *s)
| |:|::::   0x004012a4      488d3d170e..   lea rdi, str.8._Request_privileged_data ; 0x4020c2 ; "8. Request privileged data" ; const char *s
| |:|::::   0x004012ab      e8c0fdffff     call sym.imp.puts           ; int puts(const char *s)
| |:|::::   0x004012b0      488d3d260e..   lea rdi, str.9._Destroy_session ; 0x4020dd ; "9. Destroy session" ; const char *s
| |:|::::   0x004012b7      e8b4fdffff     call sym.imp.puts           ; int puts(const char *s)
| |:|::::   0x004012bc      488d3d2d0e..   lea rdi, str.10._Exit       ; 0x4020f0 ; "10. Exit" ; const char *s
| |:|::::   0x004012c3      e8a8fdffff     call sym.imp.puts           ; int puts(const char *s)
| |:|::::   0x004012c8      488d352a0e..   lea rsi, [0x004020f9]       ; "> "
| |:|::::   0x004012cf      bf01000000     mov edi, 1
| |:|::::   0x004012d4      31c0           xor eax, eax
| |:|::::   0x004012d6      e815feffff     call sym.imp.__printf_chk
| |:|::::   0x004012db      e8b0090000     call fcn.00401c90
| |:|::::   0x004012e0      4883f80a       cmp rax, 0xa                ; 10
| ========< 0x004012e4      0f8707060000   ja case.0x4012f2.0
| |:|::::   0x004012ea      4863448500     movsxd rax, dword [rbp + rax*4]
| |:|::::   0x004012ef      4801e8         add rax, rbp
| |:|::::   ;-- switch:
| |:|::::   0x004012f2      ffe0           jmp rax                     ; switch table (11 cases) at 0x4022b8
..
| |:|::::   ;-- case 6:                                                ; from 0x004012f2
| |:|::::   ; CODE XREF from main @ 0x4012f2(x)
| |:|::::   0x004012f8      31db           xor ebx, ebx
| |:|::::   0x004012fa      660f1f440000   nop word [rax + rax]
| |:|::::   ; CODE XREF from main @ 0x401313(x)
| --------> 0x00401300      49833cdc00     cmp qword [r12 + rbx*8], 0
| ========< 0x00401305      0f84fd050000   je 0x401908
| |:|::::   0x0040130b      4883c301       add rbx, 1
| |:|::::   0x0040130f      4883fb08       cmp rbx, 8                  ; 8
| ========< 0x00401313      75eb           jne 0x401300
| |:|::::   0x00401315      488d3d2e0f..   lea rdi, str.No_free_sessions. ; 0x40224a ; "No free sessions." ; const char *s
| |:|::::   0x0040131c      e84ffdffff     call sym.imp.puts           ; int puts(const char *s)
| ========< 0x00401321      e92affffff     jmp 0x401250
..
| |:|::::   ;-- case 5:                                                ; from 0x004012f2
| |:|::::   ; CODE XREF from main @ 0x4012f2(x)
| |:|::::   0x00401330      488d35e90d..   lea rsi, str.Handle:        ; 0x402120 ; "Handle:"
| |:|::::   0x00401337      bf01000000     mov edi, 1
| |:|::::   0x0040133c      31c0           xor eax, eax
| |:|::::   0x0040133e      e8adfdffff     call sym.imp.__printf_chk
| |:|::::   0x00401343      e848090000     call fcn.00401c90
| |:|::::   0x00401348      4889c3         mov rbx, rax
| |:|::::   0x0040134b      4883f81f       cmp rax, 0x1f               ; 31
| ========< 0x0040134f      771f           ja 0x401370
| |:|::::   0x00401351      4c8d2d682d..   lea r13, [0x004040c0]
| |:|::::   0x00401358      48c1e004       shl rax, 4
| |:|::::   0x0040135c      4c01e8         add rax, r13
| |:|::::   0x0040135f      80780c00       cmp byte [rax + 0xc], 0
| ========< 0x00401363      740b           je 0x401370
| |:|::::   0x00401365      83780801       cmp dword [rax + 8], 1
| ========< 0x00401369      0f84e7060000   je 0x401a56
| |:|::::   0x0040136f      90             nop
| |:|::::   ; XREFS: CODE 0x0040134f  CODE 0x00401363  CODE 0x004013a4  
| |:|::::   ; XREFS: CODE 0x004013b8  CODE 0x004013be  CODE 0x004013c4  
| |:|::::   ; XREFS: CODE 0x004014b4  CODE 0x004014cd  CODE 0x004014d8  
| |:|::::   ; XREFS: CODE 0x004014e3  CODE 0x0040159c  CODE 0x004015b4  
| |:|::::   ; XREFS: CODE 0x004015be  CODE 0x004015ca  CODE 0x00401a5c  
| --------> 0x00401370      488d3db20d..   lea rdi, str.Invalid_handle. ; 0x402129 ; "Invalid handle." ; const char *s
| |:|::::   0x00401377      e8f4fcffff     call sym.imp.puts           ; int puts(const char *s)
| ========< 0x0040137c      e9cffeffff     jmp 0x401250
..
| |:|::::   ;-- case 4:                                                ; from 0x004012f2
| |:|::::   ; CODE XREF from main @ 0x4012f2(x)
| |:|::::   0x00401388      488d35910d..   lea rsi, str.Handle:        ; 0x402120 ; "Handle:"
| |:|::::   0x0040138f      bf01000000     mov edi, 1
| |:|::::   0x00401394      31c0           xor eax, eax
| |:|::::   0x00401396      e855fdffff     call sym.imp.__printf_chk
| |:|::::   0x0040139b      e8f0080000     call fcn.00401c90
| |:|::::   0x004013a0      4883f81f       cmp rax, 0x1f               ; 31
| ========< 0x004013a4      77ca           ja 0x401370
| |:|::::   0x004013a6      48c1e004       shl rax, 4
| |:|::::   0x004013aa      488d1d0f2d..   lea rbx, [0x004040c0]
| |:|::::   0x004013b1      4801c3         add rbx, rax
| |:|::::   0x004013b4      807b0c00       cmp byte [rbx + 0xc], 0
| ========< 0x004013b8      74b6           je 0x401370
| |:|::::   0x004013ba      837b0801       cmp dword [rbx + 8], 1
| ========< 0x004013be      75b0           jne 0x401370
| |:|::::   0x004013c0      48833b00       cmp qword [rbx], 0
| ========< 0x004013c4      74aa           je 0x401370
| |:|::::   0x004013c6      488d356c0d..   lea rsi, str.Offset:        ; 0x402139 ; "Offset:"
| |:|::::   0x004013cd      bf01000000     mov edi, 1
| |:|::::   0x004013d2      31c0           xor eax, eax
| |:|::::   0x004013d4      e817fdffff     call sym.imp.__printf_chk
| |:|::::   0x004013d9      e8b2080000     call fcn.00401c90
| |:|::::   0x004013de      488d355d0d..   lea rsi, str.Size:          ; 0x402142 ; "Size:"
| |:|::::   0x004013e5      bf01000000     mov edi, 1
| |:|::::   0x004013ea      4989c6         mov r14, rax
| |:|::::   0x004013ed      31c0           xor eax, eax
| |:|::::   0x004013ef      e8fcfcffff     call sym.imp.__printf_chk
| |:|::::   0x004013f4      e897080000     call fcn.00401c90
| |:|::::   0x004013f9      4989c5         mov r13, rax
| |:|::::   0x004013fc      4981fe0001..   cmp r14, 0x100              ; 256
| ========< 0x00401403      0f8797060000   ja 0x401aa0
| |:|::::   0x00401409      483d00010000   cmp rax, 0x100              ; 256
| ========< 0x0040140f      0f878b060000   ja 0x401aa0
| |:|::::   0x00401415      498d0406       lea rax, [r14 + rax]
| |:|::::   0x00401419      483d00010000   cmp rax, 0x100              ; 256
| ========< 0x0040141f      0f877b060000   ja 0x401aa0
| |:|::::   0x00401425      31c0           xor eax, eax
| |:|::::   0x00401427      488d35300d..   lea rsi, str.Data:          ; 0x40215e ; "Data:"
| |:|::::   0x0040142e      bf01000000     mov edi, 1
| |:|::::   0x00401433      e8b8fcffff     call sym.imp.__printf_chk
| |:|::::   0x00401438      4d85ed         test r13, r13
| ========< 0x0040143b      7445           je 0x401482
| |:|::::   0x0040143d      4c8b3b         mov r15, qword [rbx]
| |:|::::   0x00401440      31db           xor ebx, ebx
| ========< 0x00401442      eb0c           jmp 0x401450
..
| |:|::::   ; CODE XREF from main @ 0x40146d(x)
| --------> 0x00401448      4801c3         add rbx, rax
| |:|::::   0x0040144b      4c39eb         cmp rbx, r13
| ========< 0x0040144e      7332           jae 0x401482
| |:|::::   ; CODE XREFS from main @ 0x401442(x), 0x401480(x)
| --------> 0x00401450      4c89ea         mov rdx, r13
| |:|::::   0x00401453      498d341e       lea rsi, [r14 + rbx]
| |:|::::   0x00401457      31ff           xor edi, edi                ; int fildes
| |:|::::   0x00401459      4829da         sub rdx, rbx                ; size_t nbyte
| |:|::::   0x0040145c      4c01fe         add rsi, r15                ; void *buf
| |:|::::   0x0040145f      e85cfcffff     call sym.imp.read           ; ssize_t read(int fildes, void *buf, size_t nbyte)
| |:|::::   0x00401464      4885c0         test rax, rax
| ========< 0x00401467      0f846d060000   je 0x401ada
| ========< 0x0040146d      79d9           jns 0x401448
| |:|::::   0x0040146f      e8ccfbffff     call sym.imp.__errno_location
| |:|::::   0x00401474      833804         cmp dword [rax], 4
| |:|:::`=< 0x00401477      0f85dffcffff   jne 0x40115c
| |:|:::    0x0040147d      4c39eb         cmp rbx, r13
| ========< 0x00401480      72ce           jb 0x401450
| |:|:::    ; CODE XREFS from main @ 0x40143b(x), 0x40144e(x)
| --------> 0x00401482      488d3dec0c..   lea rdi, str.Written.       ; 0x402175 ; "Written." ; const char *s
| |:|:::    0x00401489      e8e2fbffff     call sym.imp.puts           ; int puts(const char *s)
| ========< 0x0040148e      e9bdfdffff     jmp 0x401250
..
| |:|:::    ;-- case 3:                                                ; from 0x004012f2
| |:|:::    ; CODE XREF from main @ 0x4012f2(x)
| |:|:::    0x00401498      488d35810c..   lea rsi, str.Handle:        ; 0x402120 ; "Handle:"
| |:|:::    0x0040149f      bf01000000     mov edi, 1
| |:|:::    0x004014a4      31c0           xor eax, eax
| |:|:::    0x004014a6      e845fcffff     call sym.imp.__printf_chk
| |:|:::    0x004014ab      e8e0070000     call fcn.00401c90
| |:|:::    0x004014b0      4883f81f       cmp rax, 0x1f               ; 31
| ========< 0x004014b4      0f87b6feffff   ja 0x401370
| |:|:::    0x004014ba      48c1e004       shl rax, 4
| |:|:::    0x004014be      4c8d2dfb2b..   lea r13, [0x004040c0]
| |:|:::    0x004014c5      4901c5         add r13, rax
| |:|:::    0x004014c8      41807d0c00     cmp byte [r13 + 0xc], 0
| ========< 0x004014cd      0f849dfeffff   je 0x401370
| |:|:::    0x004014d3      41837d0801     cmp dword [r13 + 8], 1
| ========< 0x004014d8      0f8592feffff   jne 0x401370
| |:|:::    0x004014de      49837d0000     cmp qword [r13], 0
| ========< 0x004014e3      0f8487feffff   je 0x401370
| |:|:::    0x004014e9      488d35490c..   lea rsi, str.Offset:        ; 0x402139 ; "Offset:"
| |:|:::    0x004014f0      bf01000000     mov edi, 1
| |:|:::    0x004014f5      31c0           xor eax, eax
| |:|:::    0x004014f7      e8f4fbffff     call sym.imp.__printf_chk
| |:|:::    0x004014fc      e88f070000     call fcn.00401c90
| |:|:::    0x00401501      488d353a0c..   lea rsi, str.Size:          ; 0x402142 ; "Size:"
| |:|:::    0x00401508      bf01000000     mov edi, 1
| |:|:::    0x0040150d      4889c3         mov rbx, rax
| |:|:::    0x00401510      31c0           xor eax, eax
| |:|:::    0x00401512      e8d9fbffff     call sym.imp.__printf_chk
| |:|:::    0x00401517      e874070000     call fcn.00401c90
| |:|:::    0x0040151c      4881fb0001..   cmp rbx, 0x100              ; 256
| |:|:::,=< 0x00401523      0f8777050000   ja 0x401aa0
| |:|:::|   0x00401529      483d00010000   cmp rax, 0x100              ; 256
| ========< 0x0040152f      0f876b050000   ja 0x401aa0
| |:|:::|   0x00401535      488d1403       lea rdx, [rbx + rax]
| |:|:::|   0x00401539      4881fa0001..   cmp rdx, 0x100              ; 256
| ========< 0x00401540      0f875a050000   ja 0x401aa0
| |:|:::|   0x00401546      498b7500       mov rsi, qword [r13]
| |:|:::|   0x0040154a      4889c2         mov rdx, rax                ; size_t nbytes
| |:|:::|   0x0040154d      bf01000000     mov edi, 1                  ; int fd
| |:|:::|   0x00401552      4801de         add rsi, rbx                ; const char *ptr
| |:|:::|   0x00401555      e826fbffff     call sym.imp.write          ; ssize_t write(int fd, const char *ptr, size_t nbytes)
| |:|:::|   0x0040155a      4885c0         test rax, rax
| |:|::`==< 0x0040155d      0f8805fcffff   js 0x401168
| |:|:: |   ; CODE XREF from main @ 0x401825(x)
| |:|::.--> 0x00401563      488b35b62a..   mov rsi, qword [obj.stdout] ; [0x404020:8]=0 ; FILE *stream
| |:|:::|   0x0040156a      bf0a000000     mov edi, 0xa                ; int c
| |:|:::|   0x0040156f      e86cfbffff     call sym.imp.putc           ; int putc(int c, FILE *stream)
| ========< 0x00401574      e9d7fcffff     jmp 0x401250
..
| |:|:::|   ;-- case 2:                                                ; from 0x004012f2
| |:|:::|   ; CODE XREF from main @ 0x4012f2(x)
| |:|:::|   0x00401580      488d35990b..   lea rsi, str.Handle:        ; 0x402120 ; "Handle:"
| |:|:::|   0x00401587      bf01000000     mov edi, 1
| |:|:::|   0x0040158c      31c0           xor eax, eax
| |:|:::|   0x0040158e      e85dfbffff     call sym.imp.__printf_chk
| |:|:::|   0x00401593      e8f8060000     call fcn.00401c90
| |:|:::|   0x00401598      4883f81f       cmp rax, 0x1f               ; 31
| ========< 0x0040159c      0f87cefdffff   ja 0x401370
| |:|:::|   0x004015a2      4c8d2d172b..   lea r13, [0x004040c0]
| |:|:::|   0x004015a9      48c1e004       shl rax, 4
| |:|:::|   0x004015ad      4c01e8         add rax, r13
| |:|:::|   0x004015b0      80780c00       cmp byte [rax + 0xc], 0
| ========< 0x004015b4      0f84b6fdffff   je 0x401370
| |:|:::|   0x004015ba      83780801       cmp dword [rax + 8], 1
| ========< 0x004015be      0f85acfdffff   jne 0x401370
| |:|:::|   0x004015c4      488b08         mov rcx, qword [rax]
| |:|:::|   0x004015c7      4885c9         test rcx, rcx
| ========< 0x004015ca      0f84a0fdffff   je 0x401370
| |:|:::|   0x004015d0      4c89e8         mov rax, r13
| |:|:::|   0x004015d3      31d2           xor edx, edx
| ========< 0x004015d5      eb19           jmp 0x4015f0
..
| |:|:::|   ; CODE XREF from main @ 0x4015f4(x)
| --------> 0x004015e0      83c201         add edx, 1
| |:|:::|   0x004015e3      4883c010       add rax, 0x10               ; 16
| |:|:::|   0x004015e7      83fa20         cmp edx, 0x20               ; 32
| ========< 0x004015ea      0f8444040000   je 0x401a34
| |:|:::|   ; CODE XREF from main @ 0x4015d5(x)
| --------> 0x004015f0      80780c00       cmp byte [rax + 0xc], 0
| ========< 0x004015f4      75ea           jne 0x4015e0
| |:|:::|   0x004015f6      89d0           mov eax, edx
| |:|:::|   0x004015f8      488d352f0c..   lea rsi, str.Duplicated_into_handle__d._n ; 0x40222e ; "Duplicated into handle %d.\n"
| |:|:::|   0x004015ff      bf01000000     mov edi, 1
| |:|:::|   0x00401604      48c1e004       shl rax, 4
| |:|:::|   0x00401608      49894c0500     mov qword [r13 + rax], rcx
| |:|:::|   0x0040160d      41c7440508..   mov dword [r13 + rax + 8], 1
| |:|:::|   0x00401616      41c644050c01   mov byte [r13 + rax + 0xc], 1
| |:|:::|   0x0040161c      31c0           xor eax, eax
| |:|:::|   0x0040161e      e8cdfaffff     call sym.imp.__printf_chk
| ========< 0x00401623      e928fcffff     jmp 0x401250
..
| |:|:::|   ;-- case 1:                                                ; from 0x004012f2
| |:|:::|   ; CODE XREF from main @ 0x4012f2(x)
| |:|:::|   0x00401630      4c8d2d892a..   lea r13, [0x004040c0]
| |:|:::|   0x00401637      31db           xor ebx, ebx
| |:|:::|   0x00401639      4c89e8         mov rax, r13
| ========< 0x0040163c      eb12           jmp 0x401650
..
| |:|:::|   ; CODE XREF from main @ 0x401654(x)
| --------> 0x00401640      83c301         add ebx, 1
| |:|:::|   0x00401643      4883c010       add rax, 0x10               ; 16
| |:|:::|   0x00401647      83fb20         cmp ebx, 0x20               ; 32
| ========< 0x0040164a      0f84e4030000   je 0x401a34
| |:|:::|   ; CODE XREF from main @ 0x40163c(x)
| --------> 0x00401650      80780c00       cmp byte [rax + 0xc], 0
| ========< 0x00401654      75ea           jne 0x401640
| |:|:::|   0x00401656      be00010000     mov esi, 0x100              ; 256 ; size_t size
| |:|:::|   0x0040165b      bf01000000     mov edi, 1                  ; size_t nmeb
| |:|:::|   0x00401660      e86bfaffff     call sym.imp.calloc         ; void *calloc(size_t nmeb, size_t size)
| |:|:::|   0x00401665      4889c2         mov rdx, rax
| |:|:::|   0x00401668      4885c0         test rax, rax
| ========< 0x0040166b      0f8481040000   je 0x401af2
| |:|:::|   0x00401671      488b05e829..   mov rax, qword [0x00404060] ; [0x404060:8]=0
| |:|:::|   0x00401678      660f6f0570..   movdqa xmm0, xmmword [str.ECIVEDHP] ; [0x4022f0:16]=-1 ; "ECIVEDHP"
| |:|:::|   0x00401680      48c74210e0..   mov qword [rdx + 0x10], 0xe0 ; [0xe0:8]=-1 ; 224
| |:|:::|   0x00401688      488d35850a..   lea rsi, str.Handle:__d_n   ; 0x402114 ; "Handle: %d\n"
| |:|:::|   0x0040168f      bf01000000     mov edi, 1
| |:|:::|   0x00401694      4831d0         xor rax, rdx
| |:|:::|   0x00401697      0f1102         movups xmmword [rdx], xmm0
| |:|:::|   0x0040169a      48894218       mov qword [rdx + 0x18], rax
| |:|:::|   0x0040169e      89d8           mov eax, ebx
| |:|:::|   0x004016a0      48c1e004       shl rax, 4
| |:|:::|   0x004016a4      4989540500     mov qword [r13 + rax], rdx
| |:|:::|   0x004016a9      89da           mov edx, ebx
| |:|:::|   0x004016ab      41c7440508..   mov dword [r13 + rax + 8], 1
| |:|:::|   0x004016b4      41c644050c01   mov byte [r13 + rax + 0xc], 1
| |:|:::|   0x004016ba      31c0           xor eax, eax
| |:|:::|   0x004016bc      e82ffaffff     call sym.imp.__printf_chk
| ========< 0x004016c1      e98afbffff     jmp 0x401250
..
| |:|:::|   ;-- case 10:                                               ; from 0x004012f2
| |:|:::|   ; CODE XREF from main @ 0x4012f2(x)
| |:|:::|   0x004016d0      488d3d370b..   lea rdi, str.Driver_detached. ; 0x40220e ; "Driver detached." ; const char *s
| |:|:::|   0x004016d7      e894f9ffff     call sym.imp.puts           ; int puts(const char *s)
| |:|:::|   0x004016dc      488b842408..   mov rax, qword [var_108h]
| |:|:::|   0x004016e4      64482b0425..   sub rax, qword fs:[0x28]
| ========< 0x004016ed      0f85fa030000   jne 0x401aed
| |:|:::|   0x004016f3      4881c41801..   add rsp, 0x118
| |:|:::|   0x004016fa      31c0           xor eax, eax
| |:|:::|   0x004016fc      5b             pop rbx
| |:|:::|   0x004016fd      5d             pop rbp
| |:|:::|   0x004016fe      415c           pop r12
| |:|:::|   0x00401700      415d           pop r13
| |:|:::|   0x00401702      415e           pop r14
| |:|:::|   0x00401704      415f           pop r15
| |:|:::|   0x00401706      c3             ret
..
| |:|:::|   ;-- case 8:                                                ; from 0x004012f2
| |:|:::|   ; CODE XREF from main @ 0x4012f2(x)
| |:|:::|   0x00401710      488d35850a..   lea rsi, str.Session:       ; 0x40219c ; "Session:"
| |:|:::|   0x00401717      bf01000000     mov edi, 1
| |:|:::|   0x0040171c      31c0           xor eax, eax
| |:|:::|   0x0040171e      e8cdf9ffff     call sym.imp.__printf_chk
| |:|:::|   0x00401723      e868050000     call fcn.00401c90
| |:|:::|   0x00401728      4883f807       cmp rax, 7                  ; 7
| ========< 0x0040172c      0f87ae010000   ja 0x4018e0
| |:|:::|   0x00401732      488d1d4729..   lea rbx, [0x00404080]
| |:|:::|   0x00401739      488b04c3       mov rax, qword [rbx + rax*8]
| |:|:::|   0x0040173d      4885c0         test rax, rax
| ========< 0x00401740      0f849a010000   je 0x4018e0
| |:|:::|   0x00401746      48ba4f4953..   movabs rdx, 0x504853455353494f ; 'OISSESHP'
| |:|:::|   0x00401750      483910         cmp qword [rax], rdx
| ========< 0x00401753      0f85ec020000   jne 0x401a45
| |:|:::|   0x00401759      48ba371337..   movabs rdx, 0x1337133713371337 ; '7\x137\x137\x137\x13'
| |:|:::|   0x00401763      48395010       cmp qword [rax + 0x10], rdx
| ========< 0x00401767      0f85d8020000   jne 0x401a45
| |:|:::|   0x0040176d      488b7008       mov rsi, qword [rax + 8]
| |:|:::|   0x00401771      488b4818       mov rcx, qword [rax + 0x18]
| |:|:::|   0x00401775      49b85aa55a..   movabs r8, 0xa55aa55aa55aa55a
| |:|:::|   0x0040177f      488b3dda28..   mov rdi, qword [0x00404060] ; [0x404060:8]=0
| |:|:::|   0x00401786      4889f2         mov rdx, rsi
| |:|:::|   0x00401789      4831fa         xor rdx, rdi
| |:|:::|   0x0040178c      48c1c211       rol rdx, 0x11
| |:|:::|   0x00401790      4831ca         xor rdx, rcx
| |:|:::|   0x00401793      4c31c2         xor rdx, r8
| |:|:::|   0x00401796      48395020       cmp qword [rax + 0x20], rdx
| ========< 0x0040179a      0f85a5020000   jne 0x401a45
| |:|:::|   0x004017a0      48c1c10b       rol rcx, 0xb
| |:|:::|   0x004017a4      4889ca         mov rdx, rcx
| |:|:::|   0x004017a7      48b9785478..   movabs rcx, 0x5478547854785478 ; 'xTxTxTxT'
| |:|:::|   0x004017b1      4801ce         add rsi, rcx
| |:|:::|   0x004017b4      4831fa         xor rdx, rdi
| |:|:::|   0x004017b7      48c1c61d       rol rsi, 0x1d
| |:|:::|   0x004017bb      4831f2         xor rdx, rsi
| |:|:::|   0x004017be      48395028       cmp qword [rax + 0x28], rdx
| ========< 0x004017c2      0f857d020000   jne 0x401a45
| |:|:::|   0x004017c8      31f6           xor esi, esi                ; int oflag
| |:|:::|   0x004017ca      488d3d000a..   lea rdi, str.flag.txt       ; 0x4021d1 ; "flag.txt" ; const char *path
| |:|:::|   0x004017d1      31c0           xor eax, eax
| |:|:::|   0x004017d3      e838f9ffff     call sym.imp.open           ; int open(const char *path, int oflag)
| |:|:::|   0x004017d8      89c3           mov ebx, eax
| |:|:::|   0x004017da      85c0           test eax, eax
| ========< 0x004017dc      0f88e7020000   js 0x401ac9
| |:|:::|   0x004017e2      89c7           mov edi, eax                ; int fildes
| |:|:::|   0x004017e4      baff000000     mov edx, 0xff               ; 255 ; size_t nbyte
| |:|:::|   0x004017e9      4889e6         mov rsi, rsp                ; void *buf
| |:|:::|   0x004017ec      e8cff8ffff     call sym.imp.read           ; ssize_t read(int fildes, void *buf, size_t nbyte)
| |:|:::|   0x004017f1      89df           mov edi, ebx                ; int fildes
| |:|:::|   0x004017f3      4989c5         mov r13, rax
| |:|:::|   0x004017f6      e8b5f8ffff     call sym.imp.close          ; int close(int fildes)
| |:|:::|   0x004017fb      4d85ed         test r13, r13
| ========< 0x004017fe      0f8ec5020000   jle 0x401ac9
| |:|:::|   0x00401804      4c89ea         mov rdx, r13                ; size_t nbytes
| |:|:::|   0x00401807      4889e6         mov rsi, rsp                ; const char *ptr
| |:|:::|   0x0040180a      bf01000000     mov edi, 1                  ; int fd
| |:|:::|   0x0040180f      42c6042c00     mov byte [rsp + r13], 0
| |:|:::|   0x00401814      e867f8ffff     call sym.imp.write          ; ssize_t write(int fd, const char *ptr, size_t nbytes)
| |:|:::|   0x00401819      42807c2cff0a   cmp byte [rsp + r13 - 1], 0xa
| ========< 0x0040181f      0f842bfaffff   je 0x401250
| |:|::`==< 0x00401825      e939fdffff     jmp 0x401563
..
| |:|:: |   ;-- case 7:                                                ; from 0x004012f2
| |:|:: |   ; CODE XREF from main @ 0x4012f2(x)
| |:|:: |   0x00401830      488d356509..   lea rsi, str.Session:       ; 0x40219c ; "Session:"
| |:|:: |   0x00401837      bf01000000     mov edi, 1
| |:|:: |   0x0040183c      31c0           xor eax, eax
| |:|:: |   0x0040183e      e8adf8ffff     call sym.imp.__printf_chk
| |:|:: |   0x00401843      e848040000     call fcn.00401c90
| |:|:: |   0x00401848      4883f807       cmp rax, 7                  ; 7
| |:|::,==< 0x0040184c      0f878e000000   ja 0x4018e0
| |:|::||   0x00401852      488d1d2728..   lea rbx, [0x00404080]
| |:|::||   0x00401859      488b04c3       mov rax, qword [rbx + rax*8]
| |:|::||   0x0040185d      4885c0         test rax, rax
| ========< 0x00401860      747e           je 0x4018e0
| |:|::||   0x00401862      488b4810       mov rcx, qword [rax + 0x10]
| |:|::||   0x00401866      488b5008       mov rdx, qword [rax + 8]
| |:|::||   0x0040186a      4c8d4030       lea r8, [rax + 0x30]
| |:|::||   0x0040186e      488d353109..   lea rsi, str.uid_lu_role_lu_name_s_n ; 0x4021a6 ; "uid=%lu role=%lu name=%s\n"
| |:|::||   0x00401875      bf01000000     mov edi, 1
| |:|::||   0x0040187a      31c0           xor eax, eax
| |:|::||   0x0040187c      e86ff8ffff     call sym.imp.__printf_chk
| ========< 0x00401881      e9caf9ffff     jmp 0x401250
..
| |:|::||   ;-- case 9:                                                ; from 0x004012f2
| |:|::||   ; CODE XREF from main @ 0x4012f2(x)
| |:|::||   0x00401890      488d350509..   lea rsi, str.Session:       ; 0x40219c ; "Session:"
| |:|::||   0x00401897      bf01000000     mov edi, 1
| |:|::||   0x0040189c      31c0           xor eax, eax
| |:|::||   0x0040189e      e84df8ffff     call sym.imp.__printf_chk
| |:|::||   0x004018a3      e8e8030000     call fcn.00401c90
| |:|::||   0x004018a8      4989c5         mov r13, rax
| |:|::||   0x004018ab      4883f807       cmp rax, 7                  ; 7
| ========< 0x004018af      772f           ja 0x4018e0
| |:|::||   0x004018b1      488d1dc827..   lea rbx, [0x00404080]
| |:|::||   0x004018b8      488b3cc3       mov rdi, qword [rbx + rax*8]
| |:|::||   0x004018bc      4885ff         test rdi, rdi
| ========< 0x004018bf      741f           je 0x4018e0
| |:|::||   0x004018c1      e86af7ffff     call sym.imp.free           ; void free(void *ptr)
| |:|::||   0x004018c6      31c0           xor eax, eax
| |:|::||   0x004018c8      488d3d2c09..   lea rdi, str.Session_destroyed. ; 0x4021fb ; "Session destroyed." ; const char *s
| |:|::||   0x004018cf      4a8904eb       mov qword [rbx + r13*8], rax
| |:|::||   0x004018d3      e898f7ffff     call sym.imp.puts           ; int puts(const char *s)
| ========< 0x004018d8      e973f9ffff     jmp 0x401250
..
| |:|::||   ; XREFS: CODE 0x0040172c  CODE 0x00401740  CODE 0x0040184c  
| |:|::||   ; XREFS: CODE 0x00401860  CODE 0x004018af  CODE 0x004018bf  
| -----`--> 0x004018e0      488d3dd908..   lea rdi, str.Invalid_session. ; 0x4021c0 ; "Invalid session." ; const char *s
| |:|:: |   0x004018e7      e884f7ffff     call sym.imp.puts           ; int puts(const char *s)
| ========< 0x004018ec      e95ff9ffff     jmp 0x401250
| |:|:: |   ;-- default:                                               ; from 0x4012f2
| |:|:: |   ; CODE XREFS from main @ 0x4012e4(x), 0x4012f2(x)
| --------> 0x004018f1      488d3d2709..   lea rdi, str.Unknown_ioctl. ; 0x40221f ; "Unknown ioctl." ; const char *s
| |:|:: |   0x004018f8      e873f7ffff     call sym.imp.puts           ; int puts(const char *s)
| ========< 0x004018fd      e94ef9ffff     jmp 0x401250
..
| |:|:: |   ; CODE XREF from main @ 0x401305(x)
| --------> 0x00401908      be00010000     mov esi, 0x100              ; 256 ; size_t size
| |:|:: |   0x0040190d      bf01000000     mov edi, 1                  ; size_t nmeb
| |:|:: |   0x00401912      e8b9f7ffff     call sym.imp.calloc         ; void *calloc(size_t nmeb, size_t size)
| |:|:: |   0x00401917      4989c5         mov r13, rax
| |:|:: |   0x0040191a      4885c0         test rax, rax
| |:|::,==< 0x0040191d      0f84d4010000   je 0x401af7
| |:|::||   0x00401923      488d355e08..   lea rsi, str.Name:          ; 0x402188 ; "Name:"
| |:|::||   0x0040192a      bf01000000     mov edi, 1
| |:|::||   0x0040192f      31c0           xor eax, eax
| |:|::||   0x00401931      e8baf7ffff     call sym.imp.__printf_chk
| |:|::||   0x00401936      498d7d30       lea rdi, [r13 + 0x30]       ; int64_t arg1
| |:|::||   0x0040193a      e8b1020000     call fcn.00401bf0
| |:|::||   0x0040193f      488b351a27..   mov rsi, qword [0x00404060] ; [0x404060:8]=0
| |:|::||   0x00401946      89d9           mov ecx, ebx
| |:|::||   0x00401948      48b84f4953..   movabs rax, 0x504853455353494f ; 'OISSESHP'
| |:|::||   0x00401952      49894500       mov qword [r13], rax
| |:|::||   0x00401956      8d4301         lea eax, [rbx + 1]
| |:|::||   0x00401959      48bf111111..   movabs rdi, 0x1111111111111111 ; '\x11\x11\x11\x11\x11\x11\x11\x11'
| |:|::||   0x00401963      488d91e803..   lea rdx, [rcx + 0x3e8]
| |:|::||   0x0040196a      480fafc7       imul rax, rdi
| |:|::||   0x0040196e      49895508       mov qword [r13 + 8], rdx
| |:|::||   0x00401972      4831f2         xor rdx, rsi
| |:|::||   0x00401975      48bf5aa55a..   movabs rdi, 0xa55aa55aa55aa55a
| |:|::||   0x0040197f      48c1c211       rol rdx, 0x11
| |:|::||   0x00401983      49c7451001..   mov qword [r13 + 0x10], 1
| |:|::||   0x0040198b      4d892ccc       mov qword [r12 + rcx*8], r13
| |:|::||   0x0040198f      4831f0         xor rax, rsi
| |:|::||   0x00401992      4c31e8         xor rax, r13
| |:|::||   0x00401995      4831c2         xor rdx, rax
| |:|::||   0x00401998      49894518       mov qword [r13 + 0x18], rax
| |:|::||   0x0040199c      48c1c00b       rol rax, 0xb
| |:|::||   0x004019a0      4831fa         xor rdx, rdi
| |:|::||   0x004019a3      bf01000000     mov edi, 1
| |:|::||   0x004019a8      49895520       mov qword [r13 + 0x20], rdx
| |:|::||   0x004019ac      48ba2a4541..   movabs rdx, 0x414141414141452a ; '*EAAAAAA'
| |:|::||   0x004019b6      4801ca         add rdx, rcx
| |:|::||   0x004019b9      48c1c21d       rol rdx, 0x1d
| |:|::||   0x004019bd      4831f2         xor rdx, rsi
| |:|::||   0x004019c0      488d35c807..   lea rsi, str.Session:__d_n  ; 0x40218f ; "Session: %d\n"
| |:|::||   0x004019c7      4831d0         xor rax, rdx
| |:|::||   0x004019ca      89da           mov edx, ebx
| |:|::||   0x004019cc      49894528       mov qword [r13 + 0x28], rax
| |:|::||   0x004019d0      31c0           xor eax, eax
| |:|::||   0x004019d2      e819f7ffff     call sym.imp.__printf_chk
| ========< 0x004019d7      e974f8ffff     jmp 0x401250
| |:|::||   ; CODE XREF from main @ 0x4011f3(x)
| |:`-----> 0x004019dc      488d2d7d26..   lea rbp, [0x00404060]
| |: ::||   0x004019e3      89c7           mov edi, eax                ; int fildes
| |: ::||   0x004019e5      ba08000000     mov edx, 8                  ; size_t nbyte
| |: ::||   0x004019ea      89c3           mov ebx, eax
| |: ::||   0x004019ec      4889ee         mov rsi, rbp                ; void *buf
| |: ::||   0x004019ef      e8ccf6ffff     call sym.imp.read           ; ssize_t read(int fildes, void *buf, size_t nbyte)
| |: ::||   0x004019f4      89df           mov edi, ebx                ; int fildes
| |: ::||   0x004019f6      4989c4         mov r12, rax
| |: ::||   0x004019f9      e8b2f6ffff     call sym.imp.close          ; int close(int fildes)
| |: ::||   0x004019fe      4983fc08       cmp r12, 8                  ; 8
| |`======< 0x00401a02      0f84f1f7ffff   je 0x4011f9
| |  ::||   0x00401a08      31d2           xor edx, edx
| |  ::||   0x00401a0a      4889154f26..   mov qword [0x00404060], rdx ; [0x404060:8]=0
| |  ::||   ; CODE XREF from main @ 0x401ac4(x)
| | .-----> 0x00401a11      e87af6ffff     call sym.imp.getpid         ; int getpid(void)
| | :::||   0x00401a16      4898           cdqe
| | :::||   0x00401a18      4831c5         xor rbp, rax
| | :::||   0x00401a1b      48b8907856..   movabs rax, 0xc0ffee1234567890
| | :::||   0x00401a25      4831c5         xor rbp, rax
| | :::||   0x00401a28      48892d3126..   mov qword [0x00404060], rbp ; [0x404060:8]=0
| ========< 0x00401a2f      e9d3f7ffff     jmp 0x401207
| | :::||   ; CODE XREFS from main @ 0x4015ea(x), 0x40164a(x)
| --------> 0x00401a34      488d3dc106..   lea rdi, str.No_free_handles. ; 0x4020fc ; "No free handles." ; const char *s
| | :::||   0x00401a3b      e830f6ffff     call sym.imp.puts           ; int puts(const char *s)
| ========< 0x00401a40      e90bf8ffff     jmp 0x401250
| | :::||   ; CODE XREFS from main @ 0x401753(x), 0x401767(x), 0x40179a(x), 0x4017c2(x)
| --------> 0x00401a45      488d3d8e07..   lea rdi, str.Access_denied. ; 0x4021da ; "Access denied." ; const char *s
| | :::||   0x00401a4c      e81ff6ffff     call sym.imp.puts           ; int puts(const char *s)
| ========< 0x00401a51      e9faf7ffff     jmp 0x401250
| | :::||   ; CODE XREF from main @ 0x401369(x)
| --------> 0x00401a56      488b38         mov rdi, qword [rax]
| | :::||   0x00401a59      4885ff         test rdi, rdi
| ========< 0x00401a5c      0f840ef9ffff   je 0x401370
| | :::||   0x00401a62      488b4708       mov rax, qword [rdi + 8]
| | :::||   0x00401a66      4885c0         test rax, rax
| |,======< 0x00401a69      7546           jne 0x401ab1
| ||:::||   ; CODE XREF from main @ 0x401abb(x)
| --------> 0x00401a6b      e8c0f5ffff     call sym.imp.free           ; void free(void *ptr)
| ||:::||   ; CODE XREF from main @ 0x401ab9(x)
| --------> 0x00401a70      48c1e304       shl rbx, 4
| ||:::||   0x00401a74      488d3d0307..   lea rdi, str.Released.      ; 0x40217e ; "Released." ; const char *s
| ||:::||   0x00401a7b      49c7441d00..   mov qword [r13 + rbx], 0
| ||:::||   0x00401a84      41c7441d08..   mov dword [r13 + rbx + 8], 0
| ||:::||   0x00401a8d      41c6441d0c00   mov byte [r13 + rbx + 0xc], 0
| ||:::||   0x00401a93      e8d8f5ffff     call sym.imp.puts           ; int puts(const char *s)
| ========< 0x00401a98      e9b3f7ffff     jmp 0x401250
..
| ||:::||   ; XREFS: CODE 0x00401403  CODE 0x0040140f  CODE 0x0040141f  
| ||:::||   ; XREFS: CODE 0x00401523  CODE 0x0040152f  CODE 0x00401540  
| ------`-> 0x00401aa0      488d3da206..   lea rdi, str.Invalid_range. ; 0x402149 ; "Invalid range." ; const char *s
| ||:::|    0x00401aa7      e8c4f5ffff     call sym.imp.puts           ; int puts(const char *s)
| ========< 0x00401aac      e99ff7ffff     jmp 0x401250
| ||:::|    ; CODE XREF from main @ 0x401a69(x)
| |`------> 0x00401ab1      4883e801       sub rax, 1
| | :::|    0x00401ab5      48894708       mov qword [rdi + 8], rax
| ========< 0x00401ab9      75b5           jne 0x401a70
| ========< 0x00401abb      ebae           jmp 0x401a6b
| | :::|    ; CODE XREF from main @ 0x401201(x)
| `-------> 0x00401abd      488d2d9c25..   lea rbp, [0x00404060]
|   `=====< 0x00401ac4      e948ffffff     jmp 0x401a11
|    ::|    ; CODE XREFS from main @ 0x4017dc(x), 0x4017fe(x)
| --------> 0x00401ac9      488d3d1907..   lea rdi, str.Flag_unavailable. ; 0x4021e9 ; "Flag unavailable." ; const char *s
|    ::|    0x00401ad0      e89bf5ffff     call sym.imp.puts           ; int puts(const char *s)
| ========< 0x00401ad5      e976f7ffff     jmp 0x401250
|    ::|    ; CODE XREF from main @ 0x401467(x)
| --------> 0x00401ada      488d3d8406..   lea rdi, str.Unexpected_EOF. ; 0x402165 ; "Unexpected EOF." ; const char *s
|    ::|    0x00401ae1      e88af5ffff     call sym.imp.puts           ; int puts(const char *s)
|    ::|    0x00401ae6      31ff           xor edi, edi                ; int status
|    ::|    0x00401ae8      e873f5ffff     call sym.imp._exit          ; void _exit(int status)
|    ::|    ; CODE XREF from main @ 0x4016ed(x)
| --------> 0x00401aed      e8aef5ffff     call sym.imp.__stack_chk_fail ; void stack_chk_fail(void)
|    |:|    ; CODE XREF from main @ 0x40166b(x)
| ---`====< 0x00401af2      e97df6ffff     jmp 0x401174
|     ||    ; CODE XREF from main @ 0x40191d(x)
|     ``--> 0x00401af7      e978f6ffff     jmp 0x401174
..
            ;-- rip:
