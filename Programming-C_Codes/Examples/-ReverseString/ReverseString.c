#include <stdio.h>
 
void Reverse(char [], int, int);

int main() {
	
    char string[100];
    int length = 0;
    int i;
    
    scanf("%[^\n]s", string);
    
    for(i=0 ; string[i] != '\0'; i++) {
    	length++;
	}
 
    Reverse(string, 0, length-1);
    
    printf("%s", string);
    
    return 0;
}
 
void Reverse(char string[], int index, int length)
{
    char temp;
    
    temp = string[index];
    string[index] = string[length - index];
    string[length - index] = temp;
    
    if (index == length/2)
    {
        return;
    }
    
    Reverse(string, index+1, length);
}
