#include <stdio.h>
#include <stdlib.h>

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

int main(int argc, char *argv[]) {
	
	printf("Enter your name :\n");
	char name[10];
	scanf("%s",name);
	int M = 0;
	int i;
	for(i=0;i<10;i++){
		if (name[i] == '\0') break;
		M++;
	}
	printf("Your name is : %s\n",name);
	printf("Length of the name is : %d\n",M);
	return 0;
}
