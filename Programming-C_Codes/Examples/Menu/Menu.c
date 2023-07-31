#include <stdio.h>

void func1(int a);
void func2(int b);
void func3(int c);

int main(int argc, char *argv[]) {
	
	void (*f[3])(int) = {func1, func2 , func3};
	
	int choice;
	
	scanf("%d", &choice);
	
	while(choice >= 0 && choice <= 2) {
		(*f[choice])(choice);
		scanf("%d", &choice);
	}
	return 0;
}

void func1(int a) {
	printf("a\n");
}

void func2(int b) {
	printf("b\n");
}

void func3(int c) {
	printf("c\n");
}
