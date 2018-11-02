@ Mess with a resource limit of process and fail resource usages using get and setlimit API Calls
@ API calls found in this example program:
@ 	getpriority, setpriority, write, exit
@ High level description of what theis example program does:
@	Get current open file handle limit values using getlimit()
@	Set the value to 0 (even 2 would be too low to open a new handle; because STDIN/OUT/ERR)
@	Try to open a new file handle (get error)

.text
.global _start

_start:

@ How many file handles can we have open? (I got 1024 when I ran this)
@------------------------------------------------------------------------------
	mov	r7, #76		@ getlimit()
	mov	r0, #7		@ open files
	ldr	r1, =rlimit	@ data structure for rlimit
	swi	#0

@ Set the limit to none #lol
@------------------------------------------------------------------------------
	mov	r7, #75		@ setlimit()
	mov	r0, #7		@ open files
	ldr	r1, =cpusoft	@ data structure for rusage
	swi	#0

@ Try opening a file
@-----------------------------------------------------------------------------
	mov	r7, #5		@ open
	ldr	r0, =newfile	@ ponter to filename
	mov	r1, #0		@ Flags, for Read Only
	swi	#0
	@ If the file exists, the return value should be error code ...ffffffe8
	@ which is: EMFILE (Too many open files)

@ Exit
@------------------------------------------------------------------------------
	mov 	r7, #1
	swi	#0

.data
	cpusoft: .long 0
	cpuhard: .long 0
	newfile: .asciz "LinuxAPI_16_limits.asm"

.bss
	.lcomm rlimit, 8
	.lcomm filehandle, 4

@ rlimit data structure
@------------------------------------------------------------------------------
@ soft limit
@ hard limit

@ Resource Codes
@------------------------------------------------------------------------------
@ 0 - CPU		CPU time (seconds)
@ 1 - FSIZE		File size (bytes)
@ 2 - DATA		Process data segment (bytes)
@ 3 - STACK		Size of stack segment (bytes)
@ 4 - CORE		Core file size (bytes)
@ 5 - RSS		Resident set size (bytes; not implemented)
@ 6 - NPROC		Number of processes for real user ID
@ 7 - NOFILE		Maximum file descriptor number plus one
@ 8 - MEMLOCK		Locked memory (bytes)
@ 9 - AS		Process virtual memory size (bytes)
@ 10 - LOCKS		Number of locks
@ 11 - SIGPENDING	Number of queued signals for real user ID
@ 12 - MSGQUEUE		Bytes allocated for POSIX message queues for real user ID
@ 13 - NICE		Nice value
@ 14 - RTPRIO		Realtime scheduling priority
@ 15 - RTTIME		Realtime CPU time (microseconds)
