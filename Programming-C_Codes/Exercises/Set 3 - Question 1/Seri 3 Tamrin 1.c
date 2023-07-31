#include <stdio.h>

void state_of_lines (int num);

int main(int argc, char *argv[]) {
	
	int num;
	
	scanf("%d",&num);
	
	state_of_lines(num);

	return 0;
}

void state_of_lines (int num) {
	
	int a1,b1,c1,a2,b2,c2;
	int i;
	
	for(i = 1 ; i <= num ; i++) {
		
		scanf("%d %d %d %d %d %d",&a1,&b1,&c1,&a2,&b2,&c2);
		
		if(a1 != 0 && a2 != 0 ) {
		
			if( (b1*a2 == b2*a1) && (c1*a2 == c2*a1) ) {
				printf("coincident\n");
			}
			else if( (b1*a2 == b2*a1) && (c1*a2 != c2*a1) ){
				printf("parallel\n");
			}
			else if ( b1*b2 == -1*a1*a2 ) {
				printf("perpendicular\n");
			}
			else {
				printf("intersecting\n");
			}
		}
		if(a1 == 0 && a2 != 0) {
			if(b2 == 0) {
				printf("perpendicular\n");
			}
			else {
				printf("intersecting\n");
			}
		}
		if(a1 != 0 && a2 == 0) {
			if(b1 == 0) {
				printf("perpendicular\n");
			}
			else {
				printf("intersecting\n");
			}
		}
		if(a1==0 && a2==0) {
			if( c1*b2 == c2*b1 ) {
				printf("coincident\n");
			}
			else {
				printf("parallel\n");
			}
		}
	}	
}
