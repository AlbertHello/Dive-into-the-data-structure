//
//  _821_Shortest_Distance_to_a_Character.m
//  LeetCode
//
//  Created by 58 on 2020/11/3.
//

#import "_821_Shortest_Distance_to_a_Character.h"

@implementation _821_Shortest_Distance_to_a_Character

/**
 821. 字符的最短距离
 难度 简单
 链接：https://leetcode-cn.com/problems/shortest-distance-to-a-character/
 给定一个字符串 S 和一个字符 C。返回一个代表字符串 S 中每个字符到字符串 S 中的字符 C 的最短距离的数组。

 示例 1:

 输入: S = "loveleetcode", C = 'e'
 输出: [3, 2, 1, 0, 1, 0, 0, 1, 2, 2, 1, 0]
 说明:

 字符串 S 的长度范围为 [1, 10000]。
 C 是一个单字符，且保证是字符串 S 里的字符。
 S 和 C 中的所有字母均为小写字母。
 */

/**
 方法 1：最小数组

 想法
 对于每个字符 S[i]，试图找出距离向左或者向右下一个字符 C 的距离。答案就是这两个值的较小值。
 算法

 从左向右遍历，记录上一个字符 C 出现的位置 prev，那么答案就是 i - prev。

 从右向左遍历，记录上一个字符 C 出现的位置 prev，那么答案就是 prev - i。

 这两个值取最小就是答案
 */
int* shortestToChar(char*S, char C) {
    size_t N = strlen(S);
    int *ans=(int *)malloc(sizeof(int)*N);
    //就是取一个特别小的值供i来减它，虽然会得到比较大的结果，但不要紧，下一轮遍历就会筛选出小的值
    //这个值的绝对值要大于字符串的长度
    int prev = INT_MIN >> 1;
//    int prev = -2 * N;//写成这个值也行
    for (int i = 0; i < N; ++i) {
        //找到这个字符，就正好把索引赋值给prev，接下来再i - prev就不会那么大了。
        if (S[i] == C) prev = i;
        ans[i] = i - prev;//计算字符串中每个字符对应的i - prev
    }
    //这个不是算法的一部分，就是为了打印出第一次遍历结果
    for (int i=0; i< N; i++){
        // 打印出第一次便利结果如下：
        // 1073741824 1073741825 1073741826 0 1 0 0 1 2 3 4 0
        printf("%d ",ans[i]);
    }
    printf("\n");
    //如上同理
    prev = INT_MAX >> 1;
    for (int i = (int)N-1; i >= 0; --i) {
        if (S[i] == C) prev = i;
        //取小的
        ans[i] = (ans[i] < (prev - i)) ? ans[i]:(prev-i);
    }
    return ans;
}
+(void)shortestToCharTest{
    char *array="loveleetcode";
    size_t len =strlen(array);
    int *res=shortestToChar(array, 'e');
    for (int i=0; i< len; i++) {
        printf("%d ",res[i]);
    }
    printf("\n");
}
@end
