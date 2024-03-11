; *****************************************************************
;  Name: Henok Tilahun
;  NSHE_ID: 5007740928
;  Section: 1002
;  Assignment: 10
;  Description:  Make cool visual stuff w/ openGL

; -----
;  Function: getParams()
;	Gets, checks, converts, and returns command line arguments.

;  Function: drawTorus()
;	Plots torus formulas

;  Function: cvtnonaryint()
;	Convert nonary string to integer

; ---------------------------------------------------------

;	MACROS (if any) GO HERE


; ---------------------------------------------------------

section  .data

; -----
;  Define standard constants.

TRUE		equ	1
FALSE		equ	0

SUCCESS		equ	0			; successful operation
NOSUCCESS	equ	1

STDIN		equ	0			; standard input
STDOUT		equ	1			; standard output
STDERR		equ	2			; standard error

SYS_read	equ	0			; code for read
SYS_write	equ	1			; code for write
SYS_open	equ	2			; code for file open
SYS_close	equ	3			; code for file close
SYS_fork	equ	57			; code for fork
SYS_exit	equ	60			; code for terminate
SYS_creat	equ	85			; code for file open/create
SYS_time	equ	201			; code for get time

LF		equ	10
SPACE		equ	" "
NULL		equ	0
ESC		equ	27

; -----
;  OpenGL constants

GL_COLOR_BUFFER_BIT	equ	16384
GL_POINTS		equ	0
GL_POLYGON		equ	9
GL_PROJECTION		equ	5889

GLUT_RGB		equ	0
GLUT_SINGLE		equ	0

; -----
;  Define program specific constants.

R1_MIN		equ	1			; 1(10) = 1(9)
R1_MAX		equ	100			; 100(10) = 121(9)

R2_MIN		equ	1			; 1(10) = 1(9)
R2_MAX		equ	100			; 100(10) = 121(9)

H_MIN		equ	100			; 100(10) = 121(9)
H_MAX		equ	1000			; 1000(10) = 1331(9)

W_MIN		equ	100			; 1(10) = 121(9)
W_MAX		equ	1000			; 1000(10) = 1331(9)

CL_MIN		equ	50			; 50(10) = 55(9)
CL_MAX		equ	0xffffff		; 16777215(10) = 34511010(9)

; -----
;  Variables for getRadii procedure.

errUsage	db	"Usage:  ./torus -r1 <nonaryNumber> "
		db	"-r2 <nonaryNumber> -h <nonaryNumber> "
		db	"-w <nonaryNumber> -cl <nonaryNumber>"
		db	LF, NULL
errBadCL	db	"Error, invalid or incomplete command line arguments."
		db	LF, NULL

errR1sp		db	"Error, radius 1 specifier incorrect."
		db	LF, NULL
errR1value	db	"Error, radius 1 value must be between 1(9) "
		db	"and 121(9)."
		db	LF, NULL

errR2sp		db	"Error, radius 2 specifier incorrect."
		db	LF, NULL
errR2value	db	"Error, radius 2 value must be between 1(9) "
		db	"and 121(9)."
		db	LF, NULL

errHsp		db	"Error, height specifier incorrect."
		db	LF, NULL
errHvalue	db	"Error, height value must be between 121(9) "
		db	"and 1331(9)."
		db	LF, NULL

errWsp		db	"Error, width specifier incorrect."
		db	LF, NULL
errWvalue	db	"Error, width must be between 121(9) "
		db	"and 1331(9)."
		db	LF, NULL

errCLsp		db	"Error, color specifier incorrect."
		db	LF, NULL
errCLvalue	db	"Error, color value must be between 55(9) "
		db	"and 34511010(9)."
		db	LF, NULL

; -----
;  Variables for torus routine.

pi		dd	3.14159265358979323846
fltZero		dd	0.0
fltOne		dd	1.0
fltOnePtFive	dd	1.5
fltTwo		dd	2.0
fltTen		dd	10.0
fltSeventy	dd	70.0
fltTmp1		dd	0.0

x		dd	0.0			; current x
y		dd	0.0			; current y
z		dd	0.0			; current z

t		dd	0.0			; t=0.0
u		dd	0.0			; u=0.0

rd1		dd	0.0			; radius 1 (float)
rd2		dd	0.0			; radius 2 (float)

iterations	dd	0			; set based on tStep

; ------------------------------------------------------------

section  .text

; -----
;  External references for openGL routines.

extern	glutInit, glutInitDisplayMode, glutInitWindowSize, glutInitWindowPosition
extern	glutCreateWindow, glutMainLoop
extern	glutDisplayFunc, glutIdleFunc, glutReshapeFunc, glutKeyboardFunc
extern	glutSwapBuffers, gluPerspective, glutPostRedisplay
extern	glClearColor, glClearDepth, glDepthFunc, glEnable, glShadeModel
extern	glClear, glLoadIdentity, glMatrixMode, glViewport
extern	glTranslatef, glRotatef, glBegin, glEnd, glVertex3f, glColor3f
extern	glVertex2f, glVertex2i, glColor3ub, glOrtho, glFlush, glVertex2d
extern	glPushMatrix, glPopMatrix, glPointSize, glRotatef

extern	cosf, sinf

; ******************************************************************
;  Function: getParams()
;	Gets radius 1, radius 2, height, width, and color values
;	from the command line.

;	Performs error checking, converts ASCII/Undecimal string
;	to integer.  Required command line format (fixed order):
;	  "-r1 <unDecimal> -r2 <unDecimal> -h <unDecimal> 
;			-w <unDecimal> -cl <unDecimal"

; -----
;  Arguments:
;	- ARGC
;	- ARGV
;	- radius 1, double-word int, address
;	- radius 2, double-word int, address
;	- height, double-word int, address
;	- width, double-word int, address
;	- color, double-word int, address
global getParams
getParams:
    push r12

    ;check if arc = 1   errUsage
	cmp edi, 1
	je errUsagee

    ;check if there are 11 arguments    errBadCL
    ; > 11
	cmp edi, 11
	jb errBadCLe
    ; < 11
    cmp edi, 11
	ja errBadCLe

    ;check if argv[1] is -r1    errR1sp
    mov rbx, qword [rsi +8]
    mov al, byte [rbx]
    cmp al, "-"
    jne errR1spe

    mov al, byte [rbx +1]
    cmp al, "r"
    jne errR1spe

    mov al, byte [rbx +2]
    cmp al, "1"
    jne errR1spe

    mov al, byte [rbx +3]
    cmp al, NULL
    jne errR1spe

    ;check if argv[2] is a nonary number    errR1value
    mov r12, rsi
    mov rdi, qword [r12+16]
    call cvtnonary2int
    cmp eax, 0
    jl errR1valuee

    cmp eax, R1_MAX
    ja errR1valuee
    cmp eax, R1_MIN
    jb errR1valuee


    ;check if argv[3] is -r2    errR2sp
    mov rbx, qword [rsi +24]
    mov al, byte [rbx]
    cmp al, "-"
    jne errR2spe

    mov al, byte [rbx +1]
    cmp al, "r"
    jne errR2spe

    mov al, byte [rbx +2]
    cmp al, "2"
    jne errR2spe

    mov al, byte [rbx +3]
    cmp al, NULL
    jne errR2spe

    ;check if argv[4] is a nonary number    errR2value
    mov r12, rsi
    mov rdi, qword [r12+32]
    call cvtnonary2int
    cmp eax, 0
    jl errR2valuee

    cmp eax, R2_MAX
    ja errR2valuee

    cmp eax, R2_MIN
    jb errR2valuee


    ;check if argv[5] is -h     errHsp
    mov rbx, qword [rsi +40]
    mov al, byte [rbx]
    cmp al, "-"
    jne errHspe

    mov al, byte [rbx +1]
    cmp al, "h"
    jne errHspe

    ;check if argv[6] is a nonary number    errHvalue
    mov r12, rsi
    mov rdi, qword [r12+48]
    call cvtnonary2int
    cmp eax, 0
    jl errHvaluee

    cmp eax, H_MAX
    ja errHvaluee

    cmp eax, H_MIN
    jb errHvaluee


    ;check if argv[7] is -w     errWsp
    mov rbx, qword [rsi +56]
    mov al, byte [rbx]
    cmp al, "-"
    jne errWspe

    mov al, byte [rbx +1]
    cmp al, "w"
    jne errWspe

    ;check if argv[8] is a nonary number    errWvalue
    mov r12, rsi
    mov rdi, qword [r12+64]
    call cvtnonary2int
    cmp eax, 0
    jl errWvaluee

    cmp eax, W_MAX
    ja errWvaluee

    cmp eax, W_MIN
    jb errWvaluee


    ;check if argv[9] is -cl    errCLsp
    mov rbx, qword [rsi +72]
    mov al, byte [rbx]
    cmp al, "-"
    jne errCLspe

    mov al, byte [rbx +1]
    cmp al, "c"
    jne errCLspe
    
    mov al, byte [rbx +2]
    cmp al, "l"
    jne errCLspe

    mov al, byte [rbx +3]
    cmp al, NULL
    jne errCLspe

    ;check if argv[10] is a nonary number   errCLvalue
    mov r12, rsi
    mov rdi, qword [r12+80]
    call cvtnonary2int
    cmp eax, 0
    jl errCLvaluee

    cmp eax, CL_MAX
    ja errCLvaluee

    cmp eax, CL_MIN
    jb errCLvaluee


jmp donee


errUsagee:
    mov rdi, errUsage
    jmp printIt

errR1spe:
	mov rdi, errR1sp
	jmp printIt

errR1valuee:
	mov rdi, errR1value
	jmp printIt

errR2spe:
	mov rdi, errR2sp
	jmp printIt

errR2valuee:
	mov rdi, errR2value
	jmp printIt

errHspe:
	mov rdi, errHsp
	jmp printIt

errHvaluee:
	mov rdi, errHvalue
	jmp printIt

errWspe:
	mov rdi, errWsp
	jmp printIt

errWvaluee:
	mov rdi, errWvalue
	jmp printIt

errCLspe:
	mov rdi, errCLsp
	jmp printIt

errCLvaluee:
	mov rdi, errCLvalue
	jmp printIt

errBadCLe:
    mov rdi, errBadCL
    jmp printIt

printIt:
	call printString
	mov rax, FALSE
	jmp donee




donee:

    pop r12
ret




; ******************************************************************
;  Function: cvtnonary2int()
;  Boolean function to convert nonary string to integer.
global cvtnonary2int
cvtnonary2int:
	push r12
	push r13
	push r11
	push rax

	mov r12, rdi
	mov r13, 0

	mov eax, 0

startLoop1:
    mov ecx, 0
    mov cl, byte[r12+r13]
    cmp cl, NULL
    je endOfString1
    sub cl, "0"
	
	;if cl is not a number, return 0
	cmp cl, 0
	jl errV
	cmp cl, 9
	jg errV

    mov r11d, 9
    mul r11d
    add eax, ecx
    inc r13
    jmp startLoop1

endOfString1:
    mov rdi, rax

errV:
	mov rdi, -1


doneee:
	pop rax
	pop r11
	pop r13
	pop r12

ret




; ******************************************************************
;  Function: drawTorus()
;  Torus Plotting Function.

; -----
;  Basic flow:
;	set openGL drawing initializations
;	set draw color (i.e., glColor3ub)
;	convert integer values to float for calculations
;	calculate number of iterations (for loops)
;	for (double t=0.0; t<(2.0*pi); t+=tStep) {
;		for (double u=0.0; u<(2.0*pi); u+=tStep) {
;			x = 70.0 * (cos(t) * (radius1/10 + (radius2/10 * cos(u))));
;			y = 70.0 * (sin(t) * (radius1/10 + (radius2/10 * cos(u))));
;			z = 70.0 * (radius2/10 * sin(u));
;		        glVertex3f(x, y, z);
;		}
;	}
;	close openGL plotting (i.e., glEnd and glFlush)

;  The loop is from 0.0 to 2*pi by tStep.
;   Note, tStep is define in main and accessible via below common statement.

; -----
;  Global variables accessed
;	There are defined and set in the main, accessed herein by
;	name as per the below declarations.

common	viewAngle	1:4		; viewAngle, dword, float value
common	tipAngle	1:4		; tipAngle, dword, float value
common	tStep		1:4		; tStep (increment)
common	radius1		1:4		; radius 1, dword, integer value
common	radius2		1:4		; radius 2, dword, integer value
common	color		1:4		; color code letter, byte, ASCII value

global drawTorus
drawTorus:





; -----
;  Set openGL drawing initializations

	; glClear(GL_COLOR_BUFFER_BIT);
	mov	rdi, GL_COLOR_BUFFER_BIT
	call	glClear

	; glPushMatrix();
	call	glPushMatrix

	; glRotatef(viewAngle, 1.0, 0.0, 0.0);
	movss	xmm0, dword [viewAngle]
	movss	xmm1, dword [fltOne]
	movss	xmm2, dword [fltZero]
	movss	xmm3, dword [fltZero]
	call	glRotatef

	; glRotatef(tipAngle, 0.0, 1.0, 0.0);
	movss	xmm0, dword [tipAngle]
	movss	xmm1, dword [fltZero]
	movss	xmm2, dword [fltOne]
	movss	xmm3, dword [fltZero]
	call	glRotatef

	; glPointSize(1.5);
	movss	xmm0, dword [fltOnePtFive]
	call	glPointSize

	; glBegin(GL_POINTS);
	mov	rdi, GL_POINTS
	call	glBegin

; -----
;  Set draw color(r,g,b)


; -----
;  Convert integers to floats for use in formulas.



; -----
;  Calculate iterations (2*pi/tStep)



; ----
;  Main plotting loops



; -----
;  Plotting done.

	call	glEnd
	call	glPopMatrix
	call	glFlush

; -----
;  Done, pop's and return


	ret

; ******************************************************************
;  Generic procedure to display a string to the screen.
;  String must be NULL terminated.

;  Algorithm:
;	Count characters in string (excluding NULL)
;	Use syscall to output characters

;  Arguments:
;	- address, string
;  Returns:
;	nothing

global	printString
printString:
	push	rbp
	mov	rbp, rsp
	push	rbx
	push	rsi
	push	rdi
	push	rdx

; -----
;  Count characters in string.

	mov	rbx, rdi			; str addr
	mov	rdx, 0
strCountLoop:
	cmp	byte [rbx], NULL
	je	strCountDone
	inc	rbx
	inc	rdx
	jmp	strCountLoop
strCountDone:

	cmp	rdx, 0
	je	prtDone

; -----
;  Call OS to output string.

	mov	rax, SYS_write			; system code for write()
	mov	rsi, rdi			; address of characters to write
	mov	rdi, STDOUT			; file descriptor for standard in
						; EDX=count to write, set above
	syscall					; system call

; -----
;  String printed, return to calling routine.

prtDone:
	pop	rdx
	pop	rdi
	pop	rsi
	pop	rbx
	pop	rbp
	ret

; ******************************************************************


