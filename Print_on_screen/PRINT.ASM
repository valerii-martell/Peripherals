.model small
.stack 100h

.data
message db "Hello world",0dh,0ah,'$'
anyKey db "Press any key to continue...",'$'

.code
main proc       
mov ax,@data
mov ds,ax

mov ah,9
mov dx,offset message
int 21h

mov ax,40h
mov es,ax
mov ax,es:[6ch]
add ax,182
cmploop:
cmp ax,es:[6ch]
jnz cmploop

mov ah,9
mov dx, offset anyKey
int 21h

mov ah,1
int 21h

mov ax,4c00h
int 21h

main endp
end main        

