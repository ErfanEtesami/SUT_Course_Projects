#include <stdio.h>

int main(int argc, char *argv[]) {
	
	int num;
	int array[100][2]; //first column for price and second for quality
	int i,j;
	int count = 0;
	
	scanf("%d", &num);
	
	for(i=0 ; i<num ; i++) {
		for(j=0 ; j<2 ; j++) {
			scanf("%d", &array[i][j]);
		}
	}
	
	for(i=0 ; i<num ; i++) {
		for(j=0 ; j<num ; j++) {
			if((array[i][0] < array [j][0]) && (array[i][1] > array[j][1])) {
				count++;
			}
		}
	}
	
	printf("Aan is right about %d pair of laptops.", count);
	
	return 0;
}
