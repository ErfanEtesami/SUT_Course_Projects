#include <stdio.h>

void displaybits(int value);

int main(int argc, char *argv[]) {
	
	int num;
	
	scanf("%d", &num);
	
	displaybits(num);
	
	return 0;
}

void displaybits(int value) {
	
	int mask = 1 << 31;
	int i;
	
	printf("%d = ", value);
	
	for(i = 1 ; i <= 32 ; i++) {
		printf("%c", value & mask ? '1' : '0');
		value <<= 1;
	}
	
}
