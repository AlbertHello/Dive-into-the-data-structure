//
//  53_MaximumSubarray.c
//  LeetCode
//
//  Created by 58 on 2020/10/15.
//

#include "53_MaximumSubarray.h"
#include <math.h>




/**
 53. 最大子序和
 给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。
 Example 1:

 Input: nums = [-2,1,-3,4,-1,2,1,-5,4]
 Output: 6
 Explanation: [4,-1,2,1] has the largest sum = 6.
 Example 2:

 Input: nums = [1]
 Output: 1
 Example 3:

 Input: nums = [0]
 Output: 0
 Example 4:

 Input: nums = [-1]
 Output: -1
 Example 5:

 Input: nums = [-2147483647]
 Output: -2147483647

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/maximum-subarray
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 
 进阶:
 如果你已经实现复杂度为 O(n) 的解法，尝试使用更为精妙的分治法求解。
 */

int find_max(int num1, int num2){
    return num1>=num2 ? num1:num2;
}
//：动态规划
//时间复杂度：O(n)，其中n 为 nums 数组的长度。我们只需要遍历一遍数组即可求得答案。
//空间复杂度：O(1)。我们只需要常数空间存放若干变量。
int maxSubArray(int* nums, int numsSize){
    int pre = 0, maxAns = nums[0];
    for (int i =0; i<numsSize; i++) {
        int num=nums[i];
        //拿前面加过的数和当前数相加，然后再和该数比较
        //如果pre + num的和比pre小，说明num是负数。
        //无论pre重新赋值为pre + num还是num逗比原先pre要小了
        pre = find_max(pre + num, num);
        //maxAns保存的是连续子数组元素之和最大值，pre计算完后和maxAns比较，
        //如果上一步出现了num为负数，那么maxAns和pre的比较肯定保留的是maxAns
        //有点儿像滚动数组的意思
        maxAns = find_max(maxAns, pre);
    }
    return maxAns;
}

//方法二：分治法


