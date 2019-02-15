@ This program showcases copying memory and comparing strings. First the program
@ copies the first 8 bytes of a string and prints the copied part to stdout. Next,
@ the program compares the first 5 bytes of two strings that happen to match on
@ just that first part, a printf conditionally acknowledges this truth. Next we
@ do the same thing but with the first 8 bytes, of which do not match. We also
@ attempt to do a conditional print based on the matching of the strings; the
@ print doesn't occur in this case, becuase they don't match
@ Section in LibC Manual: 5.4 and 5.7 (String and Array Utilities Chapter)
@ Build: as LibC_mem.s -o LibC_mem.o && gcc LibC_mem.o -o LibC_mem

.text
.global main

main:
	push {ip, lr}

@ Copy 8 bytes of memory from 'string' pointer to a 16 byte memory area labeled 'mem'
@------------------------------------------------------------------------------
	ldr	r0, =mem	@ to
	ldr	r1, =string	@ from
	mov	r2, #8		@ How many bytes to copy
	bl	memcpy		@ Returns how many bytes into 'string' copied
	ldr	r0, =mem	@ Get a pointer to that 8 bytes of the substring
	bl	printf		@ Print it
	ldr	r0, =newline
	bl	printf		@ Make sure to print a newline too

@ Compare first 5 bytes of "Hello World\n" to "Hello Land\n". Print a message
@ Stating that they match (if they do indeed match). [the print statement occurs]
@------------------------------------------------------------------------------
	ldr	r0, =string
	ldr	r1, =string2
	mov	r2, #5
	bl	memcmp		@ Returns 0, indicating equal
	ldreq	r0, =format
	bleq	printf

@ Compare first 8 bytes of "Hello World\n" to "Hello Land\n". Print a message
@ Stating that they match (if they do indeed match). [the print statement does not occur]
@------------------------------------------------------------------------------
	ldr	r0, =string
	ldr	r1, =string2
	mov	r2, #8
	bl	memcmp		@ Returns 1 meaning ('Wo' greater than 'La')
				@ If swapped before cmp, it would return
				@ 0xfff...(-1), meaning less than
	ldreq	r0, =format2
	bleq	printf

done:
	pop {ip, pc}

.data
	newline: .asciz "\n"
	string: .asciz "Hello World\n"
	string2: .asciz "Hello Land\n"
	format: .asciz "First 5 bytes of 'Hello World' and 'Hello Land' match\n"
	format2: .asciz "First 8 bytes of 'Hello World' and 'Hello Land' match\n"

.bss
	.lcomm mem, 16
