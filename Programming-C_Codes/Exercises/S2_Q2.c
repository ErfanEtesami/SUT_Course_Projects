#include <stdio.h>
#include <math.h>

int main(int argc, char *argv[]) {
	
	int num1, num2;
	int spaces,stars;
    int i,j,h,p;
            
    scanf("%d %d",&num1,&num2);
            
    for (i=1 ; i <= num1 ; i++) {
    	
    	spaces = fabs((num1 + 1) / 2 - i);
        stars = num1 - 2 * spaces;
        
            for (j=1 ; j <= spaces ; j++) {
                printf(" ");
            }
            for (h=1 ; h <= num2 ; h++) {
                for (p=1 ; p <= stars ; p++) {
                    printf("*");
                }
                for (j=1 ; j <= 2*spaces ; j++){
                    printf(" ");
                }
            }
            printf("\n");
	}
	
	return 0;
}


