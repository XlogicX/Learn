Environment
=====
OS: Raspbian armv6-stretch in QEMU on Ubuntu<br>
Raspbian Stretch on Raspberry Pi 1/2/3

Editor: nano

Assembler: as

Linker: ld (or gcc if using libc functions)

Commands to assemble and link:<br> 
as skeleton.s -o skeleton.o<br>
ld skeleton.o -o skeleton<br>
(gcc skeleton.o -o skeleton) - for demo programs with libc functions

Execution: ./skeleton

Debugger (USE THIS when learning): gdb (with custom .gdbinits):<br>
GEF: https://github.com/hugsy/gef - This one is great but fucks up on subroutines for below GDB 8.1 (so Raspbian is affected by this)<br>
reverse.put.as: https://github.com/gdbinit/Gdbinit - Doesn't fuck up on subs, but less features and details as GEF, must edit a line to enable ARM and you may have to comment out a couple of lines that cause errors.<br>

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

Some (53) LibC Functions (Meat)
=====
* LibC_01_printf.s
  * printf
* LibC_02_error.s
  * strerror
* LibC_03_malloc.s
  * malloc
  * free
  * realloc
  * memset
* LibC_04_mem.s
  * memcpy
  * memcmp
* LibC_05_chars.s
  * isalnum
  * isalpha
  * isascii
  * isblank
  * iscntrl
  * isdigit
  * isgraph
  * isprint
  * ispunct
  * isspace
  * isupper
  * tolower
  * toupper
* LibC_06_strings.s
  * strlen
  * strcpy
  * strcat
  * strcmp
  * strcasecmp
* LibC_07_search.s
  * memchr
  * rawmemchr
  * strstr
* LibC_08_lfind.s
  * strncmp
  * lfind
* LibC_09_qsort.s
  * qsort
* LibC_10_getchar.s
  * getchar
  * putchar
* LibC_11_gets.s
  * gets
  * puts
* LibC_12_scanf.s
  * scanf
* LibC_13_getpass.s
  * getpass
* LibC_14_basename.s
  * basename
  * dirname
* LibC_15_stringtrash.s
  * strfry
  * memfrob
* LibC_16_fnmatch.s
  * fnmatch
* LibC_17_regex.s
  * regcomp
  * regexec
  * regfree
* LibC_18_syslog.s
  * openlog
  * syslog
  * closelog
* LibC_19_random.s
  * rand
  * srand
* LibC_20_localtime.s
  * localtime
* LibC_21_crypt.s
  * crypt.s

Next Steps
=====
Stepping through the skeleton with an understand for each instruction will have you nearly 90% up to speed on assembly and how it works, though, this is just a small part of the whole instruction set (though it's the most common and useful). This skeleton only covers some of the conditional jumps, some of the different ways of addressing memory, etc... Though, I would still stress that you'd be up to speed on understanding most assembly you'd come across. The first question I would be asked is something like: 'If this is all there is too it, why can't I write anything useful; a program that does anything real, like process a file or connect to the internet'. Only a small part of this would entail learning more assembly, the massive majority would be reaching beyond the language. Below are some recommended next steps

Read a Book
====
Stepping through the assembled skeleton in a debugger with a full undertanding may only take about 1 to 2 hours. It's a nice way to cut to the chase and bypass a book. I also beleive that most books on assembly take the wrong approach to teaching (they either wait 100's of pages until getting practical (most of the books), or sacrifice low level concepts for immediate practicality (i.e. The Art of Assembly)). That said, after running through the skeleton, you will have gotten your hands very dirty. With that behind you, pretty mich any good book on assembly is going to make way more sense, and you can expiriment with all the pre-practical theory before the book puts it into practice. You could try skipping the step of reading a book and go to the next steps below, you honestly might not need a book and could just rely on a search engine for small questions that come up along the way. But if the next steps are a struggle, then a book is a good option.

Learn the Linux API
====
These assembly examples are Linux centered, but if you were expirimenting with a different OS, they have their own APIs you could learn instead. There's a good No Starch Press book on the Linux API, it's thick, but a great reference. Of the different Assembly flavors in this repo, the x86 one has some good Linux API examples. Note that x64 could have some differences, such as how arguments are passed to the API (stack centered instead of register), but the other concepts remain consistent.

There are enough Linux API functions out there to allow you to do virtually anything you may want to do in a program, albiet with a little effort for some things, but the power to communicate with the 'outside' is now in your hands (like files and sockets). Though there are many API functions, the examples on this repo list some of the really useful ones (my subjective opinion).

LibC
====
Learn to use C libraries from your assembly program. I also have some stripped down examples of some common/useful C library calls in this repo, they are unfortunately only in the ARM flavor in this project, but with a small effort, you could convert to x86 flavors. The major differences are using gcc (instead of nasm), and main (instead of _start). Otherwise, the structure is similar: you load the arguments up to registers/stack, and call/branch/int to the function (call printf).
