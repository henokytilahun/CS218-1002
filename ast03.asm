;  Name: Henok Tilahun
;  NSHE_ID: 5007740928
;  Section: 1002
;  Assignment:  3
;  Description: Performing very complex arithmetic operations


;  Focus on learning basic arithmetic operations
;  (add, subtract, multiply, and divide).
;  Ensure understanding of sign and unsigned operations.

; *****************************************************************
;  Data Declarations (provided).

section	.data
; -----
;  Define constants.

NULL		equ	0			; end of string

TRUE		equ	1
FALSE		equ	0

EXIT_SUCCESS	equ	0			; Successful operation
SYS_exit	equ	60			; call code for terminate

; -----
;  Assignment #3 data declarations

; byte data
bNum1		db	31
bNum2		db	23
bNum3		db	19
bNum4		db	29
bNum5		db	18
bNum6		db	-37
bNum7		db	-24
bNum8		db	-14
bAns1		db	0
bAns2		db	0
bAns3		db	0
bAns4		db	0
bAns5		db	0
bAns6		db	0
bAns7		db	0
bAns8		db	0
bAns9		db	0
bAns10		db	0
wAns11		dw	0
wAns12		dw	0
wAns13		dw	0
wAns14		dw	0
wAns15		dw	0
bAns16		db	0
bAns17		db	0
bAns18		db	0
bRem18		db	0
bAns19		db	0
bAns20		db	0
bAns21		db	0
bRem21		db	0

; word data
wNum1		dw	1348
wNum2		dw	659
wNum3		dw	327
wNum4		dw	125
wNum5		dw	649
wNum6		dw	-124
wNum7		dw	-253
wNum8		dw	-376
wAns1		dw	0
wAns2		dw	0
wAns3		dw	0
wAns4		dw	0
wAns5		dw	0
wAns6		dw	0
wAns7		dw	0
wAns8		dw	0
wAns9		dw	0
wAns10		dw	0
dAns11		dd	0
dAns12		dd	0
dAns13		dd	0
dAns14		dd	0
dAns15		dd	0
wAns16		dw	0
wAns17		dw	0
wAns18		dw	0
wRem18		dw	0
wAns19		dw	0
wAns20		dw	0
wAns21		dw	0
wRem21		dw	0

; double-word data
dNum1		dd	1528236
dNum2		dd	358397
dNum3		dd	126726
dNum4		dd	54372
dNum5		dd	7526
dNum6		dd	-3236
dNum7		dd	-2359
dNum8		dd	-4227
dAns1		dd	0
dAns2		dd	0
dAns3		dd	0
dAns4		dd	0
dAns5		dd	0
dAns6		dd	0
dAns7		dd	0
dAns8		dd	0
dAns9		dd	0
dAns10		dd	0
qAns11		dq	0
qAns12		dq	0
qAns13		dq	0
qAns14		dq	0
qAns15		dq	0
dAns16		dd	0
dAns17		dd	0
dAns18		dd	0
dRem18		dd	0
dAns19		dd	0
dAns20		dd	0
dAns21		dd	0
dRem21		dd	0

; quadword data
qNum1		dq	123456789
qNum2		dq	6215775
qNum3		dq	4912602
qNum4		dq	354879
qNum5		dq	197420
qNum6		dq	-135749
qNum7		dq	-374841
qNum8		dq	-531049
qAns1		dq	0
qAns2		dq	0
qAns3		dq	0
qAns4		dq	0
qAns5		dq	0
qAns6		dq	0
qAns7		dq	0
qAns8		dq	0
qAns9		dq	0
qAns10		dq	0
dqAns11		ddq	0
dqAns12		ddq	0
dqAns13		ddq	0
dqAns14		ddq	0
dqAns15		ddq	0
qAns16		dq	0
qAns17		dq	0
qAns18		dq	0
qRem18		dq	0
qAns19		dq	0
qAns20		dq	0
qAns21		dq	0
qRem21		dq	0

; *****************************************************************

section	.text
global _start
_start:

; ----------------------------------------------
; Byte Operations

; unsigned byte additions
;	bAns1  = bNum2 + bNum3
;	bAns2  = bNum1 + bNum3
;	bAns3  = bNum4 + bNum3


; -----
; signed byte additions
;	bAns4  = bNum5 + bNum7
;	bAns5  = bNum6 + bNum8


; -----
; unsigned byte subtractions
;	bAns6  = bNum1 - bNum3
;	bAns7  = bNum2 - bNum3
;	bAns8  = bNum3 - bNum4


; -----
; signed byte subtraction
;	bAns9  = bNum5 - bNum8
;	bAns10 = bNum7 - bNum6


; -----
; unsigned byte multiplication
;	wAns11  = bNum1 * bNum4
;	wAns12  = bNum2 * bNum2
;	wAns13  = bNum3 * bNum2


; -----
; signed byte multiplication
;	wAns14  = bNum5 * bNum6
;	wAns15  = bNum7 * bNum8


; -----
; unsigned byte division
;	bAns16 = bNum1 / bNum3
;	bAns17 = bNum4 / bNum2
;	bAns18 = wNum3 / bNum4
;	bRem18 = wNum3 % bNum4


; -----
; signed byte division
;	bAns19 = bNum5 / bNum8
;	bAns20 = bNum6 / bNum7
;	bAns21 = wNum5 / bNum8
;	bRem21 = wNum5 % bNum8



; *****************************************
; Word Operations

; -----
; unsigned word additions
;	wAns1  = wNum4 + wNum1
;	wAns2  = wNum3 + wNum2
;	wAns3  = wNum3 + wNum3


; -----
; signed word additions
;	wAns4  = wNum5 + wNum7
;	wAns5  = wNum6 + wNum8


; -----
; unsigned word subtractions
;	wAns6  = wNum1 - wNum3
;	wAns7  = wNum2 - wNum4
;	wAns8  = wNum4 - wNum2


; -----
; signed word subtraction
;	wAns9  = wNum5 - wNum8
;	wAns10  = wNum6 - wNum7


; -----
; unsigned word multiplication
;	dAns11 = wNum1 * wNum4
;	dAns12  = wNum4 * wNum4
;	dAns13  = wNum2 * wNum3


; -----
; signed word multiplication
;	dAns14  = wNum5 * wNum7
;	dAns15  = wNum6 * wNum8


; -----
; unsigned word division
;	wAns16 = wNum2 / wNum3
;	wAns17 = wNum1 / wNum4
;	wAns18 = dNum1 / wNum2
;	wRem18 = dNum1 % wNum2


; -----
; signed word division
;	wAns19 = wNum5 / wNum8
;	wAns20 = wNum7 / wNum6
;	wAns21 = dNum5 / wNum7
;	wRem21 = dNum5 % wNum7



; *****************************************
; Double-Word Operations

; -----
; unsigned double-word additions
;	dAns1  = dNum1 + dNum4
;	dAns2  = dNum2 + dNum3
;	dAns3  = dNum3 + dNum4


; -----
; signed double-word additions
;	dAns4  = dNum5 + dNum8
;	dAns5  = dNum6 + dNum7


; -----
; unsigned double-word subtractions
;	dAns6  = dNum1 - dNum4
;	dAns7  = dNum2 - dNum3
;	dAns8  = dNum3 - dNum4


; -----
; signed double-word subtraction
;	dAns9  = dNum5 - dNum7
;	dAns10 = dNum6 – dNum8


; -----
; unsigned double-word multiplication
;	qAns11  = dNum1 * dNum2
;	qAns12  = dNum3 * dNum4
;	qAns13  = dNum2 * dNum3


; -----
; signed double-word multiplication
;	qAns14  = dNum5 * dNum6
;	qAns15  = dNum7 * dNum8


; -----
; unsigned double-word division
;	dAns16 = dNum1 / dNum4
;	dAns17 = dNum2 / dNum3
;	dAns18 = qAns12 / dNum4
;	dRem18 = qAns12 % dNum4


; -----
; signed double-word division
;	dAns19 = dNum5 / dNum8
;	dAns20 = dNum6 / dNum7
;	dAns21 = qAns12 / dNum8
;	dRem21 = qAns12 % dNum8



; *****************************************
; QuadWord Operations

; -----
; unsigned quadword additions
;	qAns1  = qNum1 + qNum3
;	qAns2  = qNum2 + qNum4
;	qAns3  = qNum3 + qNum4


; -----
; signed quadword additions
;	qAns4  = qNum5 + qNum8
;	qAns5  = qNum6 + qNum7


; -----
; unsigned quadword subtractions
;	qAns6  = qNum1 - qNum2
;	qAns7  = qNum3 - qNum4
;	qAns8  = qNum2 - qNum4


; -----
; signed quadword subtraction
;	qAns9  = qNum6 - qNum7
;	qAns10 = qNum5 - qNum8


; -----
; unsigned quadword multiplication
;	dqAns11  = qNum1 * qNum2
;	dqAns12  = qNum3 * qNum4
;	dqAns13  = qNum2 * qNum3


; -----
; signed quadword multiplication
;	dqAns14  = qNum5 * qNum8
;	dqAns15  = qNum6 * qNum7


; -----
; unsigned quadword division
;	qAns16 = qNum1 / qNum4
;	qAns17 = qNum2 / qNum3
;	qAns18 = dqAns12 / qNum2
;	qRem18 = dqAns12 % qNum2


; -----
; signed quadword division
;	qAns19 = qNum5 / qNum6
;	qAns20 = qNum7 / qNum6
;	qAns21 = dqAns12 / qNum8
;	qRem21 = dqAns12 % qNum8


; *****************************************************************
;	Done, terminate program.

last:
	mov	rax, SYS_exit			; system call for exit (SYS_exit)
	mov	rdi, EXIT_SUCCESS		; return C/C++ style code (0)
	syscall

