@ At a high level, this program attempts to remove a directory that doesn't
@ exist, assuming you don't have a directory called 'noturdir'. Once this
@ (hopefully) fails, we use the 'strerror' function to get a friendly English
@ string form of the error (we provide the function the error code, a number)
@ Section in LibC Manual: 2.3 (Error Reporting Chapter)
@ Build: as LibC_error.s -o LibC_error.o && gcc LibC_error.o -o LibC_error

.text
.global main

main:
@ Attempt to remove a directory that doesn't exist (unless you have a directory
@ named 'noturdir'
@------------------------------------------------------------------------------
	push {ip, lr}
	mov	r7, #40				@rmdir
	ldr	r0, =dir			@pointer to the directory name
	swi #0

@ Use the returned error code number to get the friendly string name
@------------------------------------------------------------------------------
	neg	r0, r0		@Error return 2's compliment negative; make positive
	bl	strerror

@ Print the error string
@------------------------------------------------------------------------------
	bl	printf		@Error string pointer already in r0 (as return value), so print it
	ldr	r0, =newline	@Pointer to a newline character
	bl	printf		@print the newline (and flushes the buffer)

@ Exit gracefully
@------------------------------------------------------------------------------
        pop {ip, pc}

.data
	newline: .byte 0x0a,0x00
	dir:	.asciz "noturdir"
