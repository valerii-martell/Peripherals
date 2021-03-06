; rtctime,asm
; ����� �� ����� ������� ���� � ������� �� RTC
;
        .model     tiny
        .code
        .186                            ; ��� shr al,4
        org        100h                 ; ���-���������
start:
        mov        al,0Bh               ; CMOS OBh - ����������� ������� �
        out        70h,al               ; ���� 70h - ������ CMOS
        in         al,71h               ; ���� 71h - ������ CMOS
        and        al,11111011b         ; �������� ��� 2 (����� ����� - BCD)
        out        71h,al               ; � �������� �������
        mov        al,32h               ; CMOS 32h - ��� ������� ����� ����
        call       print_cmos           ; ����� �� �����
        mov        al,9                 ; CMOS 09h - ��� ������� ����� ����
        call       print_cmos
        mov        al,'-'               ; �����
        int        29h                  ; ����� �� �����
        mov        al,8                 ; CMOS 08h - ������� �����
        call       print_cmos
        mov        al,'-'               ; ��� ���� �����
        int        29h
        mov        al,7                 ; CMOS 07h - ����
        call       print_cmos
        mov        al,' '               ; ������
        int        29h
        mov        al,4                 ; CMOS 04h - ���
        call       print_cmos
        mov        al,'h'               ; ����� "h"
        int        29h
        mov        al,' '               ; ������
        int        29h
        mov        al,2                 ; CMOS 02h - ������
        call       print_cmos
        mov        al,':'               ; ���������
        int        29h
        mov        al,0h                ; CMOS 00h - �������
        call       print_cmos
        ret

; ��������� print_cmos
; ������� �� ����� ���������� ������ CMOS � ������� � AL
; �������, ��� �����, �������� �� CMOS, ��������� � ������� BCD
print_cmos proc near
        out        70h,al               ; ������� AL � ��������� ���� CMOS
        in         al,71h               ; ��������� ������
        push       ax
        shr        al,4                 ; �������� ������� ������ ����
        add        al,'0'               ; �������� ASCII-��� ����� 0
        int        29h                  ; ������� �� �����
        pop        ax
        and        al,0Fh               ; �������� ������� ������ ����
        add        al,30h               ; �������� ASCII-��� ����� 0
        int        29h                  ; ������� �� �����
        ret
print_cmos endp
        end        start
