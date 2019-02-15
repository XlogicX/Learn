@ This program may seem long, but it's very straight forward.
@ This program demonstrates character classification functions; determines whether
@ A character falls into a classification (uppercase? punctuation? number? etc...)
@ The structure of this program loads a character as an argument, and checks to see
@ If it matches the classification. If so, printf is used to state that there is
@ a match. There's a printf string prepared for all of them, even though only a
@ handful of them will print (the true ones)
@ Section in LibC Manual: 4.1 (Character Handling Chapter)
@ Build: as LibC_chars.s -o LibC_chars.o && gcc LibC_chars.o -o LibC_chars

.text
.global main

main:
	push {ip, lr}

@ Is ? an Alpha character
@------------------------------------------------------------------------------
	mov	r0, #'?'
	bl	isalpha		@ return of 0 means no
	cmp	r0, #0
	ldrne	r0, =F_isalpha
	blne	printf

@ Is ? a digit character
@------------------------------------------------------------------------------
	mov	r0, #'?'
	bl	isdigit		@ returns 0
        cmp     r0, #0
        ldrne   r0, =F_isdigit
        blne    printf

@ Is ? an alpha-numeric character
@------------------------------------------------------------------------------
	mov	r0, #'?'
	bl	isalnum		@ returns 0
        cmp     r0, #0
        ldrne   r0, =F_isalnum
        blne    printf

@ Is ? a punctuation character
@------------------------------------------------------------------------------
	mov	r0, #'?'
	bl	ispunct		@ returns 4 (is punctuation)
        cmp     r0, #0
        ldrne   r0, =F_ispunct
        blne    printf

@ Is ? a whitespace character
@------------------------------------------------------------------------------
	mov	r0, #'?'
	bl	isspace		@ returns 0
        cmp     r0, #0
        ldrne   r0, =F_isspace
        blne    printf

@ Is ? a blank character
@------------------------------------------------------------------------------
	mov	r0, #'?'
	bl	isblank		@ returns 0
        cmp     r0, #0
        ldrne   r0, =F_isblank
        blne    printf

@ Is ? a 'graphical' character
@------------------------------------------------------------------------------
	mov	r0, #'?'
	bl	isgraph		@ returns 0x8000
        cmp     r0, #0
        ldrne   r0, =F_isgraph
        blne    printf

@ Is ? a printable character
@------------------------------------------------------------------------------
	mov	r0, #'?'
	bl	isprint		@ returns 0x4000
        cmp     r0, #0
        ldrne   r0, =F_isprint
        blne    printf

@ Is ? a control character
@------------------------------------------------------------------------------
	mov	r0, #'?'
	bl	iscntrl		@ returns 0
        cmp     r0, #0
        ldrne   r0, =F_iscntrl
        blne    printf

@ Is ? an ASCII character
@------------------------------------------------------------------------------
	mov	r0, #'?'
	bl	isascii		@ returns 1
        cmp     r0, #0
        ldrne   r0, =F_isascii
        blne    printf

@ Is 'A' a lowercase character
@------------------------------------------------------------------------------
        mov     r0, #'A'
        bl      islower		@ retruns 0
        cmp     r0, #0
        ldrne   r0, =F_islower
        blne    printf

@ Convert 'A' to lowercase and print it
@------------------------------------------------------------------------------
	mov	r0, #'A'
	bl	tolower		@ returns 0x61 ('a')
	mov	r1, r0
	ldr	r0, =F_tolower
	bl	printf

@ Convert 'a' to uppercase and print it
@------------------------------------------------------------------------------
	mov	r0, #'a'
	bl	toupper		@ retruns 0x41 ('A')
	mov	r1, r0
	ldr	r0, =F_toupper
	bl	printf

@ Is 'A' an uppercase character
@------------------------------------------------------------------------------
	mov	r0, #'A'
	bl	isupper		@ returns 0x100
        cmp     r0, #0
        ldrne   r0, =F_isupper
        blne    printf

	b	exit

exit:
	pop {ip, pc}

.data
	F_isalpha: .asciz "? is alpha\n"
	F_isdigit: .asciz "? is digit\n"
	F_isalnum: .asciz "? is alnum\n"
	F_ispunct: .asciz "? is punct\n"
	F_isspace: .asciz "? is space\n"
	F_isblank: .asciz "? is blank\n"
	F_isgraph: .asciz "? is graph\n"
	F_isprint: .asciz "? is print\n"
	F_iscntrl: .asciz "? is cntr\n"
	F_isascii: .asciz "? is ascii\n"
	F_islower: .asciz "A is lower\n"
	F_tolower: .asciz "'A' is now %c\n"
	F_toupper: .asciz "It is now %c\n"
	F_isupper: .asciz "'A' is upper\n"
