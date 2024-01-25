;  Name: Henok Tilahun
;  NSHE_ID: 5007740928
;  Section: 1002
;  Assignment: CS 218 – Assignment #2
;  Description: Practice complex RAM data types and operations 
;

; *****************************************************************
;  Static Data Declarations (initialized)

section	.data

; -----
;  Define standard constants.

NULL		equ	0			; end of string

TRUE		equ	1
FALSE		equ	0

EXIT_SUCCESS	equ	0			; Successful operation
SYS_exit	equ	60			; call code for terminate

; -----
;  Initialized Static Data Declarations.

;	Place data declarations here...

; -----

bVar1		db	37
bVar2		db	51
bAns1		db	0
bAns2		db	0
wVar1		dw	2654
wVar2		dw	1873
wAns1		dw	0
wAns2		dw	0
dVar1		dd	164126937
dVar2		dd	102512521
dVar3		dd	-15476
dAns1		dd	0
dAns2		dd	0
qVar1		dq	123456789112
flt1		dd	-15.125
flt2		dd	11.25
tao		dd	2.71828
myClass		db	"CS-218", NULL
saying		db	"May the force be with you.", NULL
myName		db	"Henok Tilahun", NULL


; ----------------------------------------------
;  Uninitialized Static Data Declarations.

section	.bss

;	Place data declarations for uninitialized data here...
;	(i.e., large arrays that are not initialized)


; *****************************************************************

section	.text
global _start
_start:


; -----
;	YOUR CODE GOES HERE...

; bVar1 + bVar2 = bAns1.
mov al, byte [bVar1]
mov bl, byte [bVar2]
add eax, ebx
mov byte [bAns1], al

; bVar1 - bVar2 = bAns1.
mov al, byte [bVar1]
mov bl, byte [bVar2]
sub eax, ebx
mov byte [bAns2], al

; wVar1 + wVar2 = wAns1.
mov ax, word [wVar1]
mov bx, word [wVar2]
add eax, ebx
mov word [wAns1], ax

; wVar1 - wVar2 = wAns2.
mov ax, word [wVar1]
mov bx, word [wVar2]
sub eax, ebx
mov word [wAns2], ax

; dVar1 + dVar2 = dAns1.
mov eax, dword [dVar1]
mov ebx, dword [dVar2]
add eax, ebx
mov dword [dAns1], eax

; dVar1 - dVar2 = dAns2.
mov eax, dword [dVar1]
mov ebx, dword [dVar2]
sub eax, ebx
mov dword [dAns2], eax









; *****************************************************************
;	Done, terminate program.

last:
	mov	rax, SYS_exit		; call call for exit (SYS_exit)
	mov	rdi, EXIT_SUCCESS	; return code of 0 (no error)
	syscall

