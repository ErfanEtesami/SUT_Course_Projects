#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <time.h>
#include <string.h>

#define EMPTY 0

#define S_1 1
#define E_1 2
#define H_1 3
#define C_1 4
#define Q_1 5
#define K_1 6
#define S_2 7
#define E_2 8
#define H_2 9
#define C_2 10
#define Q_2 11
#define K_2 12

#define ROWS 2
#define COLUMNS 12
#define CAPACITY 6
#define PIECES 15
#define TYPES 6

#define WRONG_MOVE -100
#define NO_MOVES -200
#define USED -300
#define OUT -1
#define DONE 100

#define SHOW 100
#define HIDE -100
#define savedGame "gameSave.dat"
#define savedGameNumber "numberOfSavedGames.dat"
#define SAVE_INTERRUPTED -1000

char *names[COLUMNS + 1] = {"    ", "S_1 ", "E_1 ", "H_1 ", "C_1 ", "Q_1 ", "K_1 ", "S_2 ", "E_2 ", "H_2 ", "C_2 ", "Q_2 ", "K_2 "};
//S_1 : 1, E_1 : 2, H_1 : 3, C_1 : 4, Q_1 : 5, K_1 : 6, S_2 : 7, E_2 : 8, H_2 : 9, C_2 : 10, Q_2 : 11, K_2 : 12
char *rooms[COLUMNS*2 + 1] = {"C1_1", "C1_2", "C1_3", "C1_4", "C1_5", "C1_6", "R1_1", "R1_2", "R1_3", "R1_4", "R1_5", "R1_6", "C2_1", "C2_2", "C2_3", "C2_4", "C2_5", "C2_6", "R2_1", "R2_2", "R2_3", "R2_4", "R2_5", "R2_6", "O"};
//C1 : 0 to 5 , R1 : 6 to 11 , C2 : 12 to 17 , R2 : 18 to 23 , OUT(victory) : 24
char *oNames[COLUMNS + 1] = {"   ", "O_S", "O_E", "O_H", "O_C", "O_Q", "O_K", "O_S", "O_E", "O_H", "O_C", "O_Q", "O_K"}; //out pieces
//O_S: 1, O_E: 2, O_H: 3, O_C: 4, O_Q: 5, O_K: 6, O_S: 7, O_E: 8, O_H: 9, O_C: 10, O_Q: 11, O_K: 12

int board[2][COLUMNS][CAPACITY] = {EMPTY}; //2 : parts (up(1)(player2's realm) , bottom(0)(player1's realm) , 12 : columns , each column of each part consists of 6 places
int playerOs[2][PIECES] = {EMPTY}; //out pieces in cell-- 2 : players , each player has 15 pieces
int holes[3][2] = {EMPTY}; //3 : places , 2 : 0->which row , 1->which column
int coins[3][2] = {EMPTY}; //3 : places , 2 : 0->which row , 1->which column
int coinsCollected[2] = {0}; //2 : players
int point[2] = {0}; //checking victory process -- 2 : players
int playerBanned[2] = {0}; //2 : players
int newSaveNumber = 1;

int loadBoard(void);
void printBoard(void);
void obtainMove(char*, char*, int*);
int selectDice(int, int, int, int, int, int*, int*);
int movePlayer(int, int, int, int, int, int);
int freeThePiece(int, int, int);
int findFreePiece(int, int); 
void checkForCoinRelease(int, int);
void showMsg(int, int, int, int);
int isPlayerCastleFull(int);
int movePieceToO(int, int, int, int);
int anyMoveLeft(int, int);
void createHolesAndCoins(void);
int loadNames(int); 
int save(int);

int main(void) {
	
	int turn = 0;
	int saveResult = 0;
	char source[10], destination[10];
	char temp;
	int index = 0;
	int dice1 = 0, dice2 = 0;
	int dices[2] = {0};
	int availableDices = 2; //initial availablity of dices
	int moves = 2; //initial number of moves
	int moveInfo[5]; //move correct source or destination
	int result = 0; //for checking some conditions
	int matched = 0; //to check whether the movement is corresponding with dices or not
	int i, j;
	
	srand(time(NULL));
	
	turn = loadBoard();
	//playerOs[0][0] = 3;
	
	while(1) {
		
		printBoard();
		
		printf("\nPlayer %d, please press \'d\' to throw dices...", turn+1);
		
		char input = getch();
		
		if(input == 'd' || input == 'D') {
			//checking whether the player is banned or not
			if(playerBanned[turn] != 0) {
				playerBanned[turn]--;
				printf("\nPlayer %d is banned!\n", turn+1);
				result = 0;
				turn = (turn + 1) % 2; //changing the turn
				getch(); //just to show the message
				continue;
			}
			
			moves = 2;
			
			dice1 = dices[0] = rand() % 6 + 1;
			dice2 = dices[1] = rand() % 6 + 1;
			//dice1 = dices[0] = 4;
			//dice2 = dices[1] = 4;
			availableDices = 2;
			
			if(dices[0] == dices[1]) {
				moves = 4;
			}

			for(i = 0 ; i < moves ; i++) {
				
				printBoard();
				
				matched = 0;
				
				printf("\nDices: %d , %d", dice1, dice2);
				//if moves == 4
				if(i == 2 && dice1 == dice2 && dices[0] == USED && dices[1] == USED) {
					dices[0] = dices[1] = dice1;
				}
				//if the player still has to move
				for(j = 0 ; j < 2 && !anyMoveLeft(turn, dices[j]) ; j++) {
					availableDices--;
				}
				//if there is no further move
				if(availableDices == 0) {
					showMsg(turn+1, NO_MOVES, i, moves); //no moves available
					getch(); //just to show the message
					break;
				}
				
				showMsg(turn+1, result, i, moves); //please enter your source and destination
				
				result = 0;
				
				scanf("%s%s", source, destination);
				
				obtainMove(source, destination, moveInfo);

				if(playerOs[turn][0] != EMPTY) {
					int pieceIndex;
					
					for(pieceIndex = 0 ; pieceIndex <= COLUMNS && strcmp(oNames[playerOs[turn][pieceIndex]], source) ; pieceIndex++);
					
					if(pieceIndex > COLUMNS) {
						result = WRONG_MOVE;
					}
					else {
						index = selectDice(turn, OUT, OUT, moveInfo[3], moveInfo[4], dices, &matched);
						
						if(matched == 0) {
							result = WRONG_MOVE;
						}
						else {
							result = freeThePiece(turn, pieceIndex, dices[index]);
						}
						
						if(result == DONE) {
							dices[index] = USED;
						}
					}
				}
				else if(!strcmp(destination, rooms[24])) {
					int flag = isPlayerCastleFull(turn);
					
					if(flag == 1) {
						index = selectDice(turn, moveInfo[1], moveInfo[2], moveInfo[3], moveInfo[4], dices, &matched);
					
						result = movePieceToO(turn, moveInfo[1], moveInfo[2], dices[index]);
					
						if(result == DONE) {
							dices[index] = USED;
						}
					}
					if(flag == 0) {
						printf("your castle in not full!");
						getch();
						i--;
					}
				}
				else if(moveInfo[0] == 2) {
					index = selectDice(turn, moveInfo[1], moveInfo[2], moveInfo[3], moveInfo[4], dices, &matched);
					
					result = movePlayer(turn, dices[index], moveInfo[1], moveInfo[2], moveInfo[3], moveInfo[4]);
					
					if(result == DONE) {
						dices[index] = USED;
					}
				}
				else {
					result = WRONG_MOVE;
				}
				
				if(result == WRONG_MOVE) {
					i--;
				}
				
				if(i == moves-1) {
					printBoard();
					showMsg(turn+1, result, moves, moves);
				}
			}

			result = 0;
			
			turn = (turn + 1) % 2;
			
			getch();
		}
		
		printf("\nS. Save Game\tN. Next Move ");
		
		if((temp = getch()) == 's' || temp == 'S') {
			
			saveResult = save(turn);
			
			if(saveResult == SAVE_INTERRUPTED) {
				printf("\nSaving Failed !\n");
			}
			else {
				printf("\nShatnard%d Saved. ", newSaveNumber-1);
			}
			
			getch();
		}
	}
	
	return 0;
}

//setting up the game in 3 different ways : 1-based on saves(continue) 2-new game 3-from the map
int loadBoard(void) {
	
	char t;
	int turn = 0;
	int saveNumber = 0;
	
	newSaveNumber = loadNames(HIDE);
	
	while(1) {

		system("cls");
		
		printf("1. Continue \n2. New Game\n3. Load From Map File\n");
		
		//changing char format to integer
		t = _getch() - '0';
		
		if(t == 2) {
			board[1][0][0] = K_1;
			board[1][0][1] = Q_1;
			
			board[0][0][0] = K_2;
			board[0][0][1] = Q_2;

			board[0][5][0] = C_1;
			board[0][5][1] = S_1;
			board[0][5][2] = H_1;
			board[0][5][3] = S_1;
			board[0][5][4] = C_1;

			board[1][5][0] = C_2;
			board[1][5][1] = S_2;
			board[1][5][2] = H_2;
			board[1][5][3] = S_2;
			board[1][5][4] = C_2;

			board[0][7][0] = S_1;
			board[0][7][1] = E_1;
			board[0][7][2] = S_1;

			board[1][7][0] = S_2;
			board[1][7][1] = E_2;
			board[1][7][2] = S_2;

			board[1][11][0] = S_1;
			board[1][11][1] = H_1;
			board[1][11][2] = S_1;
			board[1][11][3] = S_1;
			board[1][11][4] = E_1;

			board[0][11][0] = S_2;
			board[0][11][1] = H_2;
			board[0][11][2] = S_2;
			board[0][11][3] = S_2;
			board[0][11][4] = E_2;

			createHolesAndCoins();
			
			break;
		}
		else if(t == 1) {
			int i, m, j, k;
			
			FILE *f = fopen(savedGame, "r");
			
			if(!f) {
				printf("\nNo saves found! Try again...");
				newSaveNumber = 1;
				getch();
				continue;
			}
			
			newSaveNumber = loadNames(SHOW);
			
			do {
				printf("\nEnter the number of the save you want: ");
				scanf("%d", &saveNumber);
			} while(saveNumber <= 0 || saveNumber >= newSaveNumber);
			
			for(i = 0 ; i < saveNumber ; i++) {
				char temp[50];
				
				fscanf(f, "%s", temp);
				
				for(m = 0 ; m < ROWS ; m++) {
					for(j = 0; j < COLUMNS ; j++) {
						for(k = 0 ; k < CAPACITY ; k++) {
							fscanf(f, "%d", &board[m][j][k]);
						}
					}
				}

				for(m = 0 ; m < 2 ; m++) {
					for(j = 0 ; j < PIECES ; j++) {
						fscanf(f, "%d", &playerOs[m][j]);
					}
				}

				fscanf(f, "%d%d", &point[0], &point[1]);

				for(m = 0 ; m < 3 ; m++) {
					fscanf(f, "%d%d", &holes[m][0], &holes[m][1]);
				}

				for(m = 0 ; m < 3 ; m++) {
					fscanf(f, "%d%d", &coins[m][0], &coins[m][1]);
				}

				fscanf(f, "%d%d%d%d%d", &playerBanned[0], &playerBanned[1], &coinsCollected[0], &coinsCollected[1], &turn);
			}
			
			break;
		}
		else if(t == 3) {
			int c = 0;
			char address[100];
			char temp[5] = {0};
			int realm = 1;
			int room = 0;
			int piece = 0;
			
			FILE *fMap;
			
			printf("\n\nMap File Address: ");
			
			scanf("%s", address);
			
			fMap = fopen(address, "r");
			
			if(!fMap) {
				printf("Error in openning the map file, Try again!\n");
				getch();
				continue;
			}
			
			while(fgetc(fMap) != '\n');
			
			while(!feof(fMap)) {
				int i = 0;
				int index = 0;
				
				temp[0] = temp[1] = temp[2] = temp[4] = 0;
				temp[3] = ' ';
				
				if(realm == 0 && piece < 0 && room == 0) {
					break;
				}
				
				for(i = 0 ; i < 3 ; i++) {
					temp[i] = fgetc(fMap);
					
					if(temp[i] == '|') {
						temp[i] = fgetc(fMap);
					}
					if(temp[i] == '\n') {
						if(realm == 1) {
							piece++;
						}
						else {
							piece--;
						}
						break;
					}
				}
				
				if(piece >= CAPACITY) {
					piece = CAPACITY - 1;
					realm = 0;
				}
				
				if(temp[i] == '\n') {
					board[realm][room][piece] = EMPTY;
					room = 0;
					temp[0] = temp[1] = temp[2] = temp[3] = temp[4] = 0;
				}
				else {
					for( ; index < COLUMNS+1 && strcmp(temp, names[index]) ; index++);
					board[realm][room][piece] = index;
					room = (room + 1) % COLUMNS;
				}
			}
			
			createHolesAndCoins();
			
			break;
		}
	}
	
	_fcloseall();
	
	return turn;
}

void printBoard(void) {
	
	int outCounter = 0;
	int i, j;
	
	system("cls");
	
	printf("Player2's Castle\t\tRoad number 2\t\t\tPlayer1 Cell | Player2 Cell\n");
	printf(" 1   2   3   4   5   6  |");
	printf(" 1   2   3   4   5   6\t\t\t\t     |\n");
	
	for(i = 0 ; i < CAPACITY ; i++) {
		for(j = 0 ; j < COLUMNS ; j++) {
			printf("%s", names[board[1][j][i]]);
			if(j == 5) {
				printf("|");
			}
		}
		printf("\t\t\t%s  |  %s\n", oNames[playerOs[0][outCounter]], oNames[playerOs[1][outCounter]]);
		outCounter++;
	}

	for(i = CAPACITY-1 ; i >= 0 ; i--) {
		for(j = 0 ; j < COLUMNS ; j++) {
			printf("%s", names[board[0][j][i]]);
			if(j == 5) {
				printf("|");
			}
		}
		printf("\t\t\t%s  |  %s\n", oNames[playerOs[0][outCounter]], oNames[playerOs[1][outCounter]]);
		outCounter++;
	}
	
	printf(" 1   2   3   4   5   6  |");
	printf(" 1   2   3   4   5   6   ");
	printf("\t\t\t%s  |  %s\n", oNames[playerOs[0][outCounter]], oNames[playerOs[1][outCounter]]);
	printf("Player1's Castle\t\tRoad number 1\n");
	
	return;
}

void createHolesAndCoins(void) {
	
	/*int num = rand() % 3;
	int i;
	
	for(i = 0 ; i <= num ; i++) {
		do {
			holes[i][0] = rand() % ROWS;
			holes[i][1] = rand() % (COLUMNS / 2) + (COLUMNS / 2);
		} while(board[holes[i][0]][holes[i][1]][0] != EMPTY);
	}
	
	num = rand() % 3;
	
	for(i = 0 ; i <= num ; i++) {
		do {
			coins[i][0] = rand() % ROWS;
			coins[i][1] = rand() % COLUMNS;
		} while(board[coins[i][0]][coins[i][1]][0] != EMPTY || (coins[i][0] == holes[i][0] && coins[i][1] == holes[i][1]));
	}
	
	return;*/
	
	//holes[1][0] = 1;
	//holes[1][1] = 8;
	
	coins[1][0] = 1;
	coins[1][1] = 8;
}

int anyMoveLeft(int player, int dice) {
	
	int r1 = 0, r2 = 0;
	int numberOfPiecesInCastle = 0;
	int flag = 0;
	int i;
	
	for(i = 0 ; i < COLUMNS ; i++) {
		if(player == 0) {
			//check if there is any piece in cell and check if player can take piece inside the board with that dice
			if(playerOs[0][0] != EMPTY) {
				if(board[1][dice - 1][1] <= K_1 && board[1][dice - 1][CAPACITY - 1] != EMPTY) {
					return 0;
				}
				else if(board[1][dice - 1][1] >= S_2) {
					return 0;
				}
			}
			
			if(board[0][i][0] <= K_1 && board[0][i][0] > EMPTY) {
				r1 = (i + 1 - dice); //player1 move to left in its realm -- destination room
				
				if(r1 == 0) { //can move out of the board
					return 1;
				}
				
				if(r1 > 0) { //can move but with conditions
					if(board[0][i - dice][1] <= K_1 && board[0][i - dice][CAPACITY - 1] == EMPTY) {
						return 1;
					}
				}
			}
			
			if(board[1][i][0] <= K_1 && board[1][i][0] > EMPTY) {
				//player1 move to right in player2's realm -- destination room
				r1 = (i + dice) % COLUMNS; 
				r2 = (i + dice) / COLUMNS; 
				
				if(r2 == 0) { //if i+dice < 12 -- this move doesn't change the realm
					if(board[1][i + dice][1] <= K_1 && board[1][i + dice][CAPACITY - 1] == EMPTY) {
						return 1;
					}
				}
				else { //if i+dice > 12 -- this move changes the realm
					if(board[0][COLUMNS - r1 - 1][1] <= K_1 && board[0][COLUMNS - r1 - 1][CAPACITY - 1] == EMPTY) {
						return 1;
					}
				}
			}
		}
		else {
			//check if there is any piece in cell and check if player can take piece inside the board with that dice
			if(playerOs[1][0] != EMPTY) {
				if(board[0][dice - 1][1] >= S_2 && board[0][dice - 1][CAPACITY - 1] != EMPTY) {
					return 0;
				}
				else if(board[0][dice - 1][1] <= K_1 && board[0][dice - 1][1] != EMPTY) {
					return 0;
				}
			}
			
			if(board[1][i][0] >= S_2) {
				r1 = (i + 1 - dice); //player2 move to right in its realm -- destination room
				
				if(r1 == 0) { //can move out of the board
					return 1;
				}
				
				if(r1 > 0) { //can move but with conditions
					if((board[1][i - dice][1] >= S_2 || board[1][i - dice][1] == EMPTY) && board[1][i - dice][CAPACITY - 1] == EMPTY) {
						return 1;
					}
				}
			}
			
			if(board[0][i][0] >= S_2) {
				//player2 move to left in player2's realm -- destination room
				r1 = (i + dice) % COLUMNS;
				r2 = (i + dice) / COLUMNS;
				
				if(r2 == 0) { //if i+dice < 12 -- this move doesn't change the realm
					if((board[0][i + dice][1] >= S_2 || board[0][i + dice][1] == EMPTY) && board[0][i + dice][CAPACITY - 1] == EMPTY) {
						return 1;
					}
				}
				else { //if i+dice > 12 -- this move changes the realm
					if((board[1][COLUMNS - r1 - 1][1] >= S_2 || board[1][COLUMNS - r1 - 1][1] == EMPTY) && board[1][COLUMNS - r1 - 1][CAPACITY - 1] == EMPTY) {
						return 1;
					}
				}
			}
		}
	}
	
	return isPlayerCastleFull(player) && ((dice >= 5 && ((player == 0 && board[player][4][0] <= K_1 && board[player][4][0] > EMPTY) || (player == 1 && board[player][4][0] >= S_2))) ||
										  (dice >= 4 && ((player == 0 && board[player][3][0] <= K_1 && board[player][3][0] > EMPTY) || (player == 1 && board[player][3][0] >= S_2))) ||
										  (dice >= 3 && ((player == 0 && board[player][2][0] <= K_1 && board[player][2][0] > EMPTY) || (player == 1 && board[player][2][0] >= S_2))) ||
										  (dice >= 2 && ((player == 0 && board[player][1][0] <= K_1 && board[player][1][0] > EMPTY) || (player == 1 && board[player][1][0] >= S_2))) ||
										  (dice >= 1 && ((player == 0 && board[player][0][0] <= K_1 && board[player][0][0] > EMPTY) || (player == 1 && board[player][0][0] >= S_2))) );
}

//s : source - d : desination - r : changing moveInfo elemnts
void obtainMove(char *s, char *d, int *r) {
	
	int i;
	
	r[0] = 0; //to check whether both source and destination(or each of them) are correct or not
	
	for(i = 0 ; i < COLUMNS*ROWS+1 ; i++) {
		//validating and finding the source
		if(!strcmp(s, rooms[i])) {
			r[1] = i / 12; //which part
			r[2] = i % 12; //which column(room)
			r[0]++;
		}
		//validating and findong the destination
		if(!strcmp(d, rooms[i])) {
			r[3] = i / 12; //which part
			r[4] = i % 12; //which column(room)
			r[0]++;
		}
	}
	
	return;
}

//sRealm : source's part , sRoom : source's room , dRealm : destination's realm , dRoom : destination's room
int selectDice(int player, int sRealm, int sRoom, int dRealm, int dRoom, int *dices, int *matched) {
										  //the movement is leftward when we don't have change in realm and is rightward when we have change in realm
	int step = player == sRealm ? -1 : 1; //show heading -- if step == -1 : decreases in index(leftward)  , step == 1 : increases in index(rightward)
	int distance;
	int flag;
	//if there are pieces in cell
	if(sRealm == OUT) {
		if(dRealm == (player + 1) % 2) {
			if(dRoom == dices[0] - 1) {
				*matched = 1; //the movement is corresponding with dices
				return 0;
			}
			
			if(dRoom == dices[1] - 1) {
				*matched = 1; //the movement is corresponding with dices
				return 1;
			}
		}
		
		*matched = 0; //the movement is not corresponding with dices
		
		return 0;
	}

	if(dices[0] == dices[1]) {
		return 0;
	}
	//dice[0] was used
	if(dices[0] == USED) {
		return 1;
	}
	//dice[1] was used
	if(dices[1] == USED) {
		return 0;
	}
	//this move doesn't change the realm
	if(sRealm == dRealm) {
		if(dRoom == sRoom + step*dices[0]) { //returning the move based on dice[0]
			*matched = 1; //the movement is corresponding with dices
			return 0;
		}
		
		if(dRoom == sRoom + step*dices[1]) { //returning the move based on dice[1]
			*matched = 1; //the movement is corresponding with dices
			return 1;
		}
	}
	else if(dRealm != 2) { //whether dRealm is 0 or 1 -- if dRealm == 2 -> it means the destination is O(victory process)
		if(step != -1) { //the move should be leftward
			distance = (COLUMNS - sRoom) + (COLUMNS - dRoom) - 1;
			
			if(distance == dices[0]) {
				*matched = 1; //the movement is corresponding with dices
				return 0;
			}
			
			if(distance == dices[1]) {
				*matched = 1; //the movement is corresponding with dices
				return 1;
			}
		}
	}
	else if(dRealm == 2) { //if dRealm == 2 -> it means the destination is O(victory process)
		flag = isPlayerCastleFull(player);
		
		if((sRealm == player && sRoom == dices[0] - 1) || (flag == 1 && ((sRoom == 4 && dices[0] >= 5) || (sRoom == 3 && dices[0] >= 4) || (sRoom == 2 && dices[0] >= 3) || (sRoom == 1 && dices[0] >= 2) || (sRoom == 0 && dices[0] >= 1)))) {
			*matched = 1; //the movement is corresponding with dices
			return 0;
		}
		
		if((sRealm == player && sRoom == dices[1] - 1) || (flag == 1 && ((sRoom == 4 && dices[1] >= 5) || (sRoom == 3 && dices[1] >= 4) || (sRoom == 2 && dices[1] >= 3) || (sRoom == 1 && dices[1] >= 2) || (sRoom == 0 && dices[1] >= 1)))) {
			*matched = 1; //the movement is corresponding with dices
			return 1;
		}
	}
	
	*matched = 0; //the movement is not corresponding with dices
	
	return 0;
}

//show appropriate prompt
void showMsg(int player, int r, int i, int moves) {
	
	char *moveOrders[4] = {"first", "second", "third", "forth"};
	
	if(r == WRONG_MOVE) {
		printf("\nWrong move Player %d, please try again: ", player);
		return;
	}
	else if(r == NO_MOVES) {
		printf("\nplayer %d, No moves available", player);
		return;
	}
	else if(r == 0) {
		printf("\nPlayer %d, please enter your %s source and destination: ", player, moveOrders[i]);
		return;
	}
	else if(i == moves) {
		printf("\nNice move Player %d, end of your turn...", player);
		return;
	}
	else {
		printf("\nNice move Player %d , now please enter your %s source and destination: ", player, moveOrders[i]);
		return;
	}
	
}

int movePlayer(int player, int dice, int sRealm, int sRoom, int dRealm, int dRoom) {
	
	int piece;
	int dFirstFree, cellFirstFree;
	int distance;
	int nextPlayer = (player + 1) % 2;
	int step = player == sRealm ? -1 : 1;
	int i;
	
	if(board[sRealm][sRoom][0] == EMPTY) {
		return WRONG_MOVE;
	}
	
	if((player == 0 && board[sRealm][sRoom][0] >= S_2) || (player == 1 && board[sRealm][sRoom][0] <= K_1)) {
		return WRONG_MOVE;
	}
	
	piece = findFreePiece(sRealm, sRoom);
	
	if(board[dRealm][dRoom][0] == EMPTY) {
		dFirstFree = 0;
	} 
	else {
		dFirstFree = findFreePiece(dRealm, dRoom) + 1;
	}

	if(sRealm == dRealm) {
		if(dRoom == sRoom + step*dice) {
			if((player == 0 && board[dRealm][dRoom][0] >= S_2) || (player == 1 && board[dRealm][dRoom][0] <= K_1 && board[dRealm][dRoom][0] > EMPTY)) {
				if(board[dRealm][dRoom][1] != EMPTY) {
					return WRONG_MOVE;
				}
				else {
					for(cellFirstFree = 0 ; playerOs[nextPlayer][cellFirstFree] != EMPTY ; cellFirstFree++);
					
					playerOs[nextPlayer][cellFirstFree] = board[dRealm][dRoom][0];
					board[dRealm][dRoom][0] = board[sRealm][sRoom][piece];
					board[sRealm][sRoom][piece] = EMPTY;
					
					checkForCoinRelease(nextPlayer, cellFirstFree);
				}
			}
			else if(board[dRealm][dRoom][CAPACITY-1] != EMPTY) {
				return WRONG_MOVE; 
			}
			else {
				board[dRealm][dRoom][dFirstFree] = board[sRealm][sRoom][piece];
				board[sRealm][sRoom][piece] = EMPTY;
			}
		}
		else {
			return WRONG_MOVE;
		}
	}
	else {
		if(step == -1) {
			return WRONG_MOVE;
		}
		else {
			if((player == 0 && board[dRealm][dRoom][0] >= S_2) || (player == 1 && board[dRealm][dRoom][0] <= K_1 && board[dRealm][dRoom][0] > EMPTY)) {
				if(board[dRealm][dRoom][1] != EMPTY) {
					return WRONG_MOVE;
				}
				else {
					for(cellFirstFree = 0 ; playerOs[nextPlayer][cellFirstFree] != EMPTY ; cellFirstFree++);
					
					playerOs[nextPlayer][cellFirstFree] = board[dRealm][dRoom][0];
					board[dRealm][dRoom][0] = board[sRealm][sRoom][piece];
					board[sRealm][sRoom][piece] = EMPTY;
					
					checkForCoinRelease(nextPlayer, cellFirstFree);
				}
			}
			else if(board[dRealm][dRoom][CAPACITY - 1] != EMPTY) {
				return WRONG_MOVE;
			}
			else {
				distance = (COLUMNS - sRoom) + (COLUMNS - dRoom) - 1;
				
				if(distance == dice) {
					board[dRealm][dRoom][dFirstFree] = board[sRealm][sRoom][piece];
					board[sRealm][sRoom][piece] = EMPTY;
				}
				else {
					return WRONG_MOVE;
				}
			}
		}
	}
	
	for(i = 0 ; i < 3 ; i++) {
		if(holes[i][0] == dRealm && holes[i][1] == dRoom) {
			playerBanned[player] = 2;
			printf("\nPlayer %d, There was a hole right there ! You are banned for 2 turns!\n", player+1);
			getch();
		}
		else if(coins[i][0] == dRealm && coins[i][1] == dRoom) {
			coinsCollected[player]++;
			coins[i][0] = coins[i][1] = USED;
			printf("\n+1 coins collected! Player %d coins: %d\n", player+1, coinsCollected[player]);
			getch();
		}
	}
	
	return DONE;
}

void checkForCoinRelease(int player, int cellFirstFree) {
	
	if(coinsCollected[player] > 0) {
		int search;
		
		//check for first empty room
		for(search = 0 ; search < COLUMNS/2 ; search++) {
			if(board[(player + 1) % 2][search][0] == EMPTY) {
				break;
			}
		}
		
		if(search < COLUMNS/2) {		
			char c;
			
			printf("\n\nPlayer %d, do you want to use your coin? y. Yes n. No : ", player+1);
			
			c = getch();
			
			if(c == 'y' || c == 'Y') {
				coinsCollected[player]--;
				//moving out piece to particular room of the oppsite player's castle
				board[(player + 1) % 2][search][0] = playerOs[player][cellFirstFree];
				//removing the out piece from cell
				playerOs[player][cellFirstFree] = EMPTY;
			}
		}
	}
	
	return;
}

//find which piece of the specific part and column has to move
//realm : free piece's part
int findFreePiece(int realm, int room) {
	
	int x = CAPACITY - 1;
	
	for(x ; x >= 0 && board[realm][room][x] == EMPTY ; x--);
	
	return x; //returing index of the row of that specific realm(part) and room(column)
}

int freeThePiece(int player, int pIndex, int dice) { 

	int nextPlayer = (player + 1) % 2;
	int cellFirstFree;
	int dFirstFree;
	int i;
	
	if(board[nextPlayer][dice - 1][0] == EMPTY) {
		dFirstFree = 0;
	}
	else {
		dFirstFree = findFreePiece(nextPlayer, dice-1) + 1;
	}
	
	if(board[nextPlayer][dice - 1][CAPACITY - 1] != EMPTY) {
		return WRONG_MOVE;
	}
	
	if((player == 0 && board[1][dice - 1][1] >= S_2) || (player == 1 && board[0][dice - 1][1] <= K_1 && board[0][dice - 1][1] > EMPTY)) {
		return WRONG_MOVE;
	}
	
	if((player == 0 && board[1][dice - 1][0] >= S_2) || (player == 1 && board[0][dice - 1][0] <= K_1 && board[0][dice - 1][0] > EMPTY)) {
		for(cellFirstFree = 0 ; playerOs[nextPlayer][cellFirstFree] != EMPTY ; cellFirstFree++);
		
		playerOs[nextPlayer][cellFirstFree] = board[nextPlayer][dice - 1][0];
		board[nextPlayer][dice - 1][0] = playerOs[player][pIndex] ;
		playerOs[player][pIndex] = EMPTY;
		
		checkForCoinRelease(nextPlayer, cellFirstFree);
	}
	else {
		board[nextPlayer][dice - 1][dFirstFree] = playerOs[player][pIndex];
		playerOs[player][pIndex] = EMPTY;
	}
	
	for(i = pIndex ; i < PIECES-1 ; i++) {
		playerOs[player][i] = playerOs[player][i + 1];
	}
	
	for(i = 0 ; i < 3 ; i++) {
		if(coins[i][0] == nextPlayer && coins[i][1] == dice - 1) {
			coinsCollected[player]++;
			coins[i][0] = coins[i][1] = USED;
			printf("\n+1 coins collected! Player %d coins: %d\n", player, coinsCollected[player]);
		}
	}
	
	return DONE;
}

int isPlayerCastleFull(int player) {
	
	int numberOfPiecesInCastle = 0;
	int flag = 0;
	int i, j;
	
	for(i = 0 ; i < COLUMNS/2 ; i++) {
		for(j = 0 ; j < CAPACITY && board[player][i][j] != EMPTY ; j++) {
			if(player == 0 && board[player][i][j] > EMPTY && board[player][i][j] <= K_1) {
				numberOfPiecesInCastle++;
			}
			else if(player == 1 && board[player][i][j] >= S_2) {
				numberOfPiecesInCastle++;
			}
		}
	}
	
	if(numberOfPiecesInCastle == PIECES - point[player]) {
		flag = 1;
	}
	
	return flag;
}

//victory process
//sRealm : source's part , sRoom : source's room
int movePieceToO(int player, int sRealm, int sRoom, int dice) {
	
	int flag = 0;
	int piece = findFreePiece(sRealm, sRoom);
	int numberOfPiecesInCastle = 0;
	//check whether that specifc place is empty or not
	if(board[sRealm][sRoom][0] == EMPTY) {
		return WRONG_MOVE;
	}
	//check that each player moves out her/his own pieces -- player == 0 -> player1 -- player == 1 -> player2
	if((player == 0 && board[sRealm][sRoom][0] >= S_2) || (player == 1 && board[sRealm][sRoom][0] <= K_1)) {
		return WRONG_MOVE;
	}

	flag = isPlayerCastleFull(player);
	
	if((sRealm == player && sRoom == dice-1) || (flag == 1 && ((sRoom == 4 && dice >= 5) || (sRoom == 3 && dice >= 4) ||
															   (sRoom == 2 && dice >= 3) || (sRoom == 1 && dice >= 2) || 
															   (sRoom == 0 && dice >= 1)))) {
		//number of outed piece
		point[player]++;
		//removing the piece from the board
		board[sRealm][sRoom][piece] = EMPTY;
		//checking the process of reaching victory
		if(point[player] == PIECES) {
			printf("\n*! Player %d Won !* ", player+1);
			getch();
			exit(1);
		}
	}
	else {
		return WRONG_MOVE;
	}
	
	return DONE;
}

//returning number of the saved games
int loadNames(int readMode) {
	
	int i;
	
	FILE *fSavedNames = fopen(savedGameNumber, "r");
	
	newSaveNumber = 1;
	
	if(!fSavedNames) {
		return 1;
	}
	
	fscanf(fSavedNames, "%d", &newSaveNumber);
	
	newSaveNumber++;
	
	if(readMode == SHOW) {
		printf("\n\nSaves:\n");
		for(i = 1 ; i < newSaveNumber ; i++) {
			printf("%d. Shatnard%d\n", i, i);
		}
	}

	return newSaveNumber;	
}

int save(int turn) {
	
	int i, j, k;
	
	FILE *f = fopen(savedGame, "a");
	FILE *fSaveNames = fopen(savedGameNumber, "w");
	
	if(!f) {
		f = fopen(savedGame, "w");
		
		newSaveNumber = 1;
		
		if(!f || !fSaveNames) {
			return SAVE_INTERRUPTED;
		}
	}

	fprintf(f, "Shatnard%d\n", newSaveNumber);
	fprintf(fSaveNames, "%d\n", newSaveNumber);
	
	fclose(fSaveNames);
	//saving board
	for(i = 0 ; i < ROWS ; i++) {
		for(j = 0 ; j < COLUMNS ; j++) {
			for(k = 0 ; k < CAPACITY ; k++) {
				fprintf(f, "%d\n", board[i][j][k]);
			}
		}
	}
	//saving out pieces
	for (i = 0 ; i < 2 ; i++) {
		for(j = 0 ; j < PIECES ; j++) {
			fprintf(f, "%d\n", playerOs[i][j]);
		}
	}
	//saving points gained in victory process
	fprintf(f, "%d\n%d\n", point[0], point[1]);
	//saving holes
	for(i = 0 ; i < 3 ; i++) {
		fprintf(f, "%d\n%d\n", holes[i][0], holes[i][1]);
	}
	//saving coins
	for(i = 0 ; i < 3 ; i++) {
		fprintf(f, "%d\n%d\n", coins[i][0], coins[i][1]);
	}
	//saving banned players and collected coins
	fprintf(f, "%d\n%d\n%d\n%d\n%d\n", playerBanned[0], playerBanned[1], coinsCollected[0], coinsCollected[1], turn);
	
	fclose(f);
	
	newSaveNumber++;
	
	return DONE;
}
