#include <stdio.h>
#include <malloc.h>
#define MAXLENGTH 20
typedef struct
{
    int pow;
    double constant;
}item;
typedef struct 
{
    item list[MAXLENGTH];
    int size;
}polynomial;
polynomial * initialList();
void sortList(polynomial * poly,int left,int right);
polynomial *addlist(polynomial *a,polynomial *b);
void outputList(polynomial *poly);

int main()
{
    int i,j;
    polynomial * poly1=initialList();
    polynomial * poly2=initialList();
    i=0;
    while(scanf("%lf %d",&(poly1->list[i].constant),&(poly1->list[i].pow))!=EOF)
    {
	i++;
    }
    j=0;
    while(scanf("%lf %d",&(poly2->list[i].constant),&(poly2->list[i].pow))!=EOF)
    {
	j++;
    }
    poly1->size=i+1;
    poly2->size=j+1;
    outputList(poly1);
    outputList(poly2);
    outputList(addlist(poly1,poly2));
    return 0;
}
polynomial * initialList()
{
    polynomial * poly=(polynomial *)malloc(sizeof(polynomial));
    poly->size=0;
    return 0;
}

void sortList(polynomial * poly,int left,int right)
{
    int i = left, j = right;
    item * list=poly->list;
    item * key = &(poly->list[left]);

    if (left >= right)
    {
	return;
    }

    while (i<j)
    {
	while (i<j&&key->pow >= list[j].pow)
	{
	    j--;
	}
	list[i] = list[j];
	while (i<j&&key->pow <= list[i].pow)
	{
	    i++;
	}
	list[j] = list[i];
    }

    list[i] = *key;

    sortList(poly, left, i - 1);
    sortList(poly, i + 1, right);

}
polynomial *addlist(polynomial *a,polynomial *b)
{
    int i,j,repeat;
    polynomial * poly=initialList();

    sortList(a,0,a->size-1);
    sortList(b,0,b->size-1);

    for(i=j=repeat=0;i<a->size&&j<b->size;)
    {
	poly->list[i+j]=a->list[i].pow<=b->list[j].pow?a->list[i++]:b->list[j++];
	if(a->list[i].pow==b->list[j].pow) 
	{
	    repeat++;
	    j++;
	    continue;
	}
	poly->list[i+j]=a->list[i].pow<=b->list[j].pow?b->list[j++]:a->list[i++];
    }
    poly->size=a->size+b->size-repeat;
    return poly;
}
void outputList(polynomial *poly)
{
    int i;
    printf("%lfx^%d",poly->list[0].constant,poly->list[0].pow);
    for(i=1;i<poly->size;i++)
    {
	printf("+%lfx^%d",poly->list[i].constant,poly->list[i].pow);
    }
    putchar('\n');
}

