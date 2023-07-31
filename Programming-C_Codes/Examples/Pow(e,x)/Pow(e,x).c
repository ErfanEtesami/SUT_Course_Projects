#include <stdio.h>

int main(int argc, char *argv[]) {
	
	float x;
	int n;
	int i = 1;
	float approximate = 1;
	float temp = 1;
	
	scanf("%f",&x);
	scanf("%d",&n);
	
	while(i <= n) {
		temp *= (float) (x / i);
		approximate += temp;
		i++;	
	}
	
	printf("%f",approximate);
	
	return 0;
}
