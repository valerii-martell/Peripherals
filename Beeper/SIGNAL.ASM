.model small
.stack 100h
                                           
.data

courseName db "Computer circuitry - 2. Peripherals",0dh,0ah,'$'                                                                                                                                                                                                                                                     
labNumber db "Lab work 1",0dh,0ah,'$'
newLine db " ",0dh,0ah,'$'
anyKey db "Press any key to continue...",'$'

f dw 1193
t dw 182

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


in al,61h
and al,11111100b
out 61h,al

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

main endp
end main
