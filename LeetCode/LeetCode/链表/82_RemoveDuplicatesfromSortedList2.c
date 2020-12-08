//
//  82_RemoveDuplicatesfromSortedList2.c
//  链表
//
//  Created by 58 on 2020/10/13.
//  Copyright © 2020 58. All rights reserved.
//

#include "82_RemoveDuplicatesfromSortedList2.h"
/**
 82. 删除排序链表中的重复元素 II
 
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


// 算法思想
// 再创建一个节点，当做新的head，那么，这个head是不参与比较的。
//
SingleNode_1* deleteDuplicates(SingleNode_1* head){
    if(!head || !head->next) return head;
    //新创建一个节点，放在最前面
    SingleNode_1 *new_head = (SingleNode_1 *)malloc(sizeof(SingleNode_1));
    new_head -> next = head;
    //再设置一个指针，指向这个最前面的节点
    SingleNode_1 *prev = new_head;
    while(prev && prev->next)
    {
        SingleNode_1 *curr = prev -> next; //curr是pre的后一个
        //拿pre的后一个和后一个的后一个比较
        //如果curr到最后一位了或者当前curr所指元素没有重复值
        if(!curr->next || curr->next->val != curr->val){
            prev = curr;
        }else{
            // 将curr定位到一串重复元素的最后一位
            while(curr->next && curr->next->val == curr->val){
                curr = curr -> next;
            }
            // prev->next跳过中间所有的重复元素
            prev -> next = curr -> next;
        }
    }
    // new_head 不是实际的head，要返回下一个才是真实的head
    return new_head -> next;
}
    

void deleteDuplicatesTest(){
    
//    SingleLink_1 *link=create_single_link_1();
//    add_for_single_node_1(5, link);
//    add_for_single_node_1(4, link);
//    add_for_single_node_1(3, link);
//    add_for_single_node_1(2, link);
//    add_for_single_node_1(1, link);
//    add_for_single_node_1(1, link);
//    add_for_single_node_1(1, link);
//
//    SingleNode_1 *head=deleteDuplicates(link->first);
//    link->first=head;
//
//    print_single_link_1(link);
}


