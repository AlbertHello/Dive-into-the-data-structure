//
//  main.c
//  LinkList
//
//  Created by 王启正 on 2019/8/12.
//  Copyright © 2019 58. All rights reserved.
//

#include <stdio.h>
#include <stdbool.h>


typedef int Element;
typedef int Status;
static  int size=0;
#define Error 0
#define Success 0
//链表定义
struct Node {
    Element data;
    struct Node *next;
}Node;
typedef struct Node *Link;


//声明
Status init_link(Link *link);
bool boundary_check(int index);
Status node_of_index(int index, Link head, struct Node** node);
void printLink(Link link);


int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello, World!\n");
    
    Link head;//头指针
    Status ret = init_link(&head);
    if (ret!=Success) {
        printf("linklist init error \n");
        return 0;
    }
    insert_element(20,head);
    insert_element(30,head);
    
    insert_element_at_index(40, 1, head);

    printLink(head);
    
    
    
//    int a=10;
//    int *p=&a;
//    int **pp=&p;
//    printf("a的地址:%p\n",&a);
//    printf("p的值  :%p\n",p);
//    printf("p的地址:%p\n",&p);
//    printf("*p的值:%d\n",*p);
//
//    printf("pp的值:%p\n",pp);
//    printf("*pp的值:%p\n",*pp);
//    printf("**p的值:%d\n",**pp);
    
    
    return 0;
}

//1、初始化一个链表
Status init_link(Link *head){
    (*head)=(Link)malloc(sizeof(Node));
    if (head) {
        (*head)->data=0;
        (*head)->next=NULL;
        size=0;
        return Success;
    }else{
        return Error;
    }
}

//2、增加一个元素
int insert_element(Element elem,Link head){
    insert_element_at_index(elem,size, head);
    return Success;
}
bool is_empty(Link head){
    return (head->next == NULL);
}

Status insert_element_at_index(Element elem, int index, Link head){
    if (boundary_check(index)) return Error;
    Link head_node=head->next;
    struct Node * new_node=(struct Node *)malloc(sizeof(Node));
    if (index==0) {
        new_node->data=elem;
        new_node->next=head_node;
        head->next=new_node;
        printf("insert one node at index 0\n");
    }else{
        struct Node *pre_node;
        node_of_index(index-1, head, &pre_node);
        new_node->next=pre_node->next;
        new_node->data=elem;
        pre_node->next=new_node;
        printf("insert one node at index %d\n",index);
    }
    size++;
    return Success;
}

 Status node_of_index(int index, Link head, struct Node** node){
//    if (boundary_check(index)) return struct NULL;
     (*node) = head->next;//此时node表示头结点
     int i=0;
     while ((*node) && i<index) {
         (*node)= (*node)->next;
         i++;
     }
     return Success;
}
bool boundary_check(int index){
    if (index<0 || index>size) {
        printf("index out of bounds \n");
        return true;
    }else{
        return false;
    }
}

//3、删除一个元素
Status delete_element(int index,Element *data,Link head){
    struct Node *pre_node;
    node_of_index(index-1, head, &pre_node);
    Element delete_data=pre_node->next->data;
    pre_node->next=pre_node->next->next;
    *data=delete_data;
    free();
    return Success;
}
//4、修改一个元素
//5、获取链表长度
//6、根据下标index查找元素Element
//7、根据元素Element查找下标index
//8、清空链表
//9、检查是否越界

void printLink(Link link){
    int i=0;
    struct Node *node=link->next;
    while (node) {
        printf("第%d个节点：data=%d\n",i,node->data);
        node=node->next;
        i++;
    }
    printf("size=%d\n",size);
}



