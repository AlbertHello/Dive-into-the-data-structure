//
//  _78_Subsets.m
//  LeetCode
//
//  Created by Albert on 2021/1/3.
//

#import "_78_Subsets.h"

@implementation _78_Subsets

/**
 78. 子集
 难度 中等
 https://leetcode-cn.com/problems/subsets/
 给你一个整数数组 nums ，返回该数组所有可能的子集（幂集）。解集不能包含重复的子集。
 示例 1：

 输入：nums = [1,2,3]
 输出：[[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]
 示例 2：

 输入：nums = [0]
 输出：[[],[0]]
 */

/**
 看下回溯算法模版：
 result = []
 def backtrack(路径, 选择列表):
     if 满足结束条件:
         result.add(路径)
         return
     for 选择 in 选择列表:
         做选择
         backtrack(路径, 选择列表)
         撤销选择
 */

NSMutableArray<NSMutableArray<NSNumber *> *> *res=NULL;

-(NSMutableArray<NSMutableArray<NSNumber *> *> * )subsets:(NSArray *)nums{
    
    // 结果
    res = [NSMutableArray array];
    // 记录走过的路径
    NSMutableArray<NSNumber *> *track=[NSMutableArray array];
    [self backtrack:nums start:0 track:track];
    return res;
}

//时间复杂度：O(n×2^n)。一共2^n个状态，每种状态需要O(n) 的时间来构造子集。
//空间复杂度：O(n)。临时数组t 的空间代价是O(n)，递归时栈空间的代价为O(n)。
-(void)backtrack:(NSArray *)nums
           start:(int)start
           track:(NSMutableArray<NSNumber *> *)track{
    
    //O(n)
    NSMutableArray *arr=[NSMutableArray arrayWithArray:track];
    [res addObject:arr];
    
    // 注意 i 从 start 开始递增 // 共2^n次
    for (int i = start; i < nums.count; i++) {
        // 做选择
        [track addObject:nums[i]];
        // 回溯
        [self backtrack:nums start:i+1 track:track];
        // 撤销选择
        [track removeLastObject];
    }
}
/**
 可以看见，对 res 的更新是一个前序遍历，也就是说，res 就是树上的所有节点：
            [ ]
           /   |   \
          /     |     \
        [ 1 ]  [ 2 ]  [ 3 ]
       /     \       \
      /        \        \
   [ 1, 2]   [ 1, 3 ]   [ 2 , 3]
     /
    /
 [1, 2, 3]
 
 */
@end
