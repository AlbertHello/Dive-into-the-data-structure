//
//  _43_MultiplyStrings.m
//  LeetCode
//
//  Created by Albert on 2021/1/3.
//

#import "_43_MultiplyStrings.h"

@implementation _43_MultiplyStrings

/**
 43. 字符串相乘 $$
 难度
 中等

 540
 
 给定两个以字符串形式表示的非负整数 num1 和 num2，返回 num1 和 num2 的乘积，它们的乘积也表示为字符串形式。

 示例 1:

 输入: num1 = "2", num2 = "3"
 输出: "6"
 示例 2:

 输入: num1 = "123", num2 = "456"
 输出: "56088"
 说明：

 num1 和 num2 的长度小于110。
 num1 和 num2 只包含数字 0-9。
 num1 和 num2 均不以零开头，除非是数字 0 本身。
 不能使用任何标准库的大数类型（比如 BigInteger）或直接将输入转换为整数来处理。
 */

/**
 整个计算过程大概是这样，有两个指针 i，j 在 num1 和 num2 上游走，计算乘积，同时将乘积叠加到 res 的正确位置：
 如何将乘积叠加到 res 的正确位置，或者说，如何通过 i，j 计算 res 的对应索引呢？
 其实，细心观察之后就发现，num1[i] 和 num2[j] 的乘积对应的就是 res[i+j] 和 res[i+j+1] 这两个位置。
 */
-(NSString *)multiply:(NSString *)num1 num2:(NSString *)num2{
    int m = (int)num1.length;
    int n = (int)num2.length;
    NSMutableArray<NSNumber *>*res=[NSMutableArray arrayWithCapacity:m+n];
    for (int i=0; i< m+n; i++) {
        [res addObject:@(0)];
    }
    // 从个位数开始逐位相乘
    for (int i = m - 1; i >= 0; i--){
        for (int j = n - 1; j >= 0; j--) {
            
            char num1_c=[num1 characterAtIndex:i];
            char num2_c=[num2 characterAtIndex:j];
            
            int mul = (num1_c- '0') * (num2_c - '0');
            // 乘积在 res 对应的索引位置
            int p1 = i + j, p2 = i + j + 1;
            // 叠加到 res 上
            int sum = mul + res[p2].intValue;
            res[p2] = @(sum % 10);
            res[p1] = @(res[p1].intValue + sum / 10);
        }
    }
    // 结果前缀可能存的 0（未使用的位）
    int i = 0;
    while (i < (m+n) && res[i].intValue == 0) i++; // 将i移到不是0的位置
    NSMutableString *str=[NSMutableString string];
    for (; i < res.count; i++){
        [str appendString:res[i].stringValue];
    }
    return str;
}

+(void)multiplyTest{
    _43_MultiplyStrings *sss=[[_43_MultiplyStrings alloc]init];
    NSLog(@"%@",[sss multiply:@"123" num2:@"456"]);
}



char *multiply(char *num1, char *num2){
    
    int m = (int)strlen(num1), n = (int)strlen(num2);
    // 结果最多为 m + n 位数
    int *res=(int *)malloc(sizeof(int)*(m+n));
    memset(res, 0, sizeof(int)*(m+n));
    // 从个位数开始逐位相乘
    for (int i = m - 1; i >= 0; i--){
        for (int j = n - 1; j >= 0; j--) {
            int mul = (num1[i] - '0') * (num2[j] - '0');
            // 乘积在 res 对应的索引位置
            int p1 = i + j, p2 = i + j + 1;
            // 叠加到 res 上
            int sum = mul + res[p2];
            res[p2] = sum % 10;
            res[p1] += sum / 10;
        }
    }
    // 结果前缀可能存的 0（未使用的位）
    int i = 0;
    while (i < (m+n) && res[i] == 0) i++; // 将i移到不是0的位置
    // 将计算结果转化成字符串
    char *str=(char *)malloc(sizeof(char)*(m+n-i+1));
    for (int j=0; i < m+n; i++,j++){
        str[j]=res[i] + '0';
    }
    str[m+n-i] = '\0';
    free(res);
    return str;
}

@end
