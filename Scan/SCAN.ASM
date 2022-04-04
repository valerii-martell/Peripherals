.model   tiny
.stack 256h
; Труппоасм не понимает AAM c основанием счисления - пишем макро
.aam    macro   power
    db  0D4h, power
    endm
.code
    org 100h
start:  xor ah, ah
    int 16h
    cmp ah, 1   ; <Esc>?
    jz  done
    int 29h
    mov al, 20h
    int 29h
    mov al, ah
    call    cvt
    call    crlf
    jmp start
done:   int 20h
cvt:    .aam     16              ; al / 16 -> ah - десятки, al - единицы
    or  ax, 3030h       ; преобразуем в символы ASCII
    call    @0              ; десятки  выводим первыми
@0: xchg    al, ah          ; меняем местами 
    cmp al, 39h         ; если код символа 
    jbe @1              ; больше '9'?
    add al, 7           ; то корректируем его до 'A'-'F'
@1: int 29h         ; выводим на экран
    ret
crlf:   mov ax, 0D0Ah
    int 29h
    xchg    ah,al
    int 29h
    ret
    end start
