//
//  61_RotateList.c
//  链表
//
//  Created by 58 on 2020/10/13.
//  Copyright © 2020 58. All rights reserved.
//

#include "61_RotateList.h"


/**
 给定一个链表，旋转链表，将链表每个节点向右移动 k 个位置，其中 k 是非负数。

 示例 1:

 输入: 1->2->3->4->5->NULL, k = 2
 输出: 4->5->1->2->3->NULL
 解释:
 向右旋转 1 步: 5->1->2->3->4->NULL
 向右旋转 2 步: 4->5->1->2->3->NULL
 
 示例 2:

 输入: 0->1->2->NULL, k = 4
 输出: 2->0->1->NULL
 解释:
 向右旋转 1 步: 2->0->1->NULL
 向右旋转 2 步: 1->2->0->NULL
 向右旋转 3 步: 0->1->2->NULL
 向右旋转 4 步: 2->0->1->NULL

 链接：https://leetcode-cn.com/problems/rotate-list
 
 */
//思路就是先把链表形成环形链表，计算出长度。
//再计算指针移动的步数。要知道移动的等于长度时正好这一圈白走。
//移动的步数大于或小于长度时求余，情况是一样的。
//最后就是定下来到底走几步：
//len - k % len - 1 的意思是走到将要当做新头结点的前一个节点处。
//然后 head=ptr->next;设置新头结点，
//ptr->next=NULL;自己就设置为尾节点。
SingleNode_1* rotateRight(SingleNode_1* head, int k){
    if (head == NULL) return head;
    SingleNode_1 *ptr = head;
    //链表的长度
    int len = 1;
    //统计链表的长度，顺便找到链表的尾结点
    while (ptr->next != NULL) {
        len++;
        ptr = ptr->next;
    }
    
    //首尾相连，构成环
    ptr->next = head;
    //归位
    ptr=head;
    //移动的步数
    //当k大于链表长度时，需要求余，因为k=len时，相当于没有转。
    //只计算不到len或超过len的次数
    int step = len - k % len - 1;
    int i=0;
    while (i<step) {
        i++;
        ptr = ptr->next;
    }
    //下一个就是head
    head=ptr->next;
    //断开环。ptr就是尾巴
    ptr->next=NULL;
    
    return head;
}


void rotate_right_test(){
    
    SingleLink_1 *link=create_single_link_1();
    add_for_single_node_1(5, link);
    add_for_single_node_1(4, link);
    add_for_single_node_1(3, link);
    add_for_single_node_1(2, link);
    add_for_single_node_1(1, link);
    
    SingleNode_1 *head=rotateRight(link->first, 6);
    
    link->first=head;
    print_single_link_1(link);
}



