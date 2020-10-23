//
//  BST.m
//  二叉搜索树
//
//  Created by 58 on 2020/10/20.
//  Copyright © 2020 58. All rights reserved.
//

#import "BST.h"

@interface BSTNode : NSObject

@property(assign, nonatomic)NSInteger data;
@property(strong, nonatomic,nullable)BSTNode *parent;
@property(strong, nonatomic,nullable)BSTNode *left;
@property(strong, nonatomic,nullable)BSTNode *right;

-(BOOL)isLeaf;
-(BOOL)hasTwoChildren;

@end

@implementation BSTNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.data=0;
        self.parent=nil;
        self.left=nil;
        self.right=nil;
    }
    return self;
}
-(BOOL)isLeaf{
    return self.left == NULL && self.right == NULL;
}
-(BOOL)hasTwoChildren{
    return self.left != NULL && self.right != NULL;
}
-(void)dealloc{
//    NSLog(@"BSTNode dealloc");
}
@end


@interface BST()
@property(assign, nonatomic)NSUInteger count;
@end

@implementation BST

-(void)dealloc{
    NSLog(@"BST dealloc");
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.root=nil;
        self.count=0;
    }
    return self;
}
-(void)add:(NSInteger)ele{
    if (!self.root) {
        self.root = [[BSTNode alloc]init];
        self.root.data=ele;
        self.root.parent=nil;
        self.root.left=nil;
        self.root.right=nil;
        self.count++;
        return;
    }
    BSTNode *parent_node=self.root;
    BSTNode *node=self.root;
    NSInteger cmp=0;
    while (node!=NULL) {
        cmp=[self compare:node.data next:ele];
        if (cmp<0) {
            //父节点指针随之跟着变换
            parent_node=node;
            //ele大于node.data，所以在右子树中找。直到node为null时，
            //说明找到了右子树中最大的那个node, 那么此时node的父节点就被定位了。
            //后面直接父节点.right=新节点
            node=parent_node.right;
        }else if (cmp>0){
            //父节点指针随之跟着变换
            parent_node=node;
            //ele小于node.data，所以在左子树中找
            node=parent_node.left;
        }else{
            //相等
            return;
        }
    }
    BSTNode *inorder=(__bridge BSTNode *)malloc(sizeof(BSTNode *)*501);
    
    BSTNode *new_node=[[BSTNode alloc]init];
    new_node.data=ele;
    new_node.left=NULL;
    new_node.right=NULL;
    new_node.parent=parent_node;
    if (cmp<0) {
        parent_node.right=new_node;
    }else{
        parent_node.left=new_node;
    }
    self.count++;
}
-(void)delete_ele:(NSInteger)ele{
    BSTNode *node=[self getNode:ele];
    if (!node) return;
    self.count--;
    
    // 如果要删除的节点的度为2，那么可以找他的后继或前驱节点都能来替换它
    if (node.hasTwoChildren) {
        // 这里找到后继节点
        BSTNode *s = [self successor:node];
        // 用后继节点的值覆盖度为2的节点的值，不就相当于删掉了这个度为2的节点嘛
        node.data = s.data;
        // 同时把node指针指向那个找到的后继节点，接下来把这个后继节点删掉。
        node = s;
    }
    
    // 删除node节点（node的度必然是1或者0，因为找到的这个前驱或者后继节点是原先节点中左子树中最大或者是右子树中最小的节点，他们的度肯定为1）
    // 首先拿到这个将要被删除的节点的左右子节点，看这个节点是度为1还是0
    BSTNode *replacement = node.left != NULL ? node.left : node.right;
    
    if (replacement != NULL) { // node是度为1的节点
        // 更改parent
        replacement.parent = node.parent;
        // 更改parent的left、right的指向
        if (node.parent == NULL) { // node是度为1的节点并且是根节点
            self.root = replacement;
        } else if (node == node.parent.left) {
            //如果node是左测的节点，删除时就需要它父节点的left指针移动
            node.parent.left = replacement;
        } else { // node == node.parent.right
            //如果node是右测的节点，删除时就需要它父节点的right指针移动
            node.parent.right = replacement;
        }
    } else if (node.parent == NULL) { // node是叶子节点并且是根节点
        self.root = NULL;
    } else { // node是叶子节点，但不是根节点
        if (node == node.parent.left) {
            node.parent.left = NULL;//删除叶子直接置空
        } else { // node == node.parent.right
            node.parent.right = NULL;//删除叶子直接置空
        }
    }
}
-(BSTNode*)getNode:(NSInteger)ele{
    BSTNode *node = self.root;
    while (node != NULL) {
        NSInteger cmp = [self compare:node.data next:ele];
        if (cmp == 0) return node;
        if (cmp > 0) {
            node = node.left;
        } else { // cmp < 0
            node = node.right;
        }
    }
    return NULL;
}
-(void)clear{
    self.root=nil;
    self.count=0;
}
-(NSUInteger)size{
    return self.count;
}
-(BOOL)contains:(NSInteger)ele;{
    return [self getNode:ele] != nil;
}
-(BOOL)is_empty{
    return self.count==0;
}
-(NSInteger)compare:(NSInteger)current next:(NSInteger)next;{
    return current-next;//返回负数放右侧，返回正数放左侧。返回0直接替换。
}
-(NSUInteger)height{
    if (self.root == NULL) return 0;
    // 树的高度
    NSUInteger height = 0;
//    // 存储着每一层的元素数量
    NSUInteger levelSize = 1;
    //用队列。根节点入队。这里用数组当做队列
    NSMutableArray *queue=[NSMutableArray array];
    [queue addObject:self.root];
    while (queue.count != 0) {
        BSTNode *node = queue.firstObject;
        levelSize--;
        [queue removeObjectAtIndex:0];
        
        if (node.left != NULL) {
            [queue addObject:node.left];
        }
        if (node.right != NULL) {
            [queue addObject:node.right];
        }
        if (levelSize == 0) { // 意味着即将要访问下一层
            levelSize = queue.count;
            height++;
        }
    }
    return height;
}

-(BSTNode*)predecessor:(BSTNode *)cur_node{
    if (cur_node == NULL) return NULL;
    // 前驱节点在左子树当中（left.right.right.right....）
    BSTNode *p = cur_node.left;
    if (p != NULL) {
        while (p.right != NULL) {
            p = p.right;
        }
        return p;
    }
    
    // 从父节点、祖父节点中寻找前驱节点
    while (cur_node.parent != NULL && cur_node == cur_node.parent.left) {
        cur_node = cur_node.parent;
    }
    // node.parent == null
    // node == node.parent.right
    return cur_node.parent;
}
-(BSTNode*)successor:(BSTNode *)cur_node{
    if (cur_node == NULL) return NULL;
    // 前驱节点在左子树当中（right.left.left.left....）
    BSTNode *p = cur_node.right;
    if (p != NULL) {
        while (p.left != NULL) {
            p = p.left;
        }
        return p;
    }
    // 从父节点、祖父节点中寻找前驱节点
    while (cur_node.parent != NULL && cur_node == cur_node.parent.right) {
        cur_node = cur_node.parent;
    }
    return cur_node.parent;
}
//前序遍历 - 递归
-(void)print_tree_preorder:(BSTNode *)node{
    if (!node) return;
    NSLog(@"node.data: %ld",node.data);
    [self print_tree_preorder:node.left];
    [self print_tree_preorder:node.right];
}
//前序遍历 - 迭代
//打印顺序是：先根、次左、后右
-(void)print_tree_preorder_no_recurse:(BSTNode *)node{
    if (!node) return;
    //用栈实现。主要是判断一个节点是否有右节点，有则先把右节点入栈，再把左节点入栈
    NSMutableArray *stack=[NSMutableArray array];
    //根节点入栈
    [stack addObject:self.root];
    while (stack.count != 0) {
        //栈顶元素出栈
        BSTNode *node=stack.lastObject;
        [stack removeObject:node];
        // 访问node节点
        NSLog(@"node.data: %ld",node.data);
        
        if (node.right != NULL) { // 先判断右节点
            //把右节点入栈，出栈时肯定晚于左节点
            [stack addObject:node.right];
        }
        if (node.left != NULL) { // 先判断左节点
            //再把左节点入栈，出栈时肯定早于右节点
            [stack addObject:node.left];
        }
    }
}
// 栈中保存的都是右节点
-(void)print_tree_preorder_no_recurse2:(BSTNode *)node{
    BSTNode *n = node;
    NSMutableArray *stack=[NSMutableArray array];
    while (true) {
        if (n != NULL) {
            // 访问node节点
            NSLog(@"node.data: %ld",n.data); //先访问
            // 将右子节点入栈
            if (n.right != NULL) { //然后找个节点如果有有右节点，顺便压进去
                [stack addObject:n.right];// 栈中保存的都是右节点
            }
            // 该节点继续向左走
            n = n.left; //一直走到null，左侧节点全部访问完成，下一步弹出栈顶元素，栈元素都是右节点
        } else if (stack.count == 0) {
            return;
        } else {
            // 处理右边
            n=stack.lastObject; //弹出右节点
            [stack removeObject:n];
        }
    }
}

-(void)print_tree_inorder:(BSTNode *)node{
    if (!node) return;
    [self print_tree_inorder:node.left];
    NSLog(@"node.data: %ld",node.data);
    [self print_tree_inorder:node.right];
}
//中序遍历 - 迭代
//打印顺序是：先左、次根、后右
-(void)print_tree_inorder_no_recurse:(BSTNode *)node{
    if (!node) return;
    //用栈实现。
    NSMutableArray *stack=[NSMutableArray array];
    BSTNode *n = node;
    while (true) {
        if (n != NULL) {
            [stack addObject:n];
            // 向左走,一直把所有最左侧的节点入栈，知道最左侧的节点为null
            n = n.left;
        } else if (stack.count == 0) {
            return;
        } else { //最左侧的节点为null时
            n=stack.lastObject; //取出栈顶元素，此时这个node正好是为空的那个节点的父节点。
            [stack removeObject:n];
            // 访问node节点
            NSLog(@"node.data: %ld",n.data);
            // 让右节点进行中序遍历
            n = n.right; //在赋值栈顶节点的右节点，下一轮开始
        }
    }
}
struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};
// C 语言实现中序遍历
int* inorderTraversal(struct TreeNode* root, int* returnSize){
    if (root == NULL){
        *returnSize=0;
        return NULL;
    }
    struct TreeNode **inorder=(struct TreeNode **)malloc(sizeof(struct TreeNode *)*100);
    int *valArr=(int *)malloc(sizeof(int)*100);
    int i=0;
    int j=0;
    struct TreeNode* node=root;
    while (true){
        if(node != NULL){
            inorder[i++]=node;
            node=node->left;
        }else if(i == 0){
            break;
        }else{
            node=inorder[--i];
            valArr[j++]=node->val;
            node=node->right;
        }
    }
    *returnSize=j;
    return valArr;
}

-(void)print_tree_postorder:(BSTNode *)node{
    if (!node) return;
    [self print_tree_postorder:node.left];
    [self print_tree_postorder:node.right];
    NSLog(@"node.data: %ld",node.data);
}
//后序遍历 - 迭代
//打印顺序是：先左、次后、后跟
-(void)print_tree_postorder_no_recurse:(BSTNode *)node{
    if (!node) return;
    // 记录上一次弹出访问的节点
    //当访问完右节点后，栈顶元素其实就是该节点的父节点，且该父节点肯定不是叶子节点
    //当栈顶元素出栈时判断下前一次访问的节点跟目前的栈顶元素是不是父子关系
    //要不然栈顶元素既不是叶子也没有判断就会再次把右节点压进栈
    BSTNode *prev = NULL;
    NSMutableArray *stack=[NSMutableArray array];
    [stack addObject:node];
    while (stack.count != 0) {
        BSTNode *top=stack.lastObject;
        if (top.isLeaf || (prev != NULL && prev.parent == top)) {
            //第一次来到此处说明根节点的左子树已经全部压进了栈中
            //且此时栈顶元素top是叶子节点
            prev = stack.lastObject; //出栈
            [stack removeObject:prev];
            // 访问节点
            NSLog(@"node.data: %ld",prev.data);
        } else {
            if (top.right != NULL) {
                [stack addObject:top.right];
            }
            if (top.left != NULL) {
                [stack addObject:top.left];
            }
        }
    }
}
//层序遍历
-(void)print_tree_levelorder{
    if (self.root == NULL) return;
    // 还是用队列，但此处用数组代替
    NSMutableArray *queue=[NSMutableArray array];
    [queue addObject:self.root];
    
    while (queue.count != 0) {
        BSTNode *node = queue.firstObject;
        [queue removeObjectAtIndex:0];
        //访问
        NSLog(@"node.data = %ld",(long)node.data);
        //左子节点入队
        if (node.left != NULL) {
            [queue addObject:node.left];
        }
        //右子节点入队
        if (node.right != NULL) {
            [queue addObject:node.right];
        }
    }
}

#pragma mark - 打印协议
/**
 * who is the root node
 */
- (id)root{
    return _root;
}
/**
 * how to get the left child of the node
 */
- (id)left:(id)node{
    BSTNode *n=(BSTNode *)node;
    return n.left;
}
/**
 * how to get the right child of the node
 */
- (id)right:(id)node{
    BSTNode *n=(BSTNode *)node;
    return n.right;
}
/**
 * how to print the node
 */
- (id)string:(id)node{
    BSTNode *n=(BSTNode *)node;
    return @(n.data);
}

/**
 226. 翻转二叉树
 难度 简单
 翻转一棵二叉树。

 示例：

 输入：
      4
    /   \
   2     7
  / \   / \
 1   3 6   9
 输出：

      4
    /   \
   7     2
  / \   / \
 9   6 3   1
 
 https://leetcode-cn.com/problems/invert-binary-tree/
 
 */

//1、递归处理。三种遍历方式都可以
-(BSTNode *)invertTree1:(BSTNode *)root{
    if (root == NULL) return root;
    BSTNode *node=root.left;
    root.left=root.right;
    root.right=node;
    [self invertTree1:root.left];
    [self invertTree1:root.right];
    return root;
}

-(BSTNode *)invertTree2:(BSTNode *)root{
    if (root == NULL) return root;
    [self invertTree2:root.left];
    BSTNode *node=root.left;
    root.left=root.right;
    root.right=node;
    [self invertTree2:root.left];
    return root;
}
-(BSTNode *)invertTree3:(BSTNode *)root{
    if (root == NULL) return root;
    [self invertTree3:root.left];
    [self invertTree3:root.right];
    BSTNode *node=root.left;
    root.left=root.right;
    root.right=node;
    return root;
}

//迭代-使用队列这里使用数组代替,其实就是二叉树的层序遍历
-(BSTNode *)invertTree4:(BSTNode *)root{
    if (root == NULL) return root;
    NSMutableArray *queue=[NSMutableArray array];
    [queue addObject:root];
    
    while (queue.count != 0) {
        BSTNode *node = queue.firstObject;
        BSTNode *tmp = node.left;
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


@end
