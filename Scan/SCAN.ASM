.model   tiny
.stack 256h
; ��������� �� �������� AAM c ���������� ��������� - ����� �����
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
cvt:    .aam     16              ; al / 16 -> ah - �������, al - �������
    or  ax, 3030h       ; ����������� � ������� ASCII
    call    @0              ; �������  ������� �������
@0: xchg    al, ah          ; ������ ������� 
    cmp al, 39h         ; ���� ��� ������� 
    jbe @1              ; ������ '9'?
    add al, 7           ; �� ������������ ��� �� 'A'-'F'
@1: int 29h         ; ������� �� �����
    ret
crlf:   mov ax, 0D0Ah
    int 29h
    xchg    ah,al
    int 29h
    ret
    end start
