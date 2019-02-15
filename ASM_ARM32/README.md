Environment
=====
OS: Raspbian armv6-stretch in QEMU on Ubuntu<br>
Raspbian Stretch on Raspberry Pi 1/2/3

Editor: nano

Assembler: as

Linker: ld

Commands to assemble and link:<br> 
as skeleton.s -o skeleton.o<br>
ld skeleton.o -o skeleton

Execution: ./skeleton

Debugger (USE THIS when learning): gdb (with custom .gdbinits):<br>
GEF: https://github.com/hugsy/gef - This one is great but fucks up on subroutines for below GDB 8.1 (so Raspbian is affected by this)<br>
reverse.put.as: https://github.com/gdbinit/Gdbinit - Doesn't fuck up on subs, but less features and details as GEF<br>

ASM diff
=====
The approach to this program is much different than the other non-assembly programs in this project. Although we could use the assembler programs many features and macros, we don't. Why? the focus for this is on assembly, not the assembler, not linux/windows, and none of that HLA BS. This could be a much more clear program if I fully used HLA and all the assembler features, but it wouldn't be as useful for demonstrating actual assembly.

It should also be noted that the program won't "appear" to do much; it will just print "Hello World!" to the terminal. Too "see" the full effect of all of these opcodes, it would be ideal to run this in gdb on an ARM+Linux platform.

Overall opcodes/concepts demonstrated:
* Movement: mov
* Stack: push, pop
* Maths: add, sub, mul, sdiv/udiv (can't on Pi)
* Logic: and, orr, neg, eor
* Shiftiness: lsl, lsr, ror (rol)
* Conditions: cmp
* Subroutines: b, bl, bx lr
* no operation at all: nop
* Memory: ldr, str    
* syscall: svc, sys_write, sys_exit

There is arguably a lot not covered, but that isn't the purpose of this project. The above opcodes should certainly get you in the right direction; they are the most common

Linux API Calls (Meat)
=====
* open (files.s, preadwrite.s, fctl.s)
* close (files.s, preadwrite.s, fctl.s)
* read (files.s)
* write (files.s, preadwrite.s)
* lseek (files.s)
* pread (preadwrite.s)
* pwrite (preadwrite.s)
* getpid (getpid.s)
* getppid (getpid.s)
* time (time.s)
* gettimeofday (time.s)
* fctl (fctl.s)
* brk (brk.s)
* mkdir (mkdir.s)
* rmdir (rmdir.s)
* getdents (getdents.s)
* signal (sigaction.s and setitimer.s; via sigaction API as signal obsolete and unsupported by my raspi)
* kill (kill.s)
* timers (setitimer.s)
* getpriority (nice.s)
* setpriority (nice.s)
* getusage (usage.s)
* getlimit (limits.s)
* setlimit (limits.s)
* socket (sockets.s)
* connect (sockets.s)
* fork (fork.s)
* wait4 (fork.s)
* execve (fork.s)
* exit (in all examples)

Some LibC Functions (Meat)
=====
* LibC_01_printf.s
  * printf()
* LibC_02_error.s
  * strerror()
* LibC_03_malloc.s
  * malloc
  * free
  * realloc
  * memset
