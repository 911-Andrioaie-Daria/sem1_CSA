;The program computes the expression a-c+d-7+b-(2+d)

bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 50
    b dw 7
    c dw 10
    d dw 110

segment code use32 class=code
    start:
    
        mov AX, [a] ;AX=a      ;a           ==50
        sub AX, [c] ;AX=AX-c   ;a-c         ==40 
        add AX, [d] ;AX=AX+d   ;a-c+d       ==150
        sub AX, 7   ;AX=AX-7   ;a-c+d-7     ==143
        add AX, [b] ;AX=AX+b   ;a-c+d-7+b   ==150
        
        add word[d], 2 ;d=d+2 =112
        
        sub AX, [d] ;AX=AX-d   ;a-c+d-7+b-(2+d)  == 38
        
    ;The final result is stored in AX, which is 312
        
        push dword 0
        call [exit]