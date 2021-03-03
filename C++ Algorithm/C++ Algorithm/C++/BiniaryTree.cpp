//
//  BiniaryTree.cpp
//  C++ Algorithm
//
//  Created by 58 on 2021/1/21.
//

#include "BiniaryTree.hpp"
#include <stack>
#include <iostream>
#include <queue>

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
void tree_levelorder(BTNode *root){
    if (root == nullptr) {
        return;
    }
    queue<BTNode *> que;
    que.push(root);
    while (que.size() != 0) {
        BTNode *front_node=que.front();
        que.pop();
        cout << front_node->val << endl;
        if (front_node->left) {
            que.push(front_node->left);
        }
        if (front_node->right) {
            que.push(front_node->right);
        }
    }
}

int height_of_tree(BTNode *root){
    if (root==nullptr) {
        return 0;
    }
    int height = 0;
    int level_size=1;
    queue<BTNode *> que;
    que.push(root);
    while (que.size() != 0) {
        BTNode *front_node=que.front();
        que.pop();
        level_size--;
        if (front_node->left) {
            que.push(front_node->left);
        }
        if (front_node->right) {
            que.push(front_node->right);
        }
        if (level_size == 0) {
            level_size=static_cast<int>(que.size()) ;
            height++;
        }
    }
    return height;
}

/**
 二叉树的最大深度
 链接：https://leetcode-cn.com/problems/maximum-depth-of-binary-tree/solution
 
 深度优先搜索DFS，递归实现
 时间复杂度：O(n)，其中n 为二叉树节点的个数。每个节点在递归中只被遍历一次。
 空间复杂度：O(height)，其中 height 表示二叉树的高度。递归函数需要栈空间，而栈空间取决于递归的深度，
 因此空间复杂度等价于二叉树的高度。
 */
int maxDepth_1(BTNode *root){
    if (root == nullptr) return 0;
    return max(maxDepth_1(root->left), maxDepth_1(root->right)) + 1;
}
/**
 BFS
 我们也可以用「广度优先搜索」的方法来解决这道题目，但我们需要对其进行一些修改，此时我们广度优先搜索的队列里存放的是「当前层的所有节点」。每次拓展下一层的时候，不同于深度优先搜索的每次只从队列里拿出一个节点，我们需要将队列里的所有节点都拿出来进行拓展，这样能保证每次拓展完的时候队列里存放的是当前层的所有节点，即我们是一层一层地进行拓展，最后我们用一个变量
 ans 来维护拓展的次数，该二叉树的最大深度即为ans。
 
 时间复杂度：O(n)，其中n 为二叉树的节点个数。与方法一同样的分析，每个节点只会被访问一次。
 空间复杂度：此方法空间的消耗取决于队列存储的元素数量，其在最坏情况下会达到O(n)。
 */
int maxDepth_2(BTNode* root) {
    if (root == nullptr) return 0;
    queue<BTNode*> Q;
    Q.push(root);
    int ans = 0;
    while (!Q.empty()) {
        int sz = static_cast<int>(Q.size());
        while (sz > 0) {
            BTNode* node = Q.front(); Q.pop();
            if (node->left) Q.push(node->left);
            if (node->right) Q.push(node->right);
            sz -= 1;
        }
        ans += 1;
    }
    return ans;
}


void Solution::BiniaryTreeTest(void){
    BTNode *root=new BTNode(1);
    BTNode *left=new BTNode(3);
    root->left=left;
    BTNode *right=new BTNode(2);
    root->right=right;
    BTNode *right1=new BTNode(4);
    right->right=right1;
    BTNode *right2=new BTNode(5);
    right1->right=right2;
    
    // pre
//    tree_preorder(root);
    
    // mid
//    tree_midorder(root);
    
    
    // post
//    left->parent=root;
//    right->parent=root;
//    right1->parent=right;
//    right2->parent=right1;
//    tree_postorder(root);
    
    // level
//    tree_levelorder(root);
    
    // height
    cout << height_of_tree(root) << endl;
    
    
    
    delete root;
    delete left;
    delete right;
    delete right1;
    delete right2;
}

}
