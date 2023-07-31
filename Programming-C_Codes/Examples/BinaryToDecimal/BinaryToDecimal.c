#include <stdio.h>

int main(int argc, char *argv[]) {
	
	int num;
	int digit;
	int decimal;
	int base = 1;
	
	scanf("%d",&num);
	
	while(num>0) {
		digit = num % 10;
		decimal += digit * base;
		base *= 2;
		num /= 10;
	}
	
	printf("%d",decimal);
	
	return 0;
}
