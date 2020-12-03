//
//  _572_Subtree_of_Another_Tree.m
//  LeetCode
//
//  Created by 58 on 2020/12/3.
//

#import "_572_Subtree_of_Another_Tree.h"
#import "MyBTNode.h"


@implementation _572_Subtree_of_Another_Tree

/**
 572. 另一个树的子树
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
 使用前序遍历和后序遍历都可。此题使用后序遍历：
 空节点用#代替，每个节点的遍历后追加一个！方便区分，比如：
 3
/ \
4   5
/ \
1   2  序列化后：#!#!1!#!#!2!4!#!#!5!3!
 把两个树后序序列化，得到连个字符串，然后查找子串
 */
-(BOOL)isSubtree:(MyBTNode *)s littleTree:(MyBTNode *)t{
    NSMutableString *postSerializeStr1 = [NSMutableString string];
    [self postSerialize:s str:postSerializeStr1];
    
    NSMutableString *postSerializeStr2 = [NSMutableString string];
    [self postSerialize:t str:postSerializeStr2];
    
    return [postSerializeStr1 containsString:postSerializeStr2];
}
-(void)postSerialize:(MyBTNode *)node str:(NSMutableString *)str{
    // 后序遍历
    if (node.left) {
        [self postSerialize:node.left str:str];
    }else{
        [str appendString:@"#!"];
    }
    if (node.right) {
        [self postSerialize:node.right str:str];
    }else{
        [str appendString:@"#!"];
    }
    // 处理值 。 典型的后续遍历递归算法
    [str appendString:[NSString stringWithFormat:@"%d!",node.val]];
}


//bool isSubtree(struct TreeNode* s, struct TreeNode* t){
//
//    return true;
//}
//void postSerialize(TreeNode node, StringBuilder sb) {
//        sb.append(node.val).append("!");
//        if (node.left == null) {
//            sb.append("#!");
//        } else {
//            postSerialize(node.left, sb);
//        }
//        if (node.right == null) {
//            sb.append("#!");
//        } else {
//            postSerialize(node.right, sb);
//        }
//    }










@end
