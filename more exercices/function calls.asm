;Read numbers (in base 10) in a loop until the digit '0' is read from the keyboard. Determine and display the smallest number from those that have been ;read.

bits 32

global start

extern exit, scanf, printf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    number dd 0
    reading_message db 'number= ', 0
    format db '%u', 0
    printing_message db 'The smallest number is: %u', 0 
    minimum dd 5
segment code use32 class=code
    start:
    
        read_until_zero:
        
            push dword reading_message
            call [printf]
            add esp, 4
        
            push dword number
            push dword format
            call [scanf]
            add esp, 4*2
            
            cmp dword[number], 0
            je print_minimum
            
            mov eax, [number]
            cmp eax, [minimum]
            
            jg read_until_zero
            mov [minimum], eax
            jmp read_until_zero
            
            
        print_minimum:
            push dword [minimum]
            push dword printing_message
            call [printf]
            add esp, 4*2
        
        push dword 0
        call [exit]
        
    
        