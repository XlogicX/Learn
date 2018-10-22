@ Example of file operation API calls. API calls found in this example program:
@ 	open, close, read, write, lseek, exit
@ High level description of what theis example program does:
@	Creates a new file with open() call and a filename specified at 'newfile' buffer.
@	Writes the contents in 'contents' buffer to this new file with the write() call.
@	Closes the file using close().
@	Re-opens the same existing file with open(), but in read-only mode this time.
@	Moves 8 bytes into the file (skipping the first 8 bytes) using lseek() call.
@	Reads the remaining bytes of the file and stores those bytes in the 'filebuffer' area of memory, using read().
@	closes the file with close().
@	prints the contents of what was read to stdout (file descriptor 1) using write().
@	exits gracefully with exit().

.text
.global _start

_start:

@ Create new file with open() call and a filename specified at 'newfile' buffer
@------------------------------------------------------------------------------
	mov	r7, #5			@open
	ldr	r0, =newfile		@pointer to the filename
	mov	r1, #0102		@Flags, Create and Writable()
	mov	r2, #0600		@Permissions
	swi	#0
	ldr	r1, =filehandle		@Get pointer to filehandle value
	str	r0, [r1]		@save filehandle

@ Write the contents in 'contents' buffer to new file with the write() call
@------------------------------------------------------------------------------
	mov	r7, #4			@write
	ldr	r0, =filehandle		@pointer to handle for opened file
	ldr	r0, [r0]		@value of handle
	ldr	r1, =contents		@location of contents to write
	mov	r2, #47			@how many bytes to write
	swi	#0

@ Close the file using close()
@------------------------------------------------------------------------------
	mov	r7, #6			@close
	ldr	r0, =filehandle
	ldr	r0, [r0]
	swi	#0

@ Re-open the same existing file with open(), but in read-only mode this time
@------------------------------------------------------------------------------
	mov	r7, #5			@open
	ldr	r0, =newfile		@pointer to the filename
	mov	r1, #0			@Flags, for Read Only
	swi	#0
	ldr	r1, =filehandle		@Get pointer to filehandle value
	str	r0, [r1]		@save filehandle

@ Move 8 bytes into the file (skipping the first 8 bytes) using lseek() call
@------------------------------------------------------------------------------
	mov	r7, #19			@lseek
	ldr	r0, =filehandle
	ldr	r0, [r0]
	mov	r1, #8			@how many bytes to skip from whence
	mov	r2, #0			@whence argument (see notes below for explanation of codes)
	swi	#0

@ Read remaining bytes of file and store those bytes to pointer using read()
@------------------------------------------------------------------------------
	mov	r7, #3			@read
	ldr	r0, =filehandle
	ldr	r0, [r0]
	ldr	r1, =filebuffer		@where in memory to put contents of file
	mov	r2, #39			@how many characters to read
	swi	#0

@ Close the file with close().
@------------------------------------------------------------------------------
        mov     r7, #6                  @close
        ldr     r0, =filehandle
        ldr     r0, [r0]
        swi     #0

@ Print the contents of what's read to stdout (file descriptor 1) using write()
@------------------------------------------------------------------------------
	mov	r7, #4			@write
	mov	r0, #1			@stdout
	ldr	r1, =filebuffer 	@contents read from file
	mov	r2, #39			@how many bytes to print
	swi	#0

@ Exit program
@------------------------------------------------------------------------------
	mov	r7, #1
	swi	#0


.data
	newfile: .asciz "newfile.txt"
	contents: .ascii "This is an example of some contents of a file.\x0a"

.bss
	.lcomm filehandle, 4
	.lcomm filebuffer, 47

@ ------------------------------
@ | Some bitfield explanations |
@ ------------------------------

@ Mode Octal codes
@------------------------------------------------------------------------------
@	Read	4
@	Write	2
@	Execute	1

@ Flags octal codes (info from The Linux Programming Interface and 
@ https://code.woboq.org/userspace/glibc/sysdeps/unix/sysv/linux/bits/fcntl-linux.h.html)
@------------------------------------------------------------------------------
@	O_RDONLY    	0
@	O_WRONLY    	1
@	O_RDWR		2
@	O_ACCMODE	3
@	O_CREAT     	100
@	O_EXCL		200	(Create file exclusively, with CREAT; call fails if file already exists)
@	O_NOCTTY    	400	(Don’t let pathname become the controlling terminal)
@	O_TRUNC     	1000	(Truncate existing file to zero length)
@	O_APPEND	2000	(Append mode, also mitigates race conditions that lseek with SEEK_END doesn't)
@	O_NONBLOCK	4000	(Open in nonblocking mode)
@	O_DSYNC     	10000	(Provide synchronized I/O data integrity)
@	O_ASYNC		20000	(Generate a signal when I/O is possible)
@	O_DIRECT	40000	(File I/O bypasses buffer cache)
@	O_LARGEFILE	100000
@	O_DIRECTORY	200000	(Fail if pathname is not a directory)
@	O_NOFOLLOW	400000	(Don't dereference symbolic links)
@	O_NOATIME   	1000000	(Don't update access time with read syscall)
@	O_CLOEXEC   	2000000	(Set the close-on-exec flag)
@	O_SYNC		4010000	(Make file writes synchronous)
@	O_PATH     	10000000
@	O_TMPFILE   	20200000

@ 'whence' argument for lseek, in edx register. offset (in ecx register) can be 
@ negative for CUR and END
@------------------------------------------------------------------------------
@	0	SEEK_SET	beginning of file + offset
@	1	SEEK_CUR	current location of file + offset
@	2	SEEK_END	End of File + offset (read after file)
