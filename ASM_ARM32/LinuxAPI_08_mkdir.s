@Simple example of creating a directory with the mkdir API call. API calls found in this example program:
@ 	mkdir, exit
@ High level description of what theis example program does:
@	Create a new directroy called 'newdir' using the mkdir API call
@	exits gracefully with exit().

.text
.global _start

_start:

@ Create a new directroy called 'newdir' using the mkdir API call
@------------------------------------------------------------------------------
	mov	r7, #39				@mkdir
	ldr	r0, =newdir			@pointer to the directory name
	mov	r1, #0600			@Read/Write for Owner
    	swi	#0

@ Exit
@------------------------------------------------------------------------------
	mov 	r7, #1
	swi	#0


.data
	newdir: .asciz "newdir"
