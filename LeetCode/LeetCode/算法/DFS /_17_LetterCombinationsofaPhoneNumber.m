//
//  _17_LetterCombinationsofaPhoneNumber.m
//  LeetCode
//
//  Created by 58 on 2020/12/7.
//

#import "_17_LetterCombinationsofaPhoneNumber.h"

@interface _17_LetterCombinationsofaPhoneNumber ()

@property(nonatomic,strong)NSMutableArray *res;
@property(nonatomic,strong)NSArray *lettersArray;

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
        self.lettersArray=@[ @[@"a", @"b", @"c"],
                             @[@"d", @"e", @"f"],
                             @[@"g", @"h", @"i"],
                             @[@"j", @"k", @"l"],
                             @[@"m", @"n", @"o"],
                             @[@"p", @"q", @"r",@"s"],
                             @[@"t", @"u", @"v"],
                             @[@"w", @"x", @"y",@"r"]
        ];
    }
    return self;
    
}
-(NSArray *)letterCombinations:(NSString *)digits {
    if (digits == nil) return nil;
    NSMutableArray *final=[NSMutableArray array];
    NSMutableArray *track=[NSMutableArray array];
    [self dfs:0 str:digits track:track final:final];
    return final;
}
-(void)dfs:(NSInteger)index str:(NSString *)digits track:(NSMutableArray *)track final:(NSMutableArray *)final{
    if (index == digits.length) {
        NSMutableString *finalStr=[NSMutableString string];
        for (NSString *letter in track) {
            [finalStr appendString:letter];
        }
        [final addObject:finalStr];
        return;
    }
    NSString *numChar = [NSString stringWithFormat:@"%c",[digits characterAtIndex:index]];
    NSInteger num = numChar.intValue;
    NSMutableArray *lettrs =  self.lettersArray[num - 2];
    for (NSString *letter in lettrs) {
        [track addObject:letter]; // 添加选择
        [self dfs:index + 1 str:digits track:track final:final]; // 进入下一层
        [track removeLastObject]; // 撤销选择
    }
}
+(void)letterCombinationsTest{
    _17_LetterCombinationsofaPhoneNumber *letter=[[_17_LetterCombinationsofaPhoneNumber alloc]init];
    NSLog(@"%@",[letter  letterCombinations:@"29"]);
}

@end
