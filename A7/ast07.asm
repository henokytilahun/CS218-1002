; *****************************************************************
;  Name: Henok Tilahun
;  NSHE_ID: 5007740928
;  Section: 1002
;  Assignment: 7
;  Description: This program will sort an array of integers using the Comb sort algorithm.

; =====================================================================
;  Macro to convert integer to nonary value in ASCII format.
;  Reads <integer>, converts to ASCII/nonary string including
;	NULL into <string>

;  Note, the macro is calling using RSI, so the macro itself should
;	 NOT use the RSI register until is saved elsewhere.

;  Arguments:
;	%1 -> <integer-variable>, value
;	%2 -> <string-address>, string address
;	%3 -> <string-length-value>, string length

;  Macro usgae
;	int2aNonary	<integer-variable>, <string-address>, <string-length>

;  Example usage:
;	int2aNonary	dword [volumes+rsi*4], tempString, STR_LENGTH


;	YOUR CODE GOES HERE

%macro int2aNonary 3
mov eax, %1
mov rcx, 0
mov ebx, 9

%%divideLoop:
    mov edx, 0
    div ebx

    push rdx
    inc rcx

    cmp eax, 0

    jne %%divideLoop

    mov rbx, %2
    mov rdi, 0

%%popLoop:
    pop rax

    add eax, "0"

    mov dword [rbx+rdi*4], eax
    inc rdi
    loop %%popLoop
    mov dword [rbx + rdi*4], NULL

%endmacro

;	Note:  UPDATE ALGORITHM TO ADD "-" for values <0



; =====================================================================
;  Simple macro to display a string to the console.
;	Call:	printString  <stringAddr>

;	Arguments:
;		%1 -> <stringAddr>, string address

;  Count characters (excluding NULL).
;  Display string starting at address <stringAddr>

%macro	printString	1
	push	rax			; save altered registers
	push	rdi
	push	rsi
	push	rdx
	push	rcx

	mov	rdx, 0
	mov	rdi, %1
%%countLoop:
	cmp	byte [rdi], NULL
	je	%%countLoopDone
	inc	rdi
	inc	rdx
	jmp	%%countLoop
%%countLoopDone:

	mov	rax, SYS_write		; system call for write (SYS_write)
	mov	rdi, STDOUT		; standard output
	mov	rsi, %1			; address of the string
	syscall				; call the kernel

	pop	rcx			; restore registers to original values
	pop	rdx
	pop	rsi
	pop	rdi
	pop	rax
%endmacro

; =====================================================================

section	.data

; -----
;  Define constants.

TRUE		equ	1
FALSE		equ	0

EXIT_SUCCESS	equ	0			; Successful operation

STDIN		equ	0			; standard input
STDOUT		equ	1			; standard output
STDERR		equ	2			; standard error

SYS_read	equ	0			; system call code for read
SYS_write	equ	1			; system call code for write
SYS_open	equ	2			; system call code for file open
SYS_close	equ	3			; system call code for file close
SYS_fork	equ	57			; system call code for fork
SYS_exit	equ	60			; system call code for terminate
SYS_creat	equ	85			; system call code for file open/create
SYS_time	equ	201			; system call code for get time

LF		equ	10
NULL		equ	0
ESC		equ	27

;  Program specfic constants

MAX_STR_LENGTH	equ	15

; -----
;  Provided data

array		dd	  147,  1123,  2245,  4440,   165
		dd	  -69,  -126,   571,   147,  -228
		dd	   27,    90,   177,   -75,    14
		dd	  181,   -25,    15,   -22,  1217
		dd	 -127,    64,   140,   172,    24
		dd	 2161,  -134,   151,   -32,   -12
		dd	 1113,  1232,  2146,  3376,  5120
		dd	 2356,  3164, 34565,  -3155, 23157
		dd	 1001,   128,   -33,   105,  8327
		dd	 -101,   115,   108,  1233,  2115
		dd	 1227,  1226,  5129,   117,  -107
		dd	  105,  -109,   730,   150,  3414
		dd	 1107,  6103, -1245,  6440,   465
		dd	-2311,   254,  4528,   913, -6722
		dd	 1149,  2126,  5671, -4647,  4628
		dd	 -327,  2390,   177,  8275,  5614
		dd	 3121,   415,   615,    22,  7217
		dd	 1221,    34, -6151,  -432,  -114
		dd	 -629,   114,   522,  2413,  -131
		dd	 5639,  -126,   -62,   -41,   127
		dd	 2101,   133,   133,    50,  4532
		dd	 1219,  3116,   -62,   -17,   127
		dd	 6787,  4569,    79,  5675,   -14
		dd	 7881,  8320,  3467,  4559,  1190
		dd	 -186,   134, -1125,  5675,  3476
		dd	 2137,  2113,  1647,   114,    15
		dd	 6571,  7624,   128,  -113, -3112
		dd	 1121,   320,  4540,  5679,  1190
		dd	 9125,  -116,  -192,   117,  -127
		dd	 5677,   101,  3727,  -125,  3184
		dd	-1104,   124,  -112,   143,   176
		dd	 7534, -2126,  6112,  -156,  1103
		dd	 6759,  6326,  2171,   147,  5628
		dd	 7527,  7569, -3177,  6785, -3514
		dd	-1156,  -164,  4165,  -155,  5156
		dd	 5634,  7526,  3413,  7686,  7563
		dd	 2147,  -113,  -143,   140,  -165
		dd	 5721,  5615,  4568,  7813,  1231
		dd	-5527,  6364,  -330,  -172,   -24
		dd	 7525,  5616,  5662,  6328,  2342

length		dd	200

minimum		dd	0
median		dd	0
maximum		dd	0
sum		dd	0
average		dd	0

; -----
;  Misc. data definitions (if any).

gap			dd	0
swapped		db	0


; -----
;  Provided string definitions.

newLine		db	LF, NULL

hdr		db	LF, "---------------------------"
		db	"---------------------------"
		db	LF, ESC, "[1m", "CS 218 - Assignment #7", ESC, "[0m"
		db	LF, "Comb Sort", LF, LF, NULL

hdrMin		db	"Minimum:  ", NULL
hdrMax		db	"Maximum:  ", NULL
hdrMed		db	"Median:   ", NULL
hdrSum		db	"Sum:      ", NULL
hdrAve		db	"Average:  ", NULL

; ---------------------------------------------

section .bss

tempString	resb	MAX_STR_LENGTH

; ---------------------------------------------

section	.text
global	_start
_start:


; ******************************
; void function combSort(array, length)
;    gap = length
;    swapped = true
;
;    outer loop while gap>1 OR swapped = true
;        // update gap for next comb sweep
;        gap = (gap * 10) / 12
;        if gap < 1
;            gap = 1
;        end if i = 0 or swapped = false
;
;        inner loop until i + gap >= length	// single comb sweep
;            if  array[i] > array[i+gap]
;                swap(array[i], array[i+gap])
;                swapped = true
;            end if
;            i = i + 1
;        end inner loop
;     end outer loop
; end function

; ******************************
;  Sort data using Comb sort.


;	YOUR CODE GOES HERE

;    gap = length\
mov gap, dword [length]
;    swapped = true
mov byte [swapped], FALSE


outerLoop:

;    outer loop while gap>1 OR swapped = true
	;        gap = (gap * 10) / 12
	mov r8, 10
	mov r9, 12
	mov eax, dword [gap]
	imul rax, r8
	cqo
	idiv rax, r9
	mov dword [gap], eax

	;        if gap < 1
	cmp dword [gap], 1
	jg outerLoopOk
	cmp byte [swapped], FALSE
	jne outerLoopDone



outerLoopOk:
	;            gap = 1
	mov dword [gap], 1
	mov byte [swapped], TRUE

	;stuff for inner ;oop
	mov ebx, dword [length]
	mov esi, 0 ; esi = i
	sub ebx, dword [gap] ; ebx = length - gap
	mov r10d, dword [esi]
	add r10d, dword [gap] ; r10d = i + gap
innerLoop:
	;            if  array[i] > array[i+gap]
	mov r8d, dword [array + esi * 4]
	mov r9d, dword [array + r10d * 4] 
	cmp r8d, r9d
	ja innerLoopSort
	inc esi
    cmp esi, ebx
	jb innerLoop
	jmp outerLoop
innerLoopSort:
;                swap(array[i], array[i+gap])
;                swapped = true
;            end if
;            i = i + 1








innerLoopDone:








	jmp outerLoopDone
outerLoopDone:




; ******************************
;  Find sum and compute the average.
;  Get/save min and max.
;  Find median.


;	YOUR CODE GOES HERE
mov ecx, dword [length]
mov rsi, 0


; ******************************
;  Display results to screen in duodecimal.

	printString	hdr

	printString	hdrMin
	int2aNonary	dword [minimum], tempString, MAX_STR_LENGTH
	printString	tempString
	printString	newLine

	printString	hdrMax
	int2aNonary	dword [maximum], tempString, MAX_STR_LENGTH
	printString	tempString
	printString	newLine

	printString	hdrMed
	int2aNonary	dword [median], tempString, MAX_STR_LENGTH
	printString	tempString
	printString	newLine

	printString	hdrSum
	int2aNonary	dword [sum], tempString, MAX_STR_LENGTH
	printString	tempString
	printString	newLine

	printString	hdrAve
	int2aNonary	dword [average], tempString, MAX_STR_LENGTH
	printString	tempString
	printString	newLine
	printString	newLine


; ******************************
;  Done, terminate program.

last:
	mov	rax, SYS_exit
	mov	rdi, EXIT_SUCCESS
	syscall

