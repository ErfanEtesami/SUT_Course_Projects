#include <stdio.h>

int main(int argc, char *argv[]) {
	
    int n;
	int i,j,k,m; //loops' counter   i for rows and j for columns
	int value;
	int top,right,down,left; //directions
	
	scanf("%d",&n);
	
	for(i = 1 ; i <= n ; i++) {
		
    	for(j = 1 ; j <= n ; j++) {
    		
      		value = 1;
      		k = i;
      		m = j;
      		
      		while(k != 1 || m != 1) {
      			
        		top = k - 1;
        		right = n - m;
        		down = n - k;
        		left = m - 1;
        		
        		if(top <= down && top <= left && top <= right) {
          			m--;
          		}
        		else if(right <= top && right <= down && right <= left) {
          			k--;
          		}
        		else if(down <= top && down <= right && down <= left) {
          			m++;
          		}
        		else if(left <= top && left <= down && left <= right) {
          			k++;
          		}
          		
        	value++;
        	
      		} //end of while
      		
      		printf("%d",value);
      		
      		if(j != n) {
        		printf("\t");
        	}
    	} //end of nested for
    	
    	if(i != n) {
      		printf("\n");
      	}
  	} //end of for
	
	return 0;
}
