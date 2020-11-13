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

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/implement-strstr
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
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




+ (void)locateSubstringTest{
//    NSLog(@"%ld",(long)[self locateSubstring:@"aaaaa" sub:@"baa"]);
    char *string="a";
    char *sub="a";
    printf("%d\n",strStr(string, sub));
}








@end
