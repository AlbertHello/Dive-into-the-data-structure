//
//  203_RemoveLinkedListElements.c
//  链表
//
//  Created by 58 on 2020/10/12.
//  Copyright © 2020 58. All rights reserved.
//

#include "203_RemoveLinkedListElements.h"

/**
 删除链表中等于给定值 val 的所有节点。
 
 https://leetcode-cn.com/problems/remove-linked-list-elements/
 
 示例:

 输入: 1->2->6->3->4->5->6, val = 6
 输出: 1->2->3->4->5
 
 [1]
 []
  
 [1,2]
 [2]
 
 [5,4,3,2,1,1]
 [5,4,3,2]
 
 */

SingleNode_1* removeElements(SingleNode_1* head, int val){
    if (head == NULL ) return NULL;
    SingleNode_1 *node=head;
    SingleNode_1 *last_node=head;
    while (node->next != NULL){
        if (node->val == val){
            //直接拿下一个的值覆盖当前值，就是删除了当前值啊
            node->val=node->next->val;
            //这一步就相当于往下走了一步
            node->next=node->next->next;
        }else{
            //不行等的情况下往下走一步
            last_node=node;
            node=node->next;
        }
    }
    //此处是遍历到最后一个节点
    if(node->val == val){
        last_node->next = NULL;
    }
    //处理一个元素的情况
    if (head->val == val) {
        head=NULL;
        return NULL;
    }
    return head;
}
