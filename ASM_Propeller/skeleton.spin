'These are comment lines before the actual spin program stuff
'.spin files are divided into sections (from variables, to imports, the program, and data), they are segmented

{
  This is a 'block' comment area
}
CON
        _clkmode = xtal1 + pll16x  'Standard clock mode * crystal frequency = 80 MHz
        _xinfreq = 5_000_000       '5 MHZ crystal very standard

VAR

  long  value1
  long  value2
   
OBJ
  'This is where we would import other 'modules'
  
PUB LoadCog

  value1 := %00000000_10101010_00000000_00000000
  value2 := %00000000_01010101_00000000_00000000

  'We are passing two arguments to cognew, the address in DAT of the asm code, and the address of value1.
  'value2 so happens to follow value1 in memory, we end up using this 'feature'
  cognew(@ASMSkel, @value1)         ' start the decoder cog

DAT
              org       0

{Get parameters, this is some pointer shit, a 3-step process
        1. Put start memory address in all variables
        2. Use add op to offset these addresses accordingly
        3. Move the values from the addresses to actual variables}
ASMSkel       mov       v1_addr, par                 'Get address of first parameter passed to asm                              
              mov       v2_addr, par                 'Same value
              add       v2_addr, #4                  'Point address of v2 to the next value (add 4 with immediate addressing mode)
              rdlong    v1, v1_addr                  'Get the value from memory address
              rdlong    v2, v2_addr                  'Get value from memory address

              mov       dira, iomask            'set up I/O values to match LEDs on DefCon22 badge

              'Wait for button press before starting routines
Button_Wait   mov       input, ina              'get I/O
              'Bitwise AND
              and       input, #1               'mask this with the only bit [0] we care about
              cmp       input, #1   wz          'compare with on '1'
        if_nz jmp       #Button_Wait            'if it's not on, keep checking

              'Addition                    
              add       v1, v2                  '00000000_10101010_00000000_00000000
                                                '00000000_01010101_00000000_00000000 +
                                                '00000000_11111111_00000000_00000000 
              mov       outa, v1                'Output ALL LEDs on

              'Subroutine Example (to pausing routine)
              call      #Pause

              'Subtraction
              sub       v1, bitstring1
              mov       outa, v1
              call      #Pause

              'Bitwise OR
              or        v1, v2                  '00000000_11110000_00000000_00000000
                                                '00000000_01010101_00000000_00000000 OR
                                                '00000000_11110101_00000000_00000000 
              mov       outa, v1
              call      #Pause

              'Bitwise XOR
              xor       v1, v2                  '00000000_11110101_00000000_00000000
                                                '00000000_01010101_00000000_00000000 XOR
                                                '00000000_10100000_00000000_00000000  
              mov       outa, v1
              call      #Pause


        'Begin Shiftiness. This starts with 2 LEDs on the 'right' and shifts them 1 at a time
        'to the left 7 times. We then return to the right using the shr opcode
              mov       v1, bitstring2
              mov       outa, v1
              call      #fPause
              shl       v1, #1
              mov       outa, v1
              call      #fPause              
              shl       v1, #1
              mov       outa, v1
              call      #fPause
              shl       v1, #1
              mov       outa, v1
              call      #fPause
              shl       v1, #1
              mov       outa, v1
              call      #fPause
              shl       v1, #1
              mov       outa, v1
              call      #fPause
              shl       v1, #1
              mov       outa, v1
              call      #fPause                                                        
              shl       v1, #1
              mov       outa, v1
              call      #fPause              
              shr       v1, #1
              mov       outa, v1
              call      #fPause
              shr       v1, #1
              mov       outa, v1
              call      #fPause
              shr       v1, #1
              mov       outa, v1
              call      #fPause
              shr       v1, #1
              mov       outa, v1
              call      #fPause
              shr       v1, #1
              mov       outa, v1
              call      #fPause
              shr       v1, #1
              mov       outa, v1
              call      #fPause
              shr       v1, #1
              mov       outa, v1
              call      #fPause              

              'Display nothing and stop the cog
              mov       outa, #0
              cogid     whoami
              cogstop   whoami

'Delaying subroutine
Pause         mov       clock, cnt
              add       clock, delay
              waitcnt   clock, #0
Pause_ret     ret

'Delaying subroutine
fPause        mov       clock, cnt
              add       clock, fdelay
              waitcnt   clock, #0
fPause_ret    ret                                         

v1_addr       long  0                           'variable to store a memory address (pointer)
v2_addr       long  0                           'variable to store a memory address (pointer)
v1            long  0                           'general variable
v2            long  0                           'another general variable

iomask        long  %00000000_11111111_00000000_00000000      'Available LEDs on my Defcon22 badge
bitstring1    long  %00000000_11110000_00000000_00000000
bitstring2    long  %00000000_00000011_00000000_00000000
clock         long  0
delay         long  $08000000
fdelay        long  $02000000
input         byte  0
whoami        long  0