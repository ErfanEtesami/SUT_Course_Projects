#include <stdio.h>
#include <string.h>

typedef struct {
	char name[100];
	int exist; // 1 : exists , 0 : doesn't exist
} Books;

typedef struct {
	char name[100];
	int record; // member's last book , 1 : returned , 0 : not returned
} Members;


int main(void) {
	
	Books library[100][100];
	Members member[100];

	char order[10];
	
	int num; // number of books entered
	int tempNum;
	int countMember = 0; // number of members
	int m, n; // m : columns of the library , n : rows of the library;
	
	char tempMember[100]; //input member's name
	char tempBook[100]; //input book's name
	
	int i, j, h, k;
	//set all the existence to 0
	for(i = 0 ; i < 100 ; i++) {
		for(j = 0 ; j < 100 ; j++) {
			library[i][j].exist = 0;
		}
	}
	//set all the records to 1
	for(i = 0 ; i < 100 ; i++) {
		member[i].record = 1;
	}
	
	scanf("%d%d", &m, &n);
	
	scanf("%d", &num);
	
	tempNum = num; //used in donate part
	
	for(i = 0 ; i < n ; i++) {
		for(j = 0 ; j < m ; j++) {
			if(num == 0) {
				break;
			}
			scanf("%s", library[i][j].name);
			library[i][j].exist = 1;
			num--;
		}
		if(num == 0) {
			break;
		}
	}
	
	scanf("%s", &order);
	
	i = 0;
	
	while(strcmp(order, "end") != 0) {
		
		if(strcmp(order, "add") == 0) {
			scanf("%s", member[i].name);
			
			i++;
			countMember++;
		}
		
		int check1 = -1;
		int check2 = -1;
		int tempRow;
		int tempColumn;
		
		if(strcmp(order, "borrow") == 0) {
			scanf("%s", &tempMember);
			scanf("%s", &tempBook);
			
			for(j = 0 ; j < n ; j++) {
				for(k = 0 ; k < m ; k++) {
					if(strcmp(library[j][k].name, tempBook) == 0) {
						if(library[j][k].exist == 1) {
							tempRow = j;
							tempColumn = k;
							check1 = 1;
							break;
						}
						else {
							check1 = 0;
							break;
						}
					}
				}
				
				if(check1 == 1 || check1 == 0) {
					break;
				}
			}
			
			if(check1 == 0 || check1 == -1) {
				printf("we don't have this book.\n");
			}
			
			if(check1 == 1) {
				for(h = 0 ; h < countMember ; h++) {
					if(strcmp(member[h].name, tempMember) == 0) {
						if(member[h].record == 1) {
							library[tempRow][tempColumn].exist = 0;
							member[h].record = 0;
							check2 = 1;
							break;
						}
						else {
							printf("action can't be done.\n");
							check2 = 0;
							break;
						}
					}
				}
				
				if(check2 == -1) {
					printf("we don't have this member.\n");
				}
			}	
		}
		
		int check3 = -1;
		
		if(strcmp(order, "return") == 0) {
			scanf("%s", &tempMember);
			scanf("%s", &tempBook);
			
			for(j = 0 ; j < n ; j++) {
				for(k = 0 ; k < m ; k++) {
					if(strcmp(library[j][k].name, tempBook) == 0) {
						library[j][k].exist = 1;
						check3 = 1;
						break;
					}
				}
				
				if(check3 == 1) {
					break;
				}
			}
			
			for(h = 0 ; h < countMember ; h++) {
				if(strcmp(member[h].name, tempMember) == 0) {
					member[h].record = 1;
					break;
				}
			}
		}
		
		if(strcmp(order, "donate") == 0) {
			scanf("%s", &tempMember);
			scanf("%s", &tempBook);
			
			int check4 = tempNum;
			
			for(j = 0 ; j < n ; j++) {
				for(k = 0 ; k < m ; k++) {
					if(tempNum >= m * n) {
						printf("we don't have enough space.\n");
						break;
					}
					if(check4 > -1) {
						check4--;					
					}
					if(check4 == -1) {
						strcpy(library[j][k].name, tempBook);
						library[j][k].exist = 1;
						tempNum++;
						break;					
					}
				}
				if(tempNum >= m * n) {
					break;
				}
				if(check4 == -1) {
					break;
				}
			}
		}
		
		scanf("%s", &order);
	}
	
	if(strcmp(order, "end") == 0) {
		for(j = 0 ; j < n ; j++) {
			for(k = 0 ; k < m ; k++) {
				if(tempNum > 0) {
					printf("%s : %s [%d,%d]\n", library[j][k].name, library[j][k].exist == 1 ? "available" : "unavailable", j+1, k+1);
					tempNum--;
				}
				if(tempNum == 0) {
					break;
				}
			}
			
			if(tempNum == 0) {
				break;
			}
		}
	}

	return 0;
}
