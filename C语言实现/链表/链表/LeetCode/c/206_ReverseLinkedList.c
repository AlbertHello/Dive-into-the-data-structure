//
//  206_ReverseLinkedList.c
//  链表
//
//  Created by 58 on 2020/10/10.
//  Copyright © 2020 58. All rights reserved.
//

#include "206_ReverseLinkedList.h"

/**
 反转一个单链表。 。
 https://leetcode-cn.com/problems/reverse-linked-list/
 示例:

 输入: 1->2->3->4->5->NULL
 输出: 5->4->3->2->1->NULL
 
 */

// 递归
SingleLink *reverseList_C1(SingleLink* head){
    
    if (head == NULL || head->next == NULL){
        return head; // 当开始返回时，说明传进来的head=1
    }
    // 返回的new_head = 1，说明调用reverseList_C1传进去的是1，那么head=2
    SingleLink *new_head=reverseList_C1(head->next);
    
    // 此时head是2，则head->next->next=head 就是2->next=1,1->next=2
    head->next->next=head;
    //2->next=null,
    head->next=NULL;
    
    //因为此时new_head=1,所以new=1,new->1->next=2,2->next=null。
    //即new->1->2->null，开始倒转了。。以此类推
    return new_head;
}

// 迭代
SingleLink* reverseList_C2(SingleLink* head){
    if (head == NULL || head->next == NULL){
        return head;
    }
    //head=1,new_head = null
    SingleLink *new_head=NULL;
    while(head != NULL){
        //tmp指向的一直是head的下一个，比如此时tmp=2
        SingleLink *tmp_node=head->next;
        //1的next=null,连起来则是：head=1->null
        //2的next=new,连起来则是：head=2->new=1->null，也就是head=2->1->null
        head->next=new_head;
        //new=head=1，则连起来则是new=1->null
        //new=head=2，则连起来则是new=2->1->null
        new_head=head;
        //head移到下一个2.
        //head移到下一个3.
        head=tmp_node;
    }
    return new_head;
}
