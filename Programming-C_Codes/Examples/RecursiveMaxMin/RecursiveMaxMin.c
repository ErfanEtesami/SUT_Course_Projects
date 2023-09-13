#include <stdio.h>

int maximum(int array[], int index, int length);
int minimum(int array[], int index, int length);

int main() {
	
    int array[100];
	int size;
	int max, min;
    int i;

    scanf("%d", &size);
    
    for(i = 0 ; i < size ; i++) {
        scanf("%d", &array[i]);
    }

    max = maximum(array, 0, size);
    min = minimum(array, 0, size);

    printf("Minimum element in array = %d\n", min);
    printf("Maximum element in array = %d\n", max);

    return 0;
}


int maximum(int array[], int index, int length) {
	
    int max;

    if(index >= length - 2) {
        if(array[index] > array[index + 1]) {
            return array[index];
        }
        else {
            return array[index + 1];
        }
    }

    max = maximum(array, index+1, length);

    if(array[index] > max) {
        return array[index];
    }
    else {
        return max;
    }
}

int minimum(int array[], int index, int length) {
	
    int min;

    if(index >= length-2) {
        if(array[index] < array[index + 1]) {
            return array[index];
        }
        else {
            return array[index + 1];
        }
    }

    min = minimum(array, index+1, length);

    if(array[index] < min) {
        return array[index];
    }
    else {
        return min;
    }
}
