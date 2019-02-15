@ This program showcaes a few string functions. We start by printing the lenght of
@ A string using the strlen function. Next we use strcpy to copy a string to an area
@ of memory. We then use strcat to append one string to the end of another. Finally
@ we go through 3 iterations of comparing strings (with strcmp and strcasecmp) and
@ printing the results of matching or non-matching based on the results.
@ Section in LibC Manual: 5.3, 5.4, 5.5, 5.7 (String and Array Utilities)
@ Build: as LibC_strings.s -o LibC_strings.o && gcc LibC_strings.o -o LibC_strings

.text
.global main

main:
	push {ip, lr}

@ Print the Lenght of a string
@------------------------------------------------------------------------------
	ldr	r0, =string	@ String to check the length of
	bl	strlen		@ Get the length of it
	mov	r2, r0		@ Use that value as an argument to printf
	ldr	r1, =string	@ Also use the original string as an argument to printf
	ldr	r0, =format1	@ The format string for printf
	bl	printf		@ Print the results

@ Copy the string to a 20 byte buffer in memory
@------------------------------------------------------------------------------
	ldr	r0, =string2	@ to
	ldr	r1, =string	@ from
	bl	strcpy		@ copy it

@ Append a small string to the end of our string in that 20 byte buffer
@ Then print the result
@------------------------------------------------------------------------------
	ldr	r0, =string2	@ to
	ldr	r1, =string_end	@ from
	bl	strcat		@ add string_end to the end of the string2 buffer
	bl	printf

@ Compare 'Hello world' to 'Hello world'
@------------------------------------------------------------------------------
	ldr	r0, =string
	ldr	r1, =string3
	bl	strcmp
	cmp	r0, #0
	ldreq	r0, =match1
	ldrne	r0, =nonmatch1
	bl	printf

@ Compare 'Hello world' to 'Hello land'
@------------------------------------------------------------------------------
	ldr	r0, =string
	ldr	r1, =string4
	bl	strcmp
        ldreq   r0, =match2
        ldrne   r0, =nonmatch2
        bl      printf


@ Compare 'Hello world' to 'hEllO WOrlD'  with no case sensitivity
@------------------------------------------------------------------------------
        ldr     r0, =string
        ldr     r1, =string5
        bl      strcasecmp
        ldreq   r0, =match3
        ldrne   r0, =nonmatch3
        bl      printf

done:
	pop {ip, pc}

.data
	string: .asciz "Hello world"
	string3: .asciz "Hello world"
	string4: .asciz "Hello land"
	string5: .asciz "hEllO WOrlD"
	string_end: .asciz ", bye.\n"
	format1: .asciz "'%s' is %i characters long.\n"

	match1: .asciz "'Hello world' matches 'Hello world'\n"
	nonmatch1: .asciz "'Hello world' does not match 'Hello world'\n"
	match2: .asciz "'Hello world' matches 'Hello land'\n"
	nonmatch2: .asciz "'Hello world' does not match 'Hello land'\n"
	match3: .asciz "'Hello world' matches 'hEllO WOrlD' without case sensitivity\n"
	nonmatch3: .asciz "'Hello world' does not match 'hEllO WOrlD' without case sensitivity\n"

.bss
	.lcomm string2, 20
