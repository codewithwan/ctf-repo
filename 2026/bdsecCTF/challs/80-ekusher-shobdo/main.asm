            ; DATA XREF from entry0 @ 0x1a18(r)
/ 2091: int main (int argc, char **argv, char **envp);
|           0x00001180      4155           push r13
|           0x00001182      31c9           xor ecx, ecx                ; size_t size
|           0x00001184      ba02000000     mov edx, 2                  ; int mode
|           0x00001189      31f6           xor esi, esi                ; char *buf
|           0x0000118b      4154           push r12
|           0x0000118d      4c8d259424..   lea r12, [0x00003628]
|           0x00001194      55             push rbp
|           0x00001195      53             push rbx
|           0x00001196      4883ec08       sub rsp, 8
|           0x0000119a      488b3d8f3e..   mov rdi, qword [obj.stdin]  ; [0x5030:8]=0 ; FILE*stream
|           0x000011a1      e89afeffff     call sym.imp.setvbuf        ; int setvbuf(FILE*stream, char *buf, int mode, size_t size)
|           0x000011a6      488b3d733e..   mov rdi, qword [obj.stdout] ; [0x5020:8]=0 ; FILE*stream
|           0x000011ad      31c9           xor ecx, ecx                ; size_t size
|           0x000011af      31f6           xor esi, esi                ; char *buf
|           0x000011b1      ba02000000     mov edx, 2                  ; int mode
|           0x000011b6      e885feffff     call sym.imp.setvbuf        ; int setvbuf(FILE*stream, char *buf, int mode, size_t size)
|           0x000011bb      488b3d7e3e..   mov rdi, qword [obj.stderr] ; [0x5040:8]=0 ; FILE*stream
|           0x000011c2      31c9           xor ecx, ecx                ; size_t size
|           0x000011c4      31f6           xor esi, esi                ; char *buf
|           0x000011c6      ba02000000     mov edx, 2                  ; int mode
|           0x000011cb      e870feffff     call sym.imp.setvbuf        ; int setvbuf(FILE*stream, char *buf, int mode, size_t size)
|           0x000011d0      488d3d411f..   lea rdi, str.               ; 0x3118 ; "============================================================" ; const char *s
|           0x000011d7      e804ffffff     call sym.imp.puts           ; int puts(const char *s)
|           0x000011dc      488d3d751f..   lea rdi, str._____________________EKUSHER_SHOBDO ; 0x3158 ; "                     EKUSHER SHOBDO" ; const char *s
|           0x000011e3      e8f8feffff     call sym.imp.puts           ; int puts(const char *s)
|           0x000011e8      488d3d911f..   lea rdi, str.________________LANGUAGE_ARCHIVE_TERMINAL ; 0x3180 ; "                LANGUAGE ARCHIVE TERMINAL" ; const char *s
|           0x000011ef      e8ecfeffff     call sym.imp.puts           ; int puts(const char *s)
|           0x000011f4      488d3d1d1f..   lea rdi, str.               ; 0x3118 ; "============================================================" ; const char *s
|           0x000011fb      e8e0feffff     call sym.imp.puts           ; int puts(const char *s)
|           0x00001200      488d3da91f..   lea rdi, str.On_21_February_1952__the_people_of_East_Pakistan ; 0x31b0 ; "On 21 February 1952, the people of East Pakistan" ; const char *s
|           0x00001207      e8d4feffff     call sym.imp.puts           ; int puts(const char *s)
|           0x0000120c      488d3dd51f..   lea rdi, str._now_Bangladesh__resisted_West_Pakistans_attempt ; 0x31e8 ; "(now Bangladesh) resisted West Pakistan's attempt" ; const char *s
|           0x00001213      e8c8feffff     call sym.imp.puts           ; int puts(const char *s)
|           0x00001218      488d3d0120..   lea rdi, str._now_Pakistan__to_impose_Urdu_and_deny_Bangla ; 0x3220 ; "(now Pakistan) to impose Urdu and deny Bangla" ; const char *s
|           0x0000121f      e8bcfeffff     call sym.imp.puts           ; int puts(const char *s)
|           0x00001224      488d3d7c21..   lea rdi, str.equal_recognition. ; 0x33a7 ; "equal recognition." ; const char *s
|           0x0000122b      e8b0feffff     call sym.imp.puts           ; int puts(const char *s)
|           0x00001230      488d3d1920..   lea rdi, str.Their_sacrifice_is_honored_worldwide_through ; 0x3250 ; "Their sacrifice is honored worldwide through" ; const char *s
|           0x00001237      e8a4feffff     call sym.imp.puts           ; int puts(const char *s)
|           0x0000123c      488d3d3d20..   lea rdi, str.International_Mother_Language_Day. ; 0x3280 ; "International Mother Language Day." ; const char *s
|           0x00001243      e898feffff     call sym.imp.puts           ; int puts(const char *s)
|           0x00001248      488d3d5920..   lea rdi, str.____________________________________________________________ ; 0x32a8 ; "------------------------------------------------------------" ; const char *s
|           0x0000124f      e88cfeffff     call sym.imp.puts           ; int puts(const char *s)
|           0x00001254      488d3d8d20..   lea rdi, str.Every_word_must_be_classified_before_publication. ; 0x32e8 ; "Every word must be classified before publication." ; const char *s
|           0x0000125b      e880feffff     call sym.imp.puts           ; int puts(const char *s)
|           ; XREFS: CODE 0x0000139b  CODE 0x000013ad  CODE 0x00001450  
|           ; XREFS: CODE 0x00001498  CODE 0x0000153f  CODE 0x000015f3  
|           ; XREFS: CODE 0x000016a0  CODE 0x000016b4  CODE 0x000016d1  
|           ; XREFS: CODE 0x00001798  CODE 0x00001818  CODE 0x0000188f  
|           ; XREFS: CODE 0x00001920  CODE 0x00001981  CODE 0x000019da  
|           ; XREFS: CODE 0x000019f7  
| .......-> 0x00001260      488d3d5321..   lea rdi, str._n1._Create_record ; 0x33ba ; "\n1. Create record" ; const char *s
| :::::::   0x00001267      e874feffff     call sym.imp.puts           ; int puts(const char *s)
| :::::::   0x0000126c      488d3d5921..   lea rdi, str.2._Edit_record ; 0x33cc ; "2. Edit record" ; const char *s
| :::::::   0x00001273      e868feffff     call sym.imp.puts           ; int puts(const char *s)
| :::::::   0x00001278      488d3d5c21..   lea rdi, str.3._Reclassify_record ; 0x33db ; "3. Reclassify record" ; const char *s
| :::::::   0x0000127f      e85cfeffff     call sym.imp.puts           ; int puts(const char *s)
| :::::::   0x00001284      488d3d6521..   lea rdi, str.4._Display_record ; 0x33f0 ; "4. Display record" ; const char *s
| :::::::   0x0000128b      e850feffff     call sym.imp.puts           ; int puts(const char *s)
| :::::::   0x00001290      488d3d6b21..   lea rdi, str.5._Inspect_archive_metadata ; 0x3402 ; "5. Inspect archive metadata" ; const char *s
| :::::::   0x00001297      e844feffff     call sym.imp.puts           ; int puts(const char *s)
| :::::::   0x0000129c      488d3d7b21..   lea rdi, str.6._Publish_record ; 0x341e ; "6. Publish record" ; const char *s
| :::::::   0x000012a3      e838feffff     call sym.imp.puts           ; int puts(const char *s)
| :::::::   0x000012a8      488d3d8121..   lea rdi, str.7._Delete_record ; 0x3430 ; "7. Delete record" ; const char *s
| :::::::   0x000012af      e82cfeffff     call sym.imp.puts           ; int puts(const char *s)
| :::::::   0x000012b4      488d3d8621..   lea rdi, str.8._List_records ; 0x3441 ; "8. List records" ; const char *s
| :::::::   0x000012bb      e820feffff     call sym.imp.puts           ; int puts(const char *s)
| :::::::   0x000012c0      488d3d8a21..   lea rdi, str.9._Exit        ; 0x3451 ; "9. Exit" ; const char *s
| :::::::   0x000012c7      e814feffff     call sym.imp.puts           ; int puts(const char *s)
| :::::::   0x000012cc      488d358621..   lea rsi, [0x00003459]       ; "> "
| :::::::   0x000012d3      bf01000000     mov edi, 1
| :::::::   0x000012d8      31c0           xor eax, eax
| :::::::   0x000012da      e851fdffff     call sym.imp.__printf_chk
| :::::::   0x000012df      e8cc080000     call fcn.00001bb0
| :::::::   0x000012e4      4883f809       cmp rax, 9
| ========< 0x000012e8      0f87d7030000   ja case.0x12f5.0
| :::::::   0x000012ee      49630484       movsxd rax, dword [r12 + rax*4]
| :::::::   0x000012f2      4c01e0         add rax, r12
| :::::::   ;-- switch:
| :::::::   0x000012f5      ffe0           jmp rax                     ; switch table (10 cases) at 0x3628
..
| :::::::   ;-- case 9:                                                ; from 0x000012f5
| :::::::   ; CODE XREF from main @ 0x12f5(x)
| :::::::   0x00001300      488d3def22..   lea rdi, str.Archive_terminal_closed. ; 0x35f6 ; "Archive terminal closed." ; const char *s
| :::::::   0x00001307      e8d4fdffff     call sym.imp.puts           ; int puts(const char *s)
| :::::::   0x0000130c      4883c408       add rsp, 8
| :::::::   0x00001310      31c0           xor eax, eax
| :::::::   0x00001312      5b             pop rbx
| :::::::   0x00001313      5d             pop rbp
| :::::::   0x00001314      415c           pop r12
| :::::::   0x00001316      415d           pop r13
| :::::::   0x00001318      c3             ret
..
| :::::::   ;-- case 8:                                                ; from 0x000012f5
| :::::::   ; CODE XREF from main @ 0x12f5(x)
| :::::::   0x00001320      488d1d393d..   lea rbx, [0x00005060]
| :::::::   0x00001327      31c0           xor eax, eax
| :::::::   0x00001329      31ed           xor ebp, ebp
| :::::::   0x0000132b      4c8d2d1e23..   lea r13, [0x00003650]       ; "i\xe0\xff\xffh\xdd\xff\xff\x10\xdd\xff\xff\x98\xdd\xff\xff\x88\xdd\xff\xffx\xdd\xff\xff\xb5\xe1\xff\xffj\xe1\xff\xff\xd0\xe1\xff\xff\xc7\xe1\xff\xff\xbe\xe1\xff\xff\x7f\xe2\xff\xff\\xe2\xff\xff\x18\xe2\xff\xff\xc5\xe1\xff\xff\x88\xe2\xff\xff6Record"
| :::::::   0x00001332      0f1f00         nop dword [rax]
| :::::::   0x00001335      66662e0f1f..   nop word cs:[rax + rax]
| :::::::   ; CODE XREF from main @ 0x1397(x)
| --------> 0x00001340      48833b00       cmp qword [rbx], 0
| ========< 0x00001344      7445           je 0x138b
| :::::::   0x00001346      837b0805       cmp dword [rbx + 8], 5
| ========< 0x0000134a      0f8769030000   ja case.0x135b.0
| :::::::   0x00001350      8b4308         mov eax, dword [rbx + 8]
| :::::::   0x00001353      4963448500     movsxd rax, dword [r13 + rax*4]
| :::::::   0x00001358      4c01e8         add rax, r13
| :::::::   ;-- switch:
| :::::::   0x0000135b      ffe0           jmp rax                     ; switch table (6 cases) at 0x3650
..
| :::::::   ;-- case 2:                                                ; from 0x0000135b
| :::::::   ; CODE XREF from main @ 0x135b(x)
| :::::::   0x00001360      488d0d1920..   lea rcx, str.SLOGAN         ; 0x3380 ; "SLOGAN"
| :::::::   0x00001367      660f1f8400..   nop word [rax + rax]
| :::::::   ; CODE XREFS from main @ 0x13bf(x), 0x13cf(x), 0x13df(x), 0x13ef(x), 0x16c0(x)
| --------> 0x00001370      4889ea         mov rdx, rbp
| :::::::   0x00001373      488d355d22..   lea rsi, str._zu:__s_n      ; 0x35d7 ; "%zu: %s\n"
| :::::::   0x0000137a      bf01000000     mov edi, 1
| :::::::   0x0000137f      31c0           xor eax, eax
| :::::::   0x00001381      e8aafcffff     call sym.imp.__printf_chk
| :::::::   0x00001386      b801000000     mov eax, 1
| :::::::   ; CODE XREF from main @ 0x1344(x)
| --------> 0x0000138b      4883c501       add rbp, 1
| :::::::   0x0000138f      4883c310       add rbx, 0x10
| :::::::   0x00001393      4883fd10       cmp rbp, 0x10
| ========< 0x00001397      75a7           jne 0x1340
| :::::::   0x00001399      84c0           test al, al
| ========< 0x0000139b      0f85bffeffff   jne 0x1260
| :::::::   0x000013a1      488d3d3822..   lea rdi, str.The_archive_is_empty. ; 0x35e0 ; "The archive is empty." ; const char *s
| :::::::   0x000013a8      e833fdffff     call sym.imp.puts           ; int puts(const char *s)
| ========< 0x000013ad      e9aefeffff     jmp 0x1260
..
| :::::::   ;-- case 1:                                                ; from 0x0000135b
| :::::::   ; CODE XREF from main @ 0x135b(x)
| :::::::   0x000013b8      488d0dbc1f..   lea rcx, str.POEM           ; 0x337b ; "POEM"
| ========< 0x000013bf      ebaf           jmp 0x1370
..
| :::::::   ;-- case 5:                                                ; from 0x0000135b
| :::::::   ; CODE XREF from main @ 0x135b(x)
| :::::::   0x000013c8      488d0dc91f..   lea rcx, str.IMPORTED       ; 0x3398 ; "IMPORTED"
| ========< 0x000013cf      eb9f           jmp 0x1370
..
| :::::::   ;-- case 4:                                                ; from 0x0000135b
| :::::::   ; CODE XREF from main @ 0x135b(x)
| :::::::   0x000013d8      488d0daf1f..   lea rcx, str.BROADCAST      ; 0x338e ; "BROADCAST"
| ========< 0x000013df      eb8f           jmp 0x1370
..
| :::::::   ;-- case 3:                                                ; from 0x0000135b
| :::::::   ; CODE XREF from main @ 0x135b(x)
| :::::::   0x000013e8      488d0d981f..   lea rcx, str.NOTICE         ; 0x3387 ; "NOTICE"
| ========< 0x000013ef      e97cffffff     jmp 0x1370
..
| :::::::   ;-- case 7:                                                ; from 0x000012f5
| :::::::   ; CODE XREF from main @ 0x12f5(x)
| :::::::   0x000013f8      488d35c320..   lea rsi, str.Record:        ; 0x34c2 ; "Record:"
| :::::::   0x000013ff      bf01000000     mov edi, 1
| :::::::   0x00001404      31c0           xor eax, eax
| :::::::   0x00001406      e825fcffff     call sym.imp.__printf_chk
| :::::::   0x0000140b      e8a0070000     call fcn.00001bb0
| :::::::   0x00001410      4883f80f       cmp rax, 0xf
| ========< 0x00001414      0f878e020000   ja 0x16a8
| :::::::   0x0000141a      48c1e004       shl rax, 4
| :::::::   0x0000141e      488d1d3b3c..   lea rbx, [0x00005060]
| :::::::   0x00001425      4801c3         add rbx, rax
| :::::::   0x00001428      488b3b         mov rdi, qword [rbx]
| :::::::   0x0000142b      4885ff         test rdi, rdi
| ========< 0x0000142e      0f8474020000   je 0x16a8
| :::::::   0x00001434      488b07         mov rax, qword [rdi]
| :::::::   0x00001437      ff5018         call qword [rax + 0x18]
| :::::::   0x0000143a      31c0           xor eax, eax
| :::::::   0x0000143c      31d2           xor edx, edx
| :::::::   0x0000143e      488d3d8221..   lea rdi, str.Record_removed. ; 0x35c7 ; "Record removed." ; const char *s
| :::::::   0x00001445      488903         mov qword [rbx], rax
| :::::::   0x00001448      895308         mov dword [rbx + 8], edx
| :::::::   0x0000144b      e890fcffff     call sym.imp.puts           ; int puts(const char *s)
| ========< 0x00001450      e90bfeffff     jmp 0x1260
..
| :::::::   ;-- case 6:                                                ; from 0x000012f5
| :::::::   ; CODE XREF from main @ 0x12f5(x)
| :::::::   0x00001458      488d356320..   lea rsi, str.Record:        ; 0x34c2 ; "Record:"
| :::::::   0x0000145f      bf01000000     mov edi, 1
| :::::::   0x00001464      31c0           xor eax, eax
| :::::::   0x00001466      e8c5fbffff     call sym.imp.__printf_chk
| :::::::   0x0000146b      e840070000     call fcn.00001bb0
| :::::::   0x00001470      4883f80f       cmp rax, 0xf
| ========< 0x00001474      0f872e020000   ja 0x16a8
| :::::::   0x0000147a      48c1e004       shl rax, 4
| :::::::   0x0000147e      488d15db3b..   lea rdx, [0x00005060]
| :::::::   0x00001485      488b3c02       mov rdi, qword [rdx + rax]
| :::::::   0x00001489      4885ff         test rdi, rdi
| ========< 0x0000148c      0f8416020000   je 0x16a8
| :::::::   0x00001492      488b07         mov rax, qword [rdi]
| :::::::   0x00001495      ff5008         call qword [rax + 8]
| ========< 0x00001498      e9c3fdffff     jmp 0x1260
..
| :::::::   ;-- case 5:                                                ; from 0x000012f5
| :::::::   ; CODE XREF from main @ 0x12f5(x)
| :::::::   0x000014a0      488d351b20..   lea rsi, str.Record:        ; 0x34c2 ; "Record:"
| :::::::   0x000014a7      bf01000000     mov edi, 1
| :::::::   0x000014ac      31c0           xor eax, eax
| :::::::   0x000014ae      e87dfbffff     call sym.imp.__printf_chk
| :::::::   0x000014b3      e8f8060000     call fcn.00001bb0
| :::::::   0x000014b8      4883f80f       cmp rax, 0xf
| ========< 0x000014bc      0f87e6010000   ja 0x16a8
| :::::::   0x000014c2      48c1e004       shl rax, 4
| :::::::   0x000014c6      488d15933b..   lea rdx, [0x00005060]
| :::::::   0x000014cd      4801d0         add rax, rdx
| :::::::   0x000014d0      488b28         mov rbp, qword [rax]
| :::::::   0x000014d3      4885ed         test rbp, rbp
| ========< 0x000014d6      0f84cc010000   je 0x16a8
| :::::::   0x000014dc      8b4008         mov eax, dword [rax + 8]
| :::::::   0x000014df      488b5d00       mov rbx, qword [rbp]
| :::::::   0x000014e3      83e801         sub eax, 1
| :::::::   0x000014e6      83f804         cmp eax, 4
| ========< 0x000014e9      0f87f0040000   ja case.default.0x14fd
| :::::::   0x000014ef      488d157221..   lea rdx, [0x00003668]
| :::::::   0x000014f6      48630482       movsxd rax, dword [rdx + rax*4]
| :::::::   0x000014fa      4801d0         add rax, rdx
| :::::::   ;-- switch:
| :::::::   0x000014fd      ffe0           jmp rax                     ; switch table (5 cases) at 0x3668
..
| :::::::   ;-- case 4:                                                ; from 0x000012f5
| :::::::   ; CODE XREF from main @ 0x12f5(x)
| :::::::   0x00001500      488d35bb1f..   lea rsi, str.Record:        ; 0x34c2 ; "Record:"
| :::::::   0x00001507      bf01000000     mov edi, 1
| :::::::   0x0000150c      31c0           xor eax, eax
| :::::::   0x0000150e      e81dfbffff     call sym.imp.__printf_chk
| :::::::   0x00001513      e898060000     call fcn.00001bb0
| :::::::   0x00001518      4883f80f       cmp rax, 0xf
| ========< 0x0000151c      0f8786010000   ja 0x16a8
| :::::::   0x00001522      48c1e004       shl rax, 4
| :::::::   0x00001526      488d15333b..   lea rdx, [0x00005060]
| :::::::   0x0000152d      488b3c02       mov rdi, qword [rdx + rax]
| :::::::   0x00001531      4885ff         test rdi, rdi
| ========< 0x00001534      0f846e010000   je 0x16a8
| :::::::   0x0000153a      488b07         mov rax, qword [rdi]
| :::::::   0x0000153d      ff10           call qword [rax]
| ========< 0x0000153f      e91cfdffff     jmp 0x1260
..
| :::::::   ;-- case 3:                                                ; from 0x000012f5
| :::::::   ; CODE XREF from main @ 0x12f5(x)
| :::::::   0x00001548      488d35731f..   lea rsi, str.Record:        ; 0x34c2 ; "Record:"
| :::::::   0x0000154f      bf01000000     mov edi, 1
| :::::::   0x00001554      31c0           xor eax, eax
| :::::::   0x00001556      e8d5faffff     call sym.imp.__printf_chk
| :::::::   0x0000155b      e850060000     call fcn.00001bb0
| :::::::   0x00001560      4883f80f       cmp rax, 0xf
| ========< 0x00001564      0f873e010000   ja 0x16a8
| :::::::   0x0000156a      48c1e004       shl rax, 4
| :::::::   0x0000156e      488d1deb3a..   lea rbx, [0x00005060]
| :::::::   0x00001575      4801c3         add rbx, rax
| :::::::   0x00001578      48833b00       cmp qword [rbx], 0
| ========< 0x0000157c      0f8426010000   je 0x16a8
| :::::::   0x00001582      488d3dd31e..   lea rdi, str.1._Poem        ; 0x345c ; "1. Poem" ; const char *s
| :::::::   0x00001589      e852fbffff     call sym.imp.puts           ; int puts(const char *s)
| :::::::   0x0000158e      488d3dcf1e..   lea rdi, str.2._Slogan      ; 0x3464 ; "2. Slogan" ; const char *s
| :::::::   0x00001595      e846fbffff     call sym.imp.puts           ; int puts(const char *s)
| :::::::   0x0000159a      488d3dcd1e..   lea rdi, str.3._Notice      ; 0x346e ; "3. Notice" ; const char *s
| :::::::   0x000015a1      e83afbffff     call sym.imp.puts           ; int puts(const char *s)
| :::::::   0x000015a6      488d3dcb1e..   lea rdi, str.4._Broadcast   ; 0x3478 ; "4. Broadcast" ; const char *s
| :::::::   0x000015ad      e82efbffff     call sym.imp.puts           ; int puts(const char *s)
| :::::::   0x000015b2      488d3d891f..   lea rdi, str.5._Imported_archive ; 0x3542 ; "5. Imported archive" ; const char *s
| :::::::   0x000015b9      e822fbffff     call sym.imp.puts           ; int puts(const char *s)
| :::::::   0x000015be      488d35911f..   lea rsi, str.New_classification: ; 0x3556 ; "New classification:"
| :::::::   0x000015c5      bf01000000     mov edi, 1
| :::::::   0x000015ca      31c0           xor eax, eax
| :::::::   0x000015cc      e85ffaffff     call sym.imp.__printf_chk
| :::::::   0x000015d1      e8da050000     call fcn.00001bb0
| :::::::   0x000015d6      488d50ff       lea rdx, [rax - 1]
| :::::::   0x000015da      4883fa04       cmp rdx, 4
| ========< 0x000015de      0f8791030000   ja 0x1975
| :::::::   0x000015e4      488d3d981f..   lea rdi, str.Classification_updated. ; 0x3583 ; "Classification updated." ; const char *s
| :::::::   0x000015eb      894308         mov dword [rbx + 8], eax
| :::::::   0x000015ee      e8edfaffff     call sym.imp.puts           ; int puts(const char *s)
| ========< 0x000015f3      e968fcffff     jmp 0x1260
..
| :::::::   ;-- case 2:                                                ; from 0x000012f5
| :::::::   ; CODE XREF from main @ 0x12f5(x)
| :::::::   0x00001600      488d35bb1e..   lea rsi, str.Record:        ; 0x34c2 ; "Record:"
| :::::::   0x00001607      bf01000000     mov edi, 1
| :::::::   0x0000160c      31c0           xor eax, eax
| :::::::   0x0000160e      e81dfaffff     call sym.imp.__printf_chk
| :::::::   0x00001613      e898050000     call fcn.00001bb0
| :::::::   0x00001618      4883f80f       cmp rax, 0xf
| ========< 0x0000161c      0f8786000000   ja 0x16a8
| :::::::   0x00001622      48c1e004       shl rax, 4
| :::::::   0x00001626      488d15333a..   lea rdx, [0x00005060]
| :::::::   0x0000162d      4801d0         add rax, rdx
| :::::::   0x00001630      488b18         mov rbx, qword [rax]
| :::::::   0x00001633      4885db         test rbx, rbx
| ========< 0x00001636      7470           je 0x16a8
| :::::::   0x00001638      8b4008         mov eax, dword [rax + 8]
| :::::::   0x0000163b      83e801         sub eax, 1
| :::::::   0x0000163e      83f804         cmp eax, 4
| ========< 0x00001641      0f87a4030000   ja case.default.0x1655
| :::::::   0x00001647      488d152e20..   lea rdx, [0x0000367c]
| :::::::   0x0000164e      48630482       movsxd rax, dword [rdx + rax*4]
| :::::::   0x00001652      4801d0         add rax, rdx
| :::::::   ;-- switch:
| :::::::   0x00001655      ffe0           jmp rax                     ; switch table (5 cases) at 0x367c
..
| :::::::   ;-- case 1:                                                ; from 0x000012f5
| :::::::   ; CODE XREF from main @ 0x12f5(x)
| :::::::   0x00001660      488d2df939..   lea rbp, [0x00005060]
| :::::::   0x00001667      31db           xor ebx, ebx
| :::::::   0x00001669      4889e8         mov rax, rbp
| :::::::   0x0000166c      660f1f8400..   nop word [rax + rax]
| :::::::   0x00001675      66662e0f1f..   nop word cs:[rax + rax]
| :::::::   ; CODE XREF from main @ 0x1692(x)
| --------> 0x00001680      48833800       cmp qword [rax], 0
| ========< 0x00001684      7450           je 0x16d6
| :::::::   0x00001686      4883c301       add rbx, 1
| :::::::   0x0000168a      4883c010       add rax, 0x10
| :::::::   0x0000168e      4883fb10       cmp rbx, 0x10
| ========< 0x00001692      75ec           jne 0x1680
| :::::::   0x00001694      488d3df11d..   lea rdi, str.The_archive_is_full. ; 0x348c ; "The archive is full." ; const char *s
| :::::::   0x0000169b      e840faffff     call sym.imp.puts           ; int puts(const char *s)
| ========< 0x000016a0      e9bbfbffff     jmp 0x1260
..
| :::::::   ; XREFS: CODE 0x00001414  CODE 0x0000142e  CODE 0x00001474  
| :::::::   ; XREFS: CODE 0x0000148c  CODE 0x000014bc  CODE 0x000014d6  
| :::::::   ; XREFS: CODE 0x0000151c  CODE 0x00001534  CODE 0x00001564  
| :::::::   ; XREFS: CODE 0x0000157c  CODE 0x0000161c  CODE 0x00001636  
| --------> 0x000016a8      488d3d1c1e..   lea rdi, str.Invalid_record. ; 0x34cb ; "Invalid record." ; const char *s
| :::::::   0x000016af      e82cfaffff     call sym.imp.puts           ; int puts(const char *s)
| ========< 0x000016b4      e9a7fbffff     jmp 0x1260
| :::::::   ;-- default:                                               ; from 0x135b
| :::::::   ; CODE XREFS from main @ 0x134a(x), 0x135b(x)
| --------> 0x000016b9      488d0de11c..   lea rcx, str.EMPTY          ; 0x33a1 ; "EMPTY"
| ========< 0x000016c0      e9abfcffff     jmp 0x1370
| :::::::   ;-- default:                                               ; from 0x12f5
| :::::::   ; CODE XREFS from main @ 0x12e8(x), 0x12f5(x)
| --------> 0x000016c5      488d3d431f..   lea rdi, str.Unknown_archive_command. ; 0x360f ; "Unknown archive command." ; const char *s
| :::::::   0x000016cc      e80ffaffff     call sym.imp.puts           ; int puts(const char *s)
| ========< 0x000016d1      e98afbffff     jmp 0x1260
| :::::::   ; CODE XREF from main @ 0x1684(x)
| --------> 0x000016d6      488d3d7f1d..   lea rdi, str.1._Poem        ; 0x345c ; "1. Poem" ; const char *s
| :::::::   0x000016dd      e8fef9ffff     call sym.imp.puts           ; int puts(const char *s)
| :::::::   0x000016e2      488d3d7b1d..   lea rdi, str.2._Slogan      ; 0x3464 ; "2. Slogan" ; const char *s
| :::::::   0x000016e9      e8f2f9ffff     call sym.imp.puts           ; int puts(const char *s)
| :::::::   0x000016ee      488d3d791d..   lea rdi, str.3._Notice      ; 0x346e ; "3. Notice" ; const char *s
| :::::::   0x000016f5      e8e6f9ffff     call sym.imp.puts           ; int puts(const char *s)
| :::::::   0x000016fa      488d3d771d..   lea rdi, str.4._Broadcast   ; 0x3478 ; "4. Broadcast" ; const char *s
| :::::::   0x00001701      e8daf9ffff     call sym.imp.puts           ; int puts(const char *s)
| :::::::   0x00001706      488d35781d..   lea rsi, str.Type:          ; 0x3485 ; "Type:"
| :::::::   0x0000170d      bf01000000     mov edi, 1
| :::::::   0x00001712      31c0           xor eax, eax
| :::::::   0x00001714      e817f9ffff     call sym.imp.__printf_chk
| :::::::   0x00001719      e892040000     call fcn.00001bb0
| :::::::   0x0000171e      4883f803       cmp rax, 3
| ========< 0x00001722      0f845e020000   je 0x1986
| ========< 0x00001728      0f87f7010000   ja 0x1925
| :::::::   0x0000172e      4883f801       cmp rax, 1
| ========< 0x00001732      7469           je 0x179d
| :::::::   0x00001734      4883f802       cmp rax, 2
| ========< 0x00001738      0f8590020000   jne 0x19ce
| :::::::   0x0000173e      bfa0000000     mov edi, 0xa0
| :::::::   0x00001743      e848f9ffff     call sym.imp.operator_new_unsigned_long_ ; operator new(unsigned long)
| :::::::   0x00001748      4531c9         xor r9d, r9d
| :::::::   0x0000174b      b925000000     mov ecx, 0x25               ; '%'
| :::::::   0x00001750      4889c2         mov rdx, rax
| :::::::   0x00001753      488d05de34..   lea rax, vtable.Slogan.0    ; 0x4c38 ; "p\x1f"
| :::::::   0x0000175a      488902         mov qword [rdx], rax
| :::::::   0x0000175d      488d7a08       lea rdi, [rdx + 8]
| :::::::   0x00001761      31c0           xor eax, eax
| :::::::   0x00001763      44898a9c00..   mov dword [rdx + 0x9c], r9d
| :::::::   0x0000176a      f3ab           rep stosd dword [rdi], eax
| :::::::   0x0000176c      b902000000     mov ecx, 2
| :::::::   ; CODE XREFS from main @ 0x17d0(x), 0x1970(x), 0x19c9(x)
| --------> 0x00001771      89d8           mov eax, ebx
| :::::::   0x00001773      89db           mov ebx, ebx
| :::::::   0x00001775      488d353a1d..   lea rsi, str.Record:__d_n   ; 0x34b6 ; "Record: %d\n"
| :::::::   0x0000177c      bf01000000     mov edi, 1
| :::::::   0x00001781      48c1e304       shl rbx, 4
| :::::::   0x00001785      4801dd         add rbp, rbx
| :::::::   0x00001788      48895500       mov qword [rbp], rdx
| :::::::   0x0000178c      89c2           mov edx, eax
| :::::::   0x0000178e      31c0           xor eax, eax
| :::::::   0x00001790      894d08         mov dword [rbp + 8], ecx
| :::::::   0x00001793      e898f8ffff     call sym.imp.__printf_chk
| `=======< 0x00001798      e9c3faffff     jmp 0x1260
|  ::::::   ; CODE XREF from main @ 0x1732(x)
| --------> 0x0000179d      bfa0000000     mov edi, 0xa0
|  ::::::   0x000017a2      e8e9f8ffff     call sym.imp.operator_new_unsigned_long_ ; operator new(unsigned long)
|  ::::::   0x000017a7      4531d2         xor r10d, r10d
|  ::::::   0x000017aa      b925000000     mov ecx, 0x25               ; '%'
|  ::::::   0x000017af      4889c2         mov rdx, rax
|  ::::::   0x000017b2      488d054f34..   lea rax, vtable.Poem.0      ; 0x4c08 ; "0\x1f"
|  ::::::   0x000017b9      488902         mov qword [rdx], rax
|  ::::::   0x000017bc      488d7a08       lea rdi, [rdx + 8]
|  ::::::   0x000017c0      31c0           xor eax, eax
|  ::::::   0x000017c2      4489929c00..   mov dword [rdx + 0x9c], r10d
|  ::::::   0x000017c9      f3ab           rep stosd dword [rdi], eax
|  ::::::   0x000017cb      b901000000     mov ecx, 1
| ========< 0x000017d0      eb9f           jmp 0x1771
|  ::::::   ;-- case 2:                                                ; from 0x000014fd
|  ::::::   ; CODE XREF from main @ 0x14fd(x)
|  ::::::   0x000017d2      488d15a71b..   lea rdx, str.SLOGAN         ; 0x3380 ; "SLOGAN"
|  ::::::   ; CODE XREFS from main @ 0x1824(x), 0x182d(x), 0x1836(x), 0x183f(x), 0x19e6(x)
| .-------> 0x000017d9      488d35bb1d..   lea rsi, str.classification_s_n ; 0x359b ; "classification=%s\n"
| :::::::   0x000017e0      bf01000000     mov edi, 1
| :::::::   0x000017e5      31c0           xor eax, eax
| :::::::   0x000017e7      e844f8ffff     call sym.imp.__printf_chk
| :::::::   0x000017ec      4889ea         mov rdx, rbp
| :::::::   0x000017ef      bf01000000     mov edi, 1
| :::::::   0x000017f4      31c0           xor eax, eax
| :::::::   0x000017f6      488d35b11d..   lea rsi, str.storage_p_n    ; 0x35ae ; "storage=%p\n"
| :::::::   0x000017fd      e82ef8ffff     call sym.imp.__printf_chk
| :::::::   0x00001802      4889da         mov rdx, rbx
| :::::::   0x00001805      bf01000000     mov edi, 1
| :::::::   0x0000180a      31c0           xor eax, eax
| :::::::   0x0000180c      488d35a71d..   lea rsi, str.dispatch_p_n   ; 0x35ba ; "dispatch=%p\n"
| :::::::   0x00001813      e818f8ffff     call sym.imp.__printf_chk
| :`======< 0x00001818      e943faffff     jmp 0x1260
| : :::::   ;-- case 1:                                                ; from 0x000014fd
| : :::::   ; CODE XREF from main @ 0x14fd(x)
| : :::::   0x0000181d      488d15571b..   lea rdx, str.POEM           ; 0x337b ; "POEM"
| ========< 0x00001824      ebb3           jmp 0x17d9
| : :::::   ;-- case 5:                                                ; from 0x000014fd
| : :::::   ; CODE XREF from main @ 0x14fd(x)
| : :::::   0x00001826      488d156b1b..   lea rdx, str.IMPORTED       ; 0x3398 ; "IMPORTED"
| ========< 0x0000182d      ebaa           jmp 0x17d9
| : :::::   ;-- case 4:                                                ; from 0x000014fd
| : :::::   ; CODE XREF from main @ 0x14fd(x)
| : :::::   0x0000182f      488d15581b..   lea rdx, str.BROADCAST      ; 0x338e ; "BROADCAST"
| ========< 0x00001836      eba1           jmp 0x17d9
| : :::::   ;-- case 3:                                                ; from 0x000014fd
| : :::::   ; CODE XREF from main @ 0x14fd(x)
| : :::::   0x00001838      488d15481b..   lea rdx, str.NOTICE         ; 0x3387 ; "NOTICE"
| ========< 0x0000183f      eb98           jmp 0x17d9
| : :::::   ;-- case 4:                                                ; from 0x00001655
| : :::::   ; CODE XREF from main @ 0x1655(x)
| : :::::   0x00001841      488d35b21c..   lea rsi, str.Station:       ; 0x34fa ; "Station:"
| : :::::   0x00001848      bf01000000     mov edi, 1
| : :::::   0x0000184d      31c0           xor eax, eax
| : :::::   0x0000184f      e8dcf7ffff     call sym.imp.__printf_chk
| : :::::   0x00001854      488d7b08       lea rdi, [rbx + 8]          ; int64_t arg1
| : :::::   0x00001858      be20000000     mov esi, 0x20               ; "@" ; int64_t arg2
| : :::::   0x0000185d      e89e020000     call fcn.00001b00
| : :::::   0x00001862      488d359b1c..   lea rsi, str.Message:       ; 0x3504 ; "Message:"
| : :::::   0x00001869      bf01000000     mov edi, 1
| : :::::   0x0000186e      31c0           xor eax, eax
| : :::::   0x00001870      e8bbf7ffff     call sym.imp.__printf_chk
| : :::::   0x00001875      488d7b28       lea rdi, [rbx + 0x28]       ; int64_t arg1
| : :::::   0x00001879      be78000000     mov esi, 0x78               ; 'x' ; int64_t arg2
| : :::::   0x0000187e      e87d020000     call fcn.00001b00
| : :::::   ; CODE XREFS from main @ 0x18d6(x), 0x18f9(x), 0x190e(x)
| -.------> 0x00001883      488d3da81c..   lea rdi, str.Record_updated. ; 0x3532 ; "Record updated." ; const char *s
| :::::::   0x0000188a      e851f8ffff     call sym.imp.puts           ; int puts(const char *s)
| ::`=====< 0x0000188f      e9ccf9ffff     jmp 0x1260
| :: ::::   ;-- case 3:                                                ; from 0x00001655
| :: ::::   ; CODE XREF from main @ 0x1655(x)
| :: ::::   0x00001894      488d35501c..   lea rsi, str.Title:         ; 0x34eb ; "Title:"
| :: ::::   0x0000189b      bf01000000     mov edi, 1
| :: ::::   0x000018a0      31c0           xor eax, eax
| :: ::::   0x000018a2      e889f7ffff     call sym.imp.__printf_chk
| :: ::::   0x000018a7      488d7b08       lea rdi, [rbx + 8]          ; int64_t arg1
| :: ::::   0x000018ab      be30000000     mov esi, 0x30               ; '0' ; int64_t arg2
| :: ::::   0x000018b0      e84b020000     call fcn.00001b00
| :: ::::   0x000018b5      488d35371c..   lea rsi, str.Body:          ; 0x34f3 ; "Body:"
| :: ::::   0x000018bc      bf01000000     mov edi, 1
| :: ::::   0x000018c1      31c0           xor eax, eax
| :: ::::   0x000018c3      e868f7ffff     call sym.imp.__printf_chk
| :: ::::   0x000018c8      488d7b38       lea rdi, [rbx + 0x38]       ; int64_t arg1
| :: ::::   0x000018cc      be68000000     mov esi, 0x68               ; 'h' ; int64_t arg2
| :: ::::   0x000018d1      e82a020000     call fcn.00001b00
| ========< 0x000018d6      ebab           jmp 0x1883
| :: ::::   ;-- case 2:                                                ; from 0x00001655
| :: ::::   ; CODE XREF from main @ 0x1655(x)
| :: ::::   0x000018d8      488d35031c..   lea rsi, str.Slogan:        ; 0x34e2 ; "Slogan:"
| :: ::::   ; CODE XREF from main @ 0x1902(x)
| ::.-----> 0x000018df      bf01000000     mov edi, 1
| :::::::   0x000018e4      31c0           xor eax, eax
| :::::::   0x000018e6      e845f7ffff     call sym.imp.__printf_chk
| :::::::   0x000018eb      488d7b08       lea rdi, [rbx + 8]          ; int64_t arg1
| :::::::   0x000018ef      be98000000     mov esi, 0x98               ; int64_t arg2
| :::::::   0x000018f4      e807020000     call fcn.00001b00
| ========< 0x000018f9      eb88           jmp 0x1883
| :::::::   ;-- case 1:                                                ; from 0x00001655
| :::::::   ; CODE XREF from main @ 0x1655(x)
| :::::::   0x000018fb      488d35d91b..   lea rsi, str.Poem:          ; 0x34db ; "Poem:"
| ::`=====< 0x00001902      ebdb           jmp 0x18df
| :: ::::   ;-- case 5:                                                ; from 0x00001655
| :: ::::   ; CODE XREF from main @ 0x1655(x)
| :: ::::   0x00001904      4889df         mov rdi, rbx                ; int64_t arg1
| :: ::::   0x00001907      e844030000     call fcn.00001c50
| :: ::::   0x0000190c      84c0           test al, al
| :`======< 0x0000190e      0f856fffffff   jne 0x1883
| :  ::::   0x00001914      488d3df31b..   lea rdi, str.Import_failed. ; 0x350e ; "Import failed." ; const char *s
| :  ::::   0x0000191b      e8c0f7ffff     call sym.imp.puts           ; int puts(const char *s)
| :  `====< 0x00001920      e93bf9ffff     jmp 0x1260
| :   :::   ; CODE XREF from main @ 0x1728(x)
| --------> 0x00001925      4883f804       cmp rax, 4
| :  ,====< 0x00001929      0f859f000000   jne 0x19ce
| :  |:::   0x0000192f      bfa0000000     mov edi, 0xa0
| :  |:::   0x00001934      e857f7ffff     call sym.imp.operator_new_unsigned_long_ ; operator new(unsigned long)
| :  |:::   0x00001939      31c9           xor ecx, ecx
| :  |:::   0x0000193b      31f6           xor esi, esi
| :  |:::   0x0000193d      4889c2         mov rdx, rax
| :  |:::   0x00001940      488d055133..   lea rax, vtable.Broadcast.0 ; 0x4c98
| :  |:::   0x00001947      488902         mov qword [rdx], rax
| :  |:::   0x0000194a      488d7a08       lea rdi, [rdx + 8]
| :  |:::   0x0000194e      31c0           xor eax, eax
| :  |:::   0x00001950      894a24         mov dword [rdx + 0x24], ecx
| :  |:::   0x00001953      b907000000     mov ecx, 7
| :  |:::   0x00001958      f3ab           rep stosd dword [rdi], eax
| :  |:::   0x0000195a      b91d000000     mov ecx, 0x1d
| :  |:::   0x0000195f      488d7a28       lea rdi, [rdx + 0x28]
| :  |:::   0x00001963      89b29c000000   mov dword [rdx + 0x9c], esi
| :  |:::   0x00001969      f3ab           rep stosd dword [rdi], eax
| :  |:::   0x0000196b      b904000000     mov ecx, 4
| ========< 0x00001970      e9fcfdffff     jmp 0x1771
| :  |:::   ; CODE XREF from main @ 0x15de(x)
| --------> 0x00001975      488d3def1b..   lea rdi, str.Invalid_classification. ; 0x356b ; "Invalid classification." ; const char *s
| :  |:::   0x0000197c      e85ff7ffff     call sym.imp.puts           ; int puts(const char *s)
| :  |`===< 0x00001981      e9daf8ffff     jmp 0x1260
| :  | ::   ; CODE XREF from main @ 0x1722(x)
| --------> 0x00001986      bfa0000000     mov edi, 0xa0
| :  | ::   0x0000198b      e800f7ffff     call sym.imp.operator_new_unsigned_long_ ; operator new(unsigned long)
| :  | ::   0x00001990      31ff           xor edi, edi
| :  | ::   0x00001992      b90b000000     mov ecx, 0xb
| :  | ::   0x00001997      4531c0         xor r8d, r8d
| :  | ::   0x0000199a      4889c2         mov rdx, rax
| :  | ::   0x0000199d      488d05c432..   lea rax, vtable.Notice.0    ; 0x4c68
| :  | ::   0x000019a4      488902         mov qword [rdx], rax
| :  | ::   0x000019a7      31c0           xor eax, eax
| :  | ::   0x000019a9      897a34         mov dword [rdx + 0x34], edi
| :  | ::   0x000019ac      488d7a08       lea rdi, [rdx + 8]
| :  | ::   0x000019b0      f3ab           rep stosd dword [rdi], eax
| :  | ::   0x000019b2      b919000000     mov ecx, 0x19
| :  | ::   0x000019b7      488d7a38       lea rdi, [rdx + 0x38]
| :  | ::   0x000019bb      4489829c00..   mov dword [rdx + 0x9c], r8d
| :  | ::   0x000019c2      f3ab           rep stosd dword [rdi], eax
| :  | ::   0x000019c4      b903000000     mov ecx, 3
| ========< 0x000019c9      e9a3fdffff     jmp 0x1771
| :  | ::   ; CODE XREFS from main @ 0x1738(x), 0x1929(x)
| ---`----> 0x000019ce      488d3dcc1a..   lea rdi, str.Unknown_record_type. ; 0x34a1 ; "Unknown record type." ; const char *s
| :    ::   0x000019d5      e806f7ffff     call sym.imp.puts           ; int puts(const char *s)
| :    `==< 0x000019da      e981f8ffff     jmp 0x1260
| :     :   ;-- default:                                               ; from 0x14fd
| :     :   ; CODE XREFS from main @ 0x14e9(x), 0x14fd(x)
| --------> 0x000019df      488d15bb19..   lea rdx, str.EMPTY          ; 0x33a1 ; "EMPTY"
| `=======< 0x000019e6      e9eefdffff     jmp 0x17d9
|       :   ;-- default:                                               ; from 0x1655
|       :   ; CODE XREFS from main @ 0x1641(x), 0x1655(x)
| --------> 0x000019eb      488d3d2b1b..   lea rdi, str.Invalid_record_type. ; 0x351d ; "Invalid record type." ; const char *s
|       :   0x000019f2      e8e9f6ffff     call sym.imp.puts           ; int puts(const char *s)
\       `=< 0x000019f7      e964f8ffff     jmp 0x1260
