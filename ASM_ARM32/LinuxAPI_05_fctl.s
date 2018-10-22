@Example of fcntl API. API calls found in this example program:
@ 	open, close, fcntl, exit
@ High level description of what theis example program does:
@	Opens a file with the open() API.
@	Changes the flags for the file to NOATIME, APPEND, and WRONLY using fcntl()_SETFD
@	Checks the flags of the file using fcntl()_GETFD (making sure the previously set value gets returned into EAX)
@	closes the file handle with close()
@	exits program with exit()

.text
.global _start

_start:

@ Open file as Read-Only
@------------------------------------------------------------------------------
	mov	r7, #5			@open
	ldr	r0, =newfile		@pointer to the filename
	mov	r1, #2			@Flags, for Read Only
	swi	#0
	ldr	r1, =filehandle		@Pointer to filehandle
	str	r0, [r1]		@store value of filehandle

@ Nah Fuck that, change it to WRONLY, append mode, and don't set the timestamp
@------------------------------------------------------------------------------
	mov	r7, #55			@fcntl
        ldr     r0, =filehandle		@pointer to filehandle
	ldr	r0, [r0]		@value of filehandle
	mov	r1, #4			@SETFL
	@mov	r2, #01002001		@NOATIME, APPEND, WRONLY
		mov	r2, #0x100
		lsl	r2, #10
		mov	r3, #0x100
		lsl	r3, #2
		add	r3, #1
		add	r2, r3
	swi	#0

@ Read the file mode back to verify that it took
@------------------------------------------------------------------------------
	mov	r7, #55			@fcntl
	ldr	r0, =filehandle		@pointer to filehandle
	ldr	r0, [r0]		@value of filehandle
	mov	r1, #3			@GETFL
	swi	#0

@ Now close the file
@------------------------------------------------------------------------------
        mov     r7, #6                  @close
        ldr     r0, =filehandle
        ldr     r0, [r0]
        swi     #0

@ Exit program
@------------------------------------------------------------------------------
	mov	r7, #1
	swi	#0

.data
	newfile: .asciz "newfile.txt"

.bss
	.lcomm filehandle, 4

@ ------------------------------
@ | Some bitfield explanations |
@ ------------------------------

@ fctl commands (goes in ecx)
@------------------------------------------------------------------------------
@	0	F_DUPFD	(needs argument)
@	1	F_GETFD
@	2	F_SETFD (needs argument)
@	3	F_GETFL
@	4	F_SETFL (needs permissions as argument)
@	5	F_GETLK (needs argment, address)
@	6	F_SETLK (needs argument, address)
@	7	F_SETLKW (needs argument)
@	8	F_SETOWN (needs argument)
@	9	F_GETOWN
@	10	F_SETSIG (needs argument)
@	11	F_GETSIG (needs argument)

@ Mode Octal codes
@------------------------------------------------------------------------------
@	Read	4
@	Write	2
@	Execute	1

@ Flags octal codes, ones with *'s can be modified with SETFL
@------------------------------------------------------------------------------
@	O_RDONLY    	0
@	O_WRONLY    	1
@	O_RDWR		2
@	O_ACCMODE	3
@	O_CREAT     	100
@	O_EXCL		200	(Create file exclusively, with CREAT; call fails if file already exists)
@	O_NOCTTY    	400	(Don’t let pathname become the controlling terminal)
@	O_TRUNC     	1000	(Truncate existing file to zero length)
@	*O_APPEND	2000	(Append mode, also mitigates race conditions that lseek with SEEK_END doesn't)
@	*O_NONBLOCK	4000	(Open in nonblocking mode)
@	O_DSYNC     	10000	(Provide synchronized I/O data integrity)
@	*O_ASYNC	20000	(Generate a signal when I/O is possible)
@	*O_DIRECT	40000	(File I/O bypasses buffer cache)
@	O_LARGEFILE	100000
@	O_DIRECTORY	200000	(Fail if pathname is not a directory)
@	O_NOFOLLOW	400000	(Don't dereference symbolic links)
@	*O_NOATIME  	1000000	(Don't update access time with read syscall)
@	O_CLOEXEC   	2000000	(Set the close-on-exec flag)
@	O_SYNC		4010000	(Make file writes synchronous)
@	O_PATH     	10000000
@	O_TMPFILE   	20200000
