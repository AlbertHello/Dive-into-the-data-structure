//
//  _83_RemoveDuplicatesfromSortedList.m
//  LeetCode
//
//  Created by Albert on 2021/1/2.
//

#import "_83_RemoveDuplicatesfromSortedList.h"
#include "ListNode_C.h"

@implementation _83_RemoveDuplicatesfromSortedList

/**
 83. 删除排序链表中的重复元素 ¥
 难度 简单
 https://leetcode-cn.com/problems/remove-duplicates-from-sorted-list/
 给定一个排序链表，删除所有重复的元素，使得每个元素只出现一次。

 示例 1:

 输入: 1->1->2
 输出: 1->2
 示例 2:

 输入: 1->1->2->3->3
 输出: 1->2->3
 */


/**
 链表去重其实和数组去重是一模一样的，唯一的区别是把数组赋值操作变成操作指针而已
 
 */
SingleNode_1 *deleteDuplicates(SingleNode_1* head) {
    if (head == NULL) return NULL;
    // 双指针
    SingleNode_1 *slow = head, *fast = head;
    while (fast != NULL) {
        if (fast->val != slow->val) {
            // nums[slow] = nums[fast];
            slow->next = fast;
            // slow++;
            slow = slow->next;
        }
        // fast++
        fast = fast->next;
    }
    // 断开与后面重复元素的连接
    slow->next = NULL;
    return head;
}

@end
