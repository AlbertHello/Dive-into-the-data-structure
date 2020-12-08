//
//  Offer_62_LastRemaining_in_Circle.m
//  LeetCode
//
//  Created by 58 on 2020/12/8.
//

#import "Offer_62_LastRemaining_in_Circle.h"

@implementation Offer_62_LastRemaining_in_Circle
/**
 剑指 Offer 62. 圆圈中最后剩下的数字
 难度
 简单
0,1,,n-1这n个数字排成一个圆圈，从数字0开始，每次从这个圆圈里删除第m个数字。
 求出这个圆圈里剩下的最后一个数字。
 例如，0、1、2、3、4这5个数字组成一个圆圈，从数字0开始每次删除第3个数字，则删除的前4个数字依次是2、0、4、1，因此最后剩下的数字是3。
 示例 1：
 输入: n = 5, m = 3
 输出: 3
 示例 2：

 输入: n = 10, m = 17
 输出: 2

 限制：

 1 <= n <= 10^5
 1 <= m <= 10^6
 
 https://leetcode-cn.com/problems/yuan-quan-zhong-zui-hou-sheng-xia-de-shu-zi-lcof/
 */

/**
 其实就是约瑟夫环的问题:
 有n个人，编号分别为0,1,2...n-1,每当报数到第m个人时，就杀掉他，求最后胜利者编号.
 这种题有数学公式：f(n,m)=(f(n-1,m)+m) % n
 */

//根据公式用递归方法来做：
int lastRemaining1(int n, int m) {
    // 只有一个人的时候，编号就是0.返回0
    if (n == 1) {
        return 0;
    }
    return (lastRemaining1(n - 1, m) + m) % n;
}

/**
 非递归：
  f(1, 3) = 0
  f(2, 3) = (f(1, 3) + 3) % 2
  f(3, 3) = (f(2, 3) + 3) % 3
  ...
  f(7, 3) = (f(6, 3) + 3) % 7
  f(8, 3) = (f(7, 3) + 3) % 8
  f(9, 3) = (f(8, 3) + 3) % 9
  f(10, 3) = (f(9, 3) + 3) % 10
 */

int lastRemaining2(int n, int m) {
    int res = 0;
    for (int i = 2; i <= n; i++) { // i是数据规模，代表有多少个数字（有多少个人）
        res = (res + m) % i;
    }
    return res;
}


@end
