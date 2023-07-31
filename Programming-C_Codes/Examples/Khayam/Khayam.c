#include <stdio.h>

long factorial(int);

int main(int argc, char *argv[]) {
	
	int rows;
	int i, j;
    long value;

    scanf("%d", &rows);

    for(i = 0 ; i < rows ; i++) {
    	
        for(j = i; j <= rows; j++) {
            printf("   ");
        }

        for(j = 0 ; j <= i ; j++) {
            value = factorial(i) / (factorial(j) * factorial(i-j));
            printf("%6ld",value);
        }

        printf("\n");
        
    }

	return 0;
	
}

long factorial(int number) {
	
    long factorial = 1l;
    
    while(number >= 1) {
        factorial *= number;
        number--;
    }

    return factorial;
}
