//
//  BiniaryTree.cpp
//  C++ Algorithm
//
//  Created by 58 on 2021/1/21.
//

#include "BiniaryTree.hpp"
#include <stack>
#include <iostream>

namespace BiniaryTree {

class BTNode{
public:
    int val;
    BTNode *left;
    BTNode *right;
    BTNode(int val):val(val),left(nullptr),right(nullptr) {};
    ~BTNode();
};

void tree_preorder_no_recurse(BTNode *root){
    if (root == nullptr) return;
    //用栈实现。主要是判断一个节点是否有右节点，有则先把右节点入栈，再把左节点入栈
    std::stack<BTNode *> stk;
    //根节点入栈
    stk.push(root);
    while (stk.size() != 0) {
        //栈顶元素出栈
        BTNode * node = stk.top();
        stk.pop();
        // 访问node节点
        std::cout<< node->val << std::endl;
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
void Solution::BiniaryTreeTest(void){
    
}

}
