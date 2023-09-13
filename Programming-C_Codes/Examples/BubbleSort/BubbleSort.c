#include <stdio.h>

int main(int argc, char *argv[]) {
	
	int num;
	int array[1000];
	int i,j;
	int temp;
	int flag;
	scanf("%d",&num);
	
	for(i = 0 ; i < num ; i++) {
		scanf("%d",&array[i]);
	}
	
	for(i = 1 ; i < num ; i++) {
		flag = 0;
		
		for(j = 0 ; j < num-1 ; j++) {
			if(array[j] > array[j+1]) {
				temp = array[j];
				array[j] = array[j+1];
				array[j+1] = temp;
				flag = 1;
			}
		}
		
		if(!flag) {
			break;
		}
	}
	
	for(i = 0 ; i < num ; i++) {
		printf("%d\n",array[i]);
	}
	
	return 0;
}
