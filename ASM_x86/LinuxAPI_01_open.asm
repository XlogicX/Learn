;Example of file operation API calls. API calls found in this example program:
; 	open, close, read, write, lseek, exit
; High level description of what theis example program does:
;	Creates a new file with open() call and a filename specified at 'newfile' buffer.
;	Writes the contents in 'contents' buffer to this new file with the write() call.
;	Closes the file using close().
;	Re-opens the same existing file with open(), but in read-only mode this time.
;	Moves 8 bytes into the file (skipping the first 8 bytes) using lseek() call.
;	Reads the remaining bytes of the file and stores those bytes in the 'filebuffer' area of memory, using read().
;	closes the file with close().
;	prints the contents of what was read to stdout (file descriptor 1) using write().
;	exits gracefully with exit().

section .text
global _start

_start:

; Create new file with open() call and a filename specified at 'newfile' buffer
;------------------------------------------------------------------------------
	mov		eax, 5				;open
	mov		ebx, newfile		;pointer to the filename
	mov		ecx, 102o			;Flags, Create and Writable	()
	mov		edx, 600o
	int		0x80
	mov		[filehandle], eax	;save filehandle

; Write the contents in 'contents' buffer to new file with the write() call
;------------------------------------------------------------------------------
	mov		eax, 4				;write
	mov		ebx, [filehandle]	;handle for newly opened file
	mov		ecx, contents		;location of contents to write
	mov		edx, 47				;how many bytes to write
	int		0x80

; Close the file using close()
;------------------------------------------------------------------------------
	mov		eax, 6				;close
	mov		ebx, [filehandle]
	int		0x80

; Re-open the same existing file with open(), but in read-only mode this time
;------------------------------------------------------------------------------
	mov		eax, 5				;open
	mov		ebx, newfile		;pointer to the filename
	mov		ecx, 0				;Flags, for Read Only
	int		0x80
	mov		[filehandle], eax	;save filehandle

; Move 8 bytes into the file (skipping the first 8 bytes) using lseek() call
;------------------------------------------------------------------------------
	mov		eax, 19				;lseek
	mov		ebx, [filehandle]
	mov		ecx, 8				;how many bytes to skip from whence
	mov		edx, 0				;whence argument (see notes below for explanation of codes)
	int		0x80

; Read remaining bytes of file and store those bytes to pointer using read()
;------------------------------------------------------------------------------
	mov		eax, 3				;read
	mov		ebx, [filehandle]
	mov		ecx, filebuffer		;where in memory to put contents of file
	mov		edx, 39				;how many characters to read
	int		0x80

; Close the file with close().
;------------------------------------------------------------------------------
	mov		ebx, [filehandle]	;get filehandle return value
	mov		eax, 6				;close
	int		0x80

; Print the contents of what's read to stdout (file descriptor 1) using write()
;------------------------------------------------------------------------------
	mov		eax, 4				;write
	mov		ebx, 1				;stdout
	mov		ecx, filebuffer 	;contents read from file
	mov		edx, 39				;how many bytes to print
	int		0x80

; Exit program
;------------------------------------------------------------------------------
	mov		eax, 1
	int		0x80

section .data
	newfile db 'newfile.txt', 0x00
	contents db 'This is an example of some contents of a file.', 0x0a, 0x00

section .bss
	filehandle resb 4
	filebuffer resb 47

; ------------------------------
; | Some bitfield explanations |
; ------------------------------

; Mode Octal codes
;------------------------------------------------------------------------------
;	Read	4
;	Write	2
;	Execute	1

; Flags octal codes (info from The Linux Programming Interface and 
; https://code.woboq.org/userspace/glibc/sysdeps/unix/sysv/linux/bits/fcntl-linux.h.html)
;------------------------------------------------------------------------------
;	O_RDONLY    0
;	O_WRONLY    1
;	O_RDWR		2
;	O_ACCMODE	3
;	O_CREAT     100
;	O_EXCL		200		(Create file exclusively, with CREAT; call fails if file already exists)
;	O_NOCTTY    400		(Don’t let pathname become the controlling terminal)
;	O_TRUNC     1000	(Truncate existing file to zero length)
;	O_APPEND	2000	(Append mode, also mitigates race conditions that lseek with SEEK_END doesn't)
;	O_NONBLOCK	4000	(Open in nonblocking mode)
;	O_DSYNC     10000	(Provide synchronized I/O data integrity)
;	O_ASYNC		20000	(Generate a signal when I/O is possible)
;	O_DIRECT	40000	(File I/O bypasses buffer cache)
;	O_LARGEFILE	100000
;	O_DIRECTORY	200000	(Fail if pathname is not a directory)
;	O_NOFOLLOW	400000	(Don't dereference symbolic links)
;	O_NOATIME   1000000	(Don't update access time with read syscall)
;	O_CLOEXEC   2000000	(Set the close-on-exec flag)
;	O_SYNC		4010000	(Make file writes synchronous)
;	O_PATH     	10000000
;	O_TMPFILE   20200000

; 'whence' argument for lseek, in edx register. offset (in ecx register) can be 
; negative for CUR and END
;------------------------------------------------------------------------------
;	0	SEEK_SET	beginning of file + offset
;	1	SEEK_CUR	current location of file + offset
;	2	SEEK_END	End of File + offset (read after file)