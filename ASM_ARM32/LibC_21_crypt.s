@ This program shows doing SHA512, SHA256, MD5, and DES functions on a string.
@ For each hash, a null salt is used.
@ Section in LibC Manual: 33.1 (Cryptographic Functions Chapter)
@ Build: as LibC_crypt.s -o LibC_crypt.o && gcc -lcrypt LibC_crypt.o -o LibC_crypt

.text
.global main

main:
        push {ip, lr}

@ Perfrom SHA512 on the string and print the result
@------------------------------------------------------------------------------
	ldr	r0, =passphrase
	ldr	r1, =sha_2_512_salt
	bl	crypt

	mov	r1, r0
	ldr	r0, =format_sha512
	bl	printf

@ Perfrom SHA256 on the string and print the result
@------------------------------------------------------------------------------
        ldr     r0, =passphrase
        ldr     r1, =sha_2_256_salt
        bl      crypt

        mov     r1, r0
        ldr     r0, =format_sha256
        bl      printf

@ Perfrom MD5 on the string and print the result
@------------------------------------------------------------------------------
        ldr     r0, =passphrase
        ldr     r1, =md5_salt
        bl      crypt

        mov     r1, r0
        ldr     r0, =format_md5
        bl      printf

@ Perfrom DES on the string and print the result
@------------------------------------------------------------------------------
        ldr     r0, =passphrase
        ldr     r1, =des_salt
        bl      crypt

        mov     r1, r0
        ldr     r0, =format_des
        bl      printf


@ Exit
@------------------------------------------------------------------------------
        pop {ip, pc}

.data
	passphrase: .asciz "This is my password"
	sha_2_512_salt: .ascii "$6$\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
	sha_2_256_salt: .ascii "$5$\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
	md5_salt: .ascii "$1$\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
	des_salt: .ascii "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
	format_sha512: .asciz "SHA2-512: %s\n"
	format_sha256: .asciz "SHA2-256: %s\n"
	format_md5: .asciz "MD5: %s\n"
	format_des: .asciz "DES: %s\n"
