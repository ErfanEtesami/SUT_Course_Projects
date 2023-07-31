#include <stdio.h>
#include <stdlib.h>

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

int main(int argc, char *argv[]) {
	
	char blank = ' ';
	char ch;
	int numofchar = 0;
	int numofword = 1;
	
	printf("Please enter an sentences :\n");
	
	while ((ch = getche()) != '\r') {
		numofchar++;
		if (ch == blank)
			numofword++;
	}
	
	printf("\n%d\t%d\n",numofchar,numofword);
	
	return 0;
}
