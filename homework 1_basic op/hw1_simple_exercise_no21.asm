;The program computes the expression 15/3

bits 32 ; assembling for the 32 bits architecture

global start        

extern exit         
import exit msvcrt.dll    

segment data use32 class=data
    a dw 15
    b db 3

segment code use32 class=code
    start:
        
        mov AX, [a]          ;AX = a = 15
        div byte [b]         ;AL= AX/b = a/b =15/3
        
    ;The final result is stored in AL == 5
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
