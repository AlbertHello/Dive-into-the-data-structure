//
//  82_RemoveDuplicatesfromSortedList2.c
//  链表
//
//  Created by 58 on 2020/10/13.
//  Copyright © 2020 58. All rights reserved.
//

#include "82_RemoveDuplicatesfromSortedList2.h"

/**
 给定一个排序链表，删除所有含有重复数字的节点，只保留原始链表中 没有重复出现 的数字。

 示例 1:

 输入: 1->2->3->3->4->4->5
 输出: 1->2->5
 示例 2:

 输入: 1->1->1->2->3
 输出: 2->3

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/remove-duplicates-from-sorted-list-ii
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

SingleNode_1* deleteDuplicates(SingleNode_1* head){
    if (head == NULL || head->next == NULL) return head;
    SingleNode_1 *node=head;
    SingleNode_1 *ptr=head;
    while(node->next != NULL){ //至少2个元素
        if(node->val == node->next->val){
            if (node->next->next == NULL && ptr == head) {
                head = NULL;
                return head;
            }else{
                //把这俩都去掉
                ptr->next=node->next->next;
                node=ptr->next;
                if (node == NULL) return head;
            }
        }else{
            ptr=node;
            node=node->next;
        }
    }
    return head;
}

void deleteDuplicatesTest(){
    
    SingleLink_1 *link=create_single_link_1();
    add_for_single_node_1(1, link);
    add_for_single_node_1(1, link);
    add_for_single_node_1(1, link);
    add_for_single_node_1(2, link);
    add_for_single_node_1(3, link);
    add_for_single_node_1(4, link);
    add_for_single_node_1(5, link);
    
    SingleNode_1 *head=deleteDuplicates(link->first);
    link->first=head;
    
    print_single_link_1(link);
}
