//
//  _190_Reverse_Bits.m
//  LeetCode
//
//  Created by 58 on 2020/12/28.
//

#import "_190_Reverse_Bits.h"

@implementation _190_Reverse_Bits


/*
 190. 颠倒二进制位
 难度 简单
 https://leetcode-cn.com/problems/reverse-bits/
 颠倒给定的 32 位无符号整数的二进制位。
 示例 1：
 输入: 00000010100101000001111010011100
 输出: 00111001011110000010100101000000
 解释: 输入的二进制串 00000010100101000001111010011100 表示无符号整数 43261596，
      因此返回 964176192，其二进制表示形式为 00111001011110000010100101000000。
 示例 2：
 
 输入：11111111111111111111111111111101
 输出：10111111111111111111111111111111
 解释：输入的二进制串 11111111111111111111111111111101 表示无符号整数 4294967293，
      因此返回 3221225471 其二进制表示形式为 10111111111111111111111111111111 。
 
 进阶:
 如果多次调用这个函数，你将如何优化你的算法？
 */

/**
 时间复杂度：O（1）。在算法中，我们有一个循环来迭代输入的最高非零位，即
 空间复杂度：O(1)，因为不管输入是什么，内存的消耗是固定的。
 */
uint32_t reverseBits(uint32_t n) {
    uint32_t ret = 0, power = 31;
    while (n != 0) {
        // (n & 1) 取出n的最后一个二进制位数字， << power; 然后把取出的数左移power位已达到reverse的效果
        ret += (n & 1) << power;
        n = n >> 1;// 之后 n 右移一位，下次循环再取出新的一个二进制位
        power -= 1;
    }
    return ret;
}

/**
 不需要循环的解法
 首先，我们将原来的 32 位分为 2 个 16 位的块。
 然后我们将 16 位块分成 2 个 8 位的块。
 然后我们继续将这些块分成更小的块，直到达到 1 位的块。
 在上述每个步骤中，我们将中间结果合并为一个整数，作为下一步的输入。
 
            [b1][b2]
mask        &10/\ &01
              /  \
        [b1][0]   [0][b2]
 shift  ----->    <------
        [0][b1]   [b2][0]
           \         /
            \       /
             \     /
 combine     [b2][b1]
 时间复杂度：O(1)，没有使用循环。
 空间复杂度：O(1)，没有使用变量。
 */
uint32_t reverseBits2(uint32_t n) {
    // n:       0000 0010 1001 0100 0001 1110 1001 1100
    // n >> 16: 0000 0000 0000 0000 0000 0010 1001 0100
    // n << 16: 0001 1110 1001 1100 0000 0000 0000 0000 这俩值进行或运算得到 0001 1110 1001 1100 0000 0010 1001 0100
    // 正好按照16位一半反转了
    n = (n >> 16) | (n << 16);
    
    // n:                       0001 1110 1001 1100 0000 0010 1001 0100
    // 0xff00ff00 =             1111 1111 0000 0000 1111 1111 0000 0000
    // n&0xff00ff00=            0001 1110 0000 0000 0000 0010 0000 0000
    //(n & 0xff00ff00) >> 8     0000 0000 0001 1110 0000 0000 0000 0010  // n1
    // n & 0x00ff00ff           0000 0000 1111 1111 0000 0000 1111 1111
    // (n & 0x00ff00ff) << 8    1001 1100 0000 0010 1001 0100 0000 0000 // n2
    // n = n1 | n2 =            1001 1100 0001 1110 1001 0100 0000 0010 // 前后四个8位再反转
    n = ((n & 0xff00ff00) >> 8) | ((n & 0x00ff00ff) << 8);
    
    // 按4位反转
    // 0xf0f0f0f0 = 1111 0000 1111 0000 1111 0000 1111 0000
    n = ((n & 0xf0f0f0f0) >> 4) | ((n & 0x0f0f0f0f) << 4);
    // 按2位反转
    // 0xcccccccc = 1100 1100 1100 1100 1100 1100 1100 1100
    // 0x33333333 = 0011 0011 0011 0011 0011 0011 0011 0011
    n = ((n & 0xcccccccc) >> 2) | ((n & 0x33333333) << 2);
    // 按1位反转
    // 0xaaaaaaaa = 1010 1010 1010 1010 1010 1010 1010 1010
    // 0x55555555 = 0101 0101 0101 0101 0101 0101 0101 0101
    n = ((n & 0xaaaaaaaa) >> 1) | ((n & 0x55555555) << 1);
    return n;
}

/**
 326. 3的幂
 难度 简单
 链接：https://leetcode-cn.com/problems/power-of-three/solution/3de-mi-by-leetcode/
 给定一个整数，写一个函数来判断它是否是 3 的幂次方。如果是，返回 true ；否则，返回 false 。
 整数 n 是 3 的幂次方需满足：存在整数 x 使得 n == 3x
 示例 1：

 输入：n = 27
 输出：true
 示例 2：

 输入：n = 0
 输出：false
 示例 3：

 输入：n = 9
 输出：true
 示例 4：

 输入：n = 45
 输出：false
 */
//
// 找出数字 n 是否是数字 b 的幂的一个简单方法是，n%b 只要余数为 0，就一直将 n 除以 b。
// 应该可以将 n 除以 b x 次，每次都有 0 的余数，最终结果是 1。
//时间复杂度：O(logb(n))==(以b为底，n的对数)就是执行的次数。在我们的例子中是O(logn)。除数是用对数表示的。
//空间复杂度：O(1)，没有使用额外的空间。
bool isPowerOfThree(int n) {
    if (n < 1) { // 对于负数，该算法没有意义，
        return false;
    }
    while (n % 3 == 0) {
        n /= 3;
    }
    return n == 1;
}

@end
