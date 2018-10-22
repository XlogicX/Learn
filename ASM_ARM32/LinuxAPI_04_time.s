@Example of some time API calls. API calls found in this example program:
@ 	time, gettimeofday, exit
@ High level description of what theis example program does:
@	Get epoch time into memory pointer
@	Get epoch time with microseconds into same memory pointer

.text
.global _start

_start:

@ Get the Epoch Time, this call fails: ENOSYS 38 Function not implemented
@------------------------------------------------------------------------------
	mov 	r7, #13		@time
	ldr	r0, =timeval	@timeval
    	swi	#0

@ Get the Epoch Time with microseconds (this works fine on ARM, better API anyway)
@------------------------------------------------------------------------------
	mov 	r7, #78		@gettimeofday
	ldr	r0, =timeval	@timeval
    	mov	r1, #0		@timezone, legacy argument, setting to null
    	swi	#0

@ Exit
@------------------------------------------------------------------------------
	mov 	r7, #1
	swi	#0


.bss
	.lcomm timeval, 8	@to keep track of where the heap started in the beginning
					@ The first 4 bytes is the epoch time in seconds
					@ The next 4 bytes is the remaining useconds
