//
//  _160_Intersection_of_Two_Linked_Lists.m
//  LeetCode
//
//  Created by 58 on 2020/11/12.
//

#import "_160_Intersection_of_Two_Linked_Lists.h"
//Node
@interface Node_160 : NSObject
@property(assign, nonatomic)NSInteger val;
@property(strong, nonatomic,nullable)Node_160 *next;
@end
@implementation Node_160

@end
@implementation _160_Intersection_of_Two_Linked_Lists

/**
 160. 相交链表
 编写一个程序，找到两个单链表相交的起始节点。

 如下面的两个链表：在节点 c1 开始相交。
 示例 1：
 输入：intersectVal = 8, listA = [4,1,8,4,5], listB = [5,0,1,8,4,5], skipA = 2, skipB = 3
 输出：Reference of the node with value = 8
 输入解释：相交节点的值为 8 （注意，如果两个链表相交则不能为 0）。从各自的表头开始算起，链表 A 为 [4,1,8,4,5]，链表 B 为 [5,0,1,8,4,5]。在 A 中，相交节点前有 2 个节点；在 B 中，相交节点前有 3 个节点。
   示例 2：
输入：intersectVal = 2, listA = [0,9,1,2,4], listB = [3,2,4], skipA = 3, skipB = 1
 输出：Reference of the node with value = 2
 输入解释：相交节点的值为 2 （注意，如果两个链表相交则不能为 0）。从各自的表头开始算起，链表 A 为 [0,9,1,2,4]，链表 B 为 [3,2,4]。在 A 中，相交节点前有 3 个节点；在 B 中，相交节点前有 1 个节点。
   示例 3：
 输入：intersectVal = 0, listA = [2,6,4], listB = [1,5], skipA = 3, skipB = 2
 输出：null
 输入解释：从各自的表头开始算起，链表 A 为 [2,6,4]，链表 B 为 [1,5]。由于这两个链表不相交，所以 intersectVal 必须为 0，而 skipA 和 skipB 可以是任意值。
 解释：这两个链表不相交，因此返回 null。
 */

/**
 题解：设链表A的长度为a+c，链表B的长度为b+c,将两个链表连起来，A->B和B->A，
 比如：linkA= 1->2->3->4->5->null
 比如：linkB= 6->7->4->5->null
 那么A+B=1->2->3->4->5->null->6->7->4->5->null
 那么B+A=6->7->4->5->null->1->2->3->4->5->null
 无论A+B还是B+A只要他俩是相交的，连起来后最后的节点都是相同的，那么从头开始一步一步的走肯定能碰到相同的节点啊
 如果他俩不相交，那么一直走到最后呗都是NULL，就说明不相交
 时间复杂度：O（n）
 时间复杂度：O（1）
 */
Node_160 *getIntersectionNode(Node_160 *headA, Node_160 *headB) {
    if(!headA || !headB) return NULL;
    Node_160 *ptr_a=headA;
    Node_160 *ptr_b=headB;
    while(ptr_a != ptr_b){ // 不相交都是null时也会结束循环
        //第一次走到null之后再接着从另一条连表头部还是走
        ptr_a = ptr_a ? ptr_a.next : headB;
        ptr_a = ptr_b ? ptr_b.next : headA;
    }
    return ptr_a;
}


@end
