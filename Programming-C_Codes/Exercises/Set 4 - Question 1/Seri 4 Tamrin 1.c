#include <stdio.h>
#include <stdlib.h>

int main()
{
    int i;
    char name[1000];
    
    scanf("%[^\n]s",name);
    
	for(i=0 ; name[i] != '\0' ; i++) {
		
		if(i==0) {
			if((name[i]>='a' && name[i]<='z')) {
				name[i]=name[i]-32;
			}	
			continue;
		}		
		else {
			if(name[i]>='A' && name[i]<='Z') {
				name[i]=name[i]+32;
			}	
		}
		
	}
	
	printf("%s",name);

    return 0;
}
