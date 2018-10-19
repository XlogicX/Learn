;Example of allocating heap memory with the brk API call. API calls found in this example program:
; 	brk, exit
; High level description of what theis example program does:
;	Find the current end of heap with brk
;	Add 1MB of memory to the heap
;	Write some data around the end of the heap

section .text
global _start

_start:

; Locate Current Heap End
;------------------------------------------------------------------------------
	mov		eax, 78				;brk
    mov		ebx, 0				;This will cause an error
    int		0x80				;which will return current heap end value
    mov		[brk_start], eax	;store that value in brk_start

; Allocate about a megabyte of heap memory
;------------------------------------------------------------------------------
    mov		eax, 45				;brk
    mov		ebx, [brk_start]	;get current heap end address
    add		ebx, 0x100000		;and add a megabyte to it
    int		0x80
    mov		[brk_end], eax		;keep new address for safe keeping

; Write some data around the end of the heep.
;------------------------------------------------------------------------------
	mov		eax, [brk_end]		;get the heaps last address boundry
	sub		eax, 16				;go backwards 16 bytes
	mov		[eax], eax			;write some data into that location
	;Without doing the heap managment calls with brk, the above instruction
	;would have an illegal access fault.

; Exit
;------------------------------------------------------------------------------
	mov		eax, 1
	int		0x80


section .bss
	brk_start resb 4	;to keep track of where the heap started in the beginning
	brk_end resb 4	;to keep track of the current end of heap location