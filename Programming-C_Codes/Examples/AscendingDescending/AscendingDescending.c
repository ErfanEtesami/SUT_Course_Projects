#include <stdio.h>

void bubble(int array[], int size, int (*compare)(int a, int b));
int ascending(int n1, int n2);
int descending(int n1, int n2);

int main(int argc, char *argv[]) {
	
	int size;
	int i;
	int order;
	
	scanf("%d", &size);
	
	int numbers[size];
	
	for(i=0 ; i < size ; i++) {
		scanf("%d", &numbers[i]);
	}
	
	scanf("%d", &order);
	
	if(order == 1) {
		bubble(numbers, size, ascending);
	}
	if(order == 2) {
		bubble(numbers, size, descending);
	}
	
	for(i=0 ; i < size ; i++) {
		printf("%d\t", numbers[i]);
	}
	return 0;
}

void bubble(int array[], int size, int (*compare)(int a, int b)) {
	
	void swap(int *ele1, int *ele2);
	
	int i, j;
	
	for(i=1 ; i < size ; i++) {
		for(j=0 ; j < size-1 ; j++) {
			if((*compare)(array[j], array[j+1])) {
				swap(&array[j], &array[j+1]);
			}
		}
	}
	
}

void swap(int *ele1, int *ele2) {
	
	int temp;
	
	temp = *ele1;
	*ele1 = *ele2;
	*ele2 = temp;
	
}

int ascending(int n1, int n2) {
	return n2 < n1;
}

int descending(int n1, int n2) {
	return n2 > n1;
}
