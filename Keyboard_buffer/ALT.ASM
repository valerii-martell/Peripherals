.model small                                                                                                                                                                    
.stack 256

.data 
titleWelcome db "Hello! I'm your Laba. PRESS ALT PLEASE", 13,10, "$"
msgKeyPressed db "Who pressed ALT?", 13,10, "$"
seconds db ?
.code
main proc   

	mov ax,@data                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
	mov ds,ax 
	
	mov ah,09h		;type of interrupt - string output
	mov dx,offset titleWelcome
	int 21h
	

;first check the ALT button press
begin:
	mov ah,2
    int 16h     ; GET SHIFT FLAGS
    test al,8   ; Alt
    je begin
	

mov ah,09h	
mov dx,offset msgKeyPressed
int 21h   

;read begin time seconds from Real Time Clock
mov al, 0h		;there is number of seconds in bcd
out 70h, al		;write an address
in al, 71h		;read seconds
mov dl, al
;mov seconds, dl
;call showTime


        mov ax,40h
        mov es,ax
        mov al,0
        mov es:[17h],al
       


;second check the ALT button press
begin2:
mov ah,2
    int 16h     ; GET SHIFT FLAGS
    test al,8   ; Alt
    je begin2
	;jnz done2
    ;jmp begin2
	
;done2:
mov ah,09h	
mov dx,offset msgKeyPressed
int 21h 

;read end time seconds from Real Time Clock
mov al, 0h		;there is number of seconds in bcd
out 70h, al		;write an address
in al, 71h		;read seconds

sub al, dl
das		;Decimal adjust after subtraction
mov seconds, al

call showTime

mov    ah,4ch            ; функция DOS завершения пргоораммы
int    21h 


;output the result
showTime:
mov ax,@data                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
mov ds,ax
mov cx,0
xor ax,ax
xor bx,bx
xor dx,dx
mov ax,0
mov al, seconds
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
	ret

main endp
end main
