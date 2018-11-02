;Example reading and setting 'nice' values with the set/getpriority API. API calls found in this example program:
; 	getpriority, setpriority, write, exit
; High level description of what theis example program does:
;	Set the priority really high
;	Do some pointless work
;	Set the priority really low
;	Do some pointless work

section .text
global _start

_start:

; Set Nice Value
;------------------------------------------------------------------------------
	mov 	eax, 97			; getpriority()
	xor		ebx, ebx		; 'which' (0=PROCESS)
	xor		ecx, ecx		; 'who' (0=calling process)
	mov		edx, -20		; Teh Lowest!
    int    	0x80

xor		eax, eax			; Init eax to 0
call 	do_work				; Do a really long pointless loop
call 	loop_done			; Indicate that we are done doing it

; Set Nice Value
;------------------------------------------------------------------------------
	mov 	eax, 97			; getpriority()
	xor		ebx, ebx		; 'which' (0=PROCESS)
	xor		ecx, ecx		; 'who' (0=calling process)
	mov		edx, 19			; Teh Lowest!
    int    	0x80

xor		eax, eax			; Init eax to 0
call 	do_work				; Do a really long pointless loop
call 	loop_done			; Indicate that we are done doing it

; Get Nice Value (to validate that it is still so low, viewable in a debugger)
;------------------------------------------------------------------------------
	mov 	eax, 96			; getpriority()
	xor		ebx, ebx		; 'which' (0=PROCESS)
	xor		ecx, ecx		; 'who' (0=calling process)
    int    	0x80

; Exit
;------------------------------------------------------------------------------
	mov 	eax, 1
	int 	0x80

; Print that we are done with a loop
;------------------------------------------------------------------------------
loop_done:
	mov		eax, 4				; write
	mov		ebx, 1				; stdout
	mov		ecx, message	 	; 'Done with Loop'
	mov		edx, 15				; how many bytes to print
	int		0x80
	ret

; Do some work
;------------------------------------------------------------------------------
do_work:
	inc		eax					; increment eax
	cmp		eax, 0xffffffff		; compare eax to a large value
	jb		do_work				; repeat if below the value
	ret

section .data
	message db 'Done with Loop', 0x0a

; WHICH values
;------------------------------------------------------------------------------
; 0 - PRIO_PROCESS
; 1 - PRIO_PGRP
; 2 - PRIO_USR
