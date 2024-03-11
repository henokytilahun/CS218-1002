;  Name: Henok Tilahun
;  NSHE_ID: 5007740928
;  Section: 1002
;  Assignment: 1
;  Description: Simple assembly language example
;   No name, asst, section -> no points!


; *****************************************************************
;  Data Declarations
;	Note, all data is declared statically (for now).
          
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
; *****************************************************************
;  Code Section

section	.text
global _start
_start:

; ----------








; *****************************************************************
;	Done, terminate program.

last:
	mov	rax, SYS_exit
	mov	rdi, EXIT_SUCCESS
	syscall

