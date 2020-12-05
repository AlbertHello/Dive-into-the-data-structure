//
//  5_LongestPalindromicSubstring.c
//  链表
//
//  Created by 58 on 2020/10/14.
//  Copyright © 2020 58. All rights reserved.
//

#include "5_LongestPalindromicSubstring.h"

/*
 5. 最长回文子串
 给定一个字符串 s，找到 s 中最长的回文子串。你可以假设 s 的最大长度为 1000。

 示例 1：

 输入: "babad"
 输出: "bab"
 注意: "aba" 也是一个有效答案。
 示例 2：

 输入: "cbbd"
 输出: "bb"

 Example 3:

 Input: s = "a"
 Output: "a"
 Example 4:

 Input: s = "ac"
 Output: "a"
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/longest-palindromic-substring
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/*从字符串的中间截取n个字符*/

/// 从字符串的中间截取n个字符
/// @param src 源字符串
/// @param length 要截取的长度
/// @param start 要截取的子串的起始位置
char * subString(char *src, int length,int start){
    char *p = src;
    char *dst = (char *)malloc(sizeof(char)*(length+1));
    char *q=dst;
    int len = (int)strlen(src);
    if(length>len) length = len-start;    /*从第m个到最后*/
    if(start<0) start=0;    /*从第一个开始*/
    if(start>len) return NULL;
    p += start;
    while(length--){
        *(dst++) = *(p++);
    }
    *(dst++)='\0'; /*有必要吗？很有必要*/
    return q;
}
/**
 回文串就是正着读和反着读都一样的字符串。回文串的的长度可能是奇数，也可能是偶数，这就添加了回文串问题的难度，解决该类问题的核心是双指针
 寻找回文串的问题核心思想是：从中间开始向两边扩散来判断回文串。 中心扩散法
 
 时间复杂度 O(N^2)，
 空间复杂度 O(1)
 */
// 中心扩散法1
char *palindrome(char *s, int l, int r) {
    // l >= 0 && r < strlen(s) 防止索引越界
    // s[l] == s[r]  左右字符相等就满足时回文串了
    while (l >= 0 && r < strlen(s) && s[l] == s[r]) {
        // 继续向两边展开
        l--; r++;
    }
    // 直到不再满足回文串的条件，就把前一次循环的满足的回文串提取出来
    // r - l -1 是满足的回文串的长度
    // l+1是满足的回文串在原字符串S中的起始位置
    return subString(s, r - l -1, l+1);
}
char * longestPalindrome(char * s){
    char *res=NULL;
    for (int i = 0; i < strlen(s); i++) {
        // 以 s[i] 为中心的最长回文子串，这是处理奇数长度的字符串
        char *s1 = palindrome(s, i, i);
        // 以 s[i] 和 s[i+1] 为中心的最长回文子串 。这是处理偶数长度的字符串
        char *s2 = palindrome(s, i, i + 1);
        //在res, s1, s2中寻找最长的一个
        size_t len_s1=strlen(s1);
        size_t len_s2=strlen(s2);
        char * temp=NULL;
        if (len_s1>len_s2) {
            temp=s1;
            free(s2);
        }else{
            temp=s2;
            free(s1);
        }
        if (!res) {
            res=temp;
        }else{
            res = strlen(res) > strlen(temp) ? res : temp;
        }
    }
    return res;
}
// 中心扩散法2

// 这个方法不再每次都返回字符串，频繁创建字符串也会耗性能。
//这个方法返回的是源字符串S中满足回文条件的子串的起始位置和长度
// length 满足的回文串的长度
// return 返回的是回文串的起始位置
int palindrome2(char *s, int l, int r, int *length) {
    // l >= 0 && r < strlen(s) 防止索引越界
    // s[l] == s[r]  左右字符相等就满足时回文串了
    while (l >= 0 && r < strlen(s) && s[l] == s[r]) {
        // 继续向两边展开
        l--; r++;
    }
    // 直到不再满足回文串的条件，就把前一次循环的满足的回文串提取出来
    // r - l -1 是满足的回文串的长度
    // l+1是满足的回文串在原字符串S中的起始位置
    *length = r - l - 1;
    return l + 1;
}
// 优化
char * longestPalindrome2(char * s){
    int max = 0;
    int start = 0;
    for (int i = 0; i < strlen(s); i++) {
        // 以 s[i] 为中心的最长回文子串，这是处理奇数长度的字符串
        int length1 = 0;
        int start1 = palindrome2(s, i, i, &length1);
        // 以 s[i] 和 s[i+1] 为中心的最长回文子串 。这是处理偶数长度的字符串
        int length2 = 0;
        int start2 = palindrome2(s, i, i + 1,&length2);
        //在max, length1, length2中寻找最长的一个
        int len = (length1 > length2)?length1:length2;
        max = max > len ? max : len;
        start = (length1 > length2)?start1:start2;
    }
    if (max > 0) {
        char *res = (char *)malloc(sizeof(char)*(max + 1));
        memcpy(res, s, (max + 1));
        return res;
    }else{
        return NULL;
    }
}

/**
 这个方法是判断一个字符串是不是回文串
 而判断一个字符串是不是回文串就简单很多，不需要考虑奇偶情况，只需要「双指针技巧」，
 从两端向中间逼近即可：
 因为回文串是对称的，所以正着读和倒着读应该是一样的。
 */
bool isPalindrome(char *s) {
    size_t left = 0, right = strlen(s) - 1;
    while (left < right) {
        if (s[left] != s[right]) return false;
        left++; right--;
    }
    return true;
}
void longestPalindromeTest(void){
    char *src="baab";
//    bool isP=isPalindrome(src);
    char *dest=longestPalindrome2(src);
    printf("%s\n",dest);
}
