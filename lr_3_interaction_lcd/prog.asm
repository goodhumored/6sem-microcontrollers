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
; Variables
;*******************************************************************
switch equ 43h ;переключатель «команда-данные» (RS)
bte equ 44h ;выдаваемый на ЖКИ байт
;*******************************************************************
; Reset Vector
;*******************************************************************
org 0h ; processor reset vector
ajmp start ; go to beginning of program
;*******************************************************************
; MAIN PROGRAM
;*******************************************************************
org 100h
start: 
  ; Инициализация ЖКИ
  mov switch, #0  ; переключатель на команду
  mov bte, #38h   ; ширина ввода и 2 строки
  lcall write_led ; вызов подпрограммы передачи в ЖКИ
  mov bte, #0fh   ; активация всех знакомест
  lcall write_led
  mov bte, #06h   ; режим автом. перемещения курсора
  lcall write_led
  mov bte, #88h   ; установка адреса первого символа
  lcall write_led

  ;вывод строк
  mov switch, #1 ;переключатель на данные
  mov dptr, #0fd0h ;адрес, по которому расположены данные

  row1: ;вывод символов первой строки
    clr a
    movc a, @a+dptr
    mov bte, a
    lcall write_led
    inc dptr
    mov a, dpl ; младший байт указателя данных
    cjne a, #0d4h, row1 ; пока не введены 4 символа 1ой строки
  
  mov switch, #0 ;команда
  mov bte, #0C4h ;установка адреса первого символа второй строки
  lcall write_led
  mov switch, #1 ;RS=1 - данные

  row2: ;вывод символов второй строки
    clr a
    movc a, @a+dptr
    mov bte, a
    lcall write_led
    inc dptr
    mov a, dpl
    cjne a, #0e0h, row2
  
  ;d4h+12h=e0h – адр. конца второй стр.
  jmp finish ;переход на конец программы
  

write_led: ;подпрограмма передачи в ЖКИ
  mov p2, bte ;передаваемый байт – в Р2
  setb p1.6   ;E:=1
  clr p1.7    ;RW:=0 (запись)

  mov a, switch
  mov c, acc.0 ;нам нужен 0-ой бит аккумулятора
  mov p1.5, c ;RS:=switch (команда/данные)

  lcall delay ;вызов подпрограммы задержки

  clr p1.6 ;E:=0

  lcall delay

  setb p1.6 ;E:=1
  ret 

delay: ;подпрограмма задержки на 40мкс
  push A ;сохраняем аккумулятор в стеке
  mov A, #0Ah ; 40 = 2+2+1+А(1+2)+1+2+2
  m: 
    dec A
  jnz m
  nop
  pop A ;восстанавливаем значение аккумулятора
  ret

org 0FD0h ;данные располагаем в памяти программ
data:
  db '4142'
  db 'K.S.Nekrasov'
finish: sjmp $ ;конец программы
end