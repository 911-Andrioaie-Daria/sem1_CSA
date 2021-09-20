bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 10
    b db 10
    c db 50
    d db 10
    e dw 10
    f dw 300
    g dw 10
    h dw 500

;The program computes the expression (f*g-a*b*e)/(h+c*d)
    
segment code use32 class=code
    start:
        
    ;a*b*e    
        mov AL, [a]        ;AL=a=10
        mul byte [b]       ;AX=AL*b=a*b = 100
        mul word [e]       ;DX:AX=AX*e   ;DX:AX=a*b*e = 1000
        
        push DX
        pop  CX
        push AX
        pop  BX            ;CX:BX=DX:AX=a*b*e = 1000
    
    ;f*g
        mov AX, [f]        ;AX=f
        mul word [g]       ;DX:AX=AX*g   ;DX:AX=f*g =3000
    
    ;f*g-a*b*e
        sub AX, BX     
        sbb DX, CX         ;DX:AX=DX:AX-CX:BX  ;DX:AX=f*g-a*b*e = 2000
        
        push DX
        push AX
        pop  ECX            ;ECX = DX:AX = f*g-a*b*e = 2000
        
     
     
    ;h+c*d
        mov AL, [c]        ;AL=c = 50
        mul byte [d]       ;AX=AL*d       ;AX=c*d = 500
        add AX, [h]        ;AX=AX+h       ;AX=h+c*d = 1000
        
        mov BX, AX         ;BX=AX         ;BX=h+c*d = 1000
     
     
        push ECX
        pop AX
        pop DX             ;DX:AX= f*g-a*b*e = 2000
    
    ;(f*g-a*b*e)/(h+c*d)
        div BX             ;AX <- DX:AX / BX, DX<-DX:AX % BX
        
    ;The final result is stored in AX = 2
    
        push dword 0
        call [exit]