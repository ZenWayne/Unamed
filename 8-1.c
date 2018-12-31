#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
#include <time.h>
#define MAXVERTICE 20
#define MAXWEIGHT 10000

typedef struct list{
    int node;
    union {
	int weight;
	char visited;

    };
    struct list *next;

}list;

typedef struct {
    char vertices[MAXVERTICE];
    int edge[MAXVERTICE][MAXVERTICE];
    int numOfVerts;

}graphMatrix;

typedef struct {
    list *verticesList[MAXVERTICE];
    int numOfVerts;

}graphList;

graphList *initgraphList(graphMatrix *GM)
{
    graphList * p=(graphList *)malloc(sizeof(graphList));
    list *tmp=0;
    p->numOfVerts=GM->numOfVerts;
    int i,j;

    for(i=0;i<p->numOfVerts;i++){
	p->verticesList[i]=(list *)malloc(sizeof(list));
	p->verticesList[i]->node=GM->vertices[i];
	p->verticesList[i]->visited=0;
	tmp=p->verticesList[i];
	for(j=0;j<p->numOfVerts;j++){
	    if(GM->edge[i][j]==MAXWEIGHT)continue;
	    p->verticesList[i]->next=(list *)malloc(sizeof(list));
	    p->verticesList[i]=p->verticesList[i]->next;
	    p->verticesList[i]->node=j;
	    p->verticesList[i]->visited=0;
	    p->verticesList[i]->weight=GM->edge[i][j];
	}
	p->verticesList[i]->next=0;
	p->verticesList[i]=tmp;
    }
    return p;
}

graphMatrix *initgraphMatrix(int arr[][MAXVERTICE],char ch, int num)
{
    graphMatrix * p=(graphMatrix *)malloc(sizeof(graphMatrix));
    p->numOfVerts=num;
    int i,j;

    for(i=0;i<num;i++){
	p->vertices[i]=ch+i;
	for(j=0;j<num;j++){
	    p->edge[i][j] = arr[i][j] ;
	}

    }
    return p;
}

void outputGM(graphMatrix *p)
{
    printf("Vertices : ");
    for(int i=0 ;i < p->numOfVerts ;i++)
	printf("%c ", p->vertices[i]);
    puts("");
    puts("Weight table : ");
    for(int i=0;i < p->numOfVerts ;i++)
    {
	for(int j=0;j < p->numOfVerts ; j++)
	    printf("%-6d", p->edge[i][j] );
	puts("");
    }
}

void outputGL(graphList *p)
{
    list *tmp=0;
    printf("Vertices : ");
    for(int i=0 ;i < p->numOfVerts ;i++)
	printf("%c ", p->verticesList[i]->node);
    puts("");
    puts("Weight table : ");
    for(int i=0;i < p->numOfVerts ;i++)
    {
	tmp=p->verticesList[i];
	printf("vertice %c : ", tmp->node);
	while(tmp->next){
	    tmp=tmp->next;
	    printf("%c %-6d", p->verticesList[tmp->node]->node, tmp->weight );
	}
	puts("");
    }
}

int main()
{

    int arr[5][MAXVERTICE]={
	{MAXWEIGHT,25, 18, 30, MAXWEIGHT  },
	{39,MAXWEIGHT, 25, 41, 3},
	{29, 3 ,MAXWEIGHT, 43, 6},
	{3 , 12,MAXWEIGHT, MAXWEIGHT , MAXWEIGHT   },
	{1 , 21,MAXWEIGHT, MAXWEIGHT , MAXWEIGHT  },
    };
    graphMatrix * GM=initgraphMatrix(arr,'A',5);
    graphList * GL=initgraphList(GM);
    outputGM(GM);
    outputGL(GL);
}
