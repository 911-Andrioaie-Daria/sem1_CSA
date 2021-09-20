;The program computes the expression (a-b)+(d-c)
bits 32

global start
extern exit

import exit msvcrt.dll

segment data use32 class=data
    a db 30
    b db 5
    c db 16
    d db 27
segment code use32 class=code
    start:
    
    ;(a-b)
        mov AL, [a]     ;AL=a
        sub AL, [b]     ;AL=AL-b=a-b
        
    ;(d-c)
        mov BL, [d] ;BL=d
        sub BL, [c] ;BL=BL-c=d-c
        
    ;add the two parantheses
        add AL, BL  ;AL=AL+BL=(a-b)+(d-c)
  
    ;The final result is stored in AL == 36
        
        push dword 0
        call [exit]