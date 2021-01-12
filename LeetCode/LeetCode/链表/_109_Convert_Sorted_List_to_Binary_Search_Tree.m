//
//  _109_Convert_Sorted_List_to_Binary_Search_Tree.m
//  LeetCode
//
//  Created by 58 on 2020/11/11.
//

#import "_109_Convert_Sorted_List_to_Binary_Search_Tree.h"
//BST
@interface TreeNode_109 : NSObject
@property(assign, nonatomic)NSInteger val;
@property(strong, nonatomic,nullable)TreeNode_109 *left;
@property(strong, nonatomic,nullable)TreeNode_109 *right;
@end
@implementation TreeNode_109
-(instancetype)initWithVal:(NSInteger)val{
    if (self=[super init]) {
        self.left=nil;
        self.right=nil;
        self.val=val;
    }
    return self;
}
@end

//单链表
@interface LinkNode : NSObject
@property(assign, nonatomic)NSInteger val;
@property(strong, nonatomic,nullable)LinkNode *next;
@end
@implementation LinkNode
-(instancetype)init{
    if (self=[super init]) {
        self.val=0;
        self.next=nil;
    }
    return self;
}
@end

@implementation _109_Convert_Sorted_List_to_Binary_Search_Tree

/**
 109. 有序链表转换二叉搜索树 $
 难度 中等
 https://leetcode-cn.com/problems/convert-sorted-list-to-binary-search-tree/
 给定一个单链表，其中的元素按升序排序，将其转换为高度平衡的二叉搜索树。

 本题中，一个高度平衡二叉树是指一个二叉树每个节点 的左右两个子树的高度差的绝对值不超过 1。

 示例:

 给定的有序链表： [-10, -3, 0, 5, 9],

 一个可能的答案是：[0, -3, 9, -10, null, 5], 它可以表示下面这个高度平衡二叉搜索树：

       0
      / \
    -3   9
    /   /
  -10  5
 */
/**
 BST的中序遍历是升序的，因此本题等同于根据中序遍历的序列恢复二叉搜索树。因此我们可以以升序序列中的任一个元素作为根节点，以该元素左边的升序序列构建左子树，以该元素右边的升序序列构建右子树，这样得到的树就是一棵二叉搜索树啦～ 又因为本题要求高度平衡，因此我们需要选择升序序列的中间元素作为根节点奥～
 
 唯一的区别是 108 题是数组，我们可以通过数组索引直接定位到中间元素。
 而本题是单链表，链表找中间节点可以用快慢指针法
 时间复杂度：O(nlogn)，其中n 是链表的长度。n 的链表构造二叉搜索树的时间为T(n)，递推式为T(n)=2⋅T(n/2)+O(n)，根据主定理，T(n)=O(nlogn)。
 空间复杂度：O(logn)，这里只计算除了返回答案之外的空间。平衡二叉树的高度为(logn)，即为递归过程中栈的最大深度，
 也就是需要的空间。
 
 主定理：
 T(n) = T(n/2)  + O(1)    --->>>   O(logn)
 T(n) = T(n/2)  + O(n)    --->>>   O(n)
 T(n) = 2T(n/2) + O(1)    --->>>   O(n)
 T(n) = 2T(n/2) + O(n)    --->>>   O(nlogn)
 T(n) = T(n-1)  + O(1)    --->>>   O(n)
 T(n) = T(n-1)  + O(n)    --->>>   O(n^2)
 T(n) = 2T(n-1) + O(1)    --->>>   O(2^n)
 T(n) = 2T(n-1) + O(n)    --->>>   O(2^n)
 
 */
-(TreeNode_109 *)sortedArrayToBST:(LinkNode *)head{
    if (head == nil) return nil;
    if (head.next == nil) return [[TreeNode_109 alloc]initWithVal:head.val];
    return [self buildBST:head right:NULL];
}
// 快慢指针找中心节点
// 1->2->3->4->5->null 奇数长度，最终fast停留在最后一个节点5上。slow停留在正中间节点3上
// 1->2->3->4->5->6->null 偶数长度，最终fast停留在null上。slow停留在后一半的第一个节点4上。
-(LinkNode *)getMedianLeft:(LinkNode *)left right:(LinkNode *)right{
    LinkNode *slow = left;
    LinkNode *fast = left;
    while (fast != right && fast.next != right) { // O(n)
        slow = slow.next;
        fast = fast.next.next;
    }
    return slow;
}
-(TreeNode_109 *)buildBST:(LinkNode *)left right:(LinkNode *)right{
    if (left == right) return  NULL;
    LinkNode *mid=[self getMedianLeft:left right:right];
    TreeNode_109 *root = [[TreeNode_109 alloc]initWithVal:mid.val];;
    root.left = [self buildBST:left right:mid]; // T(n/2)
    root.right = [self buildBST:mid.next right:right]; // T(n/2)
    return root;
}

@end
