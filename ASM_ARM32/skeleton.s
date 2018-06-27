.data
message: .asciz "Hello World!\n"

.text
.global _start

_start:
/* Movment */
mov r0, #55

/* Stack */
push {r0}
pop {r1}

/* Math */
add r1, #3
sub r0, #53
mul r2, r0, r1
/* Unsupported */
// udiv r3, r2, r0

/* Logic */
mov r0, #0x55
and r1, r0, #0xAA
orr r1,r0, #0xAA
eor r1, r0, #0x33
neg r1, r1

/* Shifts and Rotates */
mov r0, #0xf000000f
lsr r1, r0, #4
lsl r1, r0, #4
ror r1, r0, #4
ror r1, r0, #28

/* Contidtionals and Branching */
mov r0, #0
repeating:
	cmp r0, #10
	beq last
	add r0, r0, #1
	b repeating
last:

bl hello	//Like a CALL for x86 peoples
nop		//don't do anything, for no real reason
ldr r0, message_addr	//get address of 'hello world' buffer into r0
str r2, [r0]			//replace the starting 4-byte memory cell of hello world with what's in r2 (still 14/0x0E)

mov r7, #1	//1 - Exit
svc #0

/* Memory and Linux API */
hello:
mov r0, #1		//stdout
ldr r1, message_addr	//pointer to string buffer
mov r2, #14		//Amount of characters including newline and nullbyte
mov r7, #4		//4 - Write
svc #0
bx lr			//Like RET for x86 peoples

/* Pointer */
message_addr: .word message
