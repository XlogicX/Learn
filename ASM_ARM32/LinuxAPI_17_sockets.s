@ Pull down a website and display it to the terminal
@ API calls found in this example program:
@ 	socket, connect, write, read, close, exit
@ High level description of what theis example program does:
@	Create a socket with the socket API
@	Connect to the socket with connect API
@	GET the page with the write API
@	Read a packet of the webpage with the read API
@	Write it to the screen with the write API
@	Get another packet of the webpage with the read API
@	Write it to the screen with the write API
@	Close the socket with the close() API
@	Exit with the exit API

.text
.global _start

_start:

@ Create a socket
@------------------------------------------------------------------------------
	mov 	r7, #281		@ socket()
	mov	r0, #2			@ family: PF_INET
	mov	r1, #1			@ type: SOCK_STREAM
	mov	r2, #6			@ protocol: IPPROTO_TCP
    	swi	#0
	ldr	r1, =sockhandle
	str	r0, [r1]		@ save filehandle

@ Connect to the socket
@------------------------------------------------------------------------------
	mov 	r7, #283		@ socketcall()
	ldr	r0, =sockhandle
	ldr	r0, [r0]
	ldr	r1, =sockaddr
	mov	r2, #16
 	swi	#0

@ GET the page
@------------------------------------------------------------------------------
	mov	r7, #4			@ write
	ldr	r0, =sockhandle
	ldr	r0, [r0]		@ handle for newly opened socket
	ldr	r1, =getrequest		@ location of contents to write (the GET request)
	mov	r2, #56			@ how many bytes to write
	swi	#0

@ Read bytes from the webpage
@------------------------------------------------------------------------------
	mov	r7, #3			@ read
        ldr     r0, =sockhandle
        ldr     r0, [r0]                @ contents returned by website
	ldr	r1, =sitebuffer		@ where in memory to put contents of file
	mov	r2, #1488		@ how many characters to read
	swi	#0

@ Write part of the page to stdout
@------------------------------------------------------------------------------
	mov	r7, #4			@ write
	mov	r0, #1			@ STDOUT
	ldr	r1, =sitebuffer		@ location of contents to write
	mov	r2, #1488		@ how many bytes to write
	swi	#0

@ Read bytes from the webpage
@------------------------------------------------------------------------------
        mov     r7, #3                  @ read
        ldr     r0, =sockhandle
        ldr     r0, [r0]                @ contents returned by website
        ldr     r1, =sitebuffer         @ where in memory to put contents of file
        mov     r2, #1488               @ how many characters to read
        swi     #0

@ Write part of the page to stdout
@------------------------------------------------------------------------------
        mov     r7, #4                  @ write
        mov     r0, #1                  @ STDOUT
        ldr     r1, =sitebuffer         @ location of contents to write
        mov     r2, #1488               @ how many bytes to write
        swi     #0


@ Close the socket with the close() api call.
@------------------------------------------------------------------------------
        mov     r7, #6                  @ close
        ldr     r0, =sockhandle
        ldr     r0, [r0]                @ get socket return value
        swi     #0

@ Exit
@------------------------------------------------------------------------------
	mov 	r7, #1			@ exit
	mov	r0, #0			@ null argument to exit
	swi	#0

.data
	@ socket data
	domain: .long 	2		@ PF_INET
	type: 	.long 	1		@ SOCK_STREAM
	prot: 	.long  6		@ IPPROTO_TCP

	sockhandle:	.long 0	@ This value will change to fd for socket

	@ connect data
	sockaddr:	.2byte 0x0002
	port:		.2byte 0x5000
	domain_ip:	.long 0xDD258368
	@domain 'http://xlogicx.net/'

	getrequest:	.asciz "GET / HTTP/1.1\x0aHost: xlogicx.net\x0aUser-Agent: Deez Nuts\x0a\x0a"

.bss
	.lcomm sitebuffer, 1488

@ socketcall call types
@------------------------------------------------------------------------------
@ 0 - socket_subcall
@ 1 - socket
@ 2 - bind
@ 3 - connect
@ 4 - listen
@ 5 - accept
@ 6 - getsockname
@ 7 - getpeername
@ 8 - socketpair
@ 9 - send
@ 10 - recv
@ 11 - sendto
@ 12 - recvfrom
@ 13 - shutdown
@ 14 - setsockopt
@ 15 - getsockopt
@ 16 - sendmsg
@ 17 - rcvmsg
@ 18 - accept4
@ 19 - recvmmsg

@ socket domain codes
@------------------------------------------------------------------------------
@ 0 - PF_UNSPEC
@ 1 - PF_LOCAL
@ 2 - PF_INET
@ 3 - PF_AX25
@ 4 - PF_IPX
@ 5 - PF_APPLETALK
@ 6 - PF_NETROM
@ 7 - PF_BRIDGE
@ 8 - ATMPVC
@ 9 - PF_X25
@ 10 - PF_INET6
@ 11 - PF_ROSE
@ 12 - PF_DECnet
@ 13 - PF_NETBEUI
@ 14 - PF_SECURITY
@ 15 - PF_KEY
@ ...

@ PF_INET socket type codes
@------------------------------------------------------------------------------
@ 0 - 0
@ 1 - SOCK_STREAM
@ 2 - SOCK_DGRAM
@ 3 - SOCK_RAW
@ 4 - SOCK_RDM
@ 5 - SOCK_SEQPACKET
@ 6 - SOCK_DCCP

@ PF_INET socket protocol codes
@------------------------------------------------------------------------------
@ 0 - IPPROTO_IP
@ 1 - IPPROTO_ICMP
@ 2 - IPPROTO_IGMP
@ 4 - IPPROTO_IPIP 
@ 6 - IPPROTO_TCP
@ 8 - IPPROTO_EGP
@ 12 - IPPROTO_PUP
@ 17 - IPPROTO_UDP
@ ...

@ bind socket families (similar to socket domain codes)
@------------------------------------------------------------------------------
@ 0 - AF_UNSPEC
@ 1 - AF_LOCAL
@ 2 - AF_INET
@ 3 - AF_AX25
@ ...
