#include <stdio.h>

int main(void)
{

    int vector[1000];
    int i, j;

    for(i = 0 ; i < 1000 ; i++) {
		vector[i] = 1;
    }

    for(i = 2 ; i < 1000 ; i++) {
		if(vector[i] == 1)
	    	for(j = i+1 ; j < 1000 ; j++) {
				if (vector[j] == 0) {
		    		continue;
		    	}
				else if(j % i == 0) {
		    		vector[j] = 0;
				}
	    }
    }

    for(i = 2 ; i < 1000 ; i++) {
    	if(vector[i] == 1) {
    		printf("%d\n",i);
		}
	}

    return 0;
}

