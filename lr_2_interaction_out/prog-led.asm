;*******************************************************************
; *
; Filename: prog-led.asm
; Date: 2024/02/29
; File Version: 1
; Author: Nekrasov K.N.
; Company: SUAI
; Description:
; *
;*******************************************************************
; Reset Vector
;*******************************************************************
org 0h
 ; processor reset vector
ajmp start
 ; go to beginning of program
;*******************************************************************
; MAIN PROGRAM
;*******************************************************************
org 100h

start:
  mov P1,#0
  mov P3,#0 

loop:
  mov P2,#0

  mov P3,#10010110b

  mov P1,#00111100b
  mov P2,#00010001b

  lcall delay
  mov P2,#0

  mov P1,#00100010b
  mov P2,#11101110b

  lcall delay
  sjmp loop

delay: ;подпрограмма задержки
  nop
  nop
  nop
  nop
  nop
  nop
  ret

finish: sjmp $ ;конец программы
end 