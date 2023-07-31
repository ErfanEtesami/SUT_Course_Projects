#include <stdio.h>
#include <stdlib.h>
#include <time.h>

struct card {
	char *face;
	char *suit;
};

typedef struct card Card;

void fillDeck(Card *deck, char *face[], char *suit[]);
void shuffle(Card *deck);
void deal(Card *deck);

int main(int argc, char *argv[]) {
	
	Card deck[52];
	
	char *face[] = {"Ace" ,"Deuce" ,"Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"};
	char *suit[] = {"Hearts", "Diamonds", "Clubs", "Spades"};
	
	srand(time(NULL));
	
	fillDeck(deck, face, suit);
	shuffle(deck);
	deal(deck);
	
	return 0;
}

void fillDeck(Card *deck, char *face[], char *suit[]) {
	
	int i;
	
	for(i = 0; i < 52 ; i++) {
		deck[i].face = face[i % 13];
		deck[i].suit = suit[i / 13];
	}
}

void shuffle(Card *deck) {
	
	int i;
	
	for(i = 0 ; i < 52 ; i++) {
		int j = rand() % 52;
		Card temp = deck[i];
		deck[i] = deck[j];
		deck[j] = temp;
	}
}

void deal(Card *deck) {
	
	int i;
	
	for(i = 0 ; i < 52 ; i++) {
		printf("%s of %s\n", deck[i].face, deck[i].suit);
	}
}
