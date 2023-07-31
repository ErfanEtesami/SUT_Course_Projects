#include <stdio.h>

void func1(int a);
int func2(int a);
void func3 (int *aptr);

int main(int argc, char *argv[]) {
	
	int a;
	scanf("%d",&a);
	

	printf("\nyou entered : %d\n\n",a);
	
	func1(a); //call by value
	printf("after outside1 : %d\n\n",a);
	
	a = func2(a); //overwrite //call by value + assignment
	printf("after ouside2 : %d\n\n",a);
	
	func3(&a); //call by refrence
	printf("after outside 3 :%d\n",a);
	
	return 0;
}

void func1(int a){ //yek copy az a tahie mishavad
	a*=2;
	printf("after inside1 : %d\n",a);
}

int func2(int a) { //yek copy az a tahie mishavad
	a*=2;
	printf("after inside2 : %d\n",a);
	return a;
}

void func3 (int *aptr){
	*aptr *= 2;
	printf("after inside3 : %d\n",*aptr);
}
