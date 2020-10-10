//
//  206_ReverseLinkedList.c
//  链表
//
//  Created by 58 on 2020/10/10.
//  Copyright © 2020 58. All rights reserved.
//

#include "206_ReverseLinkedList.h"

struct ListNode_C* reverseList_C2(struct ListNode_C* head){
    if (head == NULL || head->next == NULL){
        return head;
    }
    struct ListNode_C *new_head=head;
    while(head != NULL){
        struct ListNode_C *tmp_node=head->next;
        head->next=new_head;
        new_head=head;
        head=tmp_node;
    }
    return new_head;
}
