#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>

int row,column;
int main()
{
    int compute(int **matrix,int row,int column,int num);
    int i,j;

    scanf("%d %d",&row,&column);
    getchar();


    int *matrix[row];
    for(i=0;i<row;i++)
    {
	matrix[i]=(int *)malloc(column*sizeof(int));
	for(j=0;j<column;j++)
	{
	    scanf("%d",&matrix[i][j]);
	    getchar();
	}
    }

    printf("%d\n",compute(matrix,row,column,1));

    for(i=0;i<row;i++)
    {
	free(matrix[i]);
	matrix[i]=0;
    }
    return 0;
}


int compute(int **matrix,int row,int column,int num)
{
    static int * subscript=0;
    static int result=0;
    int i,j,flag,product;

    if(!subscript)
    {
	subscript=(int *)malloc((row+1)*sizeof(int));
	subscript[0]=-1;
    }

    if(num<=row){ //find the correct sequence
	for(i=0;i<column;i++)
	{
	    flag=0;
	    subscript[num]=i;
	    for(j=num-1;j>=0;j--)
	    {
		if(subscript[num]==subscript[j]){
		    flag=1; break;
		}
	    }
	    if(flag) continue; //iterate when i!=0,that is, no repitive number
	    compute(matrix,row,column,num+1); //find the next number corresponding to condition
	}
	if(!subscript){
	    free(subscript);
	    subscript=0;
	}
    }else {
	flag=0;
	product=1;
	for(i=0;i<row;i++)
	{
	    product*=matrix[i][subscript[i+1]];
	}
	for(i=1;i<=row;i++)
	{
	    for(j=1;j<i;j++)
		if(subscript[j]>subscript[i])flag++;
	}
	result+=(-2*(flag%2)+1)*product;
    }

    return result;
}
