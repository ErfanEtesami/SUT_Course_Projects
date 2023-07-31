#include <stdio.h>

void copy1(char *const str1, const char *const str2);
void copy2(char *str1, const char *str2);

int main(int argc, char *argv[]) {
	
	char *string;
	int size = 0;
	
	gets(string);
	
	int i = 0;
	while(string[i] != '\0') {
		size++;
		i++;
	}
	
	char str1[size], str2[size];
	
	copy1(str1, string);
	copy2(str2, string);
	
	printf("%s\n", str1);
	printf("%s\n", str2);
	
	return 0;
}

void copy1(char *const str1, const char *const str2) {
	
	int i;
	
	for(i=0 ; ((str1[i] = str2[i]) != '\0') ; i++){
		;
	}
	
}

void copy2(char *str1, const char *str2) {
	
	int i;
	
	for( ; ((*str1 = *str2) != '\0') ; str1++, str2++) {
		;
	}
}
