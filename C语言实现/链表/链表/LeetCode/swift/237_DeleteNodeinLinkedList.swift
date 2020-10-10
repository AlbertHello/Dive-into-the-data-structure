//
//  leedcode.swift
//  链表
//
//  Created by 58 on 2020/10/10.
//  Copyright © 2020 58. All rights reserved.
//

import Foundation

/**
 请编写一个函数，使其可以删除某个链表中给定的（非末尾）节点。传入函数的唯一参数为 要被删除的节点 。
 https://leetcode-cn.com/problems/delete-node-in-a-linked-list/
 示例 1：

 输入：head = [4,5,1,9], node = 5
 输出：[4,1,9]
 解释：给定你链表中值为 5 的第二个节点，那么在调用了你的函数之后，该链表应变为 4 -> 1 -> 9.
 
 */
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
      self.val = val
      self.next = nil
    }
}
class Solution {
    func deleteNode(_ node: ListNode?) {
        guard let current_node = node, let next_node = node?.next else {
            return;
        }
        current_node.val=next_node.val;
        current_node.next=next_node.next;
    }
}
