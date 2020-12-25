//
//  _01_09_String_Rotation_LCCI.m
//  LeetCode
//
//  Created by 58 on 2020/12/3.
//

#import "_01_09_String_Rotation_LCCI.h"

@implementation _01_09_String_Rotation_LCCI

/**
 面试题 01.09. 字符串轮转
 难度 简单
 https://leetcode-cn.com/problems/string-rotation-lcci/
 字符串轮转。给定两个字符串s1和s2，请编写代码检查s2是否为s1旋转而成（比如，waterbottle是erbottlewat旋转后的字符串）。
 示例1:
  输入：s1 = "waterbottle", s2 = "erbottlewat"
  输出：True
 示例2:
  输入：s1 = "aa", s2 = "aba"
  输出：False
 提示：
 字符串长度在[0, 100000]范围内。
 说明:
 你能只调用一次检查子串的方法吗？
 
 */

/**
 思路：
 其实很简单，只要把两个原字符串拼接起来，其他的轮转字符串都是该拼接字符串的子串
 比如：weak
 拼接后：weakweak
 那么四个轮转子串是：weak eakw、akwe、kwea
 */

-(BOOL)isFlipedString:(NSString *)s1 s2:(NSString *)s2{
    if (s1 == nil || s2 == nil) return NO;
    if (s1.length != s2.length) return NO; // 首先俩串的长度肯得一样。
    
    NSMutableString *str1=[NSMutableString stringWithString:s1];
    [str1 appendString:str1];
    return [str1 containsString:s2]; // 这里还可以考虑使用KMP算法
}


bool isFlipedString(char* s1, char* s2){
    if (s1 == NULL || s2 == NULL) return false;
    if (strlen(s1) != strlen(s2)) return false;
    
    char *long_s1 = (char *)malloc( strlen(s1) * 2 + 1);
    strcat(long_s1, s1);
    strcat(long_s1, s1);
    
    return strstr(long_s1, s2) != NULL;
}



@end
