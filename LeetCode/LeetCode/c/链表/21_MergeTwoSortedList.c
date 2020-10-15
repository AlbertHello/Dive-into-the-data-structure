//
//  21_MergeTwoSortedList.c
//  链表
//
//  Created by 58 on 2020/10/14.
//  Copyright © 2020 58. All rights reserved.
//

#include "21_MergeTwoSortedList.h"

/*
 
 21. 合并两个有序链表
 
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

 作者：LeetCode-Solution
 链接：https://leetcode-cn.com/problems/merge-two-sorted-lists/solution/he-bing-liang-ge-you-xu-lian-biao-by-leetcode-solu/
 来源：力扣（LeetCode）
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
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
           //如果打，则prev指向小的这个l1，
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

