#include <stdio.h>

int sum_factors(int num);

int main(int argc, char *argv[]) {
	
	int num;
	int i,temp;
    int count = 1;
    
    scanf("%d",&num);
    
    for(i = 221 ; i < num ; i++) {
    	
    	temp = sum_factors(i);
    	
    	if(sum_factors(temp)==i && temp!=i && temp<num){
    		count++;
		}
	}

	printf("%d",count/2);

    return 0;
}

int sum_factors(int num) {
	
    int i;
    int sum = 1;
    
    for(i = 2 ; i * i <= num ; i++) {
        if(num % i == 0) {
        	sum += i;
        	sum += num / i;
        }
        if(i*i == num) {
        	sum -= i;
		}
    }
    return sum;
}
