//
//  _876_Middle_of_the_Linked_List.m
//  LeetCode
//
//  Created by 58 on 2020/11/5.
//

#import "_876_Middle_of_the_Linked_List.h"

@implementation _876_Middle_of_the_Linked_List


/**
 876. 链表的中间结点 $
 给定一个头结点为 head 的非空单链表，返回链表的中间结点。
 https://leetcode-cn.com/problems/middle-of-the-linked-list/
 如果有两个中间结点，则返回第二个中间结点。
 示例 1：

 输入：[1,2,3,4,5]
 输出：此列表中的结点 3 (序列化形式：[3,4,5])
 返回的结点值为 3 。 (测评系统对该结点序列化表述是 [3,4,5])。
 注意，我们返回了一个 ListNode 类型的对象 ans，这样：
 ans.val = 3, ans.next.val = 4, ans.next.next.val = 5, 以及 ans.next.next.next = NULL.
 示例 2：

 输入：[1,2,3,4,5,6]
 输出：此列表中的结点 4 (序列化形式：[4,5,6])
 由于该列表有两个中间结点，值分别为 3 和 4，我们返回第二个结点。
  

 提示：

 给定链表的结点数介于 1 和 100 之间。
 */
/**
 快慢指针问题
 让快指针一次前进两步，慢指针一次前进一步，当快指针到达链表尽头时，慢指针就处于链表的中间位置。
 如果链表的长度是奇数，slow恰巧停在中点位置；
 如果长度是偶数，slow最终的位置是中间偏右。
 寻找链表中点的一个重要作用是对链表进行归并排序。

 回想数组的归并排序：求中点索引递归地把数组二分，最后合并两个有序数组。
 对于链表，合并两个有序链表是很简单的，难点就在于二分。
 */
SingleNode_1* middleNode(SingleNode_1* head){
    SingleNode_1 *fast, *slow;
    fast = slow = head;
    while (fast != NULL && fast->next != NULL) {
        //快指针一次走两步，最先到null
        fast = fast->next->next;
        //满指针一次走一步，快指针到头时，慢指针刚好在中间
        slow = slow->next;
    }
    // slow 就在中间位置
    return slow;
}
@end
