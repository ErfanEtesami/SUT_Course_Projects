#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int Search(char *search, int row, int col, char **grid, int row_max, int col_max) {
	
    int numOfFound = 0;
 
    if(row >= 0 && row <= row_max && col >= 0 && col <= col_max && *search == grid[row][col]) {
             
        char match = *search++;
        
        grid[row][col] = 0;
 
        if(*search == 0) {
            numOfFound = 1;
        }
		else { 
            numOfFound += Search(search, row, col+1, grid, row_max, col_max);
            numOfFound += Search(search, row+1, col, grid, row_max, col_max);
        }
 
        grid[row][col] = match;
    }
 
    return numOfFound;
}
 
int searchGrid(char *search, int row, int col, char **grid, int row_count, int col_count) {
	
    int numOfFound = 0;
    int i, j;
 
    for(i = 0 ; i < row_count ; i++) {
        for(j = 0 ; j < col_count; j++) {
            numOfFound += Search(search, i, j, grid, row_count-1, col_count-1);
        }
    }
 
    return numOfFound;
}

int main(void) {
	
	char **grid = NULL;
	char **search = NULL;
	int count[100] = {0};
	int numOfRows;
	int numOfSearch;
	int maxChar;
	int i, j, k;
	
	scanf("%d", &numOfRows);
	
	grid = malloc(100 * sizeof(char *));
	search = malloc(100 * sizeof(char *));
	
	for(i = 0 ; i < 100 ; i++) {
		grid[i] = malloc(100 * sizeof(char));
	}
	
	for(i = 0 ; i < 100 ; i++) {
		search[i] = malloc(100 * sizeof(char));
	}
	
	for(i = 0 ; i < numOfRows ; i++) {
		scanf("%s", grid[i]);
	}
	
	scanf("%d", &numOfSearch);
	
	for(i = 0 ; i < numOfSearch ; i++) {
		scanf("%s", search[i]);
	}
	
	maxChar = strlen(grid[0]);
	for(i = 1 ; i < numOfRows ; i++) {
		if(maxChar < strlen(grid[i])) {
			maxChar = strlen(grid[i]);
		}
	}
	
	for(i = 0 ; i < numOfRows ; i++) {
		for(j = strlen(grid[i]) ; j < maxChar ; j++) {
			strcat(grid[i], " ");
		}
	}
	
	for(i = 0 ; i < numOfSearch ; i++) {
    	printf("%d\n", searchGrid(search[i], 0, 0, grid, numOfRows, maxChar));
	}
		
    return 0;
}
