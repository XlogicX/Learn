; MURDER-SUICIDE
;Example of killing a process with the kill API. API calls found in this example program:
; 	kill
; Go back in time and identify parent (using ppid API)
; Murder parent, effectively killing current-time self:
;	Murder Suicide

section .text
global _start

_start:

; Get Parent Process ID
;------------------------------------------------------------------------------
	mov		eax, 64		; get the Parent Process ID of self getppid()
	int		0x80
	mov		[ppid], eax	; make note of Parent process ID

; Kill Parent
;------------------------------------------------------------------------------
	mov 	eax, 37			; kill
    mov 	ebx, [ppid]		; Parent's process ID (Could be bash, could be gdb)
    mov		ecx, 9			; kill -9
    int    	0x80

section .bss
	ppid resb 4

; Some misc notes on return value from kill API call
;------------------------------------------------------------------------------
; You can set the sig field (in ecx) to 0, which doesn't do any killing at all
; 	but it does offer some good recon about the process with the following
;	return codes:
; If response is -3 (ESRCH), the process doesn't exist
;	This is a hacky way of seeing if a process ID exists or notes
; If response is -1 (EPERM), you don't have permissions to kill the process
;	But it does confirm that the process exists
; If response is 0 (no error), not only does the process exist, but you can kill it