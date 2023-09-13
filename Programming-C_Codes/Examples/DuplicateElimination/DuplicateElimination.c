#include <stdio.h>

int main(int argc, char *argv[]) {
	
	int array[1000];
	int size;
	int i,j,k;
	
	scanf("%d",&size);
	
	for(i = 0 ; i < size ; i++) {
		scanf("%d", &array[i]);
	}
	
	for(i = 0 ; i < size ; i++) {
		for(j = i+1 ; j < size ; ) {
			if(array[j] == array[i]) {
				for(k = j ; k < size ; k++) {
					array[k] = array[k+1];
				}
				size--;
			}
			else{
				j++;
			}
		}
	}
	
	for(i = 0 ; i < size ; i++) {
		printf("\n%d\n",array[i]);
	}
	
	return 0;
}
