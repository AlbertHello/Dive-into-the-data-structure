//
//  DoubleEndedQueue.c
//  队列
//
//  Created by 58 on 2020/10/15.
//  Copyright © 2020 58. All rights reserved.
//

#include "DoubleEndedQueue.h"

static DoubleLink dq_link=NULL;


void check_dq_link(void){
    if (!dq_link) {
        dq_link=create_double_link();
    }
}
int doubleEndedQueue_size(void){
    check_dq_link();
    return doubleLinkNode_get_link_length(dq_link);
}
bool doubleEndedQueue_isEmpty(void){
    check_dq_link();
    return doubleLinkNode_is_empty(dq_link);
}
void doubleEndedQueue_clear(void){
    check_dq_link();
    doubleLinkNode_clearLink(dq_link);
    if (dq_link) {
        free(dq_link);
        dq_link=NULL;
    }
}
void doubleEndedQueue_enQueueRear(int element){
    if (!dq_link) {
        dq_link=create_double_link();
    }
    //链表尾部追加
    doubleLinkNode_insert_element(element, dq_link);
}
int doubleEndedQueue_deQueueFront(void){
    DoubleLinkNode node=dq_link->last;///获取链表头部的节点
    if (node) {
        int data=0;
        doubleLinkNode_delete_element(0, &data, dq_link);
        return node->data;
    }
    return -1;
}
void doubleEndedQueue_enQueueFront(int element){
    check_dq_link();
    //链表尾部追加
    doubleLinkNode_insert_element_at_index(element, 0, dq_link);
}
int  doubleEndedQueue_deQueueRear(void){
    check_dq_link();
    DoubleLinkNode node= dq_link->last; //获取链表尾部的节点
    if (node) {
        int data=0;
        doubleLinkNode_delete_element(doubleEndedQueue_size()-1, &data, dq_link);
        return node->data;
    }
    return -1;
}
int doubleEndedQueue_front(void){
    check_dq_link();
    DoubleLinkNode node=dq_link->first;//获取链表头部的节点
    if (node) {
        return node->data;
    }
    return -1;
}
int doubleEndedQueue_rear(void){
    check_dq_link();
    DoubleLinkNode node=dq_link->last;//获取链表尾部的节点
    if (node) {
        return node->data;
    }
    return -1;
}
void doubleEndedQueue_print(void){
    check_dq_link();
    doubleLinkNode_printLink(dq_link);
}

