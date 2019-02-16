@ This is a very simple scanf example of accepting an integer from the user and then
@ storing the result into a register. It effectively also serves as an ascii decimal
@ to hex/number (register) conversion
@ Section in LibC Manual: 12.14.8 (Input/Output on Streams Chapter)
@ Build: as LibC_scanf.s -o LibC_scanf.o && gcc LibC_scanf.o -o LibC_scanf

.text
.global main

main:
	push 	{ip, lr}

	ldr	r0, =format3	@ Promt user for a digit (if the chose to do that...)
	bl	printf

	ldr	r0, =format	@ The actual format string
	ldr	r1, =integer	@ pointer to number we want to collect
	bl	scanf		@ Now call (branch) scanf
	ldr	r1, =integer	@ Get pointer to user supplied number

	ldr	r0, =format2	@ Format string for printing the number back out
	ldr	r1, [r1]	@ Get that number into a register as arg to printf
	bl	printf
	bl	exit

exit:
	pop 	{ip, pc}

.data
	format: .ascii "%d"
	format2: .asciz "Your Number was: %i\n"
	format3: .asciz "Enter a Number: "

.bss
	.lcomm integer, 4

@ Syntax
@ %[param-no] flags width . * [param-no $] type conversion
@ %[param-no] flags width [ . precision ] type conversion
@ Example: %-10.8ld
@	flag: -, width: 10, precision: *, type: l, conversion: d
@	long int, decimal, minimum of 8 digits, left-justified, in field at least 10 chars wide

@ Common formats
@ %d/%i - digit
@ %s - string
@ %c - character
@ %u - unsigned number
@ %x/%X - unsigned hex
@ %o - unsinged octal
@ %f - floating point
@ %e - exponent form
@ %p - pointer
@ %% - just a %

@ Flags
@ - - Left justify
@ + - show + sign if value is positive
@   - provide space for + or - sign
@ # - prefixes octal and hex (as in the 0x prefix for hex)
@ ' - comma the digits up
@ 0 - pad with 0's instead of spaces (ignored if - flag or precision specified)
