.model tiny                                                                                                                                                                    
.stack 256h
                                           
.data                                                                                                                                                                           
courseName db "Computer circuitry - 2. Peripherals",0dh,0ah,'$'                                                                                                                                                                                                                                                     
labNumber db "Lab work 1",0dh,0ah,'$'
newLine db " ",0dh,0ah,'$'

String db 5 dup (?), '$'
StringEnd = $-1

hoursLabel db "Hours ",'$'                                                                                                                                                                                                                                                     
minutesLabel db "Minutes ",'$'                                                                                                                                                                                                                                                     
secondsLabel db "Seconds ",'$'

time dw 0

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

mov al,0Bh
out 70h,al
in al,71h
and al,11111011b
out 71h,al
mov al,0h
call printCMOS



call delay55ms



mov ah,1
int 21h
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
mov ax,4c00h
int 21h


;--------delay 55 ms---------
delay55ms:
mov cx,1
delay:
        mov al,04h
        out 43h,al
        in al,40h
        mov ah,al
        in al,40h
        cmp ax,0
        jne m1
        mov ax,0FFFFh
        m1: sub ax,1
        mov bx,ax
        m2: mov al,04h
        out 43h,al
        in al,40h
        mov ah,al
        in al,40h
        cmp ax,bx
        jne m2
        loop delay
        ret

printCMOS:

        out 70h,al
        in al,71h
        push ax
        shr ax,4
        add al,'0'
        int 29h
        pop ax
        and al,0Fh
        add al,30h
        int 29h
        ret

main endp
end main
                                
