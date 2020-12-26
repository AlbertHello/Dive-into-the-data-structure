//
//  _179_Largest_Number.m
//  LeetCode
//
//  Created by 58 on 2020/11/11.
//

#import "_179_Largest_Number.h"

@implementation _179_Largest_Number


/**
 179. 最大数
 难度 中等
 https://leetcode-cn.com/problems/largest-number/
 给定一组非负整数 nums，重新排列它们每位数字的顺序使之组成一个最大的整数
 注意：输出结果可能非常大，所以你需要返回一个字符串而不是整数。

 示例 1：

 输入：nums = [10,2]
 输出："210"
 示例 2：

 输入：nums = [3,30,34,5,9]
 输出："9534330"
 示例 3：

 输入：nums = [1]
 输出："1"
 示例 4：

 输入：nums = [10]
 输出："10"
  

 提示：

 1 <= nums.length <= 100
 0 <= nums[i] <= 109
 
 
 */
// 主要是 a+b 和 b+a 两个字符串比较大小
-(NSString *)largestNumber:(NSArray *)nums{
    // 数字转字符串
    NSMutableArray *strArr=[NSMutableArray array];
    for (int i = 0; i < nums.count; i++) {
        NSNumber *num=nums[i];
        [strArr addObject: num.stringValue];
    }
    
    //冒泡排序
    //从后往前排序比较a和b两个字符串
    //a+b 和 b+a 两个字符串比较大小
    int len=(int)strArr.count;
    for (int i=0; i< len; i++) {
        for (int j=len-1; j>i; j--) {
            NSMutableString *str1=[NSMutableString string];
            NSMutableString *str2=[NSMutableString string];
            
            [str1 appendString:strArr[j-1]];
            [str1 appendString:strArr[j]];
            
            [str2 appendString:strArr[j]];
            [str2 appendString:strArr[j-1]];
            
            if (str1.intValue<str2.intValue) {
                NSString *temp=strArr[j];
                strArr[j]=strArr[j-1];
                strArr[j-1]=temp;
            }
        }
    }
    //如果第一个是0，那么后面的肯定都是0
    if ([strArr[0] isEqual:@"0"]) {
        return @"0";
    }
    //用一个字符串穿起来
    NSMutableString *final=[NSMutableString string];
    for (NSString *str in strArr) {
        [final appendString:str];
    }
    return final;
}
@end
