/*
	* O(lgn) algorithm to implement x^n
	* if you complie it on windows change the character set to utf8-BOM
	*/
#include <stdio.h>

int main()
{
				int x,n,powerSum=1,i,bit;
				printf("input the x and the power n(seperate by spaces)\n");
				scanf("%d %d",&x,&n);
				int xarry[n];
				xarry[1]=x;
				i=1;
				while(1<<i<=n)
				{
								i++;
								xarry[i]=xarry[i-1]*xarry[i-1];
				}
				bit=i;
				for(i=1;i<=bit;i++)
								powerSum*=((n>>(i-1))&1)*xarry[i]+!(n&(1<<(i-1)));
				printf("%d",powerSum);

				return 0;
}
