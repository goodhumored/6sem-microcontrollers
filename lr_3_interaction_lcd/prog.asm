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
  mov switch, #0 ; переключатель уст-ть на команду (RS=0)
  mov bte, #38h  ; байт – команда
  lcall indic_wr ; вызов подпрограммы передачи в ЖКИ
  mov bte, #0fh  ; активация всех знакомест
  lcall indic_wr
  mov bte, #06h  ; режим автом. перемещения курсора
  lcall indic_wr
  mov bte, #80h  ; установка адреса первого символа
  lcall indic_wr

  ;вывод строк
  mov switch, #1 ;переключатель – данные (RS=1)
  mov dptr, #0fd0h ;адрес, по которому расположены данные
                   ;(см. конец программы)

indic_data_wr1: ;вывод символов первой строки
  clr a
  movc a, @a+dptr

ind_row1:
  mov bte, a ;передаваемый байт – код символа
  lcall indic_wr
  inc dptr
  mov a, dpl ;младший байт указателя данных
  cjne a, #0E3h, indic_data_wr1 ;пока не введены 19 символов 1ой строки
  
  mov switch, #0 ;RS=0 – команда
  mov bte, #0C0h ;установка адреса первого символа второй строки
  lcall indic_wr
  mov switch, #1 ;RS=1 - данные

indic_data_wr2: ;вывод символов второй строки
  clr a
  movc a, @a+dptr

ind_row2: 
  mov bte, a
  lcall indic_wr
  inc dptr
  mov a, dpl
  cjne a, #0F6h, indic_data_wr2
  ;E3h+13h=F6h – адр. конца второй стр.
  jmp finish
  ;переход на конец программы
  

indic_wr: ;подпрограмма передачи в ЖКИ
  mov p2, bte ;передаваемый байт – в Р2
  setb p1.6   ;E:=1
  clr p1.7    ;RW:=0 (запись)

  mov a, switch
  mov c, acc.0 ;нам нужен 0-ой бит аккумулятора
  mov p1.5, c ;RS:=switch (команда/данные)

  lcall indic_delay ;вызов подпрограммы задержки

  clr p1.6 ;E:=0

  lcall indic_delay

  setb p1.6 ;E:=1
  ret 

indic_delay: ;подпрограмма задержки на 40мкс
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
  db 'it is test example.' ;директива db помещает коды
  db '0123456789ABCDFI@#$' ;символов в последовательные ячейки памяти программ
finish: sjmp $ ;конец программы
end