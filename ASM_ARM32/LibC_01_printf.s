@ A Basic printf example that uses a string, digits, and a pointer in its format
@ I deliberately made sure to use enough arguments to printf to nessesitate
@ pushing the last argument to the stack
@ Section in LibC Manual: 12.12.7 (Input/Output on Streams Chapter)
@ Build: as LibC_printf.s -o LibC_printf.o && gcc LibC_printf.o -o LibC_printf

.text
.global main

main:
	push 	{ip, lr}

@ Load Arguments for Printf and print them
@------------------------------------------------------------------------------
	ldr	r0, =format	@ The actual format string
	ldr	r1, =format	@ Same thing, put we are going to print it as a pointer
	ldr	r2, =format	@ Same as above, but will be as decimal
	mov r3, #149946368
	add r3, #53504
	add r3, #128		@ r3 will contain 150,000,000
	ldr	r4, =string	@ A string to use in our sentance
	push	{r4}		@ And we have to push the string address to the stack
	bl	printf		@ Now call (branch) printf
	add	sp, #4		@ Recover stack alignment (as we pushed something to stack)
	bl	exit

exit:
	pop 	{ip, pc}

.data
	format: .ascii "This format is at %p, which in decimal is %d.\n"
		.asciz "The stegosaurus existed about %d years %s.\n"
	string: .asciz "ago"

@ Some Printf Documentation TLDR
@------------------------------------------------------------------------------

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
