@ This is a simple program that uses getchar to prompt for 1 character, next it
@ uses putchar to print your entered character back out on the next line. It then
@ uses putchar again to do a newline. The output will end up showing two instances
@ of the character because echoing is on
@ Section in LibC Manual: 12.7 and 12.8 (Input/Output on Streams Chapter)
@ Build: as LibC_getchar.s -o LibC_getchar.o && gcc LibC_getchar.o -o LibC_getchar

.text
.global main

main:
	push 	{ip, lr}

	bl	getchar
	bl	putchar
	mov	r0, #0x0a	@ newline
	bl	putchar
	bl	exit

exit:
	pop 	{ip, pc}
