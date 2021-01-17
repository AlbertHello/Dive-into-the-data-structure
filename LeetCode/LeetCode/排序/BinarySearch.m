//
//  BinarySearch.m
//  LeetCode
//
//  Created by Albert on 2020/11/1.
//

#import "BinarySearch.h"

@implementation BinarySearch
// 大O排序
// O(1) < O(logn) < O(n) < O(nlogn) < O(n^2) < O(2^n) < O(n!)

//  名称    最好          最坏               平均            空间   in-place  稳定性
// 冒泡排序  O(n)         O(n^2)            O(n^2)          O(1)    ✅       ✅
// 选择排序  O(n^2)       O(n^2)            O(n^2)          O(1)    ✅       ❌
// 插入排序  O(n)         O(n^2)            O(n^2)          O(1)    ✅       ✅
// 归并排序  O(nlogn)     O(nlogn)          O(nlogn)        O(n)    ❌       ✅
// 快速排序  O(nlogn)     O(n^2)             O(nlogn)        O(logn) ✅       ❌
// 希尔排序  O(n)     O(n^(4/3))~O(n^2)   取决于步长序列       O(1)    ✅       ❌
// 堆排序    O(nlogn)     O(nlogn)         O(nlogn)         O(1)    ✅       ❌
// 计数排序  O(n + k)     O(n + k)          O(n + k)        O(n + k) ❌      ✅
// 基数排序  O(d∗(n+k))   O(d∗(n+k))       O(d∗(n+k))       O(n + k) ❌      ✅
// 桶排序    O(n + k)     O(n + k)          O(n + k)        O(n + m) ❌      ✅



/**
 1 最基本的二分查找
 不要出现 else，而是把所有情况用 else if 写清楚，这样可以清楚地展现所有细节。
 计算 mid 时需要防止溢出，代码中 left + (right - left) / 2 就和 (left + right) / 2 的结果相同，但是有效防止了 left 和 right 太大直接相加导致溢出。
 
 因为我们初始化 right = nums.length - 1
 所以决定了我们的「搜索区间」是 [left, right]
 所以决定了 while (left <= right)
 同时也决定了 left = mid+1 和 right = mid-1
 因为我们只需找到一个 target 的索引即可
 所以当 nums[mid] == target 时可以立即返回
 */
int binarySearch(int* nums, int numsSize, int target) {
    int left = 0;
    int right = numsSize - 1; // 注意，这里是闭区间【left，right】
    while(left <= right) {
        int mid = left + (right - left) / 2;
        if(nums[mid] == target){
            return mid;
        }else if (nums[mid] < target){
            left = mid + 1; // 注意
        }else if (nums[mid] > target){
            right = mid - 1; // 注意
        }
    }
    return -1;
}

/**
 2 寻找左侧边界的二分查找：
 因为我们初始化 right = nums.length
 所以决定了我们的「搜索区间」是 [left, right)
 所以决定了 while (left < right)
 同时也决定了 left = mid + 1 和 right = mid

 因为我们需找到 target 的最左侧索引
 所以当 nums[mid] == target 时不要立即返回
 而要收紧右侧边界以锁定左侧边界
 */
int left_bound(int* nums, int numsSize, int target) {
    if (numsSize == 0) return -1;
    int left = 0;
    int right = numsSize; // 注意

    while (left < right) { // 注意
        int mid = (left + right) / 2;
        if (nums[mid] == target) {
            right = mid;
        } else if (nums[mid] < target) {
            left = mid + 1;
        } else if (nums[mid] > target) {
            right = mid; // 注意
        }
    }
    // 比如对于有序数组 nums = [2,3,5,7], target = 1，算法会返回 0，含义是：nums 中小于 1 的元素有 0 个。
    // 再比如说 nums = [2,3,5,7], target = 8，算法会返回 4，含义是：nums 中小于 8 的元素有 4 个。
    // 综上可以看出，函数的返回值（即 left 变量的值）取值区间是闭区间 [0, nums.length]
    
    // 所以target 比所有数都大
    if (left == numsSize) return -1;
    // 类似之前算法的处理方式
    return nums[left] == target ? left : -1;
}
// 下面是闭区间形式的
int left_bound2(int* nums, int numsSize, int target) {
    int left = 0, right = numsSize - 1;
    // 搜索区间为 [left, right]
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (nums[mid] < target) {
            // 搜索区间变为 [mid+1, right]
            left = mid + 1;
        } else if (nums[mid] > target) {
            // 搜索区间变为 [left, mid-1]
            right = mid - 1;
        } else if (nums[mid] == target) {
            // 收缩右侧边界
            right = mid - 1;
        }
    }
    // 检查出界情况
    if (left >= numsSize || nums[left] != target) return -1;
    return left;
}

/**
 3 寻找右侧边界的二分查找：
 因为我们初始化 right = nums.length
 所以决定了我们的「搜索区间」是 [left, right)
 所以决定了 while (left < right)
 同时也决定了 left = mid + 1 和 right = mid

 因为我们需找到 target 的最右侧索引
 所以当 nums[mid] == target 时不要立即返回
 而要收紧左侧边界以锁定右侧边界

 又因为收紧左侧边界时必须 left = mid + 1
 所以最后无论返回 left 还是 right，必须减一
 */

int right_bound(int* nums, int numsSize,int target) {
    if (numsSize == 0) return -1;
    int left = 0, right = numsSize;

    while (left < right) {
        int mid = (left + right) / 2;
        if (nums[mid] == target) {
            left = mid + 1; // 注意
        } else if (nums[mid] < target) {
            left = mid + 1;
        } else if (nums[mid] > target) {
            right = mid;
        }
    }
    if (left == 0) return -1;
    return nums[left-1] == target ? (left-1) : -1;
}
// 下面是闭区间形式的
int right_bound2(int* nums, int numsSize,int target) {
    int left = 0, right = numsSize - 1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (nums[mid] > target) {
            right = mid - 1;
        } else if (nums[mid] < target) {
            left = mid + 1;
        } else if (nums[mid] == target) {
            // 这里改成收缩左侧边界即可
            left = mid + 1;
        }
    }
    // 这里改为检查 right 越界的情况，见下图
    if (right < 0 || nums[right] != target) return -1;
    return right;
}









//查找v在有序数组array（升序）中待插入位置
//如果要找的值在数组中存在多个，则此算法并不能确定找到的是哪个值
-(int)indexOf:(int *)array length:(int)len value:(int)v{
        if (array == NULL || len == 0) return -1;
        int begin = 0;
        int end = len;// end等于len，则数组长度正好等于len-begin
        while (begin < end) { //begin=end或者直接找到mid结束
            int mid = (begin + end) >> 1; //取中间索引
            if (v < array[mid]) { //当前值小于数组中间值
                end = mid; //则需要在前半部分查找，所以end=mid
            } else if (v > array[mid]) { //当前值大于数组中间值
                begin = mid + 1; //则需要在后半部分查找，所以begin=mid+1
            } else { //当前值等于数组中间值
                return mid;
            }
        }
        return -1;
    }

//查找val在有序数组array（升序）中待插入位置
//index: 0 1 2 3 4  5  6  7
//value: 2 4 8 8 8 12 14
//则开始时，begin=0，end=7
//里面存在相同的8，如果再插入8，我要找到第1个大于 v 的元素位置，则index=5
-(int)search:(int *)array length:(int)len value:(int)val{
    if (array == NULL || len == 0) return -1;
    int begin = 0;
    int end = len;
    while (begin < end) {
        int mid = (begin + end) >> 1;
        if (val < array[mid]) { //小于
            end = mid;
        } else { //大于等于
            //这里用作大于等于
            //如果数组中存在多个相同的val
            //则能保证插入的位置是最后一个相同的值的后一个索引
            
            begin = mid + 1;
        }
    }
    return begin;
}


@end
