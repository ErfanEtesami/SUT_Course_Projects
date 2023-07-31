#include <stdio.h>
#include <math.h>

int main(int argc, char *argv[]) {
	
	int num1, num2;
	int i;
	int sum = 0;
	int digit = 0, count_digit = 0;
	int temp1 = 0, temp2, temp3;
	int check = 0;
	
	scanf("%d %d",&num1,&num2);
	
	if(num1 > num2) {
		temp1 = num2;
		num2 = num1;
		num1 = temp1;
	}
	
	for(i = num1 ; i <= num2 ; i++) {
		
		temp2 = i;
		temp3 = i;
		
		while(temp2 > 0) {
			temp2 /= 10;
			count_digit++;
		}
		
		while(temp3 > 0) {
			digit = temp3 % 10;
			sum += pow(digit,count_digit);
			temp3 /= 10;
		}
		
		if(sum == i) {
			printf("%d\t",i);
			check++;
		}
		
		sum = 0;
		count_digit = 0;
	}
	
	if(check == 0) {
		printf("Not Found");
	}
	
	return 0;
	
}
