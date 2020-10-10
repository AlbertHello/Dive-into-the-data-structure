//
//  206_ReverseLinkedList.swift
//  链表
//
//  Created by 58 on 2020/10/10.
//  Copyright © 2020 58. All rights reserved.
//

import Foundation

/**
 反转一个单链表。 。
 https://leetcode-cn.com/problems/reverse-linked-list/
 示例:

 输入: 1->2->3->4->5->NULL
 输出: 5->4->3->2->1->NULL
 
 */

class Solution_2 {
    func reverseList(_ head: ListNode_Swfit?) -> ListNode_Swfit? {
        if head == nil {
            return head;
        }
        if head?.next == nil {
            return head;
        }
        let new_head=reverseList(head?.next);
        head?.next?.next=head;
        head?.next=nil;
        return new_head;
    }
//    func reverseList2(_ head: ListNode_Swfit?) -> ListNode_Swfit? {
//        if head == nil {
//            return head;
//        }
//        if head?.next == nil {
//            return head;
//        }
//        var head_old = head;
//        var new_head: ListNode_Swfit?;
//        while head != nil {
//            // 临时变量
//            var tmp_node: ListNode_Swfit?;
//            // tmp指向的一直是head的下一个。
//            tmp_node=head_old?.next;
//            //第一个节点的next指向new，也就是指向null
//            head_old?.next=new_head;
//            //new再指向第一个head。
//            new_head=head_old;
//            //head移到了tmp指向的第二个node
//            head_old=tmp_node;
//        }
//        return new_head;
//    }
}
