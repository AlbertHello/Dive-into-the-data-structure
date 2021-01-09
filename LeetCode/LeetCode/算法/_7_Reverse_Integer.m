//
//  _7_Reverse_Integer.m
//  LeetCode
//
//  Created by 58 on 2020/12/9.
//

#import "_7_Reverse_Integer.h"

@implementation _7_Reverse_Integer


/**
 7. 整数反转 ¥¥¥¥¥
 https://leetcode-cn.com/problems/reverse-integer/
 难度 简单
 给出一个 32 位的有符号整数，你需要将这个整数中每位上的数字进行反转。
 示例 1:
 输入: 123
 输出: 321
 示例 2:
 输入: -123
 输出: -321
 示例 3:
 输入: 120
 输出: 21
 注意:

 假设我们的环境只能存储得下 32 位的有符号整数，则其数值范围为 [−2^31,  2^31 − 1]。请根据这个假设，如果反转后整数溢出那么就返回 0。
 */

// 第一种处理溢出的方法：用long定义，并且和INT_MAX/INT_MIN 比较
int reverse1(int x) {
    long res = 0; // 先用long定义，因为传入的int类型，long类型res肯定能接收int最大值反转后溢出的数，也能包含int最小值反转后溢出的数
    while (x != 0) {
        // 1234 -> 4321
        // x % 10 等于拿到最后一个数字4
        res = res * 10 + x % 10;
        if (res > INT_MAX) return 0; // 处理溢出
        if (res < INT_MIN) return 0; // 处理溢出
        x /= 10; // 前面拿到4后，x/10拿到其他数字：123
    }
    return (int) res;
}
// 第二种处理溢出的方法：反推
// res = prevRes * 10 + x % 10; 如果res溢出，那么反推回去num = (res - (x % 10 )) / 10，num肯定不等于prevRes
int reverse2(int x) {
    int res = 0;
    while (x != 0) {
        int prevRes = res;
        int mod = x % 10;
        // 此处，就又可能已经溢出了，某些语言从此处就可能报错了
        res = prevRes * 10 + mod;
        if ((res - mod) / 10 != prevRes) return 0;
        x /= 10;
    }
    return res;
}

+(void)integerReverseTest{
//    printf("%d",INT_MIN);
    // INT_MAX: 2147483647
    // INT_MIN: -2147483648
    printf("%d",reverse2(-2147483648));
}




@end
