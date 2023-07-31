#include <stdio.h>

int main(int argc, char *argv[]) {
	
	int num;
	int i,j;
	int check1 = 1 ,check2 = 1, check3 = 0;
	
	scanf("%d",&num);
	
	for (i=2 ; i <= num/2 ; i++ ) {
		check1 = 1;
		check2 = 1;
		for (j=2 ; j<i ; j++) {
			if ( i%j == 0) {
				check1 = 0;
				j = i;
			}
		}
		for (j=2 ; j<num-i ; j++) {
			if ( (num-i)%j == 0) {
				check2 = 0;
				j = num-i;
			}
		}
		if (check1==1 && check2==1) {
			printf("%d + %d = %d\n",num-i,i,num);
			check3 = 1;
		}
	}
	if (check3 == 0) {
		printf("not found");
	}
	
	return 0;
}




