.model small                                                                                                                                                                    
.stack 100h
                                           
.data                                                                                                                                                                           
courseName db "Computer circuitry - 2. Peripherals",0dh,0ah,'$'                                                                                                                                                                                                                                                     
labNumber db "Lab work 1",0dh,0ah,'$'
newLine db " ",0dh,0ah,'$'
String db 5 dup (?), '$'
StringEnd = $-1
f dw 1193
t dw 1

.code
main proc       
mov ax,@data                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
mov ds,ax

mov ah,9
mov dx,offset courseName
int 21h

mov ah,9
mov dx,offset labNumber
int 21h

Beep:

call ShowFrequency

BadKey:

in al,61h
or al,3
out 61h,al

mov al,0B6h
out 43h,al

mov dx,f
mov al,dl
out 42h,al
mov al,dh
out 42h,al

mov ah,0
int 1ah
mov bx,dx
add bx,t
pointer: int 1ah
cmp dx,bx
jne pointer


mov ax,00h
int 16h
cmp al,68h ;h
je PressH
cmp al,6Ch ;l
je PressL
cmp al,73h ;s - stop
je Stop
cmp al,68h
jne BadKey

PressH:
mov ax,f
sub ax,100
mov f,ax
jmp Beep

PressL:
mov ax,f
add ax,100
mov f,ax
jmp Beep

Stop:
in al,61h
and al,11111100b
out 61h,al

mov ah,4ch
int 21h

;----------output frequency-----------
ShowFrequency:
        mov ax,@data
        mov ds,ax
        mov cx,0
        xor ax,ax
        xor bx,bx
        xor dx,dx
        mov ax,0
        mov al,20h
        mov bx,10
        dvsn:   div bx
                push dx
                xor dx,dx
                inc cx
                test ax,ax
                jnz dvsn
        mov ah,02h
        ot:     pop dx
                add dx,'0'
                int 21h
                loop ot
        mov ah,9
        mov dx,offset newLine
        int 21h
        ret

main endp
end main
