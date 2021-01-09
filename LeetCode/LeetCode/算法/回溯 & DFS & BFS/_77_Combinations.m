//
//  _77_Combinations.m
//  LeetCode
//
//  Created by Albert on 2021/1/3.
//

#import "_77_Combinations.h"

@interface _77_Combinations ()

@property(nonatomic,strong)NSMutableArray<NSMutableArray<NSNumber *> *> *res;

@end

@implementation _77_Combinations

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.res=[NSMutableArray array];
    }
    return self;
}

/**
 77. 组合 $
 难度 中等
 https://leetcode-cn.com/problems/combinations/
 给定两个整数 n 和 k，返回 1 ... n 中所有可能的 k 个数的组合。
 示例:
 输入: n = 4, k = 2
 输出:
 [
   [2,4],
   [3,4],
   [2,3],
   [1,2],
   [1,3],
   [1,4],
 ]
 */



-(NSMutableArray<NSMutableArray<NSNumber *> *> *)combine:(int)n k:(int)k{
    if (k <= 0 || n <= 0) return self.res;
    // 记录走过的路径
    NSMutableArray<NSNumber *> *track=[NSMutableArray array];
    [self backtrack:n k:k start:0 track:track];
    return self.res;
}

/**
 这就是典型的回溯算法，k 限制了树的高度，n 限制了树的宽度，直接套我们以前讲过的回溯算法模板框架就行了：
 backtrack 函数和计算子集的差不多，区别在于，更新 res 的地方是树的底端。
 */
-(void)backtrack:(int)n
               k:(int)k
           start:(int)start
           track:(NSMutableArray<NSNumber *> *)track{
    // 到达树的底部
    if (k == track.count) {
        NSMutableArray *arr=[NSMutableArray arrayWithArray:track]; // O(n)
        [self.res addObject:arr];
        return;
    }
    // 注意 i 从 start 开始递增
    for (int i = start; i <= n; i++) { // O(n)
        // 做选择
        [track addObject:@(i)];
        // 进入下一层
        [self backtrack:n k:k start:i+1 track:track];
        // 撤销选择，回溯
        [track removeLastObject];
    }
}
@end
