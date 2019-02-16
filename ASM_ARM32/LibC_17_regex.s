@ This program is a simple demo of seeing if a string matches a regular expression.
@ First the regular expression must be compiled with regcomp. After setting up all
@ of the arguemnts, we can use regexec to check to see if the compiled expression
@ matches a string.
@ Section in LibC Manual: 10.3.1, 10.3.3, and 10.3.6 (Pattern Matching Chapter)
@ Build: as LibC_regex.s -o LibC_regex.o && gcc LibC_regex.o -o LibC_regex

.text
.global main

main:
	push 	{ip, lr}

	@ Compile the regular exression
	@------------------------------------------------------------------------------
	ldr	r0, =recomp	@ Pointer to where expression will be compiled
	ldr	r1, =expression	@ A string of the regular expression to compile
	mov	r2, #1		@ Flags, in this case, REG_EXTENDED
	bl	regcomp		@ compile it

	@ Execute the regular expression; do the search for a match
	@------------------------------------------------------------------------------
	ldr	r0, =recomp	@ The now compiled expression (assuming no errors)
	ldr	r1, =string	@ The string to search

	@ Get the amount of subexpressions the pattern might match (more elegant than handcoding/guessing)
	ldr	r2, =recomp	@ Get address of compiled expression
	add	r2, #24		@ subexpression amount is offset 0x18 (24)
	ldrb 	r2, [r2]	@ Get the value
	add	r2, #1		@ Add 1 to it

	ldr	r3, =regmatches	@ Pointer to data structure for match offsets
	mov	r4, #0		@ No eflats
	push	{r4}		@ eflags value must go on stack, as we are up to our 5th arg
	bl	regexec		@ Perfrom match check
	add	sp, #4		@ Re-Adjust stack due to previous push
	cmp	r0, #0
	ldreq	r0, =format1
	ldrne	r0, =format2
	bl	printf		@ Print out whether it matched or not

	@ Free up the compiled expression
	@------------------------------------------------------------------------------
	ldr	r0, =recomp	@ Pointer to compiled expression
	bl	regfree		@ Do it

	bl	exit

exit:
	pop 	{ip, pc}

.data
	expression: .asciz "s[a-g]a"		@ Regular expression
	string: .asciz "A sentance to search"	@ String to check
	format1: .asciz "Match\n"
	format2: .asciz "No Match\n"

.bss
	.lcomm regmatches, 24	@ data structure for match offsets
	.lcomm recomp, 32	@ reserve room for compiled expression

@ - Clfags (flags for r2 before branching to regcomp)
@ REG_EXTENDED = 0x1
@ REG_ICASE = 0x2
@ REG_NOSUB = 0x8
@ REG_NEWLINE = 0x4

@ - Eflags
@ REG_NOTBOL
@ REG_NOTEOL

@ - Data structure for compiled expression
@ Offset:	Field			Description
@0x00:		*buffer			Space that holds the compiled pattern
@0x04:		allocated		Number of bytes to which `buffer' points
@0x08:		used			Number of bytes actually used in `buffer'
@0x0C:		syntax			Syntax setting with which the pattern was compiled
@0x10:		*fastmap		Pointer to a fastmap, if any, otherwise zero.  re_search uses the fastmap, if there is one, to skip over impossible starting points for matches
@0x14:		*translate		Either a translate table to apply to all characters before comparing them, or zero for no translation.  The translation is applied to a pattern when it is compiled and to a string when it is matched.
@0x18:		re_nsub			Number of subexpressions found by the compiler
@0x19:		can_be_null		Zero if this pattern cannot match the empty string, one else
@0x1A:		regs_allocated		If REGS_UNALLOCATED, allocate space in the `regs' structure for `max (RE_NREGS, re_nsub + 1)' groups. If REGS_REALLOCATE, reallocate space if necessary. If REGS_FIXED, use what's there
@0x1B:		fastmap_accurate	Set to zero when regex_compile compiles a pattern; set to one by re_compile_fastmap when it updates the fastmap, if any
@0x1C:		no_sub			If set, regexec reports only success or failure and does not return anything in pmatch
@0x1D:		not_bol			If set, a beginning-of-line anchor doesn't match at the beginning of the string
@0x1E:		not_eol			Similarly for an end-of-line anchor
@0x1F:		newline_anchor		If true, an anchor at a newline matches

@ Data structure for match offsets
@ Each subexpression takes 8 bytes. The first 4 bytes is the offset into the string
@ where the match starts, and the next 4 bytes is where it ends (or the next char).
@ If more than one subexpression is requested, additional offsets will follow
@ directly after. The amount of subexpressions possible is dependant on the
@ regular expression itself. The ammount of subexpressions that an expression may
@ find in a string can be found in offset 0x18 (24 bytes into) the compiled
@ expression data structure. Add 1 to the value found.
