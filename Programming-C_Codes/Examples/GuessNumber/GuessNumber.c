#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char *argv[]) {
	
	int proGuess, userGuess;
	
	srand(time(NULL));
	proGuess = rand() % 1000 + 1;
	
	printf("Guess the number between 1 to 1000 : ");
	
	scanf("%d",&userGuess);
	
	while(1) {
		if(userGuess < proGuess) {
			printf("too low\n");
			printf("Enter another number : ");
			scanf("%d",&userGuess);
		}
		if(userGuess > proGuess) {
			printf("too high\n");
			printf("Enter another number : ");
			scanf("%d",&userGuess);
		}
		if(userGuess == proGuess) {
			printf("you made it.");
			break;
		}
	}
	
	return 0;
}
