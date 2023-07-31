#include <stdio.h>

int main(int argc, char *argv[]) {
	
	int p1,p2; //pages
	int count; //first user input
	int i;
	int temp;
	
	scanf("%d",&count);
	
	for(i=0 ; i < count ; i++){
	
		scanf("%d %d",&p1,&p2);
		
		if(p2 < p1) {
			temp = p2;
			p2 = p1;
			p1 = temp;
		}
		
		if(p1 % 2 == 0){
			p1--;
		}
		if(p2 % 2 == 1){
			p2++;
		}
		
		temp = (p1 + p2 - 1)/2;
		
		if((p1<=temp)&&(p2<=temp)){
			printf("?\n");
			continue;
		}
		if((p1>=temp)&&(p2>=temp)){
			printf("?\n");
			continue;
		}
		
		printf("%d\n",p1+p2-1);	
	}
	return 0;
}

