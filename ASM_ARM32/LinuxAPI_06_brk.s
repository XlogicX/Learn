@Example of allocating heap memory with the brk API call. API calls found in this example program:
@ 	brk, exit
@ High level description of what theis example program does:
@	Find the current end of heap with brk
@	Add 1MB of memory to the heap
@	Write some data around the end of the heap

.text
.global _start

_start:

@ Locate Current Heap End
@------------------------------------------------------------------------------
	mov	r7, #45			@brk
    	mov	r0, #0			@This will cause an error
    	swi	#0			@Which will return current heap end value
	ldr	r1, =brk_start		@Get pointer for break start
	str	r0, [r1]		@Store the value

@ Allocate about a megabyte of heap memory
@------------------------------------------------------------------------------
    	mov	r7, #45			@brk
	ldr	r0, =brk_start		@Get pointer to current heap break
	ldr	r0, [r1]		@Get value of heap break
    	@add	r0, 0x100000		@Add a megabyte to it
		mov	r1, #0x100
		lsl	r1, #12
		add	r0, r1
   	swi	#0
	ldr	r1, =brk_end		@Get pointer to new end address
	str	r0, [r1]		@Store the new end address value

@ Write some data around the end of the heep.
@------------------------------------------------------------------------------
	ldr	r0, =brk_end		@Get the pointer for the heaps last adr boundry
	ldr	r0, [r0]		@Get the value of the heaps last adr boundry
	sub	r0, #16			@Go backwards 16 bytes
	str	r0, [r0]		@Write some data into that location
					@This memory locations value will be its own address
		@Without doing the heap managment calls with brk, the above instruction
		@would have an illegal access fault.

@ Exit
@------------------------------------------------------------------------------
	mov	r7, #1
	swi	#0


.bss
	.lcomm brk_start, 4	@to keep track of where the heap started in the beginning
	.lcomm brk_end, 4	@to keep track of the current end of heap location
