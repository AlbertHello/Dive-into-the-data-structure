//
//  _27_Remove_Element.m
//  LeetCode
//
//  Created by Albert on 2021/1/2.
//

#import "_27_Remove_Element.h"

@implementation _27_Remove_Element

/**
 27. 移除元素 ¥
 难度 简单
 https://leetcode-cn.com/problems/remove-element/
 给你一个数组 nums 和一个值 val，你需要 原地 移除所有数值等于 val 的元素，并返回移除后数组的新长度。

 不要使用额外的数组空间，你必须仅使用 O(1) 额外空间并 原地 修改输入数组。

 元素的顺序可以改变。你不需要考虑数组中超出新长度后面的元素。

  

 示例 1:

 给定 nums = [3,2,2,3], val = 3,

 函数应该返回新的长度 2, 并且 nums 中的前两个元素均为 2。

 你不需要考虑数组中超出新长度后面的元素。
 示例 2:

 给定 nums = [0,1,2,2,3,0,4,2], val = 2,

 函数应该返回新的长度 5, 并且 nums 中的前五个元素为 0, 1, 3, 0, 4。

 注意这五个元素可为任意顺序。

 你不需要考虑数组中超出新长度后面的元素。
  

 说明:

 为什么返回数值是整数，但输出的答案是数组呢?

 请注意，输入数组是以「引用」方式传递的，这意味着在函数里修改输入数组对于调用者是可见的。

 你可以想象内部操作如下:

 // nums 是以“引用”方式传递的。也就是说，不对实参作任何拷贝
 int len = removeElement(nums, val);

 // 在函数里修改输入数组对于调用者是可见的。
 // 根据你的函数返回的长度, 它会打印出数组中 该长度范围内 的所有元素。
 for (int i = 0; i < len; i++) {
     print(nums[i]);
 }
 */

/**
 此题和 【 26. 删除排序数组中的重复项 】题差不多
 题目要求我们把 nums 中所有值为 val 的元素原地删除，依然需要使用 双指针技巧 中的快慢指针：
 如果 fast 遇到需要去除的元素，则直接跳过，否则就告诉 slow 指针，并让 slow 前进一步。
 这和前面说到的数组去重问题解法思路是完全一样的。
 
 这里和有序数组去重的解法有一个重要不同，我们这里是先给 nums[slow] 赋值然后再给 slow++，这样可以保证 nums[0..slow-1] 是不包含值为 val 的元素的，最后的结果数组长度就是 slow。
 */
int removeElement(int* nums, int numsSize, int val) {
    int fast = 0, slow = 0;
    while (fast < numsSize) {
        if (nums[fast] != val) {
            // 先赋值
            nums[slow] = nums[fast];
            // 后增加，那么slow就是数组长度
            slow++;
        }
        fast++;
    }
    return slow;
}

/**
 283. 移动零 ¥¥¥
 难度 简单
 https://leetcode-cn.com/problems/move-zeroes/
 给定一个数组 nums，编写一个函数将所有 0 移动到数组的末尾，同时保持非零元素的相对顺序。
 示例:
 输入: [0,1,0,3,12]
 输出: [1,3,12,0,0]
 说明:
 必须在原数组上操作，不能拷贝额外的数组。
 尽量减少操作次数。
 */

/**
 题目让我们将所有 0 移到最后，其实就相当于移除 nums 中的所有 0，然后再把后面的元素都赋值为 0 即可。
 所以我们可以复用上一题的 removeElement 函数：
 */
void moveZeroes(int* nums, int numsSize){
    // 去除 nums 中的所有 0
    // 返回去除 0 之后的数组长度
    int p = removeElement(nums, numsSize, 0);
    for (; p < numsSize; p++) {
        // 将 p 之后的所有元素赋值为 0
        nums[p] = 0;
    }
}

@end
