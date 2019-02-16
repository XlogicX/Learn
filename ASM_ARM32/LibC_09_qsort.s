@ Qsort (quick sort) will sort all of the items in an array, you must provide the comparison function,
@ However. This program sorts the array provided in the .data section. The results of the sorted array
@ are stored back into the same area of memory (the original array is overwritten with the sorted one).
@ Section in LibC Manual: 9.3 (Searching and Sorting Chapter)
@ Build: as LibC_qsort.s -o LibC_qsort.o && gcc LibC_qsort.o -o LibC_qsort

.text
.global main

main:
	push 	{ip, lr}

@ Sort array with six elements where each element is 1 byte and the comparison
@ function is 'comparefunc'
@------------------------------------------------------------------------------
	ldr	r0, =array		@ pointer to the array to sort
	mov	r1, #6			@ There are six elements in the array
	mov	r2, #1			@ Each element is one byte
	ldr	r3, =comparefunc	@ Pointer to the function that compares 2 elements
	bl	qsort			@ Run the quick sort

@ Print All of the sorted elements. Loading the arguments is straightforward for
@ The first few, but once the remaining 3 arguments need to be loaded on the
@ stack, they are being pushed in reverse order, because FIFO
@------------------------------------------------------------------------------
	ldr	r0, =format
	ldr	r5, =array
	ldrb	r1, [r5]	@ Element 1
	add	r5, #1
	ldrb	r2, [r5]	@ Element 2
	add	r5, #1
	ldrb	r3, [r5]	@ Element 3
	add	r5, #3
	ldrb	r4, [r5]	@ Element 4
	push	{r4}
	sub	r5, #1
	ldrb	r4, [r5]
	push	{r4}		@ Element 5
	sub     r5, #1
        ldrb    r4, [r5]
        push    {r4}            @ Element 6
	bl	printf
	add	sp, #12		@ Correct Stack for all the pushes

	bl	exit

comparefunc:
@ Compare the two elements to each others and simply return whether the result
@ was less than, greater than, or equal (using -1, 1, and 0 respectively, it's
@ the format of the return value that qsort expects)
@------------------------------------------------------------------------------
	push	{lr}		@ Know where we came from
	ldrb	r0, [r0]	@ Get value of first element
	ldrb	r1, [r1]	@ Get value of second element
	cmp	r0, r1		@ Compare them
	movlt	r0, #-1		@ Return negative number if less than
	movgt	r0, #1		@ Return positive number of greater than
	moveq	r0, #0		@ Return zero if equal
	pop	{lr}		@ Remember where we came from
	bx	lr		@ Return there

exit:
	pop 	{ip, pc}

.data
	array: .byte 6,2,0,4,9,34	@When done: 0x0, 0x2, 0x4, 0x6, 0x9, 0x22
	format: .asciz "Array Values: [%i, %i, %i, %i, %i, %i]\n"
