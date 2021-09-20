;The program computes the expression (a*a/b+b*b)/(2+b)+e-x in the signed representation
bits 32

global start        


extern exit               
import exit msvcrt.dll    


segment data use32 class=data
    a db 12
    b dw 40
    e dd 100
    x dq 500

segment code use32 class=code
    ;(a*a/b+b*b)/(2+b)+e-x
    start:
       
        ;a*a/b
        mov AL, [a]    ;AL=a   = 12
        imul byte [a]  ;AX=AL*a = a*a =144
        
        cwd            ;DX:AX = AX = a*a = 144
        
        idiv word [b]  ;AX = DX:AX/b = a*a/b =3
        
        ;good part
        cwd            ;DX:AX = AX = a*a/b
  
        mov BX, AX
        mov CX, DX     ;CX:BX = DX:AX = a*a/b =3
        
        ;wrong part
        ;mov BX, AX     ;BX = a*a/b =3
        ;mov CX, 0
        
        ;b*b
        mov AX, [b]    ;AX = b =40
        imul word [b]  ;DX:AX = AX*b = b*b = 1600
        
        add AX, BX
        adc DX, CX     ;DX:AX= a*a/b + b*b = 1603
        
        ;(2+b)
        mov BX, [b]    ;BX=b =40
        add BX, 2      ;BX=b+2 =42
        
        ;(a*a/b+b*b)/(2+b)
        idiv BX        ;AX = DX:AX/BX = 38
        
        cwde           ;EAX = AX = (a*a/b+b*b)/(2+b) = 38
        
        
        add EAX, [e]   ;EAX = (a*a/b+b*b)/(2+b) + e = 138
        
        cdq            ;EDX:EAX = EAX = 138
        
        ;EDX:EAX = EDX:EAX - x
        sub EAX, dword[x]     
        sbb EDX, dword[x+4]   
        
        ;The final result is stored in EDX:EAX = -362
        
        push    dword 0      
        call    [exit]       
