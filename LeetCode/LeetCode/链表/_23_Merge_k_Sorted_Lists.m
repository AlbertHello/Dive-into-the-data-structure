//
//  _23_Merge_k_Sorted_Lists.m
//  LeetCode
//
//  Created by 58 on 2020/11/19.
//

#import "_23_Merge_k_Sorted_Lists.h"
#include "ListNode_C.h"

@implementation _23_Merge_k_Sorted_Lists
/**
 23. 合并K个升序链表
 给你一个链表数组，每个链表都已经按升序排列。
 请你将所有链表合并到一个升序链表中，返回合并后的链表。
 示例 1：

 输入：lists = [[1,4,5],[1,3,4],[2,6]]
 输出：[1,1,2,3,4,4,5,6]
 解释：链表数组如下：
 [
   1->4->5,
   1->3->4,
   2->6
 ]
 将它们合并到一个有序链表中得到。
 1->1->2->3->4->4->5->6
 示例 2：

 输入：lists = []
 输出：[]
 示例 3：

 输入：lists = [[]]
 输出：[]
 https://leetcode-cn.com/problems/merge-k-sorted-lists/
 */

SingleNode_1* mergeKLists(SingleNode_1** lists,int listsSize) {
    if (lists == NULL) return NULL;
    return merge(lists, 0, listsSize - 1);
}
//T(k)=2T(k/2)+O(n)
//所以时间复杂度：O(nlogk)
//空间复杂度：递归会使用到O(logk) 空间代价的栈空间。
SingleNode_1* merge(SingleNode_1** lists, int left, int right) {
    if (left == right) return lists[left];
    int mid = left + (right - left) / 2;
    SingleNode_1* l1 = merge(lists, left, mid); //T(k/2)
    SingleNode_1* l2 = merge(lists, mid + 1, right);//T(k/2)
    return mergeTwoLink(l1, l2);//O(n)
}
//时间复杂度：O(n+m)，其中n 和m 分别为两个链表的长度。因为每次调用递归都会去掉 l1 或者 l2 的头节点（直到至少有一个链表为空），函数 mergeTwoList 至多只会递归调用每个节点一次。
//因此，时间复杂度取决于合并后的链表长度，即O(n+m)。
//空间复杂度：O(n+m)，其中n 和m 分别为两个链表的长度。递归调用 mergeTwoLists 函数时需要消耗栈空间，栈空间的大小取决于递归调用的深度。
//结束递归调用时 mergeTwoLists 函数最多调用n+m 次，因此空间复杂度为O(n+m)。
SingleNode_1* mergeTwoLink(SingleNode_1* l1, SingleNode_1* l2){
    if (l1 == NULL) {
        return l2;
    } else if (l2 == NULL) {
        return l1;
    } else if (l1->val < l2->val) {
        l1->next = mergeTwoLink(l1->next, l2);
        return l1;
    } else {
        l2->next = mergeTwoLink(l1, l2->next);
        return l2;
    }
}


@end
