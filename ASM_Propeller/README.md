Environment
=====
OS: Windows 8 (VMWare on OSX)

Editor: Propeller Tool

Hardware: Defcon 22 badge with push button soldered from power to I/O pin 0. Badge not needed, however; needs Propeller chip with LEDs on I/O pins 16, 18, 19, 20, 22, 23, and ideally a push button on I/O pin 0.

Execution: F11


Diff
=====
Printing: We are instead outputting a signal to a bank of pins (LEDs)
Take Input: We are taking a high/low value as input from a pin
Handling Files: We are not dealing with files here

Function of the program
=====
The approach to this program is much different for 2 major reasons: It's assembly AND it's for an embedded system. It should also be noted that the program won't appear to do much; it will display some LED patterns if you have LEDs hooked up to p16-23. To "see" the full effect of all of these opcodes, it would be ideal to run this in a debugger, GEAR is by far the best debugger/emulator I know for Propeller.

Overall opcodes/concepts demonstrated:

Core/"Cog" Handling: cogid, cogstop, cognew
I/O: ina, outa, dira
Movement: mov
Maths: add, sub
Logic: and, or, xor
Memory
Shiftiness: shl, shr
Conditions: jne, jmp, cmp
Subroutines: call, ret
no operation at all: nop

There is arguably a lot not covered, but that isn't the purpose of this project. The above opcodes should certainly get you in the right direction; they are the most common. Of notable difference from x86, Registers aren't exactly the same concept, There is no Stack, and if you want flags to be set, you have to explicity code for this.