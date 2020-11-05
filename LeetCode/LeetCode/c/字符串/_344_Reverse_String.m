//
//  _344_Reverse_String.m
//  LeetCode
//
//  Created by 58 on 2020/11/5.
//

#import "_344_Reverse_String.h"

@implementation _344_Reverse_String

/**
 344. 反转字符串
 编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组 char[] 的形式给出。

 不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用 O(1) 的额外空间解决这一问题。

 你可以假设数组中的所有字符都是 ASCII 码表中的可打印字符。


 示例 1：

 输入：["h","e","l","l","o"]
 输出：["o","l","l","e","h"]
 示例 2：

 输入：["H","a","n","n","a","h"]
 输出：["h","a","n","n","a","H"]

 */


void swap(char *a, char *b) {
    char t = *a;
    *a = *b;
    *b = t;
}
/**
 双指针问题
 时间复杂度：O(N)，其中N 为字符数组的长度。一共执行了N/2 次的交换。
 空间复杂度：O(1)。只使用了常数空间来存放若干变量。
 
 */
void reverseString(char* s, int sSize){
    int l=0;
    int r=sSize-1;
    //如果len是奇数，则刚好剩下最中间一个字符不用反转，且l小于r
    //如果len是偶数，则最后一次遍历就是最中间两个字符，此时l<r，再l++;r--;刚好l>r,退出循环
    while (l < r) {
        //交换
        swap(&s[l], &s[r]);
        //左指针++
        l++;
        //右指针--
        r--;
    }
}
@end
