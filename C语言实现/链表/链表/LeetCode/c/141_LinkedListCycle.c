//
//  141_LinkedListCycle.c
//  链表
//
//  Created by 58 on 2020/10/10.
//  Copyright © 2020 58. All rights reserved.
//

#include "141_LinkedListCycle.h"
/**
 环形链表
 给定一个链表，判断链表中是否有环。
 https://leetcode-cn.com/problems/linked-list-cycle/
 */

// 快慢指针原理：
// 好比在操场跑圈，跑的快的人一个会和跑的慢的人相遇的，如果快慢指针相遇了则存在环。
// 慢指针走一步，快指针走两步
bool hasCycle(SingleNode_1 *head) {
    if (head==NULL) return false;
    SingleNode_1 *slow=head;
    SingleNode_1 *fast=head->next;
    //fast为空则代表走到头了
    while (fast != NULL) {
        //因为下面有fast->next->next，则需要判断fast->next是否为空
        if (fast->next == NULL) return false;
        slow=slow->next;
        fast=fast->next->next;
        if (slow == fast) return true;
    }
    return  false;
}
