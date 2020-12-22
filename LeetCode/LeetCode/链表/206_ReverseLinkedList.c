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
SingleNode_1 *reverseList_C1(SingleNode_1* head){
    
    if (head == NULL || head->next == NULL){
        return head; // 当开始返回时，说明传进来的head=1
    }
    //这个意思是 把2->3->4->5->NULL反转成5->4->3->2->null
    SingleNode_1 *new_head=reverseList_C1(head->next);
    //此时1->next=2, 2->null,
    //这句代码就是让2指向1
    head->next->next=head;
    //这句代码就是让1->next=null,到此就反转完了
    head->next=NULL;
    
    return new_head;
}

// 迭代
/**
 这是反转[a, null)的链表
 那么「反转 a 到 b 之间的结点」，你会不会？只需要把 cur_node != NULL 换成cur_node != b就行了
 这就完成了反转链表中部分链表
 */
SingleNode_1* reverseList_C2(SingleNode_1* head){
    if (head == NULL || head->next == NULL){
        return head;
    }
    //head=1,new_head = null
    SingleNode_1 *pre_node=NULL;
    SingleNode_1 *cur_node=head;
    SingleNode_1 *next_node=NULL;
    while(cur_node != NULL){
        //tmp指向的一直是head的下一个，比如此时tmp=2
        next_node=cur_node->next;
        //1的next=null,连起来则是：head=1->null
        //2的next=new,连起来则是：head=2->new=1->null，也就是head=2->1->null
        cur_node->next=pre_node;
        //new=head=1，则连起来则是new=1->null
        //new=head=2，则连起来则是new=2->1->null
        pre_node=cur_node;
        //head移到下一个2.
        //head移到下一个3.
        cur_node=next_node;
    }
    return pre_node;
}


/** 反转区间 [a, b) 的元素，注意是左闭右开 */
SingleNode_1* reverseListA_B(SingleNode_1* a, SingleNode_1* b){
    SingleNode_1 *pre_node=NULL;
    SingleNode_1 *cur_node=a;
    SingleNode_1 *next_node=NULL;
    while(cur_node != b){
        next_node=cur_node->next;
        cur_node->next=pre_node;
        pre_node=cur_node;
        cur_node=next_node;
    }
    return pre_node;
}
//「K 个一组反转链表」
SingleNode_1 * reverseKGroup(SingleNode_1 * head, int k) {
    if (head == NULL) return NULL;
    // 区间 [a, b) 包含 k 个待反转元素，那么[a, b)就是一组
    SingleNode_1 *a=NULL, *b=NULL;
    a = b = head;
    for (int i = 0; i < k; i++) {
        // 不足 k 个，不需要反转，base case
        if (b == NULL) return head;
        b = b->next;
    }
    // 反转前 k 个元素
    SingleNode_1 *newHead = reverseListA_B(a, b);
    // 递归反转后续链表并连接起来
    a->next = reverseKGroup(b, k);
    return newHead;
}


