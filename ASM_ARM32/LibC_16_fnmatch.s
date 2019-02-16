@ The fnmatch function does wildcard searching. You provide the pattern string to search
@ as the first argument, and the string being searched as the 2nd argument. You can optionally
@ have a 3rd argument for options (like case insensitivity and such). By default, the patterns
@ can use wildcards.
@ Section in LibC Manual: 10.1 (Pattern Matching Chapter)
@ Build: as LibC_fnmatch.s -o LibC_fnmatch.o && gcc LibC_fnmatch.o -o LibC_fnmatch

.text
.global main

main:
	push 	{ip, lr}

@ See if "A s*rch" matches "A simple string to search" (it does)
@------------------------------------------------------------------------------
	ldr	r0, =pattern	@ Pattern with wildcard
	ldr	r1, =string	@ String to search
	mov	r2, #0		@ No options
	bl	fnmatch		@ 'A s*rch' should match the string
	ldreq	r0, =match	@ Loads the matching phrase to print
	ldrne	r0, =nomatch	@ This is not executed
	bl	printf		@ Print that this matches

@ See if "B s*rch" matches "A simple string to search" (it does not)
@------------------------------------------------------------------------------
	ldr	r0, =pattern2	@ Use our other pattern on the same string
	ldr	r1, =string
	mov	r2, #0
	bl	fnmatch		@ 'B s*rch' shouldn't match the string
        ldreq   r0, =match	@ Not executed
        ldrne   r0, =nomatch	@ Loads the nonmatching phrase to print
        bl      printf		@ Print that this is no match

	bl	exit

exit:
	pop 	{ip, pc}

.data
	pattern: .asciz "A s*rch"
	pattern2: .asciz "B s*rch"
	string: .asciz "A simple string to search"
	match: .asciz "Match\n"
	nomatch: .asciz "No Match\n"
