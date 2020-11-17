//
//  BinaryTree.m
//  LeetCode
//
//  Created by 58 on 2020/11/12.
//

#import "BinaryTree.h"
@interface BTNode : NSObject

@property(assign, nonatomic)int data;
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
//************************* 129. 求根到叶子节点数字之和 *************************
/**
 129. 求根到叶子节点数字之和
 给定一个二叉树，它的每个结点都存放一个 0-9 的数字，每条从根到叶子节点的路径都代表一个数字。
 例如，从根到叶子节点路径 1->2->3 代表数字 123。
 计算从根到叶子节点生成的所有数字之和。
 说明: 叶子节点是指没有子节点的节点。
 
 示例 1:
 输入: [1,2,3]
     1
    / \
   2   3
 输出: 25
 解释:
 从根到叶子节点路径 1->2 代表数字 12.
 从根到叶子节点路径 1->3 代表数字 13.
 因此，数字总和 = 12 + 13 = 25.
 
 示例 2:
 输入: [4,9,0,5,1]
     4
    / \
   9   0
  / \
 5   1
 输出: 1026
 解释:
 从根到叶子节点路径 4->9->5 代表数字 495.
 从根到叶子节点路径 4->9->1 代表数字 491.
 从根到叶子节点路径 4->0 代表数字 40.
 因此，数字总和 = 495 + 491 + 40 = 1026.
 https://leetcode-cn.com/problems/sum-root-to-leaf-numbers/
 
 */
/**
 递归
 1 我们要遍历整个二叉树，且需要要返回值做逻辑处理，所有返回值为void
 参数只需要把根节点传入，此时还需要定义两个全局遍历，一个是result，记录最终结果，一个是数组path，数组方便
 删除最后一个元素，回到上一个节点。这就是回溯
 2 当然是遇到叶子节点，此时要收集结果了，通知返回本层递归，因为单条路径的结果使用数组，
 我们需要一个函数arrayToInt把数组转成int。
 3 这里主要是当左节点不为空，path收集路径，并递归左孩子，右节点同理。
 */
static NSMutableArray *path = nil;
static int result = 0;
// 把数组里都的存储的一条路径的所有数字转化为int
-(int)arrayToInt:(NSArray *)array{
    int sum = 0;
    for (int i = 0; i < array.count; i++) {
        sum = sum * 10 + [array[i] intValue];
    }
    return sum;
}
-(void)traversal:(BTNode*)cur {
    if (!cur.left && !cur.right) { // 遇到了叶子节点
        result += [self arrayToInt:path];
        return;
    }
    if (cur.left) { // 左 （空节点不遍历）
        [path addObject:@(cur.left.data)];// 处理节点
        [self traversal:cur.left];//递归
        //来到这里说明前面一条路径处理完了，把数组最后一个元素删掉也就是删掉叶子结点cur.left
        //删除后最后一个元素是cur
        [path removeLastObject];// 回溯，撤销
    }
    if (cur.right) { // 右 （空节点不遍历）
        [path addObject:@(cur.right.data)];// 处理节点
        [self traversal:cur.right];// 递归
        [path removeLastObject];// 回溯，撤销
    }
    return ;
}
/**
 时间复杂度：O(n)，其中n 是二叉树的节点个数。对每个节点访问一次。
 空间复杂度：O(H)，其中H 是树的高度。空间复杂度主要取决于递归时栈空间的开销，最坏情况下，树呈现链状，
 空间复杂度为O(N)。平均情况下树的高度与节点数的对数正相关，空间复杂度为O(logN)。
 */
-(int)sumNumbers:(BTNode *)root {
    path=[NSMutableArray array];
    if (root == nil) return 0;
    [path addObject:@(root.data)];
    [self traversal:root];
    return result;
}
//************************* 112. 路径总和 *************************
/**
 112. 路径总和
 给定一个二叉树和一个目标和，判断该树中是否存在根节点到叶子节点的路径，这条路径上所有节点值相加等于目标和。
 说明: 叶子节点是指没有子节点的节点。
 示例:
 给定如下二叉树，以及目标和 sum = 22，
               5
              / \
             4   8
            /   / \
           11  13  4
          /  \      \
         7    2      1
 返回 true, 因为存在目标和为 22 的根节点到叶子节点的路径 5->4->11->2。
 https://leetcode-cn.com/problems/path-sum/
 */
/**
 递归
1 可以使用深度优先遍历的方式，确定递归函数的参数和返回类型
 参数：需要二叉树的根节点，还需要一个计数器，这个计数器用来计算二叉树的一条边之和是否正好是目标和，计数器为int型。来看返回值，递归函数什么时候需要返回值？什么时候不需要返回值？
 在《二叉树：我的左下角的值是多少？》中得出结论：如果需要搜索整颗二叉树，那么递归函数就不要返回值，如果要搜索其中一条符合条件的路径，递归函数就需要返回值，因为遇到符合条件的路径了就要及时返回。
 在《二叉树：我的左下角的值是多少？》因为要遍历树的所有路径，找出深度最深的叶子节点，所以递归函数不要返回值。而本题我们要找一条符合条件的路径，所以递归函数需要返回值，及时返回，
2 确定终止条件
 首先计数器如何统计这一条路径的和呢？
 不要去累加然后判断是否等于目标和，那么代码比较麻烦，可以用递减，让计数器count初始为目标和，然后每次减去遍历路径节点上的数值。如果最后count == 0，同时到了叶子节点的话，说明找到了目标和。
 如果遍历到了叶子节点，count不为0，就是没找到。
 3 确定单层递归的逻辑
 因为终止条件是判断叶子节点，所以递归的过程中就不要让空节点进入递归了。
 递归函数是有返回值的，如果递归函数返回true，说明找到了合适的路径，应该立刻返回。
 
 时间复杂度：O(N)，其中N 是树的节点数。对每个节点访问一次。
 空间复杂度：O(H)，其中H 是树的高度。空间复杂度主要取决于递归时栈空间的开销，最坏情况下，树呈现链状，
 空间复杂度为O(N)。平均情况下树的高度与节点数的对数正相关，空间复杂度为O(logN)。
 
 */

//回溯隐藏在traversal(cur->left, count - cur->left->val)这里， 因为把count - cur->left->val 直接作为参数传进去，函数结束，count的数值没有改变。
//为了把回溯的过程体现出来，可以改为如下代码：
-(BOOL)traversal_112:(BTNode*)cur count:(int)count {
    if (!cur.left && !cur.right && count == 0) return true; // 遇到叶子节点，并且计数为0
    if (!cur.left && !cur.right) return false; // 遇到叶子节点直接返回
    if (cur.left) { // 左
        count -= cur.left.data; // 递归，处理节点;
        if ([self traversal_112:cur.left count:count]) return true;
        count += cur.left.data; // 回溯，撤销处理结果
    }
    if (cur.right) { // 右
        count -= cur.right.data; // 递归，处理节点;
        if ([self traversal_112:cur.right count:count]) return true;
        count += cur.right.data; // 回溯，撤销处理结果
    }
    return false;
}
-(BOOL)hasPathSum1:(BTNode*)root sum:(int)sum {
    if (root == nil) return false;
    return [self traversal_112:root count:sum-root.data];
}
//以上代码精简之后如下
-(BOOL)hasPathSum2:(BTNode*)root sum:(int)sum {
    if (root == NULL) return false;
    if (!root.left && !root.right && sum == root.data) return true;
    return [self hasPathSum2:root.left sum:sum-root.data] || [self hasPathSum2:root.right sum:sum-root.data];
}

/**
 解法2 前序遍历迭代
 */
-(BOOL)hasPathSum3:(BTNode*)root sum:(int)sum {
    if (root == NULL) return false;
    NSMutableArray *stack=[NSMutableArray array];
    // 此时栈里要放的是<节点指针, 还要记录从头结点到该节点的路径数值总和>
    NSDictionary *dict=@{
        @"node":root,
        @"count":@(root.data)
    };
    [stack addObject:dict];
    while (stack.count != 0) {
        //访问节点
        NSDictionary *dict =(NSDictionary *)stack.lastObject;
        [stack removeLastObject];
        // 如果该节点是叶子节点了，同时该节点的路径数值等于sum，那么就返回true
        BTNode *node=dict[@"node"];
        int count=[dict[@"count"] intValue];
        if (!node.left && !node.right && sum == count) return true;
        // 右节点，压进去一个节点的时候，将该节点的路径数值也记录下来
        if (node.right) {
            NSDictionary *right=@{
                @"node":node.right,
                @"count":@(count+node.right.data)
            };
            [stack addObject:right];
        }
        // 左节点，压进去一个节点的时候，将该节点的路径数值也记录下来
        if (node.left) {
            NSDictionary *left=@{
                @"node":node.left,
                @"count":@(count+node.left.data)
            };
            [stack addObject:left];
        }
    }
    return false;
}





@end
