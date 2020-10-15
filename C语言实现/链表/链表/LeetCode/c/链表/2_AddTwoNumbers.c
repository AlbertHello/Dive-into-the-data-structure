//
//  2_AddTwoNumbers.c
//  链表
//
//  Created by 58 on 2020/10/12.
//  Copyright © 2020 58. All rights reserved.
//

#include "2_AddTwoNumbers.h"

/**
 给出两个 非空 的链表用来表示两个非负的整数。其中，它们各自的位数是按照 逆序 的方式存储的，并且它们的每个节点只能存储一位数字
 如果，我们将这两个数相加起来，则会返回一个新的链表来表示它们的和。
 您可以假设除了数字 0 之外，这两个数都不会以 0 开头。
 
 https://leetcode-cn.com/problems/add-two-numbers/
 示例：

 输入：(2 -> 4 -> 3) + (5 -> 6 -> 4)
 输出：7 -> 0 -> 8
 原因：342 + 465 = 807

 
 */


//将长度较短的链表在末尾补零使得两个连表长度相等，再一个一个元素对其相加（考虑进位）
//获取两个链表所对应的长度
//在较短的链表末尾补零
//对齐相加考虑进位
SingleNode_1 *addTwoNumbers1(SingleNode_1* l1, SingleNode_1* l2){
    
//    1、获取链表长度
    int len1=0;
    int len2=0;
    SingleNode_1 *link1=l1;
    SingleNode_1 *link2=l2;
    while (link1->next != NULL) {
        len1++;
        link1=link1->next;
    }
    len1++;
    while (link2->next != NULL) {
        len2++;
        link2=link2->next;
    }
    len2++;
    
//    2、统一长度，短的补零
    if (len1<len2) {
        while (len1 < len2) {
            SingleNode_1 *node=(SingleNode_1 *)malloc(sizeof(SingleNode_1));
            node->val=0;
            node->next=NULL;
            len1++;
            link1->next=node;
            link1=node;
        }
    }else{
        while (len2 < len1) {
            SingleNode_1 *node=(SingleNode_1 *)malloc(sizeof(SingleNode_1));
            node->val=0;
            node->next=NULL;
            len2++;
            link2->next=node;
            link2=node;
        }
    }
    
//    3、相同索引下的值相加，记录进位
    link1=l1;
    link2=l2;
    SingleNode_1 *l3=NULL;
    SingleNode_1 *link3=NULL;
    int count=0;
    while (link1 != NULL) {
        SingleNode_1 *node=(SingleNode_1 *)malloc(sizeof(SingleNode_1));
        count = link1->val+link2->val + (count>=10 ? 1: 0);
        node->val=(count%10);
        node->next=NULL;
        link1=link1->next;
        link2=link2->next;
        if (link3) link3->next=node;
        link3=node;
        if (l3==NULL) l3=link3;
    }
//    4、记录最后一个索引的进位
    if (count>=10) {
        SingleNode_1 *node=(SingleNode_1 *)malloc(sizeof(SingleNode_1));
        node->val=1;
        node->next=NULL;
        link3->next=node;
    }
    return l3;
}


// 不进行补齐操作，直接相同index相加，当然需要进行节点判空
// 进位记录照样
SingleNode_1 *addTwoNumbers2(SingleNode_1* l1, SingleNode_1* l2){
    
    SingleNode_1 *link1=l1;
    SingleNode_1* link2=l2;
    SingleNode_1 *l3=NULL;
    SingleNode_1 *link3=NULL;
    int count=0;
    // 不进行补齐，
    while (link1 != NULL || link2 != NULL) {
        SingleNode_1 *node=(SingleNode_1 *)malloc(sizeof(SingleNode_1));
        int num1=(link1 == NULL)? 0:link1->val;
        int num2=(link2 == NULL)? 0:link2->val;
        count = num1 + num2 + (count>=10 ? 1: 0);
        node->val=(count%10);
        node->next=NULL;
        link1=(link1 == NULL)? NULL:link1->next;
        link2=(link2 == NULL)? NULL:link2->next;
        if (link3) link3->next=node;
        link3=node;
        if (l3==NULL) l3=link3;
    }
//    记录最后一个索引的进位
    if (count>=10) {
        SingleNode_1 *node=(SingleNode_1 *)malloc(sizeof(SingleNode_1));
        node->val=1;
        node->next=NULL;
        link3->next=node;
    }
    return l3;
}

void add_two_numbers_test(void){
    SingleNode_1 *link1=(SingleNode_1 *)malloc(sizeof(SingleNode_1));
    link1->val=5;
    link1->next=NULL;
    
    SingleNode_1 *node0=(SingleNode_1 *)malloc(sizeof(SingleNode_1));
    node0->val=4;
    node0->next=NULL;

    SingleNode_1 *link2=(SingleNode_1 *)malloc(sizeof(SingleNode_1));
    link2->val=1;
    link2->next=NULL;
    
    SingleNode_1 *node2=(SingleNode_1 *)malloc(sizeof(SingleNode_1));
    node2->val=4;
    node2->next=NULL;
    
    SingleNode_1 *node3=(SingleNode_1 *)malloc(sizeof(SingleNode_1));
    node3->val=3;
    node3->next=NULL;
    
    SingleNode_1 *node4=(SingleNode_1 *)malloc(sizeof(SingleNode_1));
    node4->val=1;
    node4->next=NULL;
    
    link1->next=node0;
    
    link2->next=node2;
    node2->next=node3;
    node3->next=node4;
    
//    SingleNode_1 *link=addTwoNumbers1(link1, link2);
    
    SingleNode_1 *link=addTwoNumbers2(link1, link2);
    
    printf("123\n");
}
