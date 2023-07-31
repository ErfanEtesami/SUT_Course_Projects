#include <stdio.h>
#include <ctype.h>

void toUpper(char *string);

int main(int argc, char *argv[]) {
	
	char string[] = "hello world";
	
	toUpper(string);
	
	printf("%s", string);
	
	return 0;
}

void toUpper(char *string) {
	while(*string != '\0') {
		*string = toupper(*string);
		string++;
	}
}
