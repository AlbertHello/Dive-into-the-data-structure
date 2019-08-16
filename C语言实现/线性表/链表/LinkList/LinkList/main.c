//
//  main.c
//  LinkList
//
//  Created by 王启正 on 2019/8/12.
//  Copyright © 2019 58. All rights reserved.
//

#include <stdio.h>
#include <stdbool.h>

//链表定义
struct Node {
    int data;
    struct Node *next;
}Node;
typedef struct Node *Link;
typedef int Element;
typedef int Status;
static  int size=0;
#define Error 0
#define Success 0

//声明
Status init_link(Link *link);



int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello, World!\n");
    
    Link link;
    Status ret = init_link(&link);
    if (ret!=Success) {
        printf("linklist init error \n");
        return 0;
    }
    
    
    return 0;
}

//1、初始化一个链表
Status init_link(Link *link){
    (*link)=(Link)malloc(sizeof(Node));
    if (link) {
        (*link)->data=0;
        (*link)->next=NULL;
        size=0;
        return Success;
    }else{
        return Error;
    }
}

//2、增加一个元素
int insert_element(Element elem,Link link){
    Link new_node=(Link)malloc(sizeof(Node));
    if (new_node) {
        new_node->data=elem;
        new_node->next=NULL;
        link->next=new_node;
        return 1;
    }else{
        return 0;
    }
}
bool is_empty(Link link){
    return (link->next == NULL);
}
Status insert_element_at_index(Element elem, int index, Link link){
    int i=0;
    link temp;
    while (link->next != NULL) {
        
    }
    return Success;
}
Node node_of_index(int index, Link link){
    if (boundary_check(index)) return NULL;
    int i=0;
    link temp;
    while (link->next != NULL) {
        
    }
    return null;
}
bool boundary_check(int index){
    if (index<0 || index>size) {
        printf("index out of bounds \n");
        return false;
    }else{
        return true;
    }
}

//3、删除一个元素
//4、修改一个元素
//5、获取链表长度
//6、根据下标index查找元素Element
//7、根据元素Element查找下标index
//8、清空链表
//9、检查是否越界




