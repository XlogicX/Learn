@ This program demonstrates the use of local time. We first use the gettimeofday LinuxAPI
@ call to get the current epoch formatted time, then we use that value into the localtime
@ call to get a broken down version. After we have this, it's just a matter of printing
@ the results
@ Section in LibC Manual: 21.4.3 (Date and Time Chapter)
@ Build: as LibC_localtime.s -o LibC_localtime.o && gcc LibC_localtime.o -o LibC_localtime

.text
.global main

main:
        push {ip, lr}

@ Get the Epoch Time with microseconds and get broken down version with localtime
@------------------------------------------------------------------------------
	mov 	r7, #78		@gettimeofday
	ldr	r0, =timeval	@timeval
    	mov	r1, #0		@timezone, legacy argument, setting to null
    	swi	#0
	ldr	r0, =timeval
	bl	localtime	@ Get broken down time values with epoch timestamp as input

@ Procede to parse and shove those values as arguments to printf to display
@------------------------------------------------------------------------------
	mov	r5, r0		@ Get Address of broken down time
	ldr	r0, =aformat
	ldr	r1, [r5]	@ seconds
	add	r5, #4
	ldr	r2, [r5]	@ minutes
	add	r5, #4
	ldr	r3, [r5]	@ hours
	add	r5, #4
	ldr	r4, [r5]
	push	{r4}		@ days
	add	r5, #4
	ldr	r4, [r5]
	push	{r4}		@ months
        add     r5, #4
        ldr     r4, [r5]
	add	r4, #1888
	add	r4, #12
        push    {r4}            @ year
        add     r5, #4
        ldr     r4, [r5]
        push    {r4}            @ weekday
        add     r5, #4
        ldr     r4, [r5]
        push    {r4}            @ yearday
	bl	printf


@ Exit
@------------------------------------------------------------------------------
	add	sp, #20		@ Adjust the stack back to normal
        pop {ip, pc}

.data
	hformat: .asciz "Address: %x\n"
	aformat: .asciz "%i Seconds, %i Minutes, %i Hours, %i DayInYear, DayOfWeek: %i, Year: %i, Month: %i, DayOfMonth: %i\n"

.bss
	.lcomm timeval, 8	@to keep track of where the heap started in the beginning
				@ The first 4 bytes is the epoch time in seconds
				@ The next 4 bytes is the remaining useconds
