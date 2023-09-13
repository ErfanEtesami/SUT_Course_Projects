#include <stdio.h>

int palindrome(char array[], int length, int begin, int end);

int main(int argc, char *argv[]) {
	
	char array[100];
	int begin, middle, end;
	int length = 0;
	int result;
	
	gets(array);
	
	while(array[length] != '\0') {
		length++;
	}
	
	/*end = length - 1;
	middle = length / 2;
	
	for(begin = 0 ; begin < middle ; begin++) {
		if(array[begin] != array[end]) {
			printf("Not");
			break;
		}
		end--;
	}
	
	if(begin == middle) {
		printf("Yes");
	}*/
	
	result = palindrome(array , length, 0, length - 1);
	
	if(result == 1) {
		printf("yes");
	}
	else{
		printf("not");
	}
	
	return 0;
}

int palindrome(char array[], int length, int begin, int end) {
	if(begin >= end) {
		return 1;
	}
	if(array[begin] == array[end]) {
		return palindrome(array, length, begin+1, end-1);
	}
}
