//
//  237_DeleteNodeinLinkedList.c
//  链表
//
//  Created by 58 on 2020/10/10.
//  Copyright © 2020 58. All rights reserved.
//

#include "237_DeleteNodeinLinkedList.h"
/**
 请编写一个函数，使其可以删除某个链表中给定的（非末尾）节点。传入函数的唯一参数为 要被删除的节点 。
 https://leetcode-cn.com/problems/delete-node-in-a-linked-list/
 示例 1：

 输入：head = [4,5,1,9], node = 5
 输出：[4,1,9]
 解释：给定你链表中值为 5 的第二个节点，那么在调用了你的函数之后，该链表应变为 4 -> 1 -> 9.
 
 */


void deleteNode(SingleLink_C* node) {
    //拿node后面的节点值直接覆盖当前要删掉的节点的值，不就相当于把当前node删掉了吗
    node->val=node->next->val;
    //同时把当前要删掉的node的next指向下一个的下一个节点。
    node->next=node->next->next;
}
