; *****************************************************************
;  Name: Henok Tilahun
;  NSHE_ID: 5007740928
;  Section: 1002
;  Assignment: 6
;  Description:	Practice using macros and converting ASCII/nonary

; =====================================================================
;  STEP #2
;  Macro to convert ASCII/nonary value into an integer.
;  Reads <string>, convert to integer and place in <integer>
;  Assumes valid data, no error checking is performed.

;  Arguments:
;	%1 -> <string>, register -> string address
;	%2 -> <integer>, register -> result

;  Macro usgae
;	anonary2int  <string-address>, <integer-variable>

;  Example usage:
;	anonary2int	rbx, tmpInteger

;  For example, to get address into a local register:
;		mov	rsi, %1

;  To return a value, it might be:
;		mov	dword [%2], eax

;  Note, the register used for the macro call (rbx in this example)
;  must not be altered BEFORE the address is copied into
;  another register (if desired).

%macro	aNonary2int	2


;	YOUR CODE GOES HERE
mov r8, %1
mov r9, 0

mov eax, 0
%%findSpaces1:
    mov cl, byte [r8 + r9]
    cmp cl, " "
    jne %%startLoop1
    inc r9
    jmp %%findSpaces1

%%startLoop1:
    mov ecx, 0
    mov cl, byte[r8+r9]
    cmp cl, NULL
    je %%endOfString1
    sub cl, "0"
    mov r11d, 9
    mul r11d
    add eax, ecx
    inc r9
    jmp %%startLoop1

%%endOfString1:
    mov dword [%2], eax

%endmacro

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

;  For example, to get the passed value into a local register:
;		mov	eax, %1

%macro	int2aNonary	3


;	YOUR CODE GOES HERE


%endmacro

; =====================================================================
;  Simple macro to display a string to the console.
;  Count characters (excluding NULL).
;  Display string starting at address <stringAddr>

;  Macro usage:
;	printString  <stringAddr>

;  Arguments:
;	%1 -> <stringAddr>, string address

%macro	printString	1
	push	rax			; save altered registers (cautionary)
	push	rdi
	push	rsi
	push	rdx
	push	rcx

	lea	rdi, [%1]		; get address
	mov	rdx, 0			; character count
%%countLoop:
	cmp	byte [rdi], NULL
	je	%%countLoopDone
	inc	rdi
	inc	rdx
	jmp	%%countLoop
%%countLoopDone:

	mov	rax, SYS_write		; system call for write (SYS_write)
	mov	rdi, STDOUT		; standard output
	lea	rsi, [%1]		; address of the string
	syscall				; call the kernel

	pop	rcx			; restore registers to original values
	pop	rdx
	pop	rsi
	pop	rdi
	pop	rax
%endmacro

; =====================================================================
;  Initialized variables.

section	.data

; -----
;  Define standard constants.

TRUE		equ	1
FALSE		equ	0

EXIT_SUCCESS	equ	0			; successful operation
NOSUCCESS	equ	1			; unsuccessful operation

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
SPACE		equ	" "
NULL		equ	0
ESC		equ	27

NUMS_PER_LINE	equ	5


; -----
;  Assignment #6 Provided Data

STR_LENGTH	equ	15			; chars in string, with NULL

edgeLengths	db	"            23", NULL, "            37", NULL
		db	"            45", NULL, "            61", NULL
		db	"            55", NULL, "            78", NULL
		db	"           123", NULL, "           137", NULL
		db	"           144", NULL, "           151", NULL
		db	"           180", NULL, "           217", NULL
		db	"           234", NULL, "           240", NULL
		db	"           267", NULL, "           281", NULL
		db	"           302", NULL, "           322", NULL
		db	"           312", NULL, "           327", NULL
		db	"           342", NULL, "           362", NULL
		db	"           372", NULL, "           381", NULL
		db	"           400", NULL, "           411", NULL
		db	"           427", NULL, "           431", NULL
		db	"           445", NULL, "           450", NULL
		db	"           462", NULL, "           477", NULL
		db	"           512", NULL, "           523", NULL
		db	"           532", NULL, "           548", NULL
		db	"           615", NULL, "           627", NULL
		db	"           632", NULL, "           648", NULL
		db	"           652", NULL, "           678", NULL
		db	"           711", NULL, "           728", NULL
		db	"           737", NULL, "           748", NULL
		db	"           777", NULL, "           827", NULL
		db	"           850", NULL, "           888", NULL

aNonaryLength	db	"            55", NULL
length		dd	0

cubeSum		dd	0
cubeAve		dd	0
cubeMin		dd	0
cubeMax		dd	0


; -----
;  Misc. variables for main.

hdr		db	"-----------------------------------------------------"
		db	LF, ESC, "[1m", "CS 218 - Assignment #6", ESC, "[0m", LF
		db	"Cube Calculations", LF, LF
		db	"Cube Volumes:", LF, NULL
shdr		db	LF, "Cube Sum:  ", NULL
avhdr		db	LF, "Cube Ave:  ", NULL
minhdr		db	LF, "Cube Min:  ", NULL
maxhdr		db	LF, "Cube Max:  ", NULL

newLine		db	LF, NULL
spaces		db	"   ", NULL

; =====================================================================
;  Uninitialized variables

section	.bss

tmpInteger	resd	1				; temporary value

volumes		resd	50
edgeLenInts	resd	50

lenString	resb	STR_LENGTH
tempString	resb	STR_LENGTH			; bytes

cubeSumString	resb	STR_LENGTH
cubeAveString	resb	STR_LENGTH
cubeMinString	resb	STR_LENGTH
cubeMaxString	resb	STR_LENGTH


; **************************************************************

section	.text
global	_start
_start:

; -----
;  Display assignment initial headers.

	printString	hdr

; -----
;  STEP #1
;	Convert integer length, in ASCII/nonary format to integer.
;	Do not use macro here...
;	Read string aNonaryLength, convert to integer, and store in length

;	YOUR CODE GOES HERE
mov r8, aNonaryLength
mov r9, 0

mov eax, 0
findSpaces:
    mov cl, byte [r8 + r9]
    cmp cl, " "
    jne startLoop
    inc r9
    jmp findSpaces

startLoop:
    mov ecx, 0
    mov cl, byte[r8+r9]
    cmp cl, NULL
    je endOfString
    sub cl, "0"
    mov r11d, 9
    mul r11d
    add eax, ecx
    inc r9 
    jmp startLoop

endOfString:
    mov dword [length], eax
; -----
;  Convert radii from ASCII/nonary format to integer.
;  STEP #2 must complete before this code.

	mov	ecx, dword [length]
	mov	rdi, 0					; index for array
	mov	rbx, edgeLengths
cvtLoop:
	push	rbx					; safety push's
	push	rcx
	push	rdi
	aNonary2int	rbx, tmpInteger
	pop	rdi
	pop	rcx
	pop	rbx

	mov	eax, dword [tmpInteger]
	mov	dword [edgeLenInts+rdi*4], eax		; save for reference

	; YOUR CODE -> Calculate volume and store in volumes array

	add	rbx, STR_LENGTH

	inc	rdi
	dec	ecx
	cmp	ecx, 0
	jne	cvtLoop

; -----
;  Display each the volumes array (five per line).

	mov	ecx, dword [length]
	mov	rsi, 0
	mov	r12, 0
printLoop:
	push	rcx					; safety push's
	push	rsi
	push	r12

	int2aNonary	dword [volumes+rsi*4], tempString, STR_LENGTH

	printString	tempString
	printString	spaces

	pop	r12
	pop	rsi
	pop	rcx

	inc	r12
	cmp	r12, 3
	jne	skipNewline
	mov	r12, 0
	printString	newLine
skipNewline:
	inc	rsi

	dec	ecx
	cmp	ecx, 0
	jne	printLoop
	printString	newLine

; -----
;  STEP #3
;	Find volumes array stats (sum, min, max, and average).
;	Reads data from volumes array (set above).


;	YOUR CODE GOES HERE
mov ecx, dword [length]
mov rsi, 0

findCalc:
    mov eax, dword [edgeLengths]
    mov dword [cubeMin], eax
    mov dword [cubeMax], eax
    mov dword [cubeSum], 0

changeLoop:
    mov eax, dword [edgeLengths + rsi *4]
    add dword [cubeSum], eax
    cmp eax, dword [cubeMin]
    jae notNewCubeMin
    mov dword [cubeMin], eax

notNewCubeMin:
    cmp eax, dword [cubeMax]
    jbe notNewCubeMax ;goes ahead
    mov dword [cubeMax], eax

notNewCubeMax:
    inc rsi
    loop changeLoop

mov eax, dword [cubeSum]
mov edx, 0 ;remainder place
div dword [length]
mov dword [cubeAve], eax

; -----
;  STEP #4
;	Convert sum to ASCII/nonary for printing.
;	Do not use macro here...

	printString	shdr				; display header

;	Read volumes sum inetger (set above), convert to
;		ASCII/nonary and store in cubeSumString.
;	The ASCII version of the number should be STR_LENGTH
;		(globally available constant) characters (including the NULL),
;		right justified with the appropriate number of leading blanks.


;	YOUR CODE GOES HERE
mov eax, dword [cubeSum]
mov rcx, 0
mov ebx, 6

divideLoop:
    mov edx, 0
    div ebx

    push rdx
    inc rcx

    cmp eax, 0

    jne divideLoop

mov rbp, rcx
dec rbp
;compare rcx w/ STR_LENGTH
cmp rcx, STR_LENGTH-1

;jmp to a loop until rcx = STR_LENGTH
jne spaceLoop

spaceLoop:
    mov rdx, SPACE
    push rdx
    inc rcx
    cmp rcx, STR_LENGTH-1
    jne spaceLoop

    mov rbx, cubeSumString
    mov rdi, 0

;addSpaces:
;   mov

popLoopSpaces:
    inc rbp
    pop rax
    mov byte [rbx+rdi], al
    inc rdi
    cmp rbp, STR_LENGTH-1
    jne popLoopSpaces


popLoop:
    pop rax


    add al, "0"

    mov byte [rbx+rdi], al
    inc rdi
    loop popLoop
    mov byte [rbx + rdi], NULL

;	print the cubeSumString (set above).
	printString	cubeSumString

; -----
;  Convert average, min, and max integers to ASCII/nonary for printing.
;  STEP #5 must complete before this code.

	printString	avhdr
	int2aNonary	dword [cubeAve], cubeAveString, STR_LENGTH
	printString	cubeAveString

	printString	minhdr
	int2aNonary	dword [cubeMin], cubeMinString, STR_LENGTH
	printString	cubeMinString

	printString	maxhdr
	int2aNonary	dword [cubeMax], cubeMaxString, STR_LENGTH
	printString	cubeMaxString

	printString	newLine
	printString	newLine

; *****************************************************************
;  Done, terminate program.

last:
	mov	rax, SYS_exit
	mov	rdi, EXIT_SUCCESS
	syscall

