//
//  _438_Find_All_Anagrams_in_a_String.m
//  LeetCode
//
//  Created by Albert on 2021/1/1.
//

#import "_438_Find_All_Anagrams_in_a_String.h"

@implementation _438_Find_All_Anagrams_in_a_String

/**
 438. 找到字符串中所有字母异位词
 难度 中等
 https://leetcode-cn.com/problems/find-all-anagrams-in-a-string/
 给定一个字符串 s 和一个非空字符串 p，找到 s 中所有是 p 的字母异位词的子串，返回这些子串的起始索引。
 字符串只包含小写英文字母，并且字符串 s 和 p 的长度都不超过 20100。
 说明：
 字母异位词指字母相同，但排列不同的字符串。
 不考虑答案输出的顺序。
 示例 1:
 输入:
 s: "cbaebabacd" p: "abc"
 输出:
 [0, 6]

 解释:
 起始索引等于 0 的子串是 "cba", 它是 "abc" 的字母异位词。
 起始索引等于 6 的子串是 "bac", 它是 "abc" 的字母异位词。
  示例 2:

 输入:
 s: "abab" p: "ab"

 输出:
 [0, 1, 2]

 解释:
 起始索引等于 0 的子串是 "ab", 它是 "ab" 的字母异位词。
 起始索引等于 1 的子串是 "ba", 它是 "ab" 的字母异位词。
 起始索引等于 2 的子串是 "ab", 它是 "ab" 的字母异位词。
 */

/**
 这个所谓的字母异位词，不就是排列吗，搞个高端的说法就能糊弄人了吗？相当于，输入一个串 S，一个串 T，找到 S 中所有 T 的排列，返回它们的起始索引。
 
 直接默写一下框架，明确刚才讲的 4 个问题，即可秒杀这道题,
 跟寻找[ 字符串的排列 ] 一样，只是找到一个合法异位词（排列）之后将起始索引加入 res 即可。
 */

-(NSMutableArray *)findAnagrams:(NSString *)source target:(NSString *)target{
    NSMutableDictionary<NSString*,NSNumber*> *needMap=[NSMutableDictionary dictionary];
    // windowMap 不是窗口，[left, right)才是窗口，
    NSMutableDictionary<NSString*,NSNumber*>*windowMap=[NSMutableDictionary dictionary];
    // 记录结果
    NSMutableArray *res=[NSMutableArray array];
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
            // 当窗口符合条件时，把起始索引加入 res
            if (valid == needMap.count) [res addObject:@(left)];
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
    return res;
}
@end
