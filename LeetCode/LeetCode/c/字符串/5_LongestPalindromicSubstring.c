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
/// @param n 要截取的长度
/// @param m 要截取的子串的起始位置
char * subString(char *src, int n,int m){
    char *p = src;
    char *dst = (char *)malloc(sizeof(char)*(n+1));
    char *q=dst;
    int len = (int)strlen(src);
    if(n>len) n = len-m;    /*从第m个到最后*/
    if(m<0) m=0;    /*从第一个开始*/
    if(m>len) return NULL;
    p += m;
    while(n--){
        *(dst++) = *(p++);
    }
    *(dst++)='\0'; /*有必要吗？很有必要*/
    return q;
}
/**
 回文串就是正着读和反着读都一样的字符串。回文串的的长度可能是奇数，也可能是偶数，这就添加了回文串问题的难度，解决该类问题的核心是双指针
 寻找回文串的问题核心思想是：从中间开始向两边扩散来判断回文串。
 
 时间复杂度 O(N^2)，
 空间复杂度 O(1)
 */
char *palindrome(char *s, int l, int r) {
    // 防止索引越界
    while (l >= 0 && r < strlen(s) && s[l] == s[r]) {
        // 向两边展开
        l--; r++;
    }
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

void longestPalindromeTest(void){
    char *src="babad";
    char *dest=longestPalindrome(src);
    size_t len = strlen(dest);
    for (size_t i=0; i<len; i++) {
        printf("%c",dest[i]);
    }
    printf("\n");
}
