//
//  _111_MinimumDepthofBinaryTree.m
//  LeetCode
//
//  Created by Albert on 2021/1/3.
//

#import "_111_MinimumDepthofBinaryTree.h"
#import "MyBTNode.h"
#import "MyQueue.h"

@implementation _111_MinimumDepthofBinaryTree


/**
 111. 二叉树的最小深度 ¥
 难度 简单
 https://leetcode-cn.com/problems/minimum-depth-of-binary-tree/
 给定一个二叉树，找出其最小深度。
 最小深度是从根节点到最近叶子节点的最短路径上的节点数量。
 说明：叶子节点是指没有子节点的节点。
 示例 1：
 输入：root = [3,9,20,null,null,15,7]
 输出：2
 示例 2：
 输入：root = [2,null,3,null,4,null,5,null,6]
 输出：5
 */
/**
 BFS 的核心思想应该不难理解的，就是把一些问题抽象成图，从一个点开始，向四周开始扩散。一般来说，我们写 BFS 算法都是用「队列」这种数据结构，每次将一个节点周围的所有节点加入队列。
 DFS 算法就是回溯算法。
 BFS 相对 DFS 的最主要的区别是：BFS 找到的路径一定是最短的，但代价就是空间复杂度比 DFS 大很多，至于为什么，我们后面介绍了框架就很容易看出来了。
 先举例一下 BFS 出现的常见场景好吧，问题的本质就是让你在一幅「图」中找到从起点 start 到终点 target 的最近距离，这个例子听起来很枯燥，但是 BFS 算法问题其实都是在干这个事儿，
 
 */

// 记住下面这个框架就 OK 了：
// 计算从起点 start 到终点 target 的最近距离
//int BFS(Node start, Node target) {
//    Queue<Node> q; // 核心数据结构
//    Set<Node> visited; // 避免走回头路
//
//    q.offer(start); // 将起点加入队列
//    visited.add(start);
//    int step = 0; // 记录扩散的步数
//
//    while (q not empty) {
//        int sz = q.size();
//        // 将当前队列中的所有节点向四周扩散
//        for (int i = 0; i < sz; i++) {
//            Node cur = q.poll();
//            // 划重点：这里判断是否到达终点
//            if (cur is target)
//                return step;
//            // 将 cur 的相邻节点加入队列
//            for (Node x : cur.adj())
//                if (x not in visited) {
//                    q.offer(x);
//                    visited.add(x);
//                }
//        }
//        // 划重点：更新步数在这里
//        step++;
//    }
//}
//队列 q 就不说了，BFS 的核心数据结构；cur.adj() 泛指 cur 相邻的节点，比如说二维数组中，cur 上下左右四面的位置就是相邻节点；visited 的主要作用是防止走回头路，大部分时候都是必须的，但是像一般的二叉树结构，没有子节点到父节点的指针，不会走回头路就不需要 visited



int minDepth(MyBTNode* root) {
    if (root == NULL) return 0;
    
    // 队列
    MyQueue *q=[[MyQueue alloc]init];
    [q enqueue_obj:root];
    
    // root 本身就是一层，depth 初始化为 1
    int depth = 1;
    while (!q.isEmpty) {
        NSUInteger sz = q.size;
        /* 将当前队列中的所有节点向四周扩散 */
        for (int i = 0; i < sz; i++) {
            MyBTNode *cur=(MyBTNode *)q.dequeue_obj;
            // 判断是否到达终点
            if (cur.left == NULL && cur.right == NULL){
                // 叶子结点
                return depth;
            }
            // 将 cur 的相邻节点加入队列
            if (cur.left != NULL){
                [q enqueue_obj:cur.left];
            }
            if (cur.right != NULL){
                [q enqueue_obj:cur.right];
            }
        }
        // 这里增加步数。到这里，队列中的所有全部走了一步。
        depth++;
    }
    return depth;
}
@end
