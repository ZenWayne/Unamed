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

typedef struct {
    char head;
    char tail;
    int weight;
}MinSpanTree;
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
/*
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
*/
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

void oplist(list *l,list *tail)
{
    list *tmp=l;
    while(tmp!=tail){
	printf("%d ",tmp->weight);
	tmp=tmp->next;
    }
    puts("");

}

void qSort(list *head, list *tail)
{
    if(head->next==tail)return;

    list *i=head, *j=halfList(head,tail);
    list *tmp=0;
    list *key=j;
    static list *head0=0;

    if(head0==0)head0=head;

    while(i->next!=key||j->next!=tail){
	while(j->next!=tail&&j->next->weight>=key->weight){
	    j=j->next;
	}
	if(j->next!=tail){
	    tmp=j->next;
	    j->next=j->next->next;
	    tmp->next=i->next;
	    i->next=tmp;
	    i=i->next;
	}
	while(i->next!=key&&i->next->weight<=key->weight){
	    i=i->next;
	}
	if(i->next!=key){
	    tmp=i->next;
	    i->next=i->next->next;
	    tmp->next=j->next;
	    j->next=tmp;
	    j=j->next;
	}
    }

    qSort(head,key);
    qSort(key,tail);
}

list *initListarr(int *a,int num){
    list *p=(list *)malloc(sizeof(list));

    list *head=p;
    for(int i=0;i<num;i++)
    {
	p=p->next=(list *)malloc(sizeof(list));
	p->weight=a[i];
    }
    p->next=0;
    p=head->next;
    free(head);
    oplist(p,0);
    return p;
}
list *combine(list *a,list *b)
{
    list *c=(list *)malloc(sizeof(list));

    list *head=c;
    if(a)
    {
	while(a)
	{
	    *c=*a;
	    if(a->next)c->next=(list *)malloc(sizeof(list));
	    else c->next=0;
	    a=a->next;
	    c=c->next;
	}
    }
    while(b)
    {
	*c=*b;
	if(b->next)c->next=(list *)malloc(sizeof(list));
	else c->next=0;	
	b=b->next;
	c=c->next;
    }
    return head;
}
void destory(list *a)
{
    list *tmp;
    while(a){
	tmp=a;
	a=a->next;
	free(tmp);
    }
}

graphList *deleteVertices(graphList *GL, char ch)
{
    list *p=0;
    char base=GL->verticesList[0]->node;
    for(int i=0;i< GL->numOfVerts;i++)
    {
	p=GL->verticesList[i];
	while(p->next){
	    if(p->node)
	}
    }
}
graphList *prime(graphList *GL,int index)
{
    graphList *GL0=(graphList *)malloc(sizeof(graphList));
    graphList *result=(graphList *)malloc(sizeof(graphList));
    list * Seqlist[GL->numOfVerts],*tmp;
    int visitedNum[GL->numOfVerts];
    int notExist,visitedNumIndex;
    char base=GL->verticesList[0]->node;

    result->numOfVerts=GL0->numOfVerts=GL->numOfVerts;
    for(int i=0;i<GL->numOfVerts;i++)
    {
	GL0->verticesList[i]=combine(0,GL->verticesList[i]);
	GL0->verticesList[i]->visited=0;
	Seqlist[i]=0;
    }

    GL0->verticesList[index]->visited=1;
    qSort(GL0->verticesList[index],0);
    Seqlist[index]=GL0->verticesList[index];

    visitedNumIndex=0;
    visitedNum[visitedNumIndex++]=index;
    int i,j;
    for(i=index,j=0; i< GL->numOfVerts+1 ; i++)
    {
	if(i >= GL->numOfVerts ) {
	    j=Seqlist[index]->next->node;
	    Seqlist[index]=Seqlist[index]->next;
	    if(GL0->verticesList[j]->visited==0)
	    {
		GL0->verticesList[j]->visited=1;
		qSort(GL0->verticesList[j],0);
		Seqlist[j]=GL0->verticesList[j];
	    }
	    visitedNum[visitedNumIndex++]=j;
	    if(visitedNumIndex>=GL->numOfVerts)
		break;
	    else { i=-1; continue; }
	}
	if(Seqlist[i]==0||Seqlist[i]->next==0)continue;
	else {
	    for(j=0,notExist=1;j<visitedNumIndex;j++)
	    {
		if(visitedNum[j]==Seqlist[i]->next->node){
		    tmp=Seqlist[i]->next;
		    Seqlist[i]->next=Seqlist[i]->next->next;
		    free(tmp);
		    notExist=0;
		    break;
		}
	    }
	    if(notExist)index=Seqlist[i]->next->weight<Seqlist[index]->next->weight?i:index;
	}
    }
    outputGL(GL0);
    for(i=0; i <GL0->numOfVerts ;i++)
    {
	oplist(Seqlist[i],0);
    }

    return GL0;
}

MinSpanTree getFromGM(graphMatrix GM, int i, int j)
{
    MinSpanTree a;

    a.head=i;
    a.tail=j;
    a.weight=GM->edge[i][j];

    return a;
}
char Prim(graphMatrix *GM, graphList *MST)
{
    int n = GM->visitedNum, minWeight;
    int *lowCost = (int *)malloc(sizeof(int)*n);
    int i, j, k;
    for(i=1;i<n;i++)
	lowCost[i]=GM->edge[0][i];

    MST[0]=getFromGM(GM,0,0);
    lowCost[0]=-1;
    for(i= 1; i< n; i++)
    {
	minWeight=MAXWEIGHT;
	for(j=1;j<n;j++)
	{
	    if(lowCost[j]<minWeight && lowCost[j]>0)
	    {
		minWeight=lowCost[j];
		k=j;
	    }
	}
	MST[i]=getFromGM(GM,k,0);
	lowCost[k]=-1;
	for(j=1;j<n;j++)
	{
	    if(GM.edge[k][j] <lowCost[j])
		lowCost[j]=GM.edge[k][j];
	}
    }

}
int main()
{
    //graphList *GL=initgraphList( 'A' , 5  );
    //graphMatrix * GM=initgraphMatrix( 'A' , 10  );
    int arr[5][MAXVERTICE]={
	{MAXWEIGHT,25, 18, 30, MAXWEIGHT  },
	{39,MAXWEIGHT, 25, 41, 3},
	{29, 3 ,MAXWEIGHT, 43, 6},
	{3 , 12,MAXWEIGHT, MAXWEIGHT , MAXWEIGHT   },
	{1 , 21,MAXWEIGHT, MAXWEIGHT , MAXWEIGHT  },
    };
    graphMatrix * GM=initgraphMatrix(arr,'A',5);

    outputGM(GM);
    graphList *GL=initgraphList(GM);
    outputGL(GL);

    printf("dfs : %c ", GL->verticesList[0]->node);
    GLdfs(GL, GL->verticesList[0]);
    puts("");

    GLbfs(GL);

    outputGL(prime(GL,0));
    return 0;
}

