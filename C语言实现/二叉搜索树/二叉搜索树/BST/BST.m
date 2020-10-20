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

@property(strong, nonatomic,nullable)BSTNode *root;
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
    
    BSTNode *new_node=[[BSTNode alloc]init];
    new_node.data=ele;
    new_node.left=NULL;
    new_node.right=NULL;
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
//遍历 - 递归
-(void)print_tree_preorder{
    
}
-(void)print_tree_inorder{
    
}
-(void)print_tree_backorder{
    
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

@end
