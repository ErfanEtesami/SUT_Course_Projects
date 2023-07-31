#include <stdio.h>
#include <stdlib.h>

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

int main(int argc, char *argv[]) {
	
	int num;
	int sum = 0;
	
	printf("Enter your number:\n");
	scanf("%d",&num);
	
	while ( num>0 ) {
		sum += (num % 10);
		num /= 10;
	}
	printf("\n%d",sum);
	return 0;
}
