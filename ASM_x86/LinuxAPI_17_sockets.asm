; Pull down a website and display it to the terminal
; API calls found in this example program:
; 	socketcall(socket,connect), write, read, close, exit
; High level description of what theis example program does:
;       Create a socket with the socket part of socketcall API
;       Connect to the socket with connect part of socketcall API
;       GET the page with the write API
;       Read the webpage with the read API
;       Write it to the screen with the write API
;       Close the socket with the close() API
;       Exit with the exit API


section .text
global _start

_start:

; Create a socket
;------------------------------------------------------------------------------
	mov 	eax, 102			; socketcall()
	mov		ebx, 1				; socket
	mov		ecx, domain			; data structure for arguments to socketcall
    int    	0x80
	mov		[sockhandle], eax	; save filehandle    

; Connect to the socket
;------------------------------------------------------------------------------
	mov 	eax, 102			; socketcall()
	mov		ebx, 3				; connect
	mov		ecx, sockhandle		; data structure for arguments to socketcall
    int    	0x80 

; GET the page
;------------------------------------------------------------------------------
	mov		eax, 4				; write
	mov		ebx, [sockhandle]	; handle for newly opened socket
	mov		ecx, getrequest		; location of contents to write (the GET request)
	mov		edx, 60				; how many bytes to write
	int		0x80

; Read bytes from the webpage
;------------------------------------------------------------------------------
	mov		eax, 3				; read
	mov		ebx, [sockhandle]	; contents returned by website
	mov		ecx, sitebuffer		; where in memory to put contents of file
	mov		edx, 10000			; how many characters to read
	int		0x80

; Close the socket with the close() api call.
;------------------------------------------------------------------------------
	mov		eax, 6				; close
	mov		ebx, [sockhandle]	; get socket return value
	int		0x80

; Write part of the page to stdout
;------------------------------------------------------------------------------
	mov		eax, 4				; write
	mov		ebx, 1				; STDOUT
	mov		ecx, sitebuffer		; location of contents to write
	mov		edx, 10000			; how many bytes to write
	int		0x80

; Exit
;------------------------------------------------------------------------------
	mov 	eax, 1				; exit
	mov		ebx, 0				; null argument to exit
	int 	0x80

section .data
	;socket data
	domain 	dd 	2		;PF_INET
	type 	dd 	1		;SOCK_STREAM
	prot 	dd  6		;IPPROTO_TCP

	;connect data
	sockhandle 	dd 0	; This value will change to fd for socket
	sockaddr 	dd sock_family
	adrlen		dd 16

	sock_family		dw 2			; AF_INET
	port			dw 20480		; Port 80 (little endian bullshit)
	domain_address	dd 3710223208	; 104.131.37.221 (xlogicx.net), more little endian bullshit
	;domain_address	db 'http://xlogicx.net/'
	;104
	;131 - 33,536
	;37 - 2,424,832
	;221 - 3,707,764,736
	;3710223208

	getrequest	db 'GET / HTTP/1.1', 0x0d,0x0a, 'Host: xlogicx.net', 0x0d,0x0a, 'User-Agent: Deez Nuts', 0x0d,0x0a, 0x0d,0x0a

section .bss
	sitebuffer resb 10000

; socketcall call types
;------------------------------------------------------------------------------
; 0 - socket_subcall
; 1 - socket
; 2 - bind
; 3 - connect
; 4 - listen
; 5 - accept
; 6 - getsockname
; 7 - getpeername
; 8 - socketpair
; 9 - send
; 10 - recv
; 11 - sendto
; 12 - recvfrom
; 13 - shutdown
; 14 - setsockopt
; 15 - getsockopt
; 16 - sendmsg
; 17 - rcvmsg
; 18 - accept4
; 19 - recvmmsg

; socket domain codes
;------------------------------------------------------------------------------
; 0 - PF_UNSPEC
; 1 - PF_LOCAL
; 2 - PF_INET
; 3 - PF_AX25
; 4 - PF_IPX
; 5 - PF_APPLETALK
; 6 - PF_NETROM
; 7 - PF_BRIDGE
; 8 - ATMPVC
; 9 - PF_X25
; 10 - PF_INET6
; 11 - PF_ROSE
; 12 - PF_DECnet
; 13 - PF_NETBEUI
; 14 - PF_SECURITY
; 15 - PF_KEY
; ...

; PF_INET socket type codes
;------------------------------------------------------------------------------
; 0 - 0
; 1 - SOCK_STREAM
; 2 - SOCK_DGRAM
; 3 - SOCK_RAW
; 4 - SOCK_RDM
; 5 - SOCK_SEQPACKET
; 6 - SOCK_DCCP

; PF_INET socket protocol codes
;------------------------------------------------------------------------------
; 0 - IPPROTO_IP
; 1 - IPPROTO_ICMP
; 2 - IPPROTO_IGMP
; 4 - IPPROTO_IPIP 
; 6 - IPPROTO_TCP
; 8 - IPPROTO_EGP
; 12 - IPPROTO_PUP
; 17 - IPPROTO_UDP
; ...

; bind socket families (similar to socket domain codes)
;------------------------------------------------------------------------------
; 0 - AF_UNSPEC
; 1 - AF_LOCAL
; 2 - AF_INET
; 3 - AF_AX25
