@ This program uses malloc to allocate 200 bytes of memory then shoves some
@ A's into the first part of the memory using memset. We then use realloc
@ to reduce this memory size to 32 bytes, we don't really need to do this with
@ this program, it is just a demonstration on how realloc is used. Finally we
@ call 'free' to free up the memory.
@ Sections in LibC Manual: 3.2.3.1, 3.2.3.3, 3.2.3.4, 5.4 (Virtual Memory 
@ 	Allocation And Paging and String and Array Utilities Chapters)
@ Build: as LibC_malloc.s -o LibC_malloc.o && gcc LibC_malloc.o -o LibC_malloc

.text
.global main

main:
@------------------------------------------------------------------------------
	push {ip, lr}

@ Allocate 200 bytes of memory & note where it is
@------------------------------------------------------------------------------
	mov	r0, #200	@ 200 bytes
	bl	malloc		@ call malloc
	ldr	r1, =memptr	@ Variable address for where we want memory pointer that we malloc'd
	str	r0, [r1]	@ Store the base address of new memory in our memptr variable

@ Shove a bunch (16) of 'A's (0x41) into our new malloc'd memory
@------------------------------------------------------------------------------
	mov	r1, #0x41	@ 'A'
	mov	r2, #16		@ 16 of them
	bl	memset		@ r0 already has where base memory is from last malloc call

@ Use LinuxAPI Write call to print 18 bytes
@------------------------------------------------------------------------------
	mov	r7, #4			@ Write
	mov	r0, #1			@ stdout
	ldr	r1, =memptr	 	@ contents read from memory
	ldr	r1, [r1]
	mov	r2, #18			@ how many bytes to print
	swi 	#0

@ Now allocate for only 32 bytes of memory (instead of the 200 we had before)
@ We don't really do anything with this memory afterwards though, just a demo of realloc
@------------------------------------------------------------------------------
	ldr	r0, =memptr	@ We need the original base address of the malloc'd memory
	ldr	r0, [r0]	@ Dereference
	mov	r1, #32		@ 32 bytes
	bl	realloc		@ Reallocate

@ Free the Memory up, don't want any memory leaks
@------------------------------------------------------------------------------
	ldr	r0, =memptr	@ Base address of our malloc'd memory
	ldr	r0, [r0]	@ Dereference
	bl	free		@ free it up

@ Exit gracefully
@------------------------------------------------------------------------------
	pop {ip, pc}

.bss
	.lcomm memptr, 4
