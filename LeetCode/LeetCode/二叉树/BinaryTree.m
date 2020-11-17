//
//  BinaryTree.m
//  LeetCode
//
//  Created by 58 on 2020/11/12.
//

#import "BinaryTree.h"
@interface BTNode : NSObject

@property(assign, nonatomic)NSInteger data;
@property(strong, nonatomic,nullable)BTNode *parent;
@property(strong, nonatomic,nullable)BTNode *left;
@property(strong, nonatomic,nullable)BTNode *right;
@end

@implementation BTNode

- (instancetype)init{
    self = [super init];
    if (self) {
        self.data=0;
        self.parent=nil;
        self.left=nil;
        self.right=nil;
    }
    return self;
}
@end


@interface BTNode1 : NSObject

@property(assign, nonatomic)NSInteger data;
@property(strong, nonatomic,nullable)BTNode1 *parent;
@property(strong, nonatomic,nullable)BTNode1 *left;
@property(strong, nonatomic,nullable)BTNode1 *right;
@property(strong, nonatomic,nullable)BTNode1 *next;
@end

@implementation BTNode1

- (instancetype)init{
    self = [super init];
    if (self) {
        self.data=0;
        self.parent=nil;
        self.left=nil;
        self.right=nil;
    }
    return self;
}
@end


@implementation BinaryTree

//************************* 226 反转二叉树 *************************

//1、递归处理。三种遍历方式都可以
-(BTNode *)invertTree1:(BTNode *)root{
    if (root == NULL) return root;
    BTNode *node=root.left;
    root.left=root.right;
    root.right=node;
    [self invertTree1:root.left];
    [self invertTree1:root.right];
    return root;
}
-(BTNode *)invertTree2:(BTNode *)root{
    if (root == NULL) return root;
    [self invertTree2:root.left];
    BTNode *node=root.left;
    root.left=root.right;
    root.right=node;
    [self invertTree2:root.left];
    return root;
}
-(BTNode *)invertTree3:(BTNode *)root{
    if (root == NULL) return root;
    [self invertTree3:root.left];
    [self invertTree3:root.right];
    BTNode *node=root.left;
    root.left=root.right;
    root.right=node;
    return root;
}
//迭代-使用队列这里使用数组代替,其实就是二叉树的层序遍历
-(BTNode *)invertTree4:(BTNode *)root{
    if (root == NULL) return root;
    NSMutableArray *queue=[NSMutableArray array];
    [queue addObject:root];
    
    while (queue.count != 0) {
        BTNode *node = queue.firstObject;
        BTNode *tmp = node.left;
        node.left = node.right;
        node.right = tmp;
        [queue removeObjectAtIndex:0];
        
        if (node.left != NULL) {
            [queue addObject:node.left];
        }
        if (node.right != NULL) {
            [queue addObject:node.right];
        }
    }
    return root;
}

//************************* 116 填充二叉树节点的右侧指针 *************************
/**
 116. 填充每个节点的下一个右侧节点指针
给定一个完美二叉树，其所有叶子节点都在同一层，每个父节点都有两个子节点。二叉树定义如下：

 struct Node {
   int val;
   Node *left;
   Node *right;
   Node *next;
 }
 填充它的每个 next 指针，让这个指针指向其下一个右侧节点。如果找不到下一个右侧节点，则将 next 指针设置为 NULL。

 初始状态下，所有 next 指针都被设置为 NULL。
 */

-(BTNode1 *)connect:(BTNode1 *)root{
    if (root == nil || root.left == nil) return root;
    [self connectTwoNode:root.left node:root.right];
    return root;
}
-(void)connectTwoNode:(BTNode1 *)node1 node:(BTNode1 *)node2{
    /**** 前序遍历位置 ****/
    // 将传入的两个节点连接
    node1.next = node2;
    // 连接相同父节点的两个子节点
    [self connectTwoNode:node1.left node:node1.right];
    [self connectTwoNode:node2.left node:node2.right];
    // 连接跨越父节点的两个子节点
    [self connectTwoNode:node1.right node:node2.left];
}

//************************* 114 二叉树展开为连表 *************************
/**
 114. 二叉树展开为链表
给定一个二叉树，原地将它展开为一个单链表。
 例如，给定二叉树

     1
    / \
   2   5
  / \   \
 3   4   6
 将其展开为：

 1
  \
   2
    \
     3
      \
       4
        \
         5
          \
           6
 */
/**
 1、将root的左子树和右子树拉平。
 2、将root的右子树接到左子树下方，然后将整个左子树作为右子树。
 */
// 定义：将以 root 为根的树拉平为链表
-(void)flatten:(BTNode *)root{
    // base case
    if (root == nil) return;

    [self flatten:root.left];
    [self flatten:root.right];

    /**** 后序遍历位置 ****/
    // 1、左右子树已经被拉平成一条链表
    BTNode *left = root.left;
    BTNode *right = root.right;

    // 2、将左子树作为右子树
    root.left = nil;
    root.right = left;

    // 3、将原先的右子树接到当前右子树的末端
    BTNode *p = root;
    while (p.right != nil) {
        p = p.right;
    }
    p.right = right;
}
//************************* 654 最大二叉树 *************************
/**
 654. 最大二叉树
 给定一个不含重复元素的整数数组。一个以此数组构建的最大二叉树定义如下：
 二叉树的根是数组中的最大元素。
 左子树是通过数组中最大值左边部分构造出的最大二叉树。
 右子树是通过数组中最大值右边部分构造出的最大二叉树。
 通过给定的数组构建最大二叉树，并且输出这个树的根节点。
 示例 ：
 输入：[3,2,1,6,0,5]
 输出：返回下面这棵树的根节点：

       6
     /   \
    3     5
     \    /
      2  0
        \
         1
 */

/**
 肯定要遍历数组把找到最大值 maxVal，把根节点 root 做出来，然后对 maxVal 左边的数组和右边的数组进行递归调用，作为 root 的左右子树。
  伪代码如下所示：
 TreeNode constructMaximumBinaryTree([3,2,1,6,0,5]) {
     // 找到数组中的最大值
     TreeNode root = new TreeNode(6);
     // 递归调用构造左右子树
     root.left = constructMaximumBinaryTree([3,2,1]);
     root.right = constructMaximumBinaryTree([0,5]);
     return root;
 }
 */
/* 主函数 */
-(BTNode *)constructMaximumBinaryTree:(NSArray *)array {
    
    return [self build:array low:0 height:(int)array.count-1];
}

/* 将 nums[lo..hi] 构造成符合条件的树，返回根节点 */
-(BTNode *)build:(NSArray *)array low:(int)lo height:(int)hi{
    // base case
    if (lo > hi) return nil;

    // 找到数组中的最大值和对应的索引
    int index = -1, maxVal = INT_MIN;
    for (int i = lo; i <= hi; i++) {
        if (maxVal < [array[i] intValue]) {
            index = i;
            maxVal = [array[i] intValue];
        }
    }
    BTNode *root=[[BTNode alloc]init];
    root.data=maxVal;
    // 递归调用构造左右子树
    root.left = [self build:array low:lo height:index -1];
    root.right = [self build:array low:index+1 height:hi];

    return root;
}
//************************* 513 找树左下角的值 *************************
/**
 给定一个二叉树，在树的最后一行找到最左边的值。
 示例 1:
 输入:
     2
    / \
   1   3
 输出:
 1
 示例 2:
 输入:
         1
        / \
       2   3
      /   / \
     4   5   6
        /
       7
 输出:
 7
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/find-bottom-left-tree-value
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
/**
 1 层序遍历
 时间复杂度：O（n）
 空间复杂度：O（1）
 */
-(int)findBottomLeftValue:(BTNode *)root{
    NSMutableArray *queue=[NSMutableArray array];
    [queue addObject:root];
    int size = 1;
    int leftValue = 0;
    while (queue.count != 0) {
        BTNode *node=(BTNode *)queue.firstObject;
        [queue removeLastObject];
        size--;
        if (node.left) {
            [queue addObject:node.left];
        }
        if (node.right) {
            [queue addObject:node.right];
        }
        if (size == 0) {
            size=(int)queue.count;
            BTNode *node=(BTNode *)queue.firstObject;
            leftValue=(int)node.data;
        }
    }
    return leftValue;
}



@end
