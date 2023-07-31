#include <stdio.h>

int main(void) {

   double num, i;       
   double s = 1;      
   double pi = 0;
   int count = 1;
    
   scanf("%lf",&num);     

   for(i = 1 ; i <= (num * 2) ; i += 2){
     pi += s * (4 / i);
     printf("%d\t%lf\n",count,pi);
     s = -s;
     count++;
   }

	return 0;
}
