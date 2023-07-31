#include <stdio.h>

void PrintArray(int a[], int N);
void BubbleSort(const int a[], int N);
void Swap(int a[], int j1, int j2);

int main()
{
    int a[]={23,53,12,10,17,56,78,34,29,37,45,12,19,20,40,90,43,48,62};

    int N=sizeof(a)/sizeof(a[0]);

    printf("Array before sorting:\n");
    PrintArray(a,N);
    printf("\n\n");

    BubbleSort(a,N);

    printf("Array after sorting:\n");
    PrintArray(a,N);
    printf("\n\n");

    return 0;
}

void BubbleSort(const int a[], int N)
{
    int i, j;
    int swapped;

    for(i=0; i<N; i++) //pass
    {
        swapped = 0;
        for(j=0; j<N-1; j++) //eleman
        {
            if(a[j]>a[j+1])
            {
                Swap(a,j,j+1);
                swapped = 1;
            }
        }
        if(!swapped) break;
    }
}

void Swap(int a[], int j1, int j2)
{
    int temp;
    temp = a[j1];
    a[j1] = a[j2];
    a[j2] = temp;
}

void PrintArray(int a[], int N)
{
    int i;
    for(i=0; i<N; i++)
    {
        printf("%d",a[i]);
        if(i<N-1)
        {
            printf(", ");
        }
    }
}
