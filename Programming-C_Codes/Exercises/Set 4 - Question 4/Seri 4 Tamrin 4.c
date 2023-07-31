#include <stdio.h>

int main(int argc, char *argv[]) {
	
	char words[100][100];
	int i,j;
	int num;
	int length[100] = {0}; //for counting length of every string stored in each row
	
	scanf("%d", &num);
	
	for(i=0 ; i<num ; i++) {
		scanf("%s", &words[i]); //each line stored in one row of the 2d array
	}
	
	for(i=0 ; i<num ; i++) {
		for(j=0 ; words[i][j]!='\0' ; j++) {
			length[i]++;
		}
	}
	
	for(i=0 ; i<num ; i++) {
		if(length[i] > 10) {
			printf("%c%d%c\n", words[i][0], length[i]-2, words[i][length[i]-1]);
		}
		else {
			printf("%s\n", words[i]);
		}
	}
	
	return 0;
}
