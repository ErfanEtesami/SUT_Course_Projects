#include <stdio.h>

int BMM(int num1, int num2);

int main(int argc, char *argv[]) {
	
	int num1,num2;
	
	scanf("%d %d", &num1, &num2);
	
	printf("%d", BMM(num1,num2));
	
	return 0;
}

int BMM(int num1, int num2) {
	
	if(num2 == 0) {
		return num1;
	}
	else {
		return BMM(num2, num1%num2);
	}
}
