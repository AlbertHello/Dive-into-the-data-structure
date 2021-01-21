//
//  206_ReverseLinkedList.c
//  链表
//
//  Created by 58 on 2020/10/10.
//  Copyright © 2020 58. All rights reserved.
//

#include "206_ReverseLinkedList.h"

/**
 206 反转一个单链表。 。 $$$$$
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
    // 这句代码意思是 把2->3->4->5->NULL反转成5->4->3->2->null
    // 不要用脑袋去想压栈的详细过程，因为脑袋压不了几次栈
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


/**
 将链表的前 n 个节点反转（n <= 链表长度）
 反转以 head 为起点的 n 个节点，返回新的头结点
 
 1 base case 变为n == 1，反转一个元素，就是它本身，同时要记录后驱节点。
 2 刚才我们直接把head.next设置为 null，因为整个链表反转后原来的head变成了整个链表的最后一个节点。但现在head节点在递归反转之后不一定是最后一个节点了，所以要记录后驱successor（第 n + 1 个节点），反转之后将head连接上。
 */
SingleNode_1 *successor = NULL; // 后驱节点
SingleNode_1 *reverseN(SingleNode_1*head, int n) {
    if (n == 1) {
        // 记录第 n + 1 个节点
        successor = head->next;
        return head;
    }
    // 以 head.next 为起点，需要反转前 n - 1 个节点
    SingleNode_1 *last = reverseN(head->next, n - 1);

    head->next->next = head;
    // 让反转之后的 head 节点和后面的节点连起来
    head->next = successor;
    
    return last;
}
/**
 给一个索引区间[m,n]（索引从 1 开始），仅仅反转区间中的链表元素.
 首先，如果m == 1，就相当于反转链表开头的n个元素嘛，也就是我们刚才实现的功能reverseN()
 如果m != 1怎么办？如果我们把head的索引视为 1，那么我们是想从第m个元素开始反转对吧；如果把head.next的索引视为 1 呢？那么相对于head.next，反转的区间应该是从第m - 1个元素开始的；那么对于head.next.next呢……
 
 递归操作链表并不高效。和迭代解法相比，虽然时间复杂度都是 O(N)，但是迭代解法的空间复杂度是 O(1)，而递归解法需要堆栈，空间复杂度是 O(N)。
 
 */
SingleNode_1* reverseBetween(SingleNode_1* head, int m, int n) {
    // base case
    if (m == 1) {
        return reverseN(head, n);
    }
    // 前进到反转的起点触发 base case
    head->next = reverseBetween(head->next, m - 1, n - 1);
    return head;
}
