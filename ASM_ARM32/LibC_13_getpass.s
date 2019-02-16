@ This program uses the getpass function to request a password string
@ Without echoing it to the terminal as you type. After that, like an
@ asshole, it prints out your password.
@ Section in LibC Manual: 17.8 (Low-Level Terminal Interface Chapter)
@ Build: as LibC_getpass.s -o LibC_getpass.o && gcc LibC_getpass.o -o LibC_getpass

.text
.global main

main:
	push 	{ip, lr}

	ldr	r0, =prompt	@ Print the password prompt
	bl	getpass		@ Get the password

	mov	r1, r0		@ Move the pointer to the password as the 2nd argument for printf
	ldr	r0, =format	@ Format string for printing the password info
	bl	printf		@ Print it

	bl	exit

exit:
	pop 	{ip, pc}

.data
	prompt: .asciz "Password:> "
	format: .asciz "Your password was: %s\n"
