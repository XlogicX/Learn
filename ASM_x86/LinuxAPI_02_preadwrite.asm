;Example of file operation API calls using pread and pwrite. API calls found in this example program:
; 	open, close, pread, pwrite, write, exit
; High level description of what theis example program does:
;	Creates a new file with open() call and a filename specified at 'newfile' buffer.
;	Writes the contents in 'contents' buffer to this new file with the write() call.
;	Writes some different contents into the same file 8 bytes into the file with the pwrite() call.
;	Closes the file using close().
;	Re-opens the same existing file with open(), but in read-only mode this time.
;	Reads the file starting on the 8th byte using the pread() call
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
	mov		ecx, 102o			;Flags, Create and Writable
	mov		edx, 600o
	int		0x80
	mov		[filehandle], eax	;save filehandle

;Write the contents in 'contents' buffer to this new file with the write() call
;------------------------------------------------------------------------------
	mov		eax, 4				;write
	mov		ebx, [filehandle]	;handle for newly opened file
	mov		ecx, contents		;location of contents to write
	mov		edx, 47				;how many bytes to write
	int		0x80

; Write different contents into same file 8 bytes into file with pwrite() call
;------------------------------------------------------------------------------
	mov		eax, 181			;pwrite
	mov		ebx, [filehandle]	;handle for newly opened file
	mov		ecx, modif			;location of contents to write
	mov		edx, 19				;how many bytes to write
	mov		esi, 8				;starting on the 8th byte of file
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

; Read the file starting on the 8th byte using the pread() call
;------------------------------------------------------------------------------
	mov		eax, 180			;pread
	mov		ebx, [filehandle]	;the file handle
	mov		ecx, filebuffer		;data in memory
	mov		edx, 39				;read 39 bytes
	mov		esi, 8				;starting on the 8th byte of the file
	int		0x80

; Close the file with close()
;------------------------------------------------------------------------------
	mov		ebx, [filehandle]	;get filehandle return value
	mov		eax, 6				;close
	int		0x80

; Print contents of what was read to stdout (file descriptor 1) using write()
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
	modif db 'a modification of  '

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