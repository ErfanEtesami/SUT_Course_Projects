#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
	
	int num;
	int input[1000];
	int count[1000];
	int freq[1000][2];
	int i,j;
	int Count;
	int max_freq;
	int total_count = 0;
	
	scanf("%d",&num);
	
	//filling an array by given numbers
	for(i=0 ; i<num ; i++) {
		scanf("%d",&input[i]);
		count[i] = -1;  //-1 means that element doesn't count yet
	}	
	
	//finding frequency of numbers
	for(i=0 ; i<num ; i++) {
		Count = 1;
		for(j=i+1 ; j<num ; j++) {
			if(input[i] == input[j]) {
				count[j] = 0;  //0 means that element counted already
				Count++;
			}
		}
		if(count[i] != 0) {
			count[i] = Count;
		}
	}
	
	//put numbers and frequecy of them in an array
	for(i=0 ; i<num ; i++) {
		if(count[i] != 0) {
			freq[i][0] = input[i];
			freq[i][1] = count[i];
		}
	}
	
	//finding how many times most freqenut number repeats
	max_freq = freq[0][1];
	for(i=1 ; i<num ; i++) {
		if(max_freq < freq[i][1]) {
			max_freq = freq[i][1];
		}
	}
	
	//finding quantity of numbers without duplicates
	for(i=0 ; i<num ; i++) {
		for(j=0 ; j<i ; j++) {
			if(input[i] == input[j]) {
				break;
			}
		}
		if(i == j) {
			total_count++;
		}
	}
	
	printf("%d %d",max_freq, total_count);

	return 0;
}
