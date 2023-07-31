#include <stdio.h>

int sum(int array[], int size);

int main(void) {
	
	int size;
	int array[1000];
	int i;
	int total;
	
	scanf("%d",&size);
	
	for(i = 0 ; i < size ; i++) {
		scanf("%d", &array[i]);
	}
	
	total = sum(array, size);
	
	printf("\n%d", total);
	
    return 0;
}

int sum(int array[], int size) {
	if(size == 1) {
		return array[0];
	}
	else {
		return array[size-1] + sum(array, size-1);
	}
}
