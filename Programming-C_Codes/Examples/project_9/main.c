#include <stdio.h>
#include <stdlib.h>

#define N 10

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

int main(int argc, char *argv[]) {
	
	int F[N];
	
	F[0] = 0;
	F[1] = 1;
	
	int i;
	for( i=2 ; i< N ; i++ ){
		F[i] = F[i-1] + F[i-2];
	}
	
	for( i=0 ; i<N ; i++ ){
		printf("F[%d] = %d\n",i,F[i]);
	}
	
	return 0;
}
