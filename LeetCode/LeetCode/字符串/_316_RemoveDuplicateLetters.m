//
//  _316_RemoveDuplicateLetters.m
//  LeetCode
//
//  Created by Albert on 2021/1/2.
//

#import "_316_RemoveDuplicateLetters.h"
#import "MyStack.h"
@implementation _316_RemoveDuplicateLetters

/**
 316. 去除重复字母
 难度 中等
 https://leetcode-cn.com/problems/remove-duplicate-letters/
 给你一个字符串 s ，请你去除字符串中重复的字母，使得每个字母只出现一次。需保证 返回结果的字典序最小（要求不能打乱其他字符的相对位置）。
 示例 1：
 输入：s = "bcabc"
 输出："abc"
 示例 2：

 输入：s = "cbacdcbc"
 输出："acdb"
 
 提示：

 1 <= s.length <= 104
 s 由小写英文字母组成
 */

/**
 题目的要求总结出来有三点：
 要求一、要去重。
 要求二、去重字符串中的字符顺序不能打乱s中字符出现的相对顺序。
 要求三、在所有符合上一条要求的去重字符串中，字典序最小的作为最终结果。
 上述三条要求中，要求三可能有点难理解，举个例子。
 比如说输入字符串s = "babc"，去重且符合相对位置的字符串有两个，分别是"bac"和"abc"，
 但是我们的算法得返回"abc"，因为它的字典序更小.
 按理说，如果我们想要有序的结果，那就得对原字符串排序对吧，但是排序后就不能保证符合s中字符出现顺序了，这似乎是矛盾的。
 我们先暂时忽略要求三，用「栈」来实现一下要求一和要求二
 */
-(NSString *)removeDuplicateLetters:(NSString *)source{
    // 存放去重的结果
    NSMutableArray<NSString *> *stk=[NSMutableArray array];
    // 布尔数组初始值为 false，记录栈中是否存在某个字符
    // 输入字符均为 ASCII 字符，所以大小 256 够用了
    // boolean[] inStack = new boolean[256];
    // 在这里我用字典来代替
    NSMutableDictionary<NSString*,NSNumber*> *in_map=[NSMutableDictionary dictionary];
    for (int i=0; i<source.length; i++) {
        NSString *c=[source substringWithRange:NSMakeRange(i, 1)];
        
        // 如果字符 c 存在栈中，直接跳过
        if (in_map[c].intValue == 1) continue;
        // 若不存在，则插入栈顶并标记为存在
        [stk addObject:c];
        [in_map setObject:@(1) forKey:c];
    }
    NSMutableString *sb=[NSMutableString string];
    
    // 从栈顶依次取出，注意此时顺序是相反的。
    while (stk.count != 0 ) {
        NSString *str=stk.lastObject;
        [stk removeLastObject];
        [sb appendString:str];
    }
    // 栈中元素插入顺序是反的，需要 reverse 一下
    // 至此，得到的字符串只是满足条件一和条件二的。不满足条件三，接着往下看
    return [self reverseString2:sb];
}

/**
 要求一、通过inStack这个布尔数组做到栈stk中不存在重复元素。

 要求二、我们顺序遍历字符串s，通过「栈」这种顺序结构的 push/pop 操作记录结果字符串，保证了字符出现的顺序和s中出现的顺序一致。

 这里也可以想到为什么要用「栈」这种数据结构，因为先进后出的结构允许我们立即操作刚插入的字符，如果用「队列」的话肯定是做不到的。

 要求三、我们用类似单调栈的思路，配合计数器count不断 pop 掉不符合最小字典序的字符，保证了最终得到的结果字典序最小。

 当然，由于栈的结构特点，我们最后需要把栈中元素取出后再反转一次才是最终结果。
 
 时间 空间 复杂度都是 O(N)。
 */

// s = bcac
-(NSString *)removeDuplicateLetters2:(NSString *)source{
    
    // 维护一个计数器记录字符串中字符的数量
    // 因为输入为 ASCII 字符，大小 256 够用了
    // int[] count = new int[256];
    // 此处使用字典
    // 计数器count，当字典序较小的字符试图「挤掉」栈顶元素的时候，
    // 在count中检查栈顶元素是否是唯一的，只有当后面还存在栈顶元素的时候才能挤掉，否则不能挤掉。
    NSMutableDictionary<NSString*,NSNumber*> *count=[NSMutableDictionary dictionary];
    for (int i = 0; i < source.length; i++) { //O(n)
        NSString *c=[source substringWithRange:NSMakeRange(i, 1)];
        int v = count[c].intValue;
        [count setObject:@(v+1) forKey:c];
    }
    NSLog(@"count = %@",count);
    // 存放去重的结果
    NSMutableArray<NSString *> *stk=[NSMutableArray array];
    // 布尔数组初始值为 false，记录栈中是否存在某个字符
    // 输入字符均为 ASCII 字符，所以大小 256 够用了
    // boolean[] inStack = new boolean[256];
    // 在这里我用字典来代替
    NSMutableDictionary<NSString*,NSNumber*> *in_map=[NSMutableDictionary dictionary];
    for (int i=0; i<source.length; i++) { // O(n)
        NSString *c=[source substringWithRange:NSMakeRange(i, 1)];
        
        // 每遍历过一个字符，都将对应的计数减一
        int v = count[c].intValue;
        [count setObject:@(v-1) forKey:c];
        
        // 如果字符 c 存在栈中，直接跳过
        if (in_map[c].intValue == 1) continue;
        
        // 插入之前，和之前的元素比较一下大小
        // 如果字典序比前面的小，pop 前面的元素
        while (stk.count != 0 && stk.lastObject > c) {
            // 若之后不存在栈顶元素了，则停止 pop
            if (count[stk.lastObject].intValue == 0) {
                break;
            }
            // 弹出栈顶元素，并把该元素标记为不在栈中
            NSString *str=stk.lastObject;
            [stk removeLastObject];
            [in_map setObject:@(0) forKey:str];
        }
        
        // 若不存在，则插入栈顶并标记为存在
        [stk addObject:c];
        [in_map setObject:@(1) forKey:c];
    }
    NSLog(@"stk = %@",stk);
    NSLog(@"in_map = %@",in_map);
    NSMutableString *sb=[NSMutableString string];
    
    // 从栈顶依次取出，注意此时顺序是相反的。
    while (stk.count != 0 ) {
        NSString *str=stk.lastObject;
        [stk removeLastObject];
        [sb appendString:str];
    }
    // 栈中元素插入顺序是反的，需要 reverse 一下
    // 至此，得到的字符串只是满足条件一和条件二的。不满足条件三
    return [self reverseString2:sb]; // O(n)
}
+(void)removeDuplicateLettersTest{
    _316_RemoveDuplicateLetters *RD=[[_316_RemoveDuplicateLetters alloc]init];
    NSLog(@"去重：%@",[RD removeDuplicateLetters2:@"bcac"]);
}




















// OC 字符串翻转问题
// 解法1 把OC字符串转成C字符串
- (NSString *)reverseString1:(NSString *)str {
    NSUInteger length = [str lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    char s[length+1];   // NSString 转 C 字符串时，长度要加1，因为 C 字符串是以 '\0' 结尾的
    bzero(s, sizeof(s));
    [str getCString:s maxLength:sizeof(s) encoding:NSUTF8StringEncoding];

    size_t start = 0;
    size_t end = start + sizeof(s) - 2;  // 末位是字符串结束标志，这里取倒数第2位字符串作为 end
    while (start < end) {
        char ch = s[start];
        s[start++] = s[end];
        s[end--] = ch;
    }
    NSString *result = [[NSString alloc] initWithCString:s encoding:NSUTF8StringEncoding];
    return result;
}
// 解法2 依然利用OC字符串
- (NSString *)reverseString2:(NSString *)str{
  NSMutableString *s = [NSMutableString string];
  for (NSUInteger i=str.length; i>0; i--) {
    [s appendString:[str substringWithRange:NSMakeRange(i-1, 1)]];
  }
  return s;
}



@end
