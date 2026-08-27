/ 1699: int main (int argc, char **argv, char **envp);
| afv: vars(6:sp[0x40..0x128])
|      ::   0x00401190      4157           push r15
|      ::   0x00401192      ba02000000     mov edx, 2
|      ::   0x00401197      31f6           xor esi, esi
|      ::   0x00401199      4156           push r14
|      ::   0x0040119b      4155           push r13
|      ::   0x0040119d      4c8d2ddd2e..   lea r13, [0x00404081]
|      ::   0x004011a4      4154           push r12
|      ::   0x004011a6      4c8d251f13..   lea r12, [0x004024cc]
|      ::   0x004011ad      55             push rbp
|      ::   0x004011ae      53             push rbx
|      ::   0x004011af      4883ec68       sub rsp, 0x68
|      ::   0x004011b3      488b3d762e..   mov rdi, qword [obj.stdin]  ; [0x404030:8]=0
|      ::   0x004011ba      64488b0c25..   mov rcx, qword fs:[0x28]
|      ::   0x004011c3      48894c2458     mov qword [var_58h], rcx
|      ::   0x004011c8      31c9           xor ecx, ecx
|      ::   0x004011ca      488d6c2410     lea rbp, [var_10h]
|      ::   0x004011cf      e82cffffff     call sym.imp.setvbuf
|      ::   0x004011d4      488b3d452e..   mov rdi, qword [obj.stdout] ; [0x404020:8]=0
|      ::   0x004011db      31c9           xor ecx, ecx
|      ::   0x004011dd      31f6           xor esi, esi
|      ::   0x004011df      ba02000000     mov edx, 2
|      ::   0x004011e4      e817ffffff     call sym.imp.setvbuf
|      ::   0x004011e9      488b3d502e..   mov rdi, qword [obj.stderr] ; [0x404040:8]=0
|      ::   0x004011f0      31c9           xor ecx, ecx
|      ::   0x004011f2      31f6           xor esi, esi
|      ::   0x004011f4      ba02000000     mov edx, 2
|      ::   0x004011f9      e802ffffff     call sym.imp.setvbuf
|      ::   0x004011fe      488d3d5b10..   lea rdi, str.               ; 0x402260 ; "========================================"
|      ::   0x00401205      e856feffff     call sym.imp.puts
|      ::   0x0040120a      488d3d1a0e..   lea rdi, str._____________MUKTIR_SHONGKET ; 0x40202b ; "             MUKTIR SHONGKET"
|      ::   0x00401211      e84afeffff     call sym.imp.puts
|      ::   0x00401216      488d3d7310..   lea rdi, str._______FIELD_COMMUNICATION_TERMINAL ; 0x402290 ; "       FIELD COMMUNICATION TERMINAL"
|      ::   0x0040121d      e83efeffff     call sym.imp.puts
|      ::   0x00401222      488d3d3710..   lea rdi, str.               ; 0x402260 ; "========================================"
|      ::   0x00401229      e832feffff     call sym.imp.puts
|      ::   0x0040122e      488d3d8310..   lea rdi, str.Every_transmission_requires_command_approval. ; 0x4022b8 ; "Every transmission requires command approval."
|      ::   0x00401235      e826feffff     call sym.imp.puts
|      ::   0x0040123a      660f1f440000   nop word [rax + rax]
|      ::   ; XREFS: CODE 0x0040137c  CODE 0x00401428  CODE 0x004014b4  
|      ::   ; XREFS: CODE 0x004014c5  CODE 0x004015bb  CODE 0x00401684  
|      ::   ; XREFS: CODE 0x00401771  CODE 0x004017d8  CODE 0x004017e9  
| .....---> 0x00401240      488d3d010e..   lea rdi, str._n1._Upload_coded_transmission ; 0x402048 ; "\n1. Upload coded transmission"
| :::::::   0x00401247      e814feffff     call sym.imp.puts
| :::::::   0x0040124c      488d3d130e..   lea rdi, str.2._Inspect_decoded_orders ; 0x402066 ; "2. Inspect decoded orders"
| :::::::   0x00401253      e808feffff     call sym.imp.puts
| :::::::   0x00401258      488d3d210e..   lea rdi, str.3._Verify_transmission ; 0x402080 ; "3. Verify transmission"
| :::::::   0x0040125f      e8fcfdffff     call sym.imp.puts
| :::::::   0x00401264      488d3d2c0e..   lea rdi, str.4._Execute_transmission ; 0x402097 ; "4. Execute transmission"
| :::::::   0x0040126b      e8f0fdffff     call sym.imp.puts
| :::::::   0x00401270      488d3d380e..   lea rdi, str.5._Clear_terminal ; 0x4020af ; "5. Clear terminal"
| :::::::   0x00401277      e8e4fdffff     call sym.imp.puts
| :::::::   0x0040127c      488d3d3e0e..   lea rdi, str.6._Disconnect  ; 0x4020c1 ; "6. Disconnect"
| :::::::   0x00401283      e8d8fdffff     call sym.imp.puts
| :::::::   0x00401288      488d35400e..   lea rsi, [0x004020cf]       ; "> "
| :::::::   0x0040128f      bf01000000     mov edi, 1
| :::::::   0x00401294      31c0           xor eax, eax
| :::::::   0x00401296      e855feffff     call sym.imp.__printf_chk
| :::::::   0x0040129b      be40000000     mov esi, elf_phdr           ; 0x40
| :::::::   0x004012a0      4889ef         mov rdi, rbp
| :::::::   0x004012a3      48c7442408..   mov qword [var_8h], 0
| :::::::   0x004012ac      e8af060000     call 0x401960
| :::::::   0x004012b1      e87afdffff     call sym.imp.__errno_location
| :::::::   0x004012b6      ba0a000000     mov edx, 0xa
| :::::::   0x004012bb      488d742408     lea rsi, [var_8h]
| :::::::   0x004012c0      4889ef         mov rdi, rbp
| :::::::   0x004012c3      c70000000000   mov dword [rax], 0
| :::::::   0x004012c9      4889c3         mov rbx, rax
| :::::::   0x004012cc      e86ffdffff     call sym.imp.__isoc23_strtoull
| :::::::   0x004012d1      448b33         mov r14d, dword [rbx]
| :::::::   0x004012d4      4889c2         mov rdx, rax
| :::::::   0x004012d7      4585f6         test r14d, r14d
| ========< 0x004012da      0f8598030000   jne case.0x401308.0
| :::::::   0x004012e0      488b442408     mov rax, qword [var_8h]
| :::::::   0x004012e5      4839e8         cmp rax, rbp
| ========< 0x004012e8      0f848a030000   je case.0x401308.0
| :::::::   0x004012ee      803800         cmp byte [rax], 0
| ========< 0x004012f1      0f8581030000   jne case.0x401308.0
| :::::::   0x004012f7      4883fa06       cmp rdx, 6                  ; 6
| ========< 0x004012fb      0f8777030000   ja case.0x401308.0
| :::::::   0x00401301      49630494       movsxd rax, dword [r12 + rdx*4]
| :::::::   0x00401305      4c01e0         add rax, r12
| :::::::   ;-- switch:
| :::::::   0x00401308      ffe0           jmp rax                     ; switch table (7 cases) at 0x4024cc
..
| :::::::   ;-- case 6:                                                ; from 0x00401308
| :::::::   ; CODE XREF from main @ 0x401308(x)
| :::::::   0x00401310      488d3d6d0e..   lea rdi, str.Field_terminal_disconnected. ; 0x402184 ; "Field terminal disconnected."
| :::::::   0x00401317      e844fdffff     call sym.imp.puts
| :::::::   0x0040131c      488b442458     mov rax, qword [var_58h]
| :::::::   0x00401321      64482b0425..   sub rax, qword fs:[0x28]
| ========< 0x0040132a      0f8531050000   jne 0x401861
| :::::::   0x00401330      4883c468       add rsp, 0x68
| :::::::   0x00401334      31c0           xor eax, eax
| :::::::   0x00401336      5b             pop rbx
| :::::::   0x00401337      5d             pop rbp
| :::::::   0x00401338      415c           pop r12
| :::::::   0x0040133a      415d           pop r13
| :::::::   0x0040133c      415e           pop r14
| :::::::   0x0040133e      415f           pop r15
| :::::::   0x00401340      c3             ret
..
| :::::::   ;-- case 5:                                                ; from 0x00401308
| :::::::   ; CODE XREF from main @ 0x401308(x)
| :::::::   0x00401348      ba00020000     mov edx, 0x200              ; 512
| :::::::   0x0040134d      31f6           xor esi, esi
| :::::::   0x0040134f      488d3d2a2d..   lea rdi, [0x00404080]
| :::::::   0x00401356      e845fdffff     call sym.imp.memset
| :::::::   0x0040135b      488d3d090e..   lea rdi, str.Terminal_memory_cleared. ; 0x40216b ; "Terminal memory cleared."
| :::::::   0x00401362      48c705fb2c..   mov qword [0x00404068], 0   ; [0x404068:8]=0
| :::::::   0x0040136d      c705e92c00..   mov dword [0x00404060], 0   ; [0x404060:4]=0
| :::::::   0x00401377      e8e4fcffff     call sym.imp.puts
| ========< 0x0040137c      e9bffeffff     jmp 0x401240
..
| :::::::   ;-- case 4:                                                ; from 0x00401308
| :::::::   ; CODE XREF from main @ 0x401308(x)
| :::::::   0x00401388      8b05d22c0000   mov eax, dword [0x00404060] ; [0x404060:4]=0
| :::::::   0x0040138e      85c0           test eax, eax
| ========< 0x00401390      0f8447040000   je 0x4017dd
| :::::::   0x00401396      4531c9         xor r9d, r9d
| :::::::   0x00401399      41b8ffffffff   mov r8d, 0xffffffff         ; -1
| :::::::   0x0040139f      b922000000     mov ecx, 0x22               ; '\"' ; 34
| :::::::   0x004013a4      31ff           xor edi, edi
| :::::::   0x004013a6      ba03000000     mov edx, 3
| :::::::   0x004013ab      be00100000     mov esi, 0x1000
| :::::::   0x004013b0      e8dbfcffff     call sym.imp.mmap
| :::::::   0x004013b5      4989c6         mov r14, rax
| :::::::   0x004013b8      4883f8ff       cmp rax, 0xffffffffffffffff
| ::::::`=< 0x004013bc      0f84b6fdffff   je 0x401178
| ::::::    0x004013c2      488b359f2c..   mov rsi, qword [0x00404068] ; [0x404068:8]=0
| ::::::    0x004013c9      4885f6         test rsi, rsi
| ::::::,=< 0x004013cc      0f845d030000   je 0x40172f
| ::::::|   0x004013d2      31d2           xor edx, edx
| ::::::|   0x004013d4      31c0           xor eax, eax
| ::::::|   0x004013d6      488d1da32c..   lea rbx, [0x00404080]
| --------> 0x004013dd      0fb60c03       movzx ecx, byte [rbx + rax]
| ::::::|   0x004013e1      80f930         cmp cl, 0x30                ; '0' ; 48
| ========< 0x004013e4      0f8404040000   je 0x4017ee
| ========< 0x004013ea      0f87b4030000   ja 0x4017a4
| ::::::|   0x004013f0      80f910         cmp cl, 0x10                ; 16
| ========< 0x004013f3      0f8413030000   je 0x40170c
| ::::::|   0x004013f9      80f920         cmp cl, 0x20                ; 32
| ========< 0x004013fc      7511           jne 0x40140f
| ::::::|   0x004013fe      488d4a02       lea rcx, [rdx + 2]
| ::::::|   0x00401402      4881f90010..   cmp rcx, 0x1000
| ========< 0x00401409      0f8667030000   jbe 0x401776
| --------> 0x0040140f      4c89f7         mov rdi, r14
| ::::::|   0x00401412      be00100000     mov esi, 0x1000
| ::::::|   0x00401417      e8c4fcffff     call sym.imp.munmap
| ::::::|   0x0040141c      488d3d7510..   lea rdi, str.Field_engine_rejected_the_translated_transmission. ; 0x402498 ; "Field engine rejected the translated transmission."
| ::::::|   0x00401423      e838fcffff     call sym.imp.puts
| ========< 0x00401428      e913feffff     jmp 0x401240
..
| ::::::|   ;-- case 3:                                                ; from 0x00401308
| ::::::|   ; CODE XREF from main @ 0x401308(x)
| ::::::|   0x00401430      488b0d312c..   mov rcx, qword [0x00404068] ; [0x404068:8]=0
| ::::::|   0x00401437      4885c9         test rcx, rcx
| ========< 0x0040143a      0f84e7030000   je 0x401827
| ::::::|   0x00401440      4531ff         xor r15d, r15d
| ::::::|   0x00401443      31d2           xor edx, edx
| ::::::|   0x00401445      488d1d342c..   lea rbx, [0x00404080]
| ========< 0x0040144c      eb2e           jmp 0x40147c
..
| --------> 0x00401450      3c10           cmp al, 0x10                ; 16
| ========< 0x00401452      0f8408020000   je 0x401660
| ::::::|   0x00401458      3c20           cmp al, 0x20                ; 32
| ========< 0x0040145a      753e           jne 0x40149a
| ::::::|   0x0040145c      488d7209       lea rsi, [rdx + 9]
| ::::::|   0x00401460      4839f1         cmp rcx, rsi
| ========< 0x00401463      7235           jb 0x40149a
| --------> 0x00401465      3c40           cmp al, 0x40                ; elf_phdr
| ::::::|   0x00401467      4889f2         mov rdx, rsi
| ::::::|   0x0040146a      0f94c0         sete al
| ::::::|   0x0040146d      0fb6c0         movzx eax, al
| ::::::|   0x00401470      4109c7         or r15d, eax
| ::::::|   0x00401473      4839ca         cmp rdx, rcx
| ========< 0x00401476      0f836e010000   jae 0x4015ea
| ::::::|   ; CODE XREF from main @ 0x40144c(x)
| --------> 0x0040147c      0fb60413       movzx eax, byte [rbx + rdx]
| ::::::|   0x00401480      3c30           cmp al, 0x30                ; '0' ; 48
| ========< 0x00401482      0f8438010000   je 0x4015c0
| ========< 0x00401488      76c6           jbe 0x401450
| ::::::|   0x0040148a      3c40           cmp al, 0x40                ; elf_phdr
| ========< 0x0040148c      0f84ce010000   je 0x401660
| ::::::|   0x00401492      3cf0           cmp al, 0xf0                ; 240
| ========< 0x00401494      0f84f6010000   je 0x401690
| ::::::|   ; CODE XREF from main @ 0x40166d(x)
| --------> 0x0040149a      488d356f0e..   lea rsi, str.Rejected:_malformed_order_at_offset__zx._n ; 0x402310 ; "Rejected: malformed order at offset %#zx.\n"
| ::::::|   0x004014a1      bf01000000     mov edi, 1
| ::::::|   0x004014a6      31c0           xor eax, eax
| ::::::|   0x004014a8      e843fcffff     call sym.imp.__printf_chk
| ::::::|   ; CODE XREFS from main @ 0x401602(x), 0x4016a9(x), 0x401833(x), 0x40185c(x)
| --------> 0x004014ad      448935ac2b..   mov dword [0x00404060], r14d ; [0x404060:4]=0
| ========< 0x004014b4      e987fdffff     jmp 0x401240
..
| ::::::|   ;-- case 1:                                                ; from 0x00401308
| ::::::|   ; CODE XREF from main @ 0x401308(x)
| ::::::|   0x004014c0      e84b050000     call 0x401a10
| ========< 0x004014c5      e976fdffff     jmp 0x401240
..
| ::::::|   ;-- case 2:                                                ; from 0x00401308
| ::::::|   ; CODE XREF from main @ 0x401308(x)
| ::::::|   0x004014d0      48833d902b..   cmp qword [0x00404068], 0   ; [0x404068:8]=0
| ========< 0x004014d8      0f84ee020000   je 0x4017cc
| ::::::|   0x004014de      488d3d070c..   lea rdi, str.OFFSET__ORDER_____OPERAND ; 0x4020ec ; "OFFSET  ORDER     OPERAND"
| ::::::|   0x004014e5      e876fbffff     call sym.imp.puts
| ::::::|   0x004014ea      488d3df70d..   lea rdi, str.__________________________________ ; 0x4022e8 ; "------  --------  ----------------"
| ::::::|   0x004014f1      e86afbffff     call sym.imp.puts
| ::::::|   0x004014f6      488b056b2b..   mov rax, qword [0x00404068] ; [0x404068:8]=0
| ::::::|   0x004014fd      4885c0         test rax, rax
| ========< 0x00401500      0f843afdffff   je 0x401240
| ::::::|   0x00401506      4531f6         xor r14d, r14d
| ::::::|   0x00401509      488d1d702b..   lea rbx, [0x00404080]
| ========< 0x00401510      eb75           jmp 0x401587
..
| --------> 0x00401518      80f910         cmp cl, 0x10                ; 16
| ========< 0x0040151b      0f848d010000   je 0x4016ae
| ::::::|   0x00401521      80f920         cmp cl, 0x20                ; 32
| ========< 0x00401524      757f           jne 0x4015a5
| ::::::|   0x00401526      4d8d7e09       lea r15, [r14 + 9]
| ::::::|   0x0040152a      4c39f8         cmp rax, r15
| ========< 0x0040152d      7276           jb 0x4015a5
| ::::::|   0x0040152f      4c89f2         mov rdx, r14
| ::::::|   0x00401532      488d0de70b..   lea rcx, str.SIGNAL         ; 0x402120 ; "SIGNAL"
| ::::::|   0x00401539      488d35e70b..   lea rsi, str._04zx______8s  ; 0x402127 ; "%04zx    %-8s"
| ::::::|   0x00401540      31c0           xor eax, eax
| ::::::|   0x00401542      bf01000000     mov edi, 1
| ::::::|   0x00401547      e8a4fbffff     call sym.imp.__printf_chk
| ::::::|   0x0040154c      4b8b142e       mov rdx, qword [r14 + r13]
| ::::::|   0x00401550      bf01000000     mov edi, 1
| ::::::|   0x00401555      31c0           xor eax, eax
| ::::::|   0x00401557      488d35d70b..   lea rsi, str.__0x_016lx     ; 0x402135 ; "  0x%016lx"
| ::::::|   0x0040155e      4d89fe         mov r14, r15
| ::::::|   0x00401561      e88afbffff     call sym.imp.__printf_chk
| ::::::|   ; CODE XREFS from main @ 0x401652(x), 0x4016db(x)
| --------> 0x00401566      488b35b32a..   mov rsi, qword [obj.stdout] ; [0x404020:8]=0
| ::::::|   0x0040156d      bf0a000000     mov edi, 0xa
| ::::::|   0x00401572      e859fbffff     call sym.imp.putc
| ::::::|   0x00401577      488b05ea2a..   mov rax, qword [0x00404068] ; [0x404068:8]=0
| ::::::|   0x0040157e      4939c6         cmp r14, rax
| ========< 0x00401581      0f83b9fcffff   jae 0x401240
| ::::::|   ; CODE XREF from main @ 0x401510(x)
| --------> 0x00401587      420fb60c33     movzx ecx, byte [rbx + r14]
| ::::::|   0x0040158c      80f930         cmp cl, 0x30                ; '0' ; 48
| ========< 0x0040158f      747f           je 0x401610
| ========< 0x00401591      7685           jbe 0x401518
| ::::::|   0x00401593      80f940         cmp cl, 0x40                ; elf_phdr
| ========< 0x00401596      0f845a010000   je 0x4016f6
| ::::::|   0x0040159c      80f9f0         cmp cl, 0xf0                ; 240
| ========< 0x0040159f      0f843b010000   je 0x4016e0
| --------> 0x004015a5      4c89f2         mov rdx, r14
| ::::::|   0x004015a8      488d35570b..   lea rsi, str._04zx____UNKNOWN____02x_n ; 0x402106 ; "%04zx    UNKNOWN   %#02x\n"
| ::::::|   0x004015af      bf01000000     mov edi, 1
| ::::::|   0x004015b4      31c0           xor eax, eax
| ::::::|   0x004015b6      e835fbffff     call sym.imp.__printf_chk
| `=======< 0x004015bb      e980fcffff     jmp 0x401240
| --------> 0x004015c0      488d7202       lea rsi, [rdx + 2]
|  :::::|   0x004015c4      4839f1         cmp rcx, rsi
| ========< 0x004015c7      0f82cdfeffff   jb 0x40149a
|  :::::|   0x004015cd      0fb6441301     movzx eax, byte [rbx + rdx + 1]
|  :::::|   0x004015d2      4801f0         add rax, rsi
|  :::::|   0x004015d5      4839c8         cmp rax, rcx
| ,=======< 0x004015d8      0f836b020000   jae 0x401849
| |:::::|   0x004015de      4889f2         mov rdx, rsi
| |:::::|   0x004015e1      4839ca         cmp rdx, rcx
| ========< 0x004015e4      0f8292feffff   jb 0x40147c
| --------> 0x004015ea      4585ff         test r15d, r15d
| ========< 0x004015ed      0f8445020000   je 0x401838
| |:::::|   0x004015f3      488d3dde0d..   lea rdi, str.Transmission_approved_by_command_verification. ; 0x4023d8 ; "Transmission approved by command verification."
| |:::::|   0x004015fa      e861faffff     call sym.imp.puts
| |:::::|   ; CODE XREF from main @ 0x401844(x)
| --------> 0x004015ff      4589fe         mov r14d, r15d
| ========< 0x00401602      e9a6feffff     jmp 0x4014ad
..
| --------> 0x00401610      4d8d7e02       lea r15, [r14 + 2]
| |:::::|   0x00401614      4c39f8         cmp rax, r15
| ========< 0x00401617      728c           jb 0x4015a5
| |:::::|   0x00401619      4c89f2         mov rdx, r14
| |:::::|   0x0040161c      488d0d1d0b..   lea rcx, str.ROUTE          ; 0x402140 ; "ROUTE"
| |:::::|   0x00401623      488d35fd0a..   lea rsi, str._04zx______8s  ; 0x402127 ; "%04zx    %-8s"
| |:::::|   0x0040162a      31c0           xor eax, eax
| |:::::|   0x0040162c      bf01000000     mov edi, 1
| |:::::|   0x00401631      e8bafaffff     call sym.imp.__printf_chk
| |:::::|   0x00401636      420fb6543301   movzx edx, byte [rbx + r14 + 1]
| |:::::|   0x0040163c      488d35030b..   lea rsi, str.___u           ; 0x402146 ; "  +%u"
| |:::::|   0x00401643      31c0           xor eax, eax
| |:::::|   0x00401645      bf01000000     mov edi, 1
| |:::::|   0x0040164a      4d89fe         mov r14, r15
| |:::::|   0x0040164d      e89efaffff     call sym.imp.__printf_chk
| ========< 0x00401652      e90fffffff     jmp 0x401566
..
| --------> 0x00401660      488d7201       lea rsi, [rdx + 1]
| |:::::|   0x00401664      4839f1         cmp rcx, rsi
| ========< 0x00401667      0f83f8fdffff   jae 0x401465
| ========< 0x0040166d      e928feffff     jmp 0x40149a
..
| |:::::|   ;-- default:                                               ; from 0x401308
| |:::::|   ; CODE XREF from main @ 0x401308(x)
| --------> 0x00401678      488d3d220b..   lea rdi, str.Unknown_terminal_command. ; 0x4021a1 ; "Unknown terminal command."
| |:::::|   0x0040167f      e8dcf9ffff     call sym.imp.puts
| |`======< 0x00401684      e9b7fbffff     jmp 0x401240
..
| --------> 0x00401690      488d4201       lea rax, [rdx + 1]
| | ::::|   0x00401694      4839c1         cmp rcx, rax
| ========< 0x00401697      0f82fdfdffff   jb 0x40149a
| | ::::|   0x0040169d      488d3d9c0c..   lea rdi, str.Rejected:_unauthorized_freedom_broadcast. ; 0x402340 ; "Rejected: unauthorized freedom broadcast."
| | ::::|   0x004016a4      e8b7f9ffff     call sym.imp.puts
| ========< 0x004016a9      e9fffdffff     jmp 0x4014ad
| --------> 0x004016ae      4d8d7e01       lea r15, [r14 + 1]
| | ::::|   0x004016b2      4c39f8         cmp rax, r15
| ========< 0x004016b5      0f82eafeffff   jb 0x4015a5
| | ::::|   0x004016bb      488d0d8e0a..   lea rcx, str.WAIT           ; 0x402150 ; "WAIT"
| | ::::|   ; CODE XREFS from main @ 0x4016f4(x), 0x40170a(x)
| -.------> 0x004016c2      4c89f2         mov rdx, r14
| |:::::|   0x004016c5      488d355b0a..   lea rsi, str._04zx______8s  ; 0x402127 ; "%04zx    %-8s"
| |:::::|   0x004016cc      bf01000000     mov edi, 1
| |:::::|   0x004016d1      31c0           xor eax, eax
| |:::::|   0x004016d3      e818faffff     call sym.imp.__printf_chk
| |:::::|   0x004016d8      4d89fe         mov r14, r15
| ========< 0x004016db      e986feffff     jmp 0x401566
| --------> 0x004016e0      4d8d7e01       lea r15, [r14 + 1]
| |:::::|   0x004016e4      4c39f8         cmp rax, r15
| ========< 0x004016e7      0f82b8feffff   jb 0x4015a5
| |:::::|   0x004016ed      488d0d610a..   lea rcx, str.FREEDOM        ; 0x402155 ; "FREEDOM"
| ========< 0x004016f4      ebcc           jmp 0x4016c2
| --------> 0x004016f6      4d8d7e01       lea r15, [r14 + 1]
| |:::::|   0x004016fa      4c39f8         cmp rax, r15
| ========< 0x004016fd      0f82a2feffff   jb 0x4015a5
| |:::::|   0x00401703      488d0d420a..   lea rcx, [0x0040214c]       ; "END"
| |`======< 0x0040170a      ebb6           jmp 0x4016c2
| --------> 0x0040170c      4881fa0010..   cmp rdx, 0x1000
| ========< 0x00401713      0f84f6fcffff   je 0x40140f
| | ::::|   0x00401719      41c6041690     mov byte [r14 + rdx], 0x90  ; [0x90:1]=255 ; 144
| | ::::|   0x0040171e      4883c001       add rax, 1
| | ::::|   0x00401722      4883c201       add rdx, 1
| | ::::|   ; CODE XREFS from main @ 0x4017a2(x), 0x4017c7(x), 0x401822(x)
| -.------> 0x00401726      4839f0         cmp rax, rsi
| ========< 0x00401729      0f82aefcffff   jb 0x4013dd
| |:::::`-> 0x0040172f      ba05000000     mov edx, 5
| |:::::    0x00401734      be00100000     mov esi, 0x1000
| |:::::    0x00401739      4c89f7         mov rdi, r14
| |:::::    0x0040173c      e8cff9ffff     call sym.imp.mprotect
| |:::::    0x00401741      85c0           test eax, eax
| |::::`==< 0x00401743      0f853bfaffff   jne 0x401184
| |::::     0x00401749      488d3df00c..   lea rdi, str.Relaying_orders_to_field_execution_engine... ; 0x402440 ; "Relaying orders to field execution engine..."
| |::::     0x00401750      e80bf9ffff     call sym.imp.puts
| |::::     0x00401755      41ffd6         call r14
| |::::     0x00401758      4c89f7         mov rdi, r14
| |::::     0x0040175b      be00100000     mov esi, 0x1000
| |::::     0x00401760      e87bf9ffff     call sym.imp.munmap
| |::::     0x00401765      488d3d040d..   lea rdi, str.Transmission_execution_completed. ; 0x402470 ; "Transmission execution completed."
| |::::     0x0040176c      e8eff8ffff     call sym.imp.puts
| |:`=====< 0x00401771      e9cafaffff     jmp 0x401240
| --------> 0x00401776      6641c70416..   mov word [r14 + rdx], 0x8eb ; [0x8eb:2]=0xffff ; 2283
| |: ::     0x0040177d      4883c20a       add rdx, 0xa
| |: ::     0x00401781      4881fa0010..   cmp rdx, 0x1000
| ========< 0x00401788      0f8781fcffff   ja 0x40140f
| |: ::     0x0040178e      488d3dec28..   lea rdi, [0x00404081]
| |: ::     0x00401795      4883c009       add rax, 9
| |: ::     0x00401799      488b7c38f7     mov rdi, qword [rax + rdi - 9]
| |: ::     0x0040179e      49893c0e       mov qword [r14 + rcx], rdi
| ========< 0x004017a2      eb82           jmp 0x401726
| --------> 0x004017a4      80f940         cmp cl, 0x40                ; elf_phdr
| ========< 0x004017a7      0f8562fcffff   jne 0x40140f
| |: ::     0x004017ad      4881fa0010..   cmp rdx, 0x1000
| ========< 0x004017b4      0f8455fcffff   je 0x40140f
| |: ::     0x004017ba      41c60416c3     mov byte [r14 + rdx], 0xc3  ; [0xc3:1]=255 ; 195
| |: ::     0x004017bf      4883c001       add rax, 1
| |: ::     0x004017c3      4883c201       add rdx, 1
| ========< 0x004017c7      e95affffff     jmp 0x401726
| --------> 0x004017cc      488d3dff08..   lea rdi, str.No_transmission_uploaded. ; 0x4020d2 ; "No transmission uploaded."
| |: ::     0x004017d3      e888f8ffff     call sym.imp.puts
| |: `====< 0x004017d8      e963faffff     jmp 0x401240
| --------> 0x004017dd      488d3d240c..   lea rdi, str.Execution_denied:_transmission_has_not_been_verified. ; 0x402408 ; "Execution denied: transmission has not been verified."
| |:  :     0x004017e4      e877f8ffff     call sym.imp.puts
| |:  `===< 0x004017e9      e952faffff     jmp 0x401240
| --------> 0x004017ee      4881fa0010..   cmp rdx, 0x1000
| ========< 0x004017f5      0f8414fcffff   je 0x40140f
| |:        0x004017fb      488d7a05       lea rdi, [rdx + 5]
| |:        0x004017ff      0fbe4c0301     movsx ecx, byte [rbx + rax + 1]
| |:        0x00401804      41c60416e9     mov byte [r14 + rdx], 0xe9  ; [0xe9:1]=255 ; 233
| |:        0x00401809      4881ff0010..   cmp rdi, 0x1000
| ========< 0x00401810      0f87f9fbffff   ja 0x40140f
| |:        0x00401816      41894c1601     mov dword [r14 + rdx + 1], ecx
| |:        0x0040181b      4883c002       add rax, 2
| |:        0x0040181f      4889fa         mov rdx, rdi
| |`======< 0x00401822      e9fffeffff     jmp 0x401726
| --------> 0x00401827      488d3da408..   lea rdi, str.No_transmission_uploaded. ; 0x4020d2 ; "No transmission uploaded."
| |         0x0040182e      e82df8ffff     call sym.imp.puts
| ========< 0x00401833      e975fcffff     jmp 0x4014ad
| --------> 0x00401838      488d3d690b..   lea rdi, str.Rejected:_transmission_has_no_END_order. ; 0x4023a8 ; "Rejected: transmission has no END order."
| |         0x0040183f      e81cf8ffff     call sym.imp.puts
| ========< 0x00401844      e9b6fdffff     jmp 0x4015ff
| `-------> 0x00401849      488d35200b..   lea rsi, str.Rejected:_route_leaves_transmission_at_offset__zx._n ; 0x402370 ; "Rejected: route leaves transmission at offset %#zx.\n"
|           0x00401850      bf01000000     mov edi, 1
|           0x00401855      31c0           xor eax, eax
|           0x00401857      e894f8ffff     call sym.imp.__printf_chk
| ========< 0x0040185c      e94cfcffff     jmp 0x4014ad
| --------> 0x00401861      e81af8ffff     call sym.imp.__stack_chk_fail
..
            ;-- entry0:
