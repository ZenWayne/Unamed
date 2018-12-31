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

void oplist(list *l,list *tail)
{
    list *tmp=l;
    while(tmp->next!=tail){
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
    printf("%d :",key->weight);
    oplist(head0,key->next);
    printf("%d :",key->weight);
    oplist(key,tail->next);
}

list *initListarr(int *a,int num){
    list *p=(list *)malloc(sizeof(list));

    list *head=p;
    for(int i=0;i<num;i++)
    {
	p=p->next=(list *)malloc(sizeof(list));
	p->weight=a[i];
    }
    free(p->next);
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

graphList *prime(graphList *GL,int index)
{
    graphList *GL0=(graphList *)malloc(sizeof(graphList));
    list * Seqlist[GL->numOfVerts];

    for(int i=0;i<GL->numOfVerts;i++)
    {
	GL0->verticesList[i]=combine(0,GL->verticesList[i]);
	qSort(GL0->verticesList[i],0);
	GL0->verticesList[i]->visited=0;
	Seqlist[i]=GL0->verticesList[i]->next;
    }

    GL0->verticesList[index]->visited=1;
    qSort(GL0->verticesList[index],0);
    for(int i=index,j=0; i< GL->numOfVerts+1 ; i++)
    {
	if(i >= GL->numOfVerts ) {
	    Seqlist[index]=Seqlist[index]->next;
	    j=Seqlist[index]->node;
	    if(GL0->verticesList[j]->visited==0)
	    {
		GL0->verticesList[j]->visited=1;
		qSort(GL0->verticesList[j],0);
	    }
	    if((++j)>=GL->numOfVerts-1)
		break;
	    else i=-1;
	}
	if(GL0->verticesList[i]->visited==0)continue;
	else {
	    index=Seqlist[i]->weight<Seqlist[index]->weight?i:index;
	}
	/*
	Seqlist[i]=Sdfdfqlist[i]->next;
	qSort(Seqlist[i],0);
	i=Seqlist[i]->next->node;
	Seqlist[i]->visited=1;
	*/
    }

    return GL0;
}

int main()
{
    graphList *GL=initgraphList( 'A' , 10  );
    /*graphMatrix * GM=initgraphMatrix( 'A' , 10  );

      outputGM(GM);
      outputGL(GL);

      printf("dfs : %c ", GL->verticesList[0]->node);
      GLdfs(GL, GL->verticesList[0]);
      puts("");

      GLbfs(GL);

    outputGL(GL);
    list *a=GL->verticesList[0]->next;
    list *b=GL->verticesList[1]->next;
    GL->verticesList[0]->next=combine(a,b);
    outputGL(GL);
    GL->verticesList[0]->next=a;
    outputGL(GL);
*/
//    outputGL(prime(GL,0));
    int arr[8]={0,30,39,23,17,43,28,34};
    puts(".......");
    qSort(initListarr(arr,8),0);
    puts("############");
    return 0;
}

