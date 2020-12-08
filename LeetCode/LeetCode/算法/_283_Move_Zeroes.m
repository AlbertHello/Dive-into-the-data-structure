//
//  _283_Move_Zeroes.m
//  LeetCode
//
//  Created by 58 on 2020/12/8.
//

#import "_283_Move_Zeroes.h"

@implementation _283_Move_Zeroes

/**
 283. 移动零
 难度 简单
 给定一个数组 nums，编写一个函数将所有 0 移动到数组的末尾，同时保持非零元素的相对顺序。
 示例:
 输入: [0,1,0,3,12]
 输出: [1,3,12,0,0]
 说明:
 必须在原数组上操作，不能拷贝额外的数组。
 尽量减少操作次数。
 https://leetcode-cn.com/problems/move-zeroes/

 */

/**
 思路：
 从头开始遍历，如果遇见0就把0往最后挪，则有可能把非零数字挪到前面，改变了原有的顺序
 所以不能挪动0，而是把非零数字往前挪。
 */
void moveZeroes(int* nums, int numsSize){
    if (nums == NULL)  return NULL;
    for (int i=0, cur=0; i< numsSize; i++) {
        // 遇到0就跳过，但cur不能加一
        if (nums[i] == 0) continue;
        // 此处 nums[i] ！= 0
        if (cur != i) { // 此处是cur和i分别指在不同的数字上
            nums[cur] = nums[i]; // 把非零数字挪到前面
            nums[i] = 0; // 赋0，
        }
        cur++; // 如果cur和i指在相同的数字上，不做替换。直接加一
    }
}





@end
