; *****************************************************************
;  Name: Henok Tilahun
;  NSHE_ID: 5007740928
;  Section: 1002
;  Assignment: 8
;  Description: Making and using functions for estMed, listStats, listSum



; ********************************************************************************

section	.data

; -----
;  Define constants.

TRUE		equ	1
FALSE		equ	0

; -----
;  Local variables for combSort() function.
gap			dd	0
swapped		db	0



; -----
;  Local variables for lstStats() function (if any).




section	.bss

; -----
;  Unitialized variables.




; ********************************************************************************

section	.text

; **********************************************************************************
;  Comb Sort Algorithm:

;  void function combSort(array, length)
;     gap = length
;
;     outter loop until gap = 1 and swapped = false
;         gap = (gap * 10) / 12	     			// update gap for next sweep
;         if gap < 1
;           gap = 1
;         end if
;
;         i = 0
;         swapped = false
;
;         inner loop until i + gap >= length	       // single comb sweep
;             if  array[i] > array[i+gap]
;                 swap(array[i], array[i+gap])
;                 swapped = true
;             end if
;             i = i + 1
;         end inner loop
;      end outter loop
;  end function

; -----
;  HLL Call:
;	call combSort(list, len)

;  Arguments Passed:
;	1) list, addr - rdi
;	2) length, value - rsi

;  Returns:
;	sorted list (list passed by reference)

global	combSort
combSort:


;	YOUR CODE GOES HERE
push r12
push rbx
    ;    gap = length
    mov dword [gap], esi
    ;    swapped = true
	mov r12b, FALSE
    mov byte [swapped], r12b


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
	mov ebx, esi
	mov r11d, 0 ; r11d = i
	sub ebx, dword [gap] ; ebx = length - gap
	mov r10d, r11d
	add r10d, dword [gap] ; r10d = i + gap
innerLoop:
	;            if  rdi[i] > rdi[i+gap]
	mov r8d, dword [rdi + r11 * 4]
	mov r9d, dword [rdi + r10 * 4] 
	cmp r8d, r9d
	ja innerLoopSort
	inc r11d
    cmp r11d, ebx
	jb innerLoop
	jmp innerLoopDone
innerLoopSort:
;                swap(array[i], array[i+gap])
;                swapped = true
;            end if
;            i = i + 1
	mov eax, r8d ; lst[i] -> temp
    mov r8d, r9d ; lst[i+1] -> lst[i]
    mov r9d, eax ; temp -> lst[i+1]
    mov dword [rdi + r11 *4], r8d
    mov dword [rdi+ r10 *4], r9d
    mov byte [swapped], FALSE
    jmp innerLoop

innerLoopDone:

	jmp outerLoopDone
outerLoopDone:

pop rbx
pop r12
ret


; --------------------------------------------------------
;  Find statistical information for a list of integers:
;	minimum, median, maximum, sum, and average

;  Note, for an odd number of items, the median value is defined as
;  the middle value.  For an even number of values, it is the integer
;  average of the two middle values.

;  This function must call the lstAverage() function
;  to get the average.

;  Note, assumes the list is already sorted.

; -----
;  Call:
;	call lstStats(list, len, sum, ave, min, max, med)

;  Arguments Passed:
;	1) list, addr - rdi
;	2) length, value - rsi
;	3) sum, addr - rdx
;	4) average, addr - rcx
;	5) minimum, addr - r8
;	6) maximum, addr - r9
;	7) median, addr - stack, rbp+16

;  Returns:
;	minimum, median, maximum, sum, and average
;		via pass-by-reference

global lstStats
lstStats:


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

global	lstMedian
lstMedian:


;	YOUR CODE GOES HERE



; --------------------------------------------------------
;  Function to calculate the estimated median of an unsorted list.

; -----
;  Call:
;	ans = lstEstMedian(lst, len)

;  Arguments Passed:
;	1) list, address - rdi
;	1) length, value - rsi

;  Returns:
;	estimated median (in eax)


global	lstEstMedian
lstEstMedian:


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


global	lstSum
lstSum:


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

global	lstAverage
lstAverage:


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

global lstKurtosis
lstKurtosis:


;	YOUR CODE GOES HERE



; ********************************************************************************

