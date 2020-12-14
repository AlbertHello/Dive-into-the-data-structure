//
//  28_Implement_strStr.m
//  LeetCode
//
//  Created by 58 on 2020/11/2.
//

#import "28_Implement_strStr.h"

@implementation _8_Implement_strStr


/**
 28. 实现 strStr()函数
 链接：https://leetcode-cn.com/problems/implement-strstr
 给定一个 haystack 字符串和一个 needle 字符串，在 haystack 字符串中找出 needle 字符串出现的第一个位置 (从0开始)。如果不存在，则返回  -1。

 示例 1:

 输入: haystack = "hello", needle = "ll"
 输出: 2
 示例 2:

 输入: haystack = "aaaaa", needle = "bba"
 输出: -1
 说明:

 Example 3:

 Input: haystack = "", needle = ""
 Output: 0
  

 Constraints:

 0 <= haystack.length, needle.length <= 5 * 104
 haystack and needle consist of only lower-case English characters.
 
 当 needle 是空字符串时，我们应当返回什么值呢？这是一个在面试中很好的问题。

 对于本题而言，当 needle 是空字符串时我们应当返回 0 。这与C语言的 strstr() 以及 Java的 indexOf() 定义相符。
 
 */

+(NSInteger)locateSubstring:(NSString *)string sub:(NSString *)subStr{
    if (subStr.length<1) return 0;
    NSRange rang=[string rangeOfString:subStr];
    if (rang.location == NSNotFound) {
        return -1;
    }else{
        return rang.location;
    }
}
//方法1
//逐一比对
//时间复杂度：O(l(n-l))
//空间复杂度: O(1)
int strStr(char * haystack, char * needle){
    size_t n=strlen(haystack);
    size_t l=strlen(needle);
    if (l==0) return 0;
    if (l>n) return -1;
    bool flag=true;
    for (int i=0; i<=n-l; i++) { // O(n-l)
        int cur=i;
        flag=true;
        for (int j=0;j<l; j++) {  //O(l)
            if (needle[j] != haystack[cur++]){
                flag=false;
                break;
            }
        }
        if (flag) return i;
    }
    return -1;
}
/**
 解法2 双指针法
 上一个方法的缺陷是会将 haystack 所有长度为 L 的子串都与 needle 字符串比较，实际上是不需要这么做的。

 首先，只有子串的第一个字符跟 needle 字符串第一个字符相同的时候才需要比较，
 然后，可以一个字符一个字符比较，一旦不匹配了就立刻终止。
 比较到最后一位时发现不匹配，这时候开始回溯。需要注意的是，pn 指针是移动到 pn = pn - curr_len + 1 的位置，而 不是 pn = pn - curr_len 的位置。
 
 算法：
 移动 pn 指针，直到 pn 所指向位置的字符与 needle 字符串第一个字符相等。
 通过 pn，pL，curr_len 计算匹配长度。
 如果完全匹配（即 curr_len == L），返回匹配子串的起始坐标（即 pn - L）。
 如果不完全匹配，回溯。使 pn = pn - curr_len + 1， pL = 0， curr_len = 0。
 
 时间复杂度：最坏时间复杂度为O((N−L)L)，最优时间复杂度为O(N)。
 空间复杂度：O(1)。
 
 */
int strStr2(char *haystack, char *needle) {
    
    int n = (int)strlen(haystack);
    int L = (int)strlen(needle);
    if (L == 0) return 0;
    if (L > n) return -1;
    
    int pn = 0;
    while (pn < n - L + 1) { // needl最坏情况下就是haystack的最后L个字符正好匹配
        // 在haystack找到第一个匹配needle的位置
        while (pn < n - L + 1 && haystack[pn] != needle[0]) ++pn;
        
        // 匹配
        int currLen = 0, pL = 0;
        while (pL < L && pn < n && haystack[pn] == needle[pL]){
            ++pn;
            ++pL;
            ++currLen;
        }
        // 找到了
        if (currLen == L) return pn - L;
        // 回退到第一个相同字符处的下一个
        pn = pn - currLen + 1;
    }
    return -1;
}



+ (void)locateSubstringTest{
//    NSLog(@"%ld",(long)[self locateSubstring:@"aaaaa" sub:@"baa"]);
    char *string="a";
    char *sub="a";
    printf("%d\n",strStr(string, sub));
}








@end
