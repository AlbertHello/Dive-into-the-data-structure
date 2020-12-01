//
//  _86_Partition_List.m
//  LeetCode
//
//  Created by 58 on 2020/12/1.
//

#import "_86_Partition_List.h"
@interface Node_86 : NSObject
@property(assign, nonatomic)NSInteger val;
@property(strong, nonatomic,nullable)Node_86 *next;
@end
@implementation Node_86
-(instancetype)init{
    if (self=[super init]) {
        self.next=nil;
    }
    return self;
}
@end
@implementation _86_Partition_List

/**
 86. 分隔链表
 给定一个链表和一个特定值 x，对链表进行分隔，使得所有小于 x 的节点都在大于或等于 x 的节点之前。
 你应当保留两个分区中每个节点的初始相对位置。
 示例:
 输入: head = 1->4->3->2->5->2, x = 3
 输出: 1->2->2->4->3->5
 https://leetcode-cn.com/problems/partition-list/
 */

/**
 技巧：虚拟头节点。做出两个虚拟头节点来，一个表示小于X的部分，一个表示大于X的部分，最终两部分链表穿起来。
 时间复杂度：O（n）
 空间复杂度：O（1）
 
 */
-(Node_86 *)partition:(Node_86 *)head val:(int)x{
    if (head == nil) return nil;
    Node_86 *lHead = [[Node_86 alloc]init];
    Node_86 *lTail = lHead;
    Node_86 *rHead = [[Node_86 alloc]init];
    Node_86 *rTail = rHead;
    while (head != nil) {
        if (head.val < x) { // 放在lTail后面
            lTail.next = head;
            lTail = head;
        } else { // 放在rTail后面
            rTail.next = head;
            rTail = head;
        }
        head = head.next;
    }
    /*
     * 因为可能出现这样的情况:
     * 原链表倒数第N个节点A的值是>=x的，A后面所有节点的值都是<x的
     * 然后rTail.next最终其实就是A.next
     */
    rTail.next = nil; // 这句代码不能少
    // 将rHead.next拼接在lTail后面
    lTail.next = rHead.next;
    return lHead.next;
}



@end
