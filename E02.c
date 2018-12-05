#include <stdio.h>
#include <malloc.h>
#include <string.h>

typedef struct node{
    char a;
    struct node *left,*right;
}node;

typedef struct qnode{
    node *a;
    struct qnode * next;
}qnode;

typedef struct queue{
    qnode *rear;
    qnode *front;
}queue;

qnode *initqnode(node *a)
{
    qnode *b=(qnode *)malloc(sizeof(qnode));

    b->a=a;
    b->next=0;
    return b;
}
queue *bfQueue(node *n)
{
    queue *q=(queue *)malloc(sizeof(queue));
    int i,j;
    q->front=initqnode(n);
    qnode *p=0;

    i=j=0;
    p=q->rear=q->front;

    while(p){
	if(p->a->left){
	    q->rear->next=initqnode(p->a->left);
	    q->rear=q->rear->next;
	}
	if(p->a->right){
	    q->rear->next=initqnode(p->a->left);
	    q->rear=q->rear->next;
	}
	p=p->next;
    }
    q->rear->next=0;
    q->rear=q->rear->next;

    return q;
}

queue *preOrderQueue(node *n)
{

    int i,j;
    queue *q=(queue *)malloc(sizeof(queue));
    qnode *stack=0,*tmp,*s;

    i=j=0;

    q->rear=q->front=stack=initqnode(n);
    while(stack){
	tmp=stack;
	stack=stack->next;

	if(tmp->a->right){
	    s=initqnode(tmp->a->right);
	    s->next=stack;
	    stack=s;
	}

	if(tmp->a->left){
	    s=initqnode(tmp->a->left);
	    s->next=stack;
	    stack=s;
	}
	q->rear->next=tmp;
	q->rear=q->rear->next;
    }
    q->rear=0;

    return q;
}

queue *inOrderQueue(node *n)
{

    int i,j;
    queue *q=(queue *)malloc(sizeof(queue));
    qnode *stack=0,*left,*right,*parentsStack=0;

    i=j=0;

    parentsStack=stack=initqnode(n);
    while(stack){
	parentsStack->next=stack;
	parentsStack=parentsStack->next;
	stack=stack->next;

	right=0;
	if(parentsStack->a->right){
	    right=initqnode(parentsStack->a->right);
	    right->next=stack;
	    stack=right;
	}

	left=0;
	if(parentsStack->a->left){
	    left=initqnode(stack->a->left);
	    left->next=stack;
	    stack=left;
	    if(!(left->a->left ||left->a->right))
	    {
		//if leftchild hasn't child
		q->rear->next=stack;
		q->rear=q->rear->next;
		stack=stack->next;
		q->rear->next=parentsStack;
		q->rear=q->rear->next;
		parentsStack=parentsStack->next;
		if(right&&!(right->a->left ||right->a->right)) {
		    q->rear->next=stack;
		    q->rear=q->rear->next;
		    stack=stack->next;
		}
	    }
	}
    }

    q->rear=q->rear->next=0;
    return q;
}

queue *postOrderQueue(node *n)
{

    int i,j;
    queue *q=(queue *)malloc(sizeof(queue));
    qnode *stack=0,*s=0,*parentsStack=0;

    i=j=0;

    q->rear=q->front=stack=initqnode(n);
    while(stack){
	parentsStack->next=stack;
	parentsStack=parentsStack->next;
	stack=stack->next;

	if(parentsStack->a->right){
	    s=initqnode(parentsStack->a->right);
	    s->next=stack;
	    stack=s;
	    if(!(parentsStack->a->right->left ||parentsStack->a->right->right))
	    {
		//if rightchild hasn't child
		q->rear->next=initqnode(stack->a->right);
		q->rear=q->rear->next;
	    }
	}

	if(parentsStack->a->left){
	    s=initqnode(stack->a->left);
	    s->next=stack;
	    stack=s;
	    if(!(parentsStack->a->left->left ||parentsStack->a->left->right))
	    {
		//if leftchild hasn't child
		q->rear->next=initqnode(stack->a->right);
		q->rear=q->rear->next;

		q->rear->next=parentsStack;
		q->rear=q->rear->next;
		parentsStack=parentsStack->next;
	    }
	}
    }

    q->rear=q->rear->next=0;
    return q;
}

int treedepth(node *root,int i)
{
    static int depth=0;
    if(depth < i) depth=i;

    if(root->left) treedepth(root->left,i+1);
    if(root->right)treedepth(root->right,i+1);

    return depth;
}

int treeLeaves(node *tree)
{
    int cnt;
    queue *q=bfQueue(tree);
    qnode *qn=q->front;

    for(cnt=0;qn;qn=qn->next)
    {
	if(!(qn->a->left||qn->a->right))cnt++;
    }

    return cnt;
}

int notTreeLeaves(node *tree)
{
    int cnt;
    queue *q=bfQueue(tree);
    qnode *qn=q->front;

    for(cnt=0;qn;qn=qn->next)
    {
	if(qn->a->left||qn->a->right)cnt++;
    }

    return cnt;
}

node * create_bt(char *str)//构造二叉树，返回指向根节点的指针
{
    if (strlen(str)==0) return NULL;
    else
    {
	node *p=(node *)malloc(sizeof(node));
	int subStrLen=0;
	p->a=str[0];
	if((int)strlen(str)==1) return p;
	int pair=0,i=0,j=0;
	for(;i<(int)strlen(str);i++)
	{
	    if (str[i]=='(') pair++;
	    if (str[i]==')') pair--;
	    if ((str[i]==',')&&(pair==1)) break;
	}
	if(1<=i-2)
	{
	    subStrLen=i-2;

	    char *strleft=(char *)malloc((subStrLen+1)*sizeof(char));
	    for(j=0;j<subStrLen;j++)
		strleft[j]=str[j+2];
	    strleft[subStrLen]='\0';

	    p->left=create_bt(strleft);
	}
	if(1<=(int)strlen(str)-2-i)
	{
	    subStrLen=strlen(str)-2-i;

	    char *strright=(char *)malloc((subStrLen+1)*sizeof(char));
	    for(j=0;j<subStrLen;j++)
		strright[j]=str[i+j+1];
	    strright[subStrLen]='\0';

	    p->right=create_bt(strright);
	}
	return p;
    }
}
void print(queue *q)
{
    qnode *qn=q->front;
    while(qn){
	printf("%c ",qn->a->a);
	qn=qn->next;
    }
    puts("");

}

int main()
{
    char str[]="A(B(D,E(G,)),C(F(G,H),I))";
    node *tree=create_bt(str);

    printf("Tree : %s\n",str);
    puts("PreOrder Traversal:");
    print(preOrderQueue(tree));
    puts("InOrder Traversal:");
    print(inOrderQueue(tree));
    puts("PostOrder Traversal:");
    print(postOrderQueue(tree));
    puts("Breadth First:");
    print(bfQueue(tree));
    printf("Depth : %d",treedepth(tree,0));
    printf("treeLeaves : %d",treedepth(tree,0));
    printf("node except treeLeaves : %d",treedepth(tree,0));

    return 0;
}
