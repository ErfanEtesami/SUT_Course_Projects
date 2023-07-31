#include <stdio.h>

void move (int num, char source,char temp, char aim);

int main(int argc, char *argv[]) {
	
	int num;
	
	scanf("%d",&num);

    move(num,'A','B','C');
	
	return 0;
}

void move (int num, char source,char temp, char aim) {
	
	if(num == 1) {
        printf("move form 1 from %c to %c\n",source,temp);
        printf("move form 1 from %c to %c\n",temp,aim);
    }
    else {
        move(num-1, source, temp, aim);
        printf("move form %d from %c to %c\n",num,source,temp);
        move(num-1, aim, temp, source);
        printf("move form %d from %c to %c\n",num,temp,aim);
        move(num-1, source, temp, aim);
    }	
}


