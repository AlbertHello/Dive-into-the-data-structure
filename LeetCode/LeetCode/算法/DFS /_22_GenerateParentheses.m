//
//  _22_GenerateParentheses.m
//  LeetCode
//
//  Created by 58 on 2020/12/7.
//

#import "_22_GenerateParentheses.h"

@implementation _22_GenerateParentheses
/**
 22. 括号生成
 难度中等
 https://leetcode-cn.com/problems/generate-parentheses/
 数字 n 代表生成括号的对数，请你设计一个函数，用于能够生成所有可能的并且 有效的 括号组合
 示例：

 输入：n = 3
 输出：[
        "((()))",
        "(()())",
        "(())()",
        "()(())",
        "()()()"
      ]

 
 */
/**
 * Note: The returned array must be malloced, assume caller calls free().
 */

+(NSArray<NSString *>*)generateParenthesis_OC:(int)n{
    NSMutableArray *list=[NSMutableArray array];
    if (n < 0) return list;
    NSMutableArray *track=[NSMutableArray array];
    [self dfs:0 left:n right:n strA:track count:n * 2 array:list];
    return list;
}
+(void)dfs:(int)idx
      left:(int)leftRemain
     right:(int)rightRemain
      strA:(NSMutableArray *)stringA
     count:(NSInteger)count
     array:(NSMutableArray<NSString *> *)array{
    if (idx == count) {
        NSMutableString *finalStr=[NSMutableString string];
        for (NSString *str in stringA) {
            [finalStr appendString:str];
        }
        [array addObject:finalStr];
        return;
    }
    // 枚举这一层所有可能的选择
    // 选择一种可能之后，进入下一层搜索
    // 什么情况可以选择左括号？左括号的剩余数量 > 0
    // 选择左括号，然后进入下一层搜索
    if (leftRemain > 0) {
        [stringA addObject:@"("];
        [self dfs:idx+1
             left:leftRemain-1
            right:rightRemain
             strA:stringA
            count:count
            array:array];
        [stringA removeLastObject];
    }
    // 当左括号、右括号的数量一样时，只能选择左括号
    // 什么情况可以选择右括号？(右括号的剩余数量 > 0) && (右括号的剩余数量 != 左括号的剩余数量)
    // 选择右括号，然后进入下一层搜索
    if (rightRemain > 0 && leftRemain != rightRemain) {
        [stringA addObject:@")"];
        [self dfs:idx+1
             left:leftRemain
            right:rightRemain-1
             strA:stringA
            count:count
            array:array];
        [stringA removeLastObject];
    }
}
+(void)generateParenthesis_OC_TEST{
    int n = 3;
    NSLog(@"%@",[self generateParenthesis_OC:n]);
}




@end
