;computes the operation (c-a)+(b-d)+d in unsigned representation

bits 32

global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 10
    b dw 52
    c dd 890
    d dq 30



segment code use32 class=code
    start:
        
        ;c-a    
        mov EAX, [c]        ;EAX=c
        
        mov BL, [a]         ;BL=a
        mov BH, 0           ;converts BL to BX
        mov CX, 0           ;converts BX to CX:BX. Now CX:BX=a
        
        push CX             ;pushes to the stack
        push BX             ;pushes to the stack
        pop EBX             ;EBX=a
        
        sub EAX, EBX        ;EAX=c-a
        mov EDX, 0          
        
        ;EDX:EAX=c-a
        
        
        
        ;b-d   b->word, d->qword 
        mov BX, [b]         ;BX=b
        mov CX, 0           ;converts BX to CX:BX
        
        push CX
        push BX
        pop EBX             ;EBX=CX:BX=b
        
        mov ECX, 0          ;converts EBX to ECX:EBX=b
        
        sub EBX, dword[d]   ;EBX=EBX-the low part of d
        sbb ECX, dword[d+4] ;ECX=ECX-the high part of d-CF
        
        ;ECX:EBX=b-d
        
        
        
        ;(c-a)+(b-d)
        add EAX, EBX
        adc EDX, ECX    ;EDX:EAX=(c-a)+(b-d)
        
        
        ;add d
        
        add EAX, dword[d]        
        adc EDX, dword[d+4]        ;EDX:EAX=(c-a)+(b-d)+d = 902
        
        ;The final result is stored in EDX:EAX
        
    push dword 0
    call [exit]

