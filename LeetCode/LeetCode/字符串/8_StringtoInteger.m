//
//  8StringtoInteger.m
//  LeetCode
//
//  Created by 58 on 2020/10/22.
//

#import "8_StringtoInteger.h"

@interface _StringtoInteger ()

@property(nonatomic,strong)NSDictionary *map;
@property(nonatomic,assign)long res;
@property(nonatomic,assign)int sign;
@property(nonatomic,copy)NSString *state;

@end

@implementation _StringtoInteger
/**
 8. 字符串转换整数 (atoi)
 https://leetcode-cn.com/problems/string-to-integer-atoi/
 难度 中等
 请你来实现一个 atoi 函数，使其能将字符串转换成整数。
 首先，该函数会根据需要丢弃无用的开头空格字符，直到寻找到第一个非空格的字符为止。接下来的转化规则如下：
 如果第一个非空字符为正或者负号时，则将该符号与之后面尽可能多的连续数字字符组合起来，形成一个有符号整数。
 假如第一个非空字符是数字，则直接将其与之后连续的数字字符组合起来，形成一个整数。
 该字符串在有效的整数部分之后也可能会存在多余的字符，那么这些字符可以被忽略，它们对函数不应该造成影响。
 注意：假如该字符串中的第一个非空格字符不是一个有效整数字符、字符串为空或字符串仅包含空白字符时，则你的函数不需要进行转换，即无法进行有效转换。
 在任何情况下，若函数不能进行有效的转换时，请返回 0 。
 提示：
 本题中的空白字符只包括空格字符 ' ' 。
 假设我们的环境只能存储 32 位大小的有符号整数，那么其数值范围为 [−2^31,  2^31 − 1]。
 如果数值超过这个范围，请返回  INT_MAX (2^31 − 1) 或 INT_MIN (−2^31) 。

 示例 1:
 输入: "42"
 输出: 42
 示例 2:
 输入: "   -42"
 输出: -42
 解释: 第一个非空白字符为 '-', 它是一个负号。
      我们尽可能将负号与后面所有连续出现的数字组合起来，最后得到 -42 。
 示例 3:
 输入: "4193 with words"
 输出: 4193
 解释: 转换截止于数字 '3' ，因为它的下一个字符不为数字。
 示例 4:
 输入: "words and 987"
 输出: 0
 解释: 第一个非空字符是 'w', 但它不是数字或正、负号。
      因此无法执行有效的转换。
 示例 5:
 输入: "-91283472332"
 输出: -2147483648
 解释: 数字 "-91283472332" 超过 32 位有符号整数范围。
      因此返回 INT_MIN (−231)
 */

//1、解题思路:

/*
 1、因为不需要读入空格，因此无论左边有多少空格直接无视，直接移动str指针到第一个不是空格的位置上。
 2、然后判断符号位，此时存在三种情况：'+'、'-'和无正负号，因此选择使用switch，当没有符号的时候不需要任何操作，当是-号时使flag = -1。因为无论是'+'还是'-'最后都要使str移动到下一个位置，因此不需要break。
 3、排除完不是数字的情况后，逐个将数字字符转化为整数，同时判断溢出。写在循环内部的判断可以使循环次数限制在int的最大位数内
 */

int myAtoi(char* str) {
    long ret = 0; // 用long存储
    int flag = 1;//默认正数
    //去除空格，str指针走到不是空格的那个字符处
    for (; *str == 32; str++); // 空格的ASCII码是32
    //判断符号位
    switch (*str) {
        case 45: // 负号的ASCII码是45
            flag = -1;//不设置break，因为正负号都得str++
        case 43: // 正号的ASCII码是43
            str++; // 如果是正号就忽视，走到下一个字符处
    }
    //正负号之后再排除非数字的情况 0～9的ASCII码是48 ～ 57
    if (*str < 48 || *str>57) return 0;
    
    while (*str >= 48 && *str <= 57) {//连续的数字
        ret = ret * 10 + (*str - 48); //数字字符转数字
        //判断溢出
        if ((int)ret != ret) { // 如果溢出了(int)ret != ret
            return (flag == 1) ? (INT_MAX) : (INT_MIN);
        }
        str++;
    }
    ret *= flag; // 添上负号
    return (int)ret; // 转成int
}


// 2. 确定有限状态机（deterministic finite automaton, DFA）

//             ' '      +/-      number       other

//  start      start    signed   in_number    end
//  signed     end      end      in_number    end
//  in_number  end      end      in_number    end
//  end        end      end      end          end
/*
 
 思路

 字符串处理的题目往往涉及复杂的流程以及条件情况，如果直接上手写程序，一不小心就会写出极其臃肿的代码。

 因此，为了有条理地分析每个输入字符的处理方法，我们可以使用自动机这个概念：

 我们的程序在每个时刻有一个状态 s，每次从序列中输入一个字符 c，并根据字符 c 转移到下一个状态s'。这样，我们只需要建立一个覆盖所有情况的从 s 与 c 映射到 s' 的表格即可解决题目中的问题。
 
 另外自动机也需要记录当前已经输入的数字，只要在 s' 为 in_number时，更新我们输入的数字，即可最终得到输入的数字
 
 复杂度分析
 时间复杂度：O(n)，其中n 为字符串的长度。我们只需要依次处理所有的字符，处理每个字符需要的时间为O(1)。
 空间复杂度：O(1)，自动机的状态只需要常数空间存储。
 */

-(instancetype)init{
    if (self=[super init]) {
        //start对应空格，signed对应正负号，in_number对应数字，其他情况对应end，
        self.map=@{
            @"start"    :@[@"start",@"signed",@"in_number",@"end"],
            @"signed"   :@[@"end",  @"end",   @"in_number",@"end"],
            @"in_number":@[@"end",  @"end",   @"in_number",@"end"],
            @"end"      :@[@"end",  @"end",   @"end",      @"end"]
        };
        self.res=0;
        self.state=@"start";
        self.sign=1;//默认正数
    }
    return self;
}
-(void)get:(char)c{
    //get_col: 获取c对应的下标
    //数组根据下标取出当前c的状态state
    self.state = [self.map[self.state] objectAtIndex:[self get_col:c]];
    //如果c是数字
    if ([@"in_number" isEqualToString:self.state]) {
        //数字字符转数字: '0'的ASCII是48
        self.res = self.res * 10 + c - '0';
        //判断是否溢出
        //如果是正数就拿res和最大的整数(2147483647)比较，取较小值
        //如果是负数就拿res和最小的整数(-2147483648)的绝对值(2147483648)比较，取较小值
        //res在计算过程中永远是个正数
        self.res = self.sign == 1 ? MIN(self.res, (long) INT_MAX) : MIN(self.res, -(long) INT_MIN);
    } else if ([@"signed" isEqualToString:self.state]) {
        self.sign = c == '+' ? 1 : -1;
    }
}
-(int)get_col:(char)c{
    if (c == ' ') {
        return 0;
    }
    if (c == '+' || c == '-') {
        return 1;
    }
    if (c>=48 && c<=57) {
        return 2;
    }
    return 3;
}
-(int)myAtoi:(NSString *)str{
    if (str == nil) {
        return 0;
    }
    for (int i = 0; i < str.length; ++i) {
        char c=[str characterAtIndex:i];
        [self get:c];
    }
    
    //最后用int强制转换，切掉long类型多处来的高32位，剩下低32位
    return (int) (self.sign * self.res);
}


+(void)myAtoiTest{
    _StringtoInteger *sss=[[self alloc] init];
    NSLog(@"%d",[sss myAtoi:@"-2147483647"]);
    
}




@end
