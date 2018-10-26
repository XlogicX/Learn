@Simple example of removing a directory with the rmdir API call. API calls found in this example program:
@ 	rmdir, exit
@ High level description of what theis example program does:
@	Attempts ot remove the directory 'newdir' if it exists, using the rmdir API
@	exits gracefully with exit().

.text
.global _start

_start:

@ Create a new directroy called 'newdir' using the mkdir API call
@------------------------------------------------------------------------------
	mov	r7, #40				@mkdir
	ldr	r0, =newdir			@pointer to the directory name
    	swi	#0

@ Exit
@------------------------------------------------------------------------------
	mov 	r7, #1
	swi	#0


.data
	newdir: .asciz "newdir"
