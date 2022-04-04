.model small                                                                                                                                                                    
.stack 100h
                                           
.data                                                                                                                                                                           
courseName db "Computer circuitry - 2. Peripherals",0dh,0ah,'$'                                                                                                                                                                                                                                                     
labNumber db "Lab work 1",0dh,0ah,'$'
newLine db " ",0dh,0ah,'$'
anyKey db "Press any key to continue...",'$'
var db "stroka$"
ak db "adbc"


.code
main proc       
mov ax,@data                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
mov ds,ax

mov ah,9
mov dx,offset var
int 21h

mov di,var
mScan:
        cmp byte[di], '$'
        je mEnd
        inc di
        jmp mScan
mEnd:
        inc di
        mov byte[di], 'x'

mov ah,9
mov dx,offset var
int 21h



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
