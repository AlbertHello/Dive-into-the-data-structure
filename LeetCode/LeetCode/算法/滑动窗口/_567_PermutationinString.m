//
//  _567_PermutationinString.m
//  LeetCode
//
//  Created by Albert on 2021/1/1.
//

#import "_567_PermutationinString.h"

@implementation _567_PermutationinString


/**
 567. 字符串的排列
 难度 中等
 https://leetcode-cn.com/problems/permutation-in-string/
 给定两个字符串 s1 和 s2，写一个函数来判断 s2 是否包含 s1 的排列。
 换句话说，第一个字符串的排列之一是第二个字符串的子串。
 示例1:
 输入: s1 = "ab" s2 = "eidbaooo"
 输出: True
 解释: s2 包含 s1 的排列之一 ("ba").
 示例2:
 输入: s1= "ab" s2 = "eidboaoo"
 输出: False
 注意：
 输入的字符串只包含小写字母
 两个字符串的长度都在 [1, 10,000] 之间
 */

/**
 这种题目，是明显的滑动窗口算法，相当给你一个 S 和一个 T，请问你 S 中是否存在一个子串，包含 T 中所有字符且不包含其他字符？
 首先，先复制粘贴 [ 76. 最小覆盖子串 ] 的算法框架代码，然后明确刚才提出的 4 个问题，即可写出这道题的答案
 
 对于这道题的解法代码，基本上和最小覆盖子串一模一样，只需要改变两个地方：
 1、本题移动 left 缩小窗口的时机是窗口大小大于 t.size() 时，应为排列嘛，显然长度应该是一样的。
 2、当发现 valid == need.size() 时，就说明窗口中就是一个合法的排列，所以立即返回 true。
 至于如何处理窗口的扩大和缩小，和最小覆盖子串完全相同。
 */
-(BOOL)checkInclusion:(NSString *)source target:(NSString *)target{
    
    // 统计target中每个字符的个数
    NSMutableDictionary<NSString*,NSNumber*> *needMap=[NSMutableDictionary dictionary];
    // 统计[left, right)组成的窗口中满足target要求的
    // windowMap 不是窗口，[left, right)才是窗口，
    NSMutableDictionary<NSString*,NSNumber*>*windowMap=[NSMutableDictionary dictionary];

    // 统计target中每个字符的个数
    for (int i=0; i<target.length; i++) {
        NSString *key=[NSString stringWithFormat:@"%c",[target characterAtIndex:i]];
        int v = needMap[key].intValue;
        [needMap setObject:@(v+1) forKey:key];
    }
    NSLog(@"needMap: %@",needMap);
    int left = 0, right = 0;
    int valid = 0;
    // 记录最小覆盖子串的起始索引及长度
    int start = 0, len = INT_MAX;
    while (right < source.length) {
        // c 是将移入窗口的字符
        NSString *c=[source substringWithRange:NSMakeRange(right, 1)];
        // 窗口右侧扩大,继续扩大窗口[left, right)
        right++;
        // 进行窗口内数据的一系列更新
        if ([needMap.allKeys containsObject:c]) {
            int v = windowMap[c].intValue;
            [windowMap setObject:@(v+1) forKey:c];
            if (windowMap[c].intValue == needMap[c].intValue) valid++;
        }
        // 判断左侧窗口是否要收缩
        // 因为只能窗口的大小[left right)大于等于目标字符串的长度就可以考虑收缩了
        // 因为目标字符串无论如何全排列，长度是一定的，那么必须在s中找到一个等长的子串才能匹配
        // 所以只要大于等于就可以收缩窗口判断了
        while (right - left >= target.length) {
            NSLog(@"windowMap: %@",windowMap);
            // 在这里判断是否找到了合法的子串
            if (valid == needMap.count) return YES;
            NSLog(@"start: %d, len: %d",start,len);
            // d 是将移出窗口的字符
            NSString *d = [source substringWithRange:NSMakeRange(left, 1)];
            // 窗口左边收紧，开始缩小窗口[left, right)
            left++;
            if ([needMap.allKeys containsObject:d]) {
                if (windowMap[d].intValue == needMap[d].intValue) valid--;
                int v = windowMap[d].intValue;
                [windowMap setObject:@(v-1) forKey:d];
            }
        }
    }
    return NO;
}
@end
