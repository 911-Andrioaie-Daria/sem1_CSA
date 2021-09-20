#include <stdio.h>

int convert_to_hexa(int number, char hexa[]);

int main()
{
    int my_number=412563;      
    char hexa_number[12]="";
    
    convert_to_hexa(my_number, hexa_number);
    
    printf("The number in base 16 is: %s", hexa_number);
    
    return 0;
}