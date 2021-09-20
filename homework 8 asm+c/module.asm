bits 32 

global _convert_to_hexa      

extern _printf  

segment data use32 class=data
    hexa_digits db '0','1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'

segment code use32 class=code
    _convert_to_hexa:
        ; Entry code

        ; - create a stack frame for the callee program
        push ebp
        mov ebp, esp
        
        mov edx, [ebp + 8]                   ; the initial number in base 10
        mov edi, [ebp + 12]                  ; the destination string, which will have the number in base 16
        mov ebx, hexa_digits                 ; the translation table, used by the xlat instruction
      
        
        mov ecx, 8           ; since the number is on 32 bits, we have 8 nibbles on which we will perform quick conversion
        convert_nibble:
        
            ;isolate the first 4 bits of the number at the end of AL

            mov eax, edx     ; the number is now in eax
            shr eax, 28      ; the bits in eax are shifted to the right so that the nibble that we are interested in will be the lowest of AL
            

            ;convert the number in AL to its corresponding hexa digit
            xlat                 
            
            ;save the obtained hexa digit in the final string (edi)
            stosb            
            
            ;delete the first 4 bits from the number
            shl dword edx, 4 
        
        loop convert_nibble
        
        ; restore the stack frame for the caller program
        mov esp, ebp
        pop ebp
        
        ret
        