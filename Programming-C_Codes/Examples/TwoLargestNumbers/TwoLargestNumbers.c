#include <stdio.h>

int main(void) {

    int counter = 1;
    int number = 0;
    int largest1 = 0;
    int largest2 = 0;

    while(counter <= 10) {
		printf("Enter number %d of 10: ", counter);
		scanf("%d", &number);
		if(counter == 1) {
	    	largest1 = number;
		}
		if(counter == 2) {
			largest2 = (number > largest1 ? largest1 : number );
			largest1 = (number > largest1 ? number : largest1 );
		}
		else {
	    	if(number>largest1 && number>largest2) {
	    		largest2 = largest1;
	    		largest1 = number;
			}
			if(number<largest1 && number>largest2) {
				largest2 = number;
			}
		}
	counter++;
    }

    printf("Largest1 is %d\n", largest1);
    printf("Largest2 is %d\n", largest2);

    return 0;
}
