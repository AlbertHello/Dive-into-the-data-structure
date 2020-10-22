//
//  3_LongestSubstringWithoutRepeatingCharacters.m
//  LeetCode
//
//  Created by 58 on 2020/10/22.
//

#import "3_LongestSubstringWithoutRepeatingCharacters.h"
/**
 3. 无重复字符的最长子串
 给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度。

 示例 1:

 输入: "abcabcbb"
 输出: 3
 解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
 示例 2:

 输入: "bbbbb"
 输出: 1
 解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。
 示例 3:

 输入: "pwwkew"
 输出: 3
 解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
      请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。
 */
@implementation __LongestSubstringWithoutRepeatingCharacters

//滑动窗口思想
/*
 这道题主要用到思路是：滑动窗口

 什么是滑动窗口？

 其实就是一个队列,比如例题中的 abcabcbb，进入这个队列（窗口）为 abc 满足题目要求，当再进入 a，队列变成了 abca，这时候不满足要求。所以，我们要移动这个队列！

 如何移动？

 我们只要把队列的左边的元素移出就行了，直到满足题目要求！

 一直维持这样的队列，找出队列出现最长的长度时候，求出解！

 时间复杂度：O(n)
 */
-(NSUInteger)lengthOfLongestSubstring:(NSString *)str{
    if (str==nil) {
        return 0;
    }
    //创建一个队列，这里用数组表示
    NSMutableArray *queue=[NSMutableArray array];
//  队列里面的元素的下标，这个元素与将要加入的新元素重复
    NSUInteger left=0;
//    长度
    NSUInteger length=0;
    for (int i=0; i<str.length; i++) {
        char charact=[str characterAtIndex:i];
        NSString *s=[NSString stringWithFormat:@"%c",charact];
        if ([queue containsObject:s]) {
            left=[queue indexOfObject:s];
            for (int j=0; j<=left; j++) {
//                从这个下标开始前面的元素全部出队
                [queue removeObjectAtIndex:0];
            }
//            从不重复的这个元素开始，下标又是0了
            left=0;
        }
        [queue addObject:s];
//        计算长度的最大值
        length=((queue.count-left)>length)?(queue.count-left):length;
    }
    return length;
}



@end
