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

list *initList()
{
    list *a=(list*)malloc(sizeof(list));
    a->next=0;
    return a;

}
int length(list *a)
{
    int i=0;	
    list *p=a;
    if(a->next){
	do{
	    p=p->next;
	    i++;

	}while(p!=a);

    }
    return i;

}

graphMatrix *initgraphMatrix(char ch,int num){
    graphMatrix * p=(graphMatrix *)malloc(sizeof(graphMatrix));
    p->numOfVerts=num;
    int i,j;
    time_t t;

    srand((unsigned)time(&t));
    for(i=0;i<num;i++){
	p->vertices[i]=ch+i;
	for(j=0;j<num;j++){
	    if(rand()%5<=3) p->edge[i][j]=rand()%50;
	    else p->edge[i][j]=MAXWEIGHT;

	}

    }
    return p;

}

graphList *initgraphList(char ch,int num){
    graphList * p=(graphList *)malloc(sizeof(graphList));
    list *tmp=0;
    p->numOfVerts=num;
    int i,j;
    time_t t;

    srand((unsigned)time(&t));
    for(i=0;i<num;i++){
	p->verticesList[i]=(list *)malloc(sizeof(list));
	p->verticesList[i]->node=ch+i;
	p->verticesList[i]->visited=0;
	tmp=p->verticesList[i];
	for(j=0;j<num;j++){
	    if(j==i)continue;
	    if(rand()%5<=3){
		p->verticesList[i]->next=(list *)malloc(sizeof(list));
		p->verticesList[i]=p->verticesList[i]->next;
		p->verticesList[i]->node=j;
		p->verticesList[i]->visited=0;
		p->verticesList[i]->weight=rand()%50;

	    } 

	}
	p->verticesList[i]->next=0;
	p->verticesList[i]=tmp;

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
	{
	    printf("%-6d", p->edge[i][j] );

	}
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

void GLdfs(graphList *GL, list *vertices ){
    if(vertices->visited)return;
    else{
	char base=GL->verticesList[0]->node;
	list *p=vertices;
	vertices->visited=1;
	while(p->next){
	    p=p->next;
	    if(GL->verticesList[p->node]->visited)continue;
	    printf("%c ", p->node+base);
	    GLdfs(GL,GL->verticesList[p->node]);

	}

    }

}

void GLbfs(graphList *GL)
{
    list * Seqlist[GL->numOfVerts];
    char base = GL->verticesList[0]->node;
    int i,j=0;

    for( i=0; i < GL->numOfVerts ; i++ )
    {
	Seqlist[i]=GL->verticesList[i]->next;
	GL->verticesList[i]->visited=0;

    }


    printf("bfs : ");
    for( i=0; j < GL->numOfVerts ;  ){
	if(Seqlist[i]){

	    if(!GL->verticesList[Seqlist[i]->node]->visited){
		printf("%c ", Seqlist[i]->node+base);
		GL->verticesList[Seqlist[i]->node]->visited=1;

	    }
	    Seqlist[i]=Seqlist[i]->next;

	}else j++;

	if(i == GL->numOfVerts-1 ){
	    i=0;
	    if(j < GL->numOfVerts )
		j=0;

	}else i++;

    }
    puts("");

}

list *halfList(list *head,list *tail)
{
    list *h=head,*t=tail;
    int i=0,j=0;
    while(h!=t){
	h=h->next;
	i++;

    }
    h=head;
    while(h!=t&&j!=i/2){
	h=h->next;
	j++;

    }
    return h;

}

void oplist(list *l)
{
    list *tmp=l;
    while(tmp->next){
	printf("%d ",tmp->weight);
	tmp=tmp->next;

    }
    puts("");

}
void sort(list *head, list *tail)
{
    if(head==tail)return;

    list *i=head, *j=halfList(head,tail);
    list *tmp=0;
    list *key=j;

    while(i!=key||j!=tail){
	while(j->weight>=key->weight&&j!=tail){
	    j=j->next;

	}
	tmp=j->next;
	*i=*j;
	i->next=tmp;
	while(i->weight<=key->weight&&i!=key){
	    i=i->next;

	}
	tmp=j->next;
	*j=*i;
	j->next=tmp;
	oplist(head);

    }

    tmp=i->next;
    *i=*key;
    i->next=tmp;

    //sort(head,halfList(head,half));
    //    //sort(half,halfList(half,NULL));
    //
}

int main()
{
    graphMatrix * GM=initgraphMatrix( 'A' , 10  );
    graphList *GL=initgraphList( 'A' , 10  );

    outputGM(GM);
    outputGL(GL);

    printf("dfs : %c ", GL->verticesList[0]->node);
    GLdfs(GL, GL->verticesList[0]);
    puts("");

    GLbfs(GL);

    list *h=GL->verticesList[0]->next;
    sort(h,halfList(h,NULL));

    return 0;

}

