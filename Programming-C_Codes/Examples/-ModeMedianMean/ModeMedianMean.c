#include <stdio.h>

void bubbleSort(float array[], int size);
float mean(float array[], int size);
float median(float array[], int size);
void mode(float array[], int size);

int main(int argc, char *argv[]) {
	
	int i = 0;
	float numbers[1000];
	int num;
	
	scanf("%d", &num);
	
	for(i = 0 ; i < num ; i++) {
		scanf("%f", &numbers[i]);
	}
	
	bubbleSort(numbers, num);
	
	printf("\nMean is %f\n",mean(numbers , num));
	printf("\nMedian is %f\n",median(numbers , num));
	mode(numbers, num);
	
	return 0;
}

void bubbleSort(float array[], int size) {
	
	int i, j;
	int temp;
	
	for(i = 1 ; i < size ; i++) {
		for(j = 0 ; j < size - 1 ; j++) {
			if(array[j] > array [j+1]) {
				temp = array[j];
				array[j] = array[j+1];
				array[j+1] = temp;
			}
		}
	}
}

float mean(float array[], int size) {
	
	int i;
	float sum = 0;
	
	for(i = 0 ; i < size ; i++) {
		sum += array[i];
	}
	
	return (sum / size);	
}

float median(float array[], int size) {
	
	if(size % 2 == 0) {
		return ((array[size / 2] + array[size / 2 - 1]));
	}
	else {
		return (array[size / 2]);
	}
}

void mode(float array[], int size) {
	
	int i,j;
	int c,k;
	int count, maxCount = 0;
	float maxValue[size];
	
	for(i = 0 ; i < size-1 ; i++) {
		count = 0;
		for(j = i+1 ; j < size ; j++) {
			if(array[j] == array[i]) {
				count++;
			}
		}
		if((count > maxCount) && (count != 0)) {
			k = 0;
			maxCount = count;
			maxValue[k] = array[i];
			k++;
		}
		else if(count == maxCount) {
			maxValue[k] = array[i];
			k++;
		}
	}
	
	for(i = 0 ; i < size ; i++) {
		if(array[i] == maxValue[i]) {
			c++;
		}
	}
	
	if(c == size) {
		printf("\nNo Mode\n");
	}
	else {
		printf("\nMode is ");
		for(i = 0 ; i < k ; i++) {
			printf("%f ",maxValue[i]);
		}
		printf("\n");
	}
}


