@ Using lfind. This one can be a little bit complicated to use in assembly, as it is so flexible.
@ lfind can compare a 'thing' with things in an array. This 'thing' can be a number, a string, ect.
@ lfind realistically handles the overhead of looping and iterating the offset size of elements in
@ the array, the actually matching algorithm is really written by you. Though the below example uses
@ fixed sized (non null terminated) strings, I could just as easily used null terminated strings and
@ used strcmp instead of strncmp. But that doesn't change the requirement for having the elements being
@ of a fixed size, as lfind needs to know this size as it is what is used to iterate through each
@ element of the array
@ Section in LibC Manual: 5.7 and 9.2 (String and Array Utilities and Searching and Sorting Chapters)
@ Build: as LibC_lfind.s -o LibC_lfind.o && gcc LibC_lfind.o -o LibC_lfind


.text
.global main

main:
	push 	{ip, lr}

@ Use lfind ('for', array, 5 elements, 3 bytes per element, comparefunc)
@ ^^ Psuedocode
@------------------------------------------------------------------------------
	ldr	r0, =word		@ pointer to the thing to search for
	ldr	r1, =array		@ pointer to the array that has the things
	ldr	r2, =size		@ how many elements are in the array (tells lfind how many times to iterate)
	mov	r3, #3			@ how large is an element in the array (fixed size elements)
	ldr	r4, =comparefunc	@ pointer to comparison function (you have to roll your own)
	push	{r4}			@ and the pointer needs to be first on the stack
	bl	lfind			@ Run the lfind function
		@ If there's not a match, r0, will contain null. Otherwise, r0 will have the address (pointer)
		@ to the element in the array that matched
@ See if it was a match or not, print result
@------------------------------------------------------------------------------
	cmp	r0, #0
	ldrne	r0, =format1
	ldreq	r0, =format2
	bl	printf
	bl	exit

comparefunc:
@ A String compare function that uses a fixed size (3) of bytes in the comparison
@------------------------------------------------------------------------------
	@ Pointers to the things to compare are in r0, and r1 already
	push	{lr}		@ Know where we came from
	mov	r2, #3		@ We are doing strings of 3 characters
	bl	strncmp		@ Compare the strings with strncmp
	pop	{lr}		@ Remember where we came from
	bx	lr		@ Return there

exit:
	add	sp, #4		@ Correct Stack (due to the push before the lfind
	pop 	{ip, pc}

.data
	array: .ascii "and","xor","for","mov","are"
	word: .ascii "for"
	size: .word 5
	format1: .asciz "A Match was found\n"
	format2: .asciz "A Match was not found\n"
