//
//  _572_Subtree_of_Another_Tree.m
//  LeetCode
//
//  Created by 58 on 2020/12/3.
//

#import "_572_Subtree_of_Another_Tree.h"
#import "MyBTNode.h"
#import "MyQueue.h"



@implementation _572_Subtree_of_Another_Tree

/**
 572. 另一个树的子树
 难度 简答
 https://leetcode-cn.com/problems/subtree-of-another-tree/
 给定两个非空二叉树 s 和 t，检验 s 中是否包含和 t 具有相同结构和节点值的子树。s 的一个子树包括 s 的一个节点和这个节点的所有子孙。s 也可以看做它自身的一棵子树。
 示例 1:
 给定的树 s:
      3
     / \
    4   5
   / \
  1   2
 给定的树 t：
    4
   / \
  1   2
 返回 true，因为 t 与 s 的一个子树拥有相同的结构和节点值。
 示例 2:
 给定的树 s：
      3
     / \
    4   5
   / \
  1   2
     /
    0
 给定的树 t：
    4
   / \
  1   2
 返回 false。
 */
/**
 思路：
 把二叉树序列化为字符串，此题就变成了字符串和子串的查找问题
 使用前序遍历和后序遍历都可。中序遍历只能序列化但不能反序列化。
 中序遍历序列化后的根结点在字符串的中间某个字符处，反序列化时无法判断根结点的位置
 而后续和前序序列化后字符串的最后一个或者第一个字符就是根结点。
 此题使用后序遍历：空节点用#代替，每个节点的遍历后追加一个！方便区分，比如：
 3
/ \
4   5
/ \
1   2  序列化后：#!#!1!#!#!2!4!#!#!5!3!
 把两个树后序序列化，得到连个字符串，然后查找子串
 */
-(BOOL)isSubtree:(MyBTNode *)s littleTree:(MyBTNode *)t{
    NSMutableString *postSerializeStr1 = [NSMutableString string];
    [self postSerializeNode:s toStr:postSerializeStr1];
    
    NSMutableString *postSerializeStr2 = [NSMutableString string];
    [self postSerializeNode:t toStr:postSerializeStr2];
    
    return [postSerializeStr1 containsString:postSerializeStr2];
}
// 后续遍历序列化为字符串
// #!#!1!#!#!2!4!#!#!5!3!
-(void)postSerializeNode:(MyBTNode *)node toStr:(NSMutableString *)str{
    // 后序遍历
    if (node.left) {
        [self postSerializeNode:node.left toStr:str];
    }else{
        [str appendString:@"#!"]; // 这里结束继续递归
    }
    if (node.right) {
        [self postSerializeNode:node.right toStr:str];
    }else{
        [str appendString:@"#!"]; // 这里结束继续递归
    }
    // 处理值 。 典型的后续遍历递归算法
    // 这里node一定有值
    [str appendString:[NSString stringWithFormat:@"%d!",node.val]];
}

// 后续遍历序列化为数组
// # # 1 # # 2 4 # # 5 3
-(void)postSerialize:(MyBTNode *)node array:(NSMutableArray<NSString *>*)array{
    // 后序遍历
    if (node.left) {
        [self postSerialize:node.left array:array];
    }else{
        [array addObject:@"#"];// 这里结束继续递归
    }
    if (node.right) {
        [self postSerialize:node.right array:array];
    }else{
        [array addObject:@"#"];// 这里结束继续递归
    }
    // 处理值 。 典型的后续遍历递归算法
    // 这里node一定有值
    [array addObject:[NSString stringWithFormat:@"%d",node.val]];
}
// 后序遍历 反序列化
-(MyBTNode *)dePostSerialize:(NSMutableArray<NSString *>*)nodes{
    if (nodes.count == 0) {
        return NULL;
    }
    // 后续反序列化 数组最后一个是根节点
    NSString *last=nodes.lastObject;
    [nodes removeLastObject];
    if ([last isEqualToString:@"#"]) {
        return NULL;
    }
    MyBTNode *root=[[MyBTNode alloc]init];
    root.val=last.intValue;
    
    // 挨着根节点的是右子树
    root.right=[self dePostSerialize:nodes];
    // 之后才是左子树
    root.left=[self dePostSerialize:nodes];
    
    return root;
}

// 前序遍历 序列化为数组
// 3 4 1 # # 2 # # 5 # #
-(void)preSerialize:(MyBTNode *)node array:(NSMutableArray<NSString *>*)array{
    if (node == NULL) {
        [array addObject:@"#"];// 这里结束继续递归
        return;
    }
    // 处理值
    [array addObject:[NSString stringWithFormat:@"%d",node.val]];
    // 前序遍历
    [self preSerialize:node.left array:array];
    [self preSerialize:node.right array:array];
}
// 前序遍历 反序列化
// 3 4 1 # # 2 # # 5 # #
-(MyBTNode *)dePreSerialize:(NSMutableArray<NSString *>*)nodes{
    if (nodes.count == 0) {
        return NULL;
    }
    // 数组第一个就是跟节点
    NSString *first=nodes.firstObject;
    [nodes removeObjectAtIndex:0];
    if ([first isEqualToString:@"#"]) {
        return NULL;
    }
    
    MyBTNode *root=[[MyBTNode alloc]init];
    root.val=first.intValue;
    
    root.left=[self dePreSerialize:nodes];
    root.right=[self dePreSerialize:nodes];
    
    return root;
}
// 中序遍历 序列化为数组，但没有反序列化
// 3 4 1 # # 2 # # 5 # #
-(void)midSerialize:(MyBTNode *)node array:(NSMutableArray<NSString *>*)array{
    if (node == NULL) {
        [array addObject:@"#"];// 这里结束继续递归
        return;
    }
    // 前序遍历
    [self midSerialize:node.left array:array];
    // 处理值
    [array addObject:[NSString stringWithFormat:@"%d",node.val]];
    
    [self midSerialize:node.right array:array];
}
// 层序遍历 序列化为数组
-(void)levelSerialize:(MyBTNode *)root array:(NSMutableArray<NSString *>*)array{
    if (root == NULL) {
        return;
    }
    NSMutableArray *queue=[NSMutableArray array];
    [queue addObject:root];
    while (queue.count != 0) {
        MyBTNode *node=queue.firstObject;
        [queue removeObjectAtIndex:0];
        
        if ([node isKindOfClass:[NSNull class]]) {
            [array addObject:@"#"];
            continue;
        }
        // 处理值
        [array addObject:[NSString stringWithFormat:@"%d",node.val]];
        
        // 无论 左右子树是否是空，全部加进去
        [queue addObject:node.left==NULL? [NSNull null] : node.left];
        [queue addObject:node.right==NULL? [NSNull null] : node.right];
    }
}
// 层序遍历 反序列化
-(MyBTNode *)deLevelSerialize:(NSMutableArray<NSString *>*)nodes{
    if (nodes.count == 0) {
        return NULL;
    }
    // 数组第一个就是跟节点
    NSString *first=nodes.firstObject;
    if ([first isEqualToString:@"#"]) {
        return NULL;
    }
    MyBTNode *root=[[MyBTNode alloc]init];
    root.val=first.intValue;
    
    NSMutableArray *queue=[NSMutableArray array];
    [queue addObject:root];
    
    for (int i=1; i<nodes.count; ) {
        // 队列中存储的都是父节点
        MyBTNode *parent=queue.firstObject;
        [queue removeObjectAtIndex:0];
        // 父节点对应的左侧子节点
        NSString *left=nodes[i++];
        if([left isEqualToString:@"#"]){
            parent.left=nil;
        }else{
            MyBTNode *leftNode=[[MyBTNode alloc]init];
            leftNode.val=left.intValue;
            parent.left=leftNode;
            [queue addObject:leftNode];
        }
        // 父节点对应的右侧子节点
        NSString *right=nodes[i++];
        if([right isEqualToString:@"#"]){
            parent.right=nil;
        }else{
            MyBTNode *rightNode=[[MyBTNode alloc]init];
            rightNode.val=right.intValue;
            parent.right=rightNode;
            [queue addObject:rightNode];
        }
    }
    return root;
}



+(void)isSubtreeTest{
    _572_Subtree_of_Another_Tree *ins=[[_572_Subtree_of_Another_Tree alloc]init];
    
    
    NSMutableArray *arr=[NSMutableArray array];
    MyBTNode *root=[[MyBTNode alloc]init];
    root.val=3;
    MyBTNode *node1=[[MyBTNode alloc]init];
    node1.val=4;
    MyBTNode *node2=[[MyBTNode alloc]init];
    node2.val=5;
    MyBTNode *node3=[[MyBTNode alloc]init];
    node3.val=1;
    MyBTNode *node4=[[MyBTNode alloc]init];
    node4.val=2;
    
    root.left=node1;
    root.right=node2;
    
    node1.left=node3;
    node1.right=node4;
    
    
    
    //level
    [ins levelSerialize:root array:arr];
    NSLog(@"arr==%@",arr);
    // delevel
    MyBTNode *newRoot=[ins deLevelSerialize:arr];
    [ins printTreeInLevel:newRoot];
    
    
    
    // mid
//    [ins midSerialize:root array:arr];
//    NSLog(@"arr==%@",arr);
    

//    // post
//    [ins postSerialize:root array:arr];
//    NSLog(@"arr==%@",arr);
//    // depost
//    MyBTNode *newRoot=[ins dePostSerialize:arr];
//    [ins printTreeInPost:newRoot];
//
    
    
//    // pre
//    [ins preSerialize:root array:arr];
//    NSLog(@"arr==%@",arr);
//    // depre
//    MyBTNode *newRoot=[ins dePreSerialize:arr];
//    [ins printTreeInPre:newRoot];
    
}

// 掐序遍历打印
-(void)printTreeInPre:(MyBTNode *)root{
    if (root == NULL) {
        printf("# ");
        return;
    }
    printf("%d ",root.val);
    [self printTreeInPre:root.left];
    [self printTreeInPre:root.right];
}
// 后序遍历打印
-(void)printTreeInPost:(MyBTNode *)root{
    if (root == NULL) {
        printf("# ");
        return;
    }
    [self printTreeInPost:root.left];
    [self printTreeInPost:root.right];
    printf("%d ",root.val);
}

// 中序遍历打印
-(void)printTreeInMid:(MyBTNode *)root{
    if (root == NULL) {
        printf("# ");
        return;
    }
    [self printTreeInMid:root.left];
    printf("%d ",root.val);
    [self printTreeInMid:root.right];
}
// 层序遍历打印
-(void)printTreeInLevel:(MyBTNode *)root{
    if (root == NULL) {
        return;
    }
    NSMutableArray *queue=[NSMutableArray array];
    [queue addObject:root];
    while (queue.count != 0) {
        MyBTNode *node=queue.firstObject;
        [queue removeObjectAtIndex:0];
        
        printf("%d ",node.val);
        
        if (node.left) {
            [queue addObject:node.left];
        }
        if (node.right) {
            [queue addObject:node.right];
        }
    }
}







@end
