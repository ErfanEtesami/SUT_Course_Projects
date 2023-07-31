#include <stdio.h>

int isMultiple(int num1, int num2);

int main(int argc, char *argv[]) {
	
	int num1,num2;
	
	scanf("%d %d",&num1,&num2);
	
	if(isMultiple(num1,num2)) {
		printf("Yes");
	}
	else {
		printf("No");
	}
	return 0;
}

int isMultiple(int num1, int num2) {
	return !(num2 % num1);
}
