;Example of the getpid API call. API calls found in this example program:
; 	getpid, getppid, exit
; High level description of what theis example program does:
;	Uses the getpid API call to get it's current process ID.
;	Stores this process ID number in memory (using pointer 'pid').
;	Exits gracefully with exit().

section .text
global _start

_start:

; Get Process ID
;------------------------------------------------------------------------------
	mov		eax, 20		;get Process ID of self, getpid()
	int		0x80
	mov		[pid], eax	;store the pid in memory

; Get Parent Process ID
;------------------------------------------------------------------------------
	mov		eax, 64		;get the Parent Process ID of self getppid()
	int		0x80
	mov		[ppid], eax

; Exit program
;------------------------------------------------------------------------------
	mov		eax, 1
	int		0x80

section .bss
	pid resb 4
	ppid resb 4