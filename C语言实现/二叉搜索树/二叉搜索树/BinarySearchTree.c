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
//前序遍历
void print_preorder(BinarySearchNode *node);
//中序遍历
void print_inorder(BinarySearchNode *node);
//后序遍历
void print_backorder(BinarySearchNode *node);

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
    BinarySearchNode *parent_node=root;
    BinarySearchNode *son_node=parent_node;
    int cmp=0;
    while (son_node!=NULL) {
        cmp=compare(son_node->data, ele);
        if (cmp<0) {
            //右子树
            parent_node=son_node;
            son_node=parent_node->right;
        }else if (cmp>0){
            //左子树
            parent_node=son_node;
            son_node=parent_node->left;
        }else{
            //相等
            printf("重复添加了：%d",ele);
            return;
        }
    }
    
    BinarySearchNode *new_node=(BinarySearchNode *)malloc(sizeof(BinarySearchNode));
    new_node->data=ele;
    new_node->left=NULL;
    new_node->right=NULL;
    if (cmp<0) {
        parent_node->right=new_node;
    }else{
        parent_node->left=new_node;
    }
    parent_node->parent=parent_node;
    count++;
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
int compare(int current, int new){
    return current-new;//返回负数放右侧，返回正数放左侧。返回0直接替换。
}
void print_tree_preorder(void){
    printf("***前序遍历如下：***\n");
    print_preorder(root);
}
void print_tree_inorder(void){
    printf("***中序遍历如下：***\n");
    print_inorder(root);
}
void print_tree_backorder(void){
    printf("***后序遍历如下：***\n");
    print_backorder(root);
}
void print_preorder(BinarySearchNode *node){
    if (node==NULL) return;
    printf("%d\n",node->data);
    print_preorder(node->left);
    print_preorder(node->right);
}
void print_inorder(BinarySearchNode *node){
    if (node==NULL) return;
    print_inorder(node->left);
    printf("%d\n",node->data);
    print_inorder(node->right);
}
void print_backorder(BinarySearchNode *node){
    if (node==NULL) return;
    print_backorder(node->left);
    print_backorder(node->right);
    printf("%d\n",node->data);
}
