section .bss
    memory    resb    1       ; Reserving a block of memory

section     .text
global      _start			;must be declared for linker (ld)

_start:						;tell linker entry point
;Showing how 32, 16, and 8 bit versions of a register works
    mov     eax, 69696969h  ;moves the 32 bits of hex data 69696969 into eax
    mov     eax, 0          ;clears eax
    mov     ax, 6969h       ;moves hex 6969 in the low 16 bits of eax, aka ax
    xor     eax, eax        ;fun way to clear a register (xor anything with itself is zero)
    mov     ah, 69h         ;moves 69 hex into upper byte of ax, aka ah
    xor     eax, eax        ;clear eax
    mov     al, 69h         ;moves 69 hex into lower byte of ax, aka al

;Showing an exchange
    xor     eax, eax        ;clear the eax
    mov     ax, 6969h       ;mov 6969 hex into ax
    mov     bx, 1337h       ;mov 1337 hex into bx    
    xchg    ax, bx          ;exchange data with ax and bx

;Pushing and Poping to/from stack
    xor     eax,eax         ;clear eax
    xor     ebx,ebx         ;clear ebx
    push    69696969h       ;push 69696969 hex onto stack
    push    13371337h       ;push 13371337 hex onto stack
    pop     rax             ;pop 13371337 off stack into eax
    pop     rbx             ;pop 69696969 off stack into ebx

;Maths
    xor     eax,eax         ;clear eax
    xor     ebx,ebx         ;clear ebx
    mov     eax, 5          ;eax now has 5
    add     eax, 3          ;eax now has 8 (5+3)
    sub     eax, 2          ;eax now has 6 (8-2)
    mov     bx, 3           ;move 3 into bx
    mul     bx              ;multiply ax * bx store back into ax (6 * 3 = 18, 12h)
    inc     eax             ;eax now has 19
    dec     eax             ;eax now has 18
    mov     dx, 0000h
    mov     ax, 2600h       ;dx:ax contains 00002600h   
    mov     bx, 2           ;bx contains 2
    div     bx              ;divide dx:ax by 2, get 1300 hex

;Logic
    xor     eax, eax        ;clear eax
    mov     al, 55h         ;01010101 goes into ah
    or      al, 0xaa        ;and with 10101010, gets ffh
    and     al, 69h         ;and all 1's with anything is itself
    not     al              ;0x69 is 01101001, flip bits gets 10010110 (0x96)
    xor     al, 99h         ;10010110 xor with 10011001 is 00001111 (0x0f)

;Memory
;We are putting "Hello World!" into memory
    mov     eax, 00000a21h      ;mov "!" and carriage return into eax
    mov     [memory], eax   ;move that into memory location 0x00600100
                                ;You should usually reserve memory with your assembler
                                ;program and refer to address as a variable, but we
                                ;are trying to rely on these features as little as 
                                ;possible for these examples
    mov     eax, 646c726fh      ;mov "dlro"
    mov     [memory-4], eax
    mov     eax, 57202c6fh      ;mov "W ,o"
    mov     [memory-8], eax
    mov     eax, 6c6c6548h      ;mov "lleH"
    mov     [memory-12], eax                         

;Shiftiness
    xor     eax, eax            ;clear eax
    mov     al, 40h             ;al has 0100 0000
    shl     al, 1               ;shift bits left = 1000 0000
    shr     al, 2               ;shift bits right by 2, 0010 0000
    rol     al, 3               ;rotate bits left by 3, 0000 0001
    ror     al, 1               ;rotate bits right by 1, 1000 0000

;Conditions and Randomness
;Note that I am not using the assembler to jump to "subroutine" names, The jumps
;are direct address based. Just note that each instruction takens a certain
;amount of bytes, so if I jump negative bytes, I am jumping a certain amount of
;instructions backwards. Likewise (forwards) for positive numbered jumps.
    rdrand  rax                 ;get random data into rax
    cmp     al, 40h             ;al - 40, set flags accordingly
    jl      -0x08               ;jump backwards to rdrand op if less
    cmp     al, 60h             ;al - 60, set flags accordingly
    jg      -0x10               ;jump backwards to rdrand op if greater
    cmp     al, 42h             ;al - 42, set flags accordingly
    je      -0x18               ;jump backwards to rdrand op if same
    jne     4                   ;otherwise, go to next op
    jmp     4                   ;unconditionally go to next op
    nop                         ;Another way to eat up 4 bytes without doing anything
    nop
    nop
    nop

;Call/Ret
    call    0x0b            ;Go down to the subroutine
;Linux Int

;exit the program    
    mov     eax,1 			;system call number (sys_exit)
    int     0x80  			;call kernel

;"Subroutine To print Hello World"
    xor     eax, eax                ;Clear eax
    mov     ecx, memory-12         ;point to start of Hello World text
    mov     edx, 14                 ;it will be 14 bytes
    mov     eax, 4                  ;"write" syscal
    int     0x80                    ;Invoke the Penguin
    ret                             ;brings us to the exit instructions
