//
//  1002_Find_Common_Characters.c
//  链表
//
//  Created by 58 on 2020/10/14.
//  Copyright © 2020 58. All rights reserved.
//

#include "1002_Find_Common_Characters.h"

/**
 1002. 查找常用字符
 难度 简单
 链接：https://leetcode-cn.com/problems/find-common-characters
 给定仅有小写字母组成的字符串数组 A，返回列表中的每个字符串中都显示的全部字符（包括重复字符）组成的列表。
 例如，如果一个字符在每个字符串中出现 3 次，但不是 4 次，则需要在最终答案中包含该字符 3 次。

 你可以按任意顺序返回答案。

  

 示例 1：

 输入：["bella","label","roller"]
 输出：["e","l","l"]
 示例 2：

 输入：["cool","lock","cook"]
 输出：["c","o"]
  

 提示：

 1 <= A.length <= 100
 1 <= A[i].length <= 100
 A[i][j] 是小写字母
 */
char** commonChars(char** A, int ASize, int* returnSize) {
    
    int minfreq[26]={0};
    for (int i =0; i<26; i++) {
        minfreq[i]=100;// 设置为一个大值
    }
    int freq[26]={0};
    for (int i = 0; i < ASize; ++i) {
        // 每重新遍历一个字符串时都把频率数组职位空，重新统计该字符串中字符出现的频率
        memset(freq, 0, sizeof(freq));
        //每个字符串的长度
        size_t n = strlen(A[i]);
        for (int j = 0; j < n; ++j) {
            //每个字符-a正好就是freq的下标
            //重复一次freq[k]的值就加1. ++freq[k]，先加1
            //一趟跑下来就知道整个字符串中有没有字母重复，重复了几次
            ++freq[A[i][j] - 'a'];
        }
        for (int j = 0; j < 26; ++j) {
            //每隔字符串中可能相同的字符重复的次数不同
            //所以需要取重复最小次
            minfreq[j] = min(minfreq[j], freq[j]);
        }
    }
    int sum = 0;
    for (int i = 0; i < 26; ++i) {
        //计算重复的这些字母需要占用多大空间，为了下面的创建ans
        sum += minfreq[i];
    }
    char** ans = (char**)malloc(sizeof(char*) * sum);
    *returnSize = 0;
    for (int i = 0; i < 26; ++i) {
        for (int j = 0; j < minfreq[i]; ++j) {
            //每个字符串2两个字节，也就是字符+结束'\0'共两个字节
            ans[*returnSize] = (char *)malloc(sizeof(char) * 2);
            //字符串的第一个字符就是重复的那个字符串
            ans[*returnSize][0] = i + 'a';
            //字符串的第二个字符就是结束符'\0'
            ans[*returnSize][1] = 0;
            //下一个字符串
            (*returnSize)++;
        }
    }
    return ans;
}
