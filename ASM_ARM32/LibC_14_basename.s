@ This program takes a 'dummy' filepath and gets the file name with the basename
@ function and then prints it. After that, it gets the directory component of the
@ path with dirname and prints that.
@ Section in LibC Manual: 5.10 (String and Array Utilities Chapter)
@ Build: as LibC_basename.s -o LibC_basename.o && gcc LibC_basename.o -o LibC_basename

.text
.global main

main:
	push 	{ip, lr}

	ldr	r0, =dir
	bl	basename
	@ Returns pointer after last slash in the filename
	@ I suppose strrchr(dir,'/') would acheive the same
	mov	r1, r0
	ldr	r0, =format1
	bl	printf

	ldr	r0, =dir
	bl	dirname
	@ This bitch will replace the last slash with a null to acheive its result
	@ So give this function a ephemeral version of your full path
	mov	r1, r0
	ldr	r0, =format2
	bl	printf

exit:
	pop 	{ip, pc}

.data
	dir: .asciz "/home/xlogicx/Documents/directory/filename-with.annoying.ext_ension.dat"
	format1: .asciz "File Name: %s\n"
	format2: .asciz "Dir Name: %s\n"
