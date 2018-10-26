;Example of fcntl API. API calls found in this example program:
; 	open, close, fcntl, exit
; High level description of what theis example program does:
;	Opens a file with the open() API.
;	Changes the flags for the file to NOATIME, APPEND, and WRONLY using fcntl()_SETFD
;	Checks the flags of the file using fcntl()_GETFD (making sure the previously set value gets returned into EAX)
;	closes the file handle with close()
;	exits program with exit()

section .text
global _start

_start:

; Open file as Read-Only
;------------------------------------------------------------------------------
	mov		eax, 5				;open
	mov		ebx, newfile		;pointer to the filename
	mov		ecx, 2				;Flags, for Read Only
	int		0x80
	mov		[filehandle], eax	;save filehandle

; Nah Fuck that, change it to WRONLY, append mode, and don't set the timestamp
;------------------------------------------------------------------------------
	mov		eax, 55				;fcntl
	mov		ebx, [filehandle]
	mov		ecx, 4				;SETFL
	mov		edx, 1002001o		;NOATIME, APPEND, WRONLY
	int		0x80

; Read the file mode back to verify that it took
;------------------------------------------------------------------------------
	mov		eax, 55				;fcntl
	mov		ebx, [filehandle]
	mov		ecx, 3				;GETFL
	int		0x80

; Now close the file
;------------------------------------------------------------------------------
	mov		ebx, [filehandle]	;get filehandle return value
	mov		eax, 6				;close
	int		0x80

; Exit program
;------------------------------------------------------------------------------
	mov		eax, 1
	int		0x80

section .data
	newfile db 'newfile.txt', 0x00

section .bss
	filehandle resb 4
	
; ------------------------------
; | Some bitfield explanations |
; ------------------------------

; fctl commands (goes in ecx)
;------------------------------------------------------------------------------
;	0	F_DUPFD	(needs argument)
;	1	F_GETFD
;	2	F_SETFD (needs argument)
;	3	F_GETFL
;	4	F_SETFL (needs permissions as argument)
;	5	F_GETLK (needs argment, address)
;	6	F_SETLK (needs argument, address)
;	7	F_SETLKW (needs argument)
;	8	F_SETOWN (needs argument)
;	9	F_GETOWN
;	10	F_SETSIG (needs argument)
;	11	F_GETSIG (needs argument)

; Mode Octal codes
;------------------------------------------------------------------------------
;	Read	4
;	Write	2
;	Execute	1

; Flags octal codes, ones with *'s can be modified with SETFL
;------------------------------------------------------------------------------
;	O_RDONLY    0
;	O_WRONLY    1
;	O_RDWR		2
;	O_ACCMODE	3
;	O_CREAT     100
;	O_EXCL		200		(Create file exclusively, with CREAT; call fails if file already exists)
;	O_NOCTTY    400		(Don’t let pathname become the controlling terminal)
;	O_TRUNC     1000	(Truncate existing file to zero length)
;	*O_APPEND	2000	(Append mode, also mitigates race conditions that lseek with SEEK_END doesn't)
;	*O_NONBLOCK	4000	(Open in nonblocking mode)
;	O_DSYNC     10000	(Provide synchronized I/O data integrity)
;	*O_ASYNC	20000	(Generate a signal when I/O is possible)
;	*O_DIRECT	40000	(File I/O bypasses buffer cache)
;	O_LARGEFILE	100000
;	O_DIRECTORY	200000	(Fail if pathname is not a directory)
;	O_NOFOLLOW	400000	(Don't dereference symbolic links)
;	*O_NOATIME  1000000	(Don't update access time with read syscall)
;	O_CLOEXEC   2000000	(Set the close-on-exec flag)
;	O_SYNC		4010000	(Make file writes synchronous)
;	O_PATH     	10000000
;	O_TMPFILE   20200000
