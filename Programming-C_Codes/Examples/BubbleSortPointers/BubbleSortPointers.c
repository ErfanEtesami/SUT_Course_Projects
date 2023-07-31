#include <stdio.h>

void bubbleSort(int *const array, int size);

int main(int argc, char *argv[]) {
	
	int numbers[100] = {0};
	int size;
	int i;
	
	scanf("%d", &size);
	
	for(i=0 ; i < size ; i++) {
		scanf("%d", &numbers[i]);
	}
	
	bubbleSort(numbers, size);
	
	return 0;
}

void bubbleSort(int *const array, int size) {
	
	void swap(int *ele1, int *ele2);
	
	int i, j;
	
	for(i=1 ; i < size ; i++) {
		for(j=0 ; j < size-1 ; j++) {
			if(array[j] > array[j+1]) {
				swap(&array[j], &array[j+1]);
			}
		}
	}
	
	for(i=0 ; i < size ; i++) {
		printf("%d ",array[i]);
	}
	
}

void swap(int *ele1, int *ele2) {
	
	int temp;
	
	temp = *ele1;
	*ele1 = *ele2;
	*ele2  = temp;
}
