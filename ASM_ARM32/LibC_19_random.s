@ This program prints a random value with a predefined seed. After that, it uses
@ a timestamp as the seed of a random value and prints that
@ Section in LibC Manual: 19.8.1 (Mathematics Chapter)
@ Build: as LibC_random.s -o LibC_random.o && gcc LibC_random.o -o LibC_random

.text
.global main

main:
	push 	{ip, lr}

@ Print a random value with the seed of 1337 (will be the same random number every run)
@------------------------------------------------------------------------------
	mov	r0, #1337	@ Set Seed to something elite
	bl	srand		@ Set the seed
	bl	rand		@ Get random value
	mov	r1, r0		@ The random value is an argument for printf
	ldr	r0, =format
	bl	printf		@ Print the value to stdout

@ Get the Epoch Time with microseconds
@------------------------------------------------------------------------------
	mov 	r7, #78		@ gettimeofday
	ldr	r0, =timeval	@ timeval
    	mov	r1, #0		@ timezone, legacy argument, setting to null
	swi #0

@ Print a random value with part of the timestamp as the seed (will be different every run)
@------------------------------------------------------------------------------
	ldr	r0, =timeval	@ Getting address of where the time is stored
	ldr	r0, [r0]	@ Load the value
	bl	srand		@ The time is the seed
	bl	rand		@ Now get a more random value
	mov	r1, r0		@ The random value is an argument for printf
	ldr	r0, =format
	bl	printf		@ Print the value to stdout

	bl	exit

exit:
	pop 	{ip, pc}


.data
	format: .asciz "The random value is: %d\n"

.bss
	.lcomm timeval 4
