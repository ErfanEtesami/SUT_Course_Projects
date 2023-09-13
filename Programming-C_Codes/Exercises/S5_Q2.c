#include <stdio.h>
#include <string.h>

int main(void) {
	
	int numOfWords;
	
	scanf("%d", &numOfWords);
	
	char sentences[1000][1000];
	char key[1000];
	int countKey = 0;
	int count[1000] = {0};
	int maxChar;
	int maxOccur;
	int i, j, k;
	
	for(i = 0 ; i < numOfWords ; i++) {
		scanf("%s", sentences[i]);
	}
	
	scanf("%s", key);
    
	//finding occurence of the key
	for(i = 0 ; i < numOfWords ; i++) {
        if(strcmp(sentences[i], key) == 0) {
        	countKey++;
		}
    }
    
    //duplicate elimination and count frequency of every original word
	for(i = 0 ; i < numOfWords ; i++) {
        for(j = i+1 ; j < numOfWords ; ) {
            if(strcmp(sentences[i], sentences[j]) == 0) {
                for(k = j ; k < numOfWords-1 ; k++) {
                    strcpy(sentences[k], sentences[k+1]);
                }
                numOfWords--;
                count[i]++;
            }
            else {
            	j++;
			}
        }
    }
    
    //finding the repetitive word
    maxOccur = count[0];
    k = 0;
    for(i = 1 ; i < numOfWords ; i++) {
        if(maxOccur < count[i]) {
           maxOccur = count[i];
           k = i;
        }
	}
    
	//find the longest word
	maxChar = strlen(sentences[0]);
	j = 0;
	
    for(i = 1 ; i < numOfWords ; i++) {
        if(maxChar < strlen(sentences[i])) {
           maxChar = strlen(sentences[i]);
           j = i;
        }
	}
	
	printf("%s\n%s\n%d", sentences[k], sentences[j], countKey);
    
    return 0;
}
