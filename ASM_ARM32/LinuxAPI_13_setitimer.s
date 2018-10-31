@Example of setting interrupt timers with the setitimer API. API calls found in this example program:
@ 	setitimer, signal, write, exit
@ High level description of what theis example program does:
@	set up an initial signal handler for our alarm signal
@	initialize the timer values to 0
@	Set up timer with 5 second delay with setitimer
@	Go to infinite loop and wait for signals
@ First handler
@	prints message
@	sets up a new handler (second handler)
@	sets a re-occuring timer for every 2 seconds
@	returns to infinite loop
@ Second handler
@	writes a new message
@	refreshes the signal handler for itself for persistence

.text
.global _start

_start:

@ Set up signal handler to intercept SIGINT (CTRL+C)
@------------------------------------------------------------------------------

	ldr	r0, =handle_struct
	ldr	r1, =handle_it
	str	r1, [r0]
	mov 	r7, #67			@ sigaction
    	mov 	r0, #14			@ SIGINT
    	ldr	r1, =handle_struct	@ Address to signal handler when catching sigint
    	swi	#0

@ Setup timing values (init all to zero/null)
@------------------------------------------------------------------------------
	mov	r1, #0
	ldr	r0, =timeval_interval_s
	str	r1, [r0]
	ldr	r0, =timeval_interval_su
	str	r1, [r0]
	ldr	r0, =timeval_stop_s
	str	r1, [r0]
	ldr	r0, =timeval_stop_su
	str	r1, [r0]

@ Set Timer
@------------------------------------------------------------------------------
	mov	r1, #5				@ Set one-time dealy of 5 seconds
	ldr	r0, =timeval_stop_s
	str	r1, [r0]
	mov	r7, #104			@ setitimer
	mov	r0, #0				@ type 0, REAL
	ldr	r1, =timeval_interval_s		@ stop interval
	mov	r2, #0
	swi	#0

@ Infinite Loop
@------------------------------------------------------------------------------
iloop:
	b iloop

@ Handler for Interupt Signal
@------------------------------------------------------------------------------
handle_it:
	push	{lr}
	mov	r7, #4		@ write
	mov	r0, #1		@ stdout
	ldr	r1, =message
	mov	r2, #5		@ how many bytes to print
	swi	#0
	@ Set up signal handler to intercept SIGINT (CTRL+C)
	@------------------------------------------------------------------------------
        	ldr     r0, =handle_struct
        	ldr     r1, =annoying_you
        	str     r1, [r0]
        	mov     r7, #67                 @ sigaction
        	mov     r0, #14                 @ SIGINT
        	ldr     r1, =handle_struct      @ Address to signal handler when catching sigint
        	swi     #0
	@ Set New Timer (interval of every 2 seconds)
	@------------------------------------------------------------------------------
		mov	r0, #2
		ldr	r1, =timeval_stop_s
		str	r0, [r1]
		ldr	r1, =timeval_interval_s
		str	r0, [r1]
		mov	r7, #104			@ setitimer
		mov	r0, #0				@ type 0, REAL
		ldr	r1, =timeval_interval_s		@ stop interval
		swi	#0
	pop	{lr}
	bx	lr



@ Handler for Interupt Signal
@------------------------------------------------------------------------------
annoying_you:
        push    {lr}
        mov     r7, #4          @ write
        mov     r0, #1          @ stdout
        ldr     r1, =message2
        mov     r2, #14          @ how many bytes to print
        swi     #0
	@ Persist signal handler to intercept SIGINT (CTRL+C)
	@------------------------------------------------------------------------------
                ldr     r0, =handle_struct
                ldr     r1, =annoying_you
                str     r1, [r0]
                mov     r7, #67                 @ sigaction
                mov     r0, #14                 @ SIGINT
                ldr     r1, =handle_struct      @ Address to signal handler when catching sigint
                swi     #0
	pop	{lr}
	bx	lr				@ but for now, go back to our infinite loop

.data
	message: .asciz "Ohai\x0a"
	message2: .asciz "Annoying You!\x0a"

.bss
	.lcomm timeval_interval_s, 4
	.lcomm timeval_interval_su, 4
	.lcomm timeval_stop_s, 4
	.lcomm timeval_stop_su, 4
	.lcomm handle_struct, 4

@ itimerval structure - Each value can be null
@------------------------------------------------------------------------------
@ timeval interval		- if null, interupt once based on timeval current time
@ timeval current time	- if null, interupt at interval specified by the interval

@ timeval structure
@------------------------------------------------------------------------------
@ sec
@ usec
