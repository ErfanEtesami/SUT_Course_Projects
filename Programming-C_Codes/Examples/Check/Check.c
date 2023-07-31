#include <stdio.h>

int main(int argc, char *argv[]) {
	
	/*
	int i = 0;
	while(i <= 5) {
		printf("%d\n",i);
		i++;
	}
	printf("\n");
	i = 0;
	while(++i <= 5) {
		printf("%d\n",i);
	}
	printf("\n");
	i = 0;
	while(i++ <= 5) {
		printf("%d\n",i);
	}
	*/
		
	/*
	switch(i) {
		case 1 ;
		case 1 :
			printf("A");
		case 1 :
			printf("A");	
	}
	*/
	
	/*	
	int a = 1;
	
	switch(a) {
		case 1 :
			printf("%d\n",a);
		case 2 :
			printf("%d\n",a);
		case 3 :
			printf("%d\n",a);
		default :
			printf("%d\n",a);
			break;
	}
	*/
	
	/*
	int a = 5 , b = -7 , c = 0 , d;
	d = ++a && ++b || ++c;
	printf("%d%d%d%d", a, b, c, d);
	*/
	
	/*
	int i = 2;
	switch(i) {
	case 2 : printf("%d",i);
	case 1 : printf("%d",i);
	case 3 : printf("%d",i); break;
	default : printf("%d",i); break;
	}
	*/
	
	
	int d = 5, m = 9, y = 1394;
	printf("%.4d/%.2d/%.2d\n", y, m, d);
	
	
	/*
	int d = 5, m = 9, y = 1394;
	printf("%04d/%02d/%02d\n", y, m, d);
	*/
	return 0;
}

