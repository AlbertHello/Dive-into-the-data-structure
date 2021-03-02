//
//  BiniaryTree.cpp
//  C++ Algorithm
//
//  Created by 58 on 2021/1/21.
//

#include "BiniaryTree.hpp"
#include <stack>
#include <iostream>
using namespace std;

namespace BiniaryTree {

class BTNode{
public:
    int val;
    BTNode *left;
    BTNode *right;
    BTNode *parent;
    BTNode(int val):val(val),left(nullptr),right(nullptr),parent(nullptr){};
    ~BTNode(){};
    bool isLeaf(){
        return ((this->left == nullptr) && (this->right==nullptr));
    }
};

void tree_preorder(BTNode *root){
    if (root == nullptr) return;
    //用栈实现。主要是判断一个节点是否有右节点，有则先把右节点入栈，再把左节点入栈
    stack<BTNode *> stk;
    //根节点入栈
    stk.push(root);
    while (stk.size() != 0) {
        //栈顶元素出栈
        BTNode * node = stk.top();
        stk.pop();
        // 访问node节点
        cout<< node->val << endl;
        if (node->right != nullptr) { // 先判断右节点
            //把右节点入栈，出栈时肯定晚于左节点
            stk.push(node->right);
        }
        if (node->left != nullptr) { // 先判断左节点
            //再把左节点入栈，出栈时肯定早于右节点
            stk.push(node->left);
        }
    }
}
void tree_midorder(BTNode *root){
    if (root == nullptr) {
        return;
    }
    BTNode *node=root;
    stack<BTNode *> stk;
    while (true) {
        if (node) {
            stk.push(node);
            node=node->left;
        }else if (stk.size() == 0){
            break;
        }else{
            BTNode *top_node=stk.top();
            stk.pop();
            cout << top_node->val << endl;
            node=top_node->right;
        }
    }
}
void tree_postorder(BTNode *root){
    if (root == nullptr) {
        return;
    }
    BTNode *pre=nullptr;
    stack<BTNode *> stk;
    stk.push(root);
    while (stk.size() != 0) {
        BTNode *top_node=stk.top();
        if (top_node->isLeaf() || (pre != nullptr && pre->parent==top_node)) {
            pre=top_node;
            stk.pop();
            cout << pre->val << endl; // visit
        }else{
            if (top_node->right != nullptr) {
                stk.push(top_node->right);
            }
            if (top_node->left != nullptr) {
                stk.push(top_node->left);
            }
        }
    }
}


void Solution::BiniaryTreeTest(void){
    BTNode *root=new BTNode(1);
    BTNode *left=new BTNode(2);
    root->left=left;
    BTNode *right=new BTNode(3);
    root->right=right;
    BTNode *right1=new BTNode(4);
    right->right=right1;
    BTNode *right2=new BTNode(5);
    right1->right=right2;
    
//    tree_preorder(root); // pre
//    tree_midorder(root); // mid
    
    left->parent=root;
    right->parent=root;
    right1->parent=right;
    right2->parent=right1;
    tree_postorder(root); // post
    
    delete root;
    delete left;
    delete right;
    delete right1;
    delete right2;
}

}
