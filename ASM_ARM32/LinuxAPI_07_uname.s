@Example of using the uname API. API calls found in this example program:
@ 	uname, exit
@ High level description of what theis example program does:
@	Simply calls uname and stores the result in memory pointer

.text
.global _start

_start:

@ Get uname data
@ This doesn't work on my raspberry pi because the function isn't implemented
@ After doing the syscall, r0 get's a return of 0xffffffda (-0x25) or error code 38
@ Running 'errno 38' returns: ENOSYS 38 Function not implemented
@------------------------------------------------------------------------------
	mov 	r7, #109	@ uname
    	ldr 	r0, =sysname	@ Pointer to where you want the data
    	swi	#0

@ Exit
@------------------------------------------------------------------------------
	mov 	r7, #1
	swi	#0


.bss
	.lcomm sysname, 65	@ Probably 'Linux'
	.lcomm nodename, 65	@ Hostname in my case
	.lcomm release, 65	@ Kernel version
	.lcomm version, 65	@ Version details
	.lcomm machine, 65	@ Architecture
