//
//  141_LinkedListCycle.c
//  链表
//
//  Created by 58 on 2020/10/10.
//  Copyright © 2020 58. All rights reserved.
//

#include "141_LinkedListCycle.h"
/**
 环形链表 ¥¥¥¥¥
 给定一个链表，判断链表中是否有环。
 https://leetcode-cn.com/problems/linked-list-cycle/
 */

// 快慢指针原理：
// 好比在操场跑圈，跑的快的人一个会和跑的慢的人相遇的，如果快慢指针相遇了则存在环。
// 慢指针走一步，快指针走两步
bool hasCycle(SingleNode_1 *head) {
    if (head==NULL) return false;
    SingleNode_1 *slow=head;
    SingleNode_1 *fast=head;
    //fast为空则代表走到头了
    //因为下面有fast->next->next，则需要判断fast->next是否为空
    while (fast != NULL && fast->next == NULL) {
        slow=slow->next;
        fast=fast->next->next;
        if (slow == fast) return true;
    }
    return false;
}

/**
 如果有环，返回这个环的起始位置？
 
 可以看到，当快慢指针相遇时，让其中任一个指针指向头节点，然后让它俩以相同速度前进，再次相遇时所在的节点位置就是环开始的位置。这是为什么呢？

 第一次相遇时，假设慢指针slow走了k步，那么快指针fast一定走了2k步：
 fast一定比slow多走了k步，这多走的k步其实就是fast指针在环里转圈圈，所以k的值就是环长度的「整数倍」
 设相遇点距环的起点的距离为m，那么环的起点距头结点head的距离为k - m，也就是说如果从head前进k - m步就能到达环起点。

 巧的是，如果从相遇点继续前进k - m步，也恰好到达环起点。你甭管fast在环里到底转了几圈，反正走k步可以到相遇点，
 那走k - m步一定就是走到环起点了：
 
 只要我们把快慢指针中的任一个重新指向head，然后两个指针同速前进，k - m步后就会相遇，相遇之处就是环的起点了。
 
 */
SingleNode_1* detectCycle(SingleNode_1* head) {
    SingleNode_1 *slow=head;
    SingleNode_1 *fast=head;
    while (fast != NULL && fast->next != NULL) {
        fast = fast->next->next;
        slow = slow->next;
        if (fast == slow) break;
    }
    // 上面的代码类似 hasCycle 函数
    slow = head;
    while (slow != fast) {
        fast = fast->next;
        slow = slow->next;
    }
    return slow;
}
