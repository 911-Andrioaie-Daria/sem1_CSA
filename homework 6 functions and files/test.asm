bits 32 
global start        


extern exit, scanf, printf              
import exit msvcrt.dll  
import scanf msvcrt.dll                          
import printf msvcrt.dll

segment data use32 class=data
   v dw 28
segment code use32 class=code
    start:
        movsx eax, dword[v]
        push    dword 0     
        call    [exit]       
