#include <stdio.h>

size_t getsize(float *Ptr);

int main(int argc, char *argv[]) {
	
	float numbers[20];
	
	printf("%u\n%u", sizeof(numbers), getsize(numbers));
	
	return 0;
}

size_t getsize(float *Ptr) {
	return sizeof(Ptr);
}


