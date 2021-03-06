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
 难度 中等
 https://leetcode-cn.com/problems/powx-n/
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
// 4  >> 1 = 2
// 5  >> 1 = 2
// -4 >> 1 = -2
// -5 >> 1 = -3
// -1 >> 1 = -1
// 快速幂 递归
//时间复杂度：O(logn)，即为递归的层数。
//空间复杂度：O(logn)，即为递归的层数。这是由于递归的函数调用会使用栈空间。
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
 快速幂 迭代
 题目要求n的范围：[ -2^31,  2^31 -1 ]
 比如3^21
 21 = 10101
 21 = (1 ∗ 2^4) + (0 ∗ 2^3) + (1 ∗ 2^2) + (0 ∗ 2^1) + (1 ∗ 2^0)
 3^21 = 3^((1∗2^4)+(0∗2^3)+(1∗2^2)+(0∗2^1)+(1∗2^0))
 3^21 = 3^(1∗2^4) ∗ 3^(0∗2^3) ∗ 3^(1∗2^2) ∗ 3^(0∗2^1) ∗ 3^(1∗2^0)
 3^(2^1) = 3^(2^0) ∗ 3^(2^0) = 3^1 ∗ 3^1 = 3^2
 3^(2^2) = 3^(2^1) ∗ 3^(2^1) = 3^2 ∗ 3^2 = 3^4
 时间复杂度：O(logn)，即为对 n 进行二进制拆分的时间复杂度。
 空间复杂度：O(1)
 */
double myPow(double x, int n) {
    // n小于0，先-n弄成正数。但n的最小值是-2^31，直接添加负号变成了2^31，对32位int来说溢出了
    // 所以强转成long类型。
    long y = (n < 0) ? -((long) n) : n;
    double res = 1.0;
    while (y > 0) { // 循环获取y的二进制数的每一位
        // y & 1 是拿到y的二进制数的最后一位二进制
        if ((y & 1) == 1) { // 只有二进制是1的情况下才有意义：比如(1 ∗ 2^2)
            // 如果最后一个二进制位是1，就累乘上x
            res *= x; // res = res * 3
        }// 二进制是0时没有意义，比如 (0 ∗ 2^3) = 0
        x *= x; // 3^(2^0) * 3^(2^0) = 3^(2^1)
        // 舍弃掉最后一个二进制位
        y >>= 1; // 右移后，下一轮y & 1就能拿到y的下一个二进制最后一位了
    }
    // n小于0，就是分数 1 / res
    return (n < 0) ? (1 / res) : res;
}


/**
 快速幂进阶
 设计一个算法求x的y次幂模z的结果：x^y % z
    假设x，y都有可能是很大的整数
    y>=0,z!=0
 
 公式须知：
 (a*b)%c == ((a%c)*(b%c))%c
 
 */
// 2^100 % 6  = (2^50 * 2^50) % 6 = ((2^50 % 6) * (2^50 % 6)) % 6
// 2^101 % 6  = (2^50 * 2^50 * 2) % 6 = ((2^50 % 6) * (2^50 % 6) * (2 % 6)) % 6
// 递归
int powMod(int x, int y, int z) {
    if (y < 0 || z == 0) return 0;
    if (y == 0) return 1 % z;
    int half = powMod(x, y >> 1, z);
    half *= half;
    if ((y & 1) == 0) { // (y & 1) == 0 偶数
        return half % z;
    } else { // (y & 1) == 1 奇数
        return (half * (x % z)) % z;
    }
}

// 迭代
int powMod1(int x, int y, int z) {
    if (y < 0 || z == 0) return 0;
    int res = 1 % z;
    x %= z;
    while (y > 0) {
        if ((y & 1) == 1) {
            // 如果最后一个二进制位是1，就累乘上x
            res = (res * x) % z;
        }
        x = (x * x) % z;
        // 舍弃掉最后一个二进制位
        y >>= 1;
    }
    return res;
}




@end
