#include <stdio.h>

int main()
{
    char g;
    int nA = 0;
    int nB = 0;
    int nC = 0;
    int nD = 0;

    while ((g = getchar()) != EOF){
        switch (g){
        case 'A':
        case 'a':
            nA++;
            break;
        case 'B':
        case 'b':
            nB++;
            break;
        case 'C':
        case 'c':
            nC++;
            break;
        case 'D':
        case 'd':
            nD++;
            break;
        }//end of switch
    }//end of while
    int n = nA+nB+nC+nD;
    printf("Grade\tCount\tPercent\n");
    printf("A\t%d\t%.2f\n",nA,(float)nA*100/n);
    printf("B\t%d\t%.2f\n",nB,(float)nB*100/n);
    printf("C\t%d\t%.2f\n",nC,(float)nC*100/n);
    printf("D\t%d\t%.2f\n",nD,(float)nD*100/n);
    return 0;
}
