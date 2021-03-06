//
//  21_MergeTwoSortedList.c
//  链表
//
//  Created by 58 on 2020/10/14.
//  Copyright © 2020 58. All rights reserved.
//

#include "21_MergeTwoSortedList.h"

/*
 
 21. 合并两个有序链表 ¥¥¥¥¥
 
 将两个升序链表合并为一个新的 升序 链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。
 
 Example 1:

 Input: l1 = [1,2,4], l2 = [1,3,4]
 Output: [1,1,2,3,4,4]
 Example 2:

 Input: l1 = [], l2 = []
 Output: []
 Example 3:

 Input: l1 = [], l2 = [0]
 Output: [0]

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/merge-two-sorted-lists
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */



/*
 我们可以用迭代的方法来实现上述算法。当 l1 和 l2 都不是空链表时，判断 l1 和 l2 哪一个链表的头节点的值更小，将较小值的节点添加到结果里，当一个节点被添加到结果里之后，将对应链表中的节点向后移一位。
 算法
 首先，我们设定一个哨兵节点 prehead ，这可以在最后让我们比较容易地返回合并后的链表。我们维护一个 prev 指针，我们需要做的是调整它的 next 指针。然后，我们重复以下过程，直到 l1 或者 l2 指向了 null ：如果 l1 当前节点的值小于等于 l2 ，我们就把 l1 当前的节点接在 prev 节点的后面同时将 l1 指针往后移一位。否则，我们对 l2 做同样的操作。不管我们将哪一个元素接在了后面，我们都需要把 prev 向后移一位。在循环终止的时候， l1 和 l2 至多有一个是非空的。由于输入的两个链表都是有序的，所以不管哪个链表是非空的，它包含的所有元素都比前面已经合并链表中的所有元素都要大。这意味着我们只需要简单地将非空链表接在合并链表的后面，并返回合并链表即可。
 
 复杂度分析
 时间复杂度：O(n+m)。其中n 和m 分别为两个链表的长度。因为每次循环迭代中，l1 和 l2只有一个元素会被放进合
 并链表中，因此 while 循环的次数不会超过两个链表的长度之和。所有其他操作的时间复杂度都是常数级别的，
 因此总的时间复杂度为O(n+m)。
 空间复杂度：O(1) 。我们只需要常数的空间存放若干变量。
 */
SingleNode_1* mergeTwoLists(SingleNode_1* l1, SingleNode_1* l2){
    SingleNode_1* preHead = (SingleNode_1 *)malloc(sizeof(SingleNode_1));
    //此时还没有指向哪个链表。
    //等比较两个链表的第一个节点谁更小后再指向这个小的。
    SingleNode_1* prev = preHead;
    
   while (l1 != NULL && l2 != NULL) {
       if (l1->val < l2->val) {
           //如果小，则prev指向小的这个l1，
           prev->next = l1;
           //同时l1往下挪一个，但l2不挪
           //下一轮拿挪动了的l1比较上次的l2
           l1 = l1->next;
       } else {
           //如果大，则prev指向小的这个l1，
           prev->next = l2;
           //同时l2往下挪一个，但l1不挪
           //下一轮拿挪动了的l2比较上次的l1
           l2 = l2->next;
       }
       //判断哪个小后pre也得移动那个小的节点上，
       //也就是pre和l1或者l2是指向同一个节点的
       prev = prev->next;
   }

   // 合并后 l1 和 l2 最多只有一个还未被合并完，我们直接将链表末尾指向未合并完的链表即可
   prev->next = l1 == NULL ? l2 : l1;

   return preHead->next;
}

/**
 递归
 细想也即是两个链表头部值较小的一个节点与剩下元素的 merge 操作结果合并。
 如果 l1 或者 l2 一开始就是空链表 ，那么没有任何操作需要合并，所以我们只需要返回非空链表。否则，我们要判断 l1 和 l2 哪一个链表的头节点的值更小，然后递归地决定下一个添加到结果里的节点。如果两个链表有一个为空，递归结束。
 复杂度分析

 时间复杂度：O(n+m)，其中n 和m 分别为两个链表的长度。因为每次调用递归都会去掉 l1 或者 l2 的头节点（直到至少有一个链表为空），函数 mergeTwoList 至多只会递归调用每个节点一次。
 因此，时间复杂度取决于合并后的链表长度，即O(n+m)。
 空间复杂度：O(n+m)，其中n 和m 分别为两个链表的长度。递归调用 mergeTwoLists 函数时需要消耗栈空间，栈空间的大小取决于递归调用的深度。
 结束递归调用时 mergeTwoLists 函数最多调用n+m 次，因此空间复杂度为O(n+m)。
 */

SingleNode_1* mergeTwoLists2(SingleNode_1* l1, SingleNode_1* l2){
    if (l1 == NULL) {
        return l2;
    } else if (l2 == NULL) {
        return l1;
    } else if (l1->val < l2->val) {
        l1->next = mergeTwoLists2(l1->next, l2);
        return l1;
    } else {
        l2->next = mergeTwoLists2(l1, l2->next);
        return l2;
    }
}

/**
 88. 合并两个有序数组 ¥
 https://leetcode-cn.com/problems/merge-sorted-array/
 难度 简单
 给你两个有序整数数组 nums1 和 nums2，请你将 nums2 合并到 nums1 中，使 nums1 成为一个有序数组。
 初始化 nums1 和 nums2 的元素数量分别为 m 和 n 。你可以假设 nums1 的空间大小等于 m + n，这样它就有足够的空间保存来自 nums2 的元素。
 
 解法1 双指针倒序
 时间：O（n）
 空间：O（1）
 */
void merge2sortArray(int* nums1, int m, int* nums2, int n) {
    // two get pointers for nums1 and nums2
    int p1 = m - 1;
    int p2 = n - 1;
    // set pointer for nums1
    int p = m + n - 1;
    // while there are still elements to compare
    while ((p1 >= 0) && (p2 >= 0)){
        // compare two elements from nums1 and nums2 and add the largest one in nums1
        nums1[p--] = (nums1[p1] < nums2[p2]) ? nums2[p2--] : nums1[p1--];
    }
    // add missing elements from nums2
    memcpy(nums1, nums2, p2+1);
}
/**
 解法1 双指针正序
 时间：O（n）
 空间：O（1）
 */
void merge2sortArray2(int* nums1, int m, int* nums2, int n) {
    // Make a copy of nums1.
    int *nums1_copy=(int *)malloc(sizeof(int)*m);
    memcpy(nums1_copy, nums1, m);
    
    // Two get pointers for nums1_copy and nums2.
    int p1 = 0;
    int p2 = 0;

    // Set pointer for nums1
    int p = 0;

    // Compare elements from nums1_copy and nums2
    // and add the smallest one into nums1.
    while ((p1 < m) && (p2 < n))
      nums1[p++] = (nums1_copy[p1] < nums2[p2]) ? nums1_copy[p1++] : nums2[p2++];

    // if there are still elements to add
    if (p1 < m)
        memcpy(nums1 + p1 + p2, nums1_copy+p1, m + n - p1 - p2);
    if (p2 < n)
        memcpy(nums1 + p1 + p2, nums2+p2, m + n - p1 - p2);
}
