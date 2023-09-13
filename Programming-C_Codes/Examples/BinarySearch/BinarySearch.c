#include <stdio.h>

int binarySearch(int array[], int key, int low, int high);
int binaryReSearch(int array[], int key, int low, int high);

int main(int argc, char *argv[]) {
	
	int array[1000];
	int key;
	int size;
	int i;
	int index;
	
	scanf("%d", &size);
	
	for(i = 0 ; i < size ; i++){
		scanf("%d", &array[i]);
	}
	
	scanf("%d", &key);
	
	//index = binarySearch(array, key, 0, size-1);
	index = binaryReSearch(array, key, 0, size-1);
	
	printf("\n%d", index);
	
	return 0;
}

int binarySearch(int array[], int key, int low, int high) {
	
	int middle;
	
	while(low < high) {
		middle = (low + high)/2;
		if(key == array[middle]) {
			return middle;
		}
		else if(key < array[middle]) {
			high = middle - 1;
		}
		else {
			low = middle + 1;
		}
	}
	
	return -1;
}

int binaryReSearch(int array[], int key, int low, int high) {
	
	int middle;
	
	if(low > high) {
		return -1;
	}
	
	middle = (low + high)/2;
	
	if(key == array[middle]) {
		return middle;
	}
	else if(key < array[middle]) {
		binaryReSearch(array, key, low, middle - 1);
	}
	else {
		binaryReSearch(array, key, middle + 1, high);
	}
}
