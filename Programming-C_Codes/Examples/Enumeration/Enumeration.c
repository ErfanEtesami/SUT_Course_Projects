#include <stdio.h>

enum months { JAN = 1, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, DEC
};

int main(int argc, char *argv[]) {
	
	enum months month;
	
	char *monthname[] = {"", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
	
	for(month = JAN ; month <= DEC ; month++) {
		printf("%d\t%s\n", month, monthname[month]);
	}
	return 0;
}
