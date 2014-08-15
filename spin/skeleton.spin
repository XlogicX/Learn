'These are comment lines before the actual spin program stuff
'.spin files are divided into sections (from variables, to imports, the program, and data), they are segmented

{
  This is a 'block' comment area

  Function of Program:
  This skeleton program works with 7 total pins of input/output. pin 0 is input,
  pins 16,18,19,20,22, and 23 as output

  The program starts with repeatedly turning on pin 16 (LED) with increasing brightness,
  until it is at a maximum brightness,and then it repeats sending a "high" to pin 0 (input)
  will go to the next output pin (18 would come after 16), when all pins are cycled through,
  it comes back to pin 16 as the output pin

}
CON
        _clkmode = xtal1 + pll16x  'Standard clock mode * crystal frequency = 80 MHz
        _xinfreq = 5_000_000       '5 MHZ crystal very standard

VAR
  'byte = 8 bits, word = 16 bits, long = 32 bits
  word  bright_start            'What brightness to start the LED at
  long  PulseWidth              'Variable for holding timing for 'high' value in PWM
  long  Cycle_time              'Frequency of PWM
  long  period                  'Helper variable for frequency
  byte  current_pin             'index for pins array (in DAT section)
   
OBJ
  'This is where we would import other 'modules'
  
PUB Dimmer

current_pin := 0                             'initialize index to first pin (p16) 

  repeat                                     'start an infinite loop
    if ina[0] == 1 and current_pin < 6       'if input pin is 'high' and we haven't reached end of outputs
      current_pin++                          'increment to the next output
    if current_pin > 5                       'if we went past our output range
      current_pin := 0                       'go back to the first pin of output (p16)
    outa[pins[current_pin]] := 0             'initially turn pin off
    bright_start := 5                        'set brightness to 5 (very dim)
    repeat while bright_start < 20000        'loop to increment brightness by 25 until maximum of 20,000
      PWM(bright_start, pins[current_pin])    'start our PWM routine (PWM)             
      bright_start += 25                     'increment our brightness

PRI PWM (brightness, pin) 
  dira[pin]~~                                           'set output line
  ctra[30..26]:=%00100                                  'run PWM mode
  ctra[5..0]:=pin                                       'Set the "A pin" of this cog  
  frqa:=1                                               'Set this counter's frqa value to 1 
  PulseWidth:=-brightness                               'Start with provided brightness 
  Cycle_time:=clkfreq/1000                              'Set the time for the pulse width to 1 ms
  period:=cnt                                           'Store the current value of the counter
  repeat 3                                              'PWM routine.
    phsa:=PulseWidth                                    'Send a high pulse for PulseWidth counts
    period:=period + Cycle_time                         'Calculate cycle time
    waitcnt(period)                                     'Wait for the cycle time

DAT
'most flexible way to initialize an array preloaded with all values. Otherwise, declare as VAR and assign 1 value at a time
pins long 16,18,19,20,22,23     'skip pins 17 and 21 