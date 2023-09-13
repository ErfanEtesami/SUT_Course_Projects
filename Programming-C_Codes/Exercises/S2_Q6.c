#include <stdio.h>

#define max(a,b) ((a)>(b)?(a):(b))

int main(int argc, char *argv[]) {
	
	float x1,y1; //a
	float x2,y2; //b
	float x3,y3; //c
	
	scanf("%f %f",&x1,&y1);
	scanf("%f %f",&x2,&y2);
	scanf("%f %f",&x3,&y3);
	
	float dis_a_b,dis_a_c,dis_b_c,dis_max;
	//square of the distance
	dis_a_b = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
	dis_a_c = (x3-x1)*(x3-x1) + (y3-y1)*(y3-y1);
	dis_b_c = (x3-x2)*(x3-x2) + (y3-y2)*(y3-y2);
	
	dis_max = max(max(dis_a_b,dis_a_c),dis_b_c);
	
	if(dis_max == dis_a_b) {
		printf("%.2f %.2f",x1+x2-x3,y1+y2-y3);
	}
	if(dis_max == dis_a_c) {
		printf("%.2f %.2f",x1+x3-x2,y1+y3-y2);
	}
	if(dis_max == dis_b_c) {
		printf("%.2f %.2f",x2+x3-x1,y2+y3-y1);
	}
	
}
