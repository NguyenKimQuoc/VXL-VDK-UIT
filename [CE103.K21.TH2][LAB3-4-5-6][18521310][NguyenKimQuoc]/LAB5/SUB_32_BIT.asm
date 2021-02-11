name "add-sub"
org 100h
; first num   =  800,000,000
mov [2002], 0800h            ;bit thap
mov [2004], 2fafh            ; bit cao

; second num  =  4,000,000,000

mov [2010], 2800h        ; bit thap
mov [2012], 0ee6bh        ; bit cao

  
add dx, [2010]  
sub dx , [2002] 
;mov bx , 0
JC next
adc bx, [2012]
sub bx , [2004]  
jmp next_to 
next:
adc bx, [2012]
sub bx , [2004]
sub bx, 2
next_to:

;in ra 16 bit cao
mov cx, 16
print1: mov ah, 2   ; print function.
       mov dl, '0'
       test bx, 1000000000000000b  ; test first bit.
       jz zero1
       mov dl, '1'
zero1:  int 21h
       shl bx, 1
loop print1  


;in ra 16 bit thap
mov cx, 16
print: mov ah, 2   ; print function.
       mov dl, '0'
       test dx, 1000000000000000b  ; test first bit.
       jz zero
       mov dl, '1'
zero:  int 21h
       shl dx, 1
loop print
 



; print binary suffix:
mov dl, 'b'
int 21h

; wait for any key press:
mov ah, 0
int 16h

ret


