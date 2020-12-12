//
//  BinaryTree.m
//  LeetCode
//
//  Created by 58 on 2020/11/12.
//

#import "BinaryTree.h"
#import "MyStack.h"
#import "ListNode_C.h"



static id object = NULL;

@interface BTNode : NSObject

// ************************* BTNode *******************************
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

// ************************* BTNode1 *******************************
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

// ************************* Info *******************************
@interface Info : NSObject
@property(strong, nonatomic)BTNode *root;
@property(assign, nonatomic)NSInteger size;
@property(assign, nonatomic)NSInteger max;
@property(assign, nonatomic)NSInteger min;
- (instancetype)initWithRoot:(BTNode *)root
                        size:(NSInteger)size
                         max:(NSInteger)max
                         min:(NSInteger)min;
@end
@implementation Info
- (instancetype)initWithRoot:(BTNode *)root
                        size:(NSInteger)size
                         max:(NSInteger)max
                         min:(NSInteger)min{
    
    self = [super init];
    if (self) {
        self.root=root;
        self.size=size;
        self.max=max;
        self.min=min;
    }
    return self;
}

@end

// ************************* BinaryTree *******************************
@interface BinaryTree ()
// 处理99题需要的属性
@property(nonatomic,strong)BTNode *prev; // 上一次中序遍历过的节点
@property(nonatomic,strong)BTNode *firstWrong; // 第一个错误节点
@property(nonatomic,strong)BTNode *secondWrong; // 第二个错误节点
// 处理124题需要的属性
@property(assign, nonatomic)int maxValue;


@end
@implementation BinaryTree
- (instancetype)init
{
    self = [super init];
    if (self) {
        object=self;
        self.maxValue=INT_MIN;
    }
    return self;
}

#pragma mark - 226 反转二叉树
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
#pragma mark - 116 填充二叉树节点的右侧指针
//************************* 116 填充二叉树节点的右侧指针 *************************
/**
 116. 填充每个节点的下一个右侧节点指针
 https://leetcode-cn.com/problems/populating-next-right-pointers-in-each-node/
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
#pragma mark - 114 二叉树展开为连表
//************************* 114 二叉树展开为连表 *************************
/**
 114. 二叉树展开为链表
 https://leetcode-cn.com/problems/flatten-binary-tree-to-linked-list/
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
#pragma mark - 654 最大二叉树
//************************* 654 最大二叉树 *************************
/**
 654. 最大二叉树
 https://leetcode-cn.com/problems/maximum-binary-tree/
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
    
    return [self build:array left:0 right:(int)array.count];
}

/* 将 [l, r) 构造成符合条件的树，返回根节点 */
-(BTNode *)build:(NSArray *)array left:(int)l right:(int)r{
    // base case
    if (l == r) return nil;

    // 找到数组中的最大值和对应的索引
    int maxIndex = -1, maxVal = INT_MIN;
    for (int i = l; i < r; i++) {
        if (maxVal < [array[i] intValue]) {
            maxIndex = i;
            maxVal = [array[i] intValue];
        }
    }
    BTNode *root=[[BTNode alloc]init];
    root.data=maxVal;
    // 递归调用构造左右子树
    root.left = [self build:array left:l right:maxIndex];
    root.right = [self build:array left:maxIndex+1 right:r];

    return root;
}

/**
 题目变形：返回一个数组，数组里面存着每个节点的父节点的索引（如果没有父节点，就存 -1）
 index: 0 1 2  3 4 5
 value: 3 2 1  6 0 5
return: 3 0 1 -1 5 3
 
 思路：利用栈求左、右边第一个比它大的数，这个栈从底到顶是降序的。
 */
int *parentIndexes(int *nums, int length) {
    if (nums == NULL || length == 0) return NULL;
    /*
     * 1.扫描一遍所有的元素
     * 2.保持栈从栈底到栈顶是单调递减的
     */
    
    //存储某个数它左边第一个比它大的数的索引
    int *lis=(int *)malloc(sizeof(int)*length);
    //存储某个数它右边第一个比它大的数的索引
    int *ris=(int *)malloc(sizeof(int)*length);
    // 初始化
    for (int i = 0; i < length; i++) {
        ris[i] = -1; // 索引默认为-1，也就是nums[i]左边没有比nums[i]大的数
        lis[i] = -1; // 索引默认为-1，也就是nums[i]右边没有比nums[i]大的数
    }

    MyStack *stack=[[MyStack alloc]init]; // 栈中存储的是数组索引
    
    for (int i = 0; i < length; i++) {
        // 1 首先栈不为空
        // 2 看一下栈顶元素和将要入栈的元素nums[i]谁大，
        // 2.1 如果将要入栈的元素更大：则需要把站定元素弹出，那么这个栈顶元素的右边第一个最大的数就是nums[i]
        while (!stack.isEmpty && nums[i] > nums[stack.peek]) {
            ris[stack.pop] = i; // 栈顶元素的右边第一个最大的数就是nums[i]，存储索引。
        }
        // 2.2 如果将要入栈的元素比栈顶元素小：那么这个将要入栈的元素左边第一个比它大的数就是栈顶元素
        if (!stack.isEmpty) {
            lis[i] = stack.peek; // 这个将要入栈的元素左边第一个比它大的数就是栈顶元素 。存储索引
        }
        // 3 如果将要入栈的元素比栈顶元素小或者栈则继续入栈
        [stack push:i];
    }
    // 到此 lis[i] 和 ris[i] 数组就存著着nums[i]这个数左边第一个比它大的数/右边第一个比它大的数的索引。
    // 而最大二叉树的原理就是每个节点都比左右子节点大。只需要找出lis[i]和ris[i]两者比较小的那个，就是nums[i]的父节点
    // 为什么找lis[i]和ris[i]两者比较小的那个，因为比较大的那个是祖父节点甚至更高层次的节点。不是直接父节点
    int *pis=(int *)malloc(sizeof(int)*length);
    
    for (int i = 0; i < length; i++) {
        if (lis[i] == -1 && ris[i] == -1) {
            // i位置的是根节点
            pis[i] = -1;
            continue;
        }
        if (lis[i] == -1) { // lis[i] 等于-1 表示nums[i]左边没有比nums[i]大的数，只能选右边ris[i]
            pis[i] = ris[i];
        } else if (ris[i] == -1) { // ris[i] 等于-1 表示nums[i]右边没有比nums[i]大的数，只能选左边lis[i]
            pis[i] = lis[i];
        } else if (nums[lis[i]] < nums[ris[i]]) { // lis[i]和ris[i] 都存在，取较小者
            pis[i] = lis[i];
        } else {
            pis[i] = ris[i];
        }
    }
    return pis;
}
#pragma mark - 513 找树左下角的值
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
#pragma mark - 129. 求根到叶子节点数字之和
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
#pragma mark - 112. 路径总和
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
#pragma mark - 113. 路径总和II
//************************* 113. 路径总和II *************************
/**
 113. 路径总和 II
 https://leetcode-cn.com/problems/path-sum-ii/
 给定一个二叉树和一个目标和，找到所有从根节点到叶子节点路径总和等于给定目标和的路径。
 说明: 叶子节点是指没有子节点的节点。
 示例:
 给定如下二叉树，以及目标和 sum = 22，
               5
              / \
             4   8
            /   / \
           11  13  4
          /  \    / \
         7    2  5   1
 返回:
 [
    [5,4,11,2],
    [5,8,4,5]
 ]
 */


/**
 因为要遍历整个树，找到所有路径，所以递归函数不要返回值，112题目只是找到一个路径即可。
 */
static NSMutableArray *path_113 = nil;
static NSMutableArray *result_113 = nil;
-(void)traversal_113:(BTNode*)cur count:(int)count {
    if (!cur.left && !cur.right && count == 0) {
        // 遇到了叶子节点切找到了和为sum的路径
        // result_113 的元素是数组，是满足要求的节点路径
        [result_113 addObject:[NSArray arrayWithArray:path_113]];
        return ;
    }
    
    if (!cur.left && !cur.right) return ; // 遇到叶子节点而没有找到合适的边，直接返回
    
    if (cur.left) { // 左  空节点不遍历
        [path_113 addObject:@(cur.left.data)];
        count -= cur.left.data; // 递归，处理节点;
        [self traversal_113:cur.left count:count];
        count += cur.left.data; // 回溯，撤销处理结果
        [path_113 removeLastObject]; // 回溯
    }
    if (cur.right) { // 右 空节点不遍历
        [path_113 addObject:@(cur.right.data)];
        count -= cur.right.data; // 递归，处理节点;
        [self traversal_113:cur.right count:count];
        count += cur.right.data; // 回溯，撤销处理结果
        [path_113 removeLastObject]; // 回溯
    }
    return ;
}
-(BOOL)hasPathSum113:(BTNode*)root sum:(int)sum {
    if (root == nil) return false;
    path_113=[NSMutableArray array];
    result_113=[NSMutableArray array];
    
    [path_113 addObject:@(root.data)];
    [self traversal_113:root count:sum-root.data];
    return result_113;
}
#pragma mark - 101 二叉树是否对称
//************************* 101 二叉树是否对称 *************************
/**
 101. 对称二叉树
给定一个二叉树，检查它是否是镜像对称的。
 例如，二叉树 [1,2,2,3,4,4,3] 是对称的。
     1
    / \
   2   2
  / \ / \
 3  4 4  3
 但是下面这个 [1,2,2,null,3,null,3] 则不是镜像对称的:
     1
    / \
   2   2
    \   \
    3    3
 
 https://leetcode-cn.com/problems/symmetric-tree/
 */

/**
 迭代法
 对于二叉树是否对称，要比较的是根节点的左子树与右子树是不是相互翻转的，理解这一点就知道了「其实我们要比较的是两个树（这两个树是根节点的左右子树）」，所以在递归遍历的过程中，也是要同时遍历两棵树。比较的是两个子树的里侧和外侧的元素是否相等.
 
 首先我们引入一个队列，这是把递归程序改写成迭代程序的常用方法。每次提取两个结点并比较它们的值（队列中每两个连续的结点应该是相等的，而且它们的子树互为镜像），然后将两个结点的左右子结点按相反的顺序插入队列中。当队列为空时，或者我们检测到树不对称（即从队列中取出两个不相等的连续结点）时，该算法结束。
 
 复杂度分析

 时间复杂度：O(n)
 空间复杂度：这里需要用一个队列来维护节点，每个节点最多进队一次，出队一次，队列中最多不会超过n 个点，故渐进空间复杂度为O(n)。
 */

-(BOOL)isSymmetric:(BTNode*)root{
    if (root == NULL) return true;
    NSMutableArray *queue=[NSMutableArray array];
    NSObject* l=(root.left) ? root.left : [NSNull null];
    NSObject* r=(root.right) ? root.right : [NSNull null];
    [queue addObject:l];// 将左子树头结点加入队列
    [queue addObject:r];// 将右子树头结点加入队列
    while (queue.count != 0) {  // 接下来就要判断这这两个树是否相互翻转
        //出对
        NSObject* leftNode = (NSObject *)queue.firstObject;
        [queue removeObjectAtIndex:0];
        NSObject* rightNode = (NSObject *)queue.firstObject;
        [queue removeObjectAtIndex:0];
        // 左节点为空、右节点为空，此时说明是对称的
        if ( !leftNode && !rightNode) continue;
        // 左右一个节点不为空 返回false
        if (!leftNode || !rightNode) return false;
        // 都不为空但数值不相同 返回false
        if (((BTNode *)leftNode).data != ((BTNode *)rightNode).data) return false;
        
        
        //来到此处说明 leftNode 和 rightNode都有值且相等
        l = (((BTNode *)leftNode).left) ? ((BTNode *)leftNode).left : [NSNull null];
        [queue addObject:l];// 加入左节点左孩子
        
        r = (((BTNode *)rightNode).right) ? ((BTNode *)rightNode).right : [NSNull null];
        [queue addObject:r];// 加入右节点右孩子
        
        r = (((BTNode *)leftNode).right) ? ((BTNode *)leftNode).right : [NSNull null];
        [queue addObject:r];// 加入左节点右孩子
        
        l = (((BTNode *)rightNode).left) ? ((BTNode *)rightNode).left : [NSNull null];
        [queue addObject:l];// 加入右节点左孩子
    }
    return true;
}

//递归
/**
 要遍历两棵树而且要比较内侧和外侧节点,
 所以准确的来说是一个树的遍历顺序是「 左 右 中 」，一个树的遍历顺序是「 右 左 中 」，可以理解算是后序遍历。
 
 1 确定递归函数的参数和返回值
 要比较的是根节点的两个子树是否是相互翻转的，进而判断这个树是不是对称树，所以要比较的是两个树，参数自然也是左子树节点和右子树节点，返回值自然是bool类型。
 2 确定终止条件
 节点为空的情况有：
    a 左节点为空，右节点不为空，不对称，return false
    b 左不为空，右为空，不对称 return  false
    c 左右都为空，对称，返回true
 左右节点不为空：
    a 左右都不为空，比较节点数值，不相同就return false
    b 左右都不为空，且数值相同，则进入单层递归逻辑：
        a 比较二叉树外侧是否对称：传入的是左节点的左孩子，右节点的右孩子。
        b 比较内测是否对称，传入左节点的右孩子，右节点的左孩子。
        c 如果左右都对称就返回true ，有一侧不对称就返回false
 
 假设树上一共n 个节点。
 时间复杂度：这里遍历了这棵树，渐进时间复杂度为O(n)。
 空间复杂度：这里的空间复杂度和递归使用的栈空间有关，这里递归层数不超过n，故渐进空间复杂度为O(n)。
 */
-(BOOL)isSymmetric2:(BTNode*)root{
    if (root == nil) return true;
    return [self compareLeft:root.left right:root.right];
}
-(BOOL)compareLeft:(BTNode*)left right:(BTNode*) right {
    // 首先排除空节点的情况
    if (left == nil && right != nil) return false;
    else if (left != nil && right == nil) return false;
    else if (left == nil && right == nil) return true;
    // 排除了空节点，再排除数值不相同的情况
    else if (left.data != right.data) return false;

    // 此时就是：左右节点都不为空，且数值相同的情况
    // 此时才做递归，做下一层的判断
    
    // 左子树：左、 右子树：右
    bool outside = [self compareLeft:left.left right:right.right];
    // 左子树：右、 右子树：左
    bool inside = [self compareLeft:left.right right:right.left];
    // 左子树：中、 右子树：中 （逻辑处理）
    bool isSame = outside && inside;
    
    return isSame;
}
#pragma mark - 100  相同的树
//************************* 100. 相同的树 *************************
/**
 100. 相同的树
 给定两个二叉树，编写一个函数来检验它们是否相同。
 如果两个树在结构上相同，并且节点具有相同的值，则认为它们是相同的。
 示例 1:
 输入:       1         1
           / \       / \
          2   3     2   3

         [1,2,3],   [1,2,3]
 输出: true
 示例 2:
 输入:      1          1
           /           \
          2             2

         [1,2],     [1,null,2]
 输出: false
 示例 3:
 输入:       1         1
           / \       / \
          2   1     1   2

         [1,2,1],   [1,1,2]
 输出: false
 
 链接：https://leetcode-cn.com/problems/same-tree/
 */

/**
 思想： 深度优先搜索 递归
 如果两个二叉树都为空，则两个二叉树相同。如果两个二叉树中有且只有一个为空，则两个二叉树一定不相同。
 如果两个二叉树都不为空，那么首先判断它们的根节点的值是否相同，若不相同则两个二叉树一定不同，若相同，再分别判断两个二叉树的左子树是否相同以及右子树是否相同。这是一个递归的过程，因此可以使用深度优先搜索，递归地判断两个二叉树是否相同。
 
 1. 确定递归函数的参数和返回值
 我们要比较的是两个树是否是相互相同的，参数也就是两个树的根节点，返回值自然是bool类型。
 2. 确定终止条件
 要比较两个节点数值相不相同，首先要把两个节点为空的情况弄清楚！否则后面比较数值的时候就会操作空指针了。
 节点为空的情况有：
    a. tree1为空，tree2不为空，不对称，return false
    b. tree1不为空，tree2为空，不对称 return false
    c. tree1，tree2都为空，对称，返回true
 
 此时tree1、tree2都不为空，比较节点数值，不相同就return false
 3. 确定单层递归的逻辑
    a. 比较二叉树是否相同 ：传入的是tree1的左孩子，tree2的右孩子。
    b. 如果左右都相同就返回true ，有一侧不相同就返回false 。
 
 时间复杂度：O(min(m,n))，其中m 和n 分别是两个二叉树的节点数。对两个二叉树同时进行深度优先搜索，
 只有当两个二叉树中的对应节点都不为空时才会访问到该节点，因此被访问到的节点数不会超过较小的二叉树的节点数。
 空间复杂度：O(min(m,n))，其中m 和n 分别是两个二叉树的节点数。空间复杂度取决于递归调用的层数，
 递归调用的层数不会超过较小的二叉树的最大高度，最坏情况下，二叉树的高度等于节点数。

 */
-(BOOL)isSameTree1:(BTNode*)root{
    if (root == nil) return true;
    return [self compareLeft:root.left right:root.right];
}
-(BOOL)compareTree1:(BTNode*)tree1 tree2:(BTNode*)tree2{
    // 首先排除空节点的情况
    if (tree1 == nil && tree2 != nil) return false;
    else if (tree1 != nil && tree2 == nil) return false;
    else if (tree1 == nil && tree2 == nil) return true;
    // 排除了空节点，再排除数值不相同的情况
    else if (tree1.data != tree2.data) return false;

    // 此时就是：左右节点都不为空，且数值相同的情况
    // 此时才做递归，做下一层的判断
    // 左子树：左、 右子树：左
    bool outside = [self compareTree1:tree1.left tree2:tree1.left];
    // 左子树：右、 右子树：右
    bool inside = [self compareTree1:tree1.right tree2:tree1.right];
    //逻辑处理 左右都得相等
    bool isSame = outside && inside;
    return isSame;
}
#pragma mark - 236. 二叉树的最近公共祖先
//************************* 236. 二叉树的最近公共祖先 *************************
/**
 236. 二叉树的最近公共祖先
 https://leetcode-cn.com/problems/lowest-common-ancestor-of-a-binary-tree/
 难度 中等
 给定一个二叉树, 找到该树中两个指定节点的最近公共祖先。
 百度百科中最近公共祖先的定义为：“对于有根树 T 的两个结点 p、q，最近公共祖先表示为一个结点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（一个节点也可以是它自己的祖先）。”

 例如，给定如下二叉树:  root = [3,5,1,6,2,0,8,null,null,7,4]
 示例 1:
 输入: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
 输出: 3
 解释: 节点 5 和节点 1 的最近公共祖先是节点 3。
 示例 2:
 输入: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 4
 输出: 5
 解释: 节点 5 和节点 4 的最近公共祖先是节点 5。因为根据定义最近公共祖先节点可以为节点本身。
 说明:
 所有节点的值都是唯一的。
 p、q 为不同节点且均存在于给定的二叉树中。
 */

/**
 * 去以root为根节点的二叉树中查找p、q的最近公共祖先
 * ① 如果p、q同时存在于这棵二叉树中，就能成功返回它们的最近公共祖先
 * ② 如果p、q都不存在于这棵二叉树中，返回null
 * ③ 如果只有p存在于这棵二叉树中，返回p
 * ④ 如果只有q存在于这棵二叉树中，返回q
 */
-(BTNode *)lowestCommonAncestor_OC:(BTNode *)root p:(BTNode *)p q:(BTNode *)q{
    if (root == nil || root == p || root == q) return root;
    // 去以root.left为根节点的二叉树中查找p、q的最近公共祖先
    BTNode *left = [self lowestCommonAncestor_OC:root.left p:p q:q];
    // 去以root.right为根节点的二叉树中查找p、q的最近公共祖先
    BTNode *right = [self lowestCommonAncestor_OC:root.right p:p q:q];;
    
    // 如果left 和 right 都不为空，那么p和q 一定在 根结点两侧，且left=right=root
    if (left != nil && right != nil) return root;
    // 如果left和right有一个为空，
    return (left != nil) ? left : right;
}
#pragma mark - 333 最大BST子树
//************************* 333 最大BST子树 *************************
/**
 给定一个二叉树，找到其中最大的二叉搜索树子树，其中最大指的是子树节点数最多的。
 注意：子树必须包含气所有后代
 输入：[10,5,15,1,8,null,7]
    10
    / \
    5  15
   / \   \
   1  8   7
 
 输出：3
 因为其中
  5
 / \
 1  8
 构成最大BST子树
 
 能用O（n）的时间复杂度解决嘛
 */

-(NSInteger)largestBSTSubtree:(BTNode *)root{
    return (root == NULL) ? 0:[self getInfo:root].size;
}
-(Info *)getInfo:(BTNode *)root{
    if (root == nil) return nil;
    // li(left info)：左子树的最大BST子树信息
    Info *li = [self getInfo:root.left];

    // ri(right info)：右子树的最大BST子树信息
    Info *ri = [self getInfo:root.right];
    /*
    有4种情况，以root为根节点的二叉树就是一棵BST，最大BST子树就是其本身
    ① li != null && ri != null //左右子树不为空且都是BST
    && li.root == root.left && root.val > li.max // 且根结点的值正好大于左BST中的最大值
    && ri.root == root.right && root.val < ri.min // 且根结点的值正好小于左BST中的最小值 那么以root为根结点的树就是一颗更大的BST

    ② li != null && ri == null // 右子树为空
    && li.root == root.left && root.val > li.max // 且根结点的值正好大于左BST中的最大值，那么root也算是一个更大的BST

    ③ li == null && ri != null // 左子树为空
    && ri.root == root.right && root.val < ri.min // 且根结点的值正好小于左BST中的最小值，那么root也算是一个更大的BST

    ④ li == null && ri == null。// 左右子树都是空，那么一个节点也是一个BST
     */

    NSInteger leftBstSize = -1, rightBstSize = -1, max = root.data, min = root.data;
    if (li == nil) { // 左为空
        leftBstSize = 0;
    } else if (li.root == root.left && root.data > li.max) {
        // 左不为空，且左子树是BST，那么leftBstSize和min就有值了
        leftBstSize = li.size;
        min = li.min;
    }// 这里往后虽然左也不为空，但左不是BST了

    if (ri == nil) { // 右为空
        rightBstSize = 0;
    } else if (ri.root == root.right && root.data < ri.min) {
        // 右不为空，且右子树是BST，那么rightBstSize和max就有值了
        rightBstSize = ri.size;
        max = ri.max;
    }// 这里往后虽然右也不为空，但右不是BST了
    
    
    if (leftBstSize >= 0 && rightBstSize >= 0) {
        // 来到这里肯定li 和 ri 都是bst了， li和ri的父节点都是root
        Info *new_info = [[Info alloc]initWithRoot:root
                                              size:1 + leftBstSize + rightBstSize
                                               max:max
                                               min:min];
        return new_info;
    } // 这里代表leftBstSize 和 rightBstSize 等于-1 也就是li和ri不是bst
    
    // 以root为根节点的二叉树并不是BST
    // 返回最大BST子树的节点数量较多的那个Info
    if (li != nil && ri != nil) return (li.size > ri.size) ? li : ri;
    // 这里就代表其中一个为空。返回li、ri中不为null的那个Info
    return (li != nil) ? li : ri;
}
#pragma mark - 99. 恢复二叉搜索树
//************************* 99. 恢复二叉搜索树 *************************
/**
 99. 恢复二叉搜索树
 https://leetcode-cn.com/problems/recover-binary-search-tree/
 难度 困难
 给你二叉搜索树的根节点 root ，该树中的两个节点被错误地交换。请在不改变其结构的情况下，恢复这棵树。
 进阶：使用 O(n) 空间复杂度的解法很容易实现。你能想出一个只使用常数空间的解决方案吗？
 示例 1：
 输入：root = [1,3,null,null,2]
 输出：[3,1,null,null,2]
 解释：3 不能是 1 左孩子，因为 3 > 1 。交换 1 和 3 使二叉搜索树有效。
 示例 2：
 输入：root = [3,1,4,null,null,2]
 输出：[2,1,4,null,null,3]
 解释：2 不能在 3 的右子树中，因为 2 < 3 。交换 2 和 3 使二叉搜索树有效。
 
 */

/**
 思路：
 既然是二叉搜索树，那么中序遍历得到的是一个生序的序列
 只需要找到那个逆序对 就可以恢复了。
 1 如果两个对调的节点，其中序遍历不是挨着的，也就是会出现两个逆序对， 那么第一个错误节点是第一个逆序对中较大者，第二个错误节点是第二个逆序对中较小者。
 2 如果两个对调的节点，其中序遍历是挨着的，也就是只有一个逆序对，
 那么第一个错误节点是逆序对中较大者，第二个错误节点就是逆序对中较小者。
 */


/**
  二叉树的Morris遍历
  时间复杂度O（n）
  空间复杂度O（1）
  以下是Morris中序遍历：
 假设便利到当前节点N：
 1 如果N.left != null，则找到N的前驱节点就是左孩子P=N.left
    如果P.right == null，则P.right = N，也就是对原二叉树添加了一个指针，孩子的右孩子指向了自己。
    然后N=N.left, 然后再回到1
 2 如果N.left == null
    打印N，然后N=N.right，再然后回到1
 如果P.right == N
    则P.right = null //这是把刚才加上的指针断掉，恢复原有二叉树
    然后打印N，然后N=N.right，再回到1
 重复1 和 2 知道N== NULL
 */
-(void)recoverTree:(BTNode *)root{
    BTNode *node = root;
    while (node != nil) {
        if (node.left != nil) { //1 如果N.left != null
            // 找到前驱节点(predecessor)、后继节点(successor)
            BTNode *pred = node.left; // 找到N的前驱节点就是左孩子P=N.left
            while (pred.right != nil && pred.right != node) {
                pred = pred.right;
            }
            if (pred.right == nil) { // 如果P.right == null，
                pred.right = node; // 则P.right = N
                node = node.left; // 然后N=N.left, 然后再回到1
            } else { // 如果 pred.right == N
                [self find:node]; // 访问
                pred.right = nil; // 则P.right=null这是把刚才加上的指针断掉，恢复原有二叉树
                node = node.right; // 然后N=N.right，再回到1
            }
        } else { // 2 如果N.left == null
            [self find:node]; // 访问N
            node = node.right;
        }
    }
    // 交换2个错误节点的值
    int tmp = self.firstWrong.data;
    self.firstWrong.data = self.secondWrong.data;
    self.secondWrong.data = tmp;
}
// 递归
// 时间复杂度：O(N) N 为二叉搜索树的节点个数。
// 空间复杂度：O(H)，其中H 为二叉搜索树的高度。中序遍历的时候栈的深度取决于二叉搜索树的高度。
-(void)recoverTree2:(BTNode *)root{
    if (root == nil) return;
    [self findWrongNodes:root];
    // 交换2个错误节点的值
    int tmp = self.firstWrong.data;
    self.firstWrong.data = self.secondWrong.data;
    self.secondWrong.data = tmp;
}
-(void)findWrongNodes:(BTNode *)root {
   if (root == nil) return;
    [self findWrongNodes:root.left];
    [self find:root]; // 中序便利
    [self findWrongNodes:root.right];
}
-(void)find:(BTNode *)node{
    // 出现了逆序对
    if (self.prev != nil && self.prev.data > node.data) {
        // 第2个错误节点：最后一个逆序对中较小的那个节点
        self.secondWrong = node;
        // 第1个错误节点：第一个逆序对中较大的那个节点
        if (self.firstWrong != nil) return;
        self.firstWrong = self.prev;
    }
    self.prev = node;
}
#pragma mark - 124. 二叉树中的最大路径和
//************************* 124. 二叉树中的最大路径和 *************************
/**
 124. 二叉树中的最大路径和
 难度 困难
 给定一个非空二叉树，返回其最大路径和。
 本题中，路径被定义为一条从树中任意节点出发，沿父节点-子节点连接，达到任意节点的序列。该路径至少包含一个节点，且不一定经过根节点。
 示例 1：
 输入：[1,2,3]
       1
       / \
      2   3
 输出：6
 示例 2：
 输入：[-10,9,20,null,null,15,7]
    -10
    / \
   9  20
     /  \
    15   7
 输出：42
 */
/**
 定义 dfs 函数：求出当前子树能向父节点“提供”的最大路径和。即，一条从父节点延伸下来的路径，
 能在当前子树中捞取的最大收益。它分为三种情况：
 路径停在当前子树的根节点，收益：root.val
 走入左子树，最大收益：root.val + dfs(root.left)
 走入右子树，最大收益：root.val + dfs(root.right)
 最大收益取三者中的最大值。
 再次提醒：一条从父节点延伸下来的路径，不能走入左子树又掉头走右子树，不能两头收益。
 当遍历到null节点时，返回 0，代表收益为 0。
 如果一个子树提供的最大路径和为负，路径走入它，收益不增反减，我们希望这个子树不被考虑，让它返回 0，像砍掉一样。
 题目说，路径不一定经过根节点，说明，最大路径和可能产生于局部子树中
 因此每次递归调用，都求一下「当前子树内部的最大路径和」，每个子树都求，取最大的。
 注意，一个子树内部的路径，要包含当前子树的根节点。如果不包括根节点，那还算什么当前子树的路径，而是当前子树的子树的内部路径。
 所以，一个子树内部的最大路径和 = 左子树提供的最大路径和 + 根节点值 + 右子树提供的最大路径和。即 dfs(root.left) + root.val + dfs(root.right);
 时间复杂度O(N)，每个节点都要遍历，空间复杂度是O(H)，递归树的深度。
 */
-(int)maxPathSum:(BTNode *)root{
    if (root == nil) {
        return 0;
    }
    int left = [self maxPathSum:root.left]; // 左子树提供的最大收益
    int right = [self maxPathSum:root.right]; // 右子树提供的最大收益
    // 当前子树内部的最大路径和
    int innerMaxSum=left + root.data + right;
    // 挑战一下最大纪录
    self.maxValue = max(self.maxValue, innerMaxSum);
    // 对外提供的最大和
    int outputMaxSum = root.data + max(left, right);
    if (outputMaxSum < 0) return 0; // 对外提供的路径和为负，直接返回0
    return outputMaxSum; // 否则正常返回
}

@end
