;Simple example of creating a directory with the mkdir API call. API calls found in this example program:
; 	mkdir, exit
; High level description of what theis example program does:
;	Create a new directroy called 'newdir' using the mkdir API call
;	exits gracefully with exit().

section .text
global _start

_start:

; Create a new directroy called 'newdir' using the mkdir API call
;------------------------------------------------------------------------------
	mov		eax, 39				;mkdir
	mov		ebx, newdir			;pointer to the directory name
	mov		ecx, 700o			;Read/Write/Execute for Owner
	int		0x80


; Exit program
;------------------------------------------------------------------------------
	mov		eax, 1
	mov		ebx, 0				; null argument to exit
	int		0x80

section .data
	newdir db 'newdir', 0x00

; ------------------------------
; | Some bitfield explanations |
; ------------------------------

; Mode Octal codes
;------------------------------------------------------------------------------
;	Read	4
;	Write	2
;	Execute	1
