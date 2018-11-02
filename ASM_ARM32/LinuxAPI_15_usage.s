@ Get usage statistics of a process using the getusage API call. API calls found in this example program:
@ 	getusage, exit
@ High level description of what theis example program does:
@	Uses the getusage() API and places the results into memory

.text
.global _start

_start:

@ Get usage statistics
@------------------------------------------------------------------------------
	mov	r7, #77		@ getusage()
	mov	r0, #0		@ 'who' (0=RUSAGE_SELF)
	ldr	r1, =rusage	@ data structure for rusage
	swi	#0

@ Exit
@------------------------------------------------------------------------------
	mov	r7, #1
	swi	#0

.bss
	.lcomm rusage, 72

@ WHO values
@------------------------------------------------------------------------------
@ 0 - RUSAGE_SELF
@ 1 - RUSAGE_CHILDREN
@ 2 - RUSAGE_THREAD

@ RUSAGE Data Structure
@------------------------------------------------------------------------------
@ utime_a	User CPU time used (epoch)
@ utime_b	User CPU time used (usec)
@ stime_a	System CPU time used (epoch)
@ stime_b	System CPU time used (usec)
@ maxrss	Maximum size of resident set (kilobytes)
@ ixrss		Integral (shared) text memory size
@ idrss		Integral (unshared) data memory used
@ isrss		Integral (unshared) stack memory used
@ minflt	Soft page faults (I/O not required)
@ majflt	Hard page faults (I/O required)
@ nswap		Swaps out of physical memory [unused]
@ inblock	Block input operations via file
@ oublock	Block output operations via file
@ msgsnd	IPC messages sent [unused]
@ msgrcv	IPC messages received [unused]
@ nsignals	Signals received [unused]
@ nvcsw		Voluntary context switches (process relinquished CPU before its time slice expired)
@ nivcsw	Involuntary context switches (higher priority process became runnable or time slice ran out)
