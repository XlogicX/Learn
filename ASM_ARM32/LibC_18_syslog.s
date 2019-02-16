@ This program demonstrates adding a log entry to Syslog by opening syslog with
@ openlog, using syslog to add the log entry, and finally closing the syslog with
@ closelog
@ Section in LibC Manual: 18.2.1, 18.2.2, and 18.2.3 (Syslog Chapter)
@ Build: as LibC_syslog.s -o LibC_syslog.o && gcc LibC_syslog.o -o LibC_syslog

.text
.global main

main:
	push 	{ip, lr}

@ Open syslog with identifier 'LOL' and pid, cons, ndelay options and the local1 facility
@------------------------------------------------------------------------------
	ldr	r0, =ident	@ Identification string for log
	mov	r1, #0xb	@ Options (pid, cons, ndelay)
	mov	r2, #0x88	@ Facilities (local1)
	bl	openlog

@ Add the message in the format string with a priority 5 (Notice)
@------------------------------------------------------------------------------
	mov	r0, #5		@ Priority (Notice)
	ldr	r1, =format	@ Log message
	bl	syslog

@ Close the log
@------------------------------------------------------------------------------
	bl	closelog

@ Let user know to grep syslog for the word 'LOL' to validate that this worked
@------------------------------------------------------------------------------
	ldr	r0, =message
	bl	printf

	bl	exit

exit:
	pop 	{ip, pc}

.data
	ident: .asciz "LOL"
	format: .asciz "This is a warning\n"
	message: .asciz "Try the following command now: 'grep LOL /var/log/syslog'\n"

@ OPTIONS
@ ----------------------------------------
@ LOG_PID = 0x1
@ LOG_CONS = 0x2
@ LOG_PERROR = 0x20
@ LOG_NDELAY = 0x8
@ LOG_ODELAY = 0x4

@ FACILITIES
@ ----------------------------------------
@ LOG_USER = 0x8
@ LOG_MAIL = 0x10
@ LOG_DAEMON = 0x18
@ LOG_AUTH = 0x20
@ LOG_SYSLOG = 0x28
@ LOG_LPR = 0x30
@ LOG_NEWS = 0x38
@ LOG_UUCP = 0x40
@ LOG_CRON = 0x48
@ LOG_AUTHPRIV = 0x50
@ LOG_FTP = 0x58
@ LOG_LOCALO = 0x80
@ LOG_LOCAL1 = 0x88
@ LOG_LOCAL2 = 0x90
@ LOG_LOCAL3 = 0x98
@ LOG_LOCAL4 = 0xa0
@ LOG_LOCAL5 = 0xa8
@ LOG_LOCAL6 = 0xb0
@ LOG_LOCAL7 = 0xb8

@ PRIORITIES
@ ----------------------------------------
@ LOG_EMERG = 0x0
@ LOG_ALERT = 0x1
@ LOG_CRIT = 0x2
@ LOG_ERR = 0x3
@ LOG_WARNING = 0x4
@ LOG_NOTICE = 0x5
@ LOG_INFO = 0x6
