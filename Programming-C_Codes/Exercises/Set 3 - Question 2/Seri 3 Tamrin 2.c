#include <stdio.h>

void conversation_base (int num, int base);

int main(int argc, char *argv[]) {
	
	int count, base;
	int num;
	int i;
	
	scanf("%d %d",&count,&base);
	
	for(i = 1 ; i <=count ; i++) {
		
		scanf("%d",&num);
		
		if(num >= base) {
			conversation_base(num,base);	
		}
		else {
			printf("%d\n",num);
		}
	}
	
	return 0;
}
void conversation_base (int num, int base) {
	
	int digit;
	int count = 0;
	int sum1 = 1, sum2 = 0;
	
	while (num > 0) {
		
		digit = num % base;
		count++;
		num /= base;
		
		if(count % 2 == 0) {
			sum1 *= digit;	
		}
		else {
			sum2 += digit;
		}	
	}
	if(sum1 >= sum2) {
		printf("%d\n",sum1 - sum2);
	}
	else {
		printf("%d\n",sum2 - sum1);
	}
}
