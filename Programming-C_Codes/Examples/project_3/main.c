#include <stdio.h>
#include <stdlib.h>

int main()
{
    int n;
    printf("Enter an number :\n");
    scanf("%d",&n);
    if(n=1){
        printf("one");
    }
    printf("\n%d",n);
    int a = 10;

    float m;
    m = a/3;
    printf("\n\n%d",m);
    printf("\n\n%f",m);
    float b = (float)a/3;
    printf("\n\n%f",b);
    printf("\n\n%10.2f",b);

    while (0){
        printf("a");
    }
    return 0;
}
