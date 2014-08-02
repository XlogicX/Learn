Learn
=====

Learn the very basics of different languages, currently 8 different languages:
* perl
* python
* ruby
* lua
* javascript
* php
* bash
* C
* Assembly (nasm/ld/linux[elf64] stack)
* Assembly (nasm/ld/linux[elf32] stack)

Description
=====
With enough knowledge/experience in one or more scripting/programming languages, I start finding it to be a waste of time reading a 500+ page book to learn a new language. There are only a few essential things I really want to know in order to get quickly started, the rest I can usually google. Sometimes I just feel like asking "Just tell me how to print and do a while loop and I'll be on my way."

This project is an attempt to make a skeleton for a few languages as a point of reference to the most commonly used programming/scripting concepts (subjective declaration). If you want to master the language, maybe a few 500+ page books is the best option; this project is for quick and dirty hacks in a language you probably wont use much. Looking over my own code, I do notice that 80%-90% of it are the common basics that can be found in these skeletons. If something more specific needs to be done, there is web-documentation for most languages, and search engine on the web.

Most of these will be somewhat sparse on comments for readability, with exception to the perl script. This script is heavily littered with comments. If you have very little scripting/programming experience, look at this one first; as it explains each part at a very granular level.

Below are my "challenges" for each language:
=====
Note that depending on the language, certain things may have to be done differently. For example, file IO with javascript (maybe use textboxes instead), or flow control in assembly (if/then/else if functionality is possible, it just looks a lot "different").<br><br>
* comments<br>
* printing (along with concatenation and variable interpolation)<br>
* take input<br>
* how to math<br>
* variables and arrays<br>
* logic/comparisons<br>
* loops<br>
* subroutines<br>
* handling files<br>


Here is a small list of useful things, but not something I would consider essential for a skeleton:<br>
* modules (importing external code)<br>
* regex<br>
* hashes<br>

Script/Program Operation
=====
* Prints a welcome statement
* Takes user input for file name
* Opens the file and
* ---Counts the lines
* ---Stores character count of each line in an array
* ---Notes the last line
* Close file
* Prints out the last line
* Loop through the character count array and get total chars for file
* Print how many lines and characters the file had
* Prompt user for another line to add to the file (has to be less than 30 characters)
* ---Use subroutine/function to validate that the line is less than 30 characters
* Write this user supplied line to the file (append)

Some Notes on the Differences in the Assembly Examples
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
* randomness: rdrand
* no operation at all: nop
* syscall: sys_exit, sys_write

There is arguably a lot not covered, but that isn't the purpose of this project. The above opcodes should certainly get you in the right direction; they are the most common
