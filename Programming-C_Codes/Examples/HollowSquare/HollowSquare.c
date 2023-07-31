#include <stdio.h>

int main()
{
    int side, curcol, currow = 1;

    scanf("%d", &side);

	while (currow <= side) {

	    if (currow == 1) {
			curcol = 1;
			while (curcol <= side) {	
		    	printf("*");
		    	curcol++;
			}
		printf("\n");
		currow++;
	    }

	    else if (currow == side) {
			curcol = 1;
			while (curcol <= side) {
		    	printf("*");
		    	curcol++;
			}
		printf("\n");
		currow++;
	    } 
	    
		else {	
			curcol = 1;
			while (curcol <= side) {
		    	if (curcol == 1)
					printf("*");
		    	else if (curcol == side)
					printf("*");
		    	else
				printf(" ");
		    curcol++;
		}
		printf("\n");
		currow++;
	    }
	}

    return 0;
}
