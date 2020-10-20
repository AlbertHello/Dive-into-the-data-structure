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

//接口
-(void)add:(NSInteger)ele;
-(void)delete_ele:(NSInteger)ele;
-(void)clear;
-(BOOL)contains:(NSInteger)ele;
-(BOOL)is_empty;
-(NSUInteger)size;
-(NSUInteger)height;
-(NSInteger)compare:(NSInteger)current next:(NSInteger)next;

//获取前驱节点
-(BSTNode*)predecessor:(BSTNode *)cur_node;
//获取后继节点
-(BSTNode*)successor:(BSTNode *)cur_node;


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



@end

NS_ASSUME_NONNULL_END
