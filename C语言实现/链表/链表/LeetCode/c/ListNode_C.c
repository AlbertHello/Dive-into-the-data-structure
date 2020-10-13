//
//  ListNode_C.c
//  链表
//
//  Created by 58 on 2020/10/11.
//  Copyright © 2020 58. All rights reserved.
//

#include "ListNode_C.h"



SingleNode_1 *node_of_index_for_single_node_1(int index,SingleLink_1 *link);

SingleLink_1 *create_single_link_1(void){
    SingleLink_1 *link=(SingleLink_1*)malloc(sizeof(SingleLink_1));
    link->size=0;
    link->first=NULL;
    return link;
}

void add_for_single_node_1(int val, SingleLink_1 *link){
    SingleNode_1 *node=(SingleNode_1*)malloc(sizeof(SingleNode_1));
    node->val=val;
    node->next=NULL;
    if (link->size == 0) {
        link->first=node;
    }else{
        SingleNode_1 *pre_node=node_of_index_for_single_node_1(link->size-1, link);
        pre_node->next=node;
    }
    link->size++;
}
SingleNode_1 *node_of_index_for_single_node_1(int index,SingleLink_1 *link){
    SingleNode_1 *node = link->first;
    int i=0;
    while (node && i<index) {
        node = node->next;//依次后移
        i++;
    }
    return node;
}
//打印链表
void print_single_link_1(SingleLink_1 *link){
    printf("单链表打印：size: %d, [",link->size);
    char string[100]={0};
    char temp[10]={0};
    SingleNode_1 *node=link->first;
    while (node) {
        sprintf(temp, "%d->" ,node->val);
        strcat(string,temp);
        node=node->next;
    }
    strcat(string,"null");
    printf("%s",string);
    printf("]\n");
}
