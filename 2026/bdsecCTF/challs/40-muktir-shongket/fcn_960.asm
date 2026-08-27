     ::::   ; CALL XREF from d2 @ 0x4012ac(x)
/ 1880: d2 (int64_t arg1, int64_t arg2);
| `- args(rdi, rsi) vars(5:sp[0x30..0xc8])
|    ::::   0x00401960      4155           push r13
|    ::::   0x00401962      4989fd         mov r13, rdi                ; arg1
|    ::::   0x00401965      4154           push r12
|    ::::   0x00401967      55             push rbp
|    ::::   0x00401968      31ed           xor ebp, ebp
|    ::::   0x0040196a      53             push rbx
|    ::::   0x0040196b      bb01000000     mov ebx, 1
|    ::::   0x00401970      4883ec18       sub rsp, 0x18
|    ::::   0x00401974      644c8b2425..   mov r12, qword fs:[0x28]
|    ::::   0x0040197d      4c89642408     mov qword [var_8h], r12
|    ::::   0x00401982      4989f4         mov r12, rsi                ; arg2
|   ,=====< 0x00401985      eb23           jmp 0x4019aa
..
|  .------> 0x00401990      0fb6442407     movzx eax, byte [var_7h]
|  :|::::   0x00401995      3c0a           cmp al, 0xa                 ; 10
| ,=======< 0x00401997      7447           je 0x4019e0
| |:|::::   0x00401999      4188442d00     mov byte [r13 + rbp], al
| |:|::::   0x0040199e      4889dd         mov rbp, rbx
| |:|::::   0x004019a1      488d5d01       lea rbx, [rbp + 1]
| |:|::::   0x004019a5      4c39e3         cmp rbx, r12
| ========< 0x004019a8      7336           jae 0x4019e0
| |:|::::   ; CODE XREF from d2 @ 0x401985(x)
| --`-----> 0x004019aa      31ff           xor edi, edi
| |: ::::   0x004019ac      ba01000000     mov edx, 1
| |: ::::   0x004019b1      488d742407     lea rsi, [var_7h]
| |: ::::   0x004019b6      e805f7ffff     call sym.imp.read
| |: ::::   0x004019bb      4885c0         test rax, rax
| |:,=====< 0x004019be      7420           je 0x4019e0
| |`======< 0x004019c0      79ce           jns 0x401990
| | |::::   0x004019c2      e869f6ffff     call sym.imp.__errno_location
| | |::::   0x004019c7      833804         cmp dword [rax], 4
| | |:`===< 0x004019ca      0f8590f7ffff   jne 0x401160
| | |: ::   0x004019d0      488d5d01       lea rbx, [rbp + 1]
| | |: ::   0x004019d4      4c39e3         cmp rbx, r12
| ========< 0x004019d7      72d1           jb 0x4019aa
| | |: ::   0x004019d9      0f1f800000..   nop dword [rax]
| `-`-----> 0x004019e0      41c6442d0000   mov byte [r13 + rbp], 0
|    : ::   0x004019e6      488b442408     mov rax, qword [var_8h]
|    : ::   0x004019eb      64482b0425..   sub rax, qword fs:[0x28]
|    :,===< 0x004019f4      750b           jne 0x401a01
|    :|::   0x004019f6      4883c418       add rsp, 0x18
|    :|::   0x004019fa      5b             pop rbx
|    :|::   0x004019fb      5d             pop rbp
|    :|::   0x004019fc      415c           pop r12
|    :|::   0x004019fe      415d           pop r13
|    :|::   0x00401a00      c3             ret
|    :`---> 0x00401a01      e87af6ffff     call sym.imp.__stack_chk_fail
..
     : ::   ; CALL XREF from d2 @ 0x4014c0(x)
            ;-- str.flag.txt:
            ;-- str.write:
            ; DATA XREF from d2 @ 0x40116c(r)
            ;-- str.2._Inspect_decoded_orders:
            ; DATA XREF from d2 @ 0x40124c(r)
            ;-- str.4._Execute_transmission:
            ; DATA XREF from d2 @ 0x401264(r)
            ;-- str.5._Clear_terminal:
            ; DATA XREF from d2 @ 0x401270(r)
            ;-- str.No_transmission_uploaded.:
            ; DATA XREFS from d2 @ 0x4017cc(r), 0x401827(r)
            ;-- str.SIGNAL:
            ; DATA XREF from d2 @ 0x401532(r)
            ;-- str.__0x_016lx:
            ; DATA XREF from d2 @ 0x401557(r)
            ;-- str.ROUTE:
            ; DATA XREF from d2 @ 0x40161c(r)
            ;-- str.mprotect:
            ; DATA XREF from d2 @ 0x401184(r)
            ;-- str.Upload_failed:_invalid_hexadecimal_transmission.:
            ;-- str.Stored__zu_transmission_bytes._n:
