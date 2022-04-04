.model small                                                                                                                                                                    
.stack 256h
                                           
.data                                                                                                                                                                           
courseName db "Computer circuitry - 2. Peripherals",0dh,0ah,'$'                                                                                                                                                                                                                                                     
labNumber db "Lab work 1",0dh,0ah,'$'
anyKey db "Press any key to continue...",'$'
newLine db " ",0dh,0ah,'$'
min db " min ",'$'
sec db " sec ",'$'
String db 5 dup (?), '$'
StringEnd = $-1
repeat dw 4
startSec db 0
startMin db 0
finishSec db 0
finishMin db 0


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

mov al, 2h             
out 70h, al            
in al, 71h
mov startMin, al
mov finishMin, al
call ShowMin

mov al, 0h             
out 70h, al            
in al, 71h
mov startSec, al
mov finishSec, al
call ShowSec

mov ah,9
mov dx,offset newLine
int 21h

mov si,repeat
cycle:
        call Delay
        dec si
        jnz cycle       


mov al, 2h         
out 70h, al        
in al, 71h         
mov finishMin,al
call ShowMin

mov al, 0h         
out 70h, al        
in al, 71h         
mov finishSec,al
call ShowSec

mov al,finishMin
mov bl,startMin
cmp al,bl
jne NotOnlySeconds


mov al,finishSec
mov bl,startSec
sub al,bl
mov finishSec,al
mov finishMin,0
jmp Finish

NotOnlySeconds:
sub al,bl
mov finishMin,al
mov al,finishSec
mov bl,startSec
cmp al,bl
jae FinishAboveStart

FinishAboveStart:
mov al,startSec
mov bl,finishSec
sub al,bl
mov bl,al
mov al,60d
sub al,bl
mov finishSec,al
mov al, finishMin
dec al
mov finishMin,al
jmp Finish

cmp al,bl
jb FinishBelowStart
FinishBelowStart:
mov ah,9
mov dx,offset courseName
int 21h

mov ah,9
mov dx,offset anyKey
int 21h
mov al,startSec
mov bl,finishSec
sub al,bl
mov bl,al
mov al,60d
sub al,bl
mov finishSec,al
mov al, finishMin
dec al
mov finishMin,al
jmp Finish

Finish:
mov ah,9
mov dx,offset newLine
int 21h
call ShowMin
call ShowSec

mov ah,9
mov dx,offset newLine
int 21h


mov ah,9
mov dx,offset anyKey
int 21h

mov ah,1
int 21h
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
mov ax,4c00h
int 21h


;----------output minutes----------
ShowMin:
        mov ax,@data                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
        mov ds,ax
        mov cx,0
        xor ax,ax
        xor bx,bx
        xor dx,dx
        mov ah,0
        mov al, finishMin
        mov bx,10
        dvsn:
                div bx
                push dx
                xor dx,dx
                inc cx
                test ax,ax
                jnz dvsn
        mov ah,02h
        ot: 
                pop dx
                add dx,'0'
                int 21h 
                loop ot
        mov ah,9
        mov dx,offset min
        int 21h

        ret

;----------output seconds----------
ShowSec:
        mov ax,@data                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
        mov ds,ax
        mov cx,0
        xor ax,ax
        xor bx,bx
        xor dx,dx
        mov ah,0
        mov al, finishSec
        mov bx,10
        dvsn1:
                div bx
                push dx
                xor dx,dx
                inc cx
                test ax,ax
                jnz dvsn1
        mov ah,02h
        ot1: 
                pop dx
                add dx,'0'
                int 21h 
                loop ot1
        mov ah,9
        mov dx,offset sec
        int 21h

        ret

;--------delay with system time use---------
Delay:
        mov ax,40h
        mov es,ax                                                                                                                                                                                                                                                                                                      
        mov ax,es:[6ch]
        add ax,182d
        cmploop:
                cmp ax,es:[6ch]
        jnz cmploop
        ret


main endp
end main
