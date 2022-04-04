.model small                                                                                                                                                                    
.stack 100h
                                           
.data                                                                                                                                                                           
courseName db "Computer circuitry - 2. Peripherals",0dh,0ah,'$'                                                                                                                                                                                                                                                     
labNumber db "Lab work 1",0dh,0ah,'$'
newLine db " ",0dh,0ah,'$'
anyKey db "Press any key to continue...",'$'
repeat dw 5
time dw 364

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

call input
call delay

mov si,repeat
cycle:                                                                                                                                                                                                                                                                                                                                                                                                                                  
        call output
        call delay
        dec si
        jnz cycle       

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

;------------read from keyboard-------------
input:
        mov cx,0fh
        mov bx,05fh
        m1:
                mov ah,1h
                int 21h
                mov [bx],al
                add bx,2h
        loop m1
        ret

;----------output keyboard buffer-----------
output:
        mov cx,0fh
        mov bx,05fh
        m2:
                mov dl,[bx]
                add bx,2h
                mov ah,2h
                int 21h
        loop m2
        ret        

;--------delay with system time use---------
delay:
        mov ax,40h
        mov es,ax                                                                                                                                                                                                                                                                                                      
        mov ax,es:[6ch]
        add ax,time
        cmploop:
                cmp ax,es:[6ch]
        jnz cmploop
        ret


main endp
end main
