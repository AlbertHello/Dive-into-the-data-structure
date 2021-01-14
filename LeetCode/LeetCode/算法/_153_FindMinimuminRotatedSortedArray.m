//
//  _153_FindMinimuminRotatedSortedArray.m
//  LeetCode
//
//  Created by 58 on 2020/12/22.
//

#import "_153_FindMinimuminRotatedSortedArray.h"

@implementation _153_FindMinimuminRotatedSortedArray

/**
 153. 寻找旋转排序数组中的最小值 ¥¥
 难度 中等
 https://leetcode-cn.com/problems/find-minimum-in-rotated-sorted-array/
 假设按照升序排序的数组在预先未知的某个点上进行了旋转。例如，数组 [0,1,2,4,5,6,7] 可能变为 [4,5,6,7,0,1,2] 。

 请找出其中最小的元素。
 示例 1：
 输入：nums = [3,4,5,1,2]
 输出：1
 示例 2：
 输入：nums = [4,5,6,7,0,1,2]
 输出：0
 示例 3：
 输入：nums = [1]
 输出：1
 */


/**
 二分
 时间复杂度为O(logN)，空间复杂度为O(1)。
 用二分法查找，需要始终将目标值（这里是最小值）套住，并不断收缩左边界或右边界。

 左、中、右三个位置的值相比较，有以下几种情况：

 左值 < 中值, 中值 < 右值 ：没有旋转，最小值在最左边，可以收缩右边界
         右
      中
  左
 左值 > 中值, 中值 < 右值 ：有旋转，最小值在左半边，可以收缩右边界
  左
          右
      中
 左值 < 中值, 中值 > 右值 ：有旋转，最小值在右半边，可以收缩左边界
      中
  左
          右
 左值 > 中值, 中值 > 右值 ：单调递减，不可能出现
  左
     中
         右
 */
int findMin(int* nums, int numsSize){
    int left = 0;
    int right = numsSize-1;/* 左闭右闭区间，如果用右开区间则不方便判断右值 */
    while (left < right) {/* 循环不变式，如果left == right，则循环结束 */
        int mid = left + (right - left) / 2;/* 地板除，mid更靠近left */
        if (nums[mid] > nums[right]) {/* 中值 > 右值，最小值在右半边，收缩左边界 */
            left = mid + 1;/* 因为中值 > 右值，中值肯定不是最小值，左边界可以跨过mid */
        } else {
            /* 明确中值 < 右值，最小值在左半边，收缩右边界 */
            /* 因为中值 < 右值，中值也可能是最小值，右边界只能取到mid处 */
            right = mid;
        }
    }
    return nums[left]; /* 循环结束，left == right，最小值输出nums[left]或nums[right]均可 */
}
@end
