//
//  Queue.c
//  队列
//
//  Created by 58 on 2019/9/21.
//  Copyright © 2019 58. All rights reserved.
//

#include "Queue.h"

static DoubleLink queue=NULL;

void initDoubleLink(){
    if (!queue) {
        if (doubleLinkNode_init_link(&queue) == Error) {
            return;
        }
        queue->data=-1;
        queue->next=NULL;
        queue->pre=NULL;
    }
}
int size(void){
    if (queue == NULL) return -1;
    return doubleLinkNode_get_link_length();
}
bool isEmpty(void){
    if (!queue) {
        initDoubleLink();
    }
    return doubleLinkNode_is_empty(queue);
}
void enQueue(int ele){
    if (!queue) {
        initDoubleLink();
    }
    doubleLinkNode_insert_element(ele, queue);
}
int deQueue(void){
    if (!queue) {
        initDoubleLink();
    }
    int data=0;
    doubleLinkNode_delete_element(0, &data, queue);
    return data;
}
int front(void){
    if (!queue) {
        initDoubleLink();
    }
    DoubleLink node=NULL;
    doubleLinkNode_node_of_index(0, queue, &node);
    return node->data;
}
void clear(void){
    if (!queue) {
        initDoubleLink();
    }
    doubleLinkNode_clearLink(queue);
}
void printQueue(void){
    if (!queue) {
        initDoubleLink();
    }
    doubleLinkNode_printLink(queue);
}
