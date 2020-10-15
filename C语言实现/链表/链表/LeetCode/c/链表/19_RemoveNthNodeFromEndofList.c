//
//  19_RemoveNthNodeFromEndofList.c
//  链表
//
//  Created by 58 on 2020/10/12.
//  Copyright © 2020 58. All rights reserved.
//

#include "19_RemoveNthNodeFromEndofList.h"

/**
 给定一个链表，删除链表的倒数第 n 个节点，并且返回链表的头结点。

 示例：

 给定一个链表: 1->2->3->4->5, 和 n = 2.

 当删除了倒数第二个节点后，链表变为 1->2->3->5.
 说明：

 给定的 n 保证是有效的。

 进阶：

 你能尝试使用一趟扫描实现吗？

 链接：https://leetcode-cn.com/problems/remove-nth-node-from-end-of-list


 
 */

// 两次遍历
//1、获取长度
//2、然后根据索引遍历
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

/**
 一次遍历
 
 一次遍历法需要使用两个指针而不是一个指针。
 第一个指针从列表的开头向前移动n+1步，而第二个指针将从列表的开头出发。现在，这两个指针被n个结点分开。
 我们通过同时移动两个指针向前来保持这个恒定的间隔，直到第一个指针到达最后一个结点。
 此时第二个指针将指向从最后一个结点数起的第n个结点。我们重新链接第二个指针所引用的结点的
 next指针指向该结点的下下个结点。

 */
SingleNode_1* removeNthFromEnd2(SingleNode_1 * head, int n){
    SingleNode_1 *node1=head;
    SingleNode_1 *node2=head;
    SingleNode_1 *node3=head; // node3一直是node1前面的一个节点
    int interval=0;
    while (node2 != NULL) {
        node2=node2->next;
        interval++;
        if (interval > n) {
            node3=node1;
            node1=node1->next;
        }
    }
    
    if (node1->next==NULL && node1 == head) {
        //这是处理链表长度等于1的情况。
        head = NULL;
        return head;
    }else if (node1->next == NULL){
        //这是处理链表长度大于1的情况。
        //第一个指针已经走到了null.第二个指针走到了最后一个节点
        //也就是处理n=1的时候
        node3->next=NULL;
        return head;
    }else{
        node1->val=node1->next->val;
        node1->next=node1->next->next;
        return head;
    }
}


void remove_nth_from_end_test(){
    
    SingleLink_1 *link=create_single_link_1();
    add_for_single_node_1(5, link);
//    add_for_single_node_1(4, link);
//    add_for_single_node_1(3, link);
//    add_for_single_node_1(2, link);
//    add_for_single_node_1(1, link);
    
    SingleNode_1 *head=removeNthFromEnd2(link->first, 1);
    
    link->first=head;
    print_single_link_1(link);
}








