//
//  UnionFind_QU_Rank_Path_Halving.m
//  LeetCode
//
//  Created by 58 on 2020/11/6.
//

#import "UnionFind_QU_Rank_Path_Halving.h"


//  路径减半：使路径上每隔一个节点就指向其祖父节点（parent的parent）
@implementation UnionFind_QU_Rank_Path_Halving


/**
 比如：
 7
 ⬆️
 7
 ⬆️
 6
 ⬆️
 5
 ⬆️
 4
 ⬆️
 3
 ⬆️
 2
 ⬆️
 1
 路径分裂后：
          7
        ↗️ ↖️
        6     5
          ↗️ ↖️
          4     3
            ↗️ ↖️
            2     1
 */
- (int)_find:(int)val{
    if ([self rangeCheck:val]) {
        
        while ([self.parents[val] intValue] != val) {
            
        }
        if ([self.parents[val] intValue] != val) {
            //父节点
            int p=[self.parents[val] intValue];
            //父节点的父节点也就是val的爷爷节点当作val的父节点
            self.parents[val] = self.parents[p];
            //跳过一个节点，再开始
            val=[self.parents[val] intValue];
        }
    }
    return val;
}


/**
 维基百科：
 使用路径压缩、分裂或减半 + 基于rank或者size的优化
 ✓ 可以确保每个操作的均摊时间复杂度为 O(𝛼 (𝑛)) ， α(𝑛) < 5
 
 个人建议的搭配:
 ✓ Quick Union
 ✓ 基于 rank 的优化
 ✓ Path Halving 或 Path Spliting
 
 
 之前的使用都是基于整型数据，如果其他自定义类型也想使用并查集呢？
 方案一：通过一些方法将自定义类型转为整型后使用并查集（比如生成哈希值）
 方案二：使用链表+映射（Map）
 
 */

@end
