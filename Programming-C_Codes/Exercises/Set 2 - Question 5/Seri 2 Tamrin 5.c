#include <stdio.h>
#include <math.h>

int main(int argc, char *argv[]) {
	
	float Vx, Vy, y0, h;
	float t1,t2;
	int g=10;
	
	scanf("%f %f %f %f",&Vx,&Vy,&y0,&h);
	
	t1 = (Vy + sqrt(Vy*Vy - 2*g*(h-y0)))/g;
	t2 = (Vy - sqrt(Vy*Vy - 2*g*(h-y0)))/g;
	
	if ( (t1>=0 && t2>=0) && (t1>t2) ) {
		printf("%.2f\n%.2f",Vx*t2,Vx*t1);
	}
	else if ( (t1>=0 && t2>=0) && (t2>t1) ) {
		printf("%.2f\n%.2f",Vx*t1,Vx*t2);
	}
	else if ( (t1>=0 && t2>=0) && (t1 == t2) ) {
		printf("%.2f",Vx*t1);
	}
	else if ( t1==0 && t2>0 ) {
		printf("%.2f",Vx*t2);
	}
	else if ( t2==0 && t1>0 ) {
		printf("%.2f",Vx*t1);
	}
	else if ( t1>=0 && t2<0 ) {
		printf("%.2f",Vx*t1);
	}
	else if ( t2>=0 && t1<0 ) {
		printf("%.2f",Vx*t2);
	}
	else {
		printf("impossible");
	}
		
	return 0;
}
