#include <stdio.h>

int fibo(int num);

int main(int argc, char *argv[]) {
	
	int n;
	double result = 1;
	int i;

	scanf("%d",&n);
	
	for(i = n ; i >= 1 ; i--) {
		result *= fibo(i);
	}
	
	printf("%0.f",result);
	
	return 0;
}

int fibo(int num) {
	if(num == 1) {
		return 2;
	}
	if(num == 2) {
		return 3;
	}
	else {
		return fibo(num-1) + fibo(num-2);
	}
}
