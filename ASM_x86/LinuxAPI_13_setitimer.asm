;Example of setting interrupt timers with the setitimer API. API calls found in this example program:
; 	setitimer, signal, write, exit
; High level description of what theis example program does:
;	set up an initial signal handler for our alarm signal
;	initialize the timer values to 0
;	Set up timer with 5 second delay with setitimer
;	Go to infinite loop and wait for signals
; First handler
;	prints message
;	sets up a new handler (second handler)
;	sets a re-occuring timer for every 2 seconds
;	returns to infinite loop
; Second handler
;	writes a new message
;	refreshes the signal handler for itself for persistence

section .text
global _start

_start:

; Set up signal handler to intercept SIGINT (CTRL+C)
;------------------------------------------------------------------------------
	mov 	eax, 48			; signal
    mov 	ebx, 14			; SIGALRM
    mov		ecx, handle_it	; Address to signal handler when catching sigint
    int    	0x80


; Setup timing values
;------------------------------------------------------------------------------
mov word [timeval_interval_s], 0
mov word [timeval_interval_su], 0
mov word [timeval_stop_s], 0
mov word [timeval_stop_su], 0

; Set Timer
;------------------------------------------------------------------------------
	mov		word [timeval_stop_s], 5	;Set one-time delay of 5 seconds
	mov		eax, 104					; setitimer
	mov		ebx, 0						; type 0, REAL
	mov		ecx, timeval_interval_s		; stop interval
	mov		edx, 0
	int		0x80

; Infinit Loop
;------------------------------------------------------------------------------
iloop:
	jmp iloop

; Handler for Interupt Signal
;------------------------------------------------------------------------------
handle_it:
	mov		eax, 4				; write
	mov		ebx, 1				; stdout
	mov		ecx, message
	mov		edx, 5				; how many bytes to print
	int		0x80
	; Set up signal handler to intercept SIGINT (CTRL+C)
	;------------------------------------------------------------------------------
		mov 	eax, 48				; signal
		mov 	ebx, 14				; SIGALRM
	    mov		ecx, annoying_you	; Address to signal handler when catching sigint
	    int    	0x80	
	; Set New Timer (interval of every 2 seconds)
	;------------------------------------------------------------------------------
		mov word [timeval_stop_s], 2
		mov word [timeval_interval_s], 2		
		mov		eax, 104			; setitimer
		mov		ebx, 0				; type 0, REAL
		mov		ecx, timeval_interval_s	; stop interval
		int		0x80
	ret								; but for now, go back to our infinite loop

; Handler for Interupt Signal
;------------------------------------------------------------------------------
annoying_you:
	mov		eax, 4				; write
	mov		ebx, 1				; stdout
	mov		ecx, message2
	mov		edx, 14				; how many bytes to print
	int		0x80
	; Persist signal handler to intercept SIGINT (CTRL+C)
	;------------------------------------------------------------------------------
		mov 	eax, 48				; signal
		mov 	ebx, 14				; SIGALRM
	    mov		ecx, annoying_you	; Address to signal handler when catching sigint
	    int    	0x80		
	ret								; but for now, go back to our infinite loop

section .data
	message db 'Ohai', 0x0a
	message2 db 'Annoying You!', 0x0a

section .bss
	timeval_interval_s resb 4
	timeval_interval_su resb 4
	timeval_stop_s resb 4
	timeval_stop_su resb 4

; itimerval structure - Each value can be null
;------------------------------------------------------------------------------
; timeval interval		- if null, interupt once based on timeval current time
; timeval current time	- if null, interupt at interval specified by the interval

; timeval structure
;------------------------------------------------------------------------------
; sec
; usec