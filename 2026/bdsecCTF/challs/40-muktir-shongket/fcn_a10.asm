/ 393: d1 ();
| afv: vars(1:sp[0x10..0x10])
|      ::   0x00401a10      53             push rbx
|      ::   0x00401a11      488d35f105..   lea rsi, str.Hex_transmission: ; 0x402009 ; "Hex transmission:"
|      ::   0x00401a18      bf01000000     mov edi, 1
|      ::   0x00401a1d      4881ec9004..   sub rsp, 0x490
|      ::   0x00401a24      64488b0425..   mov rax, qword fs:[0x28]
|      ::   0x00401a2d      4889842488..   mov qword [var_488h], rax   ; [0x488:8]=-1 ; 1160
|      ::   0x00401a35      31c0           xor eax, eax
|      ::   0x00401a37      e8b4f6ffff     call sym.imp.__printf_chk
|      ::   0x00401a3c      be80040000     mov esi, 0x480              ; 1152
|      ::   0x00401a41      4889e7         mov rdi, rsp
|      ::   0x00401a44      e817ffffff     call 0x401960
|      ::   0x00401a49      0fb61c24       movzx ebx, byte [rsp]
|      ::   0x00401a4d      84db           test bl, bl
|     ,===< 0x00401a4f      743b           je 0x401a8c
|     |::   0x00401a51      e8eaf6ffff     call sym.imp.__ctype_b_loc
|     |::   0x00401a56      4989e0         mov r8, rsp
|     |::   0x00401a59      4889e2         mov rdx, rsp
|     |::   0x00401a5c      31f6           xor esi, esi
|     |::   0x00401a5e      488b38         mov rdi, qword [rax]
|     |::   0x00401a61      4989c1         mov r9, rax
|     |::   0x00401a64      89d8           mov eax, ebx
|     |::   0x00401a66      662e0f1f84..   nop word cs:[rax + rax]
|    .----> 0x00401a70      0fb6c8         movzx ecx, al
|    :|::   0x00401a73      f6444f0120     test byte [rdi + rcx*2 + 1], 0x20
|   ,=====< 0x00401a78      754a           jne 0x401ac4
|   |:|::   0x00401a7a      8d48d0         lea ecx, [rax - 0x30]
|   |:|::   0x00401a7d      80f909         cmp cl, 9                   ; 9
|  ,======< 0x00401a80      763e           jbe 0x401ac0
|  ||:|::   0x00401a82      83e0df         and eax, 0xffffffdf         ; 4294967263
|  ||:|::   0x00401a85      83e841         sub eax, 0x41               ; 65
|  ||:|::   0x00401a88      3c05           cmp al, 5                   ; 5
| ,=======< 0x00401a8a      7634           jbe 0x401ac0
| ----`---> 0x00401a8c      488b842488..   mov rax, qword [var_488h]
| |||: ::   0x00401a94      64482b0425..   sub rax, qword fs:[0x28]
| |||:,===< 0x00401a9d      0f8505010000   jne 0x401ba8
| |||:|::   0x00401aa3      4881c49004..   add rsp, 0x490
| |||:|::   0x00401aaa      488d3d0f07..   lea rdi, str.Upload_failed:_invalid_hexadecimal_transmission. ; 0x4021c0 ; "Upload failed: invalid hexadecimal transmission."
| |||:|::   0x00401ab1      5b             pop rbx
| |||:|:`=< 0x00401ab2      e9a9f5ffff     jmp sym.imp.puts
..
| ``------> 0x00401ac0      4883c601       add rsi, 1
|   `-----> 0x00401ac4      0fb64201       movzx eax, byte [rdx + 1]
|    :|:    0x00401ac8      4883c201       add rdx, 1
|    :|:    0x00401acc      84c0           test al, al
|    `====< 0x00401ace      75a0           jne 0x401a70
|     |:    0x00401ad0      488d46ff       lea rax, [rsi - 1]
|     |:    0x00401ad4      483d00040000   cmp rax, 0x400              ; 1024
| ========< 0x00401ada      77b0           ja 0x401a8c
|     |:    0x00401adc      83e601         and esi, 1
|     |:    0x00401adf      4889f2         mov rdx, rsi
| ========< 0x00401ae2      75a8           jne 0x401a8c
|     |:    0x00401ae4      b9ffffffff     mov ecx, 0xffffffff         ; -1
|     |:    0x00401ae9      488d359025..   lea rsi, [0x00404080]
|     |:    0x00401af0      41baffffffff   mov r10d, 0xffffffff        ; -1
|     |:,=< 0x00401af6      eb29           jmp 0x401b21
..
|    .----> 0x00401b00      c1e104         shl ecx, 4
|    :|:|   0x00401b03      09c1           or ecx, eax
|    :|:|   0x00401b05      880c16         mov byte [rsi + rdx], cl
|    :|:|   0x00401b08      4883c201       add rdx, 1
|    :|:|   0x00401b0c      b9ffffffff     mov ecx, 0xffffffff         ; -1
|   .-----> 0x00401b11      410fb65801     movzx ebx, byte [r8 + 1]
|   ::|:|   0x00401b16      4983c001       add r8, 1
|   ::|:|   0x00401b1a      84db           test bl, bl
|  ,======< 0x00401b1c      7440           je 0x401b5e
| .-------> 0x00401b1e      498b39         mov rdi, qword [r9]
| :|::|:|   ; CODE XREF from d1 @ 0x401af6(x)
| :|::|:`-> 0x00401b21      0fb6c3         movzx eax, bl
| :|::|:    0x00401b24      f644470120     test byte [rdi + rax*2 + 1], 0x20
| :|`=====< 0x00401b29      75e6           jne 0x401b11
| :| :|:    0x00401b2b      8d43d0         lea eax, [rbx - 0x30]
| :| :|:    0x00401b2e      3c09           cmp al, 9                   ; 9
| :| :|:,=< 0x00401b30      7671           jbe 0x401ba3
| :| :|:|   0x00401b32      8d439f         lea eax, [rbx - 0x61]
| :| :|:|   0x00401b35      3c05           cmp al, 5                   ; 5
| :|,=====< 0x00401b37      7667           jbe 0x401ba0
| :||:|:|   0x00401b39      8d7bbf         lea edi, [rbx - 0x41]
| :||:|:|   0x00401b3c      8d43c9         lea eax, [rbx - 0x37]
| :||:|:|   0x00401b3f      0fbec0         movsx eax, al
| :||:|:|   0x00401b42      4080ff06       cmp dil, 6                  ; 6
| :||:|:|   0x00401b46      410f43c2       cmovae eax, r10d
| :||:|:|   ; CODE XREF from d1 @ 0x401ba6(x)
| --------> 0x00401b4a      83f9ff         cmp ecx, 0xffffffff
| :||`====< 0x00401b4d      75b1           jne 0x401b00
| :|| |:|   0x00401b4f      410fb65801     movzx ebx, byte [r8 + 1]
| :|| |:|   0x00401b54      4983c001       add r8, 1
| :|| |:|   0x00401b58      89c1           mov ecx, eax
| :|| |:|   0x00401b5a      84db           test bl, bl
| `=======< 0x00401b5c      75c0           jne 0x401b1e
|  `------> 0x00401b5e      4889150325..   mov qword [0x00404068], rdx ; [0x404068:8]=0
|   | |:|   0x00401b65      c705f12400..   mov dword [0x00404060], 0   ; [0x404060:4]=0
|   | |:|   0x00401b6f      488b842488..   mov rax, qword [var_488h]
|   | |:|   0x00401b77      64482b0425..   sub rax, qword fs:[0x28]
|   |,====< 0x00401b80      7526           jne 0x401ba8
|   |||:|   0x00401b82      4881c49004..   add rsp, 0x490
|   |||:|   0x00401b89      488d356806..   lea rsi, str.Stored__zu_transmission_bytes._n ; 0x4021f8 ; "Stored %zu transmission bytes.\n"
|   |||:|   0x00401b90      bf01000000     mov edi, 1
|   |||:|   0x00401b95      31c0           xor eax, eax
|   |||:|   0x00401b97      5b             pop rbx
|   |||`==< 0x00401b98      e953f5ffff     jmp sym.imp.__printf_chk
..
|   `-----> 0x00401ba0      8d43a9         lea eax, [rbx - 0x57]
|    || `-> 0x00401ba3      0fbec0         movsx eax, al
| ========< 0x00401ba6      eba2           jmp 0x401b4a
\    ``---> 0x00401ba8      e8d3f4ffff     call sym.imp.__stack_chk_fail
