@Example of intercepting a signal with our own handler using the signal API. API calls found in this example program:
@ 	signal, write, exit
@ High level description of what theis example program does:
@	Set up a signal handler to 'handle_it' using signal API
@	Proceed into infinite Loop
@	In 'handle_it' tell user that 'ctrl+C'd to fuck off, 
@		then set up new signal handler to exit if ctrl+C is used
@		return to infinite Loop
@	If Ctrl+C is pressed again, program prints a message indicating defeat and exits

.text
.global _start

_start:

@ Set up signal handler to intercept SIGINT (CTRL+C)
@------------------------------------------------------------------------------
	ldr	r0, =handle_struct
	ldr	r1, =handle_it
	str	r1, [r0]
	mov 	r7, #67			@ signal
    	mov 	r0, #2			@ SIGINT
    	ldr	r1, =handle_struct	@ Address to signal handler when catching sigint
    	swi	#0

@ Infinit Loop
@------------------------------------------------------------------------------
iloop:
	b iloop

@ Handler for Interupt Signal
@------------------------------------------------------------------------------
handle_it:
	mov	r7, #4			@ write
	mov	r0, #1			@ stdout
	ldr	r1, =message 		@ '^C <- Nah, Fuck you!'
	mov	r2, #19			@ how many bytes to print
	swi	#0

        ldr     r0, =handle_struct
        ldr     r1, =exit
        str     r1, [r0]
	mov 	r7, #67			@ new signal
   	mov 	r0, #2			@ SIGINT
   	ldr	r1, =handle_struct	@ Exit this time
   	swi	#0
	bx	lr			@ but for now, go back to our infinite loop

@ Exit
@------------------------------------------------------------------------------
exit:
	mov		r7, #4				@ write
	mov		r0, #1				@ stdout
	ldr		r1, =message2 		@ '^C Fine...'
	mov		r2, #9				@ how many bytes to print
	swi		#0
	mov		r7, #1
    swi 	#0

.data
	message: .asciz " <- Nah, Fuck you!\x0a"
	message2: .asciz " Fine...\x0a"

.bss
	.lcomm handle_struct, 4

@ All the standard signal codez
@------------------------------------------------------------------------------
@ 1		- SIGHUP	- Hangup
@ 2		- SIGINT	- Terminal interrupt
@ 3		- SIGQUIT	- Terminal quit
@ 4		- SIGILL	- Illegal instruction
@ 5		- SIGTRAP	- Trace/breakpoint trap
@ 6 	- SIGABRT 	- Abort process
@ 7		- SIGBUS	- Memory access error
@ 8		- SIGFPE	- Arithmetic exception
@ 9		- SIGKILL	- Sure Kill
@ 10	- SIGUSR1	- User-defined signal 1
@ 11	- SIGSEGV	- Invalid memory reference
@ 12	- SIGUSR2	- User-defined signal 2
@ 13	- SIGPIP	- Broken pipe
@ 14 	- SIGALRM 	- Real-time timer expired
@ 15	- SIGTERM	- Terminate process
@ 16	- SIGSTKFLT - Stack fault on coprocessor
@ 17	- SIGCHLD	- Child terminated or stopped
@ 18	- SIGCONT	- Continue if stopped
@ 19	- SIGSTOP	- Sure stop
@ 20	- SIGTSTP	- Terminal stop
@ 21	- SIGTTIN	- Terminal read from BG
@ 22	- SIGTTOU	- Terminal write from BG
@ 23	- SIGURG	- Urgent data on socket
@ 24	- SIGXCPU	- CPU time limit exceeded
@ 25	- SIGXFSZ	- File size limit exceeded
@ 26	- SIGVTALRM	- Virtual timer expired
@ 27	- SIGPROF	- Profiling timer expired
@ 28	- SIGWINCH	- Terminal window size change
@ 29	- SIGIO/POLL- I/O possible
@ 30	- SIGPWR	- Power about to fail
@ 31	- SIGSYS	- Invalid system call
