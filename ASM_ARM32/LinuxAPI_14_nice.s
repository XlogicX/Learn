@Example reading and setting 'nice' values with the set/getpriority API. API calls found in this example program:
@ 	getpriority, setpriority, write, exit
@ High level description of what theis example program does:
@	Set the priority really high
@	Do some pointless work
@	Set the priority really low
@	Do some pointless work

.text
.global _start

_start:

@ Set Nice Value
@------------------------------------------------------------------------------
	mov	r7, #97		@ setpriority()
	mov	r0, #0		@ 'which' (0=PROCESS)
	mov	r1, #0		@ 'who' (0=calling process)
	mov	r2, #-20	@ Bigly
	swi	#0

mov	r0, #0			@ Init r0 to 0
mov	r1, #15
lsl	r1, #28			@ large value to compare to
bl	do_work			@ Do a really long pointless loop
bl	loop_done		@ Indicate that we are done doing it

@ Set Nice Value
@------------------------------------------------------------------------------
        mov     r7, #97         @ setpriority()
        mov     r0, #0          @ 'which' (0=PROCESS)
        mov     r1, #0          @ 'who' (0=calling process)
        mov     r2, #19        	@ Teh Lowest!
        swi     #0

mov     r0, #0                  @ Init r0 to 0
mov     r1, #15
lsl     r1, #28                 @ large value to compare to
bl      do_work                 @ Do a really long pointless loop
bl      loop_done               @ Indicate that we are done doing it


@ Get Nice Value (to validate that it is still so low, viewable in a debugger)
@------------------------------------------------------------------------------
        mov     r7, #96         @ setpriority()
        mov     r0, #0          @ 'which' (0=PROCESS)
        mov     r1, #0          @ 'who' (0=calling process)
        swi     #0

@ Exit
@------------------------------------------------------------------------------
	mov	r7, #1
    	swi 	#0

@ Print that we are done with a loop
@------------------------------------------------------------------------------
loop_done:
	push	{lr}
	mov	r7, #4			@ write
	mov	r0, #1			@ stdout
	ldr	r1, =message 		@ 'Done with Loop'
	mov	r2, #15			@ how many bytes to print
	swi	#0
	pop	{lr}
	bx	lr

@ Do some work
@------------------------------------------------------------------------------
do_work:
	push 	{lr}
working:
	add	r0, #1			@ increment r0
	cmp	r0, r1			@ compare eax to the large vaue
	bgt	working			@ repeat if below the value
	pop	{lr}
	bx	lr

.data
	message: .asciz "Done with Loop\x0a"

@ WHICH values
@------------------------------------------------------------------------------
@ 0 - PRIO_PROCESS
@ 1 - PRIO_PGRP
@ 2 - PRIO_USR
