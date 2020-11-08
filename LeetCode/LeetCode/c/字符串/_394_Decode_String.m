//
//  _394_Decode_String.m
//  LeetCode
//
//  Created by 58 on 2020/11/6.
//

#import "_394_Decode_String.h"

@interface _394_Decode_String ()

@end


@implementation _394_Decode_String


-(instancetype)init{
    if (self=[super init]) {
        
    }
    return self;
}

/**
 394. 字符串解码
 给定一个经过编码的字符串，返回它解码后的字符串。
 编码规则为: k[encoded_string]，表示其中方括号内部的 encoded_string 正好重复 k 次。注意 k 保证为正整数。
 你可以认为输入字符串总是有效的；输入字符串中没有额外的空格，且输入的方括号总是符合格式要求的。

 此外，你可以认为原始数据不包含数字，所有的数字只表示重复的次数 k ，例如不会出现像 3a 或 2[4] 的输入。

  

 示例 1：

 输入：s = "3[a]2[bc]"
 输出："aaabcbc"
 示例 2：

 输入：s = "3[a2[c]]"
 输出："accaccacc"
 示例 3：

 输入：s = "2[abc]3[cd]ef"
 输出："abcabccdcdcdef"
 示例 4：

 输入：s = "abc3[cd]xyz"
 输出："abccdcdcdxyz"
 
 //链接：https://leetcode-cn.com/problems/decode-string/solution/
 */

//复杂度分析
//时间复杂度：记解码后得出的字符串长度为S，除了遍历一次原字符串s，
//我们还需要将解码后的字符串中的每个字符都入栈，并最终拼接进答案中，故渐进时间复杂度为O(S+∣s∣)，即O(S)。
//空间复杂度：记解码后得出的字符串长度为S，这里用栈维护 TOKEN，
//栈的总大小最终与S 相同，故渐进空间复杂度为O(S)。


-(NSString *)decodeString:(NSString *)s{
    int ptr = 0;
    NSMutableArray *statck=[NSMutableArray array];
    while (ptr < s.length) {
        char cur = [s characterAtIndex:ptr];
        if ([self isDigit:cur]) { // 数字入栈
            NSString *digits=[NSString stringWithFormat:@"%c",cur];
            [statck addObject:digits];
        } else if ([self isLetter:cur] || cur == '[') { // 字母或左括号入栈
            NSString *letter=[NSString stringWithFormat:@"%c",cur];
            [statck addObject:letter];
        } else { // 碰见右括号出站
            //存放出战的字母字符
            NSMutableArray *sub=[NSMutableArray array];
            NSString *last=statck.lastObject;
            //栈里面是abc，出战是：cba，倒叙
            while (![last isEqualToString:@"["]) {
                [sub addObject:last];
                [statck removeLastObject];
                last=statck.lastObject;
            }
            // 左括号出栈
            [statck removeLastObject];
            // 此时栈顶为当前 sub 对应的字符串应该出现的次数
            NSString *num_str = statck.lastObject;
            int repTime = num_str.intValue;
            NSMutableString  *t = [NSMutableString string];
            // 构造字符串
            while (repTime-- > 0) {
                NSUInteger strLen=sub.count;
                for (NSInteger i = strLen-1; i>=0; i--) {
                    //倒叙拼接
                    [t appendString:sub[i]];
                }
            }
            //删除这个数字
            [statck removeLastObject];
            // 将构造好的字符串入栈
            [statck addObject:t];
        }
        ptr++;
    }
    NSMutableString  *final = [NSMutableString string];
    //最后处理不是数字开头的情况： abc3[a2[c]]
    while (statck.count != 0) {
        NSString *temp=statck.lastObject;
        [final insertString:temp atIndex:0];
        [statck removeLastObject];
    }
    return (NSString *)final;
}

//递归
-(NSString *)decodeString2:(NSString *)str{
    NSMutableString *res=[NSMutableString string];
    NSMutableString *temp=[NSMutableString string];
    int times=0;
    NSInteger index=0;
    while (index<str.length) {
        char cur = [str characterAtIndex:index];
        if ([self isDigit:cur]) {
            times = cur - '0';
        }else if (cur == '['){ // 遇见[就递归
            //++index表示从中括号中间的第一个字母开始，比如[abc]从a开始
            NSString *sub=[str substringFromIndex:++index];
            //返回的temp就是中括号之间的字母组成的字符串
            temp=(NSMutableString *)[self decodeString2:sub];
            while(times-->0){
                //重复追加n次。n就是[之前的数字
                [res appendString:temp];
            }
            times = 0;//num置零
            //中括号之间有个字母index要同时++
            index+=sub.length;
        }else if (cur == ']'){ // 遇见]就递归结束
            //比如[abc]，遇见]就break，表示中括号之间的所有字母统计完了。
            break;
        }else{
            // 这个仅仅统计中括号之间的字母，
            NSString *s=[NSString stringWithFormat:@"%c",cur];
            [res appendString:s];
        }
        index++;
    }
    return res;
}

-(BOOL)isLetter:(char )c{
    if ( (c >= 65 && c <= 90) || (c >= 97 && c <= 122)) {
        return YES;
    }
    return NO;
}
-(BOOL)isDigit:(char )c{
    return (c >= 48 && c <= 57);
}
+(void)decodeStringTest{
    _394_Decode_String *ins=[[_394_Decode_String alloc]init];
    NSString *str=[ins decodeString2:@"abc3[a2[c]]"]; //abcaccaccacc
//    NSString *str=[ins decodeString:@"abc3[a2[c]]"];
    NSLog(@"str = %@",str);
}
@end
