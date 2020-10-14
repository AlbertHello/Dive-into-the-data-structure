//
//  4_MedianofTwoSortedArrays.c
//  链表
//
//  Created by 58 on 2020/10/14.
//  Copyright © 2020 58. All rights reserved.
//

#include "4_MedianofTwoSortedArrays.h"

/*
 4. 寻找两个正序数组的中位数
 
 给定两个大小为 m 和 n 的正序（从小到大）数组 nums1 和 nums2。请你找出并返回这两个正序数组的中位数。

 进阶：你能设计一个时间复杂度为 O(log (m+n)) 的算法解决此问题吗？

  

 示例 1：

 输入：nums1 = [1,3], nums2 = [2]
 输出：2.00000
 解释：合并数组 = [1,2,3] ，中位数 2
 示例 2：

 输入：nums1 = [1,2], nums2 = [3,4]
 输出：2.50000
 解释：合并数组 = [1,2,3,4] ，中位数 (2 + 3) / 2 = 2.5
 示例 3：

 输入：nums1 = [0,0], nums2 = [0,0]
 输出：0.00000
 示例 4：

 输入：nums1 = [], nums2 = [1]
 输出：1.00000
 示例 5：

 输入：nums1 = [2], nums2 = []
 输出：2.00000
  

 提示：

 nums1.length == m
 nums2.length == n
 0 <= m <= 1000
 0 <= n <= 1000
 1 <= m + n <= 2000
 -10^6 <= nums1[i], nums2[i] <= 10^6

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/median-of-two-sorted-arrays
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

double findMedianSortedArrays(int* nums1, int nums1Size, int* nums2, int nums2Size){
    
    int m = nums1Size;
    int n = nums2Size;
    int *nums=(int *)malloc(sizeof(int)*(m+n));
    
    if (m == 0) { // 数组1空
        if (n % 2 == 0) { //如果数组2的元素个数是偶数
            //则取数组中间两个数的平均数
            return (nums2[n / 2 - 1] + nums2[n / 2]) / 2.0;
        } else {
            //奇数个
            return nums2[n / 2];
        }
    }
    if (n == 0) { //数组2空
        if (m % 2 == 0) {//如果数组1的元素个数是偶数
            //则取数组中间两个数的平均数
            return (nums1[m / 2 - 1] + nums1[m / 2]) / 2.0;
        } else {
            //奇数个
            return nums1[m / 2];
        }
    }

    //准备合并俩数组
    int count = 0;
    int i = 0, j = 0;
    while (count != (m + n)) {
        if (i == m) {
//          此处表示数组1已经遍历完了。
            while (j != n) {
//                数组2剩下的元素直接快速装到nums数组中
                nums[count++] = nums2[j++];
            }
            break;
        }
        if (j == n) {
//          此处表示数组2已经遍历完了。
            while (i != m) {
//                数组1剩下的元素直接快速装到nums数组中
                nums[count++] = nums1[i++];
            }
            break;
        }
//        俩数组都还没遍历完时：
        if (nums1[i] < nums2[j]) {
//            nums累计添加nums1中的元素，然后nums1的下标i+1
//            同事nums2的下标j不动。
            nums[count++] = nums1[i++];
        } else {
//            nums累计添加nums2中的元素，然后nums1的下标j+1
//            同事nums1的下j不动。
            nums[count++] = nums2[j++];
        }
    }
//    合并完后的数组，取中位数
    if (count % 2 == 0) {
        return (nums[count / 2 - 1] + nums[count / 2]) / 2.0;
    } else {
        return nums[count / 2];
    }
}

void findMedianSortedArraysTest(){
    int nums1[]={1,2,3};
    int nums2[]={2,4,1};
    
    double nums=findMedianSortedArrays(nums1, 3, nums2, 3);
    printf("aa\n");
}
