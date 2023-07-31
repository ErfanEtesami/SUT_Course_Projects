#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define CARDS 52
#define SUITS 4
#define FACES 13

void shuffle(int deck[][FACES]);
void deal(int deck[][FACES], char *face[], char *suit[]);

int main(int argc, char *argv[]) {
	
	srand(time(NULL));
	
	int deck[SUITS][FACES] = {0};
	
	shuffle(deck);
	
	char *suits[SUITS] = {"HEARTS", "DIAMONDS", "CLUBS", "SPADES"};
	
	char *faces[FACES] = {"ACE", "DEUCE", "THREE", "FOUR",
						  "FIVE", "SIX", "SEVEN", "EIGHT",
						  "NINE", "TEN", "JACK", "QUEEN", "KING"};
	
	deal(deck, faces, suits);
	
	return 0;
}

void shuffle(int deck[][FACES]) {
	
	int i;
	int row, column;
	
	for(i=1 ; i <= CARDS ; i++) {
		do {
			row = rand() % SUITS;
			column = rand() % FACES;
		} while(deck[row][column] != 0);
	
		deck[row][column] = i;
	}
}

void deal(int deck[][FACES], char *face[], char *suit[]) {
	
	int i, j, k;
	
	for(i=1 ; i <= CARDS ; i++) {
		for(j=0 ; j < SUITS ; j++) {
			for(k=0 ; k < FACES ; k++) {
				if(deck[j][k] == i) {
					printf("%5s of %-8s%c", face[k], suit[j], i % 2 == 0 ? '\n' : '\t');
				}
			}
		}
	}
	
}

