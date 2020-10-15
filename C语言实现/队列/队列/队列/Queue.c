//
//  Queue.c
//  队列
//
//  Created by 58 on 2019/9/21.
//  Copyright © 2019 58. All rights reserved.
//

#include "Queue.h"

static DoubleLink queue=NULL;

void check_queue_link(void){
    if (!queue) {
        queue=create_double_link();
    }
}
int size(void){
    check_queue_link();
    return doubleLinkNode_get_link_length(queue);
}
bool isEmpty(void){
    check_queue_link();
    return doubleLinkNode_is_empty(queue);
}
void enQueue(int ele){
    check_queue_link();
    doubleLinkNode_insert_element(ele, queue);
}
int deQueue(void){
    check_queue_link();
    int data=0;
    doubleLinkNode_delete_element(0, &data, queue);
    return data;
}
int front(void){
    check_queue_link();
    if (queue->first) {
        return queue->first->data;
    }
    return -1;
}
void clear(void){
    check_queue_link();
    doubleLinkNode_clearLink(queue);
    free(queue);
    queue=NULL;
}
void printQueue(void){
    check_queue_link();
    doubleLinkNode_printLink(queue);
}
