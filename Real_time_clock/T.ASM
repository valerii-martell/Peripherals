.model small                                                                                                                                                                    
.stack 256h
                                           
.data                                                                                                                                                                           
courseName db "Computer circuitry - 2. Peripherals",0dh,0ah,'$'                                                                                                                                                                                                                                                     
labNumber db "Lab work 1",0dh,0ah,'$'
anyKey db "Press any key to continue...",'$'
newLine db " ",0dh,0ah,'$'
repeat dw 1

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

mov al,2
out 70h,al
in al,71h
call printAL

mov bl,al

mov al,':'
int 29h

mov  al,0h
out  70h,al
in al,71h
call printAL

sub al,bl
das
call printAL

mov ah,9
mov dx,offset newLine
int 21h

mov si,repeat
cycle:
        call Delay
        dec si
        jnz cycle       

mov al,2
out 70h,al
in al,71h
call printAL

mov al,':'
int 29h

mov  al,0h
out  70h,al
in al,71h
call printAL


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

;-------print al in decimal------
PrintAL:
        push       ax
        mov        cl, 4
        shr        al,cl  
        add        al,'0'
        int        29h   
        pop        ax
        and        al,0Fh
        add        al,30h               
        int        29h
        ret

main endp
end main
