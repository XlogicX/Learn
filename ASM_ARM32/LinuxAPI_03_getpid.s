
@Example of the getpid API call. API calls found in this example program:
@ 	getpid, getppid, exit
@ High level description of what theis example program does:
@	Uses the getpid API call to get it's current process ID.
@	Stores this process ID number in memory (using pointer 'pid').
@	Exits gracefully with exit().

.text
.global _start

_start:

@ Get Process ID
@------------------------------------------------------------------------------
	mov	r7, #20		@get Process ID of self, getpid()
	swi	#0
	ldr	r1, =pid	@Store it in a memory location
	str	r0, [r1]	@...

@ Get Parent Process ID
@------------------------------------------------------------------------------
	mov	r7, #64		@get the Parent Process ID of self getppid()
	swi	#0
	ldr	r1, =ppid	@Store it in a memory locatio
	str	r0, [r1]	@...

@ Exit program
@------------------------------------------------------------------------------
	mov	r7, #1
	swi	#0

.bss
	.lcomm pid, 4
	.lcomm ppid, 4
