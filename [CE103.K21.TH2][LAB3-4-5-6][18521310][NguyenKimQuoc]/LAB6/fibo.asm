
jmp start

; text data:
msg1 db 0Dh,0Ah, "Nhap n: $"
msg2 db 0Dh,0Ah, "Nhap lai n lon hon hoac bang 1: $"
msg3 db 0Dh,0Ah, "Nhap lai n be hon hoac bang 45: $"
msg4 db          " so fibonacci dau tien la: $" 

buffer db 7,?, 5 dup (0), 0, 0
a1 db 10 dup(0),1
a2 db 10 dup(0),1
a  db 11 dup(0), 

n dw ?

nhaplai1:
mov dx, offset msg2
mov ah, 9
int 21h                    
jmp resetinput

nhaplai2:
mov dx, offset msg3
mov ah, 9
int 21h
jmp resetinput

start:
 
; nhap n
mov dx, offset msg1
mov ah, 9
int 21h                         

resetinput:

; input string:
mov dx, offset buffer
mov ah, 0ah
int 21h

;dam bao chuoi chua ket thuc giua chung :
mov bx, 0
mov bl, buffer[1]
mov buffer[bx+2], 0


lea    si, buffer + 2  ; bat dau tu byte thu 3.
call    tobin

jmp fibonacci    
                           ; ham con  \
                           ; day gia tri vao ngan xep stack
tobin   proc    near
        push    dx
        push    ax
        push    si
   
   
jmp process
            
make_minus      db      ?       ; su dung lam co <flag>.
ten             dw      10      ; su dung lam cap so <multiplier>.

process:       

        ; reset so lan lap
        mov     cx, 0

        ; reset flag:
        mov     cs:make_minus, 0

next_digit:

    ; doc 1 ki tu trong al va tro den phan tu ke tiep
    mov     al, [si]
    inc    si     

        ; kiem tra ket thuc chuoi
        cmp     al, 0  
        jne     not_end
        jmp     stop_input       
not_end:

        ; kiem tra so am:
        cmp     al, '-'
        jne     ok_digit
        mov     cs:make_minus, 1 ; set flag!
    jmp     next_digit
   
ok_digit:

        ; nhan cx vs 10
        push    ax
        mov     ax, cx
        mul     cs:ten                  ; dx:ax = ax*10
        mov     cx, ax
        pop     ax


        ; chuyen sang ma ascii code:
        sub     al, 30h

        ; add al to cx:
        mov     ah, 0
        mov     dx, cx      ; luu kq vao dx
        add     cx, ax
       
        ; add - overflow not checked!

        jmp     next_digit

stop_input:

        ;kiem tra flag vs dk de nhap lai
        cmp     cs:make_minus, 0
        je      not_minus
        neg     cx
       
not_minus:
        cmp     cx, 1
        jc      nhaplai1
        
        cmp     cx, 45
        ja      nhaplai2  
                                ; khoi phuc lai gia tri
        mov     n, cx
        pop     si
        pop     ax
        pop     dx  
        ret
tobin        endp        


;///////////////////////////////////////////////////////////////
          

in2:      
          mov a[10], 1
          call inra       
          
in1:          mov a[10], 1
          call inra  
          jmp out

           
inra proc near            ; ham in so
        
        push    dx
        push    ax
        push    cx
        lea dx, a
        mov cx, 11 
        mov di, dx
        mov ah, 2
        mov dl, 0Ah
        int 21h 
        mov dl, 0Dh
        int 21h
        jmp inra1:
inra1: 
        mov dl, [di]
        or dl, 30h
        mov ah, 2
        int 21h
        inc di
        loop inra1:  
        
        pop dx
        pop ax
        pop cx
        ret

fibonacci: 
           mov dx,10
           mov ah,2
           int 21h 
           mov dx,0
           
           mov dx,13
           mov ah,2
           int 21h
           mov dx,0
           
                    
           mov ax,n
           mov bl, 10
           div bl
           mov cx,ax
           ; xuat chu so dau tien
           mov dl,cl
           add dl,30h     
           mov ah,2  
           int 21h    
           ; xuat chu so thu 2
           mov dl,0
           mov dl,ch
           add dl,30h
           mov ah,2  
           int 21h
           mov dx,0
            
           mov dx, offset msg4
           mov ah, 9
           int 21h
           mov dx, 0
             
         
           
           cmp n,1          ; neu n = 1 nhay in1
           je in1:
           
           cmp n,2          ; neu n = 2 nhay in2
           je in2:  

           
           mov a[10], 1 
           lea dx, a
           mov cx, 11
           mov di, dx
           call inra      
           
           mov a[10], 1 
           lea dx, a
           mov cx, 11
           mov di, dx
           call inra  
          
           sub [n], 1
           
           for:  
           sub [n], 1
           lea si, a1+10
           lea di, a2+10
           lea bx, a+10  
           mov al, 0
           mov cx, 11
           
           cong:            ; cong cac phan tu cua 2 mang voi nhau
                                                                                             
           mov dl, [si]
           add dl, [di]
           add dl, al
           mov al, 0
           cmp dl, 10
           jnb cong10:        ; nhay neu tran so
                            
           mov [bx], dl
           sub si, 1
           sub di, 1
           sub bx, 1
           
           loop cong:
jmp out1
               
           cong10:
           sub dl,10
           mov [bx], dl  
           add al, 1 
           sub si, 1
           sub di, 1
           sub bx, 1  
           
           loop cong:     
           
out1:           
           call inra 
           
           mov cx, 11
           lea si, a1+10
           lea di, a2+10
           lea bx, a+10  
           
           l1:
           mov dl, [di] 
           mov [si], dl
           mov dh, [bx]
           mov [di], dh
           sub si, 1
           sub di, 1
           sub bx, 1 
           loop l1:
           
           mov cx, [n]
           loop for:
          
out: