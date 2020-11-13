//
//  UnionFind_QU_Rank_Path.m
//  LeetCode
//
//  Created by 58 on 2020/11/5.
//

#import "UnionFind_QU_Rank_Path.h"

// 路径压缩
//在find时使路径上的所有节点都指向根节点，从而降低树的高度
@implementation UnionFind_QU_Rank_Path


// 基于Rank的路径压缩优化
// 实质就是把每条链上的节点都拆分成单个，并直接指向根结点。路径压缩的确是大，但实现成本较高
//还有两种优化方法
//路径分裂 路径
- (int)_find:(int)val{
    if ([self rangeCheck:val]) {
        if ([self.parents[val] intValue] != val) {
            //如果要找的这个val的父结点不是自己，那么就把val的父节点设置为根结点
            //递归调用的发方式一级一级的网上寻找，一直把这条链上的所有节点的父节点都设置为根结点
            //得以压缩路径。比如：1->2->3->4->5->5，很显然5是根结点
            //如果find（1）那么一级一级的网上翻，直到找到5->5为止
            //那么再一级一级的往下退：4->5, 3->5, 2->5, 1->5
            //最终路径被压缩，下次寻找时时间复杂度回降到O（1）
            self.parents[val] = @([self _find:[self.parents[val] intValue]]);
        }
    }
    return [self.parents[val] intValue];
}


@end
