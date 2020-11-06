//
//  UnionFind_QU_Rank_Path_Split.m
//  LeetCode
//
//  Created by 58 on 2020/11/6.
//

#import "UnionFind_QU_Rank_Path_Split.h"

// 路径分裂（Path Spliting）: 使路径上的每个节点都指向其祖父节点（parent的parent）
//路径分裂、路径减半的效率差不多，但都比路径压缩要好
@implementation UnionFind_QU_Rank_Path_Split



/**
 比如：1->2->3->4->5->6->7->7
 路径分裂后：
 1->3->5->7->7
 2->4->6->7->7
 
 */
- (int)_find:(int)val{
    if ([self rangeCheck:val]) {
        if ([self.parents[val] intValue] != val) {
            //父节点
            int p=[self.parents[val] intValue];
            //父节点的父节点也就是val的爷爷节点当作val的父节点
            self.parents[val] = self.parents[p];
            //再从旧父节点开始
            val=p;
        }
    }
    return val;
}

@end
