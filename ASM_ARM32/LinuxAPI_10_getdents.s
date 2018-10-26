@Example of reading the contents of a directory using the getdents API call. API calls found in this example program:
@ 	open, getdents, exit
@ High level description of what theis example program does:
@	Opens a directory in readonly mode for the file descriptor with open API
@	Reads data structure for directory and places in memory buffer with getdents API
@	Closes fd for directory with close API
@	exits gracefully with exit().

.text
.global _start

_start:

@ Open dir with open() call and a dir specified at 'dir' buffer
@------------------------------------------------------------------------------
	mov	r7, #5			@open
	ldr	r0, =dir		@pointer to the filename
	mov	r1, #0			@Flags, for Read Only
	mov	r2, #0			@Permissions not relevant
	swi	#0
	ldr	r1, =filehandle		@Get pointer to filehandle value
	str	r0, [r1]		@save filehandle

@ Get directroy contents into dirbuffer memory location
@------------------------------------------------------------------------------
	mov	r7, #141		@getdents
	ldr	r0, =filehandle		@pointer to the directory fd
	ldr	r0, [r0]
	ldr	r1, =dir		@where we want the results
	mov	r2, #300		@size of buffer for results
	swi	#0

@ Close the file with close().
@------------------------------------------------------------------------------
	mov	r7, #6			@close
	ldr	r0, =filehandle
	ldr	r0, [r0]
	swi	#0

@ Exit program
@------------------------------------------------------------------------------
	mov	r7, #1
	swi	#0

.data
	dir: .asciz "."

.bss
	.lcomm filehandle, 4
	.lcomm dirbuffer, 300

@ Seems simple right? Oh...you wanted something inteligible as far as the
@ directory listing results, and you wanted them printed out, not just a data
@ blob in a memory buffer? Aint nobody got time for that, below is some
@ documentation for the datastructure, parse it (with your brain) from memory
@ yourself. This is just a quick PoC for getdents, not a PoC for parsing a
@ complex data structure and displaying it to a human (that program would be 
@ bigger).
@ ------------------------------
@ | Some bitfield explanations |
@ ------------------------------

@ Data Structure for the directory results that show up in the provided buffer
@------------------------------------------------------------------------------
@ struct linux_dirent {
@     unsigned long  d_ino;      Inode number 
@     unsigned long  d_off;      Offset to next linux_dirent 
@     unsigned short d_reclen;   Length of this linux_dirent 
@     char           d_name[];   Filename (null-terminated) 
@                        length is actually (d_reclen - 2 -
@                          offsetof(struct linux_dirent, d_name)) 
@     
@     char           pad;        Zero padding byte
@     char           d_type;     File type (only since Linux
@                                2.6.4); offset is (d_reclen - 1)
@     
@ }
