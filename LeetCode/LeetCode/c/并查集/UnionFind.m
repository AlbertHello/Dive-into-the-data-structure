//
//  UnionFind.m
//  LeetCode
//
//  Created by 58 on 2020/11/5.
//

#import "UnionFind.h"

@implementation UnionFind

-(instancetype)initWithCapacity:(int)capacity{
    self = [super init];
    if (self) {
        self.parents=[NSMutableArray array];
        self.capacity=capacity;
        for (int i=0; i<capacity; i++) {
            // 初始化
            //每个元素的父节点都是它本身，意味着这些item相互独立，组成一个森林
            //如果让其中某些item产生关联或联通，则需要Union操作
            //构造函数初始化数据结构需要O(N) 的时间和空间复杂度
            self.parents[i]=@(i);
        }
    }
    return self;
}

-(bool)isConnected:(int)v1 item2:(int)v2{
    return ([self _find:v1] == [self _find:v2]);
}

-(BOOL)rangeCheck:(int)v {
    if (v < 0 || v >= self.parents.count) {
        return false;
    }
    return true;
}
@end
