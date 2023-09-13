#include <stdio.h>

int main(int argc, char *argv[]) {
	
	float fnum;
	int check = 0;
	
	scanf("%f",&fnum);
	
	while(fnum - ((long) fnum) > 0) {
		
		check++;
		fnum *= 10;
		
	}
	
	while( fnum > 0) {
		
		printf("%ld",((long) fnum) % 10);
		
		check--;
		
		if(check == 0) {
			printf(".");
		}
		
		fnum = ((long) fnum) / 10;
	}
	
	return 0;
	
}
