name "add-sub"

org 100h
; first num   =  3,000,000,000
;mov [2002], 5e00h            ;bit thap
;mov [2004], 0b2d0h            ; bit cao 
; first num   =  1,000,000,000
mov [2002], 0ca00h            ;bit thap
mov [2004], 3b9ah            ; bit cao
; second num  =  2,000,000,000

mov [2010], 9400h        ; bit thap
mov [2012], 7735h        ; bit cao



; cong bit thap
adc dx, [2002]
adc dx , [2010]
;cong bit cao 
adc bx, [2012]
adc bx , [2004]
; code overload here
JC NEXT
JMP NEXT_TO
NEXT:
mov al, 0
add al , 1
mov cx, 1
print0: mov ah, 2   ; print function.
       mov dl, '0'
       test al, 1b  ; test first bit.
       jz zero0
       mov dl, '1'
zero0:  int 21h
       shl al, 1
loop print0  
jmp NEXT_TO
NEXT_TO: 



; in ra 16 bit cao
mov cx, 16
print1: mov ah, 2   ; print function.
       mov dl, '0'
       test bx, 1000000000000000b  ; test first bit.
       jz zero1
       mov dl, '1'
zero1:  int 21h
       shl bx, 1
loop print1  


; in ra 16 bit thap
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


