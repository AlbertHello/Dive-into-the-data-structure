//
//  _11_ContainerWithMostWater.m
//  LeetCode
//
//  Created by 58 on 2020/12/10.
//

#import "_11_ContainerWithMostWater.h"

@implementation _11_ContainerWithMostWater


/**
 11. 盛最多水的容器 ¥¥¥¥¥
 难度 中等
 https://leetcode-cn.com/problems/container-with-most-water/
 给你 n 个非负整数 a1，a2，...，an，每个数代表坐标中的一个点 (i, ai) 。在坐标内画 n 条垂直线，垂直线 i 的两个端点分别为 (i, ai) 和 (i, 0) 。找出其中的两条线，使得它们与 x 轴共同构成的容器可以容纳最多的水。
 说明：你不能倾斜容器。
 示例 1：
 输入：[1,8,6,2,5,4,8,3,7]
 输出：49
 解释：图中垂直线代表输入数组 [1,8,6,2,5,4,8,3,7]。在此情况下，容器能够容纳水（表示为蓝色部分）的最大值为 49。
 示例 2：

 输入：height = [1,1]
 输出：1
 示例 3：

 输入：height = [4,3,2,1,4]
 输出：16
 示例 4：

 输入：height = [1,2,1]
 输出：2
  

 提示：

 n = height.length
 2 <= n <= 3 * 10^4
 0 <= height[i] <= 3 * 10^4
 */



/**
 思路：
 设置左右两个索引，比较哪个索引下的值更小，用小的值乘l到r的跨度，就是这个矩形的面积，也就是接的水
 时间复杂度：O(n)
 空间复杂度：O(1)
 */
int maxArea(int* height, int heightSize){
    if (height == NULL || heightSize == 0) return 0;
    int l = 0, r = heightSize - 1, water = 0;
    while (l < r) {
        if (height[l] <= height[r]) {
            // 矩形面积 长 * 宽， 长：(r - l)，宽：height[l]
            water = max(water, (r - l) * height[l]);
            l++;
        } else {
            water = max(water, (r - l) * height[r]);
            r--;
        }
    }
    return water;
}
/**
 优化1: 三目运算符
 */
int maxArea1(int* height, int heightSize){
    if (height == NULL || heightSize == 0) return 0;
    int l = 0, r = heightSize - 1, water = 0;
    while (l < r) {
        int minH = (height[l] <= height[r]) ? height[l++] : height[r--];
        water = max(water, minH * (r - l + 1));
    }
    return water;
}
/**
 优化2: 跳过没必要的数
 */
int maxArea2(int* height, int heightSize){
    if (height == NULL || heightSize == 0) return 0;
    int l = 0, r = heightSize - 1, water = 0;
    while (l < r) {
        if (height[l] <= height[r]) {
            int minH = height[l];
            water = max(water, (r - l) * minH);
            // 上面已经找到了minH，当l++后如果height[l]比minH还小就没必要判断了，接着l++
            while (l < r && height[l] <= minH) l++;
        } else {
            int minH = height[r];
            water = max(water, (r - l) * minH);
            // 上面已经找到了minH，当r--后如果height[r]比minH还小就没必要判断了，接着r--
            while (l < r && height[r] <= minH) r--;
        }
    }
    return water;
}









@end
