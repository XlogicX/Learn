@ Mostly an example of the fork API, also uses waitpid and execve for better illustration
@ API calls found in this example program:
@ 	fork, wait4, execve, write, exit
@ High level description of what theis example program does:
@       Forks
@	The parent waits for the child and prints a message when done
@	prints a message and then executes /bin/ps before returning to parent


.text
.global _start

_start:

@ Fork
@------------------------------------------------------------------------------
	mov 	r7, #2			@ fork()
    	swi	#0
	    @ Return on failure is -1
	    @ Return is 0 if child
	    @ Return is the pid of child if parent
    	cmp	r0, #0			@ Compare to child value
    	beq	child			@ Go to child process if so

parent:					@ otherwise your the parent with pid of child in eax
	@ Wait for child
	mov	r7, #114		@ wait4() (waitpid is not implemented)
	swi	#0

	@ Let STDOUT know you're the parent
	mov	r7, #4			@ write()
	mov	r0, #1			@ STDOUT
	ldr	r1, =parent_msg		@ Message for parent
	mov	r2, #11			@ Message length
	swi	#0

	@ Bail
	b	exit

child:
	@ Let STDOUT know you're the child
	mov	r7, #4			@ write()
	mov	r0, #1			@ STDOUT
	ldr	r1, =child_msg		@ Message for child
	mov	r2, #10			@ Message length
	swi	#0

	@ Execute a shell command
	mov	r7, #11			@ execve()
	ldr	r0, =command		@ command to execute
	ldr	r1, =args		@ arguments (none)
	ldr	r2, =env		@ enviornment (none)
	swi	#0

	@ Bail (but parent waiting on this)
	b	exit


@ Exit
@------------------------------------------------------------------------------
	exit:
	mov 	r7, #1			@ exit
	mov	r0, #0			@ null argument to exit
	swi	#0

.data
	child_msg: .ascii "Ima Child\x0a"
	parent_msg: .ascii "Ima Parent\x0a"
	command: .asciz "/bin/ps"
	args: .long command
	env: .long 0x00000000
