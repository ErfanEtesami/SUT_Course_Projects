#include <stdio.h>
#include <stdlib.h>

int main()
{
    int i, space, rows, k=0;

    printf("Enter number of rows:\n");
    scanf("%d",&rows);

    for(i=1; i<=rows; i++)
    {
        for(space=1; space<=rows-i; ++space)
        {
            printf("  ");
        }

        for(k=1;k<=i;k++){
            printf(" *  ");
        }

        printf("\n");
    }

    return 0;
}
