#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct line {
	char name[1000];
	struct line *nextPtr;
};

typedef struct line Line;
typedef Line *LinePtr;

struct temp {
	char name[1000];
	int exist;
};

typedef struct temp Temp;

void add(LinePtr *lPtr, char *array);
void out(LinePtr *lPtr, char *array);
int isEmpty(LinePtr lPtr);
void backToClassroom(LinePtr currentPtr);
void first(LinePtr *lPtr, char *array);
void place(LinePtr *lPtr, char *newName, char *otherName);
static void reverse(LinePtr* lPtr);

int main(int argc, char *argv[]) {
	
	char order[25];
	LinePtr startPtr = NULL;
	char tempName1[1000];
	char tempName2[1000];
	Temp array[1000];
	int i = 0, j;
	int check = 0;
	
	scanf("%s", order);
	
	while(strcmp(order, "back") != 0) {
		
		if(strcmp(order, "add") == 0) {
			scanf("%s", tempName1);
			for(j = 0 ; j < 1000 ; j++) {
				if(strcmp(array[j].name, tempName1) == 0) {
					check = 1;
					array[j].exist = 2;
				}
			}
			if(check == 0) {
				add(&startPtr, tempName1);
			}
		}
		
		if(strcmp(order, "out") == 0) {
			scanf("%s", tempName1);
			out(&startPtr, tempName1);
		}
		
		if(strcmp(order, "first") == 0) {
			scanf("%s", tempName1);
			first(&startPtr, tempName1);
		}
		
		if(strcmp(order, "ja") == 0) {
			scanf("%s", tempName1);
			scanf("%s", tempName2);
    		place(&startPtr, tempName2, tempName1);
    		strcpy(array[i].name, tempName2);
    		array[i].exist = 1;
    		i++;
		}
		
		if(strcmp(order, "doaye") == 0) {
			reverse(&startPtr);
		}
		
		scanf("%s", order);
	}
	
	if(strcmp(order, "back") == 0) {
		for(j = 0 ; j < 1000 ; i++) {
			if(array[j].exist == 1) {
				out(&startPtr, array[i].name);
			}
		}
		backToClassroom(startPtr);
	}
	
	return 0;
}


int isEmpty(LinePtr lPtr) {
	return (lPtr == NULL);
}

void backToClassroom(LinePtr currentPtr) {
	if(isEmpty(currentPtr)) {
		printf("line is empty.\n");
	}
	else {
		while(currentPtr != NULL) {
			printf("%s\n", currentPtr->name);
			currentPtr = currentPtr->nextPtr;
		}
	}
}

static void reverse(LinePtr* lPtr) {
    LinePtr previousPtr = NULL;
    LinePtr currentPtr = *lPtr;
    LinePtr afterPtr;
    while(currentPtr != NULL) {
        afterPtr  = currentPtr->nextPtr;  
        currentPtr->nextPtr = previousPtr;   
        previousPtr = currentPtr;
        currentPtr = afterPtr;
    }
    *lPtr = previousPtr;
}

void out(LinePtr *lPtr, char *array) {
	LinePtr tempPtr;
	if(strcmp(array, (*lPtr)->name) == 0) {
		tempPtr = *lPtr;
		*lPtr = (*lPtr)->nextPtr;
		free(tempPtr);
	}
	else {
		LinePtr previousPtr = *lPtr;
		LinePtr currentPtr = (*lPtr)->nextPtr;
		while((currentPtr != NULL) && ((strcmp(currentPtr->name, array)) != 0)) {
			previousPtr = currentPtr;
			currentPtr = currentPtr->nextPtr;
		}
		if(currentPtr != NULL) {
			tempPtr = currentPtr;
			previousPtr->nextPtr = currentPtr->nextPtr;
			free(tempPtr);
		}
	}
}

void first(LinePtr *lPtr, char *array) {
    LinePtr newPtr = malloc(sizeof(Line));
    strcpy(newPtr->name, array);
    newPtr->nextPtr = (*lPtr);
    (*lPtr) = newPtr;
}

void add(LinePtr *lPtr, char *array) {
    LinePtr newPtr = malloc(sizeof(Line));
    LinePtr lastPtr = *lPtr;
	strcpy(newPtr->name, array);
    newPtr->nextPtr = NULL;
    if(*lPtr == NULL) {
       *lPtr = newPtr;
       return;
    }  
    while(lastPtr->nextPtr != NULL) {
        lastPtr = lastPtr->nextPtr;
    }
    lastPtr->nextPtr = newPtr;    
}

void place(LinePtr *lPtr, char *newName, char *otherName) {
	
    if(lPtr == NULL) {
        return;
    }

    Line *walk = *lPtr;
    
    while(walk) {
        if(strcmp(walk->name, otherName) == 0) {
            LinePtr newPtr = (LinePtr)malloc(sizeof(Line));
            strcpy(newPtr->name, newName);
            newPtr->nextPtr = walk->nextPtr;
            walk->nextPtr = newPtr;
            break;
        }
        walk = walk->nextPtr;
    }
}
