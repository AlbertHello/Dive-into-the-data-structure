//
//  BinarySearchTree.c
//  二叉搜索树
//
//  Created by 王启正 on 2019/9/17.
//  Copyright © 2019 58. All rights reserved.
//

#include "BinarySearchTree.h"

static int count=0;//节点个数
BinarySearchNode *root=NULL;//根节点

void add(int ele){
    if (!root) {
        root = (BinarySearchNode *)malloc(sizeof(BinarySearchNode));
        root->data=ele;
        root->parent=NULL;
        root->left=NULL;
        root->right=NULL;
        count++;
        return;
    }
    
}
void delete_ele(int ele){
    
}
void clear(void){
    
}
bool contains(int ele){
    return 0;
}





int size(void){
    return count;
}
bool is_empty(void){
    return count==0;
}
