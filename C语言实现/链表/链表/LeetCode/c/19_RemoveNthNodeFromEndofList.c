//
//  19_RemoveNthNodeFromEndofList.c
//  链表
//
//  Created by 58 on 2020/10/12.
//  Copyright © 2020 58. All rights reserved.
//

#include "19_RemoveNthNodeFromEndofList.h"


SingleNode_1* removeNthFromEnd1(SingleNode_1 * head, int n){
        
    //1、遍历求链表长度
    int len=0;
    SingleNode_1 *node=head;
    while (node != NULL) {
        len++;
        node=node->next;
    }
    node=head;
    
    //2、根据len 和 n 遍历
    if (n==len) { // 处理第一个
        head=head->next;
        return head;
    }
    //处理除了第一个以外的
    int i = 0;
    while (node->next != NULL) {
        if (i==len-n-1) {
            node->next=node->next->next;
            break;
        }
        i++;
        node=node->next;
    }
    return head;
}

void remove_nth_from_end_test(){
    
    SingleLink_1 *link=create_single_link_1();
    add_for_single_node_1(5, link);
    add_for_single_node_1(4, link);
    add_for_single_node_1(3, link);
    add_for_single_node_1(2, link);
    add_for_single_node_1(1, link);
    
    SingleNode_1 *head=removeNthFromEnd1(link->first, 1);
    
    link->first=head;
    print_single_link_1(link);
}








