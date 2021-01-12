//
//  _148_Sort_List.m
//  LeetCode
//
//  Created by 58 on 2020/12/26.
//

#import "_148_Sort_List.h"
#include "ListNode_C.h"
#include "21_MergeTwoSortedList.h"


@implementation _148_Sort_List


/**
 148. 排序链表 ¥¥¥¥¥
 难度 中等
 链接：https://leetcode-cn.com/problems/sort-list
 给你链表的头结点 head ，请将其按 升序 排列并返回 排序后的链表 。
 
 进阶：
 你可以在 O(n log n) 时间复杂度和常数级空间复杂度下，对链表进行排序吗？
 
 示例 1：


 输入：head = [4,2,1,3]
 输出：[1,2,3,4]
 示例 2：


 输入：head = [-1,5,3,4,0]
 输出：[-1,0,3,4,5]
 示例 3：

 输入：head = []
 输出：[]
 
 */
/**
 题目的进阶问题要求达到O(nlogn) 的时间复杂度和O(1) 的空间复杂度，时间复杂度是O(nlogn) 的排序算法包括归并排序、堆排序和快速排序，
 快速排序的最差时间复杂度是 O(n^2). 其中最适合链表的排序算法是归并排序。
 
 归并排序基于分治算法。最容易想到的实现方式是自顶向下的递归实现，考虑到递归调用的栈空间，
 自顶向下归并排序的空间复杂度是O(logn)。如果要达到O(1) 的空间复杂度，则需要使用自底向上的实现方式。

 方法一：自顶向下归并排序
 对链表自顶向下归并排序的过程如下。
 1 找到链表的中点，以中点为分界，将链表拆分成两个子链表。寻找链表的中点可以使用快慢指针的做法，
 快指针每次移动 2 步，慢指针每次移动1 步，当快指针到达链表末尾时，慢指针指向的链表节点即为链表的中点。
 2 对两个子链表分别排序。
 3 将两个排序后的子链表合并，得到完整的排序后的链表。可以使用「21. 合并两个有序链表」的做法，将两个有序的子链表进行合并。
 
 递归的终止条件是链表的节点个数小于或等于1
 
 时间复杂度：O(nlogn)，其中n 是链表的长度。
 空间复杂度：O(logn)，其中n 是链表的长度。空间复杂度主要取决于递归调用的栈空间。
 
 */
SingleNode_1* toSortList(SingleNode_1* head, SingleNode_1* tail) {
    if (head == NULL) {
        return head;
    }
    if (head->next == tail) {
        head->next = NULL;
        return head;
    }
    // 找到链表中点
    SingleNode_1 *slow = head, *fast = head;
    while (fast != tail) {
        slow = slow->next;
        fast = fast->next;
        if (fast != tail) {
            fast = fast->next;
        }
    }
    SingleNode_1 *mid = slow;
    
    SingleNode_1 *left=toSortList(head, mid);
    SingleNode_1 *right=toSortList(mid, tail);
    
    return mergeTwoLists(left, right);
}

SingleNode_1 * sortList(SingleNode_1* head) {
    return toSortList(head, NULL);
}


/**
 方法二：自底向上归并排序
 使用自底向上的方法实现归并排序，则可以达到O(1) 的空间复杂度。
 首先求得链表的长度length，然后将链表拆分成子链表进行合并。
 具体做法如下。

 1 用subLength 表示每次需要排序的子链表的长度，初始时 subLength=1。
 2 每次将链表拆分成若干个长度为subLength 的子链表（最后一个子链表的长度可以小于 subLength），按照每两个子链表一组进行合并，合并后即可得到若干个长度为
 subLength×2 的有序子链表（最后一个子链表的长度可以小于subLength×2）。合并两个子链表仍然使用「21. 合并两个有序链表」的做法。
 3 将subLength 的值加倍，重复第 2 步，对更长的有序子链表进行合并操作，直到有序子链表的长度大于或等于length，整个链表排序完毕。
 
 复杂度分析
 时间复杂度：O(nlogn)，其中n 是链表的长度。
 空间复杂度：O(1)。
 */
SingleNode_1* sortList2(SingleNode_1* head) {
    if (head == NULL) {
        return head;
    }
    // 计算链表长度
    int length = 0;
    SingleNode_1* node = head;
    while (node != NULL) {
        length++;
        node = node->next;
    }
    SingleNode_1* dummyHead = malloc(sizeof(SingleNode_1));
    dummyHead->next = head;
    for (int subLength = 1; subLength < length; subLength <<= 1) {
        SingleNode_1 *prev = dummyHead, *curr = dummyHead->next;
        while (curr != NULL) {
            SingleNode_1* head1 = curr;
            for (int i = 1; i < subLength && curr->next != NULL; i++) {
                curr = curr->next;
            }
            SingleNode_1* head2 = curr->next;
            curr->next = NULL;
            curr = head2;
            for (int i = 1; i < subLength && curr != NULL && curr->next != NULL;
                 i++) {
                curr = curr->next;
            }
            SingleNode_1* next = NULL;
            if (curr != NULL) {
                next = curr->next;
                curr->next = NULL;
            }
            SingleNode_1* merged = mergeTwoLists(head1, head2);
            prev->next = merged;
            while (prev->next != NULL) {
                prev = prev->next;
            }
            curr = next;
        }
    }
    return dummyHead->next;
}




@end
