#include <stdio.h>

int main(int argc, char *argv[]) {
	
	int in,an;
	char Code;
	
	scanf("%c %d %d",&Code,&in,&an);
	
	((Code == ('A')) || (Code == ('B')) || (Code == ('C'))) && printf("%d",(3*in)+(5*an)) || printf("%d",(5*in)+(3*an));

	return 0;
}
