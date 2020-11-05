//
//  _167_TwoSum_2.m
//  LeetCode
//
//  Created by 58 on 2020/11/5.
//

#import "_167_TwoSum_2.h"

@implementation _167_TwoSum_2


/**
 167. 两数之和 II - 输入有序数组

 给定一个已按照升序排列 的有序数组，找到两个数使得它们相加之和等于目标数。

 函数应该返回这两个下标值 index1 和 index2，其中 index1 必须小于 index2。

 说明:

 返回的下标值（index1 和 index2）不是从零开始的。
 你可以假设每个输入只对应唯一的答案，而且你不可以重复使用相同的元素。
 示例:

 输入: numbers = [2, 7, 11, 15], target = 9
 输出: [1,2]
 解释: 2 与 7 之和等于目标数 9 。因此 index1 = 1, index2 = 2 。
 
 Example 2:

 Input: numbers = [2,3,4], target = 6
 Output: [1,3]
 Example 3:

 Input: numbers = [-1,0], target = -1
 Output: [1,2]

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/two-sum-ii-input-array-is-sorted
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */
/**
 双指针：
 
 只要数组有序，就应该想到双指针技巧。这道题的解法有点类似二分查找，通过调节left和right可以调整sum的大小
 
 时间复杂度：O（n）
 空间复杂度：O（1）
 */
int* twoSum_2(int* numbers, int numbersSize, int target, int* returnSize){
    int left = 0, right = numbersSize - 1;
    while (left < right) {
        int sum = numbers[left] + numbers[right];
        if (sum == target) {
            // 题目要求的索引是从 1 开始的
            int *res=(int *)malloc(sizeof(int)*2);
            res[0]=left+1;
            res[1]=right+1;
            *returnSize=2;
            return res;
        } else if (sum < target) {
            left++; // 让 sum 大一点，则左指针++
        } else if (sum > target) {
            right--; // 让 sum 小一点，则右指针--
        }
    }
    return NULL;
}
@end
