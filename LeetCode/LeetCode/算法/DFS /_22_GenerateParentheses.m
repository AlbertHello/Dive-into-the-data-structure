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

 https://leetcode-cn.com/problems/generate-parentheses/
 
 */
/**
 * Note: The returned array must be malloced, assume caller calls free().
 */

-(NSArray<NSString *>*)generateParenthesis_OC:(int)n{
    NSMutableArray *list=[NSMutableArray array];
    if (n < 0) return list;
    NSMutableString *string=[NSMutableString string];
    [self dfs:0 left:n right:n str:string array:list];
    return list;
}
-(void)dfs:(int)idx
      left:(int)leftRemain
     right:(int)rightRemain
       str:(NSMutableString *)string
     array:(NSMutableArray<NSString *> *)array{
    if (idx == string.length) {
        [array addObject:[NSString stringWithString:string]];
        return;
    }
    // 枚举这一层所有可能的选择
    // 选择一种可能之后，进入下一层搜索
    // 什么情况可以选择左括号？左括号的数量 > 0
    // 选择左括号，然后进入下一层搜索
    if (leftRemain > 0) {
        [string appendString:@"("];
        [self dfs:idx+1 left:leftRemain-1 right:rightRemain str:string array:array];
    }
    // 当左括号、右括号的数量一样时，只能选择左括号
    // 什么情况可以选择右括号？(右括号的数量 > 0) && (右括号的数量 != 左括号的数量)
    // 选择右括号，然后进入下一层搜索
    if (rightRemain > 0 && leftRemain != rightRemain) {
        [string appendString:@")"];
        [self dfs:idx+1 left:leftRemain right:rightRemain-1 str:string array:array];
    }
}

@end
