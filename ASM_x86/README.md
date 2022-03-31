Environment
=====
OS: Ubuntu Linux (12.04 LTS) 32-bit<br>
Kali Linux (comes with nasm/ld and edb pre-installed)

Editor: SublimeText

Assembler: Nasm

Linker: ld

Commands to assemble and link:<br> 
nasm -f elf skeleton.asm<br>
ld -m elf_i386 -s -o skeleton skeleton.o

Execution: ./skeleton

Debugger (USE THIS when learning): edb (Evans Debugger). This guide is okay: http://www.benmccann.com/blog/installing-evans-debugger-in-ubuntu/
Kali Linux has nasm/ld and edb.

GDB
=====
There are also great gdb init files to make the gdb debugger more 'usable.' These 'enhanced' visuals show most of the pertinent information going on in the CPU and memory/stack for each instruction step, without you having to query each individual thing (especially since you may not know which things are even worth querying).

I still highly recommend 'gef':<br>
https://gef.readthedocs.io/en/master/

This is also a good newer alternative:<br>
https://github.com/cyrus-and/gdb-dashboard

"Installation" for both are a simple oneliner command (shown on the corresponding doc page for each).

GDB has TONS of commands and features you could know. Here are some essential ones in the context of following this skeleton

br
====
You can breakpoint on labels and addresses. An example of breakpointing the beginning of the skeleton:<br>
br _start<br>
An example of breakpointing an arbitrary address in program memory:<br>
br *0x100a50<br>

info files
====
Gives good amount of info about the program structure, and notably gives the address of the entry point when things like '_start', 'start', or 'main' aren't working for you (you can just use the address of the entry point).

run
====
Actually starts running the program, but make sure to set your breakpoint first, or it will run right past you. If you are in the middle of the program somewhere, running this command again is effectively 'restart'

si
====
Single step an instruction, one at a time. In other debuggers, this can also be known as the 'step into' kind of stepping. If you want to step by a fixed amount of instructions more than just one, you can specify how many instructions you want to step/skip by putting a number after the si command, for example:<br>
si 15

ni
====
Also a step instruction (next), also known as 'step over'. Using this when on a CALL instruction will execute everything that the CALL references until after the return; so it steps over it to the next instruction you see after the CALL (but still executes everything in the call). This is good for not having to debug library code or well understood functions (especially deep and wide loops)

x
====
Examine memory. This command has a lot of variety, this is how I personally approach the syntax:<br>
x /nf a<br>
Where n is the amount of bytes, f is the format, and a is the address (precede the address with a * to dereference as a pointer if you need). Formats can be things like x(hex), b(byte), s(string). Addresses should fit the 0xabcdef01 kind of format. An example could be<br>
x /4x 0x100a50<br>
Which is giving 4 hex formatted bytes starting at address 0x100a50<br>
You can use any memory address that the program has permissions to, so this can be general purpose allocated memory, anywhere in the stack, and even the addresses that the program itself is in.

cont
====
This continues the running of the program. This will keep running the program until it either finishes execution, or hits the next breakpoint

disas startaddress endaddress
====
disasembles memory data from the specified startaddress and endaddress. So if there is code in memory, this will show you what it would like like as assembly instructions. You can try it out by using addresses starting with what is in your EIP/RIP register. You likely wont need to use this command for the skeleton, but it is useful in some reverse engineering contexts

quit
====
gets us out of the program

ASM diff
=====
The approach to this program is much different than the other non-assembly programs in this project. Although we could use the assembler programs (nasm/masm/gas) many features and macros, we don't. Why? the focus for this is on assembly, not nasm, not linux/windows, and none of that HLA BS. This could be a much more clear program if I fully used HLA and all the nasm features, but it wouldn't be as useful for demonstrating actual assembly.

It should also be noted that the program won't "appear" to do much; it will just print "Hello World!" to the terminal. Too "see" the full effect of all of these opcodes, it  would be ideal to run this in a debugger (I prefer edb (Evan's Debugger) on the Linux  platform and OllyDbg on Windows).

Overall opcodes/concepts demonstrated:
* Registers
* Movement: mov, xchg
* Stack: push, pop
* Maths: add, sub, mull, div, inc, dec
* Logic: and, or, not, xor
* Memory
* Shiftiness: shl, shr, rol, ror
* Conditions: jl, jg, je, jne, jmp, cmp
* Subroutines: call, ret
* no operation at all: nop
* syscall: sys_exit, sys_write

There is arguably a lot not covered, but that isn't the purpose of this project. The above opcodes should certainly get you in the right direction; they are the most common

Linux API Calls (Meat)
=====
* open (files.asm, preadwrite.asm, fctl.asm)
* close (files.asm, preadwrite.asm, fctl.asm)
* read (files.asm)
* write (files.asm, preadwrite.asm)
* lseek (files.asm)
* pread (preadwrite.asm)
* pwrite (preadwrite.asm)
* getpid (getpid.asm)
* getppid (getpid.asm)
* time (time.asm)
* gettimeofday (time.asm)
* fctl (fctl.asm)
* brk (brk.asm)
* mkdir (mkdir.asm)
* rmdir (rmdir.asm)
* getdents (getdents.asm)
* timers (setitimer.asm)
* getpriority (nice.asm)
* setpriority (nice.asm)
* getusage (usage.asm)
* getlimit (limits.asm)
* setlimit (limits.asm)
* socketcall
** socket (sockets.asm)
** connect (sockets.asm)
* fork (fork.asm)
* waitpid (fork.asm)
* execve (fork.asm)
* exit (in all examples)
