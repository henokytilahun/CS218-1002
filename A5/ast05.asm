;  Name: Henok Tilahun
;  NSHE_ID: 5007740928
;  Section: 1002
;  Assignment: CS 218 – Assignment #5
;  Description: Practice push and pop operations 
;

; *****************************************************************
;  Static Data Declarations (initialized)

section	.data
 

; -----
;  Define constants.

NULL		equ	0			; end of string

TRUE		equ	1
FALSE		equ	0

EXIT_SUCCESS	equ	0			; successful operation
SYS_exit	equ	60			; call code for terminate

; -----
;  Data Set

bases		db	 148,  194,  162,  163,  118 
		db	 161,  145,  152,  129,  165 
		db	 112,  100,  185,  163,  125 
		db	 176,  147,  155,  110,  113 
		db	 108,  145,  161,  164,  165 
		db	 177,  120,  156,  147,  161 
		db	 152,  119,  165,  161,  131 
		db	 165,  114,  123,  115,  114 
		db	 101,  171,  111

slants		dw	 233,  214,  223,  211,  234 
		dw	 212,  200,  285,  263,  205 
		dw	 264,  213,  224,  213,  265 
		dw	 244,  212,  213,  212,  223 
		dw	 265,  264,  273,  216,  234 
		dw	 253,  213,  243,  213,  235 
		dw	 244,  169,  234,  233,  232 
		dw	 234,  223,  215,  214,  201 
		dw	 222,  242,  233

heights		dd	 245,  234,  223,  223,  223 
		dd	 253,  253,  243,  253,  235 
		dd	 234,  234,  256,  264,  242 
		dd	 253,  253,  284,  242,  234 
		dd	 245,  234,  223,  223,  223 
		dd	 234,  234,  256,  264,  242 
		dd	 253,  253,  284,  242,  234 
		dd	 256,  264,  242,  234,  201 
		dd	 201,  223,  272

length		dd	43

laMin		dd	0
laEstMed	dd	0
laMax		dd	0
laSum		dd	0
laAve		dd	0

taMin		dd	0
taEstMed	dd	0
taMax		dd	0
taSum		dd	0
taAve		dd	0

vMin		dd	0
vEstMed		dd	0
vMax		dd	0
vSum		dd	0
vAve		dd	0

; -----
; Additional variables

ddTwo		dd	2
ddThree		dd	3

; --------------------------------------------------------------
; Uninitialized data

section	.bss

lateralAreas	resd	43
totalAreas	resd	43
volumes		resd	43

; *****************************************************************

section	.text
global _start
_start:


; -----
;	YOUR CODE GOES HERE...

mov ecx, dword [length]
mov rsi, 0

findCalc: ;Does the lateralAreas, totalAreas, and volumes calculations
    ;lateralAreas[n] = 2 × bases[n] × slants[n]
    movzx r8d, byte [bases + rsi * 1] ;base[i]
    movzx r9d, word [slants + rsi * 2] ;slant[i]
    mov eax, r8d
    mul dword [ddTwo] ;base[i] * 2
    mul r9d  ;ans * slant[i]
    mov dword [lateralAreas + rsi * 4], eax
    
    ;totalAreas[n] = bases[n] × (2 × slants[n] + bases[n])
    movzx r8d, word [slants + rsi * 2] ;slant[i]
    movzx r9d, byte [bases + rsi * 1] ;base[i]
    mov eax, r8d
    mul dword [ddTwo]   ;2 * slant[i]
    add eax, r9d   ;(2 * slant[i]) + base[i]
    mul r9d ;ans * base[i]
    mov dword [totalAreas + rsi * 4], eax

    ;volumes[n] = ((bases[n] × bases[n]) × heights[n]) / 3
    movzx r8d, byte [bases + rsi * 1] ;base[i]
    movzx r9d, byte [bases + rsi * 1] ;base[i]
    mov eax, r8d
    mul r9d ;base[i] * base[i]
    mov r8d, dword [heights + rsi * 4] ;height[i]
    mul r8d ;ans * height[i]
    mov edx, 0
    div dword [ddThree] ;ans / 3
    mov dword [volumes + rsi * 4], eax

    inc rsi ;incrementation
    cmp rsi, rcx
    jne findCalc

    ; Lateral Area Calculations!!!!!!!!!!!!!!!!!
    




; *****************************************************************
;	Done, terminate program.

last:
	mov	rax, SYS_exit		; call call for exit (SYS_exit)
	mov	rdi, EXIT_SUCCESS	; return code of 0 (no error)
	syscall

