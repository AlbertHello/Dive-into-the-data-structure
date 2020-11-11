//
//  _108_Convert_Sorted_Array_to_Binary_Search_Tree.m
//  LeetCode
//
//  Created by 58 on 2020/11/11.
//

#import "_108_Convert_Sorted_Array_to_Binary_Search_Tree.h"

@interface TreeNode_108 : NSObject
@property(assign, nonatomic)NSInteger val;
@property(strong, nonatomic,nullable)TreeNode_108 *left;
@property(strong, nonatomic,nullable)TreeNode_108 *right;
@end
@implementation TreeNode_108
-(instancetype)initWithVal:(NSInteger)val{
    if (self=[super init]) {
        self.left=nil;
        self.right=nil;
        self.val=val;
    }
    return self;
}
@end



@implementation _108_Convert_Sorted_Array_to_Binary_Search_Tree


/**
 108. 将有序数组转换为二叉搜索树

 将一个按照升序排列的有序数组，转换为一棵高度平衡二叉搜索树。

 本题中，一个高度平衡二叉树是指一个二叉树每个节点 的左右两个子树的高度差的绝对值不超过 1。

 示例:

 给定有序数组: [-10,-3,0,5,9],

 一个可能的答案是：[0,-3,9,-10,null,5]，它可以表示下面这个高度平衡二叉搜索树：

       0
      / \
    -3   9
    /   /
  -10  5
 
 https://leetcode-cn.com/problems/convert-sorted-array-to-binary-search-tree/
 */


/**
 题意：根据升序数组，恢复一棵高度平衡的BST🌲。

 分析：BST的中序遍历是升序的，因此本题等同于根据中序遍历的序列恢复二叉搜索树。因此我们可以以升序序列中的任一个元素作为根节点，以该元素左边的升序序列构建左子树，以该元素右边的升序序列构建右子树，这样得到的树就是一棵二叉搜索树啦～ 又因为本题要求高度平衡，因此我们需要选择升序序列的中间元素作为根节点奥～
 
 时间复杂度：O(n)，其中n 是数组的长度。T(n)=2T(n/2)+O(1)每个数字只访问一次。
 空间复杂度：O(logn)，其中n 是数组的长度。空间复杂度不考虑返回值，因此空间复杂度主要取决于递归栈的深度，递归栈的深度是O(logn)。
 
 */

-(TreeNode_108 *)sortedArrayToBST:(NSArray *)array{
    return [self dfs:array left:0 right:(int)array.count];
}
-(TreeNode_108 *)dfs:(NSArray *)array left:(int)lo right:(int)hi{
    if (lo > hi) return NULL;
    // 以升序数组的中间元素作为根节点 root。
    int mid = lo + ((hi - lo) >> 1); //O(1)
    TreeNode_108 *root = [[TreeNode_108 alloc]initWithVal:[array[mid] integerValue]];
    // 递归的构建 root 的左子树与右子树。
    root.left = [self dfs:array left:lo right:mid-1]; //T(n/2)
    root.right = [self dfs:array left:mid+1 right:hi]; //T(n/2)
    
    return root;
}


@end
