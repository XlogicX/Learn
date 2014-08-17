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
