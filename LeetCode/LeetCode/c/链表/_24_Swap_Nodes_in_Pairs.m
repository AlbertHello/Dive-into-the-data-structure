//
//  _24_Swap_Nodes_in_Pairs.m
//  LeetCode
//
//  Created by 58 on 2020/11/10.
//

#import "_24_Swap_Nodes_in_Pairs.h"

@interface Node : NSObject
@property(assign, nonatomic)NSInteger val;
@property(strong, nonatomic,nullable)Node *next;
@end
@implementation Node
-(instancetype)init{
    if (self=[super init]) {
        self.next=nil;
    }
    return self;
}
@end


@implementation _24_Swap_Nodes_in_Pairs

/**
 24. 两两交换链表中的节点

 给定一个链表，两两交换其中相邻的节点，并返回交换后的链表。

 你不能只是单纯的改变节点内部的值，而是需要实际的进行节点交换。

 示例 1：

 输入：head = [1,2,3,4]
 输出：[2,1,4,3]
 示例 2：

 输入：head = []
 输出：[]
 示例 3：

 输入：head = [1]
 输出：[1]
  

 提示：

 链表中节点的数目在范围 [0, 100] 内
 0 <= Node.val <= 100
 
 https://leetcode-cn.com/problems/swap-nodes-in-pairs/solution/
 */

-(Node *)swapPairs:(Node *)head{
    if (head == NULL || head.next == NULL) return head;
    Node *rest = head.next.next;
    Node * newHead = head.next;
    newHead.next = head;
    head.next = [self swapPairs:rest];
    return newHead;
}

//每两个节点交换
/**
 复杂度分析

 时间复杂度：O(n)，其中n 是链表的节点数量。需要对每个节点进行更新指针的操作。
 空间复杂度：O(1)。
 */
-(Node *)swapPairs_no_recurse:(Node *)head {
    Node *pre = [[Node alloc]init];//虚拟了一个头节点
    pre.next = head;
    Node *temp = pre;
    //第一个节点和第二个节点都不能为空
    while(temp.next != nil && temp.next.next != nil) {
        //第一个节点 1
        Node *start = temp.next;
        //第二个节点 2
        Node *end = temp.next.next;
        //0->2
        temp.next = end;
        //1->3
        start.next = end.next;
        //2->1
        end.next = start;
        //start 和 end 交换了位置了。temp跟上
        temp = start;
    }
    return pre.next;
}

@end
