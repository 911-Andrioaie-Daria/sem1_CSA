;The program computes the expression (a*a/b+b*b)/(2+b)+e-x in the unsigned representation

bits 32

global start        


extern exit               
import exit msvcrt.dll   

segment data use32 class=data
    a db 12
    b dw 40
    e dd 100
    x dq 50

segment code use32 class=code
    ;(a*a/b+b*b)/(2+b)+e-x
    start:
        
        ;a*a/b
        mov AL, [a]    ;AL=a = 12
        mul byte [a]   ;AX=AL*a=a*a = 144
        
        mov DX, 0      ;DX:AX=a*a
        
        div word[b]    ;AX=DX:AX/b   =>AX=a*a/b  = 3
        
        mov BX, AX     ;BX=a*a/b
        mov CX, 0      ;CX:BX = a*a/b
        
        
        ;b*b
        mov AX, [b]    ;AX=b = 40
        mul word[b]    ;DX:AX = AX*b = b*b = 1600
        
        
        ;add a*a/b and b*b
        add AX, BX
        adc DX, CX   ;DX:AX= DX:AX + CX:BX = a*a/b+b*b = 1603
        
        ;b+2
        mov BX, [b]  ;BX=b = 40
        add BX, 2    ;BX=BX+2 =42
        
        ;(a*a/b+b*b)/(2+b)
        div BX       ;AX = DX:AX / BX  = (a*a/b+b*b)/(b+2) = 38
             
        
        ;add e -> dword
        mov DX, 0
        
        push DX
        push AX
        pop EAX       ;DX:AX -> EAX   => EAX =(a*a/b+b*b)/(b+2) = 38
        
        add EAX, [e]   ;EAX = EAX+e = (a*a/b+b*b)/(b+2)+e = 138
        
        
        ;sub x -> qword
        mov EDX, 0   ;EDX:EAX = (a*a/b+b*b)/(b+2)+e
        
        sub EAX, dword[x]    ;subtract the low part of x
        sbb EDX, dword[x+4]  ;subtract the high part of x and the CF
        
        ;The final result is stored in EDX:EAX = (a*a/b+b*b)/(2+b)+e-x = 88
        
        
        
        push    dword 0     
        call    [exit]       
