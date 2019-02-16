@ Yeah, gets is dangerous, whatevs. This program will prompt for a string
@ input up to 40 bytes (it may take more, due to dangerous reasons). It will
@ then locate the 4th character and change it to an X. Finally it will print
@ out that modified string using puts.
@ Section in LibC Manual: 12.7 and 12.9 (Input/Output on Streams Chapter)
@ Build: as LibC_gets.s -o LibC_gets.o && gcc LibC_gets.o -o LibC_gets

.text
.global main

main:
	push 	{ip, lr}

	ldr	r0, =userstring		@ Buffer for the user entered string (40 bytes)
	bl	gets			@ Get a user input string

	ldr	r0, =userstring		@ The string
	add	r0, #3			@ Get 4th character
	mov	r1, #'X'		@ Change it to an 'X'
	strb	r1, [r0]		@ Mangle 4th character with X
	ldr	r0, =userstring		@ Reload the string
	bl	puts			@ print the string out using puts
	bl	exit

exit:
	pop 	{ip, pc}

.bss
	.lcomm userstring, 40
