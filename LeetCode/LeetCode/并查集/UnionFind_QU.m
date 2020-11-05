//
//  UnionFind_QU.m
//  LeetCode
//
//  Created by 58 on 2020/11/5.
//

#import "UnionFind_QU.h"

//Quick Union
@implementation UnionFind_QU


/**
 find操作查找的永远都是根结点，根结点指向的是自己
 
 API isConnected 和 union 中的复杂度都是 find 函数造成的， 所以说它们的
 复杂度和 find ⼀样。
 find 主要功能就是从某个节点向上遍历到树根， 其时间复杂度就是树的⾼
 度。 我们可能习惯性地认为树的⾼度就是 logN ， 但这并不⼀定。 logN 的
 ⾼度只存在于平衡⼆叉树， 对于⼀般的树可能出现极端不平衡的情况， 使得
 「树」 ⼏乎退化成「链表」 ， 树的⾼度最坏情况下可能变成 N
 
 */
- (int)_find:(int)val{
    if ([self rangeCheck:val]) {
        //一直找到根结点
        while (val != [self.parents[val] intValue]) {
            val=[self.parents[val] intValue];
        }
        return val;
    }
    return -1;
}
//则让其中的（任意） ⼀个节点的根节点接到另⼀个节点的根节点上
//这样， 如果节点 p 和 q 连通的话， 它们⼀定拥有相同的根节点
//我们⼀开始就是简单粗暴的把 p 所在的树接到 q 所在的树的根节点下⾯，那么这⾥就可能出现「头重脚轻」
//的不平衡状况
//所以还可以优化
- (void)_unionItem1:(int)v1 item2:(int)v2{
    // 俩根结点
    int p1=[self _find:v1];
    int p2=[self _find:v2];
    if (p2==p1) return;
    //如果俩根节点不是同一个，则代表不在一个结合或者没有连通
    self.parents[p1]=@(p2);//就把v1的根节点变成v2的根结点
}
@end
