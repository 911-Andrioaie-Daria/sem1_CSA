;The program computes the expression d-[3*(a+b+2)-5*(c+2)]

bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 10
    b db 13
    c db 8
    d dw 1300

segment code use32 class=code
    start:
    
    ;3*(a+b+2)
    
        mov AL, [a] ;AL = a                            
        add AL, [b] ;AL = AL+b  ;a+b
        add AL, 2   ;AL = AL+2  ;a+b+2
        
        mov AH, 3   ;AH=3
        mul AH      ;AX <- AL*AH  ;3*(a+b+2)
        
        mov BX, AX  ;BX=AX    ;BX=3*(a+b+2)
    
    ;5*(c+2)
    
        add byte[c], 2 ;c=c+2
        mov AL, [c]    ;AL=c+2
        
        mov AH, 5
        mul AH          ;AX <- AL*AH ;AX=5*(c+2)
        
        
    ;3*(a+b+2)-5*(c+2)
        sub BX, AX     ;BX=BX-AX   ;BX=3*(a+b+2)-5*(c+2)
        
        sub [d], BX    ;d=d-BX     ;d=d-[3*(a+b+2)-5*(c+2)]
        
        mov AX, [d]    ;AX=d
        
    ;now, the result of the expression is stored in AX=1275
        
        push dword 0
        call [exit]