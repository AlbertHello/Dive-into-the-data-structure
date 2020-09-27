//
//  BinarySearchTree.h
//  二叉搜索树
//
//  Created by 王启正 on 2019/9/17.
//  Copyright © 2019 58. All rights reserved.
//

#ifndef BinarySearchTree_h
#define BinarySearchTree_h

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct Node {
    int data;
    struct Node *parent;
    struct Node *left;
    struct Node *right;
} BinarySearchNode;

void add(int ele);
BinarySearchNode* getNode(int ele);
void delete_ele(int ele);
void clear(void);
bool contains(int ele);
int size(void);
bool is_empty(void);
int compare(int current, int next);
void print_tree_preorder(void);
void print_tree_inorder(void);
void print_tree_backorder(void);
void print_tree_levelorder(void);

BinarySearchNode* lowestCommonAncestor(BinarySearchNode* root,
                                       BinarySearchNode* p,
                                       BinarySearchNode* q);



#endif /* BinarySearchTree_h */
