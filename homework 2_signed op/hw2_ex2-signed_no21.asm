;Computes the expression d-a+(b+a-c) in the signed representation

bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 10
    b dw 30
    c dd 50
    d dq 100
segment code use32 class=code
    start:
        
        ;d-a
        
        ;make 'a' the size of a quad in order to compute 'd-a'
        
        mov AL, [a]         ;AL=a
        cbw                 ;AL->AX   ;AX=a
        cwde                ;AX->EAX  ;EAX=a
        cdq                 ;EAX->EDX:EAX   ;EDX:EAX=a  the size of a quad
        
        mov EBX, dword[d]
        mov ECX, dword[d+4] ;ECX:EBX=d
        
        sub EBX, EAX
        sbb ECX, EDX        ;ECX:EBX=ECX:EBX-EDX:EAX   =>ECX:EBX=d-a == 90
        
        
        ;b+a-c    ,a=byte, b=word, c=dword
        
        mov AL, [a]         ;AL=a
        cbw                 ;AL->AX  =>AX=a = 10
        
        add AX, [b]         ;AX=b+a = 40
        
        cwde                ;AX->EAX  =>EAX=b+a
    
        sub EAX, [c]          ;EAX=b+a-c
        
        cdq                 ;EAX->EDX:EAX   =>EDX:EAX=b+a-c  = -10
        
        
        ;(d-a)+(b+a-c)
        
        add EAX, EBX
        adc EDX, ECX       ;EDX:EAX = EDX:EAX + ECX:EBX = (d-a)+(b+a-c) = 80
        
        
        ;The final result is stored in EDX:EAX
    
    push dword 0
    call [exit]