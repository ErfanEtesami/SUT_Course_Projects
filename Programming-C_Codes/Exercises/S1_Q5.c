#include <stdio.h>
#include <math.h>

int main(int argc, char *argv[]) {
	
	float num1,num2;
	
	scanf("%f %f",&num1,&num2);
	
	float x = num1 * pow(10,6); //dar nazar gereftan adad (num1) bedoon momayez
	float y = num2 * pow(10,6); //dar nazar gereftan adad (num2) bedoon momayez
	
	int difference = (int) (x-y);
	
	int sign = (difference>>31) && 1;
	
	(sign & 1 && printf("%.2f",(num1)/2)) || printf("%.2f",2*num2);
	
	return 0;
}
