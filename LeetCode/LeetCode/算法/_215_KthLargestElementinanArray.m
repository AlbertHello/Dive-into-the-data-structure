//
//  _215_KthLargestElementinanArray.m
//  LeetCode
//
//  Created by 58 on 2021/1/7.
//

#import "_215_KthLargestElementinanArray.h"


@implementation _215_KthLargestElementinanArray

/**
 215. 数组中的第K个最大元素 $$$$$
 难度 中等
 https://leetcode-cn.com/problems/kth-largest-element-in-an-array/
 在未排序的数组中找到第 k 个最大的元素。请注意，你需要找的是数组排序后的第 k 个最大的元素，而不是第 k 个不同的元素。

 示例 1:

 输入: [3,2,1,5,6,4] 和 k = 2
 输出: 5
 示例 2:

 输入: [3,2,3,1,2,4,5,5,6] 和 k = 4
 输出: 4
 说明:

 你可以假设 k 总是有效的，且 1 ≤ k ≤ 数组的长度。
 */

/**
 解法1 快速选择算法
 
 快速选择算法比较巧妙，时间复杂度更低，是快速排序的简化版，一定要熟悉思路。
 我们先从快速排序讲起。
 快速排序的逻辑是，若要对nums[lo..hi]进行排序，我们先找一个分界点p，通过交换元素使得nums[lo..p-1]都小于等于nums[p]，且nums[p+1..hi]都大于nums[p]，然后递归地去nums[lo..p-1]和nums[p+1..hi]中寻找新的分界点，最后整个数组就被排序了。
 快速排序的代码如下：
 
 */
/* 快速排序主函数 */
void sort_quick(int* nums, int numsSize) {
    // 一般要在这用洗牌算法将 nums 数组打乱，也就是取随机索引下的数当妯点
    // 以保证较高的效率，我们暂时省略这个细节
    quick(nums, 0, numsSize-1);
}
// 快速排序核心逻辑
void quick(int* nums, int begin, int end) { // [begin, end]
    if (begin >= end) return;
    // 通过交换元素构建分界点索引 p
    int p = findZhouDian(nums, begin, end);
    // 现在 nums[begin..p-1] 都小于 nums[p]，
    // 且 nums[p+1..end] 都大于 nums[p]
    quick(nums, begin, p-1);
    quick(nums, p+1, end);
}
// 找那个轴点元素索引 [being, end]
int findZhouDian(int* nums, int begin, int end){
    int left = begin;
    int right = end;
    // 备份begin位置的元素，还是取index=begin处的元素作为标准值判断
    int pivot = nums[begin];
    while (left < right) {
        // 左右begin end交替判断就可以用到这两个while来实现
        while (left < right) {
            // 如果大于号改成大于等于号，则可能就会导致最坏情况发生
            if (nums[right] > pivot) { // 右边元素 > 轴点元素
                right--;
            } else { // 右边元素 <= 轴点元素 就得往轴点元素左边移动了
                //下一轮就从轴点左侧开始判断
                //begin end 交替判断
                nums[left++]=nums[right];
                break;
            }
        }
        while (left < right) {
            // 如果小于号改成小于等于号，则可能就会导致最坏情况发生
            if (nums[left] < pivot) { // 左边元素 < 轴点元素
                left++;
            } else { // 左边元素 >= 轴点元素 就得往轴点元素右边移动了
                //下一轮就从轴点右侧开始判断了
                //begin end 交替判断
                nums[right--]=nums[left];
                break;
            }
        }
    }
    //能来到这里说明left=right了，也就找到了最中间的那个值的索引
    // 将轴点元素放入最终的位置
    nums[left]=pivot;
    return left;
}
/**
 我们刚说了，findZhouDian函数会将nums[p]排到正确的位置，使得nums[begin..p-1] < nums[p] < nums[p+1..end]。
 那么我们可以把p和k进行比较，如果p < k说明第k大的元素在nums[p+1..end]中，如果p > k说明第k大的元素在nums[begin..p-1]中。
 所以我们可以复用findZhouDian函数来实现这道题目，不过在这之前还是要做一下索引转化：
 题目要求的是「第k个最大元素」，这个元素其实就是nums升序排序后「索引」为len(nums) - k的这个元素。
 这个代码框架其实非常像我们前文 二分搜索框架 的代码，这也是这个算法高效的原因，但是时间复杂度为什么是O(N)呢？按理说类似二分搜索的逻辑，时间复杂度应该一定会出现对数才对呀？
 其实这个O(N)的时间复杂度是个均摊复杂度，因为我们的partition函数中需要利用 双指针技巧 遍历nums[lo..hi]，那么总共遍历了多少元素呢？
 最好情况下，每次p都恰好是正中间(lo + hi) / 2，那么遍历的元素总数就是：
 N + N/2 + N/4 + N/8 + … + 1
 这就是等比数列求和公式嘛，求个极限就等于2N，所以遍历元素个数为2N，时间复杂度为O(N)。
 但我们其实不能保证每次p都是正中间的索引的，最坏情况下p一直都是lo + 1或者一直都是hi - 1，遍历的元素总数就是：
 N + (N - 1) + (N - 2) + … + 1
 这就是个等差数列求和，时间复杂度会退化到O(N^2)，为了尽可能防止极端情况发生，我们需要在算法开始的时候对nums数组来一次随机打乱,打乱之后平均时间复杂度就是O(n)了。
 
 总结一下，快速选择算法就是快速排序的简化版，复用了partition函数，快速定位第 k 大的元素。相当于对数组部分排序而不需要完全排序，从而提高算法效率，将平均时间复杂度降到O(N)。
 */
int findKthLargest(int* nums, int numsSize, int k) {
    int lo = 0, hi = numsSize-1;
    // 索引转化
    k = numsSize - k;
    while (lo < hi) {
        // 在 nums[lo..hi] 中选一个分界点
        int p = findZhouDian(nums, lo, hi);
        if (p < k) {
            // 第 k 大的元素在 nums[p+1..hi] 中
            lo = p + 1;
        } else if (p > k) {
            // 第 k 大的元素在 nums[lo..p-1] 中
            hi = p - 1;
        } else {
            // 找到第 k 大元素
            return nums[p];
        }
    }
    return -1;
}
void findKthLargestTest(){
    int nums[]={3,2,1,5,6,4,59,21,34,12,8,19,20};
    int numsSize=sizeof(nums)/sizeof(int);
    // 检查下快排算法是否正确
    sort_quick(nums, numsSize);
    for (int i=0; i<numsSize; i++) {
        printf("%d ",nums[i]);
    }
    printf("\n");
    
    // 找出第k个最大的元素
    printf("%d ",findKthLargest(nums,numsSize,4));
}



@end
