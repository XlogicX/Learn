;Simple example of removing a directory with the rmdir API call. API calls found in this example program:
; 	rmdir, exit
; High level description of what theis example program does:
;	Attempts ot remove the directory 'newdir' if it exists, using the rmdir API
;	exits gracefully with exit().

section .text
global _start

_start:

; Attempts ot remove the directory 'newdir' if it exists, using the rmdir API
;------------------------------------------------------------------------------
	mov		eax, 40				;rmdir
	mov		ebx, newdir			;pointer to the directory name
	int		0x80


; Exit program
;------------------------------------------------------------------------------
	mov		eax, 1
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