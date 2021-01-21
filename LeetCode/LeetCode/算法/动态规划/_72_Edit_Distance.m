//
//  _72_Edit_Distance.m
//  LeetCode
//
//  Created by Albert on 2020/12/6.
//

#import "_72_Edit_Distance.h"

@implementation _72_Edit_Distance

/**
 72. 编辑距离 ¥
 给你两个单词 word1 和 word2，请你计算出将 word1 转换成 word2 所使用的最少操作数 。
 你可以对一个单词进行如下三种操作：
 插入一个字符
 删除一个字符
 替换一个字符

 示例 1：
 输入：word1 = "horse", word2 = "ros"
 输出：3
 解释：
 horse -> rorse (将 'h' 替换为 'r')
 rorse -> rose (删除 'r')
 rose -> ros (删除 'e')
 示例 2：

 输入：word1 = "intention", word2 = "execution"
 输出：5
 解释：
 intention -> inention (删除 't')
 inention -> enention (将 'i' 替换为 'e')
 enention -> exention (将 'n' 替换为 'x')
 exention -> exection (将 'n' 替换为 'c')
 exection -> execution (插入 'u')
 提示：

 0 <= word1.length, word2.length <= 500
 word1 和 word2 由小写英文字母组成
 https://leetcode-cn.com/problems/edit-distance/

 */
/**
 动态规划：
 假设字符串 （ mice）为s1 ，它的长度为 n1；字符串 （“ arise”）为 s2，它的长度为n2
 dp是大小为(n1+1)*(n2+1) 的二维数组
 dp[ i ][ j ]是s1[0, i)转化成s2[0, j)的最少操作数
 s1[0, i) 是由是s1的前 i 个字符组成
 s2[0, j) 是由是s2的前 j 个字符组成
 
 那么dp[n1][n2]就是是s1[0, n1)转化成s2[0, n2)的最少操作数
 也就是s1转化称s2的最少操作数
 
 
 */

int minDistance(char * word1, char * word2){
    if (word1 == NULL || word2 == NULL) return 0;
    size_t len1=strlen(word1); //
    size_t len2=strlen(word2);
    // 定义二维数组
    int **dp=(int**)malloc(sizeof(int*)*(len1 + 1)); // len1 + 1 行，
    for(int i=0; i <= len1; i++)
        dp[i]=(int*)malloc(sizeof(int)*(len2+1)); // len2 + 1 列
    dp[0][0] = 0;
    // 第0列
    for (int i = 1; i <= len1; i++) {
        // 多出来的第0列，就相当于把word1[0 ~ i] 变成0个字符的word2需要的操作数
        // 就是逐个删除word1的字符，变成word2
        dp[i][0] = i;
    }
    // 第0行
    for (int j = 1; j <= len2; j++) {
        // 多出来的第0行，就相当于把0个字符的word1变成word2[0 ~ j]需要的操作数
        // 就是逐个添加word1字符，变成word2
        dp[0][j] = j;
    }
    // 其他行其他列，这时候才是 word1 和 word2 组成的行列矩阵
    for (int i = 1; i <= len1; i++) {
        for (int j = 1; j <= len2; j++) {
            //dp[i][j] 可以由dp[i-1][j]加1求得，就是由word1[i-1]变成word2[j]
            //只比由word1[i]变成word2[j]少一个字符，给word1做一个“添加”操作即可，所以加1
            int top = dp[i - 1][j] + 1;
            //dp[i][j] 可以由dp[i][j-1]加1求得，就是由word1[i]变成word2[j-1]
            //只比由word1[i]变成word2[j]少一个字符，给word1做一个“添加”操作即可，所以加1
            int left = dp[i][j - 1] + 1;
            // 这是dp[i][j]的左上角
            // 左上角字符相等不需要做什么
             // 左上角字符不等，则需要 s2[j-1]替换s1[i-1]
            int leftTop = dp[i - 1][j - 1];
            if (word1[i - 1] != word2[j - 1]) {
                leftTop++;
            }
            // 寻找三者中的最小值
            dp[i][j] = min(min(top, left), leftTop);
        }
    }
    return dp[len1][len2];
}







@end
