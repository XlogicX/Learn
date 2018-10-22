;Example of some time API calls. API calls found in this example program:
; 	time, gettimeofday, exit
; High level description of what theis example program does:
;	Get epoch time into memory pointer
;	Get epoch time with microseconds into same memory pointer

section .text
global _start

_start:

; Get the Epoch Time
;------------------------------------------------------------------------------
	mov 	eax, 13				;time
    mov 	ebx, timeval		;timeval
    int    	0x80

; Get the Epoch Time with microseconds
;------------------------------------------------------------------------------
	mov 	eax, 78				;gettimeofday
    mov 	ebx, timeval		;timeval
    mov		ecx, 0				;timezone, legacy argument, setting to null
    int    	0x80

; Exit
;------------------------------------------------------------------------------
	mov 	eax, 1
	int 	0x80


section .bss
timeval resb 8	;to keep track of where the heap started in the beginning
				;	The first 4 bytes is the epoch time in seconds
				;	The next 4 bytes is the remaining useconds
