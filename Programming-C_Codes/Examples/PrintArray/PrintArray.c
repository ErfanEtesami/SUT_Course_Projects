#include <stdio.h>

void printArray(char array[], int begin, int size);

int main(void)
{
	char array[100];
	int size = 0;
	
	gets(array);
	
	while(array[size] != '\0') {
		size++;
	}
	
	printArray(array, 0, size);
	
    return 0;
}

void printArray(char array[], int begin, int size) {
	if(begin >= size) {
		return;
	}
	printf("%c",array[begin]);
	printArray(array, begin+1, size);
}
