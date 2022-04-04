.model small                                                                                                                                                                    
.stack 100h
                                           
.data                                                                                                                                                                           
courseName db "Computer circuitry - 2. Peripherals",0dh,0ah,'$'                                                                                                                                                                                                                                                     
labNumber db "Lab work 1",0dh,0ah,'$'
newLine db " ",0dh,0ah,'$'
surname db "Dayko",'$'                                                                                                                                                                                                                             

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

Infinity:

MinutesCheck:
mov AL, 2h
out 70h, AL
in AL, 71h
mov AH, AL

mov AL, 0h
out 70h, AL
in AL, 71h

cmp AL,AH
je MinutesEqualsSeconds


HoursCheck:
mov AL, 4h
out 70h, AL
in AL, 71h
mov AH, AL

mov AL, 0h
out 70h, AL
in AL, 71h

cmp AL,AH
je HoursEqualsSeconds

jmp Infinity


MinutesEqualsSeconds:
        call ShowSurname
        call Delay
        jmp HoursCheck

HoursEqualsSeconds:
        call ShowSurname
        call Delay
        jmp MinutesCheck


;------------show surname repeat times-------------
ShowSurname:
        mov si,5
        cycle:
                mov ah,9
                mov dx,offset surname
                int 21h
                dec si
                jnz cycle
        ret

;--------------deley 1 sec----------------
Delay:
        mov ax,40h
        mov es,ax                                                                                                                                                                                                                                                                                                      
        mov ax,es:[6ch]
        add ax,19
        cmploop:
                cmp ax,es:[6ch]
        jnz cmploop
        ret


main endp
end main
