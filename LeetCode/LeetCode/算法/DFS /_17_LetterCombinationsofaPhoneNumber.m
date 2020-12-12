//
//  _17_LetterCombinationsofaPhoneNumber.m
//  LeetCode
//
//  Created by 58 on 2020/12/7.
//

#import "_17_LetterCombinationsofaPhoneNumber.h"

@interface _17_LetterCombinationsofaPhoneNumber ()

@property(nonatomic,strong)NSMutableArray *res;
@property(nonatomic,strong)NSMutableArray *lettersArray;

@end



@implementation _17_LetterCombinationsofaPhoneNumber


/**
 17. 电话号码的字母组合
 https://leetcode-cn.com/problems/letter-combinations-of-a-phone-number/
 难度 中等
 给定一个仅包含数字 2-9 的字符串，返回所有它能表示的字母组合。
 给出数字到字母的映射如下（与电话按键相同）。注意 1 不对应任何字母。
 示例:

 输入："23"
 输出：["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
 说明:
 尽管上面的答案是按字典序排列的，但是你可以任意选择答案输出的顺序。
 */


-(instancetype)init{
    if (self=[super init]) {
        self.res=[NSMutableArray array];
//        self.lettersArray=@[ @[@"a", @"b", @"c"],
//                             @[@"d", @"e", @"f"],
//                             @[@"g", @"h", @"i"],
//                             @[@"j", @"a", @"a"],
//                             @[@"a", @"a", @"a"],
//                             @[@"a", @"a", @"a"],
//                             @[@"a", @"a", @"a"],
//                             @[@"a", @"a", @"a"],
//        ];
    }
    return self;
    
}



@end
