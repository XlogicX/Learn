;Example of using the uname API. API calls found in this example program:
; 	uname, exit
; High level description of what theis example program does:
;	Simply calls uname and stores the result in memory pointer

section .text
global _start

_start:

; Get uname data
;------------------------------------------------------------------------------
	mov 	eax, 109		; uname
    mov 	ebx, sysname	; Pointer to where you want the data
    int    	0x80

; Exit
;------------------------------------------------------------------------------
	mov 	eax, 1
	int 	0x80


section .bss
	sysname resb 65		; Probably 'Linux'
	nodename resb 65	; Hostname in my case
	release resb 65		; Kernel version
	version resb 65		; Version details
	machine resb 65		; Architecture