bits 32 

;Problem 21
;Two byte strings A and B are given. Obtain the string R by concatenating the elements of B in reverse order and the negative elements of A.
;Example:
;A: 2, 1, -3, 3, -4, 2, 6
;B: 4, 5, 7, 6, 2, 1
;R: 1, 2, 6, 7, 5, 4, -3, -4


global start        

extern exit               
import exit msvcrt.dll    

segment data use32 class=data
    a db 2, 1, -3, 3, -4, 2, 6
    la equ $-a
    b db 4, 5, 7, 6, 2, 1
    lb equ $-b
    d times (la+lb) db 0   ; the destination string

segment code use32 class=code
    start:
    
        mov ecx, lb       ; the length of B
        mov esi, lb-1     ; the index of the last element of B   
        mov edi, 0
        
        jecxz handleA     ; if the string B is empty, move forward to string A
        reverseB:
            mov al, [b+esi]   ;take the last element from B
            
            mov [d+edi], al   ;and copy it in the destination string
            dec esi           ;move one step back in the string B
            inc edi           ;move one step forward in the destination string
        
        loop reverseB
        
        handleA: 
            mov ecx, la           ; the length of string A
            mov esi, 0            ; we take the elements of A from beginning to end    
            
            jecxz endofprogram
            negativesofA:
                mov AL, [a+esi]   ;copy each element in the string A
                cmp AL, 0         ;compare it to 0
                jge nextelement   ; if it is positive, move forward to the next element
                
                mov [d+edi], AL   ;if it negative, add it to the destination string
                inc edi
               
                nextelement:
                inc esi           ;move forward to the next element
            
            
            loop negativesofA
        
        endofprogram:
       
        push    dword 0     
        call    [exit]