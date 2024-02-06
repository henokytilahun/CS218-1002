;  Name: Henok Tilahun
;  NSHE_ID: 5007740928
;  Section: 1002
;  Assignment: CS 218 – Assignment #2
;  Description: Practice using lables and deeper programing concepts 
;

; *****************************************************************
;  Static Data Declarations (initialized)

section	.data

; -----
;  Define constants.
medStart dd 0
medEnd dd 0
minimum dd 0
median dd 0
ans dd 0
DIVEVEN dd 2
DIV12       dd	12			; divisor for 12

NULL		equ	0			; end of string

TRUE		equ	1
FALSE		equ	0

EXIT_SUCCESS	equ	0			; successful operation
SYS_exit	equ	60			; call code for terminate

; -----

list		dd	 2140, -2376,  2540, -2240,  2677, -2635,  2426,  2000
		dd	-2614,  2418, -2513,  2420, -2119,  2215, -2556,  2712
		dd	 2436, -2622,  2731, -2729,  2615, -2724,  2208,  2220
		dd	-2580,  2146, -2324,  2425, -2816,  2256, -2718,  2192
  		dd	 2004, -2235,  2764, -2615,  2312, -2765,  2954,  2960
		dd	-2515,  2556, -2342,  2321, -2556,  2727, -2227,  2844
		dd	 2382, -2465,  2955, -2435,  2225, -2419,  2534,  2348
		dd	-2467,  2316, -2961,  2335, -2856,  2553, -2032,  2832
		dd	 2246, -2330,  2317, -2115,  2726, -2140,  2565,  2868
		dd	-2464,  2915, -2810,  2465, -2544,  2264, -2612,  2656
		dd	 2192, -2825,  2916, -2312,  2725, -2517,  2498,  3672
		dd	-2475,  2034, -2223,  2883, -2172,  2350, -2415,  2335
		dd	 2124, -2118,  2713,  2025
length		dd	100

listMin		dd	0
listEstMed	dd	0
listMax		dd	0
listSum		dd	0
listAve		dd	0

negCnt		dd	-1
negSum		dd	0
negAve		dd	0

twelveCnt	dd	-1
twelveSum	dd	0
twelveAve	dd	0


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
; FIND MIN
mov rbx, list
mov rcx, 0
mov eax, dword[rbx]

changeLess:
    mov dword [listMin], eax
    jmp minloop

minloop:
    mov eax, dword [rbx + rcx*4]
    inc rcx
    cmp eax, dword [listMin]
    jle changeLess
    cmp ecx, dword [length]
    jne minloop

; FIND Median

mov eax, dword[length]
mov edx, 0
div dword [DIVEVEN]
mov dword [median], eax

mov ecx, dword [median]
medLoop1:
    mov eax, dword[rbx]
    add rbx, 4
    dec ecx
    cmp ecx, 0
    jne medLoop1

mov rbx, list
mov ecx, dword [median]
inc ecx
inc ecx
medLoop2:
    mov edx, dword[rbx]
    add rbx, 4
    dec ecx
    cmp ecx, 1
    jne medLoop2


;add eax, dword [edx]
mov dword [listEstMed], edx

; FIND MAX
mov rbx, list
mov rcx, 0
mov eax, dword[rbx]

changeMax:
    mov dword [listMax], eax
    jmp Maxloop

Maxloop:
    mov eax, dword [rbx + rcx*4]
    inc rcx
    cmp eax, dword [listMax]
    jge changeMax
    cmp ecx, dword [length]
    jne Maxloop

; FIND SUM
mov rbx, list
mov ecx, dword [length]
mov eax, 0
Sumloop:
    add eax, dword [rbx]
    add rbx, 4
    dec ecx
    cmp ecx, 0
    jne Sumloop
    mov dword [listSum], eax

; FIND AVG
mov ecx, dword [listSum]

mov eax, dword [listSum]
mov edx, 0
div dword [length]
mov dword [listAve], eax



mov rbx, list
mov eax, 0
mov ebx, 0
mov rsi, 1

twelveCount:
    inc dword [twelveCnt]
    mov eax, dword [list - 8 + rsi*4]
    jmp twelveSumLoop
twelveSumLoop:
    mov eax, dword[list + rsi * 4]
    mov ebx, 12
    cdq
    idiv ebx
    inc rsi
    cmp edx, 0
    je twelveCount
    cmp esi, dword [length]
    jne twelveSumLoop

; FIND # DIVISABLE by 12 SUM
mov rbx, list
mov eax, 0
mov ebx, 0
mov rsi, 1


twelveSumLoop2:
    mov eax, dword[list + rsi * 4]
    mov ebx, 12
    cdq
    idiv ebx
    cmp edx, 0
    je twelveSumm
    inc rsi
    cmp esi, dword [length]
    jne twelveSumLoop2
    jmp doneTwelveSum
twelveSumm:
    mov eax, dword [list + rsi*4]
    add dword [twelveSum], eax
    inc rsi
    jmp twelveSumLoop2

doneTwelveSum:
;FIND # DIVISABLE by 12 AVG
mov ecx, dword [twelveSum]
mov eax, dword [twelveSum]
mov edx, 0
div dword [twelveCnt]
mov dword [twelveAve], eax


; FIND NEGATIVE COUNT
mov rbx, list
mov eax, 0
mov ebx, 0
mov rsi, 1

negCount:
    inc dword [negCnt]
    mov eax, dword [list - 8 + rsi*4]
    jmp negSumLoop
negSumLoop:
    mov eax, dword[list + rsi * 4]
    inc rsi
    cmp eax, 0
    jl negCount
    cmp esi, dword [length]
    jne negSumLoop


mov rbx, list
mov eax, 0
mov ebx, 0
mov rsi, 1

negSumLoop2:
    mov eax, dword[list + rsi * 4]
    cmp eax, 0
    jl negSumm
    inc rsi
    cmp esi, dword [length]
    jne negSumLoop2
    jmp donenegSum
negSumm:
    mov eax, dword [list + rsi*4]
    add dword [negSum], eax
    inc rsi
    jmp negSumLoop2

donenegSum:
;FIND # DIVISABLE by 12 AVG
mov ecx, dword [negSum]
mov eax, dword [negSum]
cdq
idiv dword [negCnt]
mov dword [negAve], eax

; *****************************************************************
;	Done, terminate program.

last:
	mov	rax, SYS_exit		; call call for exit (SYS_exit)
	mov	rdi, EXIT_SUCCESS	; return code of 0 (no error)
	syscall

