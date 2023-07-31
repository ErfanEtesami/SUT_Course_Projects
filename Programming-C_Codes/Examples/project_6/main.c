#include <stdio.h>
#include <stdlib.h>

int Fibo1(int n);
int Fibo2(int n);

int main()
{
    int n;
    printf("Input the number :\n");
    scanf("%d",&n);
    printf("\n");

    int i;
    for(i=0 ; i<n ; i++){
    printf("F(%d) : %d\n",i,Fibo1(i));
    }
    printf("\n");

    int j;
    for(j=0 ; j<n ; j++){
    printf("F(%d) : %d\n",j,Fibo2(j));
    }
    printf("\n");

    printf("Golden Ratio :\n");
    int k;
    for(k=1 ; k<=n ; k++){
        float r = (float) Fibo2(n+1)/Fibo2(n);
        printf("R(%d) = F(%d)/F(%d) = %f\n",k,k+1,k,r);
    }
    return 0;

}

int Fibo1(int n){

    if (n<=0) return 0;
    if (n==1) return 1;

    int i;
    int n1 = 0;
    int n2 = 1;
    int n3;

    for(i=2 ; i<=n ; i++){
        n3 = n1 + n2;
        n1 = n2;
        n2 = n3;
    }

    return n3;

}

int Fibo2(int n){
    if (n==0){
        return 0;
    }
    if (n==1){
        return 1;
    }
    return Fibo2(n-1) + Fibo2(n-2);
}
