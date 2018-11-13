; Mostly an example of the fork API, also uses waitpid and execve for better illustration
; API calls found in this example program:
; 	fork, waitpid, execve, write, exit
; High level description of what theis example program does:
;	Forks
;	The parent waits for the child and prints a message when done
;	prints a message and then executes /bin/ps before returning to parent


section .text
global _start

_start:

; Fork
;------------------------------------------------------------------------------
	mov 	eax, 2			; fork()
    int    	0x80
	    ; Return on failure is -1
	    ; Return is 0 if child
	    ; Return is the pid of child if parent
    cmp		eax, 0			; Compare to child value
    jz		child			; Go to child process if so

parent:						; otherwise your the parent with pid of child in eax
	; Wait for child
	mov		ebx, eax		; Get that pid into ebx, we need it
	mov		eax, 7			; waitpid()
	int		0x80

	; Let STDOUT know you're the parent
	mov		eax, 4			; write()
	mov		ebx, 1			; STDOUT
	mov		ecx, parent_msg	; Message for parent
	mov		edx, 11			; Message length
	int		0x80 

	; Bail
	jmp		exit

child:
	; Let STDOUT know you're the child
	mov		eax, 4			; write()
	mov		ebx, 1			; STDOUT
	mov		ecx, child_msg	; Message for child
	mov		edx, 10			; Message length
	int		0x80

	; Execute a shell command
	mov		eax, 11			; execve()
	mov		ebx, command	; command to execute
	mov		ecx, args		; arguments (none)
	mov		edx, env		; enviornment (none)
	int 	0x80

	; Bail (but parent waiting on this)
	jmp		exit


; Exit
;------------------------------------------------------------------------------
	exit:
	mov 	eax, 1				; exit
	mov		ebx, 0				; null argument to exit
	int 	0x80

section .data
	child_msg db 'Ima Child', 0x0a
	parent_msg db 'Ima Parent', 0x0a
	command	db '/bin/ps', 0x00
	args dd command
	env db 0x00,0x00,0x00,0x00
