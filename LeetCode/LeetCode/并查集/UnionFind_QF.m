//
//  UnionFind_QF.m
//  LeetCode
//
//  Created by 58 on 2020/11/5.
//

#import "UnionFind_QF.h"


//本代码是Quick Find模式，让find的时间复杂度达到O（1）级别
@implementation UnionFind_QF


// find 操作是O（1）
-(int)_find:(int)val{
    if ([self rangeCheck:val]) {
        return [self.parents[val] intValue];
    }
    return -1;
}
//但是union操作是O（n）
-(void)_unionItem1:(int)v1 item2:(int)v2{
    
    int p1 = [self _find:v1];
    int p2 = [self _find:v1];
    if (p1 == p2) return; //如果两个item的父节点都是同一个，那么无需再union
    
    //如果俩item的父节点不是同一个那么就把v1的父节点换成v2的父节点
    //可能以p1为父节点的不止v1一个，需要把所有以p1为父节点的item的父节点都换成p2
    for (int i = 0; i < self.parents.count; i++) {
        if ([self.parents[i] intValue] == p1) {
            self.parents[i] = @(p2);
        }
    }
}

@end
