#include <stdio.h>

int linearSearch(int array[], int key, int size);
int linearReSearch(int array[], int start, int end, int key);

int main(int argc, char *argv[]) {
	
	int array[1000];
	int key;
	int index;
	int i;
	int size;
	
	scanf("%d", &size);
	
	for(i = 0 ; i < size ; i++) {
		scanf("%d", &array[i]);
	}
	
	scanf("%d", &key);
	
	//index = linearSearch(array, key, size);
	index = linearReSearch(array, 0, size-1, key);
	
	printf("\n%d", index);
	return 0;
}

int linearSearch(int array[], int key, int size) {
	
	int i;
	
	for(i = 0 ; i < size ; i++) {
		if(array[i] == key) {
			return i;
		}
	}
	
	return -1;
}

int linearReSearch(int array[], int start, int end, int key) {
	if(end < start) {
		return -1;
	}
	if(array[start] == key) {
		return start;
	}
	return linearReSearch(array, start+1, end, key);
}


