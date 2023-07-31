#include <stdio.h>

void hanoi(int n ,char source ,char temp, char aim);

int main(void) {
	
	int n;
	
	scanf("%d",&n);
	
	hanoi(n,'A','B','C');
	
    return 0;
}

void hanoi(int n,char source, char temp, char aim) {
	if(n==1) {
		printf("move form %d from %c to %c\n",n,source,aim);
	}
	else {
		hanoi(n-1,source,aim,temp);
		printf("move form %d from %c to %c\n",n,source,aim);
		hanoi(n-1,temp,source,aim);
	}
}
