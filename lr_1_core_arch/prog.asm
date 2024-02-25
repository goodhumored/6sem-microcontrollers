;*******************************************************************
; *
; Filename: prog.asm *
; Date: 2024/02/25 *
; File Version: 0 *
; Author: Nekrasov K.S. *
; Company: SUAI *
; Description: lr 1.1 *
; *
;*******************************************************************
x equ 28h
y equ 29h
z equ 2ah
buf equ 2bh
rez equ 30h;
;*******************************************************************
; Reset Vector
;*******************************************************************
RES_VECT CODE 0x0000 ; processor reset vector
SJMP START ; go to beginning of program
;*******************************************************************
; MAIN PROGRAM
;*******************************************************************
MAIN_PROG CODE 0x0100
START:
MOV a, x ;/x -> a
MOV b, z ;/z -> b
DIV ab ;x/z -> a
SUBB a, y ;x/z - y -> a
MOV buf,a ; a -> buf

MOV a,y
MOV b,#2
MUL ab
ADD a,z

MOV b,#4
DIV ab

MOV b, buf

MUL ab

mov rez,a

SJMP $ ; loop forever
END