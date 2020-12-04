//
//  _242_Valid_Anagram.m
//  LeetCode
//
//  Created by 58 on 2020/12/4.
//

#import "_242_Valid_Anagram.h"

@implementation _242_Valid_Anagram

/**
 242. 有效的字母异位词
 https://leetcode-cn.com/problems/valid-anagram/
 给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的字母异位词。
 示例 1:
 输入: s = "anagram", t = "nagaram"
 输出: true
 示例 2:

 输入: s = "rat", t = "car"
 输出: false
 说明:
 你可以假设字符串只包含小写字母。

 进阶:
 如果输入字符串包含 unicode 字符怎么办？你能否调整你的解法来应对这种情况？
 
 Unicode 是为了解决传统字符编码的局限性而产生的方案，它为每个语言中的字符规定了一个唯一的二进制编码。而
 Unicode 中可能存在一个字符对应多个字节的问题，为了让计算机知道多少字节表示一个字符，面向传输的编码方式的
 UTF−8 和UTF−16 也随之诞生逐渐广泛使用
 
 */

bool isAnagram(char *s, char *t) {
    if (s == NULL || t == NULL) return false;
    size_t s_len=strlen(s);
    size_t t_len=strlen(t);
    if (s_len != t_len) return false; // 俩串长度不一致肯定不符合
    int counts[26]={0}; // 存储每个字母出现的次数。i 就是对应 a ~ z
    for (int i=0; i<s_len; i++) {
        counts[s[i] - 'a']++; // s[i] - 'a'
    }
    for (int i=0; i<t_len; i++) {
        // 只要出现一个 counts[t[i] - 'a'] < 0 说明s串中就没有 t[i] 这个字符
        if (--counts[t[i] - 'a'] < 0) return false;
    }
    return true;
}
@end
