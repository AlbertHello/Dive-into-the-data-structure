//
//  BST.h
//  二叉搜索树
//
//  Created by 58 on 2020/10/20.
//  Copyright © 2020 58. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJBinaryTreeInfo.h"


NS_ASSUME_NONNULL_BEGIN

@class BSTNode;

@interface BST : NSObject<MJBinaryTreeInfo>

@property(strong, nonatomic,nullable)BSTNode *root;

//接口
-(void)add:(NSInteger)ele;
-(void)delete_ele:(NSInteger)ele;
-(void)clear;
-(BOOL)contains:(NSInteger)ele;
-(BOOL)is_empty;
-(NSUInteger)size;
-(NSUInteger)height;
-(NSInteger)compare:(NSInteger)current next:(NSInteger)next;

#pragma mark - 前驱后继
//获取前驱节点
-(BSTNode*)predecessor:(BSTNode *)cur_node;
//获取后继节点
-(BSTNode*)successor:(BSTNode *)cur_node;

#pragma mark - 遍历相关
//前序遍历
-(void)print_tree_preorder:(BSTNode *)node;
-(void)print_tree_preorder_no_recurse:(BSTNode *)node;
-(void)print_tree_preorder_no_recurse2:(BSTNode *)node;
//中序遍历
-(void)print_tree_inorder:(BSTNode *)node;
-(void)print_tree_inorder_no_recurse:(BSTNode *)node;
//后序遍历
-(void)print_tree_postorder:(BSTNode *)node;
-(void)print_tree_postorder_no_recurse:(BSTNode *)node;

#pragma mark - 打印相关

- (id)root;
/**
 * how to get the left child of the node
 */
- (id)left:(id)node;
/**
 * how to get the right child of the node
 */
- (id)right:(id)node;
/**
 * how to print the node
 */
- (id)string:(id)node;

#pragma mark - 算法相关
-(BSTNode *)invertTree1:(BSTNode *)root;
-(BSTNode *)invertTree2:(BSTNode *)root;
-(BSTNode *)invertTree3:(BSTNode *)root;
-(BSTNode *)invertTree4:(BSTNode *)root;



@end

NS_ASSUME_NONNULL_END
