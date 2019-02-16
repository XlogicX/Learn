@ This program takes a string and scrambles up all of the characters using
@ strfry (pronounced stir-fry, I hope). It then takes that string and XOR
@ encodes the first 10 bytes of the jumbled string. Both results are printed
@ using printf
@ Section in LibC Manual: 5.12 and 5.13 (String and Array Utilities Chapter)
@ Build: as LibC_stringtrash.s -o LibC_stringtrash.o && gcc LibC_stringtrash.o -o LibC_stringtrash

.text
.global main

main:
	push 	{ip, lr}

@ Randomize all of the characters of an existing string; jumble them up
@------------------------------------------------------------------------------
	ldr	r0, =string
	bl	strfry		@ Randomize all of the characters of string
	bl	printf
	ldr	r0, =newline
	bl	printf

@ XOR the first 10 bytes of the string with the key of 0x2A
@------------------------------------------------------------------------------
	ldr	r0, =string
	mov	r1, #10		@ Only process the first 10 bytes
	bl	memfrob		@ XOR them with the key of 0x2A
	bl	printf
	ldr	r0, =newline
	bl	printf

exit:
	pop 	{ip, pc}

.data
	string: .asciz "Hi I'm a string, I will be randomized"
	newline: .ascii "\x0a"
