; *****************************************************************
;  Name: Henok Tilahun
;  NSHE_ID: 5007740928
;  Section: 1002
;  Assignment: 9
;  Description: Practice connecting asm to c++ and using system calls


; ********************************************************************************

section	.data

; -----
;  Define standard constants.

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
SPACE		equ	" "
NULL		equ	0
ESC		equ	27

; -----
;  Define program specific constants.

MAXNUM		equ	100000
MINNUM		equ	-100000
BUFFSIZE	equ	51			; 50 chars plus NULL

; -----
;  NO static local variables allowed...


; ********************************************************************************

section	.text

; --------------------------------------------------------
;  Read an ASCII nonary number from the user.
;  Perform appropriate error checking and, if OK,
;  convert to integer.

; -----
;  HLL Call:
;	bool = readNonaryNum(&numberRead, promptStr, errMsg1,
;				errMsg2, errMsg3);

;  Arguments Passed:
;	numberRead, addr - rdi
;	promptStr, addr - rsi
;	errMsg1, addr - rdx
;	errMsg2, addr - rcx
;	errMsg3, addr - r8

;  Returns:
;	true/false
;	number read (via reference)


;	YOUR CODE GOES HERE


; **********************************************************************************
;  Perform comb sort

; -----
;  HLL Call:
;	call combSort(list, len)

;  Arguments Passed:
;	1) list, addr - rdi
;	2) length, value - rsi

;  Returns:
;	sorted list (list passed by reference)


;	YOUR CODE GOES HERE


; --------------------------------------------------------
;  Find statistical information for a list of integers:
;	sum, average, minimum, maximum, and, median

;  Note, for an odd number of items, the median value is defined as
;  the middle value.  For an even number of values, it is the integer
;  average of the two middle values.

;  This function must call the lstAvergae() function
;  to get the average.

;  Note, assumes the list is already sorted.

; -----
;  Call:
;	call lstStats(list, len, sum, ave, min, max, med)

;  Arguments Passed:
;	list, addr - rdi
;	length, value - rsi
;	sum, addr - rdx
;	average, addr - rcx
;	minimum, addr - r8
;	maximum, addr - r9
;	median, addr - stack, rbp+16

;  Returns:
;	sum, average, minimum, maximum, and median
;		via pass-by-reference


;	YOUR CODE GOES HERE


; --------------------------------------------------------
;  Function to calculate the median of a sorted list.

; -----
;  Call:
;	ans = lstMedian(lst, len)

;  Arguments Passed:
;	1) list, address - rdi
;	1) length, value - rsi

;  Returns:
;	median (in eax)


;	YOUR CODE GOES HERE


; --------------------------------------------------------
;  Function to calculate the estimated median of a sorted list.

; -----
;  Call:
;	ans = lstEstMedian(lst, len)

;  Arguments Passed:
;	1) list, address - rdi
;	1) length, value - rsi

;  Returns:
;	estimated median (in eax)


;	YOUR CODE GOES HERE


; --------------------------------------------------------
;  Function to calculate the sum of a list.

; -----
;  Call:
;	ans = lstSum(lst, len)

;  Arguments Passed:
;	1) list, address - rdi
;	1) length, value - rsi

;  Returns:
;	sum (in eax)


;	YOUR CODE GOES HERE


; --------------------------------------------------------
;  Function to calculate the average of a list.

; -----
;  Call:
;	ans = lstAverage(lst, len)

;  Arguments Passed:
;	1) list, address - rdi
;	1) length, value - rsi

;  Returns:
;	average (in eax)


;	YOUR CODE GOES HERE


; --------------------------------------------------------
;  Function to calculate the kurtosis statisic.

; -----
;  Call:
;  kStat = lstKurtosis(list, len, ave)

;  Arguments Passed:
;	1) list, address - rdi
;	2) len, value - esi
;	3) ave, value - edx

;  Returns:
;	kurtosis statistic (in rax)


;	YOUR CODE GOES HERE


; ********************************************************************************
;  Generic procedure to display a string to the screen.
;  String must be NULL terminated.

;  Algorithm:
;	Count characters in string (excluding NULL)
;	Use syscall to output characters

; -----
;  HLL Call:
;	printString(stringAddr);

;  Arguments:
;	1) address, string
;  Returns:
;	nothing

global	printString
printString:

; -----
;  Count characters to write.

	mov	rdx, 0
strCountLoop:
	cmp	byte [rdi+rdx], NULL
	je	strCountLoopDone
	inc	rdx
	jmp	strCountLoop
strCountLoopDone:
	cmp	rdx, 0
	je	printStringDone

; -----
;  Call OS to output string.

	mov	rax, SYS_write			; system code for write()
	mov	rsi, rdi			; address of char to write
	mov	rdi, STDOUT			; file descriptor for std in
						; rdx=count to write, set above
	syscall					; system call

; -----
;  String printed, return to calling routine.

printStringDone:
	ret

; ******************************************************************

