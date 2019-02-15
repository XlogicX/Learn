@ This program demonstrates finding characters or strings inside of another string.
@ First we use memchr to look for the 'r' characters within only the first 10
@ bytes of a string (no match). Next we use rawmemchr to search the whole string
@ for the 'r' character and we find a match. Finally we use strstr to search for
@ a small string/word within the larger string, finding a match.
@ Section in LibC Manual: 12.12.7 (Input/Output on Streams Chapter)
@ as LibC_search.s -o LibC_search.o && gcc LibC_search.o -o LibC_search

.text
.global main

main:
	push 	{ip, lr}

@ Look for the 'r' character in the first 10 characters of a string, it wont match
@------------------------------------------------------------------------------
	ldr	r0, =string	@ String to search
	mov	r1, #'r'	@ Character to search for
	mov	r2, #10		@ How many characters to search
	bl	memchr
	@ Returns pointer to first character that matched, returns 0 if no match
	@ In this case returns 0, because we don't look far enough into the string
	cmp	r0, #0
        ldrne   r0, =format1    @ Match found if not equal
        ldreq   r0, =format2    @ Match not found if equal
	bl	printf

@ Look for the 'r' character in all of the characters of the string, it will match
@------------------------------------------------------------------------------
	ldr	r0, =string	@ String to search
	mov	r1, #'r'	@ Character to search for
	bl	rawmemchr	@ like memchr, but will keep looking until a match is found
        cmp     r0, #0
        ldrne   r0, =format1    @ Match found if not equal
        ldreq   r0, =format2    @ Match not found if equal
        bl      printf


@ Look for the string 'test' in the string 'This is a test string', it will match
@------------------------------------------------------------------------------
	ldr	r0, =string	@ "haystack"
	ldr	r1, =string2	@ "needle"
	bl	strstr
   	cmp     r0, #0
        ldrne   r0, =format1    @ Match found if not equal
        ldreq   r0, =format2    @ Match not found if equal
        bl      printf


exit:
	pop 	{ip, pc}

.data
	string: .asciz "This is a test string\x0a"
	string2: .asciz "test"
	format1: .asciz "Match Found!\n"
	format2: .asciz "No Match\n"
