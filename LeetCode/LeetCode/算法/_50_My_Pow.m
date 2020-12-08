//
//  _50_My_Pow.m
//  LeetCode
//
//  Created by 58 on 2020/12/8.
//

#import "_50_My_Pow.h"

@implementation _50_My_Pow

/**
 50. Pow(x, n)
 难度
 中等
 实现 pow(x, n) ，即计算 x 的 n 次幂函数。

 示例 1:

 输入: 2.00000, 10
 输出: 1024.00000
 示例 2:

 输入: 2.10000, 3
 输出: 9.26100
 示例 3:

 输入: 2.00000, -2
 输出: 0.25000
 解释: 2-2 = 1/22 = 1/4 = 0.25
 说明:

 -100.0 < x < 100.0
 n 是 32 位有符号整数，其数值范围是 [−2^31, 2^31 − 1] 。
 
 */
// 3^20  = 3^10  * 3^10
// 3^21  = 3^10  ∗ 3^10 ∗3
// 3^−20 = 3^−10 ∗ 3^−10
// 3^−21 = 3^−10 ∗ 3^−10 ∗ 3^−1
// 3^−21 = 3^−11 ∗ 3^−11 ∗ 3
// 递归
// 实践复杂度：// T(n) = T(n/2) + O(1) = O(logn)
double myPow1(double x, int n) {
    if (n == 0) return 1;
    if (n == -1) return 1 / x;
    // n >> 1 = n / 2
    double half = myPow1(x, n >> 1); // T(n/2)
    half *= half;
    // 是否为奇数 (n & 1) == 1
    return ((n & 1) == 1) ? (half * x) : half;
}

/**
 
 */
double myPow(double x, int n) {
    long y = (n < 0) ? -((long) n) : n;
    double res = 1.0;
    while (y > 0) {
        if ((y & 1) == 1) {
            // 如果最后一个二进制位是1，就累乘上x
            res *= x;
        }
        x *= x;
        // 舍弃掉最后一个二进制位
        y >>= 1; // 除2
    }
    // n小于0，就是分数 1 / res
    return (n < 0) ? (1 / res) : res;
}

@end
