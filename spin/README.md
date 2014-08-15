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
We are acheiving completely different goals than the goals of most of the other computer scripts. This language is for embedded, so goals will tend to be different.

This skeleton program works with 7 total pins of input/output. pin 0 is input, pins 16,18,19,20,22, and 23 as output.

The program starts with repeatedly turning on pin 16 (LED) with increasing brightness, until it is at a maximum brightness,and then it repeats. Sending a "high" to pin 0 (input) will go to the next output pin (18 would come after 16), when all pins are cycled through, it comes back to pin 16 as the output pin
