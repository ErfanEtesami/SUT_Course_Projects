#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

int main(int argc, char *argv[]) {
	
	int i,j,k;
	
	int p[] = {0,2,4,5,6,7,8,9,
			   5,6,3,4,6,2,1,1,
			   2,5,7,8,4,3,5,9,
			   9,1,2,5,3,4,7,6,
			   8,0,9,2,1,0,0,2};
			   
	int N = sizeof(p) / sizeof(p[0]);
	
	int f[10];
	for( i=0 ; i<10 ; i++){
		f[i] = 0;
	}
	
	for( j=0 ; j<N ; j++) {
		f[p[j]]++;
	}
	
	printf("Vote.\tFreq.\tHistogram\n");
	
	for( i=0 ; i<10 ; i++){
		printf("%d\t%d\t",i,f[i]);
		for ( k=0 ; k<f[i] ; k++ ){
			printf("*");
		}
		printf("\n");	
	}
	
	int sum = 0;
	float mean;
	float stdev = 0;
	for ( j=0 ; j<N ; j++){
		sum += p[j];
	}
	mean = (float) sum / N;
	for ( k=0 ; k<N ; k++){
		stdev = pow((p[j]-mean),2);
	}
	stdev = sqrt(stdev/(N-1));
	
	printf("\nSUM is : %d\n",sum);
	printf("MEAN is : %f\n",mean);
	printf("STDEV is : %f\n",stdev);
	
	return 0;
}
